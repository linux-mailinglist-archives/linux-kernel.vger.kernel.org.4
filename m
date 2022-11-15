Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD5DB62A3F7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 22:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiKOVVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 16:21:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238716AbiKOVVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 16:21:38 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D387205D8;
        Tue, 15 Nov 2022 13:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nyKgzABuL/ly1ySWJPooscj+ldW3eJWZmk6Lzgs1mvE=; b=hqycI/WOAi9Lm6ARDyTBomx+/p
        tDXAsPRy7wE+jawPq2mMiT2xKb3H0ZgdwivCPfIQNZQfBzrgrSBTntsUsKgMrKIqlQ2RUAre20cfp
        NrvPU+kP0geGkqNHC2ntPKAxf2dbEtNoKUCEPwFO20nb23QyOFMUnWIxZvym8pfbT1tUDzXJebpW/
        wNEsZLv8HwqIva87ZQwSDn5PhEA/eTO3IYAlEQqkozyJsOS7sRzJZxrc0TOM33rw7frJ+LsHmDjzy
        uAWrpUBo5zBv/uXwtcIg47rsmY+btLvrLGw1ZkRQS1tg+++sDjKfsWH0qV2qOb/MekhdbcOU1hAxH
        a5fA5XDA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ov3Mu-00F2AJ-9l; Tue, 15 Nov 2022 21:21:20 +0000
Date:   Tue, 15 Nov 2022 13:21:20 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Nick Alcock <nick.alcock@oracle.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v9 2/8] kbuild: add modules_thick.builtin
Message-ID: <Y3QC0OIbZgSmvAxT@bombadil.infradead.org>
References: <20221109134132.9052-1-nick.alcock@oracle.com>
 <20221109134132.9052-3-nick.alcock@oracle.com>
 <Y2x22mKtaZvC7ZSk@bombadil.infradead.org>
 <87h6z5wqlk.fsf@esperi.org.uk>
 <Y25mXAGty35I5lQx@bombadil.infradead.org>
 <87iljhv321.fsf@esperi.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87iljhv321.fsf@esperi.org.uk>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 05:49:58PM +0000, Nick Alcock wrote:
> On 11 Nov 2022, Luis Chamberlain outgrape:
> 
> > On Fri, Nov 11, 2022 at 01:47:03PM +0000, Nick Alcock wrote:
> >> +arch/x86/crypto/libblake2s-x86_64.o: arch/x86/crypto/blake2s-core.o arch/x86/crypto/blake2s-glue.o
> >> 
> >> But...
> >> 
> >> obj-$(CONFIG_CRYPTO_BLAKE2S_X86) += libblake2s-x86_64.o
> >> libblake2s-x86_64-y := blake2s-core.o blake2s-glue.o
> >> 
> >> config CRYPTO_BLAKE2S_X86
> >>         bool "Hash functions: BLAKE2s (SSSE3/AVX-512)"
> >> 
> >> This cannot be built as a module.
> >
> > mcgrof@fulton ~/linux (git::modules-next)$ git grep MODULE_LICENSE arch/x86/crypto/blake2s-*
> > arch/x86/crypto/blake2s-glue.c:MODULE_LICENSE("GPL v2");
> >
> > Try removing that.
> 
> OK, that works!
> 
> So if we're using the presence of MODULE_LICENSE to indicate that
> something is potentially modular, I guess this means I need to do a
> sweep through the kernel and find everywhere that cites a MODULE_LICENSE
> and cannot be built as a module before this will say things are modules
> that really are.

Yes, make allyesconfig builds + a verifier for tristate would be nice.
scripts/kconfig/streamline_config.pl has an iterator over kconfig files
and also objects which you might find useful.

At build time such a thing could nag about issues like the above.

  Luis
