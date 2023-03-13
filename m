Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52AD66B7BDE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 16:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjCMPYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 11:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbjCMPYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 11:24:21 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC4354C94
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 08:24:18 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-541a05e4124so60881927b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 08:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678721058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=miD1UL5SmaXU4angX1YOOgTXJKTsZ0bIXYcLaAcdSBs=;
        b=sBBL2nrrHl8OUQTwNxo1hL50DYzng/MctVbkj/JgtWNDA/2ehB4a/4Laz6BGRWq7hI
         ot0b2cO9LzgvRThnNmF5DwKvea1/gdKxXMjwQB0OejwBKxjnSbqOUXaYmoNOM3DZ+JE8
         3SsQWGK54GouUPA3IRoCcoWiBKCVwgkNiTo18/9FTsMgN6guMqR6bAeF3sneCx6axYBr
         L7vS7fC8/1QIRvLjCcgrOU9Gl6Wfls40Kdr2rJYPk92IdN9bE1JB62DKG7XfQC6O4Vw+
         hO/H9LW1WBhMVzo3QvxeeqsPPegyBeBuZZK7C6Z4WwfCd0EdQjGU/fw5O62LqHg26+j9
         fONQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678721058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=miD1UL5SmaXU4angX1YOOgTXJKTsZ0bIXYcLaAcdSBs=;
        b=xgnmxI1vyeHVZBwA/ootbgVLq9mzt8ifz+SueStEmC1MPj4toxXkR/fGb/JYRJGN4E
         PBFZAcncGP7+aH1jadL1acpaDOLp5fiDk+YtciA1Bz+W6WNzxeUo3hLGEvxUxFpQLhmP
         xhADgqKPNL6OXHgKb5DItk6GpUAAIClhyXCG9+R29z0uViuD2XQ+vGUM5SPcaXS62GBz
         NA+bOBYVN6/kQox93GGB5O+IJazlfM/wxEVuQQj7SfQGotgHtkWWDjnUx+Fdg7alE5Xb
         eIrZ3d4SM9i9WmGPp06pqgPXYsdqakA5R14sJnBAUmTzq4PeGIOX6gSHxzMoPUkyLwfY
         T4Ig==
X-Gm-Message-State: AO0yUKUFVKKyo/782Es3ae/Tmd5XW3IxjvaLG+xeQT3UXjHjM1OaB+Rt
        Cgg3jrIhH5Z203mX7zfUA7ZsjYOkPRX/oCOVUGRPYg==
X-Google-Smtp-Source: AK7set9rOIwWUcKus6/AOVo/cWIf+3wr/bs1l75PKL7IV1SvIuGBUgFixB+MaM+Xt3efTaF+E8qXMRI+OtH3pPVeROM=
X-Received: by 2002:a81:af5c:0:b0:540:e6c6:31e7 with SMTP id
 x28-20020a81af5c000000b00540e6c631e7mr5878250ywj.2.1678721057682; Mon, 13 Mar
 2023 08:24:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230313080201.2440201-1-tmricht@linux.ibm.com> <20230313080201.2440201-3-tmricht@linux.ibm.com>
In-Reply-To: <20230313080201.2440201-3-tmricht@linux.ibm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 13 Mar 2023 08:24:06 -0700
Message-ID: <CAP-5=fW6HjLubp381QuAw-Q8N7-D6StTP5maqksRGWvwwv9UgQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] tools/perf/json: Add cache metrics for s390 z15
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, sumanthk@linux.ibm.com, svens@linux.ibm.com,
        gor@linux.ibm.com, hca@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 1:31=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.c=
om> wrote:
>
> Add metrics for s390 z15
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
> Outpuf after:
>  # ./perf stat -M l4rp -- find /
>  .... find output deleted
>
>  Performance counter stats for 'find /':
>
>               5      L1I_OFFDRAWER_L4_SOURCED_WRITES  #     0.01 l4rp
>             187      L1D_OFFDRAWER_L4_SOURCED_WRITES
>               0      L1I_OFFDRAWER_L3_SOURCED_WRITES
>     231,333,165      L1I_DIR_WRITES
>           3,303      L1D_OFFDRAWER_L3_SOURCED_WRITES
>          47,461      L1D_OFFDRAWER_L3_SOURCED_WRITES_IV
>               0      L1I_OFFDRAWER_L3_SOURCED_WRITES_IV
>     126,706,244      L1D_DIR_WRITES
>
>    27.870355461 seconds time elapsed
>
>     0.521562000 seconds user
>    12.494503000 seconds sys
>  #
>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Acked-By: Sumanth Korikkar <sumanthk@linux.ibm.com>
> ---
>  .../arch/s390/cf_z15/transaction.json         | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/tools/perf/pmu-events/arch/s390/cf_z15/transaction.json b/to=
ols/perf/pmu-events/arch/s390/cf_z15/transaction.json
> index 86bf83b4504e..cca237bdb7ba 100644
> --- a/tools/perf/pmu-events/arch/s390/cf_z15/transaction.json
> +++ b/tools/perf/pmu-events/arch/s390/cf_z15/transaction.json
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
> +    "MetricExpr": "((L1D_ONCLUSTER_L3_SOURCED_WRITES + L1D_ONCLUSTER_L3_=
SOURCED_WRITES_IV + L1D_ONDRAWER_L4_SOURCED_WRITES + L1I_ONCLUSTER_L3_SOURC=
ED_WRITES + L1I_ONCLUSTER_L3_SOURCED_WRITES_IV + L1I_ONDRAWER_L4_SOURCED_WR=
ITES + L1D_OFFCLUSTER_L3_SOURCED_WRITES + L1D_OFFCLUSTER_L3_SOURCED_WRITES_=
IV + L1D_ONCHIP_L3_SOURCED_WRITES_RO + L1I_OFFCLUSTER_L3_SOURCED_WRITES + L=
1I_OFFCLUSTER_L3_SOURCED_WRITES_IV) / (L1I_DIR_WRITES + L1D_DIR_WRITES)) * =
100"

It is more typical for percentages to change the ScaleUnit to "100%"
and not to do the "* 100". Otherwise these look good.

Thanks,
Ian

> +  },
> +  {
> +    "BriefDescription": "Percentage sourced from Level 4 Remote cache on=
 different book",
> +    "MetricName": "l4rp",
> +    "MetricExpr": "((L1D_OFFDRAWER_L3_SOURCED_WRITES + L1D_OFFDRAWER_L3_=
SOURCED_WRITES_IV + L1D_OFFDRAWER_L4_SOURCED_WRITES + L1I_OFFDRAWER_L3_SOUR=
CED_WRITES + L1I_OFFDRAWER_L3_SOURCED_WRITES_IV + L1I_OFFDRAWER_L4_SOURCED_=
WRITES) / (L1I_DIR_WRITES + L1D_DIR_WRITES)) * 100"
> +  },
> +  {
> +    "BriefDescription": "Percentage sourced from memory",
> +    "MetricName": "memp",
> +    "MetricExpr": "((L1D_ONCHIP_MEMORY_SOURCED_WRITES + L1D_ONCLUSTER_ME=
MORY_SOURCED_WRITES + L1D_OFFCLUSTER_MEMORY_SOURCED_WRITES + L1D_OFFDRAWER_=
MEMORY_SOURCED_WRITES + L1I_ONCHIP_MEMORY_SOURCED_WRITES + L1I_ONCLUSTER_ME=
MORY_SOURCED_WRITES + L1I_OFFCLUSTER_MEMORY_SOURCED_WRITES + L1I_OFFDRAWER_=
MEMORY_SOURCED_WRITES) / (L1I_DIR_WRITES + L1D_DIR_WRITES)) * 100"
>    }
>  ]
> --
> 2.39.1
>
