Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2B3765F142
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 17:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233840AbjAEQe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 11:34:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbjAEQew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 11:34:52 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EDA418B1F;
        Thu,  5 Jan 2023 08:34:49 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id h16so36629633wrz.12;
        Thu, 05 Jan 2023 08:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0lAIo3spWClLaTdCHxySX0ouHrSXLWypZM77NTYweN4=;
        b=eBDP8rvyt7dl//bCEO8LrldKofxFCS2KF4Gz8zBBX2kN4AQ2DAyM5YtayeT/dDYKMg
         X0Qp+gHtvnsVqnvSh9SD/U926xqPOw3bgmfAF0B/I4fUm+eTNalEO6RSdX/2Vc1y6PmY
         2woD/uit8a55nMlZlxXtbdL9+J9wxo8KzddOkDuHrFBwRc31dZCT3LTIxdf1f3kIoIIi
         No3OceHFZJWaJc9wj9QuvxRrsQUItTOk3vS6FIMBWL+dBJ8nyNvfXhO+pvMa0m4w3LIF
         7f2XQhQswdzkH7Z/6s7q4fOaDvzs0pjAz0n4OMOKCGJ3VtxZICs/9YUCTYxjePtFm/tb
         RSUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0lAIo3spWClLaTdCHxySX0ouHrSXLWypZM77NTYweN4=;
        b=l4gt88WMWkxsbVVzrafmr8eyZ4PDTArme0EJcxdXiAqUOMapocdw5QHiLGDE5sitEW
         7Z91jEqL372ixpdk/XqmSL0Tht1T2JVQCeOeKa7b1fs0GTcpUQE+XuYgl7ymgQr0HQLv
         8BKkNPyXdGuB0+9h62IoxgkOoL0TNAd/IVpJ4tqssSwolWfSo69rRtGOKSfUj5KilkVT
         2WGbNo8K9t4RQh/Z4qoshnyz/mSpOnDJCHDwHloI0hCdQwV0JfQZ218n2nq1rZt4Furj
         jrunx7i7vk06ENiUkmsWGxh34Df4qfOjR2iN4B8GVuK0QoZqAkRooGxu/QFvck9zpc+4
         S5NQ==
X-Gm-Message-State: AFqh2koghBee4WgFDV+G3KF6MVhcS6o5+0NpfMP5R4A9nmbpNla2EtvM
        JYousHJF0PzmamcHK6lXxAw=
X-Google-Smtp-Source: AMrXdXu+KA2fB53cJsZQeu9XcWeoxFE9i61XhKCbJ/q9IJZHzllc3rqNHO8IHGwyEIhC6Mu/EMwedQ==
X-Received: by 2002:a5d:6e8f:0:b0:276:473f:7120 with SMTP id k15-20020a5d6e8f000000b00276473f7120mr32573146wrz.26.1672936487924;
        Thu, 05 Jan 2023 08:34:47 -0800 (PST)
Received: from jernej-laptop.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id s18-20020adfdb12000000b00241fde8fe04sm37319469wri.7.2023.01.05.08.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 08:34:47 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Samuel Holland <samuel@sholland.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 0/2] Allwinner power domain support
Date:   Thu, 05 Jan 2023 17:34:46 +0100
Message-ID: <1915282.PYKUYFuaPT@jernej-laptop>
In-Reply-To: <20221231160402.16157-1-samuel@sholland.org>
References: <20221231160402.16157-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sobota, 31. december 2022 ob 17:04:00 CET je Samuel Holland napisal(a):
> This series adds support for the power controller found in D1 and other
> recent Allwinner SoCs. There is no first-party documentation, but there
> are a couple of vendor drivers for different hardware revisions[1][2],
> and the register definitions were easy to verify empirically.
> 
> I have tested this driver on D1 with the video engine. There is no DT
> update patch here to avoid dependencies between series. The example in
> the binding is what will go in the D1 DT.

So such driver is needed for H616 for GPU? Or is power domain handling 
different there?

Best regards,
Jernej

> 
> [1]:
> https://github.com/mangopi-sbc/tina-linux-5.4/blob/main/drivers/soc/sunxi/g
> pu_domain.c [1]:
> https://github.com/mangopi-sbc/tina-linux-5.4/blob/main/drivers/soc/sunxi/p
> m_domains.c
> 
> 
> Samuel Holland (2):
>   dt-bindings: power: Add Allwinner D1 PPU
>   soc: sunxi: Add Allwinner D1 PPU driver
> 
>  .../power/allwinner,sun20i-d1-ppu.yaml        |  54 +++++
>  drivers/soc/sunxi/Kconfig                     |   9 +
>  drivers/soc/sunxi/Makefile                    |   1 +
>  drivers/soc/sunxi/sun20i-ppu.c                | 207 ++++++++++++++++++
>  .../power/allwinner,sun20i-d1-ppu.h           |  10 +
>  5 files changed, 281 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/power/allwinner,sun20i-d1-ppu.yaml create
> mode 100644 drivers/soc/sunxi/sun20i-ppu.c
>  create mode 100644 include/dt-bindings/power/allwinner,sun20i-d1-ppu.h




