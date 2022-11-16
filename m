Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D0C62C7AD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 19:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233773AbiKPSbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 13:31:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbiKPSbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 13:31:40 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928F84731C;
        Wed, 16 Nov 2022 10:31:39 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id j15so31363028wrq.3;
        Wed, 16 Nov 2022 10:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7vuZ7CJY0ycdtFnuj3y46+D+gGNut+18NmhYqgD4cCk=;
        b=A/b/gFWWIaZlP6nO+upfw//cia6u0pLcYbWigMSSijt+xIwlVox8kgoiXerfwh95jp
         FFnoK0GK8C4ffBg+U6/cUP7ws2NLQCeHsF28R4oPhjsDqMol77cjmXNiajaX2FvNrAnP
         /ZbLdjAs0n3lGPV3WONNlusIWlqxuJLqheDpbNihS7h2GVF500g/opMZ/ZcUvR8LnWyn
         MqdD/dk01/CoasVdQszbdX9R9yfeL2z7P2DyDgEcyTbpyasSdAPIroAVQRo5VOJmhmHQ
         DGWkj7LXOXys2i/M5n/B1jC6GBjHrECYWTcYeEyPiD2r0wOFMR/uSMbeMDRsxU/lt8W9
         HpUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7vuZ7CJY0ycdtFnuj3y46+D+gGNut+18NmhYqgD4cCk=;
        b=S/QZesHpylbTOR9725LhdU4fHqq6ddlgvprkgBQjfKOpITuhzkvo39DJoVbVGbK22h
         U363kYg+i8kraRIJ3qIjOOBQaPobo+cwRujsYpRwQJ+EflrJZIt7MDmw0Ip2tsLxuvrB
         +lwZ/K8jb+Tthm2ANIpwirACStgrijmetuevK8zUn5RUDLXv5fIG10LH9DIR6hwFJO1Q
         hekYH7T3bmd9vfmAFUsEXh6rzLQKT5jltNbCLzvc1EcpKEnfE3rXCi5QfBBWrBIp44DT
         iBTDk1LwrvO2pyuWSnVsW0NeQlUY1OsccjI4r4WkNAuA0VO5N8NoWXtmXfJ70CfJAfVk
         +WFw==
X-Gm-Message-State: ANoB5pk2UPOb5LzMN/oKqtA0sjQ0RfbkJtCEklMS6Lu5xlC/oWtevkM7
        18TEPBe6fnlUV9GJz/5b0uQ=
X-Google-Smtp-Source: AA0mqf4Nc6OJ4lu29BUhXlv7SudGsN5nC4mOB29eH7ww/WOvGUmd1JJSnE5wzY5KO03EZEtlmaxDSw==
X-Received: by 2002:a5d:6885:0:b0:22e:3460:5e28 with SMTP id h5-20020a5d6885000000b0022e34605e28mr14796361wru.211.1668623498036;
        Wed, 16 Nov 2022 10:31:38 -0800 (PST)
Received: from kista.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id o12-20020a05600c2e0c00b003b50428cf66sm2611152wmf.33.2022.11.16.10.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 10:31:37 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Samuel Holland <samuel@sholland.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Chen-Yu Tsai <wenst@chromium.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] arm64: allwinner: h6: Add IOMMU reference to Hantro G2 decoder
Date:   Wed, 16 Nov 2022 19:31:36 +0100
Message-ID: <5619569.DvuYhMxLoT@kista>
In-Reply-To: <20221115090644.3602573-1-wenst@chromium.org>
References: <20221115090644.3602573-1-wenst@chromium.org>
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

Dne torek, 15. november 2022 ob 10:06:42 CET je Chen-Yu Tsai napisal(a):
> While doing some decoder tests with Fluster and Chrome's VDA tests, I
> found that the Hantro G2 was failing, and there were IOMMU fault errors
> in the kernel log.
> 
> Turns out the decoder is behind the IOMMU on the H6, as shown in the
> user manual.
> 
> This series adds the "iommus" property to the binding and the dtsi.
> Please have a look.

Applied, thanks!

Best regards,
Jernej

> 
> 
> Thanks
> ChenYu
> 
> Chen-Yu Tsai (2):
>   media: dt-bindings: allwinner: h6-vpu-g2: Add IOMMU reference property
>   arm64: dts: allwinner: h6: Add IOMMU reference to Hantro G2
> 
>  .../bindings/media/allwinner,sun50i-h6-vpu-g2.yaml           | 5 +++++
>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi                 | 1 +
>  2 files changed, 6 insertions(+)
> 
> --
> 2.38.1.493.g58b659f92b-goog


