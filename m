Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37970740303
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 20:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjF0SPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 14:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbjF0SPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 14:15:32 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326C530DA
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 11:15:10 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b6afc1ceffso17639221fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 11:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1687889707; x=1690481707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=40uQzvlt/PE5dTbfAx50Zw1FjL4TOr/3oSkUCzxbiF8=;
        b=BpzZOh//Y9cJssc0gNbtxSrLtl/qMOEAM8n0q+ady6zMbTkGBrsVULo0P04NtsTW3E
         1nH009cgsXYd4hcf5zlYJ/7UZn6Hjvi5GxliyovfWuLTbNqR+C8LxWHOf0vRxJZf/0IM
         I36ZpXXgmJ56aekAPVwbIJmQVZRTqKNSyVCc27f0zYTNF2xbL7eqg1Qcxlo/VJTZRHG3
         YJFs0PPIyhPE+TjC0aQOyJQZcrOmWq5iRn/1xZjzt2av8DOLbEcS2gZRfVnKY0dc2ikR
         YSE3wg+wz0beTEYchOT3DJPSRJ7Etc/UklgTnYvVa3UUzYW+6/IH5uJkz0p0WMdoljj5
         Bn5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687889707; x=1690481707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=40uQzvlt/PE5dTbfAx50Zw1FjL4TOr/3oSkUCzxbiF8=;
        b=IaxtpvH+2L8BzCvGdygH74rGKhDGPAZh3Xi0FOmorhcLK1KunxpOUvBZEuIS2vuRuo
         hiHAUrhxQ26IIryfKrIbv5MEz8fkGzTf/c+HCNJcODhuw+cOLmSuXEYUHLxEK6hCfQ9B
         OFQrXCnbs7L4PpygHEyb7o7laUKDCKsCZpjAaFTCRc68SUmjCYq5Z77JaD5bWHbDB4jc
         VCAend42ucuP7kAQBwtT8KGtfl8i1df5LaZE+b+9lsWZYLYoY26HB81z3YUdgA9qTn0B
         3Z5DOVVM1d1EGGydC6Wfs7281EX/WIe/1UHvRov+b1EvJXdnQGgudQPSimLcWdNgxj5g
         3GcA==
X-Gm-Message-State: AC+VfDw/DnE2tJonUfUX/Cw0Nvu7oHOazFy5gGTTx9cS5EOgOcHI6mir
        LcVav41kf2tEmRCPTbNaje1VLjmmRyY3bn1MukgUIQ==
X-Google-Smtp-Source: ACHHUZ4G8ea65SHqLki4m9fBUhKHm5w4ocMU1vOhxRKMuTvj5QBTRG/YFzssfGy0ZDcdeWvI5aGqaubksEEzygNxLRE=
X-Received: by 2002:a19:4f54:0:b0:4f8:5d94:2e46 with SMTP id
 a20-20020a194f54000000b004f85d942e46mr10292221lfk.48.1687889706821; Tue, 27
 Jun 2023 11:15:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230627143747.1599218-1-sameo@rivosinc.com> <20230627143747.1599218-2-sameo@rivosinc.com>
In-Reply-To: <20230627143747.1599218-2-sameo@rivosinc.com>
From:   Evan Green <evan@rivosinc.com>
Date:   Tue, 27 Jun 2023 11:14:30 -0700
Message-ID: <CALs-HssMkVikspnEi-Ek2t=ABvFvgptAhsBjk1+aLuVjiP7P7w@mail.gmail.com>
Subject: Re: [PATCH 1/3] RISC-V: add Bitmanip/Scalar Crypto parsing from DT
To:     Samuel Ortiz <sameo@rivosinc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        "Hongren (Zenithal) Zheng" <i@zenithal.me>, linux@rivosinc.com,
        Conor Dooley <conor.dooley@microchip.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Anup Patel <apatel@ventanamicro.com>,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        Jiatai He <jiatai2021@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75 autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 7:38=E2=80=AFAM Samuel Ortiz <sameo@rivosinc.com> w=
rote:
>
> From: "Hongren (Zenithal) Zheng" <i@zenithal.me>
>
> This patch parses Zb/Zk related string from DT and
> output them in cpuinfo
>
> One thing worth noting is that if DT provides zk,
> all zbkb, zbkc, zbkx and zkn, zkr, zkt would be enabled.
>
> Note that zk is a valid extension name and the current
> DT binding spec allows this.
>
> This patch also changes the logical id of
> existing multi-letter extensions and adds a statement
> that instead of logical id compatibility, the order
> is needed.
>
> There currently lacks a mechanism to merge them when
> producing cpuinfo. Namely if you provide a riscv,isa
> "rv64imafdc_zk_zks", the cpuinfo output would be
> "rv64imafdc_zbkb_zbkc_zbkx_zknd_zkne_zknh_zkr_zksed
> _zksh_zkt"
>
> Tested-by: Jiatai He <jiatai2021@iscas.ac.cn>
> Signed-off-by: Hongren (Zenithal) Zheng <i@zenithal.me>
> ---
>  arch/riscv/include/asm/hwcap.h | 11 +++++++++++
>  arch/riscv/kernel/cpu.c        | 11 +++++++++++
>  arch/riscv/kernel/cpufeature.c | 30 ++++++++++++++++++++++++++++++
>  3 files changed, 52 insertions(+)
>
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwca=
p.h
> index f041bfa7f6a0..b80ca6e77088 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -53,6 +53,17 @@
>  #define RISCV_ISA_EXT_ZICSR            40
>  #define RISCV_ISA_EXT_ZIFENCEI         41
>  #define RISCV_ISA_EXT_ZIHPM            42
> +#define RISCV_ISA_EXT_ZBC              43
> +#define RISCV_ISA_EXT_ZBKB             44
> +#define RISCV_ISA_EXT_ZBKC             45
> +#define RISCV_ISA_EXT_ZBKX             46
> +#define RISCV_ISA_EXT_ZKND             47
> +#define RISCV_ISA_EXT_ZKNE             48
> +#define RISCV_ISA_EXT_ZKNH             49
> +#define RISCV_ISA_EXT_ZKR              50
> +#define RISCV_ISA_EXT_ZKSED            51
> +#define RISCV_ISA_EXT_ZKSH             52
> +#define RISCV_ISA_EXT_ZKT              53
>
>  #define RISCV_ISA_EXT_MAX              64
>  #define RISCV_ISA_EXT_NAME_LEN_MAX     32
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index a2fc952318e9..10524322a4c0 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -215,7 +215,18 @@ static struct riscv_isa_ext_data isa_ext_arr[] =3D {
>         __RISCV_ISA_EXT_DATA(zihpm, RISCV_ISA_EXT_ZIHPM),
>         __RISCV_ISA_EXT_DATA(zba, RISCV_ISA_EXT_ZBA),
>         __RISCV_ISA_EXT_DATA(zbb, RISCV_ISA_EXT_ZBB),
> +       __RISCV_ISA_EXT_DATA(zbc, RISCV_ISA_EXT_ZBC),
> +       __RISCV_ISA_EXT_DATA(zbkb, RISCV_ISA_EXT_ZBKB),
> +       __RISCV_ISA_EXT_DATA(zbkc, RISCV_ISA_EXT_ZBKC),
> +       __RISCV_ISA_EXT_DATA(zbkx, RISCV_ISA_EXT_ZBKX),
>         __RISCV_ISA_EXT_DATA(zbs, RISCV_ISA_EXT_ZBS),
> +       __RISCV_ISA_EXT_DATA(zknd, RISCV_ISA_EXT_ZKND),
> +       __RISCV_ISA_EXT_DATA(zkne, RISCV_ISA_EXT_ZKNE),
> +       __RISCV_ISA_EXT_DATA(zknh, RISCV_ISA_EXT_ZKNH),
> +       __RISCV_ISA_EXT_DATA(zkr, RISCV_ISA_EXT_ZKR),
> +       __RISCV_ISA_EXT_DATA(zksed, RISCV_ISA_EXT_ZKSED),
> +       __RISCV_ISA_EXT_DATA(zksh, RISCV_ISA_EXT_ZKSH),
> +       __RISCV_ISA_EXT_DATA(zkt, RISCV_ISA_EXT_ZKT),
>         __RISCV_ISA_EXT_DATA(smaia, RISCV_ISA_EXT_SMAIA),
>         __RISCV_ISA_EXT_DATA(ssaia, RISCV_ISA_EXT_SSAIA),
>         __RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeatur=
e.c
> index bdcf460ea53d..447f853a5a4c 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -309,10 +309,40 @@ void __init riscv_fill_hwcap(void)
>                                 SET_ISA_EXT_MAP("svpbmt", RISCV_ISA_EXT_S=
VPBMT);
>                                 SET_ISA_EXT_MAP("zba", RISCV_ISA_EXT_ZBA)=
;
>                                 SET_ISA_EXT_MAP("zbb", RISCV_ISA_EXT_ZBB)=
;
> +                               SET_ISA_EXT_MAP("zbc", RISCV_ISA_EXT_ZBC)=
;
>                                 SET_ISA_EXT_MAP("zbs", RISCV_ISA_EXT_ZBS)=
;
> +                               SET_ISA_EXT_MAP("zbkb", RISCV_ISA_EXT_ZBK=
B);
> +                               SET_ISA_EXT_MAP("zbkc", RISCV_ISA_EXT_ZBK=
C);
> +                               SET_ISA_EXT_MAP("zbks", RISCV_ISA_EXT_ZBK=
X);

Should "zbks" be "zbkx"?

>                                 SET_ISA_EXT_MAP("zicbom", RISCV_ISA_EXT_Z=
ICBOM);
>                                 SET_ISA_EXT_MAP("zicboz", RISCV_ISA_EXT_Z=
ICBOZ);
>                                 SET_ISA_EXT_MAP("zihintpause", RISCV_ISA_=
EXT_ZIHINTPAUSE);
> +                               SET_ISA_EXT_MAP("zksed", RISCV_ISA_EXT_ZK=
SED);
> +                               SET_ISA_EXT_MAP("zksh", RISCV_ISA_EXT_ZKS=
H);
> +                               SET_ISA_EXT_MAP("zkr", RISCV_ISA_EXT_ZKR)=
;
> +                               SET_ISA_EXT_MAP("zkt", RISCV_ISA_EXT_ZKT)=
;
> +                               SET_ISA_EXT_MAP("zkn", RISCV_ISA_EXT_ZBKB=
);
> +                               SET_ISA_EXT_MAP("zkn", RISCV_ISA_EXT_ZBKC=
);
> +                               SET_ISA_EXT_MAP("zkn", RISCV_ISA_EXT_ZBKX=
);
> +                               SET_ISA_EXT_MAP("zkn", RISCV_ISA_EXT_ZKND=
);
> +                               SET_ISA_EXT_MAP("zkn", RISCV_ISA_EXT_ZKNE=
);
> +                               SET_ISA_EXT_MAP("zkn", RISCV_ISA_EXT_ZKNH=
);
> +                               SET_ISA_EXT_MAP("zknd", RISCV_ISA_EXT_ZKN=
D);
> +                               SET_ISA_EXT_MAP("zkne", RISCV_ISA_EXT_ZKN=
E);
> +                               SET_ISA_EXT_MAP("zknh", RISCV_ISA_EXT_ZKN=
H);
> +                               SET_ISA_EXT_MAP("zks", RISCV_ISA_EXT_ZBKB=
);
> +                               SET_ISA_EXT_MAP("zks", RISCV_ISA_EXT_ZBKC=
);
> +                               SET_ISA_EXT_MAP("zks", RISCV_ISA_EXT_ZBKX=
);
> +                               SET_ISA_EXT_MAP("zks", RISCV_ISA_EXT_ZKSE=
D);
> +                               SET_ISA_EXT_MAP("zks", RISCV_ISA_EXT_ZKSH=
);
> +                               SET_ISA_EXT_MAP("zk", RISCV_ISA_EXT_ZBKB)=
;
> +                               SET_ISA_EXT_MAP("zk", RISCV_ISA_EXT_ZBKC)=
;
> +                               SET_ISA_EXT_MAP("zk", RISCV_ISA_EXT_ZBKX)=
;
> +                               SET_ISA_EXT_MAP("zk", RISCV_ISA_EXT_ZKND)=
;
> +                               SET_ISA_EXT_MAP("zk", RISCV_ISA_EXT_ZKNE)=
;
> +                               SET_ISA_EXT_MAP("zk", RISCV_ISA_EXT_ZKNH)=
;
> +                               SET_ISA_EXT_MAP("zk", RISCV_ISA_EXT_ZKR);
> +                               SET_ISA_EXT_MAP("zk", RISCV_ISA_EXT_ZKT);

It would be nice to consolidate the ones together that search for a
single string and set multiple bits, though I don't have any super
elegant ideas for how off the top of my head.
