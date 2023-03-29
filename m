Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B856CD8D2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 13:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjC2LyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 07:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjC2LyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 07:54:09 -0400
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4A84203;
        Wed, 29 Mar 2023 04:54:03 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R421e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0VewpsNi_1680090837;
Received: from 30.221.149.47(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VewpsNi_1680090837)
          by smtp.aliyun-inc.com;
          Wed, 29 Mar 2023 19:53:58 +0800
Message-ID: <8ba831ae-4568-32af-3fd1-fd51a7c13dcd@linux.alibaba.com>
Date:   Wed, 29 Mar 2023 19:53:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH RFC 1/4] driver/perf: Add identifier sysfs file for CMN
To:     John Garry <john.g.garry@oracle.com>,
        Ian Rogers <irogers@google.com>, Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Zhuo Song <zhuo.song@linux.alibaba.com>
References: <1679885172-95021-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1679885172-95021-2-git-send-email-renyu.zj@linux.alibaba.com>
 <72246c5e-6ba5-098b-a979-e90738cc7509@oracle.com>
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
In-Reply-To: <72246c5e-6ba5-098b-a979-e90738cc7509@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=ENV_AND_HDR_SPF_MATCH,
        NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/3/27 下午3:55, John Garry 写道:
> On 27/03/2023 03:46, Jing Zhang wrote:
>> To allow userspace to identify the specific implementation of the device,
>> add an "identifier" sysfs file.
>>
>> The perf tool can match the arm CMN metric through the identifier.
>>
>> Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
>> ---
>>   drivers/perf/arm-cmn.c | 43 +++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 43 insertions(+)
>>
>> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
>> index c968986..0c138ad 100644
>> --- a/drivers/perf/arm-cmn.c
>> +++ b/drivers/perf/arm-cmn.c
>> @@ -1168,10 +1168,53 @@ static ssize_t arm_cmn_cpumask_show(struct device *dev,
>>       .attrs = arm_cmn_cpumask_attrs,
>>   };
>>   +static ssize_t arm_cmn_identifier_show(struct device *dev,
>> +        struct device_attribute *attr, char *buf)
>> +{
>> +    struct arm_cmn *cmn = to_cmn(dev_get_drvdata(dev));
>> +    if (cmn->model == CMN700) {
>> +        return sysfs_emit(buf, "%s\n", "CMN700");
> 
> Is it possible to have a pointer to this string in struct arm_cmn, such that we don't have to do this model to identifier lookup here? If-else chains like this are not scalable.
> 
Will do.

> BTW, does this HW have some HW identifier register, like iidr? I think that using that may be preferable.
> 

I didn't find the relevant identifier register.

Do Illka and Robin know that there is such a register that can identify different CMN versions? Looking forward to your suggestions.


>> +    }
>> +    else if (cmn->model == CMN650) {
>> +        return sysfs_emit(buf, "%s\n", "CMN650");
> 
> I'd use lowercase names
> 
Ok.

>> +    }
>> +    else if (cmn->model == CMN600) {
>> +        return sysfs_emit(buf, "%s\n", "CMN600");
>> +    }
>> +    else if (cmn->model == CI700) {
>> +        return sysfs_emit(buf, "%s\n", "CI700");
>> +    }
>> +    return sysfs_emit(buf, "%s\n", "UNKNOWN");
> 
> can we have a "is_visble" attr to just no show this when unknown?
> 

Ok.

>> +}
>> +
>> +static umode_t arm_cmn_identifier_attr_visible(struct kobject *kobj,
>> +        struct attribute *attr, int n)
>> +{
>> +    struct device *dev = kobj_to_dev(kobj);
>> +    struct arm_cmn *cmn = to_cmn(dev_get_drvdata(dev));
>> +    if (cmn->model <= 0)
>> +        return 0;
>> +    return attr->mode;
>> +};
>> +
>> +static struct device_attribute arm_cmn_identifier_attr =
>> +__ATTR(identifier, 0444, arm_cmn_identifier_show, NULL);
>> +
>> +static struct attribute *arm_cmn_identifier_attrs[] = {
>> +    &arm_cmn_identifier_attr.attr,
>> +    NULL,
> 
> nit: no need for trailing ',' on a sentinel
> 

Ok, Will do.

>> +};
>> +
>> +static struct attribute_group arm_cmn_identifier_attr_group = {
>> +    .attrs = arm_cmn_identifier_attrs,
>> +    .is_visible = arm_cmn_identifier_attr_visible,
>> +};
>> +
>>   static const struct attribute_group *arm_cmn_attr_groups[] = {
>>       &arm_cmn_event_attrs_group,
>>       &arm_cmn_format_attrs_group,
>>       &arm_cmn_cpumask_attr_group,
>> +    &arm_cmn_identifier_attr_group,
>>       NULL
>>   };
>>   
