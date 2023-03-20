Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFDD6C0D7A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 10:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbjCTJhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 05:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbjCTJhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 05:37:02 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8461A1C7D1;
        Mon, 20 Mar 2023 02:36:56 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5187B660212C;
        Mon, 20 Mar 2023 09:36:54 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1679305015;
        bh=AqjpL/b1AU7J3DxLOJCIC6nSYPDchmaD5zguUd7vIlk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=RReo38Sb8gmmE37OytUUMxmn1ToVArj1arV5E175vgnKY4RXtEAYVl3ICVeDbwWxD
         Kexmpz39PHjIhJ6M+AZhOxDTkLbpo8/+S/3/3f6o3ehgvf1dc5bo2xEKYA2Kiy8962
         ZNwr90V9pJWNwmwA9FhgoJT8y/TDkDuxfczJDiw07gOFSeAVmi3fZbBUp0DxoFm6S/
         UnkGWF5ycXM7t1CL27OpgX/P3HvK8bnfuH2X8woVGrWO7vjum69gASymoTYNc8btlH
         9uYhO+3YiWwlgTKi2pdW4Kci3uXViqCWxNRsldg0vpYUcwOPfEFxeQAGYSHpPM82ja
         5KsSERUiaulVA==
Message-ID: <2ae1762a-ab5d-b81f-c03a-51221bdb81a4@collabora.com>
Date:   Mon, 20 Mar 2023 10:36:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v5,1/2] media: mediatek: vcodec: Make MM21 the default
 capture format
Content-Language: en-US
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        =?UTF-8?Q?N=c3=adcolas_F_=2e_R_=2e_A_=2e_Prado?= 
        <nfraprado@collabora.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230318035651.27454-1-yunfei.dong@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230318035651.27454-1-yunfei.dong@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 18/03/23 04:56, Yunfei Dong ha scritto:
> Given that only the MM21 capture format is supported by userspace tools (like
> gstreamer and libyuv), make it the default capture format.
> 
> This allows us to force the MM21 format even when a MM21 and MT21C capable
> firmware is available (which is needed while dynamic format switching isn't
> implemented in the driver), without causing the following regressions on
> v4l2-compliance:
> 
>          fail: v4l2-test-formats.cpp(478): pixelformat 3132544d (MT21) for buftype 9 not reported by ENUM_FMT
>      test VIDIOC_G_FMT: FAIL
>          fail: v4l2-test-formats.cpp(478): pixelformat 3132544d (MT21) for buftype 9 not reported by ENUM_FMT
>      test VIDIOC_TRY_FMT: FAIL
>          fail: v4l2-test-formats.cpp(478): pixelformat 3132544d (MT21) for buftype 9 not reported by ENUM_FMT
>      test VIDIOC_S_FMT: FAIL
> 
> Fixes: 7501edef6b1f ("media: mediatek: vcodec: Different codec using different capture format")
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> Reviewed-by: Nicolas F. R. A. Prado <nfraprado@collabora.com>
> Tested-by: Nicolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

