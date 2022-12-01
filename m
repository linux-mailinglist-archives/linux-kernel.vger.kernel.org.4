Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D953163E77F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 03:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiLACJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 21:09:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiLACJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 21:09:26 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE3743857;
        Wed, 30 Nov 2022 18:09:25 -0800 (PST)
Received: from kwepemi500014.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NMzyL0gfFzmWBp;
        Thu,  1 Dec 2022 10:08:42 +0800 (CST)
Received: from [10.174.176.189] (10.174.176.189) by
 kwepemi500014.china.huawei.com (7.221.188.232) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Dec 2022 10:09:23 +0800
Message-ID: <683df422-68f2-12e3-ff5e-66c45e567db2@huawei.com>
Date:   Thu, 1 Dec 2022 10:09:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] media: platform: mtk-mdp3: Fix return value check in
 mdp_probe()
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     <mchehab@kernel.org>, <matthias.bgg@gmail.com>,
        <linux-media@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20221130081312.35523-1-linqiheng@huawei.com>
 <fc7ac761-eb81-347b-1c51-cdc9c786ee5b@collabora.com>
From:   Qiheng Lin <linqiheng@huawei.com>
In-Reply-To: <fc7ac761-eb81-347b-1c51-cdc9c786ee5b@collabora.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.189]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500014.china.huawei.com (7.221.188.232)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2022/11/30 17:44, AngeloGioacchino Del Regno 写道:
> Il 30/11/22 09:13, Qiheng Lin ha scritto:
>> In case of error, the function mtk_mutex_get()
>> returns ERR_PTR() and never returns NULL. The NULL test in the
>> return value check should be replaced with IS_ERR().
>>
>> Fixes: 61890ccaefaf ("media: platform: mtk-mdp3: add MediaTek MDP3 
>> driver")
>> Signed-off-by: Qiheng Lin <linqiheng@huawei.com>
>> ---
>>   drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c 
>> b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
>> index c413e59d4286..7a2d992dd842 100644
>> --- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
>> +++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
>> @@ -207,8 +207,8 @@ static int mdp_probe(struct platform_device *pdev)
>>       }
>>       for (i = 0; i < MDP_PIPE_MAX; i++) {
>>           mdp->mdp_mutex[i] = mtk_mutex_get(&mm_pdev->dev);
>> -        if (!mdp->mdp_mutex[i]) {
>> -            ret = -ENODEV;
>> +        if (IS_ERR(mdp->mdp_mutex[i])) {
>> +            ret = PTR_ERR(mdp->mdp_mutex[i]);
>>               goto err_return;
>>           }
>>       }
>>
> 
> That's true, and I fully agree.
> While you're at it, can you also fix the err_return case?
> 
> if (mdp)
>      for ...
>          if (!IS_ERR_OR_NULL(mdp->mdp_mutex[i]))
>              mtk_mutex_put(...)
> 

Thanks for your suggestion, will send the v2.

> Thanks,
> Angelo

