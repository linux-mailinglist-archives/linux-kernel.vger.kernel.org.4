Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A00A7740037
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 17:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbjF0P7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 11:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbjF0P7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 11:59:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72BB72D68;
        Tue, 27 Jun 2023 08:59:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 016EA611D3;
        Tue, 27 Jun 2023 15:59:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04E10C433C9;
        Tue, 27 Jun 2023 15:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687881569;
        bh=AA3u7kz1pu0vMNPeSL/vGc5ARaKVq+llu1ZjNTFOZYY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AEjG+n/bSqn/UH82G8HIczhWixak5ScxThjfmMOSom1fAGV4FP1vd9ebK46Wuz2jr
         6ywXrGKYTf08EabwSo2e/C10RS6x2Im/4ZwHxfXtkFWKT0tBsFToh1WaFTerJU+c1V
         Jo08l+xxO6Gg6MEHS3rgX0YABVC3s0laavLbYzjXidie28j32/MqcCdEIFmwzUdgk8
         wDplROUqNRcYqxhIWuUa/pzhrTtO9pIYu1XAAcW/WBweTo30W2aL2Ztx7kdgFzTCGF
         8YFpNCSQM8GzHBgJvTTXZATWEaz6VHZDvPXCT8/lC06ZFeNhmHW5CX4clk6CjLBysA
         Y4h11ieYXXwVg==
Date:   Tue, 27 Jun 2023 08:59:28 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Ilya Dryomov <idryomov@gmail.com>, netdev@vger.kernel.org,
        Xiubo Li <xiubli@redhat.com>, Jeff Layton <jlayton@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3] libceph: Partially revert changes to
 support MSG_SPLICE_PAGES
Message-ID: <20230627085928.6569353e@kernel.org>
In-Reply-To: <3199652.1687873788@warthog.procyon.org.uk>
References: <3199652.1687873788@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jun 2023 14:49:48 +0100 David Howells wrote:
> Fix the mishandling of MSG_DONTWAIT and also reinstates the per-page
> checking of the source pages (which might have come from a DIO write by
> userspace) by partially reverting the changes to support MSG_SPLICE_PAGES
> and doing things a little differently.  In messenger_v1:
> 
>  (1) The ceph_tcp_sendpage() is resurrected and the callers reverted to use
>      that.
> 
>  (2) The callers now pass MSG_MORE unconditionally.  Previously, they were
>      passing in MSG_MORE|MSG_SENDPAGE_NOTLAST and then degrading that to
>      just MSG_MORE on the last call to ->sendpage().
> 
>  (3) Make ceph_tcp_sendpage() a wrapper around sendmsg() rather than
>      sendpage(), setting MSG_SPLICE_PAGES if sendpage_ok() returns true on
>      the page.
> 
> In messenger_v2:
> 
>  (4) Bring back do_try_sendpage() and make the callers use that.
> 
>  (5) Make do_try_sendpage() use sendmsg() for both cases and set
>      MSG_SPLICE_PAGES if sendpage_ok() is set.
> 
> Fixes: 40a8c17aa770 ("ceph: Use sendmsg(MSG_SPLICE_PAGES) rather than sendpage")
> Fixes: fa094ccae1e7 ("ceph: Use sendmsg(MSG_SPLICE_PAGES) rather than sendpage()")
> Reported-by: Ilya Dryomov <idryomov@gmail.com>

Ilya, would you be okay if we sent the 6.5 PR without this and then
we can either follow up with a PR in a few days or you can take this
via your tree?

Or you could review it now, that'd also work :)

In hindsight we should have pushed harder to make the FS changes as
small as possible for sendpage removal, so that they can go in via 
the appropriate tree with an appropriate level of scrutiny for 6.6,
lesson learned :(
