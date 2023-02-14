Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C778695FEC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 10:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbjBNJ4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 04:56:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232415AbjBNJ4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 04:56:02 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F3CEC69;
        Tue, 14 Feb 2023 01:55:39 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B28E8660216A;
        Tue, 14 Feb 2023 09:55:36 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676368538;
        bh=GPjPDcw1DbLNEhZjsESUC0x1/RTrz5my5LsVvj59CxA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WKwDiZfZDreJQUUcDZVtXsHfDDDLyl4UY9y5+xPfwoy1SISoTcKrDPhBym55Bcxx5
         l/NEVmt5QUxTz+rQieXWPq0PIOLKzLoyXH9eZP6Kt3dF6udQc8jaQC7ognMDzA9j+7
         Gm4I4LdqadFRsS2EHDa5H5bP0acoBppYfrf3R3FYVCYEHtCoQt0VP3TKSj+oejLUvh
         ekDYMFfeEhZWh8YKfV5AaHlxg4M0wygu/UbdszAaOU1F9+0gKHX15r8DGX87/JaPKI
         MNT1y1sdhN6wRZFjT6s3HkJO5TAmaZ7dhlF0atET7citXogkyWw3Ol9VnHECD/Cw1Q
         ozGbkXm89CUhw==
Message-ID: <5f66275f-5440-38ee-60e7-3b4ea276aae7@collabora.com>
Date:   Tue, 14 Feb 2023 10:55:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v3 08/11] iommu/mediatek: Add a gap for the iova regions
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
 <20230214031114.926-9-yong.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230214031114.926-9-yong.wu@mediatek.com>
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
> As the removed property in the vcodec dt-binding, the property is:
> dma-ranges = <0x1 0x0 0x0 0x40000000 0x0 0xfff00000>;
> 
> The length is 0xfff0_0000 rather than 0x1_0000_0000, this means it
> requires 1M as a gap. This is because the end address for some vcodec
> HW is (address + size). If the size is 4G, the end address may be
> 0x2_0000_0000, and the width for vcodec register only is 32, then the
> HW may get the ZERO address.
> 
> Currently the consumer's dma-ranges property doesn't work, IOMMU
> has to consider this case. Add a bigger gap(8M) for all the regions
> to avoid it.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


