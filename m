Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C153E67E0FB
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 11:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233329AbjA0KDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 05:03:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233236AbjA0KCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 05:02:51 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1B78A54;
        Fri, 27 Jan 2023 02:02:50 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id y1so4489685wru.2;
        Fri, 27 Jan 2023 02:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DVjNs8ApiQ/q6Yn0xoVLNbwQz1nduDbWHI8WGclaVYg=;
        b=ENBAfKMwVYuqJWFy6oHCDHqOaVxIZ+7bd82RfqrryF4RV18JDGMgeQv7OfAgDv3iPl
         2YvQ7l6/X/sPqNrpS+Z7cqxqwINwNtdw8U8f12NCQIJuNZrHvHBk2ieXUc+5ePyzoFu4
         XQfaL2V6VL34lQ8bJqXt8Ge/geTWYAQSNGZdzyx66uNqJBIFdiCuarGwaXcD+Z5/Fn73
         7z0bwUu2eGP/u51KXdY4mBjuKsFTVjIbdyHtv0k6ywlmUzUjPMzSjEYtP6h1wHXf7znp
         98xXZWlWdrraqYsQOoiA8IN0XH4V5jD5tdds3v99qacADoVaf2Ho+BEvSEd1nAm4Vtls
         qCeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DVjNs8ApiQ/q6Yn0xoVLNbwQz1nduDbWHI8WGclaVYg=;
        b=23sMZV+EQR1doXJl5QpU/SVqMuXaaaXYL4/DIwN7VnEetV/+E1hqpXaNjWKo9BUDot
         B2+QreARtCZ65br0z+UoMQ/m5l6DgcBLE6Og3OuXkm+FmcKh+HSxjuKeTocoknYJp3Q1
         81GG9aKX5oDGbqoQYVdKKd0bia4Yeu9HHsuTcStGG1R1uGNEGAis7Zz0nArR2blQaB0o
         pIt/Ho94IdKN5HgaVHLkWXJmWgHj4tKIqUXbwK87c2pV3ObZgj6grOL2L3mD94Sz/4Ki
         zzsl73/tEW8MKQvuh9lDXc6BX3/IUVwwzF+oN7w/9t2e0U31DIbRSAI/noNyRudQGUWZ
         RRng==
X-Gm-Message-State: AO0yUKVQUUJ/t2bOtSBUkumF7kjkLvpHHRLmRTkJLNSBGw0l1sdbkvJs
        a0rtbo5hwv2wu4NTePljleU=
X-Google-Smtp-Source: AK7set+o2e/q/0/mxVxRI/tuvZJX3Fc0uHM/KRU3TL0Yria4HgEzC+zBCGB11NLZglehk3lbfjREFA==
X-Received: by 2002:adf:db12:0:b0:2bf:c518:b060 with SMTP id s18-20020adfdb12000000b002bfc518b060mr5128556wri.20.1674813768717;
        Fri, 27 Jan 2023 02:02:48 -0800 (PST)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id l7-20020adffe87000000b002bfbe30e8f8sm3493858wrr.98.2023.01.27.02.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 02:02:48 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 3/4] dt-bindings: arm: amlogic: add support for BananaPi M2-Pro
Date:   Fri, 27 Jan 2023 10:02:35 +0000
Message-Id: <20230127100236.3385154-4-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230127100236.3385154-1-christianshewitt@gmail.com>
References: <20230127100236.3385154-1-christianshewitt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BPI-M2-PRO is based upon the BPI-M5 using the Amlogic SM1 (S905X3) chipset.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index e16b5fa55847..e935c92ab346 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -176,6 +176,7 @@ properties:
           - enum:
               - amediatech,x96-air
               - amediatech,x96-air-gbit
+              - bananapi,bpi-m2-pro
               - bananapi,bpi-m5
               - cyx,a95xf3-air
               - cyx,a95xf3-air-gbit
-- 
2.34.1

