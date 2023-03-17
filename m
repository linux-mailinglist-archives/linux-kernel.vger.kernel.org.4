Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69BDC6BE5AF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 10:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbjCQJeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 05:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjCQJef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 05:34:35 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43129113DB;
        Fri, 17 Mar 2023 02:34:34 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 619FE660309F;
        Fri, 17 Mar 2023 09:34:32 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1679045673;
        bh=NPnMSIT8GhdkxFjv1oWWysOJEh2QHcceiGEgx5s2ACU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nx3mnF3sIVTsy3pv8yoUYiMu/2x0n3yndWxedYuspeNWINEY7F5lQ0hf60F18gQOj
         Pb14+QnipFsAniwoK+lib7DvABxjp/fWQFwuB99mBw3JRrW327pki7Vh3Dd6hdPVw4
         jhMkVskFwdm/AjZOVHkPTqvaUzcyuUblGCxdnjTdh0UoZ/ZJJWLW3JzkrgiVd2HNYi
         Nm2Gtoza7ssXZV/SI9LQXkaa+Lvi3680+736qjDWx8vnfvGOGYZMMQLm2coMRe8vLu
         euTLlMzIx1PQiPBQzado95BCB3jciD+ofA8BUol6LHKkkrrjITXrnFAb74tbVesqau
         3HBu5jeQoev/A==
Message-ID: <797dcbef-8485-72cc-4eb5-f58153d147ce@collabora.com>
Date:   Fri, 17 Mar 2023 10:34:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v9 3/7] iommu/mediatek: Adjust mtk_iommu_config flow
Content-Language: en-US
To:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, mingyuan.ma@mediatek.com,
        yf.wang@mediatek.com, jianjiao.zeng@mediatek.com,
        chengci.xu@mediatek.com
References: <20230317085541.20447-1-yong.wu@mediatek.com>
 <20230317085541.20447-4-yong.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230317085541.20447-4-yong.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 17/03/23 09:55, Yong Wu ha scritto:
> From: "Chengci.Xu" <chengci.xu@mediatek.com>
> 
> If there are many ports in a infra master, current flow will update
> the INFRA register many times. This patch saves all ports to portid_msk
> in the front of mtk_iommu_config(), then update only once for the IOMMU
> configure. After this, we could avoid send too many SMC calls to ATF in
> MT8188.
> 
> Prepare for MT8188, also reduce the indention without functional change.
> 
> Signed-off-by: Chengci.Xu <chengci.xu@mediatek.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


