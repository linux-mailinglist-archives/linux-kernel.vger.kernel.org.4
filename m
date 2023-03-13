Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087266B7BD7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 16:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbjCMPXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 11:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbjCMPXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 11:23:02 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B109B4EE6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 08:22:56 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-540cb2fb5b9so143827477b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 08:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678720976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9j2QtS0izWtlGzja2plumnFtdWtXW9QpAWI+2e46E1w=;
        b=Ppq3CJmGuTh9roU+hKK7uMdfAhMLQkc+A8dUwlD238z9zAcDijvrtKMBs/L6fHolOV
         UBIJbEfQFph5WndN/eBKarOyIPLQOB9RkTQ8o7vUjkPi5zJo37PosGoF7IEZdeKEcvAP
         YYDSEnMN8TPAdFO/2Ky/Me4KuYEzkPVaADQ/LIzZpnhw9yotevGJxydFRAMUwXh+oz24
         DQnuYM/ZmaDuxESKPEsnjmA7zn1xQ14euy88wGUiwYv69Q4PTJ4um7RKGd5w0BX7VBKk
         ARKzVzbEtLccrLfhozlmKMca9l2B51aVYGqPPnOSGbrxmy5TiT+48+B+6QFt1JPfTvx7
         hiXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678720976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9j2QtS0izWtlGzja2plumnFtdWtXW9QpAWI+2e46E1w=;
        b=f56p30cgKosF1/uxfDs9S9momNFrUsRJMe4EI6w9wGxOmN5eQVR2SMfdMrwGwTBGwl
         gUzfFi1PreSBFwfwFaTTB3IbeToRsNqM+923UQUsH++IQkuKob3GiiWQ3QYV71TAiJ9w
         PchhJl+vctZOw5Dq+zS7fOJZBCIzkgD2gT9Fw0kBdCYwCBdrCjJJCpeYsbEcBAc7ykif
         DL4YJ45dBXVHOGNkqkMhLPrabibRPMUlYnKhSQB0oH5/JokDXK6DNDFZ7hB5hsW7FBFH
         MVPvPMDfWeFHYsSuNfgpNbauQzsRr/iY1Q1Knm9EMsQmoRX8vtgduD3ommE6N9hbkgYl
         1SCw==
X-Gm-Message-State: AO0yUKUhNScE12871LdGdUNtlOo58Cq2jLSYrrDOe+K6JE6+X3yZDmjm
        CxVtcKoipQu1Mvj8co9hQefI0gaxgiJy2kT2APfFzA==
X-Google-Smtp-Source: AK7set8gePuMGWiDrsPV9lJEidAEgaaYfnXDj6nGhpPG9bKQlQblHGaGIsm9Wv3vk9NSgM9ruJYYzNFKKqY5VtUQB5M=
X-Received: by 2002:a81:ae22:0:b0:541:6fb9:c9c2 with SMTP id
 m34-20020a81ae22000000b005416fb9c9c2mr4757137ywh.2.1678720975603; Mon, 13 Mar
 2023 08:22:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230313080201.2440201-1-tmricht@linux.ibm.com> <20230313080201.2440201-2-tmricht@linux.ibm.com>
In-Reply-To: <20230313080201.2440201-2-tmricht@linux.ibm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 13 Mar 2023 08:22:44 -0700
Message-ID: <CAP-5=fW=xVYzkgQ4vUyzkiK-oQjUQ=hLwcLT6D8VjtVCXH5oSQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] tools/perf/json: Add cache metrics for s390 z16
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, sumanthk@linux.ibm.com, svens@linux.ibm.com,
        gor@linux.ibm.com, hca@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 1:30=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.c=
om> wrote:
>
> Add metrics for s390 z16
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
>  # ./perf stat -M l4rp -- dd if=3D/dev/zero of=3D/dev/null bs=3D10M count=
=3D10K
>  .... dd output deleted
>
>  Performance counter stats for 'dd if=3D/dev/zero of=3D/dev/null bs=3D10M=
 count=3D10K':
>
>                  0      IDCW_OFF_DRAWER_CHIP_HIT         #     0.00 l4rp
>            431,866      L1I_DIR_WRITES
>              2,395      IDCW_OFF_DRAWER_IV
>                  0      ICW_OFF_DRAWER
>                  0      IDCW_OFF_DRAWER_DRAWER_HIT
>              1,437      DCW_OFF_DRAWER
>        425,960,793      L1D_DIR_WRITES
>
>       12.165030699 seconds time elapsed
>
>        0.001037000 seconds user
>       12.162140000 seconds sys
>
>  #
>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Acked-By: Sumanth Korikkar <sumanthk@linux.ibm.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  .../arch/s390/cf_z16/transaction.json         | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/tools/perf/pmu-events/arch/s390/cf_z16/transaction.json b/to=
ols/perf/pmu-events/arch/s390/cf_z16/transaction.json
> index 86bf83b4504e..dde0735a7d22 100644
> --- a/tools/perf/pmu-events/arch/s390/cf_z16/transaction.json
> +++ b/tools/perf/pmu-events/arch/s390/cf_z16/transaction.json
> @@ -18,5 +18,30 @@
>      "BriefDescription": "Level One Miss per 100 Instructions",
>      "MetricName": "l1mp",
>      "MetricExpr": "((L1I_DIR_WRITES + L1D_DIR_WRITES) / INSTRUCTIONS) * =
100"
> +  },
> +  {
> +    "BriefDescription": "Percentage sourced from Level 2 cache",
> +    "MetricName": "l2p",
> +    "MetricExpr": "((DCW_REQ + DCW_REQ_IV + ICW_REQ + ICW_REQ_IV) / (L1I=
_DIR_WRITES + L1D_DIR_WRITES)) * 100"
> +  },
> +  {
> +    "BriefDescription": "Percentage sourced from Level 3 on same chip ca=
che",
> +    "MetricName": "l3p",
> +    "MetricExpr": "((DCW_REQ_CHIP_HIT + DCW_ON_CHIP + DCW_ON_CHIP_IV + D=
CW_ON_CHIP_CHIP_HIT + ICW_REQ_CHIP_HIT + ICW_ON_CHIP + ICW_ON_CHIP_IV + ICW=
_ON_CHIP_CHIP_HIT) / (L1I_DIR_WRITES + L1D_DIR_WRITES)) * 100"
> +  },
> +  {
> +    "BriefDescription": "Percentage sourced from Level 4 Local cache on =
same book",
> +    "MetricName": "l4lp",
> +    "MetricExpr": "((DCW_REQ_DRAWER_HIT + DCW_ON_CHIP_DRAWER_HIT + DCW_O=
N_MODULE + DCW_ON_DRAWER + IDCW_ON_MODULE_IV + IDCW_ON_MODULE_CHIP_HIT + ID=
CW_ON_MODULE_DRAWER_HIT + IDCW_ON_DRAWER_IV + IDCW_ON_DRAWER_CHIP_HIT + IDC=
W_ON_DRAWER_DRAWER_HIT + ICW_REQ_DRAWER_HIT + ICW_ON_CHIP_DRAWER_HIT + ICW_=
ON_MODULE + ICW_ON_DRAWER) / (L1I_DIR_WRITES + L1D_DIR_WRITES)) * 100"
> +  },
> +  {
> +    "BriefDescription": "Percentage sourced from Level 4 Remote cache on=
 different book",
> +    "MetricName": "l4rp",
> +    "MetricExpr": "((DCW_OFF_DRAWER + IDCW_OFF_DRAWER_IV + IDCW_OFF_DRAW=
ER_CHIP_HIT + IDCW_OFF_DRAWER_DRAWER_HIT + ICW_OFF_DRAWER) / (L1I_DIR_WRITE=
S + L1D_DIR_WRITES)) * 100"
> +  },
> +  {
> +    "BriefDescription": "Percentage sourced from memory",
> +    "MetricName": "memp",
> +    "MetricExpr": "((DCW_ON_CHIP_MEMORY + DCW_ON_MODULE_MEMORY + DCW_ON_=
DRAWER_MEMORY + DCW_OFF_DRAWER_MEMORY + ICW_ON_CHIP_MEMORY + ICW_ON_MODULE_=
MEMORY + ICW_ON_DRAWER_MEMORY + ICW_OFF_DRAWER_MEMORY) / (L1I_DIR_WRITES + =
L1D_DIR_WRITES)) * 100"
>    }
>  ]
> --
> 2.39.1
>
