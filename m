Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F3566AA31
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 09:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjANIu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 03:50:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjANIuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 03:50:52 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B955B90
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 00:50:50 -0800 (PST)
Received: from dggpeml500002.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NvBmP6N4lzJrS7;
        Sat, 14 Jan 2023 16:49:25 +0800 (CST)
Received: from [10.67.103.44] (10.67.103.44) by dggpeml500002.china.huawei.com
 (7.185.36.158) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sat, 14 Jan
 2023 16:50:46 +0800
Subject: Re: [PATCH] coresight: etm4x: Fix accesses to TRCSEQRSTEVR and
 TRCSEQSTR
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        <mathieu.poirier@linaro.org>, <mike.leach@linaro.org>,
        <leo.yan@linaro.org>
References: <20230110125101.10533-1-hejunhao3@huawei.com>
 <4c799bd3-ab24-c0e6-57a4-aa9acc6c46b4@arm.com>
CC:     <coresight@lists.linaro.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>,
        <shenyang39@huawei.com>, <prime.zeng@hisilicon.com>
From:   hejunhao <hejunhao3@huawei.com>
Message-ID: <080e64bc-0e7e-a227-0a48-1168ccd1d774@huawei.com>
Date:   Sat, 14 Jan 2023 16:50:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <4c799bd3-ab24-c0e6-57a4-aa9acc6c46b4@arm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.44]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500002.china.huawei.com (7.185.36.158)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/1/11 0:15, Suzuki K Poulose wrote:
>
> On 10/01/2023 12:51, Junhao He wrote:
>> The TRCSEQRSTEVR and TRCSEQSTR register is not implemented if the
>> TRCIDR5.NUMSEQSTATE == 0. Skip accessing the register in such cases.
>>
>> Signed-off-by: Junhao He <hejunhao3@huawei.com>
>
> This must have :
>
> Fixes: 2e1cdfe184b5 ("coresight-etm4x: Adding CoreSight ETM4x driver")
>
> The patch as such looks correct to me.
>
> I will queue this.
>
> Thanks
> Suzuki
Sure, Will fix in next version.

Best regards,
Junhao.
>
>> ---
>>   .../hwtracing/coresight/coresight-etm4x-core.c | 18 ++++++++++++------
>>   1 file changed, 12 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c 
>> b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> index 80fefaba58ee..c7a65d1524fc 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> @@ -424,8 +424,10 @@ static int etm4_enable_hw(struct etmv4_drvdata 
>> *drvdata)
>>           etm4x_relaxed_write32(csa, config->vipcssctlr, TRCVIPCSSCTLR);
>>       for (i = 0; i < drvdata->nrseqstate - 1; i++)
>>           etm4x_relaxed_write32(csa, config->seq_ctrl[i], 
>> TRCSEQEVRn(i));
>> -    etm4x_relaxed_write32(csa, config->seq_rst, TRCSEQRSTEVR);
>> -    etm4x_relaxed_write32(csa, config->seq_state, TRCSEQSTR);
>> +    if (drvdata->nrseqstate) {
>> +        etm4x_relaxed_write32(csa, config->seq_rst, TRCSEQRSTEVR);
>> +        etm4x_relaxed_write32(csa, config->seq_state, TRCSEQSTR);
>> +    }
>>       etm4x_relaxed_write32(csa, config->ext_inp, TRCEXTINSELR);
>>       for (i = 0; i < drvdata->nr_cntr; i++) {
>>           etm4x_relaxed_write32(csa, config->cntrldvr[i], 
>> TRCCNTRLDVRn(i));
>> @@ -1631,8 +1633,10 @@ static int __etm4_cpu_save(struct 
>> etmv4_drvdata *drvdata)
>>       for (i = 0; i < drvdata->nrseqstate - 1; i++)
>>           state->trcseqevr[i] = etm4x_read32(csa, TRCSEQEVRn(i));
>>   -    state->trcseqrstevr = etm4x_read32(csa, TRCSEQRSTEVR);
>> -    state->trcseqstr = etm4x_read32(csa, TRCSEQSTR);
>> +    if (drvdata->nrseqstate) {
>> +        state->trcseqrstevr = etm4x_read32(csa, TRCSEQRSTEVR);
>> +        state->trcseqstr = etm4x_read32(csa, TRCSEQSTR);
>> +    }
>>       state->trcextinselr = etm4x_read32(csa, TRCEXTINSELR);
>>         for (i = 0; i < drvdata->nr_cntr; i++) {
>> @@ -1760,8 +1764,10 @@ static void __etm4_cpu_restore(struct 
>> etmv4_drvdata *drvdata)
>>       for (i = 0; i < drvdata->nrseqstate - 1; i++)
>>           etm4x_relaxed_write32(csa, state->trcseqevr[i], 
>> TRCSEQEVRn(i));
>>   -    etm4x_relaxed_write32(csa, state->trcseqrstevr, TRCSEQRSTEVR);
>> -    etm4x_relaxed_write32(csa, state->trcseqstr, TRCSEQSTR);
>> +    if (drvdata->nrseqstate) {
>> +        etm4x_relaxed_write32(csa, state->trcseqrstevr, TRCSEQRSTEVR);
>> +        etm4x_relaxed_write32(csa, state->trcseqstr, TRCSEQSTR);
>> +    }
>>       etm4x_relaxed_write32(csa, state->trcextinselr, TRCEXTINSELR);
>>         for (i = 0; i < drvdata->nr_cntr; i++) {
>
> _______________________________________________
> CoreSight mailing list -- coresight@lists.linaro.org
> To unsubscribe send an email to coresight-leave@lists.linaro.org
>
> .
>

