Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91021616E82
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 21:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiKBUWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 16:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbiKBUWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 16:22:01 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2833C60D2
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 13:21:59 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id hh9so16441qtb.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 13:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lNJVosPNdci0vHdXGVs2cdHuEF7DCHwmyiOAOfe3bjg=;
        b=aag3Q6rvohNiU2mvHEM/YNYMwiTlmVlXjpg2FkFSf2xvsl4jlUZe2s3GGDSTnb7Ule
         1ztKxAm0hvppt+0TkbP9fVRWxWHq18cr2bQ34aEgoo1yYATiCBtrbt31+X46FHnC5S3t
         fpJJ/7woPzc6EzA+DxDjwd1K0+HMUUXFmjdKKGGtcM9c2OM+S7SWdzldPaBwFJF6PGfV
         oqnugcvbFdyJMMLqniuNW+3OBLz5Tfo9miucJN/UvRfQG8tYKbFOsGlA/fTq6c9UMWm6
         mWybycEUQ+vnkYg8oqXmEp4PBrgxWQh/xrKqwhFZ3QtnJK/VzTITp9l6uyTz3Cr+dgDU
         mcuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lNJVosPNdci0vHdXGVs2cdHuEF7DCHwmyiOAOfe3bjg=;
        b=cJphyldpN9jV9pJSgSRgBbVaBK/I9IXmtmV4DWMEzbkoDbnfLh5MTXum8fK5IYHUcn
         AfEb2CDztR57FZZbzxVBFBeEzdqRjOY95uF0sA66BusXxDJhGJVRxPeqU2mfkurwy41m
         49FEZMk3KkecC8gdB0z3emOn09ixAK/xPhKY5N0is9Y+mRQTD/6WGLJ3rxHry6t16ZvB
         UBoephZEkZdpxVN4fTR7joDPvSV7IGgwnrTV/SnFYJ9/9q5zcX/Y5NQA25Z56FOj67+z
         VqRRsLH4klAj2eEPyI8VTOaN57y173AAGxyg8dCPjtvl5j8n1hWkds3TjxTgUdz8qH4L
         u9ow==
X-Gm-Message-State: ACrzQf2r4JAi0i/tKdggaToUMsM+WP1QleW+zRM7RPMeEXMkGTDMygUc
        UAkVeVIgDNgoRC0Y5weyQxLdLw==
X-Google-Smtp-Source: AMsMyM55attEsYX0NHeDvMJiDWhSkZby8BQWWdMuvTRAlvzA5XgZG0q3sde2KYvGY5AfXLic9icfWQ==
X-Received: by 2002:ac8:5245:0:b0:3a5:3e52:2d97 with SMTP id y5-20020ac85245000000b003a53e522d97mr7396482qtn.121.1667420518371;
        Wed, 02 Nov 2022 13:21:58 -0700 (PDT)
Received: from krzk-bin.. ([2601:586:5000:570:28d9:4790:bc16:cc93])
        by smtp.gmail.com with ESMTPSA id f11-20020ac8498b000000b00399ad646794sm7119581qtq.41.2022.11.02.13.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 13:21:58 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Pierre Gondois <pierre.gondois@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob.Herring@arm.com, linux-samsung-soc@vger.kernel.org
Subject: Re: (subset) [PATCH 06/20] arm64: dts: Update cache properties for exynos
Date:   Wed,  2 Nov 2022 16:21:55 -0400
Message-Id: <166742051292.139492.12539582422109367063.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221031091945.531874-1-pierre.gondois@arm.com>
References: <20221031091945.531874-1-pierre.gondois@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Oct 2022 10:19:45 +0100, Pierre Gondois wrote:
> The DeviceTree Specification v0.3 specifies that the cache node
> 'compatible' and 'cache-level' properties are 'required'. Cf.
> s3.8 Multi-level and Shared Cache Nodes
> 
> The recently added init_of_cache_level() function checks
> these properties. Add them if missing.
> 
> [...]

Applied, thanks!

[06/20] arm64: dts: Update cache properties for exynos
        https://git.kernel.org/krzk/linux/c/58710ae94589a2b2baaab6b6986064b691124b0d

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
