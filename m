Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D003C6CF7AA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 01:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbjC2XsL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 29 Mar 2023 19:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjC2XsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 19:48:07 -0400
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6AA40D3;
        Wed, 29 Mar 2023 16:48:06 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id o32so9855373wms.1;
        Wed, 29 Mar 2023 16:48:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680133685; x=1682725685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ctdAn3TPM+vvdeJtZGNCNvHS+kSCvbPyFtr6LjG6+Aw=;
        b=EVzN7mFXUkO8Hz/p9NAEg/Zn5RVmhawQgf8z9kT/CJI9A3ZpPA5cdcwW7c6czEIW2Y
         b71VCMsEZAoYfTpVhXfmMPPeaiT6YWfSK72QZkipqx/mwKgHuz5mdInOcg/TP7aAJpE2
         GY94jQVfRCsX1iVlW2E58eR8kjcy3dZ91fXLheXvdq+lVIauMSgg3N20208+5dgDVxHn
         vVBYPKOGeQVYMMPEuUJLONAteqZC+cJwb61mKlEg3HWNxMTKxnc0Y4vHEC35wScr9ojP
         oGLML1f091/OxQJtyCouv1cQcvqy1f7H7PV7B5ai9FPBlFUnHkFYtS45PGi9GZL1+27e
         vkBg==
X-Gm-Message-State: AAQBX9cQvXzs5QSum5cPGT/1jrbMWuNbqIUsy1NwKAYCkooifTrmFfwj
        lJ9RxwA31SVfeJPxD9neMPKLa7oesznoZ1O9/R4=
X-Google-Smtp-Source: AKy350aJytfdzHPKv36QTRP+AsUSLLUPF0uZh8sH5X/cvbnwh0AJ6pZquc/una80jBbRVg+Lma2XRLoMK0ZywE2Q43o=
X-Received: by 2002:a1c:7405:0:b0:3ef:62cd:1eb with SMTP id
 p5-20020a1c7405000000b003ef62cd01ebmr12986698wmc.7.1680133685137; Wed, 29 Mar
 2023 16:48:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230327130851.1565-1-ravi.bangoria@amd.com> <CAM9d7ciQLXAcVwFJWeJDHwkwUQ-rnHvdetYsQn7w83kkOsFKWg@mail.gmail.com>
 <00f1954f-cf55-d954-5dc6-0da95f8ea308@amd.com>
In-Reply-To: <00f1954f-cf55-d954-5dc6-0da95f8ea308@amd.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 29 Mar 2023 16:47:52 -0700
Message-ID: <CAM9d7cgHL=aXffUtu7CSNdfsVnDoO1cEzBSSpdYVQh9ZrbL-zQ@mail.gmail.com>
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

On Wed, Mar 29, 2023 at 2:45 AM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>
> Hi Namhyung,
>
> >> @@ -716,25 +748,19 @@ static void perf_ibs_get_mem_lvl(union ibs_op_data2 *op_data2,
> >>          * DcMiss, L2Miss, DataSrc, DcMissLat etc. are all invalid for Uncached
> >>          * memory accesses. So, check DcUcMemAcc bit early.
> >>          */
> >> -       if (op_data3->dc_uc_mem_acc && ibs_data_src != IBS_DATA_SRC_EXT_IO) {
> >> -               data_src->mem_lvl = PERF_MEM_LVL_UNC | PERF_MEM_LVL_HIT;
> >> -               return;
> >> -       }
> >> +       if (op_data3->dc_uc_mem_acc && ibs_data_src != IBS_DATA_SRC_EXT_IO)
> >> +               return L(UNC);
> >
> > Hmm.. it seems we don't have PERF_MEM_LVLNUM_UNC.
>
> Right. Is it worth to introduce one?

I think MEM_LVLNUM should express every memory level in MEM_LVL.

>
> On a side note, I came to know that IBS OpData2[RmtNode] is not applicable
> when DataSrc=7 (I/O). So, I need to respin this patch with that change.
>
> [...]
>
> >>  check_mab:
> >> @@ -830,12 +810,11 @@ static void perf_ibs_get_mem_lvl(union ibs_op_data2 *op_data2,
> >>          * DataSrc simultaneously. Prioritize DataSrc over MAB, i.e. set
> >>          * MAB only when IBS fails to provide DataSrc.
> >>          */
> >> -       if (op_data3->dc_miss_no_mab_alloc) {
> >> -               data_src->mem_lvl = PERF_MEM_LVL_LFB | PERF_MEM_LVL_HIT;
> >> -               return;
> >> -       }
> >> +       if (op_data3->dc_miss_no_mab_alloc)
> >> +               return L(LFB) | LN(LFB);
> >>
> >>         data_src->mem_lvl = PERF_MEM_LVL_NA;
> >> +       return 0;
> >
> > Wouldn't it be 'return L(NA) | LN(NA);' ?
>
> IBS has no instruction type filtering, i.e. it tags whatever instruction it
> sees at overflow. When IBS tags non-load/store instruction, data_src->val is
> set to PERF_MEM_NA, which does not initialize mem_lvl_num (Shall we change
> that?). If I set both LVL_NA and LVL_NUM_NA for load/store with no DataSrc
> info, perf mem output becomes funny:

Probably worth changing PERF_MEM_NA.

>
>   $ sudo ./perf mem report -F sample,mem --stdio
>   #      Samples  Memory access
>   # ............  .......................................
>   #
>             1914  N/A                   <====== Non-LS
>              905  L1 or L1 hit
>               19  L3 or L3 hit
>               16  L2 or L2 hit
>                6  N/A or N/A hit        <====== LS with no DataSrc info
>                6  Local RAM or RAM hit
>                4  Remote node, same socket RAM hit
>                3  Remote core, same node Any cache hit
>                2  Remote node, same socket Any cache hit

Maybe that's better to differentiate them :)

>
> Also, L(NA) is PERF_MEM_LVL_NA | PERF_MEM_LVL_HIT. If I just return L(NA),
> perf tools shows it as "N/A hit".
>
> So, until tool code gets refactored, setting mem_lvl = NA here is hiding
> tool's dumbness :(. Maybe I should refactor perf_mem__snp_scnprintf() as
> part of this patchset.

I think we can change the tool independently - preferring MEM_LVLNUM
if present but you might want to add an option to override.
Given IBS didn't set it so far, the output would remain mostly the same.

Thanks,
Namhyung
