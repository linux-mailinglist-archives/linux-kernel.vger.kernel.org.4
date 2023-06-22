Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F704739584
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 04:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjFVC1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 22:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjFVC1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 22:27:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4AC91A1;
        Wed, 21 Jun 2023 19:27:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 025DD61724;
        Thu, 22 Jun 2023 02:27:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57D76C433C8;
        Thu, 22 Jun 2023 02:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687400851;
        bh=wi1QN+X0A4k6VZUiD9sGaUcw+wP/IbFgFpzja7AlxNU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ND4F0QtuKNSyIvNg6K6lv0XSg/WCyfGtV2T/ZusEIhnFS7agDccx9NqPPxUJqcxRb
         ulwiii0aoknsHIvPIP7DDx9c/6eNWws2KPXyfX1MOycyl9JKRWfsTQqpmmlR2g4vnu
         isdy2mFjCh7fcaGIRPh7sD2/PYCUm+rWkg8M+MMfwqu656yLBoTGfg9DT/9/3oK4b2
         pU4iY11Zf+kskXlxvkcm5fNXh+Yg0DSkz1Kee1R4sQDlqGsCE/AxxQvzn040US7tch
         vZ3M1/CVIB4ih9c7/q0TlADzsKr1ysGZUm5BryUTsxvkh7Ibnj8/3MDsXSgESmKlxo
         MciDOn6GsACIQ==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-1a9acdddb20so126460fac.0;
        Wed, 21 Jun 2023 19:27:31 -0700 (PDT)
X-Gm-Message-State: AC+VfDyK2R/cRK6TYYKmK4G6Bif0yOCF0t7MgLKbJ41gAnziGY1yUZNM
        dAdRRYtIugPVb3o+4MiScvvodLHLxYgVhuxxSQQ=
X-Google-Smtp-Source: ACHHUZ7uqK58I8UdvuU6orqGHCMZcei2ru+VkR2hVlAJvnCRg6KnKNrH/r4CJjq4yvBJH43PbKAsLdE23OlWC8fAF4I=
X-Received: by 2002:a05:6871:711:b0:1a6:98ca:4377 with SMTP id
 f17-20020a056871071100b001a698ca4377mr8224287oap.24.1687400850592; Wed, 21
 Jun 2023 19:27:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230608142428.256985-1-masahiroy@kernel.org> <20230608142428.256985-4-masahiroy@kernel.org>
 <bb5048e7-5e8f-4391-a9a0-ff15b5384186@roeck-us.net>
In-Reply-To: <bb5048e7-5e8f-4391-a9a0-ff15b5384186@roeck-us.net>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 22 Jun 2023 11:26:53 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQpgx5uYnQTb0Pu=uR=YPWkJX7P75p55Qva5okhRpaN_g@mail.gmail.com>
Message-ID: <CAK7LNAQpgx5uYnQTb0Pu=uR=YPWkJX7P75p55Qva5okhRpaN_g@mail.gmail.com>
Subject: Re: [PATCH v7 03/11] kbuild: generate KSYMTAB entries by modpost
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 1:15=E2=80=AFAM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> On Thu, Jun 08, 2023 at 11:24:20PM +0900, Masahiro Yamada wrote:
> > Commit 7b4537199a4a ("kbuild: link symbol CRCs at final link, removing
> > CONFIG_MODULE_REL_CRCS") made modpost output CRCs in the same way
> > whether the EXPORT_SYMBOL() is placed in *.c or *.S.
> >
> ...
>
> > We can do this better now; modpost can selectively emit KSYMTAB entries
> > that are really used by modules.
> >
>
> This patch results in
>
> Building alpha:defconfig ... failed
> --------------
> Error log:
> <stdin>:1519:2: warning: #warning syscall clone3 not implemented [-Wcpp]
> WARNING: modpost: "saved_config" [vmlinux] is COMMON symbol
> ERROR: modpost: vmlinux: page_is_ram: EXPORT_SYMBOL used for init symbol.=
 Remove __init or EXPORT_SYMBOL.
>
> I don't know if other architectures are affected - linux-next is so broke=
n
> that it is difficult to find root causes for all the breakages.


Thanks for the comprehensive build tests.

If you compare the build log, you will see
what has happened.




In Linus' tree (without this patch),

  MODPOST Module.symvers
WARNING: modpost: "saved_config" [vmlinux] is COMMON symbol
WARNING: modpost: vmlinux.o: EXPORT_SYMBOL used for init/exit symbol:
page_is_ram (section: .init.text)



In linux-next (with this patch),


  MODPOST Module.symvers
WARNING: modpost: "saved_config" [vmlinux] is COMMON symbol
ERROR: modpost: vmlinux: page_is_ram: EXPORT_SYMBOL used for init
symbol. Remove __init or EXPORT_SYMBOL.





The change is obvious - I just turned the combination
of __init and EXPORT_SYMBOL into an error.

But, it seemed too early to do this.

I will hold it back as a warning for now, as follows:



diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index bdf4244da993..412115a8202a 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1239,10 +1239,10 @@ static void check_export_symbol(struct module
*mod, struct elf_info *elf,
        s->is_func =3D (ELF_ST_TYPE(sym->st_info) =3D=3D STT_FUNC);

        if (match(secname, PATTERNS(INIT_SECTIONS)))
-               error("%s: %s: EXPORT_SYMBOL used for init symbol.
Remove __init or EXPORT_SYMBOL.\n",
+               warn("%s: %s: EXPORT_SYMBOL used for init symbol.
Remove __init or EXPORT_SYMBOL.\n",
                      mod->name, name);
        else if (match(secname, PATTERNS(EXIT_SECTIONS)))
-               error("%s: %s: EXPORT_SYMBOL used for exit symbol.
Remove __exit or EXPORT_SYMBOL.\n",
+               warn("%s: %s: EXPORT_SYMBOL used for exit symbol.
Remove __exit or EXPORT_SYMBOL.\n",
                      mod->name, name);
 }






Fixing the alpha code is trivial.


diff --git a/arch/alpha/kernel/setup.c b/arch/alpha/kernel/setup.c
index 33bf3a627002..22131e2a9f57 100644
--- a/arch/alpha/kernel/setup.c
+++ b/arch/alpha/kernel/setup.c
@@ -385,7 +385,7 @@ setup_memory(void *kernel_end)
 #endif /* CONFIG_BLK_DEV_INITRD */
 }

-int __init
+int
 page_is_ram(unsigned long pfn)
 {
        struct memclust_struct * cluster;







I do not know much about the warning for "saved_config".



__attribute((common)) was added in the following commit:

https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/commit/=
?id=3D3c7940961fbf9f252e20f9c455f2fe63f273294c


It was more than 20 years ago, and there is
no commit description.
I do not know the intention of __attribute((common)).

I hope the maintainers will fix the warnings,
but I do not know if it is likely to happen.

MAINTAINERS says "Odd Fixes"

If you find a build regression, please let me know.
So far, I did not get new reports from 0day bot.


Thanks.




> Guenter
>
> ---
> Bisect log:
>
> # bad: [15e71592dbae49a674429c618a10401d7f992ac3] Add linux-next specific=
 files for 20230621
> # good: [45a3e24f65e90a047bef86f927ebdc4c710edaa1] Linux 6.4-rc7
> git bisect start 'HEAD' 'v6.4-rc7'
> # bad: [e867e67cd55ae460c860ffd896c7fc96add2821c] Merge branch 'master' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git
> git bisect bad e867e67cd55ae460c860ffd896c7fc96add2821c
> # bad: [57b289d5b1005a9c39d6d6567e0ef6115bd59cea] Merge branch 'for-next'=
 of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git
> git bisect bad 57b289d5b1005a9c39d6d6567e0ef6115bd59cea
> # bad: [dc6399fc9ae6d2530fc38fb3ae96bcc8393bd66f] Merge branch 'for-next/=
perf' of git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git
> git bisect bad dc6399fc9ae6d2530fc38fb3ae96bcc8393bd66f
> # good: [6d366ba598334a0457d917a7bf38efd118c5b7be] Merge branch 'mm-stabl=
e' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> git bisect good 6d366ba598334a0457d917a7bf38efd118c5b7be
> # good: [82fe2e45cdb00de4fa648050ae33bdadf9b3294a] perf pmus: Check if we=
 can encode the PMU number in perf_event_attr.type
> git bisect good 82fe2e45cdb00de4fa648050ae33bdadf9b3294a
> # bad: [d2fa756910f88c2f5871775483744407cbf67933] Merge branch 'for-next'=
 of git://git.infradead.org/users/hch/dma-mapping.git
> git bisect bad d2fa756910f88c2f5871775483744407cbf67933
> # good: [1b990bc8edc396a37a3ff1a43f7c329c361ee07c] Merge branch 'mm-nonmm=
-unstable' into mm-everything
> git bisect good 1b990bc8edc396a37a3ff1a43f7c329c361ee07c
> # good: [cff6e7f50bd315e5b39c4e46c704ac587ceb965f] kbuild: Add CLANG_FLAG=
S to as-instr
> git bisect good cff6e7f50bd315e5b39c4e46c704ac587ceb965f
> # bad: [8f3847e175a0044e2212fef772e7fa912270cd6d] ia64,export.h: replace =
EXPORT_DATA_SYMBOL* with EXPORT_SYMBOL*
> git bisect bad 8f3847e175a0044e2212fef772e7fa912270cd6d
> # good: [3a3f1e573a105328a2cca45a7cfbebabbf5e3192] modpost: fix off by on=
e in is_executable_section()
> git bisect good 3a3f1e573a105328a2cca45a7cfbebabbf5e3192
> # good: [92e74fb6e6196d642505ae2b74a8e327202afef9] scripts/kallsyms: cons=
tify long_options
> git bisect good 92e74fb6e6196d642505ae2b74a8e327202afef9
> # good: [92e2921eeafdfca9acd9b83f07d2b7ca099bac24] ARC: define ASM_NL and=
 __ALIGN(_STR) outside #ifdef __ASSEMBLY__ guard
> git bisect good 92e2921eeafdfca9acd9b83f07d2b7ca099bac24
> # bad: [bb2aa9a94b41b883037a56709d995c269204ade0] kbuild: generate KSYMTA=
B entries by modpost
> git bisect bad bb2aa9a94b41b883037a56709d995c269204ade0
> # good: [94d6cb68124b7a63f24fcc345795ba5f9a27e694] modpost: pass struct m=
odule pointer to check_section_mismatch()
> git bisect good 94d6cb68124b7a63f24fcc345795ba5f9a27e694
> # first bad commit: [bb2aa9a94b41b883037a56709d995c269204ade0] kbuild: ge=
nerate KSYMTAB entries by modpost



--=20
Best Regards
Masahiro Yamada
