Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 756655B762A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 18:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiIMQK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 12:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbiIMQKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 12:10:03 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47EC9C8F4;
        Tue, 13 Sep 2022 08:06:04 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 30B4D6600014;
        Tue, 13 Sep 2022 16:04:55 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663081496;
        bh=Y7SuvEzRQqxCRPnos88wzHGHgs9hmIxCXEYqOBc1xyc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GAzdmAduclaUF2vAhKVmAbPYWRl0wOF3ZKgFs3+tvB9U3bX/hUlS9vjl5Tx9nFPAh
         WUf0+4/Y518oaNrpprBqsNHq0+rog3z6UOr849afpr5xmPwBNoZ0SwgnaI9e/agbTz
         ytZ/e6dzGz3foPlWzX7TV8/EpKHG/dfV8aa4DgnIqCQRMlBKAggORDsva1qgjrL9ea
         wwanLhBsH74dF1cODN04c15VTE/0jo8I8sbzxsS0cpBtZJhQYLG1/gYH1nS5pkxypv
         gGPJKlzG/+0bVvXN2z/dohhG2UW2dfP9gI7v2RV69bXAkWpkx5G3XgObZYOHuTRNFv
         dgkOjba/n/EyA==
Message-ID: <be9e629b-d6d8-7387-71d7-b597e95f12a1@collabora.com>
Date:   Tue, 13 Sep 2022 17:04:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v5 2/3] iommu/mediatek: Introduce new flag
 TF_PORT_TO_ADDR_MT8173
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        joro@8bytes.org
Cc:     yong.wu@mediatek.com, will@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, paul.bouchara@somainline.org
References: <20220913122428.374280-1-angelogioacchino.delregno@collabora.com>
 <20220913122428.374280-3-angelogioacchino.delregno@collabora.com>
 <29758c95-e77a-5105-f03e-22ea94d9a569@linaro.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <29758c95-e77a-5105-f03e-22ea94d9a569@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 13/09/22 16:00, Krzysztof Kozlowski ha scritto:
> On 13/09/2022 14:24, AngeloGioacchino Del Regno wrote:
>> In preparation for adding support for MT6795, add a new flag named
>> TF_PORT_TO_ADDR_MT8173 and use that instead of checking for m4u_plat
>> type in mtk_iommu_hw_init() to avoid seeing a long list of m4u_plat
>> checks there in the future.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> Reviewed-by: Yong Wu <yong.wu@mediatek.com>
>> ---
>>   drivers/iommu/mtk_iommu.c | 6 ++++--
>>   drivers/memory/mtk-smi.c  | 1 +
>>   2 files changed, 5 insertions(+), 2 deletions(-)

..snip..

>> diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
>> index 5a9754442bc7..cd415ed1f4ca 100644
>> --- a/drivers/memory/mtk-smi.c
>> +++ b/drivers/memory/mtk-smi.c
>> @@ -462,6 +462,7 @@ static int mtk_smi_larb_sleep_ctrl_enable(struct mtk_smi_larb *larb)
>>   	if (ret) {
>>   		/* TODO: Reset this larb if it fails here. */
>>   		dev_err(larb->smi.dev, "sleep ctrl is not ready(0x%x).\n", tmp);
>> +		ret = -EAGAIN;
> 
> Doesn't look related nor explained in commit msg.

This is because it's not related.. not explained... and embarassing, as something
went wrong during the rebase.

Many thanks for pinging me about that, I'm immediately sending a new version.

Regards,
Angelo


