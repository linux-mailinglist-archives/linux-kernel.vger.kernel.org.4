Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 835126FAC01
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 13:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235552AbjEHLTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 07:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235547AbjEHLTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 07:19:40 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 838B237C6D;
        Mon,  8 May 2023 04:19:37 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R241e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0Vi4aMn6_1683544771;
Received: from 30.221.149.87(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0Vi4aMn6_1683544771)
          by smtp.aliyun-inc.com;
          Mon, 08 May 2023 19:19:32 +0800
Message-ID: <fe51aeda-bfc5-eae4-bfcc-eb15655a7bea@linux.alibaba.com>
Date:   Mon, 8 May 2023 19:19:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v2 0/5] Add JSON metrics for arm CMN and Yitian710 DDR
To:     Ian Rogers <irogers@google.com>
Cc:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>
References: <1682329456-19418-1-git-send-email-renyu.zj@linux.alibaba.com>
 <CAP-5=fX1E_qZwmch-gKcarLGkWwmxZj9dM2XuQKrBLeDRfqg7Q@mail.gmail.com>
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
In-Reply-To: <CAP-5=fX1E_qZwmch-gKcarLGkWwmxZj9dM2XuQKrBLeDRfqg7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.7 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/4/30 上午5:01, Ian Rogers 写道:
> On Mon, Apr 24, 2023 at 2:44 AM Jing Zhang <renyu.zj@linux.alibaba.com> wrote:
>>
>> Changes since RFC:
>> - Refact arm-cmn PMU identifier.
>> - Not add arm-cmn PMU aliasing currently because it's Eventcode is
>>   difficult to define.
>> - Rename ali_drw PMU identifier and Unit name.
>> - Divide ali_drw PMU metric and aliasing into two patches.
>>
>> Add an identifier sysfs file for the yitian710 SoC DDR and arm CMN to
>> allow userspace to identify the specific implementation of the device,
>> so that the perf tool can match the corresponding uncore events and
>> metrics through the identifier. Then added several general CMN700 metrics
>> and yitian710 soc DDR metrics.
>>
>> $perf list:
>> ...
>> ali_drw:
>>   hif_rmw
>>        [A Read-Modify-Write Op at HIF interface. 64B. Unit: ali_drw]
>>   hif_hi_pri_rd
>>        [A high priority Read at HIF interface. 64B. Unit: ali_drw]
>>   hif_rd
>>        [A Read Op at HIF interface. 64B. Unit: ali_drw]
>>   hif_rd_or_wr
>>        [A Write or Read Op at HIF interface. 64B. Unit: ali_drw]
>>   hif_wr
>>        [A Write Op at HIF interface. 64B. Unit: ali_drw]
>> ...
>>
>> $perf stat -M ddr_read_bandwidth.all ./test
>>
>> Performance counter stats for 'system wide':
>>
>>             38,150      hif_rd        #  2.4 MB/s  ddr_read_bandwidth.all
>>      1,000,957,941 ns   duration_time
>>
>>        1.000957941 seconds time elapsed
>>
>> Jing Zhang (5):
>>   driver/perf: Add identifier sysfs file for CMN
>>   perf vendor events: Add JSON metrics for CMN-700
>>   driver/perf: Add identifier sysfs file for Yitian 710 DDR
>>   perf jevents: Add support for Yitian 710 DDR PMU aliasing
>>   perf vendor events: Add JSON metrics for Yitian 710 DDR
> 
> The perf tool changes all make sense. John Garry is more of an expert
> on the ARM part of this than me though.
> Acked-by: Ian Rogers <irogers@google.com>
> 

Thanks Ian!
