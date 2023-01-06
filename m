Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C408665FEFE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 11:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbjAFKer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 05:34:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjAFKep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 05:34:45 -0500
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB9D69B37;
        Fri,  6 Jan 2023 02:34:43 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R801e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0VZ--e1q_1673001277;
Received: from 30.221.147.58(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VZ--e1q_1673001277)
          by smtp.aliyun-inc.com;
          Fri, 06 Jan 2023 18:34:39 +0800
Message-ID: <7c85c49d-ce6c-cadb-dea3-56dbfa43086c@linux.alibaba.com>
Date:   Fri, 6 Jan 2023 18:34:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
Subject: Re: [PATCH v5 1/6] perf vendor events arm64: Add topdown L1 metrics
 for neoverse-n2
To:     John Garry <john.g.garry@oracle.com>,
        Ian Rogers <irogers@google.com>
Cc:     Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Zhuo Song <zhuo.song@linux.alibaba.com>
References: <1672745976-2800146-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1672745976-2800146-2-git-send-email-renyu.zj@linux.alibaba.com>
 <5c5716e5-b2ff-67cd-b608-4eeffa7e04bc@oracle.com>
 <1f3d53cb-4160-e29d-3934-d6a488d9fd49@linux.alibaba.com>
 <7aa225df-af25-a6be-9bef-c965488ba43a@oracle.com>
 <d4d132d9-1513-6a4e-981f-aa4bc4ebbcbb@linux.alibaba.com>
 <00bf227a-75ce-c63c-c740-89b8d2b27e1c@oracle.com>
 <CAP-5=fVGmjFOZqOk0E1bcqeTHcJhEmoA-vrKcHLOs4B_ythT1g@mail.gmail.com>
 <6971b848-2754-6909-d36b-ea80fe157e95@oracle.com>
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
In-Reply-To: <6971b848-2754-6909-d36b-ea80fe157e95@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-12.8 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/1/6 下午6:14, John Garry 写道:
> On 05/01/2023 21:13, Ian Rogers wrote:
>>>> This may be a feasible idea. The value of slots comes from the register PMMIR_EL1, which I can read in
>>>> /sys/bus/event_source/device/armv8_pmuv3_*/caps/slots. But how do I replace the slots in MetricExpr with the
>>>> read slots values? Currently I understand that parameters in metricExpr only support events and constants.
>>>>
>>> Maybe during runtime we could create a pseudo metric/event for SLOT.
>> For Intel we do this by just having a different constant for each
>> architecture. It is fairly easy to add a new "literal", so you could
>> add a #slots in expr__get_literal:
>> https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/expr.c?h=perf*core*n407__;LyM!!ACWV5N9M2RV99hQ!IHcZFuFaLdQDQvVOnHVlbbME2S4aW8GohWUkydlejpi7ifFz61r7RutGXReRt0d88X_vDfkTySCiuD2PqOA$  Populating it would be the challenge 😄

Yes! I was thinking the same as you, I found this method from the SMT_on variable in icl_metrics.json, then I
tried it and it worked, so excited!

> 
> Thanks for the pointer. I think that the challenge in populating it really comes down to whether we would really want to make this generic.
> 
> I suppose that for arm64 we could have a method which accesses this PMMIR_EL1 register, while for other archs we could have a weak function which just returns NAN. If other archs want to use this key expr, they can add their own method.
> 

Now I have to use this method, because I just found out that neoverse-n2 has been changed to neoverse-n2-v2,
merging n2 and v2. The slots of n2 are 5, and the slots of v2 are 8. I will release the v6 patch and put the
metric in the sbsa.json file. The metrics in sbsa.json is only applicable to arm64, so even if x86 cannot get
the slots value, there will be no conflict.


> Out of curiosity, do you know if x86 has such a capability to get this slot info from HW?
> 

