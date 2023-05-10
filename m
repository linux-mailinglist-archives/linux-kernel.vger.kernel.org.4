Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E21AA6FD897
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 09:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236300AbjEJHvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 03:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236223AbjEJHv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 03:51:29 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33041FD7;
        Wed, 10 May 2023 00:51:26 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-965cc5170bdso990342366b.2;
        Wed, 10 May 2023 00:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683705085; x=1686297085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4uA7jc9Vw5Ix6vqrunAFgCIKFiZvoEgrPuoVqTgb1PQ=;
        b=ZYK5miUprEUK2vN6aa5uHlomKH0I/OboeUIVm24i2S0HV/7DTG8k1q8B2VjLfQAz/F
         RJ2lpMQY6kQxwiAy+7AWW7CjwYdFn65Qr0UsDkdIhkaCsgzTbTBXfZr50Z0o4DH+OPpt
         WbGrzw1kAQh94zkA1IbyikXWTjLjATiGr1DBxo0k3eN5qffL6QwuPV6++YJjALm2QaU+
         kEhCVzcQKsJNbRyCTqkUtvrAmtO70laJLmdV/M250X/WDKk7NPBV8K5yCJi5VtKvEDZt
         SV5SPWzsni3g5lokErGKI3moxjuIYneGRMuEuPQzgYAmR8olZkDqzbNClyVNcUd9FDNv
         2gIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683705085; x=1686297085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4uA7jc9Vw5Ix6vqrunAFgCIKFiZvoEgrPuoVqTgb1PQ=;
        b=jFGUSmgDAZ13COhhwoCJYH++2Lsp0hgWblNj5PnNjtdlZJzt0A2HeBvg4KnGN2IDgo
         14PNkd1N7OQR6Vst0bIuwUzJQ8Aic474D7e/Mi0YlvFyTrFOQnLdPVNl+qqYVdH0dwMV
         PJsZLM2jRqtaSIURdItm+nagU2NmYahEe2bm0ruHZu56AbxfAOxNXBhZkUJu+d928/xS
         e1eHnazlFg2bg/vyUfoimbtSR/mky5yra9VulZW16Q7CNzNQOoIc64uIW51Ez4YU87BN
         QBpDo1da06fy7WglRdg9eWsMPa6tpjR09G5+XEvhOFutOE/t5zajYdorQgrnkQh8CI5a
         UocQ==
X-Gm-Message-State: AC+VfDx8Vamy7EoixI1R25qbxmeMH77QNnFYJGHusys0i0EDi7FLELQt
        cb90PrgiTPBX4IJOYYlB/seSoKTGtd/HPuKosUw=
X-Google-Smtp-Source: ACHHUZ5ls2CuE62J7QEcALQ3YsLNq4iisKEzR2EZL9facu9nh742G81gJGIhm8zFi76MuXDwS94dSmou2hXmRaj3Fdw=
X-Received: by 2002:a17:906:dac1:b0:961:8fcd:53cc with SMTP id
 xi1-20020a170906dac100b009618fcd53ccmr13241080ejb.42.1683705085149; Wed, 10
 May 2023 00:51:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230509084007.24373-1-lukas.bulwahn@gmail.com> <0A466BA5-BB85-4254-9D1C-7E6B077E7725@zytor.com>
In-Reply-To: <0A466BA5-BB85-4254-9D1C-7E6B077E7725@zytor.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Wed, 10 May 2023 09:51:14 +0200
Message-ID: <CAKXUXMwo-oH=kYYtNjgWbQK-Yrb-NkxB+LjraOGQoKbA22Zwwg@mail.gmail.com>
Subject: Re: [PATCH] x86: make config X86_FEATURE_NAMES visible with EXPERT
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 3:07=E2=80=AFAM H. Peter Anvin <hpa@zytor.com> wrot=
e:
>
> On May 9, 2023 1:40:07 AM PDT, Lukas Bulwahn <lukas.bulwahn@gmail.com> wr=
ote:
> >Commit 6a108a14fa35 ("kconfig: rename CONFIG_EMBEDDED to CONFIG_EXPERT")
> >introduces CONFIG_EXPERT to carry the previous intent of CONFIG_EMBEDDED
> >and just gives that intent a much better name. That has been clearly a g=
ood
> >and long overdue renaming, and it is clearly an improvement to the kerne=
l
> >build configuration that has shown to help managing the kernel build
> >configuration in the last decade.
> >
> >However, rather than bravely and radically just deleting CONFIG_EMBEDDED=
,
> >this commit gives CONFIG_EMBEDDED a new intended semantics, but keeps it
> >open for future contributors to implement that intended semantics:
> >
> >    A new CONFIG_EMBEDDED option is added that automatically selects
> >    CONFIG_EXPERT when enabled and can be used in the future to isolate
> >    options that should only be considered for embedded systems (RISC
> >    architectures, SLOB, etc).
> >
> >Since then, this CONFIG_EMBEDDED implicitly had two purposes:
> >
> >  - It can make even more options visible beyond what CONFIG_EXPERT make=
s
> >    visible. In other words, it may introduce another level of enabling =
the
> >    visibility of configuration options: always visible, visible with
> >    CONFIG_EXPERT and visible with CONFIG_EMBEDDED.
> >
> >  - Set certain default values of some configurations differently,
> >    following the assumption that configuring a kernel build for an
> >    embedded system generally starts with a different set of default val=
ues
> >    compared to kernel builds for all other kind of systems.
> >
> >Considering the first purpose, at the point in time where CONFIG_EMBEDDE=
D
> >was renamed to CONFIG_EXPERT, CONFIG_EXPERT already made 130 more option=
s
> >become visible throughout all different menus for the kernel configurati=
on.
> >Over the last decade, this has gradually increased, so that currently, w=
ith
> >CONFIG_EXPERT, roughly 170 more options become visible throughout all
> >different menus for the kernel configuration. In comparison, currently w=
ith
> >CONFIG_EMBEDDED enabled, just seven more options are visible, one in x86=
,
> >one in arm, and five for the ChipIdea Highspeed Dual Role Controller.
> >
> >As the numbers suggest, these two levels of enabling the visibility of e=
ven
> >more configuration options---beyond what CONFIG_EXPERT enables---never
> >evolved to a good solution in the last decade. In other words, this
> >additional level of visibility of configuration option with CONFIG_EMBED=
DED
> >compared to CONFIG_EXPERT has since its introduction never become really
> >valuable. It requires quite some investigation to actually understand wh=
at
> >is additionally visible and it does not differ significantly in complexi=
ty
> >compared to just enabling CONFIG_EXPERT. This CONFIG_EMBEDDED---or any
> >other config to show more detailed options beyond CONFIG_EXPERT---is
> >unlikely to be valuable unless somebody puts significant effort in
> >identifying how such visibility options can be properly split and creati=
ng
> >clear criteria, when some config option is visible with CONFIG_EXPERT an=
d
> >when some config option is visible only with some further option enabled
> >beyond CONFIG_EXPERT, such as CONFIG_EMBEDDED attempted to do. For now, =
it
> >is much more reasonable to simply make those additional seven options th=
at
> >are visible with CONFIG_EMBEDDED visible with CONFIG_EXPERT, and then
> >remove CONFIG_EMBEDDED. If anyone spends significant effort in structuri=
ng
> >the visibility of config options, they may re-introduce suitable new
> >config options simply as they see fit.
> >
> >Make the config X86_FEATURE_NAMES visible when CONFIG_EXPERT is enabled.
> >
> >Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> >Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>
> >Acked-by: Arnd Bergmann <arnd@arndb.de>
> >---
> > arch/x86/Kconfig | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> >index ce460d6b4e25..595f6696281c 100644
> >--- a/arch/x86/Kconfig
> >+++ b/arch/x86/Kconfig
> >@@ -442,7 +442,7 @@ config SMP
> >         If you don't know what to do here, say N.
> >
> > config X86_FEATURE_NAMES
> >-      bool "Processor feature human-readable names" if EMBEDDED
> >+      bool "Processor feature human-readable names" if EXPERT
> >       default y
> >       help
> >         This option compiles in a table of x86 feature bits and corresp=
onding
>
> You know it used to be named that, and it was changed exactly because it =
was a terrible name, right?

Yes, I do (commit 6a108a14fa35 ("kconfig: rename CONFIG_EMBEDDED to
CONFIG_EXPERT")); and keeping CONFIG_EMBEDDED after that renaming was
not the best idea in retrospect.

Lukas
