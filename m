Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E34A70AE36
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 15:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbjEUNdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 09:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbjEUN2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 09:28:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4443110D3;
        Sun, 21 May 2023 06:15:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CBAC56112B;
        Sun, 21 May 2023 13:15:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CF0BC433EF;
        Sun, 21 May 2023 13:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684674939;
        bh=ClMpGWn7trOjyJnYdLlaH16LRphJd8dVTqjlNt6sTkM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Q0TA937RalbFAr+HiwKrhuEfYt9bx/pYrOXaZH6Cb8JHyDUDa0rYh82tiTJs+6Ozk
         mV3608K/KMv7HktdwGu3JowzTwUMsgOuGtdLbFIJkz26ue+Ys/RRip2Ij9S30/D2UQ
         4Pk9/wzU6W6DvGoNJ24FI6wK2OK/fVV33faOWw5OPDc48Y8r0YrDXTPhQFawP/0r7d
         oB14+HhCn2b2xYrPluXbXYIH1oS+/uVY8d8ajUDntDxneRnLzPbHVexIvQL8iNP/sx
         xPR8t3GVfe1LZ+FNcRNI6bcH8dAADzKKJO6nTBpwsE2wgxobmxJMA316dgYJDmbADW
         9MWKnlr6vjduA==
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6af6df840ffso528844a34.1;
        Sun, 21 May 2023 06:15:39 -0700 (PDT)
X-Gm-Message-State: AC+VfDyUUSTmHf04GPF5bdg22HAmqoJr1mFxiMHc578Ds4EKbL4Kp3Lz
        by70n+hxB4Kuev3brw8CU1vLrhhCzwdwTDMjso4=
X-Google-Smtp-Source: ACHHUZ6tnEh6kpdE1EV1jUGjruspnEfgKuBW9p4Wl9F3ecFIEHjOL9BuWDU+4mzCESA8DHClFFoPFqj60wqByfPP2DE=
X-Received: by 2002:aca:1218:0:b0:397:f912:9299 with SMTP id
 24-20020aca1218000000b00397f9129299mr936663ois.25.1684674938459; Sun, 21 May
 2023 06:15:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230514152739.962109-1-masahiroy@kernel.org>
In-Reply-To: <20230514152739.962109-1-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 21 May 2023 22:15:02 +0900
X-Gmail-Original-Message-ID: <CAK7LNARBiOywrMLbR=9N35sk19U0QM3xcPy7d1WqV-eyb4W23w@mail.gmail.com>
Message-ID: <CAK7LNARBiOywrMLbR=9N35sk19U0QM3xcPy7d1WqV-eyb4W23w@mail.gmail.com>
Subject: Re: [PATCH v5 00/21] Unify <linux/export.h> and <asm/export.h>,
 remove EXPORT_DATA_SYMBOL(), faster TRIM_UNUSED_KSYMS
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Pitre <npitre@baylibre.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 12:27=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.=
org> wrote:
>
>
> This patch set refactors modpost first to make it easier to
> add new code.
>
> My goals:
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
> v4: https://lore.kernel.org/linux-kbuild/CAK7LNASDzy9RERN6+q6WgR4ROYZQue=
=3DSBqgbcoYuVePByHtk6Q@mail.gmail.com/T/#t
> v3: https://lore.kernel.org/all/20220928063947.299333-1-masahiroy@kernel.=
org/
>


01-10 applied to linux-kbuild.

I will send v6 for the rest.



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
>   modpost: rename find_elf_symbol() and find_elf_symbol2()
>   modpost: modpost: refactor find_fromsym() and find_tosym()
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
>  include/linux/export.h            | 119 ++-----
>  include/linux/pm.h                |   8 +-
>  kernel/module/internal.h          |  12 +
>  scripts/Makefile.build            |  19 +-
>  scripts/Makefile.modpost          |   7 +
>  scripts/adjust_autoksyms.sh       |  73 ----
>  scripts/basic/fixdep.c            |   3 +-
>  scripts/check-local-export        |  70 ----
>  scripts/gen_ksymdeps.sh           |  30 --
>  scripts/mod/modpost.c             | 561 ++++++++++++------------------
>  scripts/mod/modpost.h             |   1 +
>  scripts/remove-stale-files        |   2 +
>  21 files changed, 343 insertions(+), 723 deletions(-)
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
