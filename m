Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28ED5EC388
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 15:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbiI0NER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 09:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiI0NEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 09:04:14 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B6717A5EB
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 06:04:13 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id s14-20020a17090a6e4e00b0020057c70943so15506908pjm.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 06:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:mime-version:in-reply-to:references
         :user-agent:from:from:to:cc:subject:date;
        bh=5A9tE5XjShKgk0dp4mGM6QaE+oB3gw3GtO9g42ZRvK8=;
        b=K6t+GiDMxCE5PqXx9M7wnOxrmVe8RhMGvnDnBYG8NOKa2YssCusIkZAF4W4yvOQESA
         grgJhoRBvxxax0+eCuPKh8p2W5rWUX6HXDrfWlnt3QOGcvz2Z0pKWEx5bc2keTzCKDPA
         EFNonbeyTfJxCD6F40ovXsaSvZaA6ciUzimvjumUgzudbGcVF+jQjdL0HxEI5YO8kDxR
         uaL+FNOyGJVlqjEpMvpc2MXt9w63j7o81b3Y3ky55r6MbLY0d+jh1dOdyFrtP5/68Jsh
         ZON8Od6QdsueW9v6KQ7nfWtM/RdVCng56yDGIVeLLVpq3zbI72tvF/vuGVGpBIBmWRps
         bqHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:mime-version:in-reply-to:references
         :user-agent:from:x-gm-message-state:from:to:cc:subject:date;
        bh=5A9tE5XjShKgk0dp4mGM6QaE+oB3gw3GtO9g42ZRvK8=;
        b=tHWi8IS5K5zfH+czYAucYA+zMJFeS42DGONLLjSPp1XCDqWLFGO7aGIl0bkp1nVJkZ
         knNk2Whg2iXupRdlFitoOVUYtm8wkGFPS+f9VFyhtoNVFmYnp2RKfgesqYakSdtRgLVD
         QdNpy71A714NRAVeYBNJ43qn5vgXJ1+iViylas0GV2ctUuMre72msI0mIKCKVorH7lla
         5Qu1pcqymfewoBrNWqzFPEwAHduiinaO4sdtHc5PY5UU3TP4K36KD7jdbj5v6Jxtu4xD
         hL9UxmOzN8nZghpLfLJ8HJE2G+2Uuij8YOruJDXQowmPsgph+EtknNXlf7LTIDZqY3g8
         jXLg==
X-Gm-Message-State: ACrzQf18HBkl68I+jCaT3YWBDBKR3+x6ooxujcEacza70F8FSMfrCDAy
        KZ6Kx40plUYSbJij4BegZ/xO+hgmTdc0OOrRWlisNQ==
X-Google-Smtp-Source: AMsMyM5gawCoKKBTAHhXh48htU73+kqaFhoDJNb7qglhir+j3HxUZ0tCej0iXrKwzR9+MRTcHiP7gPgmwpcjXrYibm8=
X-Received: by 2002:a17:90b:33c9:b0:200:a0ca:e6c8 with SMTP id
 lk9-20020a17090b33c900b00200a0cae6c8mr4481943pjb.147.1664283852916; Tue, 27
 Sep 2022 06:04:12 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 27 Sep 2022 06:04:12 -0700
From:   Guillaume Ranquet <granquet@baylibre.com>
User-Agent: meli 0.7.2
References: <20220919-v1-0-4844816c9808@baylibre.com> <20220919-v1-17-4844816c9808@baylibre.com>
 <a0a3c427-c851-ae5d-4010-e94740bf9f6e@linaro.org>
In-Reply-To: <a0a3c427-c851-ae5d-4010-e94740bf9f6e@linaro.org>
MIME-Version: 1.0
Date:   Tue, 27 Sep 2022 06:04:11 -0700
Message-ID: <CABnWg9s3N_Ua9g0S3x0uj8PN4FtOX6DO+zQcBzGFqoLTL1J24A@mail.gmail.com>
Subject: Re: [PATCH v1 17/17] drm/mediatek: Add mt8195-dpi support to drm_drv
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
        Michael Turquette <mturquette@baylibre.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-mediatek@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Pablo Sun <pablo.sun@mediatek.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Sep 2022 09:20, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>On 19/09/2022 18:56, Guillaume Ranquet wrote:
>> Add dpi support to enable the HDMI path.
>>
>> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
>>
>> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
>> index 72049a530ae1..27f029ca760b 100644
>> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
>> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
>> @@ -820,6 +820,8 @@ static const struct of_device_id mtk_ddp_comp_dt_ids[] = {
>>  	  .data = (void *)MTK_DPI },
>>  	{ .compatible = "mediatek,mt8192-dpi",
>>  	  .data = (void *)MTK_DPI },
>> +	{ .compatible = "mediatek,mt8195-dpi",
>> +	  .data = (void *)MTK_DPI },
>
>It's compatible with the others. You don't need more compatibles.

Hi Krzysztof,

It's a bit confusing, because this compatible is used in both
mtk_drm_drv.c and in mtk_dpi.c

Albeit it's entirely the same thing regarding the mtk_drm_drv module,
it's pretty different
regarding the mtk_dpi module.

Thx,
Guillaume.
>
>Best regards,
>Krzysztof
>
