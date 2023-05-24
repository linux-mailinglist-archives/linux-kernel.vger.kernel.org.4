Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5195570FE42
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 21:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233219AbjEXTKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 15:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjEXTKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 15:10:05 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCDF132;
        Wed, 24 May 2023 12:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684955403; x=1716491403;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xSjd7hZ/B+nz5DlTGVlQO8DdpW3bOXeh33EVNB7yeX0=;
  b=Pz5XVVd0TtZCwYcOmbXKUkex8/Pdj4IFHVZumIzGpuGYngHdgVdBW19n
   IFlj53pJpmJI9IRfGkKQUMKpqverrBBUMo3T1HrTLjCbPmxz6AWyCDbag
   hxLKFz4n6ijHA2bDTPjln2aYeV6lNzc/hSAaukhnRPW2u0161ahpTjgZo
   YuE4bykixedEdiLCPmVUuN9HHpsnLNCC8hrJutvJeSDJ5EDxG4C/CUtbY
   VIKw+k06jpdFA8YES8PUUuatVC8vKyP9cda5/aigFxYCB3j1geqQUO14I
   xrtVnQspkvA6z+X4nUTVwK4Wzb0pRDNrbD2sHruqCe59QQ7h0SFh96DkJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="334021579"
X-IronPort-AV: E=Sophos;i="6.00,190,1681196400"; 
   d="scan'208";a="334021579"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 12:10:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="735292079"
X-IronPort-AV: E=Sophos;i="6.00,190,1681196400"; 
   d="scan'208";a="735292079"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 24 May 2023 12:10:02 -0700
Received: from [10.212.203.235] (wangyiya-mobl.amr.corp.intel.com [10.212.203.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 189DE580C63;
        Wed, 24 May 2023 12:10:02 -0700 (PDT)
Message-ID: <fc1e8298-e19d-b16c-3894-1d6e5664151f@linux.intel.com>
Date:   Wed, 24 May 2023 15:10:00 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] perf/x86/uncore: Correct the number of CHAs on SPR
To:     Stephane Eranian <eranian@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org, ak@linux.intel.com,
        stable@vger.kernel.org
References: <20230508140206.283708-1-kan.liang@linux.intel.com>
 <CABPqkBSczJqEbA8M0HCdeqjddgDqpxapJYVYNuAS+EifJ+v+Dg@mail.gmail.com>
Content-Language: en-US
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CABPqkBSczJqEbA8M0HCdeqjddgDqpxapJYVYNuAS+EifJ+v+Dg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 2023-05-08 12:16 p.m., Stephane Eranian wrote:
> On Mon, May 8, 2023 at 7:05 AM <kan.liang@linux.intel.com> wrote:
>>
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> The number of CHAs from the discovery table on some SPR variants is
>> incorrect, because of a firmware issue. An accurate number can be read
>> from the MSR UNC_CBO_CONFIG.
>>
>> Fixes: 949b11381f81 ("perf/x86/intel/uncore: Add Sapphire Rapids server CHA support")
>> Reported-by: Stephane Eranian <eranian@google.com>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> 
> Tested-by: Stephane Eranian <eranian@google.com>
>

Gentle ping.

Do you have any comments for the patch?

Thanks,
Kan

>>
>> Cc: stable@vger.kernel.org
>> ---
>>  arch/x86/events/intel/uncore_snbep.c | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
>> index 7d1199554fe3..54abd93828bf 100644
>> --- a/arch/x86/events/intel/uncore_snbep.c
>> +++ b/arch/x86/events/intel/uncore_snbep.c
>> @@ -6138,6 +6138,7 @@ static struct intel_uncore_type spr_uncore_mdf = {
>>  };
>>
>>  #define UNCORE_SPR_NUM_UNCORE_TYPES            12
>> +#define UNCORE_SPR_CHA                         0
>>  #define UNCORE_SPR_IIO                         1
>>  #define UNCORE_SPR_IMC                         6
>>  #define UNCORE_SPR_UPI                         8
>> @@ -6448,12 +6449,22 @@ static int uncore_type_max_boxes(struct intel_uncore_type **types,
>>         return max + 1;
>>  }
>>
>> +#define SPR_MSR_UNC_CBO_CONFIG         0x2FFE
>> +
>>  void spr_uncore_cpu_init(void)
>>  {
>> +       struct intel_uncore_type *type;
>> +       u64 num_cbo;
>> +
>>         uncore_msr_uncores = uncore_get_uncores(UNCORE_ACCESS_MSR,
>>                                                 UNCORE_SPR_MSR_EXTRA_UNCORES,
>>                                                 spr_msr_uncores);
>>
>> +       type = uncore_find_type_by_id(uncore_msr_uncores, UNCORE_SPR_CHA);
>> +       if (type) {
>> +               rdmsrl(SPR_MSR_UNC_CBO_CONFIG, num_cbo);
>> +               type->num_boxes = num_cbo;
>> +       }
>>         spr_uncore_iio_free_running.num_boxes = uncore_type_max_boxes(uncore_msr_uncores, UNCORE_SPR_IIO);
>>  }
>>
>> --
>> 2.35.1
>>
