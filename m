Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B22C6748194
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 12:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbjGEKAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 06:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbjGEKAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 06:00:19 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966E9E41
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 03:00:18 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9873C66018CF;
        Wed,  5 Jul 2023 11:00:16 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688551217;
        bh=LWBUM2eAeMbEAdWCxLKa7EIHcDRWR8YL8nCssD1CCe4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=djcXx8aPIDfdDlqSgm5afDE69qEwnOwDiGHiwcfdXow+r4J+SCeO8vfhHEpRmy++N
         wUtFswCrDP3DK9E5rbh2B4dk1cQuWMDKRYXzlCTnQlE5SBYfuyRmrevTK9m2zwSrKA
         PH5TxX47sCVBkIE8wXVkb2UMQcZF2j2nluOGAQ2bohdW2xOC7r7Mg9WjA28M0dq+1F
         hl9TZT1pyuRRud/QCMpF4Lcj4PA9l2GwjRh69yhVNE4rT4xGsxh8Vt4d6cgf7Da2rA
         9bZpqViGH0w/nlQI+eE+fOWUTCjEYyKoi/1nrDA+kbDpGtCD9lw7sHPboA4nk05rTg
         5qTqBR6pszZew==
Message-ID: <be88f6db-8b07-1767-f48c-24a215006a4f@collabora.com>
Date:   Wed, 5 Jul 2023 12:00:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 4/4] phy: mediatek: tphy: Convert to
 devm_platform_ioremap_resource()
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230705090126.26854-1-frank.li@vivo.com>
 <20230705090126.26854-4-frank.li@vivo.com>
 <ddc05f70-7075-97ab-1c94-cb3d5839ef2b@collabora.com>
 <6a1bde36-fbf9-9ddd-e47f-f3c21a3528f7@vivo.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <6a1bde36-fbf9-9ddd-e47f-f3c21a3528f7@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 05/07/23 11:30, Yangtao Li ha scritto:
> HI AngeloGioacchino,
> 
> On 2023/7/5 17:22, AngeloGioacchino Del Regno wrote:
>> Il 05/07/23 11:01, Yangtao Li ha scritto:
>>> Use devm_platform_ioremap_resource() to simplify code.
>>>
>>> Signed-off-by: Yangtao Li <frank.li@vivo.com>
>>> ---
>>>   drivers/phy/mediatek/phy-mtk-tphy.c | 10 +++-------
>>>   1 file changed, 3 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/phy/mediatek/phy-mtk-tphy.c 
>>> b/drivers/phy/mediatek/phy-mtk-tphy.c
>>> index 0d110e50bbfd..cb7a4e6ea017 100644
>>> --- a/drivers/phy/mediatek/phy-mtk-tphy.c
>>> +++ b/drivers/phy/mediatek/phy-mtk-tphy.c
>>> @@ -1554,7 +1554,6 @@ static int mtk_tphy_probe(struct platform_device *pdev)
>>>       struct device_node *np = dev->of_node;
>>>       struct device_node *child_np;
>>>       struct phy_provider *provider;
>>> -    struct resource *sif_res;
>>>       struct mtk_tphy *tphy;
>>>       struct resource res;
>>>       int port, retval;
>>> @@ -1576,15 +1575,12 @@ static int mtk_tphy_probe(struct platform_device *pdev)
>>>       tphy->dev = dev;
>>>       platform_set_drvdata(pdev, tphy);
>>>   -    sif_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>>       /* SATA phy of V1 needn't it if not shared with PCIe or USB */
>>> -    if (sif_res && tphy->pdata->version == MTK_PHY_V1) {
>>> +    if (tphy->pdata->version == MTK_PHY_V1) {
>>>           /* get banks shared by multiple phys */
>>> -        tphy->sif_base = devm_ioremap_resource(dev, sif_res);
>>> -        if (IS_ERR(tphy->sif_base)) {
>>> -            dev_err(dev, "failed to remap sif regs\n");
>>> +        tphy->sif_base = devm_platform_ioremap_resource(pdev, 0);
>>> +        if (IS_ERR(tphy->sif_base) && PTR_ERR(tphy->sif_base) != -EINVAL)
>>
>> That's wrong. You want to return any error unconditionally, as the V1 PHY *needs*
>> the sif iospace and there's nothing afterwards retrying this.
> 
> 
> When sif_res is not configured, an IOMEM_ERR_PTR(-EINVAL) error will be returned in 
> __devm_ioremap_resource.
> 
> This kind of error is ignored in the newly added code, and the driving probe 
> process will not be interrupted at this time.
> 
> What did I miss?
> 

As I said, MTK_PHY_V1 *needs* sif; devm_platform_ioremap_resource() returns a
handle to that iospace, or error.

tphy->sif_base = devm_platform_ioremap_resource(pdev, 0);
if (IS_ERR(tphy->sif_base))
	return PTR_ERR(tphy->sif_base);

Regards,
Angelo

> Thx,
> 
> Yangtao
> 
> 
>>
>> Please fix.
>>
>> Regards,
>> Angelo
>>
>>>               return PTR_ERR(tphy->sif_base);
>>> -        }
>>>       }
>>>         if (tphy->pdata->version < MTK_PHY_V3) {
>>
>>



