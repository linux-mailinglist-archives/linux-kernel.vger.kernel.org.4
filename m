Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 633A06CD277
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 09:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjC2HFk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 29 Mar 2023 03:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjC2HFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 03:05:38 -0400
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA5526BA;
        Wed, 29 Mar 2023 00:05:35 -0700 (PDT)
Received: by mail-wm1-f48.google.com with SMTP id l15-20020a05600c4f0f00b003ef6d684102so5470996wmq.3;
        Wed, 29 Mar 2023 00:05:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680073533; x=1682665533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=omucdmTQdQSGX7qU7S+u0yn8Tw4QFFaw0IiuFA06/I4=;
        b=fuG63mjGPtjpBgGxIjKSr48+qlzV+ZZLhNZH5JcIIWKj4ViB2/Tg/GwO6lzWDcGC57
         bVyjxkhLw7K7Ja3pI57BQd6bAMFgSJ/S1VvWUScI4Xht3jOF1flyfAIyfeEw2fpG3yo1
         4D6HFwjAhElKyY4NLouZyU3cJnrhhtO0OaQJGuQ6lNyA4HBq0ZXbeU7N95DsMr34FLNh
         FKbGRlfWD9+SlW6GNo1u0kCuYV8Q0CHXHIShOCBfXrd04jpGlx+m1P0FMRTz2NTacTG9
         M2sVVz7aCbxf9qFEmS0RLkqFUb55HOHsbXK/1cBvQd6yLNBnx5JUnKRa0eF2r/kIBu+R
         eXYA==
X-Gm-Message-State: AO0yUKWB1P2Fd4GTIsTAuai4KNb6IZei1jf/+1vlNxfncFD+TCr0u0JT
        T+yluYbqNFyl325NKAcRgukEQdlb0y9X6pKmU7Ketvtn
X-Google-Smtp-Source: AK7set/vANdIRRDsYUX4u4IBqzr0DYi+8+DNNcXGtzYiMzf48KJDvVpXzhqE/XavauWojosLeYkUjP1YaFYv0T19afk=
X-Received: by 2002:a05:600c:ad5:b0:3ee:5519:fae1 with SMTP id
 c21-20020a05600c0ad500b003ee5519fae1mr14261836wmr.12.1680073533193; Wed, 29
 Mar 2023 00:05:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230327130851.1565-1-ravi.bangoria@amd.com>
In-Reply-To: <20230327130851.1565-1-ravi.bangoria@amd.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 29 Mar 2023 00:05:21 -0700
Message-ID: <CAM9d7ciQLXAcVwFJWeJDHwkwUQ-rnHvdetYsQn7w83kkOsFKWg@mail.gmail.com>
Subject: Re: [PATCH v2] perf/x86/ibs: Set mem_lvl_num, mem_remote and mem_hops
 for data_src
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     peterz@infradead.org, mingo@kernel.org, acme@kernel.org,
        eranian@google.com, kan.liang@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, sandipan.das@amd.com,
        ananth.narayan@amd.com, santosh.shukla@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ravi,

On Mon, Mar 27, 2023 at 6:09 AM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>
> From: Namhyung Kim <namhyung@kernel.org>
>
> Kernel IBS driver wasn't using new PERF_MEM_* APIs due to few of its
> limitations. Mainly:
>
> - mem_lvl_num doesn't allow setting multiple sources whereas old API
>   allows it. Setting multiple data sources is useful because IBS on
>   pre-zen4 uarch doesn't provide fine granular DataSrc details (there
>   is only one such DataSrc(2h) though).
> - perf mem sorting logic (sort__lvl_cmp()) ignores mem_lvl_num. perf
>   c2c (c2c_decode_stats()) does not use mem_lvl_num at all. perf mem
>   prints mem_lvl and mem_lvl_num both if both are set, which is ugly.
>
> 1st one can be handled by using ANY_CACHE with HOPS_0. 2nd one is
> purely perf tool specific issue and should be fixed separately.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> ---
> v1: https://lore.kernel.org/r/20230311000642.1270971-1-namhyung@kernel.org
> v1->v2:
> - In addition to setting new API fields, convert all individual field
>   assignments to compile time wrapper macros built using PERF_MEM_S().
>   Also convert DataSrc conditional code to array lookups.
>
>  arch/x86/events/amd/ibs.c | 155 +++++++++++++++++---------------------
>  1 file changed, 68 insertions(+), 87 deletions(-)
>
> diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
> index 64582954b5f6..b46e0b725fe5 100644
> --- a/arch/x86/events/amd/ibs.c
> +++ b/arch/x86/events/amd/ibs.c
> @@ -703,9 +703,41 @@ static u8 perf_ibs_data_src(union ibs_op_data2 *op_data2)
>         return op_data2->data_src_lo;
>  }
>
> -static void perf_ibs_get_mem_lvl(union ibs_op_data2 *op_data2,
> -                                union ibs_op_data3 *op_data3,
> -                                struct perf_sample_data *data)
> +#define        L(x)            (PERF_MEM_S(LVL, x) | PERF_MEM_S(LVL, HIT))
> +#define        LN(x)           PERF_MEM_S(LVLNUM, x)
> +#define        REM             PERF_MEM_S(REMOTE, REMOTE)
> +#define        HOPS(x)         PERF_MEM_S(HOPS, x)
> +
> +static u64 g_data_src[8] = {
> +       [IBS_DATA_SRC_LOC_CACHE]          = L(L3) | L(REM_CCE1) | LN(ANY_CACHE) | HOPS(0),
> +       [IBS_DATA_SRC_DRAM]               = L(LOC_RAM) | LN(RAM),
> +       [IBS_DATA_SRC_REM_CACHE]          = L(REM_CCE2) | LN(ANY_CACHE) | REM | HOPS(1),
> +       [IBS_DATA_SRC_IO]                 = L(IO) | LN(IO),
> +};
> +
> +#define RMT_NODE_BITS                  ((1 << IBS_DATA_SRC_DRAM) | \
> +                                        (1 << IBS_DATA_SRC_IO))
> +#define RMT_NODE_APPLICABLE(x)         (RMT_NODE_BITS & (1 << x))
> +
> +static u64 g_zen4_data_src[32] = {
> +       [IBS_DATA_SRC_EXT_LOC_CACHE]      = L(L3) | LN(L3),
> +       [IBS_DATA_SRC_EXT_NEAR_CCX_CACHE] = L(REM_CCE1) | LN(ANY_CACHE) | REM | HOPS(0),
> +       [IBS_DATA_SRC_EXT_DRAM]           = L(LOC_RAM) | LN(RAM),
> +       [IBS_DATA_SRC_EXT_FAR_CCX_CACHE]  = L(REM_CCE2) | LN(ANY_CACHE) | REM | HOPS(1),
> +       [IBS_DATA_SRC_EXT_PMEM]           = LN(PMEM),
> +       [IBS_DATA_SRC_EXT_IO]             = L(IO) | LN(IO),
> +       [IBS_DATA_SRC_EXT_EXT_MEM]        = LN(CXL),
> +};
> +
> +#define ZEN4_RMT_NODE_BITS             ((1 << IBS_DATA_SRC_EXT_DRAM) | \
> +                                        (1 << IBS_DATA_SRC_EXT_PMEM) | \
> +                                        (1 << IBS_DATA_SRC_EXT_IO) |\
> +                                        (1 << IBS_DATA_SRC_EXT_EXT_MEM))
> +#define ZEN4_RMT_NODE_APPLICABLE(x)    (RMT_NODE_BITS & (1 << x))
> +
> +static __u64 perf_ibs_get_mem_lvl(union ibs_op_data2 *op_data2,
> +                                 union ibs_op_data3 *op_data3,
> +                                 struct perf_sample_data *data)
>  {
>         union perf_mem_data_src *data_src = &data->data_src;
>         u8 ibs_data_src = perf_ibs_data_src(op_data2);
> @@ -716,25 +748,19 @@ static void perf_ibs_get_mem_lvl(union ibs_op_data2 *op_data2,
>          * DcMiss, L2Miss, DataSrc, DcMissLat etc. are all invalid for Uncached
>          * memory accesses. So, check DcUcMemAcc bit early.
>          */
> -       if (op_data3->dc_uc_mem_acc && ibs_data_src != IBS_DATA_SRC_EXT_IO) {
> -               data_src->mem_lvl = PERF_MEM_LVL_UNC | PERF_MEM_LVL_HIT;
> -               return;
> -       }
> +       if (op_data3->dc_uc_mem_acc && ibs_data_src != IBS_DATA_SRC_EXT_IO)
> +               return L(UNC);

Hmm.. it seems we don't have PERF_MEM_LVLNUM_UNC.

>
>         /* L1 Hit */
> -       if (op_data3->dc_miss == 0) {
> -               data_src->mem_lvl = PERF_MEM_LVL_L1 | PERF_MEM_LVL_HIT;
> -               return;
> -       }
> +       if (op_data3->dc_miss == 0)
> +               return L(L1) | LN(L1);
>
>         /* L2 Hit */
>         if (op_data3->l2_miss == 0) {
>                 /* Erratum #1293 */
>                 if (boot_cpu_data.x86 != 0x19 || boot_cpu_data.x86_model > 0xF ||
> -                   !(op_data3->sw_pf || op_data3->dc_miss_no_mab_alloc)) {
> -                       data_src->mem_lvl = PERF_MEM_LVL_L2 | PERF_MEM_LVL_HIT;
> -                       return;
> -               }
> +                   !(op_data3->sw_pf || op_data3->dc_miss_no_mab_alloc))
> +                       return L(L2) | LN(L2);
>         }
>
>         /*
> @@ -744,82 +770,36 @@ static void perf_ibs_get_mem_lvl(union ibs_op_data2 *op_data2,
>         if (data_src->mem_op != PERF_MEM_OP_LOAD)
>                 goto check_mab;
>
> -       /* L3 Hit */
>         if (ibs_caps & IBS_CAPS_ZEN4) {
> -               if (ibs_data_src == IBS_DATA_SRC_EXT_LOC_CACHE) {
> -                       data_src->mem_lvl = PERF_MEM_LVL_L3 | PERF_MEM_LVL_HIT;
> -                       return;
> -               }
> -       } else {
> -               if (ibs_data_src == IBS_DATA_SRC_LOC_CACHE) {
> -                       data_src->mem_lvl = PERF_MEM_LVL_L3 | PERF_MEM_LVL_REM_CCE1 |
> -                                           PERF_MEM_LVL_HIT;
> -                       return;
> -               }
> -       }
> +               u64 val = g_zen4_data_src[ibs_data_src];
>
> -       /* A peer cache in a near CCX */
> -       if (ibs_caps & IBS_CAPS_ZEN4 &&
> -           ibs_data_src == IBS_DATA_SRC_EXT_NEAR_CCX_CACHE) {
> -               data_src->mem_lvl = PERF_MEM_LVL_REM_CCE1 | PERF_MEM_LVL_HIT;
> -               return;
> -       }
> +               if (!val)
> +                       goto check_mab;
>
> -       /* A peer cache in a far CCX */
> -       if (ibs_caps & IBS_CAPS_ZEN4) {
> -               if (ibs_data_src == IBS_DATA_SRC_EXT_FAR_CCX_CACHE) {
> -                       data_src->mem_lvl = PERF_MEM_LVL_REM_CCE2 | PERF_MEM_LVL_HIT;
> -                       return;
> +               /* HOPS_1 because IBS doesn't provide remote socket detail */
> +               if (op_data2->rmt_node && ZEN4_RMT_NODE_APPLICABLE(ibs_data_src)) {
> +                       if (ibs_data_src == IBS_DATA_SRC_EXT_DRAM)
> +                               val = L(REM_RAM1) | LN(RAM) | REM | HOPS(1);
> +                       else
> +                               val |= REM | HOPS(1);
>                 }
> -       } else {
> -               if (ibs_data_src == IBS_DATA_SRC_REM_CACHE) {
> -                       data_src->mem_lvl = PERF_MEM_LVL_REM_CCE2 | PERF_MEM_LVL_HIT;
> -                       return;
> -               }
> -       }
>
> -       /* DRAM */
> -       if (ibs_data_src == IBS_DATA_SRC_EXT_DRAM) {
> -               if (op_data2->rmt_node == 0)
> -                       data_src->mem_lvl = PERF_MEM_LVL_LOC_RAM | PERF_MEM_LVL_HIT;
> -               else
> -                       data_src->mem_lvl = PERF_MEM_LVL_REM_RAM1 | PERF_MEM_LVL_HIT;
> -               return;
> -       }
> +               return val;
> +       } else {
> +               u64 val = g_data_src[ibs_data_src];
>
> -       /* PMEM */
> -       if (ibs_caps & IBS_CAPS_ZEN4 && ibs_data_src == IBS_DATA_SRC_EXT_PMEM) {
> -               data_src->mem_lvl_num = PERF_MEM_LVLNUM_PMEM;
> -               if (op_data2->rmt_node) {
> -                       data_src->mem_remote = PERF_MEM_REMOTE_REMOTE;
> -                       /* IBS doesn't provide Remote socket detail */
> -                       data_src->mem_hops = PERF_MEM_HOPS_1;
> -               }
> -               return;
> -       }
> +               if (!val)
> +                       goto check_mab;
>
> -       /* Extension Memory */
> -       if (ibs_caps & IBS_CAPS_ZEN4 &&
> -           ibs_data_src == IBS_DATA_SRC_EXT_EXT_MEM) {
> -               data_src->mem_lvl_num = PERF_MEM_LVLNUM_CXL;
> -               if (op_data2->rmt_node) {
> -                       data_src->mem_remote = PERF_MEM_REMOTE_REMOTE;
> -                       /* IBS doesn't provide Remote socket detail */
> -                       data_src->mem_hops = PERF_MEM_HOPS_1;
> +               /* HOPS_1 because IBS doesn't provide remote socket detail */
> +               if (op_data2->rmt_node && RMT_NODE_APPLICABLE(ibs_data_src)) {
> +                       if (ibs_data_src == IBS_DATA_SRC_DRAM)
> +                               val = L(REM_RAM1) | LN(RAM) | REM | HOPS(1);
> +                       else
> +                               val |= REM | HOPS(1);
>                 }
> -               return;
> -       }
>
> -       /* IO */
> -       if (ibs_data_src == IBS_DATA_SRC_EXT_IO) {
> -               data_src->mem_lvl = PERF_MEM_LVL_IO;
> -               data_src->mem_lvl_num = PERF_MEM_LVLNUM_IO;
> -               if (op_data2->rmt_node) {
> -                       data_src->mem_remote = PERF_MEM_REMOTE_REMOTE;
> -                       /* IBS doesn't provide Remote socket detail */
> -                       data_src->mem_hops = PERF_MEM_HOPS_1;
> -               }
> -               return;
> +               return val;
>         }
>
>  check_mab:
> @@ -830,12 +810,11 @@ static void perf_ibs_get_mem_lvl(union ibs_op_data2 *op_data2,
>          * DataSrc simultaneously. Prioritize DataSrc over MAB, i.e. set
>          * MAB only when IBS fails to provide DataSrc.
>          */
> -       if (op_data3->dc_miss_no_mab_alloc) {
> -               data_src->mem_lvl = PERF_MEM_LVL_LFB | PERF_MEM_LVL_HIT;
> -               return;
> -       }
> +       if (op_data3->dc_miss_no_mab_alloc)
> +               return L(LFB) | LN(LFB);
>
>         data_src->mem_lvl = PERF_MEM_LVL_NA;
> +       return 0;

Wouldn't it be 'return L(NA) | LN(NA);' ?

Thanks,
Namhyung


>  }
>
>  static bool perf_ibs_cache_hit_st_valid(void)
> @@ -925,7 +904,9 @@ static void perf_ibs_get_data_src(struct perf_ibs_data *ibs_data,
>                                   union ibs_op_data2 *op_data2,
>                                   union ibs_op_data3 *op_data3)
>  {
> -       perf_ibs_get_mem_lvl(op_data2, op_data3, data);
> +       union perf_mem_data_src *data_src = &data->data_src;
> +
> +       data_src->val |= perf_ibs_get_mem_lvl(op_data2, op_data3, data);
>         perf_ibs_get_mem_snoop(op_data2, data);
>         perf_ibs_get_tlb_lvl(op_data3, data);
>         perf_ibs_get_mem_lock(op_data3, data);
> --
> 2.39.2
>
