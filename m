Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8973964BAEF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 18:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236239AbiLMR0Z convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 13 Dec 2022 12:26:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235691AbiLMR0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 12:26:23 -0500
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B34219014;
        Tue, 13 Dec 2022 09:26:22 -0800 (PST)
Received: by mail-qt1-f175.google.com with SMTP id i20so381379qtw.9;
        Tue, 13 Dec 2022 09:26:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ABLNKqAitVQcKI2X5OFSDZh4I8+RKHdjqd+qpiEoKc=;
        b=Gv+/Y+tchiN8FKdK3kX/BWN7DFmCnySNW4eBZot/zO8JcWG62ZbzbE/QmmALon9fmh
         PRZr8hX4q8AT4m1XkdfK85XgcirdmfzxwAgTiUKSacGXse6LA4dpd08Yiv+05zSIZVbp
         1QE24Y6gNodYfMp49mjC0oD0ZT8uOxq95ZFZrlf6bpg6H7LHTuUSjKBW/bhHQysL27pY
         2WnDXDj4dVfnGtIpjrqo3HAMhiGIxpG8KHRadJYbU12MfXlcnxc/bJenylY+JpfuKcoi
         oEdHIell6B8C7xD+8FbQYFlQEBIFmXhJM406dk/roAoNA2A7gYGgdwNuKOJoK9/S+Nqy
         lhDA==
X-Gm-Message-State: ANoB5plcsqaVj2HRtgrOi0A8y/Qyz9IZqJWxD5ADbO0WdtNS/HAcaJYF
        g0vNQ4Kk7QEG6ARzglKia1VwDA5iacEVtQ==
X-Google-Smtp-Source: AA0mqf6BQkmTU2iY0firZnQfs2ZH90dGlKq5If+wOgVKCEukXfy1WFg1P0CBq0aXJUS68kf1Ni7XZg==
X-Received: by 2002:a05:622a:59ca:b0:3a4:3137:79b6 with SMTP id gc10-20020a05622a59ca00b003a4313779b6mr28783590qtb.24.1670952380931;
        Tue, 13 Dec 2022 09:26:20 -0800 (PST)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id a10-20020ac844aa000000b003434d3b5938sm229241qto.2.2022.12.13.09.26.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 09:26:20 -0800 (PST)
Received: by mail-yb1-f173.google.com with SMTP id 186so120371ybe.8;
        Tue, 13 Dec 2022 09:26:20 -0800 (PST)
X-Received: by 2002:a81:148c:0:b0:3e5:f2ca:7be8 with SMTP id
 134-20020a81148c000000b003e5f2ca7be8mr24224685ywu.358.1670952078434; Tue, 13
 Dec 2022 09:21:18 -0800 (PST)
MIME-Version: 1.0
References: <20221212115505.36770-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20221212115505.36770-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20221212115505.36770-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 13 Dec 2022 18:21:07 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXXXN9g8o1j7k-TC=F-kuyf-KngFSKi7z9z0SY9BLxmHA@mail.gmail.com>
Message-ID: <CAMuHMdXXXN9g8o1j7k-TC=F-kuyf-KngFSKi7z9z0SY9BLxmHA@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] riscv: asm: alternative-macros: Introduce
 ALTERNATIVE_3() macro
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Magnus Damm <magnus.damm@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Samuel Holland <samuel@sholland.org>,
        Guo Ren <guoren@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Mon, Dec 12, 2022 at 12:58 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Introduce ALTERNATIVE_3() macro.
>
> A vendor wants to replace an old_content, but another vendor has used
> ALTERNATIVE_2() to patch its customized content at the same location.
> In this case, this vendor can use macro ALTERNATIVE_3() and then replace
> ALTERNATIVE_2() with ALTERNATIVE_3() to append its customized content.
>
> While at it update comment above ALTERNATIVE_2() macro and make it generic
> so that the comment holds good for any new addition of ALTERNATIVE_X()
> macros.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v4->v5
> * Rebased the patch on top of Andrew's series (now in Palmers for next-branch)
> * Updated comment for ALTERNATIVE_x() as suggested by Heiko

Thanks for the update!

> --- a/arch/riscv/include/asm/alternative-macros.h
> +++ b/arch/riscv/include/asm/alternative-macros.h
> @@ -50,8 +50,17 @@
>         ALT_NEW_CONTENT \vendor_id_2, \errata_id_2, \enable_2, \new_c_2
>  .endm
>
> +.macro ALTERNATIVE_CFG_3 old_c, new_c_1, vendor_id_1, errata_id_1, enable_1,   \
> +                               new_c_2, vendor_id_2, errata_id_2, enable_2,    \
> +                               new_c_3, vendor_id_3, errata_id_3, enable_3
> +       ALTERNATIVE_CFG_2 \old_c, \new_c_1, \vendor_id_1, \errata_id_1, \enable_1,      \
> +                                 \new_c_2, \vendor_id_2, \errata_id_2, \enable_2
> +       ALT_NEW_CONTENT \vendor_id_3, \errata_id_3, \enable_3, \new_c_3
> +.endm
> +
>  #define __ALTERNATIVE_CFG(...)         ALTERNATIVE_CFG __VA_ARGS__
>  #define __ALTERNATIVE_CFG_2(...)       ALTERNATIVE_CFG_2 __VA_ARGS__
> +#define __ALTERNATIVE_CFG_3(...)       ALTERNATIVE_CFG_3 __VA_ARGS__
>
>  #else /* !__ASSEMBLY__ */
>
> @@ -98,6 +107,13 @@
>         __ALTERNATIVE_CFG(old_c, new_c_1, vendor_id_1, errata_id_1, enable_1)   \
>         ALT_NEW_CONTENT(vendor_id_2, errata_id_2, enable_2, new_c_2)
>
> +#define __ALTERNATIVE_CFG_3(old_c, new_c_1, vendor_id_1, errata_id_1, enable_1,        \
> +                                  new_c_2, vendor_id_2, errata_id_2, enable_2, \
> +                                  new_c_3, vendor_id_3, errata_id_3, enable_3) \
> +       __ALTERNATIVE_CFG_2(old_c, new_c_1, vendor_id_1, errata_id_1, enable_1, \
> +                                   new_c_2, vendor_id_2, errata_id_2, enable_2)        \
> +       ALT_NEW_CONTENT(vendor_id_3, errata_id_3, enable_3, new_c_3)
> +
>  #endif /* __ASSEMBLY__ */
>
>  #define _ALTERNATIVE_CFG(old_c, new_c, vendor_id, errata_id, CONFIG_k) \
> @@ -108,6 +124,13 @@
>         __ALTERNATIVE_CFG_2(old_c, new_c_1, vendor_id_1, errata_id_1, IS_ENABLED(CONFIG_k_1),   \
>                                    new_c_2, vendor_id_2, errata_id_2, IS_ENABLED(CONFIG_k_2))
>
> +#define _ALTERNATIVE_CFG_3(old_c, new_c_1, vendor_id_1, errata_id_1, CONFIG_k_1,               \
> +                                 new_c_2, vendor_id_2, errata_id_2, CONFIG_k_2,                \
> +                                 new_c_3, vendor_id_3, errata_id_3, CONFIG_k_3)                \
> +       __ALTERNATIVE_CFG_3(old_c, new_c_1, vendor_id_1, errata_id_1, IS_ENABLED(CONFIG_k_1),   \
> +                                  new_c_2, vendor_id_2, errata_id_2, IS_ENABLED(CONFIG_k_2),   \
> +                                  new_c_3, vendor_id_3, errata_id_3, IS_ENABLED(CONFIG_k_3))
> +
>  #else /* CONFIG_RISCV_ALTERNATIVE */

To avoid breaking the build for K210 (and VexRiscv), you need to provide
_ALTERNATIVE_CFG_3() for the !CONFIG_RISCV_ALTERNATIVE case, too:

@@ -144,6 +144,9 @@
 #define _ALTERNATIVE_CFG_2(old_c, ...) \
        ALTERNATIVE_CFG old_c

+#define _ALTERNATIVE_CFG_3(old_c, ...) \
+       ALTERNATIVE_CFG old_c
+
 #else /* !__ASSEMBLY__ */

 #define __ALTERNATIVE_CFG(old_c)       \
@@ -155,6 +158,9 @@
 #define _ALTERNATIVE_CFG_2(old_c, ...) \
        __ALTERNATIVE_CFG(old_c)

+#define _ALTERNATIVE_CFG_3(old_c, ...) \
+       __ALTERNATIVE_CFG(old_c)
+
 #endif /* __ASSEMBLY__ */
 #endif /* CONFIG_RISCV_ALTERNATIVE */

Else it fails (on riscv/for-next) with:

arch/riscv/mm/pmem.c: In function ‘arch_wb_cache_pmem’:
arch/riscv/include/asm/alternative-macros.h:198:8: error: expected
string literal before ‘_ALTERNATIVE_CFG_3’
  198 |        _ALTERNATIVE_CFG_3(old_content, new_content_1,
vendor_id_1, errata_id_1, CONFIG_k_1, \
      |        ^~~~~~~~~~~~~~~~~~
arch/riscv/include/asm/errata_list.h:128:14: note: in expansion of
macro ‘ALTERNATIVE_3’
  128 | asm volatile(ALTERNATIVE_3(      \
      |              ^~~~~~~~~~~~~
arch/riscv/mm/pmem.c:13:2: note: in expansion of macro ‘ALT_CMO_OP’
   13 |  ALT_CMO_OP(clean, addr, size, riscv_cbom_block_size, 0, 0);
      |  ^~~~~~~~~~

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
