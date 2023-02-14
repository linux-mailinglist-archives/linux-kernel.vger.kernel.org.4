Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D415695F5F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 10:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbjBNJg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 04:36:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232515AbjBNJgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 04:36:22 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C3C233C9;
        Tue, 14 Feb 2023 01:36:17 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D9062660216A;
        Tue, 14 Feb 2023 09:36:13 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676367375;
        bh=I0xlUPTQjUVqujxFEQUs5rV8kqpJYvjuzeEqfHqSU04=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=l7tFNlOyJodSIoviMgrVgynN/hgCGoWsiMMoPzS5mT6IMyqxYoXq7FRnqd4Y5BT5n
         oNgbU920nBZAAlhrz7YO9Fyn8koyaQuAEy+8AMz9Ll6hvS41NTpmhEwT9+fTKj7U88
         W3W9pLyjQS8cRqeAlGY5jscc+Pa/tR6VCNsDZXt06hjyqfJQunMGeMNDa/UQewZWd+
         OfsNvlDKW98FTRYSF/ywk1idQQ4L7X+DOvvLycalMgtLjNwEwLV/P1DMVz4iCjK1L8
         EgyoWkqBnrPB/eWzf0BrpMahzYPWmAG3JIFCy2BemqxPhG0nJKV4efXKI6VKsS3bR6
         Nu/jtxaSCLrXw==
Message-ID: <17239a6f-1d85-d725-89d6-02afe4fbe56a@collabora.com>
Date:   Tue, 14 Feb 2023 10:36:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v3 05/11] iommu/mediatek: mt8195: Add iova_region_larb_msk
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
 <20230214031114.926-6-yong.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230214031114.926-6-yong.wu@mediatek.com>
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
> Add iova_region_larb_msk for mt8195. We separate the 16GB iova regions
> by each device's larbid/portid.
> Refer to include/dt-bindings/memory/mt8195-memory-port.h
> 
> Define a new macro MT8192_MULTI_REGION_MAX_NR to indicate
> the index of mt8xxx_larb_region_msk and
> "struct mtk_iommu_iova_region mt8192_multi_dom"
> are the same.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Sorry but... you *are* introducing a iova_region_larb_msk for MT8192 later,
while you're introducing definitions containing the `MT8192` name in a commit
that introduces the same but for MT8195.

I strongly suggest to, at this point, introduce MT8192 region mask here, along
with the MT8192 definitions, and MT8195 after that :-)


Regards,
Angelo

