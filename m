Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555FA695E49
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 10:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbjBNJJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 04:09:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232237AbjBNJIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 04:08:45 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B234C1E1D2;
        Tue, 14 Feb 2023 01:07:42 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0F042660216A;
        Tue, 14 Feb 2023 09:07:16 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676365637;
        bh=exml4rk8nqwZKBNU5UVCpjJdwJUrGJx/1QP9f2Pscz0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ElAUuXnIEuGj+oHHRkeho+XGKOxgC9yqdGkGy2tGbAIG8xbFjE5dtadhKMCD5dC9M
         Keux8qe+dMHe1Fwr0osNgSZRdqXq/kHIWLcaJY6f0tDyMIjNgKUD3ErAqK1wxT/LRg
         oZqwTfxDUmEHc6YgYxZ83s/pXKx1HMwpB62BRrIZI0oe1zxp57SEX/EiFhB93vEnDP
         RpvvOd5cr16Qf9cTyedRrskLH07xQSH/IUVNjgGKWp8xCUu3evk0z+02OCyrR4qw+5
         Pr1OPcRjUHi6XDiEG9lhaO2iljeLK3i9gGLpHiUg2sagLDoJ/0IN9PpVauJ2DH70Bt
         0q9+dUmbALnMw==
Message-ID: <ab778f16-3cda-6c06-c5a5-6a4b4d1b3974@collabora.com>
Date:   Tue, 14 Feb 2023 10:07:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v3 04/11] iommu/mediatek: Get regionid from larb/port id
Content-Language: en-US
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
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230214031114.926-5-yong.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 14/02/23 04:11, Yong Wu ha scritto:
> After commit f1ad5338a4d5 ("of: Fix "dma-ranges" handling for bus
> controllers"), the dma-ranges is not allowed for dts leaf node.
> but we still would like to separate to different masters
> into different iova regions.
> 
> Thus we have to separate it by the HW larbid and portid. For example,
> larb1/2 are in region2 and larb3 is in region3. The problem is that
> some ports inside a larb are in region4 while some ports inside this
> larb are in region5. Therefore I define a "iova_region_larb_msk" to help
> record the information for each a port. Take a example for a larb:
>   [1] = ~0: means all ports in this larb are in region1;
>   [2] = BIT(3) | BIT(4): means port3/4 in this larb are region2;
>   [3] = ~(BIT(3) | BIT(4)): means all the other ports except port3/4
>                             in this larb are region3.
> 
> This method also avoids the users forget/abuse the iova regions.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>   drivers/iommu/mtk_iommu.c | 47 ++++++++++++++++++++++-----------------
>   1 file changed, 27 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index ab53edcb221f..7e2cb3b8cac8 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -8,7 +8,6 @@
>   #include <linux/clk.h>
>   #include <linux/component.h>
>   #include <linux/device.h>
> -#include <linux/dma-direct.h>
>   #include <linux/err.h>
>   #include <linux/interrupt.h>
>   #include <linux/io.h>
> @@ -212,6 +211,11 @@ struct mtk_iommu_plat_data {
>   	struct {
>   		unsigned int	iova_region_nr;
>   		const struct mtk_iommu_iova_region	*iova_region;
> +		/*
> +		 * Indicate the correspondence between larbs/ports and regions.
> +		 * The index is same with iova_region.

* The index is the same as iova_region and larb port numbers are
* described as bit positions.
* For example, storing BIT(0) at index 2 means "port 0 is in region 2".

That's most probably the best short explanation that we can give, so that nobody
goes crazy with understanding this one.

After fixing that comment, you totally deserve my

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Cheers!


