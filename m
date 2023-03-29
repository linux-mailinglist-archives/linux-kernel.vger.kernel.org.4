Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 342886CD3CE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 09:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjC2H4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 03:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjC2H4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 03:56:05 -0400
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B4119B;
        Wed, 29 Mar 2023 00:56:03 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0Vew.zTT_1680076558;
Received: from 30.240.113.3(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Vew.zTT_1680076558)
          by smtp.aliyun-inc.com;
          Wed, 29 Mar 2023 15:55:59 +0800
Message-ID: <7060f009-2964-30af-3d12-2bb3e21b6c1e@linux.alibaba.com>
Date:   Wed, 29 Mar 2023 15:55:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH RFC 3/4] driver/perf: Add identifier sysfs file for Yitian
 710 DDR
Content-Language: en-US
To:     Jing Zhang <renyu.zj@linux.alibaba.com>,
        John Garry <john.g.garry@oracle.com>,
        Ian Rogers <irogers@google.com>, Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>
References: <1679885172-95021-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1679885172-95021-4-git-send-email-renyu.zj@linux.alibaba.com>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <1679885172-95021-4-git-send-email-renyu.zj@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=ENV_AND_HDR_SPF_MATCH,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/3/27 AM10:46, Jing Zhang wrote:
> To allow userspace to identify the specific implementation of the device,
> add an "identifier" sysfs file.
> 
> The perf tool can match the Yitian 710 DDR metric through the identifier.
> 
> Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
> ---
>  drivers/perf/alibaba_uncore_drw_pmu.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/perf/alibaba_uncore_drw_pmu.c b/drivers/perf/alibaba_uncore_drw_pmu.c
> index a7689fe..6639a57 100644
> --- a/drivers/perf/alibaba_uncore_drw_pmu.c
> +++ b/drivers/perf/alibaba_uncore_drw_pmu.c
> @@ -236,10 +236,37 @@ static ssize_t ali_drw_pmu_cpumask_show(struct device *dev,
>  	.attrs = ali_drw_pmu_cpumask_attrs,
>  };
>  
> +static ssize_t ali_drw_pmu_identifier_show(struct device *dev,
> +					struct device_attribute *attr,
> +					char *page)
> +{
> +	return sysfs_emit(page, "%s\n", "ali_drw_yitian710");

Is it possible to rename identifier as "ali_drw_pmu"? I don't think we need only
limit alibaba_uncore_drw_pmu to Yitian710 SoC here.

Thank you.
Shuai

> +}
> +
> +static umode_t ali_drw_pmu_identifier_attr_visible(struct kobject *kobj,
> +						struct attribute *attr, int n)
> +{
> +	return attr->mode;
> +}
> +
> +static struct device_attribute ali_drw_pmu_identifier_attr =
> +	__ATTR(identifier, 0444, ali_drw_pmu_identifier_show, NULL);
> +
> +static struct attribute *ali_drw_pmu_identifier_attrs[] = {
> +	&ali_drw_pmu_identifier_attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group ali_drw_pmu_identifier_attr_group = {
> +	.attrs = ali_drw_pmu_identifier_attrs,
> +	.is_visible = ali_drw_pmu_identifier_attr_visible,
> +};
> +
>  static const struct attribute_group *ali_drw_pmu_attr_groups[] = {
>  	&ali_drw_pmu_events_attr_group,
>  	&ali_drw_pmu_cpumask_attr_group,
>  	&ali_drw_pmu_format_group,
> +	&ali_drw_pmu_identifier_attr_group,
>  	NULL,
>  };
>  
