Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A34662902F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 03:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbiKOCzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 21:55:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236214AbiKOCyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 21:54:47 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11041706E
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 18:54:38 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id n20so12323727ejh.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 18:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T9alcK7r3LRGbBbynWJVNVjV7+oLSYlMvkY8RpXQxqg=;
        b=AeRSmX7lhIaontjUHPn4JbetLS7qS7t8sLO0isFCkk3keEMZXIyquJ+imX5LA0z8Bo
         k3Klyxo0yZyEtm2tOfIeFxXnE3GYFGT+7TrQU+pR+3sSR5V5BbRnZ+cnyIfYZk/kZeX0
         PcICYdGS9UtMMTSeI0xrRzNDHNb/XWLqcftSi8DL82oyes/KPQcUdLkrMHw4GNgl3vda
         tpNf072BglaX2v7yC2LQ4hReg90Ja9ivGBTvvSDYNvhv0yt5gJ74dMs34jBQJM7WSkVk
         xu2JUwIWyMvyGvkjB+Sxew4jGeauFk6q/T6u8el/s2OZziDzlsTbft0w/5tW9VkeDTHp
         bUAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T9alcK7r3LRGbBbynWJVNVjV7+oLSYlMvkY8RpXQxqg=;
        b=LOuipYg4ED1os60hEMlljmv8MOwNPCGVvMDWiY0ftgLN2TZa+Xmnf7pqnbG0SVj96O
         RynpxXp7+bHtxIxszvfBDB8EqCS8YC8wB7siJ5AQxh6Mch4EH9AlFWjn3qySsNntg1gT
         8crhW4MrvoAgAd5tMRR5V2dUQRrpl9eWpUVSXNEzL5sdsSikRrtt7zKDf9ZNfJLT6BTE
         skII3tv2pJgvFFOjKSEqJTwBvfJKvU27n2aOgV0BAYhzK9cp/EbigmuFqcuRX/6EmACt
         ApgHL+Zfb/RDIOOxYtnwX2Q6FXpym6DSYj7RuzYIM2H8ygPbBLjmfCcfz30SNyDXLLM6
         dNxQ==
X-Gm-Message-State: ANoB5pl9VYTg9kli+SJaGfuZ6aDNxLxV7t8iZqOSFyY7SbJCVNlj9yhW
        fbZjK7x+JVgPAfXnxgzPMkL1ug==
X-Google-Smtp-Source: AA0mqf4wY0ggW4eD7zSQVKy7LwsAsjZgEXrVPUJBY43VMe4uCQdmo3KTeiMg+cwLesBG/auDuQ6ZYw==
X-Received: by 2002:a17:906:7ac7:b0:7a5:7e25:5b11 with SMTP id k7-20020a1709067ac700b007a57e255b11mr11870840ejo.254.1668480877138;
        Mon, 14 Nov 2022 18:54:37 -0800 (PST)
Received: from c64.fritz.box ([2a01:2a8:8108:8301:7643:bec8:f62b:b074])
        by smtp.gmail.com with ESMTPSA id l9-20020a1709063d2900b0073d9a0d0cbcsm4861177ejf.72.2022.11.14.18.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 18:54:36 -0800 (PST)
From:   =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>
To:     linux-mediatek@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com
Subject: [PATCH v2 10/15] dt-bindings: timer: Add compatible for Mediatek MT8365
Date:   Tue, 15 Nov 2022 03:54:16 +0100
Message-Id: <20221115025421.59847-11-bero@baylibre.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221115025421.59847-1-bero@baylibre.com>
References: <20221107211001.257393-1-bero@baylibre.com>
 <20221115025421.59847-1-bero@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt-binding documentation of timer for Mediatek MT8365 SoC
platform.

Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>
---
 Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
index 8bbb6e94508b2..c1f40aca2d48c 100644
--- a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
+++ b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
@@ -20,6 +20,7 @@ Required properties:
 	* "mediatek,mt8135-timer" for MT8135 compatible timers (GPT)
 	* "mediatek,mt8173-timer" for MT8173 compatible timers (GPT)
 	* "mediatek,mt8516-timer" for MT8516 compatible timers (GPT)
+	* "mediatek,mt8365-timer" for MT8365 compatible timers (GPT)
 	* "mediatek,mt6577-timer" for MT6577 and all above compatible timers (GPT)
 
 	For those SoCs that use SYST
-- 
2.38.1

