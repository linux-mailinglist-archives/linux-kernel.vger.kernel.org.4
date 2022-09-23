Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7DD5E82A1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 21:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbiIWTpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 15:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbiIWTpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 15:45:01 -0400
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com [210.131.2.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61EC583F0B
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 12:44:58 -0700 (PDT)
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 28NJigKM029622
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 04:44:42 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 28NJigKM029622
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1663962283;
        bh=NbCGtSdbG3oqkI66EnHd+jvnGku05D5DfnQbs9zZVLQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=x3AlN+6O4X9CLT/N/7ZyrW06jeAzLkdBWhD7QRycVtcysFmSD0ITESQgBNVO6rD0h
         JYui6PIm3GqoAhIOaxxrcYdHfjc6SQQuYjx2GEq5T9r/ivNcnCilFYSxHPliFgpxSw
         w7z+Cd8FNL2AJFGyzDC27uIZ3H3JN1Bm+GPPu5hJbBVvt85X2MPxEzyOv320oIbpQL
         7txS0Sof7x64RslwTy8YpPGGVIRMnxXtIdlUIuOJG2/9nv4uP0k62QY/7mA+115kGd
         knpH0CD/9NlMOExcZvpW8+rzCHItIuRv5nt24y/pqDHgxFZv7JmsBPHgAGBx9yx9IW
         r0uX9yaeC9cZw==
X-Nifty-SrcIP: [209.85.167.179]
Received: by mail-oi1-f179.google.com with SMTP id g130so1027168oia.13
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 12:44:42 -0700 (PDT)
X-Gm-Message-State: ACrzQf161tHNMI9zuMhrSj2iGM7fbv6roLCIQ+wTb8wo6Ajq/q3OIVAq
        Ayp/RaUnhO8LLYoWQwBEPP5CSk295Q0u0La8vkk=
X-Google-Smtp-Source: AMsMyM4vcr/Sug/Gk/8SieMnzcAA6gpJvAs6fyFex07yhjwvQa+N4xU9WsDe4RAkBzwftz4MHWUhlgA3q0Zd//wh+AY=
X-Received: by 2002:a05:6808:1b85:b0:34d:8ce1:d5b0 with SMTP id
 cj5-20020a0568081b8500b0034d8ce1d5b0mr9560936oib.194.1663962281705; Fri, 23
 Sep 2022 12:44:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNAT_cMLGLBz7ugaLpJD3QmZmY8FK56x9nihvWeYhJpi2ag@mail.gmail.com>
 <20220919170828.3718437-1-ndesaulniers@google.com>
In-Reply-To: <20220919170828.3718437-1-ndesaulniers@google.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 24 Sep 2022 04:44:05 +0900
X-Gmail-Original-Message-ID: <CAK7LNARk74U8AWzOVHP1pPVy2PNSMsNiyPL8bmFcYs6DkheorA@mail.gmail.com>
Message-ID: <CAK7LNARk74U8AWzOVHP1pPVy2PNSMsNiyPL8bmFcYs6DkheorA@mail.gmail.com>
Subject: Re: [PATCH v4] Makefile.compiler: replace cc-ifversion with
 compiler-specific macros
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Bill Wendling <morbo@google.com>,
        Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 2:08 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> cc-ifversion is GCC specific. Replace it with compiler specific
> variants. Update the users of cc-ifversion to use these new macros.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/350
> Link: https://lore.kernel.org/llvm/CAGG=3QWSAUakO42kubrCap8fp-gm1ERJJAYXTnP1iHk_wrH=BQ@mail.gmail.com/
> Suggested-by: Bill Wendling <morbo@google.com>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
> Changes v3 -> v4:
> * Split into its own patch again from series, as per Masahiro.
> * Rebase on top of b0839b281c427e844143dba3893e25c83cdd6c17 and update
>   clang -Wformat logic in scripts/Makefile.extrawarn, as per Masahiro.


Applied to linux-kbuild.
Thanks.



-- 
Best Regards
Masahiro Yamada
