Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3473690633
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 12:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjBILLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 06:11:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjBILKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 06:10:54 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB48D457EC
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 03:10:51 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id ba1so1384874wrb.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 03:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V89hB8P9aljMFaI4JVhG1UB7ptSBWBngnxQJmHuqEqU=;
        b=eL7Pu7g5g0LHCZLE/2uwHQbquviWqM+ui1NcQVYBmzALmBW2z+8w+HHfzi7ezO8PjH
         vG+xlrc8jAcgoLbxRLMLmXL4PKp/N64nj2u+BMllyaqSoxj3iSO+BZUnTkJEliT+yPgq
         9YIX0IaEIP+Bf8xcMetAcnJs10ka/AaDWf5Ku56uFmDjeltfdQ5EDeoPkAS3ujQmFpKC
         3RPwT3CAwR0GpQwxLe2OE9D0dXzIsM76RP4cahnqjS5+Q2fOXK2tjZqiTNAF825Grn4R
         gxwuTS0lAvs9Sk8V3pyIGPQNPPh1KAWKUCPJ2T/KomCWqS7haIOwwZGLrpiZDHcjFTQU
         WvUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V89hB8P9aljMFaI4JVhG1UB7ptSBWBngnxQJmHuqEqU=;
        b=YSHCrHNDE+o024S+aPlzGDBV0z9OoSlKodjz+mvhh2pN3WhqYNOlmsSsVNqn7H1K6C
         0Zk/k3Gj/ltjirTaSXSU6i6JZC9Uw7gnnZOzKZTFaD+J179SFN4MpGwsZeX+ThbqcmMb
         CRwzllMa7EkagxEzpgpDTKmHTN1wFbWyb6aTJ2EBKwPCTvHgYq9P7DkgidYtab8agFi1
         96jN0tPHmVn/WbJJ85qS8eOJs9f4z1gYEmm9ZMDOx0keZ+eJ1NiaxjFwtU5OTANi1VSp
         bmpnBSGD37rbajzL/FXujMD+WjWypaa8DLNaeUZfcxUVteESeXCVe2UJcMLhk6ibjZMY
         nF+g==
X-Gm-Message-State: AO0yUKWAX/HxD4tWaNmPrlWjzoYreyQxkYOiHq9aGobmthctnJTxv0iz
        m6XFIUI01rce5SvPf8CKw5IoBQ==
X-Google-Smtp-Source: AK7set9DRa8qVIxG0cZVTMfZRttELsRCFtgifHQea5sUv2Utsl7IJv8U5sa+TDnFwWB0SvKYeWZCbA==
X-Received: by 2002:adf:f34d:0:b0:2c5:3fcb:6823 with SMTP id e13-20020adff34d000000b002c53fcb6823mr226977wrp.25.1675941051537;
        Thu, 09 Feb 2023 03:10:51 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id q13-20020adff94d000000b002be099f78c0sm963207wrr.69.2023.02.09.03.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 03:10:51 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Henrik Grimler <henrik@grimler.se>,
        ~postmarketos/upstreaming@lists.sr.ht, replicant@osuosl.org,
        phone-devel@vger.kernel.org,
        =?UTF-8?q?Martin=20J=C3=BCcker?= <martin.juecker@gmail.com>
Subject: Re: [RFT PATCH 1/3] ARM: dts: exynos: add "gpios" suffix to wlf,ldo1ena on Midas
Date:   Thu,  9 Feb 2023 12:10:42 +0100
Message-Id: <167594102111.781687.5239598797684494010.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230208172634.404452-1-krzysztof.kozlowski@linaro.org>
References: <20230208172634.404452-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Feb 2023 18:26:32 +0100, Krzysztof Kozlowski wrote:
> The GPIOs properties should end with "gpios" suffix and Linux gpiolib
> already handles both names, so switch to preferred one.
> 
> While touching the lines, replace open-coded GPIO_ACTIVE_HIGH flag.
> 
> 

Applied, thanks!

[1/3] ARM: dts: exynos: add "gpios" suffix to wlf,ldo1ena on Midas
      https://git.kernel.org/krzk/linux/c/0e06b987d1b7469ff1b4f7a68466859f94e7221a
[2/3] ARM: dts: exynos: add "gpios" suffix to wlf,ldo1ena on Arndale
      https://git.kernel.org/krzk/linux/c/149a903eceb73b8b8af25e12b552c68aa9991802
[3/3] ARM: dts: s5pv210: add "gpios" suffix to wlf,ldo1ena on Aries
      https://git.kernel.org/krzk/linux/c/a81cc43abd23f2769b044b79f4cf58a9ff6e2201

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
