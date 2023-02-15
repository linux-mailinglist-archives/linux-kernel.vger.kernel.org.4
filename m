Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E9A697BDB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 13:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233732AbjBOMdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 07:33:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233518AbjBOMdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 07:33:25 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E323803B;
        Wed, 15 Feb 2023 04:33:16 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 70FE866020BD;
        Wed, 15 Feb 2023 12:33:13 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676464394;
        bh=yM8UZlP7PgHoRsCkVSZFSvADbuNBTD+p54p7NQUgWe8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nG6lJqnHl3vZ6i+3L/PYbOPZ4sAjtdsH4v+WXVEuuRE+m0RN4zl9217DF61IlWFYC
         b8RejFETSD13EwtHmVtsUl02hZAG2XsJT+tv6vgPjrWVtKUJc0zpzsweqXHyvo1q66
         4HbtRFtTHiNZwB2A6UGSu1ZkdaYpTaOOCC6N/TLaEqnxkBo2fUwdQibVtB/RlL8F15
         xgBbzjvClleBYyp1vue7PyBU0ljn7INDulSjG+KL6E/UYbPQTZEDahHYu8ieBYNK6y
         RqakM5skMwo+egwZRuwz/jhj1N5pow3oirOnxvuSmamC9mnRu/WxtfIlgl1owne62+
         Gu3n66P/ZjNOg==
Message-ID: <5701f81a-07c2-e3d5-d2fc-92c7fe4df58e@collabora.com>
Date:   Wed, 15 Feb 2023 13:33:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v4 05/11] iommu/mediatek: mt8192: Add iova_region_larb_msk
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
References: <20230215062544.8677-1-yong.wu@mediatek.com>
 <20230215062544.8677-6-yong.wu@mediatek.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230215062544.8677-6-yong.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 15/02/23 07:25, Yong Wu ha scritto:
> Add iova_region_larb_msk for mt8192. We separate the 16GB iova regions
> by each device's larbid/portid.
> Note: larb3/6/8/10/12/15 connect nothing in this SoC.
> Refer to the comment in include/dt-bindings/memory/mt8192-larb-port.h
> 
> Define a new macro MT8192_MULTI_REGION_NR_MAX to indicate
> the index of mt8xxx_larb_region_msk and
> "struct mtk_iommu_iova_region mt8192_multi_dom"
> are the same.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

P.S.: I'm sorry for the step-by-step review and making you send multiple versions,
       I feel this can be tedious sometimes but - at times - this is the only way
       to make sure that the code is as "beautiful" and bug-free as possible!

Cheers!
