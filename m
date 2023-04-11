Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 693006DD7A0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 12:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjDKKN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 06:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjDKKNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 06:13:23 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB944100;
        Tue, 11 Apr 2023 03:13:21 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7BCCC66031AD;
        Tue, 11 Apr 2023 11:13:19 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681208000;
        bh=H0bLhwmxJ3hfxq2cNw35YIq7xvlSowfBxBWvLLl7KxY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MQRpBPV4eSPWPJDxxo4hOC8lJfK7U2Gva6HAK8zfzSIzpyNgsiTuwAxLiNr6ZHrZa
         tfNlGyd5PbPnKje6sfMwqZd1XQTnjcrgb+1AoK8szw1gpTZkpSTay+iT3dNC05mtpg
         OdFJuQmxRYK7tBPAWs6hgyBNcsJ4rWruFYSLrxn9/XN2VH0Ttp88LbGht9ts0lAYVa
         ZMwPwjChFGRc3ABfoqZlzDA89+1LNVQHXEyWcv5QjDoSBXHavL356lBytEVd3jcNxO
         8q0VQJLIsYEfFeyjBFMZ0Uyj1KWaC9FZsygkBxsqMAO+E2Ry1ZBGIxRyOr+V3DHtir
         dtppndF9pmLPQ==
Message-ID: <5697b1ba-262d-34d9-b853-a6c959fc29fd@collabora.com>
Date:   Tue, 11 Apr 2023 12:13:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v7 09/14] iommu/mediatek: Set dma_mask for the master
 devices
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
References: <20230411093144.2690-1-yong.wu@mediatek.com>
 <20230411093144.2690-10-yong.wu@mediatek.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230411093144.2690-10-yong.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 11/04/23 11:31, Yong Wu ha scritto:
> MediaTek iommu arranges dma ranges for all the masters, this patch is to
> help them set dma mask. This is to avoid each master setting their own
> mask, but also to avoid a real issue, such as JPEG uses
> "mediatek,mtk-jpgenc" for 2701/8183/8186/8188, then JPEG could ignore its
> different dma_mask in different SoC to achieve common code.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

