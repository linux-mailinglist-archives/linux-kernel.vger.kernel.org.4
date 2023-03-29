Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5FE56CD8FF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 13:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjC2L7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 07:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjC2L7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 07:59:46 -0400
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DCF4699;
        Wed, 29 Mar 2023 04:59:27 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R561e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0Vewpuqu_1680091161;
Received: from 30.221.149.47(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0Vewpuqu_1680091161)
          by smtp.aliyun-inc.com;
          Wed, 29 Mar 2023 19:59:24 +0800
Message-ID: <1a2f9946-6800-fd58-2e93-8de4aaa0d2c6@linux.alibaba.com>
Date:   Wed, 29 Mar 2023 19:59:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH RFC 0/4] Add JSON metrics for arm CMN and Yitian710 DDR
To:     Ian Rogers <irogers@google.com>
Cc:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Zhuo Song <zhuo.song@linux.alibaba.com>
References: <1679885172-95021-1-git-send-email-renyu.zj@linux.alibaba.com>
 <CAP-5=fVitwxZwjkv0F98gHiYV9GBvmPq6LgcLTccQbogKmMhPA@mail.gmail.com>
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
In-Reply-To: <CAP-5=fVitwxZwjkv0F98gHiYV9GBvmPq6LgcLTccQbogKmMhPA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=ENV_AND_HDR_SPF_MATCH,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/3/28 上午12:51, Ian Rogers 写道:
> On Sun, Mar 26, 2023 at 7:46 PM Jing Zhang <renyu.zj@linux.alibaba.com> wrote:
>>
>> Hi all,
>>
>> I add an identifier sysfs file for the yitian710 SoC DDR and arm CMN to
>> allow userspace to identify the specific implementation of the device,
>> so that the perf tool can match the corresponding uncore events and
>> metrics through the identifier. Then added several general CMN700 metrics
>> and yitian710 soc DDR metrics.
> 
> Thanks!
> 
>> Since the eventid of cmn700 events is different from other events, it
>> can't be specified by "EventCode" or "ConfigCode", so in the cmn.json
>> file of cmn700, no "EventCode" and "ConfigCode" are added for these
>> events. For example, the eventid of "arm_cmn_0/hnf_sf_hit is/":
>> cat /sys/bus/event_source/devices/arm_cmn_0/events/hnf_sf_hit
>> type=0x5,eventid=0x6
> 
> This is done to add descriptions to the events? We can add encodings
> to jevents.py and the event parsing to handle the names eventid and
> type.
> 

Ok, I will try it.

>> In addition, both cmn700 and ddr PMU can count the information in a die,
>> but the same SoC can also be configured with different numbers of dies,
>> so it is dificult to design a general expression to obtain metrics in
>> different dies. The current yitian710 ddr bandwidth metric describes the
>> sum of all dies bandwidth. I would like to ask you, is there any general
>> expression can obtain metrics for die? Add an option to specify die?
> 
> So hopefully the logic for this is getting clearer in the
> perf-tools-next branch. When perf stat runs it will aggregate in a
> number of different ways, if you pass -A it will remove the
> aggregation, but you can also use --per-socket, per-die, .. The
> metrics take the individual counter values, say instructions and
> cycles and produce a metric like IPC. By default all the instruction
> counts are aggregated together, the cycles are aggregated together and
> then the metric produced on the two aggregated values. When -A or
> --per-die are passed, the appropriate amount of aggregation should be
> done then the metric computed multiple times.
> 

Thanks! It is helpful. It solved my problem.

Thanks,
Jing

> Are you asking for a way in a metric to take counts from one die and
> use them in the other's metric? For example, reads on one die are
> writes on the other? This is possible as we have all the counts in the
> tool. I've thought about this in the context of some metrics we have
> for AMD, but there is no support for this in the tool currently.
> 
> Thanks,
> Ian
> 
>> Thanks,
>> Jing
>>
>> Jing Zhang (4):
>>   driver/perf: Add identifier sysfs file for CMN
>>   perf vendor events: Add JSON metrics for cmn700
>>   driver/perf: Add identifier sysfs file for Yitian 710 DDR
>>   perf vendor events: Add JSON metrics for Yitian 710 DDR
>>
>>  drivers/perf/alibaba_uncore_drw_pmu.c              |  27 ++
>>  drivers/perf/arm-cmn.c                             |  43 +++
>>  .../pmu-events/arch/arm64/arm/cmn700/sys/cmn.json  | 188 +++++++++++
>>  .../arch/arm64/arm/cmn700/sys/metrics.json         |  74 ++++
>>  .../arm64/freescale/yitian710/sys/ali_drw.json     | 373 +++++++++++++++++++++
>>  .../arm64/freescale/yitian710/sys/metrics.json     |  20 ++
>>  tools/perf/pmu-events/jevents.py                   |   2 +
>>  7 files changed, 727 insertions(+)
>>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cmn700/sys/cmn.json
>>  create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cmn700/sys/metrics.json
>>  create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/yitian710/sys/ali_drw.json
>>  create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/yitian710/sys/metrics.json
>>
>> --
>> 1.8.3.1
>>
