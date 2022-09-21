Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5555BF9D0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 10:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbiIUIus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 04:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiIUItu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 04:49:50 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4667642B
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 01:49:34 -0700 (PDT)
X-UUID: 20cf9df1efb941bb978f518168bb9188-20220921
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:Message-ID; bh=Sd+Fxwzp7bxeXD28OoMGK9mSgc3f6o0UFW/iNLtc8BI=;
        b=CSJ0NDh69Lvh5yBCzzowyzfIFyXDnRZHZRNlIM+MBi9VBvaGWgcYKzQBH+RFCya/JoFfCqcqM7i9sK3h48j/OUKz34g0rK4RBuQleK/FOJJcFPGDHRazq8DUVjZqDnG1iXUsT7mVzadY2A0aQ8i0tHiXwpA6gaGA1iEnJ7H4hds=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:41914426-8510-42a7-a32e-10054c44b235,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:39a5ff1,CLOUDID:a0a226f7-6e85-48d9-afd8-0504bbfe04cb,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 20cf9df1efb941bb978f518168bb9188-20220921
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2011992881; Wed, 21 Sep 2022 16:49:27 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 21 Sep 2022 16:49:26 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 21 Sep 2022 16:49:26 +0800
Message-ID: <0bf7b7d5-087b-912e-412e-2b3b742448bd@mediatek.com>
Date:   Wed, 21 Sep 2022 16:49:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] drm/mediatek: dsi: Move mtk_dsi_stop() call back to
 mtk_dsi_poweroff()
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
CC:     Chun-Kuang Hu <chunkuang.hu@kernel.org>, <kernel@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Xinlei Lee <xinlei.lee@mediatek.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
References: <20220804194325.1596554-1-nfraprado@collabora.com>
 <CAJMQK-hOxxvkjgOxA6KLLUJxxBehHDQvRo-Y_FLMPLEfkoVMzA@mail.gmail.com>
 <227bce07-37cc-da1d-fc99-065a12cdf3f5@collabora.com>
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
In-Reply-To: <227bce07-37cc-da1d-fc99-065a12cdf3f5@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/19/22 21:32, AngeloGioacchino Del Regno wrote:
> Il 19/09/22 10:40, Hsin-Yi Wang ha scritto:
>> On Mon, Sep 19, 2022 at 4:39 PM Nícolas F. R. A. Prado
>> <nfraprado@collabora.com> wrote:
>>>
>>> As the comment right before the mtk_dsi_stop() call advises,
>>> mtk_dsi_stop() should only be called after
>>> mtk_drm_crtc_atomic_disable(). That's because that function calls
>>> drm_crtc_wait_one_vblank(), which requires the vblank irq to be enabled.
>>>
>>> Previously mtk_dsi_stop(), being in mtk_dsi_poweroff() and guarded by a
>>> refcount, would only be called at the end of
>>> mtk_drm_crtc_atomic_disable(), through the call to
>>> mtk_crtc_ddp_hw_fini().
>>> Commit cde7e2e35c28 ("drm/mediatek: Separate poweron/poweroff from
>>> enable/disable and define new funcs") moved the mtk_dsi_stop() call to
>>> mtk_output_dsi_disable(), causing it to be called before
>>> mtk_drm_crtc_atomic_disable(), and consequently generating vblank
>>> timeout warnings during suspend.
>>>
>>> Move the mtk_dsi_stop() call back to mtk_dsi_poweroff() so that we have
>>> a working vblank irq during mtk_drm_crtc_atomic_disable() and stop
>>> getting vblank timeout warnings.
>>>
>>> Fixes: cde7e2e35c28 ("drm/mediatek: Separate poweron/poweroff from
>>> enable/disable and define new funcs")
>>> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
>>>
>> Tested-by: Hsin-Yi Wang <hsinyi@chromium.org>
>>
> 
> Reviewed-by: AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com>
> 
> 

Tested suspend/resume work properly on mt8188 and mt8186  .

Tested-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
