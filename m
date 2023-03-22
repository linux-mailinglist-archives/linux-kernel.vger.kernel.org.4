Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D39B6C4FBD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 16:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjCVPyt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 22 Mar 2023 11:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjCVPyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 11:54:46 -0400
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE545CC25
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 08:54:45 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id t129so8664688iof.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 08:54:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679500485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zg1OgSGuxXP6AQWbcWAEYszqeWEdcbfQ7SIm2fyZ1RU=;
        b=w0OIQBDM0y2U5wtHAAbqcMyPyM8M4EXuERPpmLo+xi8Q5jXaoMiv7UMcxNGuqBR+21
         1p2RYmKtaW9n3WhAdBiUdJuW1T3WbbBQNQ5pxmFfH4edotv2IqQAXuIoFjhETs6/yree
         VAKYiMd8UIyX5rS4acYOfup70ppqyB4xPWecimpTO8fuxqF2+ZcH5w5c9tBVKIAwMffY
         qUNo/6BCpaziJgH/ifPSiF28aNXJEgOaUpUOFyvfgN0atal4QrScGk1fsQZhCcSWxNUZ
         IparoIBlM684/CYM29RYkAN3tyMTNDi00T2PwpMbtH1Wo8vJjP9TVz0XODNfE1Ng3oDG
         ARLg==
X-Gm-Message-State: AO0yUKUViyEdtYNZmSMOhst10G6PWCPaGF0YEQD0GvIOMbpEKXAsMJCN
        oKF5S3tArD5xocjzgjWxOihtJfX4xgF+r8AG5ks33y9Q
X-Google-Smtp-Source: AK7set9xywU3jk2K9kRPUjux+cNLCuo67Mo9r9ndoFpia3wUnm6iRsrogf5dr5kIMiB2xs3ha4NhA5c0ZsxfWcTPeK0=
X-Received: by 2002:a5d:8055:0:b0:745:4726:b228 with SMTP id
 b21-20020a5d8055000000b007454726b228mr4113618ior.17.1679500484794; Wed, 22
 Mar 2023 08:54:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230311000642.1270971-1-namhyung@kernel.org> <2154046a-2081-606d-a1ea-33fd2d48cce7@amd.com>
In-Reply-To: <2154046a-2081-606d-a1ea-33fd2d48cce7@amd.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 22 Mar 2023 08:54:33 -0700
Message-ID: <CAM9d7chDaKn57UT9D+BeZBwAQ3Mo4bVgJpign4O0De=9sFsu=w@mail.gmail.com>
Subject: Re: [PATCH] perf/x86/ibs: Set data_src.mem_lvl_num as well
To:     Ravi Bangoria <ravi.bangoria@amd.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
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

Hi Ravi,

On Mon, Mar 20, 2023 at 11:33 PM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>
> Hi Namhyung,
>
> > @@ -748,12 +750,14 @@ static void perf_ibs_get_mem_lvl(union ibs_op_data2 *op_data2,
> >       if (ibs_caps & IBS_CAPS_ZEN4) {
> >               if (ibs_data_src == IBS_DATA_SRC_EXT_LOC_CACHE) {
> >                       data_src->mem_lvl = PERF_MEM_LVL_L3 | PERF_MEM_LVL_HIT;
> > +                     data_src->mem_lvl_num = PERF_MEM_LVLNUM_L3;
> >                       return;
> >               }
> >       } else {
> >               if (ibs_data_src == IBS_DATA_SRC_LOC_CACHE) {
> >                       data_src->mem_lvl = PERF_MEM_LVL_L3 | PERF_MEM_LVL_REM_CCE1 |
> >                                           PERF_MEM_LVL_HIT;
> > +                     data_src->mem_lvl_num = PERF_MEM_LVLNUM_L3;
>
> mem_lvl_num does not have option to set multiple sources. Setting just
> PERF_MEM_LVLNUM_L3 is bit misleading here. Documentation (PPR 55898 Rev
> 0.70 - Oct 14, 2022) says:
>
>  "data returned from shared L3, other L2 on same CCX or other core's
>   cache trough same node."
>
> As per my knowledge, "shared L3" and "other L2 on same CCX" has similar
> latency. But request need to go through DF for "other core's cache trough
> same node" which incurs higher latency. Thus, setting both is important.
> This was one of the reason to not use mem_lvl_num in IBS code.

I suspect it's a quality issue for CPUs prior to Zen4 not to identify
data source precisely.  How about setting LVLNUM_ANY_CACHE then?

>
> 2nd reason was, perf c2c (c2c_decode_stats()) does not use mem_lvl_num.

Maybe we can change that.  It'd be easy as long as they provide
the same information.  IOW mem_lvl = mem_lvl_num + remote + snoop.

>
> 3rd reason was, perf mem sorting logic (sort__lvl_cmp()) does not consider
> mem_lvl_num.

Likewise.

>
> 4th one was, if I set both mem_lvl and mem_lvl_num, like what other archs
> do, `perf mem report` prints both, which is kind of ugly:
>
>           464029  N/A
>           340728  L1 or L1 hit
>             8312  LFB/MAB or LFB/MAB hit
>             7901  L2 or L2 hit
>              123  L3 or Remote Cache (1 hop) or L3 hit
>
> Without mem_lvl_num it's much cleaner:
>
>           330057  N/A
>           229646  L1 hit
>             5842  L2 hit
>             5726  LFB/MAB hit
>               78  L3 or Remote Cache (1 hop) hit

Agreed.  It doesn't need to repeat the same information.

>
> I think we should clean this before applying this patch? Other option is
> to add bpf filter support for mem_lvl. What do you think?

I still prefer using mem_lvl_num as I think it's the way to go,
but I'm open for change.

Peter, what do you think?

Thanks,
Namhyung
