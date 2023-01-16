Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E61866BACF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 10:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbjAPJrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 04:47:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjAPJrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 04:47:33 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2135C65D;
        Mon, 16 Jan 2023 01:47:31 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 30B6866029A5;
        Mon, 16 Jan 2023 09:47:29 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673862450;
        bh=33zIFHwmx9BzY/eZo1j7iwlJxGh1pbqYh9OLwq0AIO8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VU1ikWfY30pNkiJqE3XjwoKgR44syhpC/71YWMr5OFxsOcNB/z4aLE2aDesOeWB1+
         1OhBFUG0uMCPAYZihjxzOndhOH4HcnDMH6Z3NNYRWYba7gkmK3UkhtDIsVCg29bFUP
         XdeqtHlTY/XjseoQfuIrR6RC6RH0qZv4AHoXdFfciqrLDOF9CDgKvVd+twcxWlY33c
         sqp7zDq9lTDBuosMn6mfyF8dJYKjSt7G2u9upE8YOO4bXqRus0rPafoZaBP0bRnh4+
         9r6QLLSqzK1oAXdA8ntWHCBXf3vOeOEW/ZzrRsaSqQ4zaEPZvFW6gdhZioGC4p+cIl
         yZmKVcQLdH39Q==
Message-ID: <6aa2d375-144f-c66d-0bf9-24d9f8226907@collabora.com>
Date:   Mon, 16 Jan 2023 10:47:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 08/10] arm64: dts: mt8195: Add dma-ranges for the parent
 "soc" node
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
        yf.wang@mediatek.com, libo.kang@mediatek.com,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        kyrie wu <kyrie.wu@mediatek.corp-partner.google.com>,
        chengci.xu@mediatek.com, youlin.pei@mediatek.com,
        anan.sun@mediatek.com
References: <20230113060133.9394-1-yong.wu@mediatek.com>
 <20230113060133.9394-9-yong.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230113060133.9394-9-yong.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 13/01/23 07:01, Yong Wu ha scritto:
> After commit f1ad5338a4d5 ("of: Fix "dma-ranges" handling for bus
> controllers"), the dma-ranges property is not allowed for
> the leaf node. But our iommu/dma-ranges is 16GB, we still expect
> separate the 16GB dma-range like:
> a) display is in 0 - 4GB;
> b) vcodec is in 4GB - 8GB;
> c) camera is in 8GB - 12GB.
> We can not expect all the masters add a parent node for them,
> especial for the existed drivers/nodes.
> Thus, we add whole the 16GB dma-ranges in the parent "soc" node.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

