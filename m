Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A44EC63D79F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 15:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiK3OGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 09:06:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiK3OGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 09:06:18 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDEE769EC
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 06:06:15 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id ja4-20020a05600c556400b003cf6e77f89cso1556287wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 06:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=newflow-co-uk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=fYLdV6GRz5Ju2T6ejCA2CmepPlL7SuUYQ7FRznedctw=;
        b=kuun4qE0EiIX95QdeuH6JmmoXmhpryE2PdzPk2n+Y5eh5iNFX+qlfVtLg6LC8bgFqb
         2mpgKgc7QMzQWC7/mE9O1pbyRZ4IuSiNp/9IbJFasaKVrtVVdx3TWQyUsFtKJW5+mero
         e8xBwGPTjlFYnKobGvUxj1/RnyQ55rsjGn9twyWIxvu5Ct2UmpjfN6HJ+OgIRSA0lKXc
         UO5kDgggrAjMaofrIsdqWabEM0+DeLTCyjW4AZypBuaWtVhnU0fR9qP/7dnyVRHWDdLh
         nCuSl1WCJ7Q93Jr65BHalkxd/2ZG2ly6O5zLPzb7YMbs8yAFHxg2mkAfbx0zbnJbbIH2
         0cyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fYLdV6GRz5Ju2T6ejCA2CmepPlL7SuUYQ7FRznedctw=;
        b=0H/WqAUR9rBh9sBmtqb/mHu4yrWOrSAh+MLQ4Lfr5GWg2S7TD/pg1/n5xAjGPIH2Wh
         131oykfCyuuQ5sEGoOIHJ7xt9n4RWO/Kk8quKRUlYv0st+9ClpBSMllxrHiJHuv9uuJP
         yiYNIKv2LhRyQn0r491vuigYXv2NCQ5W/LcUjUhgFWxwkp9SOB7WW8xLmH64wEPJDUye
         JhY4ukXi7nZfoupzi8Fr/RGByiLgz5I+KGHoXuQgGteQ2eDxVw0fegvde9vUJs1bU45T
         ZyudZUumj8AiLKB2ylv3wsv6e1WSOCUP23ZaThZtxv9jkOYJOvw2sWP0quMcW+8GCuFq
         t2ng==
X-Gm-Message-State: ANoB5pl+DTBEcm2NbSc9wGe8/VOu+iUkcgEC8EbZP0AmZqWJs9XAotVU
        Ct5vKORXAREP9IWdEBhPKNgPCg==
X-Google-Smtp-Source: AA0mqf4JjwqB9oF5df9Y5AdAXQ3SO1fdRtMzlmNaPjYAXlFVvGFHcE+8rQQVp85lizvqjnNG0EoQRg==
X-Received: by 2002:a05:600c:6012:b0:3cf:cb16:f242 with SMTP id az18-20020a05600c601200b003cfcb16f242mr37121882wmb.82.1669817173945;
        Wed, 30 Nov 2022 06:06:13 -0800 (PST)
Received: from mpfj-unity.. ([94.12.112.226])
        by smtp.gmail.com with ESMTPSA id v128-20020a1cac86000000b003cfa80443a0sm2062542wme.35.2022.11.30.06.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 06:06:13 -0800 (PST)
From:   Mark Jackson <mpfj@newflow.co.uk>
To:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Mark Jackson <mpfj@newflow.co.uk>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 RESEND 0/5] ARM: dts: nanobone: Fix missing/incorrect features
Date:   Wed, 30 Nov 2022 14:05:42 +0000
Message-Id: <20221130140547.295859-1-mpfj@newflow.co.uk>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series updates the NanoBone DTS file to address various missing or
incorrect features.

v1 -> v2:
  - Move temperature sensor definition under I2C heirarchy

Mark Jackson (5):
  ARM: dts: am335x-nano: Fix GPIO settings for RTS/CTS pins on UART3 & 4
  ARM: dts: am335x-nano: Enable RS485 mode for UART3 & 4
  ARM: dts: am335x-nano: Enable I2C temperature sensor
  ARM: dts: am335x-nano: Fix GPIO settings for MMC pins
  ARM: dts: am335x-nano: Enable USB host

 arch/arm/boot/dts/am335x-nano.dts | 32 +++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

-- 
2.34.1

