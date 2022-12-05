Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 831C8642A47
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 15:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbiLEOWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 09:22:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbiLEOVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 09:21:46 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F301A206;
        Mon,  5 Dec 2022 06:21:39 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 09C776601E6A;
        Mon,  5 Dec 2022 14:21:37 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1670250098;
        bh=B08ZCRyfqEVr3DGfEAF/s62Wj4pjhb1yJOJfzrepg1w=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=e7rhKO6e5PFiyGRzo6fSbBaBtA3fm2JhrwJinvIXyWf9cWlN4yHb0QgGu4g378x2W
         8zV0CuFaDK7CBJy4/Zp+/SaqaCSjV+xjMUZKnJsEtawXO0mZMd1Rslq5gCvaQhzefM
         ZD3o8IaUSJpBxgBnkyPlm1Ui/KJb1j2aemCXDMohmIKgIPNr7s8Dn5JKk/qBwxfmvt
         u1iux4lYT49LkDDcW9UAoAoEgC2UTWUFeC2jqZK0YM0+4coAj5lpPO9JqFRs/ZNbyM
         t6L29oTY9nPufD30SClr8+W8ncNc3suY5mpN+mzzMmKp7RDSRY0aAcK0jEOvftP2Wm
         6JZY14hXXQ2Ww==
Message-ID: <ef2e6859-56e1-bbf0-dbde-44ea3d7d2f3f@collabora.com>
Date:   Mon, 5 Dec 2022 15:21:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 3/9] spi: mtk-snfi: Add optional nfi_hclk which needed
 for MT7986
Content-Language: en-US
To:     Xiangsheng Hou <xiangsheng.hou@mediatek.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Chuanhong Guo <gch981213@gmail.com>
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, benliang.zhao@mediatek.com,
        bin.zhang@mediatek.com
References: <20221205065756.26875-1-xiangsheng.hou@mediatek.com>
 <20221205065756.26875-4-xiangsheng.hou@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221205065756.26875-4-xiangsheng.hou@mediatek.com>
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

Il 05/12/22 07:57, Xiangsheng Hou ha scritto:
> Add optional nfi_hclk which needed for MT7986.
> 
> Signed-off-by: Xiangsheng Hou <xiangsheng.hou@mediatek.com>

Is there any operation for which you need NFI_HCLK enabled, but at the same time
PAD_CLK and/or NFI_CLK can be disabled?

If NFI_HCLK and NFI_CLK must always be ON at the same time, adding this clock to
spi-mtk-snfi.c is *not* an optimal way of doing things: you can, at this point,
set NFI_HCLK as parent of NFI_CLK in the MT7986 clock driver instead, without
making any addition to this driver at all.

Regards,
Angelo


