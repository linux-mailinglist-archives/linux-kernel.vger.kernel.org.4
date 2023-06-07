Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F950726694
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 18:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbjFGQ5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 12:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbjFGQ5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 12:57:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0CC1FC2
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 09:57:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5B9561459
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 16:57:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83317C433A0;
        Wed,  7 Jun 2023 16:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686157063;
        bh=lmG/iO4yCH/y6BZzMgEzghnezPPBrnzSLbgdr+z6b0Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tNgxGoQ0gPVV6m9sXjcItYlUSPzWY69mHwmYp2o9RLQ/1mqxCliU+wlW2xMneoWzC
         eUVJ+njWX0VKJLEdtS+raXSkIh/Lyz/cqrGHv4a0bJMrPI5LzBvWG3F6F/3DZADS8u
         MLkx72637FQN/GCcz30xpzaz1TLR0Aq8hXzoYjSCw/mCRa7Y4vg/oRkXQ0Rql9F6L5
         NrhQBSSd9ktD2Ijy2WawHszVdVHtwjqs65PKO46Aw0autkh7HPSPutb4ZljhyfDjGQ
         bIloblYGEHqhDpUz98zVWqvlsl9xnVOBx+m+QYiDbBz9TY8R65a/6bIur/FL7xdlzm
         kpMbNUvYAniQg==
Date:   Wed, 7 Jun 2023 09:57:41 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     netdev@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Boris Pismenny <borisp@nvidia.com>,
        John Fastabend <john.fastabend@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 05/14] tls/sw: Use splice_eof() to flush
Message-ID: <20230607095741.223689c1@kernel.org>
In-Reply-To: <20230607140559.2263470-6-dhowells@redhat.com>
References: <20230607140559.2263470-1-dhowells@redhat.com>
        <20230607140559.2263470-6-dhowells@redhat.com>
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

On Wed,  7 Jun 2023 15:05:50 +0100 David Howells wrote:
> Allow splice to end a TLS record after prematurely ending a splice/sendfile
> due to getting an EOF condition (->splice_read() returned 0) after splice
> had called TLS with a sendmsg() with MSG_MORE set when the user didn't set
> MSG_MORE.
> 
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Link: https://lore.kernel.org/r/CAHk-=wh=V579PDYvkpnTobCLGczbgxpMgGmmhqiTyE34Cpi5Gg@mail.gmail.com/
> Signed-off-by: David Howells <dhowells@redhat.com>

Reviewed-by: Jakub Kicinski <kuba@kernel.org>
