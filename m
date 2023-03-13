Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 766DC6B7BE9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 16:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbjCMP2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 11:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjCMP2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 11:28:37 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F9530EB9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 08:28:36 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id c200so2194697ybf.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 08:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678721315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W4IjsZmjIlqDtXW9Y3byuaEZrLwcunxxDuoHomYByjg=;
        b=fO/3GG8EQryyLD5uH151F36i0l5KSLAHeN7Brm8hMuZqbKqbrCdBpMX4ZHFqZ2S7gd
         Czbdg7vza5juqVD680lUTz7yuTlGRPOMD4OHl5zv12D3QmetAhjoarmL+/EtS+XxZFBM
         pclfWDURjVvhyW+UblP0EUmBTyWHGepGEYCrzpvS96lulwz/vTwu2D20jcPoPbpF1609
         ndaabP8ICRyNBmuTsqirM3fQN3e2Q5s9jcevwk/hGtXM19THL1c3Qok9bqOL463AateN
         kVrG44Lr4tIm7PbLThonyn9QY0jQJuUIodIRxWUvmfNbYtk7/VRO4ck5J0O6hExvqrKQ
         +u5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678721315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W4IjsZmjIlqDtXW9Y3byuaEZrLwcunxxDuoHomYByjg=;
        b=a957mBfjvvVXlciL9x+5R8V7bSEDkEUEK3uYZothm3ilqkBnRXKjYaOTy6P7aBZenO
         +b+nkey4JM7hqAjQNBCk+sn5ZrBrekXZyZ2gWJ2boCAmC18p+4rU3VDn1NxmD3O4oDTH
         60kQHQj4Ug4rOsdrxozW7QQgQIowARCm10pLrgtjxxqHfbHCOn4YK2qoltM8l85blZtu
         cMFFJY6T52wzbGBYE/NfYV6/JHGTDHNY9LPkcGIRdO22lrJOCHpeji3BAw8nTMW/sExF
         /2ZvEjJXGiF/N/fi+N/hlS8QPTLQBvycVJW8xvlUfskXFXzuWoe7KuUtlWCHx/vNz/Ou
         BraQ==
X-Gm-Message-State: AO0yUKWqMg7ZVk+0dBLTA9lJvPCMoJwQkrSH54YrdaR1BzxA4aDrT90M
        C1WkzRKnGS7MpKH7lREGSxHCLITjjMcguyYfwexzaw==
X-Google-Smtp-Source: AK7set8+yFjWi/334y3DiCaNsZ4bU0r1AJ5uVYJ49mewHTRvEL2JzmCHUDGdpnCm10Pgv9dsYjmzTdvBt3jwIrXDGWU=
X-Received: by 2002:a25:f512:0:b0:b3c:cbdb:ed5e with SMTP id
 a18-20020a25f512000000b00b3ccbdbed5emr633576ybe.3.1678721315402; Mon, 13 Mar
 2023 08:28:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230313080201.2440201-1-tmricht@linux.ibm.com> <20230313080201.2440201-5-tmricht@linux.ibm.com>
In-Reply-To: <20230313080201.2440201-5-tmricht@linux.ibm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 13 Mar 2023 08:28:23 -0700
Message-ID: <CAP-5=fU+PNg_eFfFbaKLjKv1swgrKO=vKMc7skPty9nJ4D8oFA@mail.gmail.com>
Subject: Re: [PATCH 5/6] tools/perf/json: Add cache metrics for s390 z13
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, sumanthk@linux.ibm.com, svens@linux.ibm.com,
        gor@linux.ibm.com, hca@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UPPERCASE_50_75,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 1:06=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.c=
om> wrote:
>
> Add metrics for s390 z13
> - Percentage sourced from Level 2 cache
> - Percentage sourced from Level 3 on same chip cache
> - Percentage sourced from Level 4 Local cache on same book
> - Percentage sourced from Level 4 Remote cache on different book
> - Percentage sourced from memory
>
> For details about the formulas see this documentation:
> https://www.ibm.com/support/pages/system/files/inline-files/CPU%20MF%20Fo=
rmulas%20including%20z16%20-%20May%202022_1.pdf
>
> Output after:
>
>  # ./perf stat -M l4rp -- find /
>    ...find output deleted
>
>  Performance counter stats for 'find /':
>
>             2      L1I_OFFDRAWER_SCOL_L4_SOURCED_WRITES #     0.02 l4rp
>           252      L1D_ONDRAWER_L4_SOURCED_WRITES
>         3,465      L1D_ONDRAWER_L3_SOURCED_WRITES_IV
>            80      L1D_OFFDRAWER_SCOL_L4_SOURCED_WRITES
>           761      L1D_ONDRAWER_L3_SOURCED_WRITES
>             0      L1I_OFFDRAWER_SCOL_L3_SOURCED_WRITES
>   131,817,067      L1I_DIR_WRITES
>             1      L1I_OFFDRAWER_FCOL_L4_SOURCED_WRITES
>           447      L1D_OFFDRAWER_SCOL_L3_SOURCED_WRITES
>            22      L1D_OFFDRAWER_FCOL_L4_SOURCED_WRITES
>             7      L1I_ONDRAWER_L4_SOURCED_WRITES
>             0      L1I_OFFDRAWER_FCOL_L3_SOURCED_WRITES
>         1,071      L1D_OFFDRAWER_FCOL_L3_SOURCED_WRITES
>             3      L1I_ONDRAWER_L3_SOURCED_WRITES
>        13,352      L1D_OFFDRAWER_FCOL_L3_SOURCED_WRITES_IV
>        15,252      L1D_OFFDRAWER_SCOL_L3_SOURCED_WRITES_IV
>             0      L1I_ONDRAWER_L3_SOURCED_WRITES_IV
>             0      L1I_OFFDRAWER_FCOL_L3_SOURCED_WRITES_IV
>    57,431,083      L1D_DIR_WRITES
>             0      L1I_OFFDRAWER_SCOL_L3_SOURCED_WRITES_IV
>
>       15.386502874 seconds time elapsed
>
>        0.647348000 seconds user
>        3.537041000 seconds sys
>
>  #
>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Acked-By: Sumanth Korikkar <sumanthk@linux.ibm.com>
> ---
>  .../arch/s390/cf_z13/transaction.json         | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/tools/perf/pmu-events/arch/s390/cf_z13/transaction.json b/to=
ols/perf/pmu-events/arch/s390/cf_z13/transaction.json
> index 86bf83b4504e..71e2c7fa734c 100644
> --- a/tools/perf/pmu-events/arch/s390/cf_z13/transaction.json
> +++ b/tools/perf/pmu-events/arch/s390/cf_z13/transaction.json
> @@ -18,5 +18,30 @@
>      "BriefDescription": "Level One Miss per 100 Instructions",
>      "MetricName": "l1mp",
>      "MetricExpr": "((L1I_DIR_WRITES + L1D_DIR_WRITES) / INSTRUCTIONS) * =
100"
> +  },
> +  {
> +    "BriefDescription": "Percentage sourced from Level 2 cache",
> +    "MetricName": "l2p",
> +    "MetricExpr": "((L1D_L2D_SOURCED_WRITES + L1I_L2I_SOURCED_WRITES) / =
(L1I_DIR_WRITES + L1D_DIR_WRITES)) * 100"

Looks good but the same comment about using ScaleUnit.

Thanks,
Ian

> +  },
> +  {
> +    "BriefDescription": "Percentage sourced from Level 3 on same chip ca=
che",
> +    "MetricName": "l3p",
> +    "MetricExpr": "((L1D_ONCHIP_L3_SOURCED_WRITES + L1D_ONCHIP_L3_SOURCE=
D_WRITES_IV + L1I_ONCHIP_L3_SOURCED_WRITES + L1I_ONCHIP_L3_SOURCED_WRITES_I=
V) / (L1I_DIR_WRITES + L1D_DIR_WRITES)) * 100"
> +  },
> +  {
> +    "BriefDescription": "Percentage sourced from Level 4 Local cache on =
same book",
> +    "MetricName": "l4lp",
> +    "MetricExpr": "((L1D_ONNODE_L4_SOURCED_WRITES + L1D_ONNODE_L3_SOURCE=
D_WRITES_IV + L1D_ONNODE_L3_SOURCED_WRITES + L1I_ONNODE_L4_SOURCED_WRITES +=
 L1I_ONNODE_L3_SOURCED_WRITES_IV + L1I_ONNODE_L3_SOURCED_WRITES) / (L1I_DIR=
_WRITES + L1D_DIR_WRITES)) * 100"
> +  },
> +  {
> +    "BriefDescription": "Percentage sourced from Level 4 Remote cache on=
 different book",
> +    "MetricName": "l4rp",
> +    "MetricExpr": "((L1D_ONDRAWER_L4_SOURCED_WRITES + L1D_ONDRAWER_L3_SO=
URCED_WRITES_IV + L1D_ONDRAWER_L3_SOURCED_WRITES + L1D_OFFDRAWER_SCOL_L4_SO=
URCED_WRITES + L1D_OFFDRAWER_SCOL_L3_SOURCED_WRITES_IV + L1D_OFFDRAWER_SCOL=
_L3_SOURCED_WRITES + L1D_OFFDRAWER_FCOL_L4_SOURCED_WRITES + L1D_OFFDRAWER_F=
COL_L3_SOURCED_WRITES_IV + L1D_OFFDRAWER_FCOL_L3_SOURCED_WRITES + L1I_ONDRA=
WER_L4_SOURCED_WRITES + L1I_ONDRAWER_L3_SOURCED_WRITES_IV + L1I_ONDRAWER_L3=
_SOURCED_WRITES + L1I_OFFDRAWER_SCOL_L4_SOURCED_WRITES + L1I_OFFDRAWER_SCOL=
_L3_SOURCED_WRITES_IV + L1I_OFFDRAWER_SCOL_L3_SOURCED_WRITES + L1I_OFFDRAWE=
R_FCOL_L4_SOURCED_WRITES + L1I_OFFDRAWER_FCOL_L3_SOURCED_WRITES_IV + L1I_OF=
FDRAWER_FCOL_L3_SOURCED_WRITES) / (L1I_DIR_WRITES + L1D_DIR_WRITES)) * 100"
> +  },
> +  {
> +    "BriefDescription": "Percentage sourced from memory",
> +    "MetricName": "memp",
> +    "MetricExpr": "((L1D_ONNODE_MEM_SOURCED_WRITES + L1D_ONDRAWER_MEM_SO=
URCED_WRITES + L1D_OFFDRAWER_MEM_SOURCED_WRITES + L1D_ONCHIP_MEM_SOURCED_WR=
ITES + L1I_ONNODE_MEM_SOURCED_WRITES + L1I_ONDRAWER_MEM_SOURCED_WRITES + L1=
I_OFFDRAWER_MEM_SOURCED_WRITES + L1I_ONCHIP_MEM_SOURCED_WRITES) / (L1I_DIR_=
WRITES + L1D_DIR_WRITES)) * 100"
>    }
>  ]
> --
> 2.39.1
>
