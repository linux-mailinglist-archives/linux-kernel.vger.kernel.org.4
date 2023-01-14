Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B87EA66AA2D
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 09:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjANItq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 03:49:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjANIto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 03:49:44 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C32659E4
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 00:49:42 -0800 (PST)
Received: from dggpeml500002.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NvBkZ55lSz16Mm9;
        Sat, 14 Jan 2023 16:47:50 +0800 (CST)
Received: from [10.67.103.44] (10.67.103.44) by dggpeml500002.china.huawei.com
 (7.185.36.158) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sat, 14 Jan
 2023 16:49:29 +0800
Subject: Re: [PATCH] coresight: etm4x: Fix accesses to TRCSEQRSTEVR and
 TRCSEQSTR
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <mike.leach@linaro.org>, <leo.yan@linaro.org>
References: <20230110125101.10533-1-hejunhao3@huawei.com>
 <f2886dd2-c98c-cbe0-0816-0d7926edd2f0@arm.com>
CC:     <coresight@lists.linaro.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>,
        <shenyang39@huawei.com>, <prime.zeng@hisilicon.com>
From:   hejunhao <hejunhao3@huawei.com>
Message-ID: <5a834f93-f32b-c926-2bec-e00e35aa864f@huawei.com>
Date:   Sat, 14 Jan 2023 16:49:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <f2886dd2-c98c-cbe0-0816-0d7926edd2f0@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.44]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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


On 2023/1/12 11:48, Anshuman Khandual wrote:
>
> On 1/10/23 18:21, Junhao He wrote:
>> The TRCSEQRSTEVR and TRCSEQSTR register is not implemented if the
> s/register is/registers are/
Ok, will fix it.
Thanks.
>> TRCIDR5.NUMSEQSTATE == 0. Skip accessing the register in such cases.
> s/register/registers/
Ok, will fix it.
Thanks.

>> Signed-off-by: Junhao He <hejunhao3@huawei.com>
> Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
>
>> ---
>>   .../hwtracing/coresight/coresight-etm4x-core.c | 18 ++++++++++++------
>>   1 file changed, 12 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> index 80fefaba58ee..c7a65d1524fc 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> @@ -424,8 +424,10 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
>>   		etm4x_relaxed_write32(csa, config->vipcssctlr, TRCVIPCSSCTLR);
>>   	for (i = 0; i < drvdata->nrseqstate - 1; i++)
>>   		etm4x_relaxed_write32(csa, config->seq_ctrl[i], TRCSEQEVRn(i));
>> -	etm4x_relaxed_write32(csa, config->seq_rst, TRCSEQRSTEVR);
>> -	etm4x_relaxed_write32(csa, config->seq_state, TRCSEQSTR);
>> +	if (drvdata->nrseqstate) {
>> +		etm4x_relaxed_write32(csa, config->seq_rst, TRCSEQRSTEVR);
>> +		etm4x_relaxed_write32(csa, config->seq_state, TRCSEQSTR);
>> +	}
>>   	etm4x_relaxed_write32(csa, config->ext_inp, TRCEXTINSELR);
>>   	for (i = 0; i < drvdata->nr_cntr; i++) {
>>   		etm4x_relaxed_write32(csa, config->cntrldvr[i], TRCCNTRLDVRn(i));
>> @@ -1631,8 +1633,10 @@ static int __etm4_cpu_save(struct etmv4_drvdata *drvdata)
>>   	for (i = 0; i < drvdata->nrseqstate - 1; i++)
>>   		state->trcseqevr[i] = etm4x_read32(csa, TRCSEQEVRn(i));
>>   
>> -	state->trcseqrstevr = etm4x_read32(csa, TRCSEQRSTEVR);
>> -	state->trcseqstr = etm4x_read32(csa, TRCSEQSTR);
>> +	if (drvdata->nrseqstate) {
>> +		state->trcseqrstevr = etm4x_read32(csa, TRCSEQRSTEVR);
>> +		state->trcseqstr = etm4x_read32(csa, TRCSEQSTR);
>> +	}
>>   	state->trcextinselr = etm4x_read32(csa, TRCEXTINSELR);
>>   
>>   	for (i = 0; i < drvdata->nr_cntr; i++) {
>> @@ -1760,8 +1764,10 @@ static void __etm4_cpu_restore(struct etmv4_drvdata *drvdata)
>>   	for (i = 0; i < drvdata->nrseqstate - 1; i++)
>>   		etm4x_relaxed_write32(csa, state->trcseqevr[i], TRCSEQEVRn(i));
>>   
>> -	etm4x_relaxed_write32(csa, state->trcseqrstevr, TRCSEQRSTEVR);
>> -	etm4x_relaxed_write32(csa, state->trcseqstr, TRCSEQSTR);
>> +	if (drvdata->nrseqstate) {
>> +		etm4x_relaxed_write32(csa, state->trcseqrstevr, TRCSEQRSTEVR);
>> +		etm4x_relaxed_write32(csa, state->trcseqstr, TRCSEQSTR);
>> +	}
>>   	etm4x_relaxed_write32(csa, state->trcextinselr, TRCEXTINSELR);
>>   
>>   	for (i = 0; i < drvdata->nr_cntr; i++) {
> .
>

