Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85430702F35
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 16:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239844AbjEOOHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 10:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239353AbjEOOHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 10:07:15 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49C3172B
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 07:07:10 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3075e802738so11768121f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 07:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1684159629; x=1686751629;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n75gxWwijMMTI9GiXx1bdZzw1eSKDQ/JY3MbdqyyfJ8=;
        b=MybEwHb7tKFR+czM65dq6Won8HWSGsgYs9IN4ez2NUgHvZhPq/Fjq3SQvBRDwj2apk
         TQlRnqRGsmPdmCCiuAQcNV5mzBWUfS345LKMeMaqnYmHN1XGmlqe+rc1IsW5hQGIN2hY
         Sk7HLb6fGLLzfm46sD0+z8iN/0C24ndOXGjNqF6egg+usyu0Bf3KHWzTofwatANRJWl4
         NM6U67P7oQUYPeY4ghnVyPngLeXR/uhODxoz4qrOAMKkje2MBG2F+8kinM7BX0ZLPHGd
         S/9F6uqsD+yaKQT/H6KccQdorGqjBBxvsrr+IBeIoiXO2e2PeafrSkbg/OX5wBedzpfb
         rR2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684159629; x=1686751629;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n75gxWwijMMTI9GiXx1bdZzw1eSKDQ/JY3MbdqyyfJ8=;
        b=I4hwtEYtD4jhy9owpids4F1CeZ0uXRp97JczhGIJExObOFosVzZ4l0ojpisZDKZrjz
         THJ4zQsp462ZVWO6aY3zYAuRj7TFrg/46KpjQKXWj7s4ZiWgtX/nH+7/9BLpCgpKvYDE
         yA/fnvxJU+SdWplZmYezP20+fETAax7KlHtlfKyq7VSbI7zAJrYjMVRjAOYLUgALWKyu
         tOkI+V+A6OqMENk2KkTSQ08oclqUiLtYq6xvHkih0ozJmLSpFVHT+VBkzUxe7iTDJmrI
         Lr4V6E9o2jerrCAvq7OwatAuDQ03me1w1t17jonFDGa0+lCSPbkLwwndw3Thw1XB4daS
         //TA==
X-Gm-Message-State: AC+VfDwB7O3BuUSoCntHm4xeSsamU5T1FUz5bSKa8M30J+4NzYrcyygM
        P1Eeavu9PS7xKTsP00E9HKzKvA==
X-Google-Smtp-Source: ACHHUZ79hANfbDvpP6oNPyXKE1ftm/gHtkEaa9Icb1GGlaeSnOsVu4I4PEo/Jz9DCazNFmJCLmAmFg==
X-Received: by 2002:adf:e492:0:b0:306:2dd6:95d3 with SMTP id i18-20020adfe492000000b003062dd695d3mr30832770wrm.22.1684159629085;
        Mon, 15 May 2023 07:07:09 -0700 (PDT)
Received: from localhost ([2a01:e0a:55f:21e0:fd3b:9fed:e621:cc8f])
        by smtp.gmail.com with ESMTPSA id a2-20020a05600c224200b003f4253ddb7dsm23548392wmm.43.2023.05.15.07.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 07:07:08 -0700 (PDT)
Date:   Mon, 15 May 2023 16:07:07 +0200
From:   Julien Stephan <jstephan@baylibre.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     krzysztof.kozlowski@linaro.org, robh@kernel.org,
        chunkuang.hu@kernel.org, linux-mediatek@lists.infradead.org,
        Phi-bang Nguyen <pnguyen@baylibre.com>,
        Louis Kuo <louis.kuo@mediatek.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Andy Hsieh <andy.hsieh@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek USB3 PHY DRIVER" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>,
        "open list:DRM DRIVERS FOR MEDIATEK" 
        <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v2 2/2] phy: mtk-mipi-csi: add driver for CSI phy
Message-ID: <b2nk4jw2hpy4ndoq4cojazkn6h3tra2zjffhiswb7aqryabf7q@mkbtzhzcbivv>
References: <20230515090551.1251389-1-jstephan@baylibre.com>
 <20230515090551.1251389-3-jstephan@baylibre.com>
 <cd6067b2-660a-8f2c-697d-26814a9dc131@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd6067b2-660a-8f2c-697d-26814a9dc131@collabora.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 02:22:52PM +0200, AngeloGioacchino Del Regno wrote:
> > +#define CSIxB_OFFSET		0x1000
>
> What if we grab two (or three?) iospaces from devicetree?
>
> - base (global)
> - csi_a
> - csi_b
>
> That would make it possible to maybe eventually extend this driver to more
> versions (older or newer) of the CSI PHY IP without putting fixes offsets
> inside of platform data structures and such.
>
Hi Angelo,
The register bank of the CSI port is divided into 2:
* from base address to base + 0x1000 (port A)
* from base + 0x1000 to base +0x2000 (port B)
Some CSI port can be configured in 4D1C mode (4 data + 1 clock) using
the whole register bank from base to base + 0x2000 or in 2D1C mode (2 data +
1 clock) and use either port A or port B.

For example  mt8365 has CSI0 that can be used either in 4D1C mode or in
2 * 2D1C and CSI1 which can use only 4D1C mode

2D1C mode can not be tested and is not implemented in the driver so
I guess adding csi_a and csi_b reg value may be confusing?

What do you think?

Regards,
Julien
