Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF835EA85B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 16:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234379AbiIZO0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 10:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234370AbiIZOZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 10:25:43 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31AE626D;
        Mon, 26 Sep 2022 05:37:51 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Mbhxq500fzlWvQ;
        Mon, 26 Sep 2022 20:33:35 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 20:37:49 +0800
Received: from [10.174.179.24] (10.174.179.24) by
 dggpemm100009.china.huawei.com (7.185.36.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 20:37:49 +0800
Subject: Re: [PATCH 3/4] memory: tegra210-emc: use DEFINE_SHOW_ATTRIBUTE to
 simplify code
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
References: <20220922143344.3252585-1-liushixin2@huawei.com>
 <20220922143344.3252585-4-liushixin2@huawei.com>
 <b5252d24-0c7a-5e71-ec4b-d0460181acb8@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>
From:   Liu Shixin <liushixin2@huawei.com>
Message-ID: <08a48f70-89e7-0cd0-b5d5-c2799b5d76e0@huawei.com>
Date:   Mon, 26 Sep 2022 20:37:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <b5252d24-0c7a-5e71-ec4b-d0460181acb8@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.24]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/9/26 17:26, Krzysztof Kozlowski wrote:
> On 22/09/2022 16:33, Liu Shixin wrote:
>> Use DEFINE_SHOW_ATTRIBUTE helper macro to simplify the code.
>> No functional change.
>>
>> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
>> ---
>>  drivers/memory/tegra/tegra210-emc-core.c | 14 +-------------
>>  1 file changed, 1 insertion(+), 13 deletions(-)
>>
>> diff --git a/drivers/memory/tegra/tegra210-emc-core.c b/drivers/memory/tegra/tegra210-emc-core.c
>> index cbe1a7723514..603b306daca1 100644
>> --- a/drivers/memory/tegra/tegra210-emc-core.c
>> +++ b/drivers/memory/tegra/tegra210-emc-core.c
>> @@ -1621,20 +1621,8 @@ static int tegra210_emc_debug_available_rates_show(struct seq_file *s,
>>  
>>  	return 0;
>>  }
>> +DEFINE_SHOW_ATTRIBUTE(tegra210_emc_debug_available_rates);
>>  
>> -static int tegra210_emc_debug_available_rates_open(struct inode *inode,
>> -						   struct file *file)
>> -{
>> -	return single_open(file, tegra210_emc_debug_available_rates_show,
>> -			   inode->i_private);
>> -}
>> -
>> -static const struct file_operations tegra210_emc_debug_available_rates_fops = {
>> -	.open = tegra210_emc_debug_available_rates_open,
>> -	.read = seq_read,
>> -	.llseek = seq_lseek,
>> -	.release = single_release,
>> -};
>>  
> It looks you leave here two blank lines. If so, please fix it - only one
> blank line.
Thanks for the reminder, I have removed the duplicate blank lines in next version.

Thanks,
>
>>  static int tegra210_emc_debug_min_rate_get(void *data, u64 *rate)
>>  {
> Best regards,
> Krzysztof
>
> .
>

