Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED0A5BF2EE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 03:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbiIUB3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 21:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbiIUB2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 21:28:40 -0400
Received: from out199-8.us.a.mail.aliyun.com (out199-8.us.a.mail.aliyun.com [47.90.199.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1272810552
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 18:28:29 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VQLXQDo_1663723704;
Received: from 30.240.97.89(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VQLXQDo_1663723704)
          by smtp.aliyun-inc.com;
          Wed, 21 Sep 2022 09:28:26 +0800
Message-ID: <74773dd0-583a-afb4-ad73-9b324c715d08@linux.alibaba.com>
Date:   Wed, 21 Sep 2022 09:28:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [PATCH v3] mm/damon/sysfs: return 'err' value when call
 kstrtoul() failed
To:     SeongJae Park <sj@kernel.org>
Cc:     akpm@linux-foundation.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220920025158.70293-1-xhao@linux.alibaba.com>
From:   haoxin <xhao@linux.alibaba.com>
In-Reply-To: <20220920025158.70293-1-xhao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-12.1 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi SJ,


在 2022/9/21 上午12:35, SeongJae Park 写道:
> From: Xin Hao <xhao@linux.alibaba.com>
>
> We had better return the 'err' value when calling kstrtoul() failed, so
> the user will know why it really fails, there do little change, let it
> return the 'err' value when failed.
>
> Suggested-by: SeongJae Park <sj@kernel.org>
> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
> Reviewed-by: SeongJae Park <sj@kernel.org>
> Signed-off-by: SeongJae Park <sj@kernel.org>
>
> ---
> Changes from v2
> (https://lore.kernel.org/damon/20220920025158.70293-1-xhao@linux.alibaba.com/)
> - Move patch changelog outside of the commit message area

Thanks for fix this stupid bug，i will nerver make it happen once again.

Reviewed-by: Xin Hao <xhao@linux.alibaba.com>

>
> Changes from v1
> (https://lore.kernel.org/linux-mm/20220919170305.61335-1-sj@kernel.org/T/)
> - keep the 'err' variable, and return the 'err' value when failed.
>
>   mm/damon/sysfs.c | 46 ++++++++++++++--------------------------------
>   1 file changed, 14 insertions(+), 32 deletions(-)
>
> diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> index 0cca1909bf67..455215a5c059 100644
> --- a/mm/damon/sysfs.c
> +++ b/mm/damon/sysfs.c
> @@ -58,7 +58,7 @@ static ssize_t min_store(struct kobject *kobj, struct kobj_attribute *attr,
>
>   	err = kstrtoul(buf, 0, &min);
>   	if (err)
> -		return -EINVAL;
> +		return err;
>
>   	range->min = min;
>   	return count;
> @@ -83,7 +83,7 @@ static ssize_t max_store(struct kobject *kobj, struct kobj_attribute *attr,
>
>   	err = kstrtoul(buf, 0, &max);
>   	if (err)
> -		return -EINVAL;
> +		return err;
>
>   	range->max = max;
>   	return count;
> @@ -291,9 +291,7 @@ static ssize_t interval_us_store(struct kobject *kobj,
>   			struct damon_sysfs_watermarks, kobj);
>   	int err = kstrtoul(buf, 0, &watermarks->interval_us);
>
> -	if (err)
> -		return -EINVAL;
> -	return count;
> +	return err ? err : count;
>   }
>
>   static ssize_t high_show(struct kobject *kobj,
> @@ -312,9 +310,7 @@ static ssize_t high_store(struct kobject *kobj,
>   			struct damon_sysfs_watermarks, kobj);
>   	int err = kstrtoul(buf, 0, &watermarks->high);
>
> -	if (err)
> -		return -EINVAL;
> -	return count;
> +	return err ? err : count;
>   }
>
>   static ssize_t mid_show(struct kobject *kobj,
> @@ -333,9 +329,7 @@ static ssize_t mid_store(struct kobject *kobj,
>   			struct damon_sysfs_watermarks, kobj);
>   	int err = kstrtoul(buf, 0, &watermarks->mid);
>
> -	if (err)
> -		return -EINVAL;
> -	return count;
> +	return err ? err : count;
>   }
>
>   static ssize_t low_show(struct kobject *kobj,
> @@ -354,9 +348,7 @@ static ssize_t low_store(struct kobject *kobj,
>   			struct damon_sysfs_watermarks, kobj);
>   	int err = kstrtoul(buf, 0, &watermarks->low);
>
> -	if (err)
> -		return -EINVAL;
> -	return count;
> +	return err ? err : count;
>   }
>
>   static void damon_sysfs_watermarks_release(struct kobject *kobj)
> @@ -437,9 +429,7 @@ static ssize_t sz_permil_store(struct kobject *kobj,
>   			struct damon_sysfs_weights, kobj);
>   	int err = kstrtouint(buf, 0, &weights->sz);
>
> -	if (err)
> -		return -EINVAL;
> -	return count;
> +	return err ? err : count;
>   }
>
>   static ssize_t nr_accesses_permil_show(struct kobject *kobj,
> @@ -458,9 +448,7 @@ static ssize_t nr_accesses_permil_store(struct kobject *kobj,
>   			struct damon_sysfs_weights, kobj);
>   	int err = kstrtouint(buf, 0, &weights->nr_accesses);
>
> -	if (err)
> -		return -EINVAL;
> -	return count;
> +	return err ? err : count;
>   }
>
>   static ssize_t age_permil_show(struct kobject *kobj,
> @@ -479,9 +467,7 @@ static ssize_t age_permil_store(struct kobject *kobj,
>   			struct damon_sysfs_weights, kobj);
>   	int err = kstrtouint(buf, 0, &weights->age);
>
> -	if (err)
> -		return -EINVAL;
> -	return count;
> +	return err ? err : count;
>   }
>
>   static void damon_sysfs_weights_release(struct kobject *kobj)
> @@ -1111,9 +1097,7 @@ static ssize_t start_store(struct kobject *kobj, struct kobj_attribute *attr,
>   			struct damon_sysfs_region, kobj);
>   	int err = kstrtoul(buf, 0, &region->start);
>
> -	if (err)
> -		return -EINVAL;
> -	return count;
> +	return err ? err : count;
>   }
>
>   static ssize_t end_show(struct kobject *kobj, struct kobj_attribute *attr,
> @@ -1132,9 +1116,7 @@ static ssize_t end_store(struct kobject *kobj, struct kobj_attribute *attr,
>   			struct damon_sysfs_region, kobj);
>   	int err = kstrtoul(buf, 0, &region->end);
>
> -	if (err)
> -		return -EINVAL;
> -	return count;
> +	return err ? err : count;
>   }
>
>   static void damon_sysfs_region_release(struct kobject *kobj)
> @@ -1528,7 +1510,7 @@ static ssize_t sample_us_store(struct kobject *kobj,
>   	int err = kstrtoul(buf, 0, &us);
>
>   	if (err)
> -		return -EINVAL;
> +		return err;
>
>   	intervals->sample_us = us;
>   	return count;
> @@ -1552,7 +1534,7 @@ static ssize_t aggr_us_store(struct kobject *kobj, struct kobj_attribute *attr,
>   	int err = kstrtoul(buf, 0, &us);
>
>   	if (err)
> -		return -EINVAL;
> +		return err;
>
>   	intervals->aggr_us = us;
>   	return count;
> @@ -1576,7 +1558,7 @@ static ssize_t update_us_store(struct kobject *kobj,
>   	int err = kstrtoul(buf, 0, &us);
>
>   	if (err)
> -		return -EINVAL;
> +		return err;
>
>   	intervals->update_us = us;
>   	return count;
> --
> 2.31.0
