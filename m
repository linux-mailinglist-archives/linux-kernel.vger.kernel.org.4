Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A600A6FD36E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 03:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235045AbjEJBIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 21:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234520AbjEJBIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 21:08:16 -0400
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A5E49C1;
        Tue,  9 May 2023 18:08:13 -0700 (PDT)
Received: from [127.0.0.1] ([73.231.166.163])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 34A17fsp1731854
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Tue, 9 May 2023 18:07:42 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 34A17fsp1731854
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2023040901; t=1683680863;
        bh=jhDLoIM7dHdYgcyfud1uL2JJD5Oew+jXsTMBNuzR3AE=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=Ii52SNMvSq477fqw2TQHlbh3Y1fT1pknMIoJLzYPHJ+cF4zd7lUCMNqByda5YevD/
         fn7zDUnlgRaeybBm9s1ZiU0k47Vzq8BkV63vBNkYIzwOdPaJd0neecYr01E+l2XNGo
         /m61uzeVgxVKAZ2u+2xgvcvvejGPQNomluFIMdjrSvqLAVf25e4nvd3mjtTEk5VPp2
         Kurtk7BoegbK5zWPSRlSZAFhKMyZPW9Qsc09fxLPuY6o4EvJWHXMEioglnjGijbyrZ
         FcVIh+WdfZshGBvelb6AVCdDHm9EN+vc/CZyWXSrybKuEHy5hBC4uLpV5AppSiH7Mb
         ULCDi10ZWtC3Q==
Date:   Tue, 09 May 2023 18:07:40 -0700
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
CC:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: make config X86_FEATURE_NAMES visible with EXPERT
User-Agent: K-9 Mail for Android
In-Reply-To: <20230509084007.24373-1-lukas.bulwahn@gmail.com>
References: <20230509084007.24373-1-lukas.bulwahn@gmail.com>
Message-ID: <0A466BA5-BB85-4254-9D1C-7E6B077E7725@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On May 9, 2023 1:40:07 AM PDT, Lukas Bulwahn <lukas=2Ebulwahn@gmail=2Ecom> =
wrote:
>Commit 6a108a14fa35 ("kconfig: rename CONFIG_EMBEDDED to CONFIG_EXPERT")
>introduces CONFIG_EXPERT to carry the previous intent of CONFIG_EMBEDDED
>and just gives that intent a much better name=2E That has been clearly a =
good
>and long overdue renaming, and it is clearly an improvement to the kernel
>build configuration that has shown to help managing the kernel build
>configuration in the last decade=2E
>
>However, rather than bravely and radically just deleting CONFIG_EMBEDDED,
>this commit gives CONFIG_EMBEDDED a new intended semantics, but keeps it
>open for future contributors to implement that intended semantics:
>
>    A new CONFIG_EMBEDDED option is added that automatically selects
>    CONFIG_EXPERT when enabled and can be used in the future to isolate
>    options that should only be considered for embedded systems (RISC
>    architectures, SLOB, etc)=2E
>
>Since then, this CONFIG_EMBEDDED implicitly had two purposes:
>
>  - It can make even more options visible beyond what CONFIG_EXPERT makes
>    visible=2E In other words, it may introduce another level of enabling=
 the
>    visibility of configuration options: always visible, visible with
>    CONFIG_EXPERT and visible with CONFIG_EMBEDDED=2E
>
>  - Set certain default values of some configurations differently,
>    following the assumption that configuring a kernel build for an
>    embedded system generally starts with a different set of default valu=
es
>    compared to kernel builds for all other kind of systems=2E
>
>Considering the first purpose, at the point in time where CONFIG_EMBEDDED
>was renamed to CONFIG_EXPERT, CONFIG_EXPERT already made 130 more options
>become visible throughout all different menus for the kernel configuratio=
n=2E
>Over the last decade, this has gradually increased, so that currently, wi=
th
>CONFIG_EXPERT, roughly 170 more options become visible throughout all
>different menus for the kernel configuration=2E In comparison, currently =
with
>CONFIG_EMBEDDED enabled, just seven more options are visible, one in x86,
>one in arm, and five for the ChipIdea Highspeed Dual Role Controller=2E
>
>As the numbers suggest, these two levels of enabling the visibility of ev=
en
>more configuration options---beyond what CONFIG_EXPERT enables---never
>evolved to a good solution in the last decade=2E In other words, this
>additional level of visibility of configuration option with CONFIG_EMBEDD=
ED
>compared to CONFIG_EXPERT has since its introduction never become really
>valuable=2E It requires quite some investigation to actually understand w=
hat
>is additionally visible and it does not differ significantly in complexit=
y
>compared to just enabling CONFIG_EXPERT=2E This CONFIG_EMBEDDED---or any
>other config to show more detailed options beyond CONFIG_EXPERT---is
>unlikely to be valuable unless somebody puts significant effort in
>identifying how such visibility options can be properly split and creatin=
g
>clear criteria, when some config option is visible with CONFIG_EXPERT and
>when some config option is visible only with some further option enabled
>beyond CONFIG_EXPERT, such as CONFIG_EMBEDDED attempted to do=2E For now,=
 it
>is much more reasonable to simply make those additional seven options tha=
t
>are visible with CONFIG_EMBEDDED visible with CONFIG_EXPERT, and then
>remove CONFIG_EMBEDDED=2E If anyone spends significant effort in structur=
ing
>the visibility of config options, they may re-introduce suitable new
>config options simply as they see fit=2E
>
>Make the config X86_FEATURE_NAMES visible when CONFIG_EXPERT is enabled=
=2E
>
>Signed-off-by: Lukas Bulwahn <lukas=2Ebulwahn@gmail=2Ecom>
>Reviewed-by: Masahiro Yamada <masahiroy@kernel=2Eorg>
>Acked-by: Arnd Bergmann <arnd@arndb=2Ede>
>---
> arch/x86/Kconfig | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>index ce460d6b4e25=2E=2E595f6696281c 100644
>--- a/arch/x86/Kconfig
>+++ b/arch/x86/Kconfig
>@@ -442,7 +442,7 @@ config SMP
> 	  If you don't know what to do here, say N=2E
>=20
> config X86_FEATURE_NAMES
>-	bool "Processor feature human-readable names" if EMBEDDED
>+	bool "Processor feature human-readable names" if EXPERT
> 	default y
> 	help
> 	  This option compiles in a table of x86 feature bits and corresponding

You know it used to be named that, and it was changed exactly because it w=
as a terrible name, right?
