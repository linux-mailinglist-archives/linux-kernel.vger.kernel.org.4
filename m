Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A566C695EB3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 10:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbjBNJP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 04:15:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232525AbjBNJPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 04:15:00 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB9D2529C;
        Tue, 14 Feb 2023 01:12:33 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id ECE67660216A;
        Tue, 14 Feb 2023 09:12:23 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676365945;
        bh=wNNWVklVHmzhbEv++PA7rXDFmZVhNIaqUY/+tOe7Ue8=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=Gbbf8ZbE1iIjzKzDVrDk2n1facFjipcen8TIWGSNZGugZ48XED+XWVie8M1hGvovd
         5/EQPh+XNWB/ZNPs5QjlqWdZ8E4egNt7H428Zdek3yW9R4s22hmJt98rqVS8kTIueu
         zHhf0tR5ZxD1SgumVgLHr1/xWF6r+Ha9cG+rTa+yoFCVb53Ne+vz53OhMXo7EjKP5B
         0CH5cAm2yNbChER6cgjx6ScMyj5mp6pkkvbjpFwhT/OK0vA27dR/5zFOQIK0ingXTa
         EYlGekKZ0Lciw9u4e+DFYqVteE8bFiOSz2VEIxrKpL88+rsBbKDpKveYPH3CY4TrWk
         JtO63m5DxqRnQ==
Message-ID: <c3513a9d-a98f-11de-ba6e-251b0e7f0993@collabora.com>
Date:   Tue, 14 Feb 2023 10:12:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v3 04/11] iommu/mediatek: Get regionid from larb/port id
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hans Verkuil <hverkuil@xs4all.nl>, nfraprado@collabora.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, mingyuan.ma@mediatek.com,
        yf.wang@mediatek.com, jianjiao.zeng@mediatek.com,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        kyrie wu <kyrie.wu@mediatek.corp-partner.google.com>,
        chengci.xu@mediatek.com, youlin.pei@mediatek.com,
        anan.sun@mediatek.com
References: <20230214031114.926-1-yong.wu@mediatek.com>
 <20230214031114.926-5-yong.wu@mediatek.com>
 <ab778f16-3cda-6c06-c5a5-6a4b4d1b3974@collabora.com>
In-Reply-To: <ab778f16-3cda-6c06-c5a5-6a4b4d1b3974@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 14/02/23 10:07, AngeloGioacchino Del Regno ha scritto:
> Il 14/02/23 04:11, Yong Wu ha scritto:
>> After commit f1ad5338a4d5 ("of: Fix "dma-ranges" handling for bus
>> controllers"), the dma-ranges is not allowed for dts leaf node.
>> but we still would like to separate to different masters
>> into different iova regions.
>>
>> Thus we have to separate it by the HW larbid and portid. For example,
>> larb1/2 are in region2 and larb3 is in region3. The problem is that
>> some ports inside a larb are in region4 while some ports inside this
>> larb are in region5. Therefore I define a "iova_region_larb_msk" to help
>> record the information for each a port. Take a example for a larb:
>>   [1] = ~0: means all ports in this larb are in region1;
>>   [2] = BIT(3) | BIT(4): means port3/4 in this larb are region2;
>>   [3] = ~(BIT(3) | BIT(4)): means all the other ports except port3/4
>>                             in this larb are region3.
>>
>> This method also avoids the users forget/abuse the iova regions.
>>
>> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
>> ---
>>   drivers/iommu/mtk_iommu.c | 47 ++++++++++++++++++++++-----------------
>>   1 file changed, 27 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
>> index ab53edcb221f..7e2cb3b8cac8 100644
>> --- a/drivers/iommu/mtk_iommu.c
>> +++ b/drivers/iommu/mtk_iommu.c
>> @@ -8,7 +8,6 @@
>>   #include <linux/clk.h>
>>   #include <linux/component.h>
>>   #include <linux/device.h>
>> -#include <linux/dma-direct.h>
>>   #include <linux/err.h>
>>   #include <linux/interrupt.h>
>>   #include <linux/io.h>
>> @@ -212,6 +211,11 @@ struct mtk_iommu_plat_data {
>>       struct {
>>           unsigned int    iova_region_nr;
>>           const struct mtk_iommu_iova_region    *iova_region;
>> +        /*
>> +         * Indicate the correspondence between larbs/ports and regions.
>> +         * The index is same with iova_region.
> 
> * The index is the same as iova_region and larb port numbers are
> * described as bit positions.
> * For example, storing BIT(0) at index 2 means "port 0 is in region 2".
> 

Sorry, I'm reiterating because the proposed comment is wrong.

/*
  * Indicates the correspondance between larbs, ports and regions.
  *
  * The index is the same as iova_region and larb port numbers are
  * described as bit positions.
  * For example, storing BIT(0) at index 2,1 means "larb 1, port0 is in region 2".
  *              [2] = { [1] = BIT(0) }
  */


> That's most probably the best short explanation that we can give, so that nobody
> goes crazy with understanding this one.
> 
> After fixing that comment, you totally deserve my
> 
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> Cheers!
> 
> 

