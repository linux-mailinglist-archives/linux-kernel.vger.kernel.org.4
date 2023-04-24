Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D076ED5C0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 22:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjDXUAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 16:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232815AbjDXT7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 15:59:50 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826D71AE;
        Mon, 24 Apr 2023 12:59:49 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-94ef8b88a5bso714412266b.2;
        Mon, 24 Apr 2023 12:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682366388; x=1684958388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SfzbbQMKtZ6pNWHjqROvt8NUNsppjtk4tv5OODMyIJQ=;
        b=rTft6vgnkDSyz11Uvhnevn/YDIAU0GNs5euOC8JLM/KYzoNiDApKthdHmaUvz9BYOj
         xjrLTeZrD7hVLY01DEPuSgavi14k0HVbyB/SYnNSQAfaPb0NqWaSxglQqIcrPjcNb8VY
         XAWsuPM+M//iF6Ibj0Ab7BYMKVxyrdPJQiVDByeF2RD8upD4YP3lVkRQbr61PuwYda+o
         NzW3zbFHOGeYAu14u3i15YkUYhLXRI0f98VIooPqiaqs1eMI73EFkPq08rx5s2HEUFfv
         vryrrB02q9kxRO941q165OfJAvD7oJTFavksSzLSrmwDuZZBZBtIKwMfAgNxa+VYBJtd
         D2Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682366388; x=1684958388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SfzbbQMKtZ6pNWHjqROvt8NUNsppjtk4tv5OODMyIJQ=;
        b=GBfY2uL7pQmTnKIrLCLXbl4877y2rr34a8cTexNfvU6ko94kYJU3EVxE059/XPhH3W
         3b1vyQ9jki98pDd2PF0misliY7ZRznRnM3P5N2Pi4CU3gIT4+vaaZJWC5RPCeLUV7+NV
         0iOREwQzf5MDy5krMQjsjkev1ITZ4Ief76Cngffbed2tXZmHVS2LkiReVo1ShIRbu5Fn
         9WKx5R9L9fW2kDtUxqRpXbzbFOl5m9naEy3rWVWRiyrZIkHq/tnzLSrt3qi1aNKreyp6
         fwzTVRHqSIl2kL4oGyl2gkzrK1QFpTopqO+MUoJqcnRrEbit1s7I4Yg3yXsivOUopOHW
         xiqA==
X-Gm-Message-State: AAQBX9f/yeqZ2sM2a8hHFYIqmAdd+ZInL9CdRaCzvbvGrjRif4xt+Wbu
        fB6b2Le8leS3hiYzaHN1MGg=
X-Google-Smtp-Source: AKy350bQP7cOQA5rf30OAirCb9kcsxaBObwGZVtLing0vHj1EMwP+frcY/0IBsTkTmS0nPvA55ppNQ==
X-Received: by 2002:a17:906:3391:b0:939:e870:2b37 with SMTP id v17-20020a170906339100b00939e8702b37mr10544328eja.70.1682366387914;
        Mon, 24 Apr 2023 12:59:47 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id hy12-20020a1709068a6c00b0094f09cd4658sm5956355ejc.71.2023.04.24.12.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 12:59:47 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] arm64: dts: allwinner: a64: add missing cache properties
Date:   Mon, 24 Apr 2023 21:59:46 +0200
Message-ID: <2676764.mvXUDI8C0e@jernej-laptop>
In-Reply-To: <20230421223137.115015-1-krzysztof.kozlowski@linaro.org>
References: <20230421223137.115015-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sobota, 22. april 2023 ob 00:31:37 CEST je Krzysztof Kozlowski napisal(a):
> As all level 2 and level 3 caches are unified, add required
> cache-unified property to fix warnings like:
> 
>   sun50i-a64-pine64-lts.dtb: l2-cache: 'cache-unified' is a required
> property
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> 
> Please take the patch via sub-arch SoC tree.
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi index
> 62f45f71ec65..a9c7f82c2c66 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -93,6 +93,7 @@ cpu3: cpu@3 {
>  		L2: l2-cache {
>  			compatible = "cache";
>  			cache-level = <2>;
> +			cache-unified;
>  		};
>  	};




