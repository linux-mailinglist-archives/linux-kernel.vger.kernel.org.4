Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 246E85F3281
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 17:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbiJCP3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 11:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiJCP3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 11:29:41 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84CDC20
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 08:29:37 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id x32-20020a17090a38a300b00209dced49cfso7686377pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 08:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:mime-version:in-reply-to:references
         :user-agent:from:from:to:cc:subject:date;
        bh=BuEmPyN4Ez4NmzzutnovdwGSEF1vNe6R6TiRpHW5ogY=;
        b=faryKYuRlup1uNl841W9tCsnXKY4x5ZzddcOLsdf9HkC6Bzo24TLmqkXIRjeolgwQ0
         uVnITeO5OeSznTxdOXLjya60IB11c2j9MAUPdCKbidhkfkEvpXdE+JKkOxObngvaMZ34
         YQ52qsWDGO9ZLcU4KgbMShdKMGgc4RGVjpSgkdbTzHE2GjrWygu3wygkpENNPhlESvp0
         y9fw6suGV2xOkH7lz62ZnfHklPnDTChe4P3JzhwayXA4BdsYg/7iJclyFl/JhkLgIhLj
         lJxHANwUI/go2VxU7IzU6jQR9FR3g59ID9r9gsFpVg4q0OChrT7Dtkg4IV3dgGbRSAD3
         mRYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:mime-version:in-reply-to:references
         :user-agent:from:x-gm-message-state:from:to:cc:subject:date;
        bh=BuEmPyN4Ez4NmzzutnovdwGSEF1vNe6R6TiRpHW5ogY=;
        b=osqKftceMO5QwsqvL4Wif72qRTKx0mvVSNRPcfp0n37UujOYSrJUWse8InxNSjYdZc
         n4O4Y9bzH0RH9yaDer5vahChiO7Hhl3AR96KVP6G6zrjkv0H9WMBP27FKQP9WFdoRN3s
         ATX1hT3zSPfx7YR8NhyGQYlIITDNtHXwzfQWSCzwE3jXlO2Dizo36Ou5c9yPLYkilOcu
         8gsxYa8gdyeEx5OZS8R9gNMew/J2iIs83vin2ZS1trnUwV5EjoqxOE4PX78dZaAMt9HT
         wDZvmqNuwp+Eb2wjD5T2uiWeiTgMjfsOb3Jd7ibrNQI+aZxbaN3tWvzyjhU/UMzhuBwq
         NNNA==
X-Gm-Message-State: ACrzQf3Cr1612cpqtYo57RHHvFeCfeixh1ediLicu5tubM+a2KmIZJyK
        ZiBGLHmIpuCDKT4CeRlvVVAxQtyRJqlS4QCRgzzq5w==
X-Google-Smtp-Source: AMsMyM44/4lmkJnwlFZ4jkHjH1tzKco6W1np3dHDWnE8gN2xk1BxjeMb6W4Zs9wA7u4Wlvz1r9guvdbO7Gov4Hza580=
X-Received: by 2002:a17:902:f710:b0:178:a692:b1f7 with SMTP id
 h16-20020a170902f71000b00178a692b1f7mr23009123plo.112.1664810976929; Mon, 03
 Oct 2022 08:29:36 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 3 Oct 2022 17:29:36 +0200
From:   Guillaume Ranquet <granquet@baylibre.com>
User-Agent: meli 0.7.2
References: <20220919-v1-0-4844816c9808@baylibre.com> <20220919-v1-17-4844816c9808@baylibre.com>
 <a0a3c427-c851-ae5d-4010-e94740bf9f6e@linaro.org> <CABnWg9s3N_Ua9g0S3x0uj8PN4FtOX6DO+zQcBzGFqoLTL1J24A@mail.gmail.com>
 <bc64b69d-3d65-f5ca-a688-2ad1a055ba4b@linaro.org>
In-Reply-To: <bc64b69d-3d65-f5ca-a688-2ad1a055ba4b@linaro.org>
MIME-Version: 1.0
Date:   Mon, 3 Oct 2022 17:29:36 +0200
Message-ID: <CABnWg9sJFBAXi1bu_yHDppFOmg=H=G7QTn9Bzqkr-t7qm5vUFw@mail.gmail.com>
Subject: Re: [PATCH v1 17/17] drm/mediatek: Add mt8195-dpi support to drm_drv
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Vinod Koul <vkoul@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>, Jitao shi <jitao.shi@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-mediatek@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Pablo Sun <pablo.sun@mediatek.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Sep 2022 16:28, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>On 27/09/2022 15:04, Guillaume Ranquet wrote:
>> On Thu, 22 Sep 2022 09:20, Krzysztof Kozlowski
>> <krzysztof.kozlowski@linaro.org> wrote:
>>> On 19/09/2022 18:56, Guillaume Ranquet wrote:
>>>> Add dpi support to enable the HDMI path.
>>>>
>>>> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
>>>>
>>>> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
>>>> index 72049a530ae1..27f029ca760b 100644
>>>> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
>>>> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
>>>> @@ -820,6 +820,8 @@ static const struct of_device_id mtk_ddp_comp_dt_ids[] = {
>>>>  	  .data = (void *)MTK_DPI },
>>>>  	{ .compatible = "mediatek,mt8192-dpi",
>>>>  	  .data = (void *)MTK_DPI },
>>>> +	{ .compatible = "mediatek,mt8195-dpi",
>>>> +	  .data = (void *)MTK_DPI },
>>>
>>> It's compatible with the others. You don't need more compatibles.
>>
>> Hi Krzysztof,
>>
>> It's a bit confusing, because this compatible is used in both
>> mtk_drm_drv.c and in mtk_dpi.c
>>
>> Albeit it's entirely the same thing regarding the mtk_drm_drv module,
>> it's pretty different
>> regarding the mtk_dpi module.
>
>Sure, but this does not explain why do you need these entries here in
>mtk_drm_drv.
>
>Best regards,
>Krzysztof
>

Hi Krzysztof,

Sorry for the late answer.
The mtk_drm_drv is the component master of the full mediatek drm stack.

it "binds" all of the crtc/dpi/ovl/mutex/merge... components of the stack.

That mtk_ddp_comp_dt_ids array is iterated over to find all of the components
from the device tree.

Hope this clarifies things?

Thx,
Guillaume.
