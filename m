Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1665BB774
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 11:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbiIQJLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 05:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiIQJKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 05:10:47 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C59399F0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 02:10:33 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R941e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=liusong@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VQ-LTNS_1663405829;
Received: from 30.39.131.12(mailfrom:liusong@linux.alibaba.com fp:SMTPD_---0VQ-LTNS_1663405829)
          by smtp.aliyun-inc.com;
          Sat, 17 Sep 2022 17:10:30 +0800
Message-ID: <afe5b403-4e37-80fd-643d-79e0876a7047@linux.alibaba.com>
Date:   Sat, 17 Sep 2022 17:10:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [PATCH] sbitmap: fix permanent io blocking caused by insufficient
 wakeup times
To:     Hillf Danton <hdanton@sina.com>
Cc:     axboe@kernel.dk, linux-kernel@vger.kernel.org
References: <20220917035831.735-1-hdanton@sina.com>
From:   Liu Song <liusong@linux.alibaba.com>
In-Reply-To: <20220917035831.735-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.4 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/9/17 11:58, Hillf Danton wrote:
> On 17 Sep 2022 10:33:01 +0800 Liu Song <liusong@linux.alibaba.com> wrote:
>> @@ -632,10 +633,14 @@ static bool __sbq_wake_up(struct sbitmap_queue *sbq)
>>   		if (ret == wait_cnt) {
>>   			sbq_index_atomic_inc(&sbq->wake_index);
>>   			wake_up_nr(&ws->wait, wake_batch);
>> -			return false;
>> +			if (!nr || *nr <= 0)
>> +				return false;
>>   		}
>>   
>>   		return true;
>> +	} else if (nr && *nr) {
>> +		(*nr)--;
>> +		goto again;
>>   	}
>>   
>>   	return false;
> Hi Song,
>
> See if advancing wake_index can survive your tests.

Hi

Thanks for your suggestion, this problem not only needs to switch a wait 
queue, but also needs to consume "wait_cnt" correctly.


Thanks


>
> Only for thoughts now.
>
> Hillf
> --- a/lib/sbitmap.c
> +++ b/lib/sbitmap.c
> @@ -611,6 +611,7 @@ static bool __sbq_wake_up(struct sbitmap
>   	if (wait_cnt <= 0) {
>   		int ret;
>   
> +		sbq_index_atomic_inc(&sbq->wake_index);
>   		wake_batch = READ_ONCE(sbq->wake_batch);
>   
>   		/*
> @@ -627,7 +628,6 @@ static bool __sbq_wake_up(struct sbitmap
>   		 */
>   		ret = atomic_cmpxchg(&ws->wait_cnt, wait_cnt, wake_batch);
>   		if (ret == wait_cnt) {
> -			sbq_index_atomic_inc(&sbq->wake_index);
>   			wake_up_nr(&ws->wait, wake_batch);
>   			return false;
>   		}
