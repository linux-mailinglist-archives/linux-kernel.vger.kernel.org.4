Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026D35BDAFE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 05:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiITDsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 23:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiITDsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 23:48:14 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068BC4D4FC
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 20:48:05 -0700 (PDT)
X-UUID: fa0681a33ed4482a9cbfaf39450c60ec-20220920
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:CC:To:From:Subject:MIME-Version:Date:Message-ID; bh=Jz5vm2YaapemwoSJhLba/w/znSz6qfV4EVBhxelwwNc=;
        b=cPWs2WvQKlXWgMXQZ7URz/5Ul/lT14pjEf+gWWOkQdamxn3288slKEjcVqOka4BIeFZNWdbGcKhyaE7dKyfVL41RjKGYxUn/A8CT5QODHZ2nsr9W/16dZmCM31ppcqfDP5bmo467xy/rhkCD3TlSw3YuA946OmMhnz6heQtDKTU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:acd8e1de-ec1c-4b02-b79b-915f85f2cdde,IP:0,U
        RL:25,TC:0,Content:-5,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:65
X-CID-INFO: VERSION:1.1.11,REQID:acd8e1de-ec1c-4b02-b79b-915f85f2cdde,IP:0,URL
        :25,TC:0,Content:-5,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:65
X-CID-META: VersionHash:39a5ff1,CLOUDID:f1b15b70-dafa-4a42-b716-cf2cd4845592,B
        ulkID:220918123239OLP9J5MU,BulkQuantity:135,Recheck:0,SF:28|17|19|48|823|8
        24,TC:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:40,QS:nil,BEC:nil
        ,COL:0
X-UUID: fa0681a33ed4482a9cbfaf39450c60ec-20220920
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 374548407; Tue, 20 Sep 2022 11:47:59 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 20 Sep 2022 11:47:54 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Tue, 20 Sep 2022 11:47:54 +0800
Message-ID: <42aebe49-1419-c474-ec7d-9bfcc15162eb@mediatek.com>
Date:   Tue, 20 Sep 2022 11:47:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] drm: mediatek: Fix display vblank timeout when disable
 dsi
Content-Language: en-US
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        =?UTF-8?B?WGlubGVpIExlZSAo5p2O5piV56OKKQ==?= 
        <Xinlei.Lee@mediatek.com>
References: <20220914140031.18578-1-allen-kh.cheng@mediatek.com>
 <CAAOTY_92F5WgCedZOvg_qtkHLorTCXiWtuGgoJ=9gRryYHi7TQ@mail.gmail.com>
 <7ef4e4c6-e8e6-74a9-8211-bff90ad2d9fb@mediatek.com>
In-Reply-To: <7ef4e4c6-e8e6-74a9-8211-bff90ad2d9fb@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi CK,

We can use [1] in mt8186. Please ignore this PATCH.

Thanks,
Allen

[1]
http://lists.infradead.org/pipermail/linux-mediatek/2022-August/046713.html

On 9/19/22 11:01, Allen-KH Cheng wrote:
> Hi CK,
> 
> We will test this fix on the mt8186/mt8183.
> Maybe our fix is not necessary.
> 
> I appreciate your suggestion.
> 
> BRs,
> Allen
> 
> On 9/18/22 12:32, Chun-Kuang Hu wrote:
>> Hi, Allen:
>>
>> Allen-KH Cheng <allen-kh.cheng@mediatek.com> 於 2022年9月14日 週三 晚上10:00寫道：
>>>
>>> From: Xinlei Lee <xinlei.lee@mediatek.com>
>>>
>>> Dsi is turned off at bridge.disable, causing crtc to wait for vblank
>>> timeout. It is necessary to add count protection to turn off dsi and
>>> turn off at post_disable.
>>
>> If turn off dsi in post_disable(), you should turn on dsi in pre_enable().
>>
>> There is another patch fix this problem [1], do you have any comment
>> on that patch?
>>
>> [1] http://lists.infradead.org/pipermail/linux-mediatek/2022-August/046713.html
>>
>> Regards,
>> Chun-Kuang.
>>
>>>
>>> Fixes: cde7e2e35c28 ("drm/mediatek: Separate poweron/poweroff from enable/disable and define new funcs")
>>> Signed-off-by: Xinlei Lee <xinlei.lee@mediatek.com>
>>> Co-developed-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
>>> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
>>> ---
>>> Change in v1:
>>>   * Rebase to kernel/git/chunkuang.hu/linux.git, mediatek-drm-fixes
>>>     [Allen-KH Cheng <allen-kh.cheng@mediatek.com>]
>>> ---
>>> ---
>>>  drivers/gpu/drm/mediatek/mtk_dsi.c | 15 ++++++---------
>>>  1 file changed, 6 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
>>> index 5b624e0f5b0a..e30f4244c001 100644
>>> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
>>> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
>>> @@ -768,14 +768,6 @@ static void mtk_dsi_bridge_mode_set(struct drm_bridge *bridge,
>>>         drm_display_mode_to_videomode(adjusted, &dsi->vm);
>>>  }
>>>
>>> -static void mtk_dsi_bridge_atomic_disable(struct drm_bridge *bridge,
>>> -                                         struct drm_bridge_state *old_bridge_state)
>>> -{
>>> -       struct mtk_dsi *dsi = bridge_to_dsi(bridge);
>>> -
>>> -       mtk_output_dsi_disable(dsi);
>>> -}
>>> -
>>>  static void mtk_dsi_bridge_atomic_enable(struct drm_bridge *bridge,
>>>                                          struct drm_bridge_state *old_bridge_state)
>>>  {
>>> @@ -803,13 +795,15 @@ static void mtk_dsi_bridge_atomic_post_disable(struct drm_bridge *bridge,
>>>  {
>>>         struct mtk_dsi *dsi = bridge_to_dsi(bridge);
>>>
>>> +       if (dsi->refcount == 1)
>>> +               mtk_output_dsi_disable(dsi);
>>> +
>>>         mtk_dsi_poweroff(dsi);
>>>  }
>>>
>>>  static const struct drm_bridge_funcs mtk_dsi_bridge_funcs = {
>>>         .attach = mtk_dsi_bridge_attach,
>>>         .atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
>>> -       .atomic_disable = mtk_dsi_bridge_atomic_disable,
>>>         .atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
>>>         .atomic_enable = mtk_dsi_bridge_atomic_enable,
>>>         .atomic_pre_enable = mtk_dsi_bridge_atomic_pre_enable,
>>> @@ -829,6 +823,9 @@ void mtk_dsi_ddp_stop(struct device *dev)
>>>  {
>>>         struct mtk_dsi *dsi = dev_get_drvdata(dev);
>>>
>>> +       if (dsi->refcount == 1)
>>> +               mtk_output_dsi_disable(dsi);
>>> +
>>>         mtk_dsi_poweroff(dsi);
>>>  }
>>>
>>> --
>>> 2.18.0
>>>
