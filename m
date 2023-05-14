Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC00701D78
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 14:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233187AbjENMoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 08:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjENMoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 08:44:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE2B7171C;
        Sun, 14 May 2023 05:44:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B6E660B77;
        Sun, 14 May 2023 12:44:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAA0DC4339E;
        Sun, 14 May 2023 12:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684068248;
        bh=LJBToeL0tcu0T2KaNfd3KXHteAkpEqZfe7vzNpplhzs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jF8IbLaWO+mElb4geNbZT9I4y5tgR2ozycx58nNPydnxMlqdo6Zt+OTUbQHBqAcRK
         0XMTHBbqPPT9yHMvfygB84RgTrJ9jK0Z213D/SmT9ZWZw+TPK17dedzxdxeE5OLI4n
         QlXEEwgZNYWAmVN32lU4Y2J2DLMFu3SoB1hu/RczyhXDTPdhsAvCj4nx2sJuZBhj4o
         pkIrphDmypyoqFIoN/MBuRmjLgILpRfyrnIGhUbhhAntiFsQ0kgaeH6VFgL5KQo52l
         iFPdtWmpzfdPvctOzGmrS2cxY5i2ZDNHanc2Dn7sEeQf5BhR2ephcl0vk+l+U7Sotj
         YQ8nx4JCgvp1g==
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-54fba751417so2173658eaf.0;
        Sun, 14 May 2023 05:44:08 -0700 (PDT)
X-Gm-Message-State: AC+VfDxLWOjp5Gd/VU1Pvo+Efo0t8Uc0T8KQYzl39JI+GViFAZ0s/tE1
        SVOj1zYNNaSHGnSxPlWKh47bUgnckVi1yY9WsY8=
X-Google-Smtp-Source: ACHHUZ6kXkmKU5bNAZiA8dhA5FsxHC9juf99YtM86r+10x66PzO2bClzrbBHGYxKsX4Ri4PUsJTO2kDHFTlkzOuvmIo=
X-Received: by 2002:a4a:3553:0:b0:54f:810a:160f with SMTP id
 w19-20020a4a3553000000b0054f810a160fmr8669470oog.2.1684068247998; Sun, 14 May
 2023 05:44:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230513204502.1593923-1-masahiroy@kernel.org>
In-Reply-To: <20230513204502.1593923-1-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 14 May 2023 21:43:31 +0900
X-Gmail-Original-Message-ID: <CAK7LNASDzy9RERN6+q6WgR4ROYZQue=SBqgbcoYuVePByHtk6Q@mail.gmail.com>
Message-ID: <CAK7LNASDzy9RERN6+q6WgR4ROYZQue=SBqgbcoYuVePByHtk6Q@mail.gmail.com>
Subject: Re: [PATCH v4 00/21] Unify <linux/export.h> and <asm/export.h>,
 remove EXPORT_DATA_SYMBOL(), faster TRIM_UNUSED_KSYMS
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Pitre <npitre@baylibre.com>,
        Nicolas Schier <nicolas@fjasle.eu>
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

On Sun, May 14, 2023 at 5:45=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
>
> This patch set refactors modpost first to make it easier to
> add new code.
>
> Main goals:
>
>  - Refactors EXPORT_SYMBOL, <linux/export.h> and <asm/export.h>.
>    You can still put EXPORT_SYMBOL() in *.S file, very close to the defin=
ition,
>    but you do not need to care about whether it is a function or a data.
>    This removes EXPORT_DATA_SYMBOL().
>
>  - Re-implement TRIM_UNUSED_KSYMS in one-pass.
>    This makes the building faster.
>
>  - Move the static EXPORT_SYMBOL check to modpost.
>    This also makes the building faster.
>
> Previous version
> v3: https://lore.kernel.org/all/20220928063947.299333-1-masahiroy@kernel.=
org/
>



After more testing, I noticed some issues.





- modpost: simplify find_elf_symbol()
  has a regression.
  I will get a wrong name for 'static' symbols.
  I will fix it or drop it.

- modpost: pass struct module pointer to check_section_mismatch()
  causes a build error, (but fixed by the next commit)

- kbuild: generate KSYMTAB entries by modpost
  This causes build errors on ARM.
  I will fix it.


I will send v5.



>
> Masahiro Yamada (21):
>   modpost: remove broken calculation of exception_table_entry size
>   modpost: remove fromsym info in __ex_table section mismatch warning
>   modpost: remove get_prettyname()
>   modpost: squash report_extable_warnings() into
>     extable_mismatch_handler()
>   modpost: squash report_sec_mismatch() into default_mismatch_handler()
>   modpost: clean up is_executable_section()
>   modpost: squash extable_mismatch_handler() into
>     default_mismatch_handler()
>   modpost: pass 'tosec' down to default_mismatch_handler()
>   modpost: pass section index to find_elf_symbol2()
>   modpost: simplify find_elf_symbol()
>   modpost: rename find_elf_symbol() and find_elf_symbol2()
>   modpost: unify 'sym' and 'to' in default_mismatch_handler()
>   modpost: replace r->r_offset, r->r_addend with faddr, taddr
>   modpost: remove is_shndx_special() check from section_rel(a)
>   modpost: pass struct module pointer to check_section_mismatch()
>   kbuild: generate KSYMTAB entries by modpost
>   ia64,export.h: replace EXPORT_DATA_SYMBOL* with EXPORT_SYMBOL*
>   modpost: check static EXPORT_SYMBOL* by modpost again
>   modpost: squash sym_update_namespace() into sym_add_exported()
>   modpost: use null string instead of NULL pointer for default namespace
>   kbuild: implement CONFIG_TRIM_UNUSED_KSYMS without recursion
>
>  .gitignore                        |   1 -
>  Makefile                          |  19 +-
>  arch/ia64/include/asm/Kbuild      |   1 +
>  arch/ia64/include/asm/export.h    |   3 -
>  arch/ia64/kernel/head.S           |   2 +-
>  arch/ia64/kernel/ivt.S            |   2 +-
>  include/asm-generic/export.h      |  83 +----
>  include/asm-generic/vmlinux.lds.h |   1 +
>  include/linux/export-internal.h   |  49 +++
>  include/linux/export.h            | 116 ++-----
>  include/linux/pm.h                |   8 +-
>  kernel/module/internal.h          |  12 +
>  scripts/Makefile.build            |  19 +-
>  scripts/Makefile.modpost          |   7 +
>  scripts/adjust_autoksyms.sh       |  73 ----
>  scripts/basic/fixdep.c            |   3 +-
>  scripts/check-local-export        |  70 ----
>  scripts/gen_ksymdeps.sh           |  30 --
>  scripts/mod/modpost.c             | 534 ++++++++++++------------------
>  scripts/mod/modpost.h             |   1 +
>  scripts/remove-stale-files        |   2 +
>  21 files changed, 317 insertions(+), 719 deletions(-)
>  delete mode 100644 arch/ia64/include/asm/export.h
>  delete mode 100755 scripts/adjust_autoksyms.sh
>  delete mode 100755 scripts/check-local-export
>  delete mode 100755 scripts/gen_ksymdeps.sh
>
> --
> 2.39.2
>


--=20
Best Regards
Masahiro Yamada
