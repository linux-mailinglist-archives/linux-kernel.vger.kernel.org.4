Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4D36FADAC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 13:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234019AbjEHLgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 07:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236095AbjEHLg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 07:36:26 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A183D214;
        Mon,  8 May 2023 04:35:59 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R751e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0Vi5-Kjt_1683545726;
Received: from 30.221.149.87(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0Vi5-Kjt_1683545726)
          by smtp.aliyun-inc.com;
          Mon, 08 May 2023 19:35:28 +0800
Message-ID: <d81967aa-75b4-dfcc-9f01-26ecea063051@linux.alibaba.com>
Date:   Mon, 8 May 2023 19:35:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v2 3/5] driver/perf: Add identifier sysfs file for Yitian
 710 DDR
To:     John Garry <john.g.garry@oracle.com>
Cc:     James Clark <james.clark@arm.com>,
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
        Zhuo Song <zhuo.song@linux.alibaba.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Will Deacon <will@kernel.org>, Ian Rogers <irogers@google.com>
References: <1682329456-19418-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1682329456-19418-4-git-send-email-renyu.zj@linux.alibaba.com>
 <136984f7-b9a0-721f-3e31-f6ef840b0878@oracle.com>
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
In-Reply-To: <136984f7-b9a0-721f-3e31-f6ef840b0878@oracle.com>
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



在 2023/5/1 下午8:31, John Garry 写道:
> On 24/04/2023 10:44, Jing Zhang wrote:
>> To allow userspace to identify the specific implementation of the device,
>> add an "identifier" sysfs file.
>>
>> The perf tool can match the Yitian 710 DDR metric through the identifier.
>>
>> Signed-off-by: Jing Zhang<renyu.zj@linux.alibaba.com>
>> ---
>>   drivers/perf/alibaba_uncore_drw_pmu.c | 27 +++++++++++++++++++++++++++
>>   1 file changed, 27 insertions(+)
>>
>> diff --git a/drivers/perf/alibaba_uncore_drw_pmu.c b/drivers/perf/alibaba_uncore_drw_pmu.c
>> index a7689fe..fe075fd 100644
>> --- a/drivers/perf/alibaba_uncore_drw_pmu.c
>> +++ b/drivers/perf/alibaba_uncore_drw_pmu.c
>> @@ -236,10 +236,37 @@ static ssize_t ali_drw_pmu_cpumask_show(struct device *dev,
>>       .attrs = ali_drw_pmu_cpumask_attrs,
>>   };
>>   +static ssize_t ali_drw_pmu_identifier_show(struct device *dev,
>> +                    struct device_attribute *attr,
>> +                    char *page)
>> +{
>> +    return sysfs_emit(page, "%s\n", "ali_drw_pmu");
>> +}
> 
> Would there be anything more unique per implementation version? Having a constant like this means that all implementations will have same events from userspace PoV.
> 

Currently there is only this version, and no new revision will be added in the future. We can consider all implementations
to have the same events.

Thanks,
Jing
