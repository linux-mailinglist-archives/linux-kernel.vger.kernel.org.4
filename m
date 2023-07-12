Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D11567504F6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 12:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbjGLKlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 06:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbjGLKlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 06:41:11 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405441FDA
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 03:40:43 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fba74870abso10309258e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 03:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20221208.gappssmtp.com; s=20221208; t=1689158421; x=1691750421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dUhc7Y52Rrbuq+8j2ufP7C0LAU2+c26StOhK+4Px2gM=;
        b=cGVVlogIwchiOyuXJCLRkvZffLKV9InfvvE/qXLdniK5/hjsHoD9lQLjoMRq7dWehu
         APltVzSuxN4I4GKe6uTW/SVjvMSLMndPCkuFvQjRrdz4ASsnkOaI6OPt+WrOoc82gPn8
         DMbZq44GGZffjiNtN0QDZJobXCTI6CIkfqJ9eJCJ+ua+jhV02qKfIGJ9+l5kkqe5Fn5f
         Vo0ZGSZ9ecDUIuBVSKqLZpHfJrPt1mrD0Npq8U4oTkkUZ0WPrqnAdLjt3UxUeT+6QNH7
         q7DUrs14V8SXWtuZNq1y6/b5842zlow36Qmu6RQxlQOToBFiPBLSzYnfUXcwh5oYht1b
         bugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689158421; x=1691750421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dUhc7Y52Rrbuq+8j2ufP7C0LAU2+c26StOhK+4Px2gM=;
        b=cqXE9jMvDvsZa52Lmkpo7eyYiu1c/Su+t/tqsmOVogF+HSd/GQ47/3mwWJ3sBd7crP
         KFvph983l0IkCapwZgxNe9zDUsaGJE+ZIDxNcAKjXwUC9l39KaFoyIwmPqaGONowmYIp
         6BkZiJa2tEhidjDEYNVFDg7loxCvbCuxdqQCZdyzptcVLclGUm4YlREPI62XxeWA3BnO
         HXnybYbUQhSHzw3Tk6drdfoa5dmRS+Z8RvL7XT1juQc2fIyPaKM3TxZi2a1EImGFzPUS
         uLv8tX38L4u/bY0X64VPtTxvfTa/6lBgggMgphMODHqXHvG6/XWvJhnxKjoM1SNNmqC8
         fnfw==
X-Gm-Message-State: ABy/qLbX34IMgh7Nitxoql3zTVE1IiywxbHDkbYZwMdOnEeW34tAg4n0
        GVhoWJ8tn2vIW4mQZnTk+8X0eGG70j2eJkFhr4iUXQ==
X-Google-Smtp-Source: APBJJlE9IeZBjKh7SLh9ui2xsrj36Wg37nLeB0ze+giRurG22Ft5tbcz+tRMYOZn7SG6qPSpvdqNcsBqwHWsrXy/gyo=
X-Received: by 2002:a05:6512:b99:b0:4f8:68a3:38d5 with SMTP id
 b25-20020a0565120b9900b004f868a338d5mr19757463lfv.66.1689158420689; Wed, 12
 Jul 2023 03:40:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230711153743.1970625-1-heiko@sntech.de> <20230711153743.1970625-5-heiko@sntech.de>
In-Reply-To: <20230711153743.1970625-5-heiko@sntech.de>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 12 Jul 2023 16:10:09 +0530
Message-ID: <CAAhSdy2vnrEZxxcmWRr+aZ4aT4kULqED48B3rvAhGsXkq8hJXQ@mail.gmail.com>
Subject: Re: [PATCH v4 04/12] RISC-V: add vector crypto extension detection
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, conor.dooley@microchip.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, christoph.muellner@vrull.eu,
        ebiggers@kernel.org, Heiko Stuebner <heiko.stuebner@vrull.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75 autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 9:09=E2=80=AFPM Heiko Stuebner <heiko@sntech.de> wr=
ote:
>
> From: Heiko Stuebner <heiko.stuebner@vrull.eu>
>
> Add detection for some extensions of the vector-crypto specification:
> - Zvkb: Vector Bit-manipulation used in Cryptography
> - Zvkg: Vector GCM/GMAC
> - Zvknha and Zvknhb: NIST Algorithm Suite
> - Zvkns: AES-128, AES-256 Single Round Suite
> - Zvksed: ShangMi Algorithm Suite
> - Zvksh: ShangMi Algorithm Suite

Any plan to allow user-space to detect these extensions via HWPROBE ?

Regards,
Anup

>
> As their use is very specific and will likely be limited to special place=
s
> we expect current code to just pre-encode those instructions, so right no=
w
> we don't introduce toolchain requirements.
>
> Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
> ---
>  arch/riscv/include/asm/hwcap.h |  9 ++++++
>  arch/riscv/kernel/cpu.c        |  8 ++++++
>  arch/riscv/kernel/cpufeature.c | 50 ++++++++++++++++++++++++++++++++++
>  3 files changed, 67 insertions(+)
>
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwca=
p.h
> index b80ca6e77088..0f5172fa87b0 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -64,6 +64,15 @@
>  #define RISCV_ISA_EXT_ZKSED            51
>  #define RISCV_ISA_EXT_ZKSH             52
>  #define RISCV_ISA_EXT_ZKT              53
> +#define RISCV_ISA_EXT_ZVBB             54
> +#define RISCV_ISA_EXT_ZVBC             55
> +#define RISCV_ISA_EXT_ZVKG             56
> +#define RISCV_ISA_EXT_ZVKNED           57
> +#define RISCV_ISA_EXT_ZVKNHA           58
> +#define RISCV_ISA_EXT_ZVKNHB           59
> +#define RISCV_ISA_EXT_ZVKSED           60
> +#define RISCV_ISA_EXT_ZVKSH            61
> +#define RISCV_ISA_EXT_ZVKT             62
>
>  #define RISCV_ISA_EXT_MAX              64
>  #define RISCV_ISA_EXT_NAME_LEN_MAX     32
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index 10524322a4c0..925241e25db2 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -227,6 +227,14 @@ static struct riscv_isa_ext_data isa_ext_arr[] =3D {
>         __RISCV_ISA_EXT_DATA(zksed, RISCV_ISA_EXT_ZKSED),
>         __RISCV_ISA_EXT_DATA(zksh, RISCV_ISA_EXT_ZKSH),
>         __RISCV_ISA_EXT_DATA(zkt, RISCV_ISA_EXT_ZKT),
> +       __RISCV_ISA_EXT_DATA(zvbb, RISCV_ISA_EXT_ZVBB),
> +       __RISCV_ISA_EXT_DATA(zvbc, RISCV_ISA_EXT_ZVBC),
> +       __RISCV_ISA_EXT_DATA(zvkg, RISCV_ISA_EXT_ZVKG),
> +       __RISCV_ISA_EXT_DATA(zvkned, RISCV_ISA_EXT_ZVKNED),
> +       __RISCV_ISA_EXT_DATA(zvknha, RISCV_ISA_EXT_ZVKNHA),
> +       __RISCV_ISA_EXT_DATA(zvknhb, RISCV_ISA_EXT_ZVKNHB),
> +       __RISCV_ISA_EXT_DATA(zvksed, RISCV_ISA_EXT_ZVKSED),
> +       __RISCV_ISA_EXT_DATA(zvksh, RISCV_ISA_EXT_ZVKSH),
>         __RISCV_ISA_EXT_DATA(smaia, RISCV_ISA_EXT_SMAIA),
>         __RISCV_ISA_EXT_DATA(ssaia, RISCV_ISA_EXT_SSAIA),
>         __RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeatur=
e.c
> index 9a872a2007a5..13556fd16bf6 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -343,6 +343,56 @@ void __init riscv_fill_hwcap(void)
>                                 SET_ISA_EXT_MAP("zksh", RISCV_ISA_EXT_ZKS=
H);
>                                 SET_ISA_EXT_MAP("zkr", RISCV_ISA_EXT_ZKR)=
;
>                                 SET_ISA_EXT_MAP("zkt", RISCV_ISA_EXT_ZKT)=
;
> +                               SET_ISA_EXT_MAP("zvbb", RISCV_ISA_EXT_ZVB=
B);
> +                               SET_ISA_EXT_MAP("zvbc", RISCV_ISA_EXT_ZVB=
C);
> +                               SET_ISA_EXT_MAP("zvkg", RISCV_ISA_EXT_ZVK=
G);
> +                               SET_ISA_EXT_MAP("zvkned", RISCV_ISA_EXT_Z=
VKNED);
> +                               SET_ISA_EXT_MAP("zvknha", RISCV_ISA_EXT_Z=
VKNHA);
> +                               SET_ISA_EXT_MAP("zvknhb", RISCV_ISA_EXT_Z=
VKNHB);
> +                               SET_ISA_EXT_MAP("zvksed", RISCV_ISA_EXT_Z=
VKSED);
> +                               SET_ISA_EXT_MAP("zvksh", RISCV_ISA_EXT_ZV=
KSH);
> +                               SET_ISA_EXT_MAP("zvkt", RISCV_ISA_EXT_ZVK=
T);
> +
> +                               /* NIST Algorithm Suite */
> +                               SET_ISA_EXT_MAP("zvkn", RISCV_ISA_EXT_ZVK=
NED);
> +                               SET_ISA_EXT_MAP("zvkn", RISCV_ISA_EXT_ZVK=
NHB);
> +                               SET_ISA_EXT_MAP("zvkn", RISCV_ISA_EXT_ZVB=
B);
> +                               SET_ISA_EXT_MAP("zvkn", RISCV_ISA_EXT_ZVK=
T);
> +
> +                               /* NIST Algorithm Suite with carryless mu=
ltiply */
> +                               SET_ISA_EXT_MAP("zvknc", RISCV_ISA_EXT_ZV=
KNED);
> +                               SET_ISA_EXT_MAP("zvknc", RISCV_ISA_EXT_ZV=
KNHB);
> +                               SET_ISA_EXT_MAP("zvknc", RISCV_ISA_EXT_ZV=
BB);
> +                               SET_ISA_EXT_MAP("zvknc", RISCV_ISA_EXT_ZV=
KT);
> +                               SET_ISA_EXT_MAP("zvknc", RISCV_ISA_EXT_ZV=
BC);
> +
> +                               /* NIST Algorithm Suite with GCM */
> +                               SET_ISA_EXT_MAP("zvkng", RISCV_ISA_EXT_ZV=
KNED);
> +                               SET_ISA_EXT_MAP("zvkng", RISCV_ISA_EXT_ZV=
KNHB);
> +                               SET_ISA_EXT_MAP("zvkng", RISCV_ISA_EXT_ZV=
BB);
> +                               SET_ISA_EXT_MAP("zvkng", RISCV_ISA_EXT_ZV=
KT);
> +                               SET_ISA_EXT_MAP("zvkng", RISCV_ISA_EXT_ZV=
KG);
> +
> +                               /*  ShangMi Algorithm Suite */
> +                               SET_ISA_EXT_MAP("zvks", RISCV_ISA_EXT_ZVK=
SED);
> +                               SET_ISA_EXT_MAP("zvks", RISCV_ISA_EXT_ZVK=
SH);
> +                               SET_ISA_EXT_MAP("zvks", RISCV_ISA_EXT_ZVB=
B);
> +                               SET_ISA_EXT_MAP("zvks", RISCV_ISA_EXT_ZVK=
T);
> +
> +                               /* ShangMi Algorithm Suite with carryless=
 multiply */
> +                               SET_ISA_EXT_MAP("zvksc", RISCV_ISA_EXT_ZV=
KSED);
> +                               SET_ISA_EXT_MAP("zvksc", RISCV_ISA_EXT_ZV=
KSH);
> +                               SET_ISA_EXT_MAP("zvksc", RISCV_ISA_EXT_ZV=
BB);
> +                               SET_ISA_EXT_MAP("zvksc", RISCV_ISA_EXT_ZV=
KT);
> +                               SET_ISA_EXT_MAP("zvksc", RISCV_ISA_EXT_ZV=
BC);
> +
> +                               /* ShangMi Algorithm Suite with GCM */
> +                               SET_ISA_EXT_MAP("zvksg", RISCV_ISA_EXT_ZV=
KSED);
> +                               SET_ISA_EXT_MAP("zvksg", RISCV_ISA_EXT_ZV=
KSH);
> +                               SET_ISA_EXT_MAP("zvksg", RISCV_ISA_EXT_ZV=
BB);
> +                               SET_ISA_EXT_MAP("zvksg", RISCV_ISA_EXT_ZV=
KT);
> +                               SET_ISA_EXT_MAP("zvksg", RISCV_ISA_EXT_ZV=
KG);
> +
>                         }
>  #undef SET_ISA_EXT_MAP
>                 }
> --
> 2.39.2
>
