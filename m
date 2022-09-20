Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 981FA5BE2F1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 12:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiITKUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 06:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiITKTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 06:19:53 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E499BE9;
        Tue, 20 Sep 2022 03:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663669191; x=1695205191;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XqDK7i21s81xxS44B7twjWidjsGc/l3g36/jPctT8nA=;
  b=hlxkm/YGJJcvZfmR/C9auEV7UxVxczyXhDfbszp+aBPvBqcQ1emiBJUT
   ByovgrP002WR0OUshbC93cDZqdTLvw+y/SfF3MxG1GgAvlEfwXZStjR1/
   ZNxpZvln+JWV711dOP2K6Uo9BwxSWxkKLSmPMFV3nqQDdEiapM7TPmCVb
   MLDrOA78rEP4k9WjAkdLuZ3FCBYn7zSma/tiiy31hZAQ6tGIu0vr6PgzY
   nJsLTSmzqF6LeBQuqiIIauT17vAeZzsKr/xyCXvDaiaw5bRjk1q4UQzHG
   bpaHIPd2Pc1fLfEmGc1pl1enBYECnM8JmVQq3fujX0lT0LGqojvzJZZVi
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="385942876"
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="385942876"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 03:19:51 -0700
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="681249446"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.58.32])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 03:19:48 -0700
Message-ID: <25977700-7ab7-9a3b-5c67-c6c5fe35a13a@intel.com>
Date:   Tue, 20 Sep 2022 13:19:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH] mmc: host: Fix data stomping during mmc recovery
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Wenchao Chen <wenchao.chen666@gmail.com>
Cc:     baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        megoo.tang@gmail.com, lzx.stg@gmail.com
References: <20220916090506.10662-1-wenchao.chen666@gmail.com>
 <CAPDyKFqNJzwizZduMj_ig=aEXAgssQM8AzbYxa_T9XEqNXeWPw@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAPDyKFqNJzwizZduMj_ig=aEXAgssQM8AzbYxa_T9XEqNXeWPw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/22 12:32, Ulf Hansson wrote:
> + Adrian
> 
> On Fri, 16 Sept 2022 at 11:05, Wenchao Chen <wenchao.chen666@gmail.com> wrote:
>>
>> From: Wenchao Chen <wenchao.chen@unisoc.com>
>>
>> The block device uses multiple queues to access emmc. There will be up to 3
>> requests in the hsq of the host. The current code will check whether there
>> is a request doing recovery before entering the queue, but it will not check
>> whether there is a request when the lock is issued. The request is in recovery
>> mode. If there is a request in recovery, then a read and write request is
>> initiated at this time, and the conflict between the request and the recovery
>> request will cause the data to be trampled.
>>
>> Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>
> 
> Looks like we should consider tagging this for stable kernels too, right?
> 
>> ---
>>  drivers/mmc/host/mmc_hsq.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/mmc_hsq.c b/drivers/mmc/host/mmc_hsq.c
>> index a5e05ed0fda3..9d35453e7371 100644
>> --- a/drivers/mmc/host/mmc_hsq.c
>> +++ b/drivers/mmc/host/mmc_hsq.c
>> @@ -34,7 +34,7 @@ static void mmc_hsq_pump_requests(struct mmc_hsq *hsq)
>>         spin_lock_irqsave(&hsq->lock, flags);
>>
>>         /* Make sure we are not already running a request now */
>> -       if (hsq->mrq) {
>> +       if (hsq->mrq || hsq->recovery_halt) {
> 
> This still looks a bit odd to me, but I may not fully understand the
> code, as it's been a while since I looked at this.
> 
> In particular, I wonder why the callers of mmc_hsq_pump_requests()
> need to release the spin_lock before they call
> mmc_hsq_pump_requests()? Is it because we want to allow some other
> code that may be waiting for the spin_lock to be released, to run too?

FWIW, I am not aware of any reason.

> 
> If that isn't the case, it seems better to let the callers of
> mmc_hsq_pump_requests() to keep holding the lock - and thus we can
> avoid the additional check(s). In that case, it means the
> "recovery_halt" flag has already been checked, for example.
> 
>>                 spin_unlock_irqrestore(&hsq->lock, flags);
>>                 return;
>>         }
>> --
>> 2.17.1
>>
> 
> Kind regards
> Uffe

