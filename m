Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A752B73268F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 07:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240418AbjFPFXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 01:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbjFPFXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 01:23:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30322720
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 22:23:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5582D61BBD
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 05:23:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED0BBC433C0;
        Fri, 16 Jun 2023 05:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686893009;
        bh=cfvedA+APUAxhrJ767ArAlv5k/lXbdNasLfuw1iA/v8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fzEg+oqsW/+IqclK8T1ogmt1cZoCdtIoX9ldgelPE3zd6dEW2Y+GPkuMgiQomArBo
         2dX4m/8Jx+P8Gi0ra+jlolnn9JoWGQeHEqow7siQ2k+3o/2M34rrVFccwX/sg8FM7l
         zZq9C9dq8XvwKvPKaq4t8fhQhF6pJdyOu1fxYDiUNpW/MIEXDVuZzgPLX5/VHf3svC
         Mk+Dq7rU8Q2hCUKPBbkWtdksTbOSQKc+LcjmY8n/8Od3ruVv9VckRtykbyZWnotFQb
         GHM41694xUPdXlgxgY3DKncAfyCAWg8/CwJOE65miOfnEebCPTMJzy2s4y32jA5bD6
         GmJ1He+NcUNjw==
Date:   Thu, 15 Jun 2023 22:23:27 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     David Howells <dhowells@redhat.com>, netdev@vger.kernel.org,
        syzbot+d8486855ef44506fd675@syzkaller.appspotmail.com,
        David Ahern <dsahern@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] ip, ip6: Fix splice to raw and ping sockets
Message-ID: <20230615222327.15e85c55@kernel.org>
In-Reply-To: <1410156.1686729856@warthog.procyon.org.uk>
References: <1410156.1686729856@warthog.procyon.org.uk>
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

On Wed, 14 Jun 2023 09:04:16 +0100 David Howells wrote:
> Splicing to SOCK_RAW sockets may set MSG_SPLICE_PAGES, but in such a case,
> __ip_append_data() will call skb_splice_from_iter() to access the 'from'
> data, assuming it to point to a msghdr struct with an iter, instead of
> using the provided getfrag function to access it.
> 
> In the case of raw_sendmsg(), however, this is not the case and 'from' will
> point to a raw_frag_vec struct and raw_getfrag() will be the frag-getting
> function.  A similar issue may occur with rawv6_sendmsg().
> 
> Fix this by ignoring MSG_SPLICE_PAGES if getfrag != ip_generic_getfrag as
> ip_generic_getfrag() expects "from" to be a msghdr*, but the other getfrags
> don't.  Note that this will prevent MSG_SPLICE_PAGES from being effective
> for udplite.
> 
> This likely affects ping sockets too.  udplite looks like it should be okay
> as it expects "from" to be a msghdr.

Willem, looks good?
