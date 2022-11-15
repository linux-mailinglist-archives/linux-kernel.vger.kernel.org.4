Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E6F629376
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 09:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232870AbiKOInx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 03:43:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236567AbiKOInh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 03:43:37 -0500
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95AF205EA;
        Tue, 15 Nov 2022 00:43:21 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0VUsd9r0_1668501796;
Received: from 30.221.131.168(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VUsd9r0_1668501796)
          by smtp.aliyun-inc.com;
          Tue, 15 Nov 2022 16:43:18 +0800
Message-ID: <f3823c3e-d45e-40ce-1981-e726b4b6be62@linux.alibaba.com>
Date:   Tue, 15 Nov 2022 16:43:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [External] : [RFC PATCH v2 1/6] perf vendor events arm64: Add
 topdown L1 metrics for neoverse-n2
To:     John Garry <john.g.garry@oracle.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Zhuo Song <zhuo.song@linux.alibaba.com>
References: <1667214694-89839-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1668411720-3581-2-git-send-email-renyu.zj@linux.alibaba.com>
 <590ff032-d271-48ee-a4d8-141cc070c335@oracle.com>
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
In-Reply-To: <590ff032-d271-48ee-a4d8-141cc070c335@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/11/14 下午8:59, John Garry 写道:
> On 14/11/2022 07:41, Jing Zhang wrote:
>> The calculation formula of topdown L1 is from the document:
>> https://urldefense.com/v3/__https://documentation-service.arm.com/static/60250c7395978b529036da86?token=__;!!ACWV5N9M2RV99hQ!Ll-Jgvfs0LitTCU-hC6i6BKBVJfhke-pbQq2VoO-gmuSAcglQ3ZqMVMd2r0An_5a3ZDPYmn8zXuCrpUbehwnLHplVQ$  
> 
> So since this is a from "standard" document, did you consider putting these as an arch std event? I think arch std events would work for metrics, like they do for regular events.
> 

I didn't find out how to put the metric as an arch std event, it would be best if you could provide me with an example in the upstream code,
thank you very much.

>>
>> However, due to the wrong count of stall_slot and stall_slot_frontend
>> in neoverse-n2, the real stall_slot and real stall_slot_frontend need
>> to subtract cpu_cycles, so when calculating the topdownL1 metrics,
>> stall_slot and stall_slot_frontend are corrected.
> 
> Is there a reference to this? It would be indeed useful to pass a link to the n2 doc as these metrics are not part of the arm64 arm. At least I assume that they are not there.
> 

You are right, I need to add a doc link. ARM has released the n2 ERRATA document about the incorrect count of stall_slot and stall_slot_frontend,
and provides a workaround to get the correct value.
Link: https://developer.arm.com/documentation/SDEN1982442/1200/?lang=en

>>
>> Since neoverse-n2 does not yet support topdown L2, metricgroups such
>> as Cache, TLB, Branch, InstructionsMix, and PEutilization will be
>> added to further analysis of performance bottlenecks in the following
>> patches.
>>
> 
> 
> Thanks,
> John
Best Regards,
Jing
