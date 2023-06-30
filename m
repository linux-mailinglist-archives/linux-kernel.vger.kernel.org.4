Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE58B743F7D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 18:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232791AbjF3QK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 12:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbjF3QKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 12:10:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E5B10B
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 09:10:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 658F961795
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 16:10:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A10FFC433C8;
        Fri, 30 Jun 2023 16:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688141446;
        bh=65l3uxIkPZ2teqmqxsQP31N9JJV0zpume1JU++/LnAI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dq19zYXMqF5Odo1p5GFM9j0nL2LZbW9qCerBaCPD8Oh6xhb8sATyqGZUXXM9H9unc
         eRT4kJN5byP86KaZkhnglG8iXD2T0YGHFmLTrQrj3hvDckwk2jEc9VSNh2t9S/gxtJ
         0Dx4t8ni/nfwppvYEAAUncwVBPXcvfHU7DJrXLg3fET5wHbfrq5/jlIApbGWZ57tzU
         idF/ITTbqiOgio39UFgA608R07VkW9agfG8sIhl0EcPgKzi45w4hBlJ3dOUUDCHDjR
         kxdILhNhzz3xw0Nm/HMh5YNMZKfqYFnsjYN/yyZRKtIIckltFJimgsA/AudefjbpOn
         X66t6KgUID+dQ==
Date:   Fri, 30 Jun 2023 09:10:43 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     David Howells <dhowells@redhat.com>,
        Aurelien Aptel <aaptel@nvidia.com>, netdev@vger.kernel.org,
        Alexander Duyck <alexander.duyck@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
        Willem de Bruijn <willemb@google.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-nvme@lists.infradead.org, llvm@lists.linux.dev
Subject: Re: [PATCH net-next v3 10/18] nvme/host: Use
 sendmsg(MSG_SPLICE_PAGES) rather then sendpage
Message-ID: <20230630161043.GA2902645@dev-arch.thelio-3990X>
References: <253mt0il43o.fsf@mtr-vdi-124.i-did-not-set--mail-host-address--so-tickle-me>
 <20230620145338.1300897-1-dhowells@redhat.com>
 <20230620145338.1300897-11-dhowells@redhat.com>
 <58466.1688074499@warthog.procyon.org.uk>
 <20230629164318.44f45caf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230629164318.44f45caf@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 04:43:18PM -0700, Jakub Kicinski wrote:
> On Thu, 29 Jun 2023 22:34:59 +0100 David Howells wrote:
> >                 if (!sendpage_ok(page))
> > -                       msg.msg_flags &= ~MSG_SPLICE_PAGES,
> > +                       msg.msg_flags &= ~MSG_SPLICE_PAGES;
> 
> 😵️
> 
> Let me CC llvm@ in case someone's there is willing to make 
> the compiler warn about this.
> 

Turns out clang already has a warning for this, -Wcomma:

  drivers/nvme/host/tcp.c:1017:38: error: possible misuse of comma operator here [-Werror,-Wcomma]
   1017 |                         msg.msg_flags &= ~MSG_SPLICE_PAGES,
        |                                                           ^
  drivers/nvme/host/tcp.c:1017:4: note: cast expression to void to silence warning
   1017 |                         msg.msg_flags &= ~MSG_SPLICE_PAGES,
        |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        |                         (void)(                           )
  1 error generated.

Let me do some wider build testing to see if it is viable to turn this
on for the whole kernel because it seems worth it, at least in this
case. There are a lot of cases where a warning won't be emitted (see the
original upstream review for a list: https://reviews.llvm.org/D3976) but
something is better than nothing, right? :)

Cheers,
Nathan
