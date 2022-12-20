Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89DD8651DD1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 10:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233535AbiLTJoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 04:44:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233470AbiLTJnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 04:43:35 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FE918E24;
        Tue, 20 Dec 2022 01:42:47 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0BE0F6602CAA;
        Tue, 20 Dec 2022 09:42:44 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671529365;
        bh=BWqzEXUidYwX8sbz46KDwZyzdQJjYGcYq+SPymmJ8Fk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GhcV6fJym8BwiN8M2gDxmkftRbcNNi22Fc4BrS0q4RVTrNOYhZsZPJ2v+E55CmxN5
         0jKdeqYJ8/6/kS9qW44Y8r7mXx3VyUMSST2mlWaCc/ujUQizgcV1qB2IObYWfE0/tD
         WZHnA1oJLvuipSwi8S6axT0CD5jq/oEuNGvAsm9CFsrC0qdFz5ZS514efumcYeZaKp
         i5tl+WJ0SW86AtHjmVrfx0xdxAe34+sW1aJVnSiMbfd1Yz+FZUr4g2WRbWct0fggJj
         W30PjCR4M/HJC+5ytewQJf/L8xUdfApY92Z897zkbFTPshktLfgAIunAEowdVcZkhO
         RD+SP+k80c1Pw==
Message-ID: <51e82ede-a6d4-8e7b-88d1-93a1aba1f845@collabora.com>
Date:   Tue, 20 Dec 2022 10:42:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] iommu/mediatek-v1: Fix an error handling path in
 mtk_iommu_v1_probe()
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Honghui Zhang <honghui.zhang@mediatek.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Joerg Roedel <jroedel@suse.de>, iommu@lists.linux.dev,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <593e7b7d97c6e064b29716b091a9d4fd122241fb.1671473163.git.christophe.jaillet@wanadoo.fr>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <593e7b7d97c6e064b29716b091a9d4fd122241fb.1671473163.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 19/12/22 19:06, Christophe JAILLET ha scritto:
> A clk, prepared and enabled in mtk_iommu_v1_hw_init(), is not released in
> the error handling path of mtk_iommu_v1_probe().
> 
> Add the corresponding clk_disable_unprepare(), as already done in the
> remove function.
> 
> Fixes: b17336c55d89 ("iommu/mediatek: add support for mtk iommu generation one HW")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


