Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD8065CDF9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 09:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233675AbjADIDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 03:03:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbjADIDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 03:03:21 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566EBD60
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 00:03:20 -0800 (PST)
Received: from dggpemm500007.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Nn2B865CNz16MN8;
        Wed,  4 Jan 2023 16:01:52 +0800 (CST)
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 4 Jan 2023 16:03:17 +0800
Subject: Re: [PATCH] soc: imx8m: fix wrong return value check of
 of_clk_get_by_name()
To:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <shawnguo@kernel.org>, <s.hauer@pengutronix.de>,
        <kernel@pengutronix.de>, <festevam@gmail.com>, <linux-imx@nxp.com>,
        <xiaolei.wang@windriver.com>, <l.stach@pengutronix.de>
References: <20230104064136.1695102-1-yangyingliang@huawei.com>
 <1882509.eGJsNajkDb@steina-w>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <82ddb754-a0e5-efaf-6654-70a795ab8b81@huawei.com>
Date:   Wed, 4 Jan 2023 16:03:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1882509.eGJsNajkDb@steina-w>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/1/4 15:50, Alexander Stein wrote:
> Hi,
>
> Am Mittwoch, 4. Januar 2023, 07:41:36 CET schrieb Yang Yingliang:
>> of_clk_get_by_name() never returns NULL pointer, it will return
>> ERR_PTR() when it fails, so replace the check with IS_ERR().
>>
>> Fixes: 836fb30949d9 ("soc: imx8m: Enable OCOTP clock before reading the
>> register") Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>> ---
>>   drivers/soc/imx/soc-imx8m.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/soc/imx/soc-imx8m.c b/drivers/soc/imx/soc-imx8m.c
>> index 28144c699b0c..32ed9dc88e45 100644
>> --- a/drivers/soc/imx/soc-imx8m.c
>> +++ b/drivers/soc/imx/soc-imx8m.c
>> @@ -66,8 +66,8 @@ static u32 __init imx8mq_soc_revision(void)
>>   	ocotp_base = of_iomap(np, 0);
>>   	WARN_ON(!ocotp_base);
>>   	clk = of_clk_get_by_name(np, NULL);
>> -	if (!clk) {
>> -		WARN_ON(!clk);
>> +	if (IS_ERR(clk)) {
> Nice catch. But wouldn't
>> if (WARN_ON(IS_ERR(clk)))
> be even better instead of doing the check twice?
Yes, it's better, I will send a new version.

Thanks,
Yang
>
> Best regards,
> Alexander
>
>> +		WARN_ON(IS_ERR(clk));
>>   		return 0;
>>   	}
>
>
>
> .
