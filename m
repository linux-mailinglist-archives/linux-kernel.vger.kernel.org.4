Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C892E6C6B49
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 15:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbjCWOlq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 23 Mar 2023 10:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbjCWOlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 10:41:42 -0400
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA7A21974
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 07:41:40 -0700 (PDT)
Received: by mail-io1-f43.google.com with SMTP id e13so2011873ioc.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 07:41:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679582500; x=1682174500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PVm5q8HuclEyyvOhPX3XSQPKtthp1xJpPiEGMBq7SX8=;
        b=gzZu5e/ikoNfecBDpgbdbF2LAarlG01715+MiBnKMaUT6dM57g+A0Ox1TrOepRMKAc
         ocj8RY4xD9hWSmlxHgE1vIod7GWG+zhNFxZ/qcx7WvY6tqICBb3qS2rNAjEnmKb6gHeS
         sDPgwIMDeTvZYrz8gQD6i1fhEPk0TlIhgx+KZH6mM72Pi/I/RcKLLR8PH3KPCZdpsVOT
         QcZx9jt9WvfTHwrzYlro3wHdabdPlRvbMgXAPQMRe+nzkz/kLAAd5ARHgbL/sHtL9Lam
         ym48cV72Yx2E5rmQKDGvtKeVPVBM6RAPJK1GDTIzeo/y2xEoNg/hzgXqFrAJErePKvFt
         QiEw==
X-Gm-Message-State: AO0yUKV2bU6RI0PDf/nXaXIv1PnUYbZ0EYof8MySHJYxKT1KBefppO0W
        NpLOtE8NV6VR/3LiDPY6l6FFttJCRxmdUPAMTSk=
X-Google-Smtp-Source: AK7set9Vd2a7p0K5nLql5VKB5AcudG9OoJjcqlL6PMc8ce+ldXWF5IsEosh/ajSjAX8H2cRUxHj9YBpNz3jT9xNZGGU=
X-Received: by 2002:a6b:e60a:0:b0:74c:7e93:74f6 with SMTP id
 g10-20020a6be60a000000b0074c7e9374f6mr7376338ioh.5.1679582500004; Thu, 23 Mar
 2023 07:41:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230311000642.1270971-1-namhyung@kernel.org> <2154046a-2081-606d-a1ea-33fd2d48cce7@amd.com>
 <CAM9d7chDaKn57UT9D+BeZBwAQ3Mo4bVgJpign4O0De=9sFsu=w@mail.gmail.com> <49de2976-6e8e-0987-b423-ad65ae3bd148@amd.com>
In-Reply-To: <49de2976-6e8e-0987-b423-ad65ae3bd148@amd.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 23 Mar 2023 07:41:28 -0700
Message-ID: <CAM9d7cj1oBN3o2Mf--7QpE0Qj+4RzDSX+N2RvG5_hTLQo1rTjg@mail.gmail.com>
Subject: Re: [PATCH] perf/x86/ibs: Set data_src.mem_lvl_num as well
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>
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

On Thu, Mar 23, 2023 at 7:11 AM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>
> Hi Namhyung,
>
> >>> @@ -748,12 +750,14 @@ static void perf_ibs_get_mem_lvl(union ibs_op_data2 *op_data2,
> >>>       if (ibs_caps & IBS_CAPS_ZEN4) {
> >>>               if (ibs_data_src == IBS_DATA_SRC_EXT_LOC_CACHE) {
> >>>                       data_src->mem_lvl = PERF_MEM_LVL_L3 | PERF_MEM_LVL_HIT;
> >>> +                     data_src->mem_lvl_num = PERF_MEM_LVLNUM_L3;
> >>>                       return;
> >>>               }
> >>>       } else {
> >>>               if (ibs_data_src == IBS_DATA_SRC_LOC_CACHE) {
> >>>                       data_src->mem_lvl = PERF_MEM_LVL_L3 | PERF_MEM_LVL_REM_CCE1 |
> >>>                                           PERF_MEM_LVL_HIT;
> >>> +                     data_src->mem_lvl_num = PERF_MEM_LVLNUM_L3;
> >>
> >> mem_lvl_num does not have option to set multiple sources. Setting just
> >> PERF_MEM_LVLNUM_L3 is bit misleading here. Documentation (PPR 55898 Rev
> >> 0.70 - Oct 14, 2022) says:
> >>
> >>  "data returned from shared L3, other L2 on same CCX or other core's
> >>   cache trough same node."
> >>
> >> As per my knowledge, "shared L3" and "other L2 on same CCX" has similar
> >> latency. But request need to go through DF for "other core's cache trough
> >> same node" which incurs higher latency. Thus, setting both is important.
> >> This was one of the reason to not use mem_lvl_num in IBS code.
> >
> > I suspect it's a quality issue for CPUs prior to Zen4 not to identify
> > data source precisely.  How about setting LVLNUM_ANY_CACHE then?
>
> Ok. Although, ANY_CACHE is mostly clueless, adding HOPS_0 will make it
> more consumable. There are many other places where this patch needs to
> set mem_remote and mem_hops. Also, these changes will result in too many
> assignment operations. So, I think IBS code should switch to using
> PERF_MEM_S() macro. Do you mind if I send v2 with all those changes?

Sounds good!

>
> >
> >>
> >> 2nd reason was, perf c2c (c2c_decode_stats()) does not use mem_lvl_num.
> >
> > Maybe we can change that.  It'd be easy as long as they provide
> > the same information.  IOW mem_lvl = mem_lvl_num + remote + snoop.
> >
> >>
> >> 3rd reason was, perf mem sorting logic (sort__lvl_cmp()) does not consider
> >> mem_lvl_num.
> >
> > Likewise.
> >
> >>
> >> 4th one was, if I set both mem_lvl and mem_lvl_num, like what other archs
> >> do, `perf mem report` prints both, which is kind of ugly:
> >>
> >>           464029  N/A
> >>           340728  L1 or L1 hit
> >>             8312  LFB/MAB or LFB/MAB hit
> >>             7901  L2 or L2 hit
> >>              123  L3 or Remote Cache (1 hop) or L3 hit
> >>
> >> Without mem_lvl_num it's much cleaner:
> >>
> >>           330057  N/A
> >>           229646  L1 hit
> >>             5842  L2 hit
> >>             5726  LFB/MAB hit
> >>               78  L3 or Remote Cache (1 hop) hit
> >
> > Agreed.  It doesn't need to repeat the same information.
> >
> >>
> >> I think we should clean this before applying this patch? Other option is
> >> to add bpf filter support for mem_lvl. What do you think?
> >
> > I still prefer using mem_lvl_num as I think it's the way to go,
> > but I'm open for change.
>
> Sure. 2nd, 3rd and 4th are all tool side improvements. Although it would
> be good to fix those, let me post v2 of this patch for now?

Sure, please go ahead.

Thanks,
Namhyung
