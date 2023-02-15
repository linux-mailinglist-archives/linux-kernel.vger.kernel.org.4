Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603DB697BDE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 13:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbjBOMd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 07:33:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbjBOMd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 07:33:57 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B28338663;
        Wed, 15 Feb 2023 04:33:32 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id F1262660218A;
        Wed, 15 Feb 2023 12:33:23 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676464405;
        bh=XjKxrV8fXkRvrXBNe0Ydl7+8yd1Vv/vlPl9Gx+Y6YkM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Uz0hRl40VuK3a2d6yqRDVcl37/37u/4CNYCIrahSlkK3Qe/AgaAoIYZktt2jYp+qX
         VzCjlnkCfmSPNJTf8YX7ktoBQYFx9jgc8AngZpMMdf0ZZQFbseN0nTKrcILXMxgkvl
         zcCxOLRtJNVV4CNfmcffkjHu5BiXmX3i401ssgF20o8nb0o2NCGX14ineyve6n1TM3
         mY1kIaBR2oFlGTVuRcdqJACoiDFb+8RuCvekS8sg7XKExX79wdU3RVp46Bra0iyzbu
         KSx4tkMq82sOcb/lqqJWpw9dL2vUY6oliaA6zmK5+1Nx2TutiVJFbOaetU6lxyhQy4
         EDByEb1blM8pQ==
Message-ID: <7a46706b-3de5-d8dc-6ea5-8e909e2b927e@collabora.com>
Date:   Wed, 15 Feb 2023 13:33:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v4 06/11] iommu/mediatek: mt8195: Add iova_region_larb_msk
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
References: <20230215062544.8677-1-yong.wu@mediatek.com>
 <20230215062544.8677-7-yong.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230215062544.8677-7-yong.wu@mediatek.com>
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
> Add iova_region_larb_msk for mt8195. We separate the 16GB iova regions
> by each device's larbid/portid.
> Refer to include/dt-bindings/memory/mt8195-memory-port.h
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


