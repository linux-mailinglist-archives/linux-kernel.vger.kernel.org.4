Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E19A6355D6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 10:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237525AbiKWJVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 04:21:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237513AbiKWJVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 04:21:09 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DF2107E43;
        Wed, 23 Nov 2022 01:21:07 -0800 (PST)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NHFwL6JCWz15MqQ;
        Wed, 23 Nov 2022 17:20:34 +0800 (CST)
Received: from [10.67.110.112] (10.67.110.112) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 17:21:05 +0800
Subject: Re: [PATCH] clk: rockchip: Fix memory leak in
 rockchip_clk_register_pll()
To:     Heiko Stuebner <heiko@sntech.de>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <mturquette@linaro.org>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20221123032237.64567-1-xiujianfeng@huawei.com>
 <6301679.31r3eYUQgx@phil>
From:   xiujianfeng <xiujianfeng@huawei.com>
Message-ID: <648ff5d2-9a52-3a73-46b8-a903315202d9@huawei.com>
Date:   Wed, 23 Nov 2022 17:21:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <6301679.31r3eYUQgx@phil>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.112]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

ÔÚ 2022/11/23 17:01, Heiko Stuebner Ð´µÀ:
> Hi,
> 
> Am Mittwoch, 23. November 2022, 04:22:37 CET schrieb Xiu Jianfeng:
>> If clk_register() fails, @pll->rate_table may have allocated memory by
>> kmemdup(), so it needs to be freed, otherwise will cause memory leak
>> issue, this patch fixes it.
>>
>> Fixes: 90c590254051 ("clk: rockchip: add clock type for pll clocks and pll used on rk3066")
>> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
>> ---
>>   drivers/clk/rockchip/clk-pll.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/clk/rockchip/clk-pll.c b/drivers/clk/rockchip/clk-pll.c
>> index 4b9840994295..dc4ce280d125 100644
>> --- a/drivers/clk/rockchip/clk-pll.c
>> +++ b/drivers/clk/rockchip/clk-pll.c
>> @@ -1200,6 +1200,7 @@ struct clk *rockchip_clk_register_pll(struct rockchip_clk_provider *ctx,
>>   	clk_unregister(mux_clk);
>>   	mux_clk = pll_clk;
>>   err_mux:
>> +	kfree(pll->rate_table);
> 
> I think this free needs to go up to the err_pll block.
> 
> In the code it is
> - clk_register(pll_mux->hw)   -> err_mux
> - kmemdup
> - clk_register(pll->hw)	-> err_pll
> 
> so the kfree for the rate-table should probably
> be at
> 	err_pll:
> 		kfree(rate_table)

Thanks for you review, I think here should be kfree(pll->rate_table) 
instead of kfree(rate_table), because @rate_table is the intput param 
while pll->rate_table is the new allocated memory.

v2 already sent.

> 		clk_unregister(mux_clk);
> 		...
> 
> 
> Heiko
> 
>>   	kfree(pll);
>>   	return mux_clk;
>>   }
>>
> 
> 
> 
> 
> 
> .
> 
