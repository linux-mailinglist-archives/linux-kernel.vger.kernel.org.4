Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCFB7190B5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 04:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbjFACvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 22:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjFACvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 22:51:13 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E86497
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 19:51:12 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-25673e8c464so57592a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 19:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685587872; x=1688179872;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QJvI42hzqEfLq+DDW1OxT0grFxR3mOlryj6N6dIoRA8=;
        b=BSgJOLNKhZW08Q5W2hVYZFOOYILOZsab5M9FRjNq9kNADqpxi+0yEasbwoPQ6C0RYD
         AEkZuY1Lhs0sZ+QMQ0sT3uB6hHd+//YLWvGQIDj1eyc19RJZOhVosve0y8PQfp/dXpnq
         FLwmUqCk0ZZMTo35hD81j8HljdTyAil05pPVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685587872; x=1688179872;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QJvI42hzqEfLq+DDW1OxT0grFxR3mOlryj6N6dIoRA8=;
        b=UkTrh0xUZoM5xp3iVGwuqzB1dcOg/gFkwDs3f/x4Aa/dYc8REpiHv9lYm3WgMKe7NL
         Q5zLFL4qhAMqAdYe/jD8AmUbFTQVV680jun8ujkBDH73qAssc5N+Bp9XdshxvdyA+Ent
         /1SRzHgP9MG9ynfMtuZ69AQIHpiGVGk9slwmicKxaoWX6L8BxR2nuyQUXcnJoEETspX8
         0Mbsfm2B1GjqX54tDYi4I8buegiuWfMKSNSRgFZuKlVkKft9gm5spT/DWA/vDQacFc07
         zhAMWP85pfvZ8AaWAT5N5jCKsLcAT5DbOrxhbeIhmGb9HtIXICY9fTjMvOGBT39r62+H
         KK2g==
X-Gm-Message-State: AC+VfDw7jFu2MBihLRa3C8UE1Cs11aghCApKHalI9UCuBe3JOi5lpTmA
        y625AAN3NccoTJJrNAdHz7mM2w==
X-Google-Smtp-Source: ACHHUZ7PFFFjKduMvOqjuZYsP8C5LHYpM5N6RALb9qSn8RKP39imX2lcG+hpivB2yErAslXEfNFSPw==
X-Received: by 2002:a17:90a:db8a:b0:24e:688:30f8 with SMTP id h10-20020a17090adb8a00b0024e068830f8mr5009755pjv.49.1685587871737;
        Wed, 31 May 2023 19:51:11 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id oa14-20020a17090b1bce00b002500df72713sm257413pjb.7.2023.05.31.19.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 19:51:11 -0700 (PDT)
Date:   Wed, 31 May 2023 19:51:10 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Joan Bruguera =?iso-8859-1?Q?Mic=F3?= <joanbrugueram@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Alyssa Ross <hi@alyssa.is>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] riscv/purgatory: Do not use fortified string functions
Message-ID: <202305311950.EFFD6521@keescook>
References: <20230531003404.never.167-kees@kernel.org>
 <20230531-abruptly-settling-f9852f408dcd@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230531-abruptly-settling-f9852f408dcd@spud>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 11:37:20PM +0100, Conor Dooley wrote:
> Hey Kees,
> 
> On Tue, May 30, 2023 at 05:34:04PM -0700, Kees Cook wrote:
> > With the addition of -fstrict-flex-arrays=3, struct sha256_state's
> > trailing array is no longer ignored by CONFIG_FORTIFY_SOURCE:
> > 
> > struct sha256_state {
> >         u32 state[SHA256_DIGEST_SIZE / 4];
> >         u64 count;
> >         u8 buf[SHA256_BLOCK_SIZE];
> > };
> > 
> > This means that the memcpy() calls with "buf" as a destination in
> > sha256.c's code will attempt to perform run-time bounds checking, which
> > could lead to calling missing functions, specifically a potential
> > WARN_ONCE, which isn't callable from purgatory.
> > 
> > Reported-by: Thorsten Leemhuis <linux@leemhuis.info>
> > Closes: https://lore.kernel.org/lkml/175578ec-9dec-7a9c-8d3a-43f24ff86b92@leemhuis.info/
> > Bisected-by: "Joan Bruguera Micó" <joanbrugueram@gmail.com>
> > Fixes: df8fc4e934c1 ("kbuild: Enable -fstrict-flex-arrays=3")
> > Cc: Paul Walmsley <paul.walmsley@sifive.com>
> > Cc: Palmer Dabbelt <palmer@dabbelt.com>
> > Cc: Albert Ou <aou@eecs.berkeley.edu>
> > Cc: Masahiro Yamada <masahiroy@kernel.org>
> > Cc: Conor Dooley <conor.dooley@microchip.com>
> > Cc: Nick Desaulniers <ndesaulniers@google.com>
> > Cc: Alyssa Ross <hi@alyssa.is>
> > Cc: Heiko Stuebner <heiko.stuebner@vrull.eu>
> > Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> > Cc: linux-riscv@lists.infradead.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Perhaps this is indicative of other issues in RISC-V land, but
> allmodconfig complains about this patch:
> 
> ../lib/string.c:17: warning: "__NO_FORTIFY" redefined
> ../lib/string.c:17:9: warning: preprocessor token __NO_FORTIFY redefined

Argh, thanks. My compile test clearly failed. I'll fix this up.

-Kees

> 
> > ---
> >  arch/riscv/purgatory/Makefile | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/riscv/purgatory/Makefile b/arch/riscv/purgatory/Makefile
> > index 5730797a6b40..11f4c275f141 100644
> > --- a/arch/riscv/purgatory/Makefile
> > +++ b/arch/riscv/purgatory/Makefile
> > @@ -31,9 +31,9 @@ $(obj)/strncmp.o: $(srctree)/arch/riscv/lib/strncmp.S FORCE
> >  $(obj)/sha256.o: $(srctree)/lib/crypto/sha256.c FORCE
> >  	$(call if_changed_rule,cc_o_c)
> >  
> > -CFLAGS_sha256.o := -D__DISABLE_EXPORTS
> > -CFLAGS_string.o := -D__DISABLE_EXPORTS
> > -CFLAGS_ctype.o := -D__DISABLE_EXPORTS
> > +CFLAGS_sha256.o := -D__DISABLE_EXPORTS -D__NO_FORTIFY
> > +CFLAGS_string.o := -D__DISABLE_EXPORTS -D__NO_FORTIFY
> > +CFLAGS_ctype.o := -D__DISABLE_EXPORTS -D__NO_FORTIFY
> >  
> >  # When linking purgatory.ro with -r unresolved symbols are not checked,
> >  # also link a purgatory.chk binary without -r to check for unresolved symbols.
> > -- 
> > 2.34.1
> > 
> > 
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv



-- 
Kees Cook
