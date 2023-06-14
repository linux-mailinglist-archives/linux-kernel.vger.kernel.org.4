Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF3A472FEF5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 14:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244712AbjFNMpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 08:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244710AbjFNMps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 08:45:48 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43DBE69
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 05:45:45 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Vl6jGnu_1686746740;
Received: from 30.221.149.129(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0Vl6jGnu_1686746740)
          by smtp.aliyun-inc.com;
          Wed, 14 Jun 2023 20:45:41 +0800
Message-ID: <a488689c-b4b9-1998-59c9-e2b14f6628f4@linux.alibaba.com>
Date:   Wed, 14 Jun 2023 20:45:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH 2/2] perf/arm-cmn: Add sysfs identifier
To:     Robin Murphy <robin.murphy@arm.com>, will@kernel.org
Cc:     mark.rutland@arm.com, ilkka@os.amperecomputing.com,
        john.g.garry@oracle.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <cover.1686588640.git.robin.murphy@arm.com>
 <b8a14c14fcdf028939ebf57849863e8ae01743de.1686588640.git.robin.murphy@arm.com>
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
In-Reply-To: <b8a14c14fcdf028939ebf57849863e8ae01743de.1686588640.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/6/13 上午1:16, Robin Murphy 写道:
> Expose a sysfs identifier encapsulating the CMN part number and revision
> so that jevents can narrow down a fundamental set of possible events for
> calculating metrics. Configuration-dependent aspects - such as whether a
> given node type is present, and/or a given node ID is valid - are still
> not covered, and in general it's hard to see how userspace could handle
> them, so we won't be removing any data or validation logic from the
> driver any time soon, but at least it's a step in a useful direction.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/perf/arm-cmn.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index 8cf4ed932950..088dc5c690a4 100644
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c
> @@ -1199,19 +1199,31 @@ static ssize_t arm_cmn_cpumask_show(struct device *dev,
>  static struct device_attribute arm_cmn_cpumask_attr =
>  		__ATTR(cpumask, 0444, arm_cmn_cpumask_show, NULL);
>  
> -static struct attribute *arm_cmn_cpumask_attrs[] = {
> +static ssize_t arm_cmn_identifier_show(struct device *dev,
> +				       struct device_attribute *attr, char *buf)
> +{
> +	struct arm_cmn *cmn = to_cmn(dev_get_drvdata(dev));
> +
> +	return sysfs_emit(buf, "%03x%02x\n", cmn->part, cmn->rev);
> +}
> +
> +static struct device_attribute arm_cmn_identifier_attr =
> +		__ATTR(identifier, 0444, arm_cmn_identifier_show, NULL);
> +
> +static struct attribute *arm_cmn_other_attrs[] = {
>  	&arm_cmn_cpumask_attr.attr,
> +	&arm_cmn_identifier_attr.attr,
>  	NULL,
>  };
>  
> -static const struct attribute_group arm_cmn_cpumask_attr_group = {
> -	.attrs = arm_cmn_cpumask_attrs,
> +static const struct attribute_group arm_cmn_other_attrs_group = {
> +	.attrs = arm_cmn_other_attrs,
>  };
>  
>  static const struct attribute_group *arm_cmn_attr_groups[] = {
>  	&arm_cmn_event_attrs_group,
>  	&arm_cmn_format_attrs_group,
> -	&arm_cmn_cpumask_attr_group,
> +	&arm_cmn_other_attrs_group,
>  	NULL
>  };
>  


Tested-by: Jing Zhang <renyu.zj@linux.alibaba.com>

Thanks,
Jing
