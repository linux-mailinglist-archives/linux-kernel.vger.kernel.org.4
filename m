Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D88976DF520
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 14:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjDLMZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 08:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjDLMZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 08:25:44 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4666A72;
        Wed, 12 Apr 2023 05:25:25 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9654D66031FE;
        Wed, 12 Apr 2023 13:25:22 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681302323;
        bh=nOzVvK8/OyHfK5HYRJf+IGjzqcFAOxs4Ytqo8/2OFHE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=gc5Sv4kln7oHqMmSFcbKpVlJr9p4dZCxlmGJ4Es9BFR46g2r+b2xBLEzNHzFLhhG8
         IXvgIoT5hFEspmvfGw+/xDeoXu0IIvuUCJapa5OF819dxmsTKl6cND7O41TT0O1gR3
         j8bKsIPt5hNutKvG/2EnBF0uB0LOGwuE14vW1Je/hKSyB3A6s+Hx0OY0VOXB3kksWa
         6C3UFT7c4/yZa0M4Vn52L5rEabjPkny4iM9DPZrCLBS7mRpznbhzVxV+RMmPWmxHeQ
         z5+6NzIAwxQnvSmLbruXInqHUZ4Yc2DFxIdo0/1aCuWMr5tJpJnELbYVep4USUW/Vo
         Kkqca5ONCjZEQ==
Message-ID: <9f12a544-1acd-e98b-ae33-6c63ea72eb68@collabora.com>
Date:   Wed, 12 Apr 2023 14:25:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [v9] media: mediatek: vcodec: support stateless AV1 decoder
Content-Language: en-US
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Xiaoyong Lu <xiaoyong.lu@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>
Cc:     George Sun <george.sun@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Irui Wang <irui.wang@mediatek.com>,
        Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230412033022.7766-1-xiaoyong.lu@mediatek.com>
 <00a8fb79-580e-5389-f03f-abb7bba9f092@xs4all.nl>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <00a8fb79-580e-5389-f03f-abb7bba9f092@xs4all.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 12/04/23 14:22, Hans Verkuil ha scritto:
> On 12/04/2023 05:30, Xiaoyong Lu wrote:
>> Add mediatek av1 decoder linux driver which use the stateless API in
>> MT8195.
>>
>> Signed-off-by: Xiaoyong Lu<xiaoyong.lu@mediatek.com>
>> Tested-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
>> Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
>> Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> Hmm, I get this compile error:
> 
> drivers/media/platform/mediatek/vcodec/vdec/vdec_av1_req_lat_if.c: In function ‘vdec_av1_slice_setup_uh’:
> drivers/media/platform/mediatek/vcodec/vdec/vdec_av1_req_lat_if.c:48:58: error: ‘V4L2_AV1_FRAME_FLAG_UNIFORM_TILE_SPACING’ undeclared (first use in this function); did you mean
> ‘V4L2_AV1_TILE_INFO_FLAG_UNIFORM_TILE_SPACING’?
>     48 | #define FH_FLAG(x, name)                (!!((x)->flags & V4L2_AV1_FRAME_FLAG_##name))
>        |                                                          ^~~~~~~~~~~~~~~~~~~~
> drivers/media/platform/mediatek/vcodec/vdec/vdec_av1_req_lat_if.c:1322:41: note: in expansion of macro ‘FH_FLAG’
>   1322 |         uh->uniform_tile_spacing_flag = FH_FLAG(ctrl_fh, UNIFORM_TILE_SPACING);
>        |                                         ^~~~~~~
> drivers/media/platform/mediatek/vcodec/vdec/vdec_av1_req_lat_if.c:48:58: note: each undeclared identifier is reported only once for each function it appears in
>     48 | #define FH_FLAG(x, name)                (!!((x)->flags & V4L2_AV1_FRAME_FLAG_##name))
>        |                                                          ^~~~~~~~~~~~~~~~~~~~
> drivers/media/platform/mediatek/vcodec/vdec/vdec_av1_req_lat_if.c:1322:41: note: in expansion of macro ‘FH_FLAG’
>   1322 |         uh->uniform_tile_spacing_flag = FH_FLAG(ctrl_fh, UNIFORM_TILE_SPACING);
>        |                                         ^~~~~~~
> 
> This flag was renamed from V4L2_AV1_FRAME_FLAG_UNIFORM_TILE_SPACING to
> V4L2_AV1_TILE_INFO_FLAG_UNIFORM_TILE_SPACING in v5 of the AV1 uAPI.
> 
> So this suggests to me that you are testing with an old version of the AV1
> uAPI. The correct one is v7:
> 
> https://patchwork.linuxtv.org/project/linux-media/patch/20230306161850.492072-1-daniel.almeida@collabora.com/
> 
> You have to compile and test with that v7 patch since that's the version we
> want to merge.

I was about to say the same.

Please Xiaoyong, update your patch and resend.

Thanks,
Angelo

