Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B8169E675
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 18:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234890AbjBURyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 12:54:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbjBURyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 12:54:20 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD1F2F787;
        Tue, 21 Feb 2023 09:54:18 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id da10so21793554edb.3;
        Tue, 21 Feb 2023 09:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=syuBBfuFNqUVEt5myTUHBWQU/zXBUecumwT+b6a2b1M=;
        b=AGZu5gEIPSYKRYNzAgI8kqaU/PIpT5EgeijlR8isi/ANHPYmgW67diC/jEcjZDEWpt
         E2dmehxpVEZKDz0KC23oqFrFjmrCjJNiIqouPGXqdgm5VkPmiSBk9mMCTDWvCFl5zOAI
         2H5HEe1K6nei1UNg1NyoxqlCTZH4MKNN/AW8MZfid9KtlihlxCJYt2RI5lCwdVTzoJiX
         BTMKogf3TPtRk01ks4ZNHGBshuIxOWkN0iI83rlGIf8W1W/VaIYvJiwYUEiMfGxbWox8
         LLusaZJH6yDDaG3QALS1IKA3nf5O3T4VS50FLbBo8KAIxx5Mb0aZ8cfwVVePvLuEFufg
         JZWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=syuBBfuFNqUVEt5myTUHBWQU/zXBUecumwT+b6a2b1M=;
        b=XgSiOlNyeLLNIAnqLWwonKIOVRMg7LllAR/3Lzpp4Au6KG6wkFTH1sI0DQkvG05Lev
         lMt20eTkBDoI4FbLBcWIj7+s+Ftglzr6cvWiFrreCWg6t+U0luXAM5MgMKHG9qhcJKdk
         Whl0Xff5LFOUUmd9cyilbAC7YmI68rD70xioQoWxI2lBBbUQYP1lu9kumh9GkyNoatzG
         A1jUfazNU2E2Abdg8ZrEpxE1HAt5TmJ3r5CmxDqN+v4NlrR5ADMnj78aagE27VMLH4k5
         Pd80/IhSJbicOxmXUxx86s53yYfV+pFH5kW0SPu5Hz+JOvbfOLbzTA6RdcqJ+Djzpk3T
         rykA==
X-Gm-Message-State: AO0yUKVJVt5NsrXjJZSXhMOxMGGWQwPkQGq4U5EFkUMoqH35rkWm/bgb
        GPhepbYNkf9AjfZFerjz5ik=
X-Google-Smtp-Source: AK7set846FyhuiAgWy0WS2GFPkCRZ5tlaV8I3dfbPtfUTgCpETfP8lkevOXLrTwB5EBNaoRNLtc0WA==
X-Received: by 2002:a05:6402:2485:b0:4ad:52bc:2780 with SMTP id q5-20020a056402248500b004ad52bc2780mr4470118eda.2.1677002057503;
        Tue, 21 Feb 2023 09:54:17 -0800 (PST)
Received: from xeon.. ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id b3-20020a170906660300b008e493b7bb61sm236357ejp.153.2023.02.21.09.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 09:54:17 -0800 (PST)
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 5/5] tegra30: peripherals: add 266.5MHz nodes
Date:   Tue, 21 Feb 2023 19:53:48 +0200
Message-Id: <20230221175348.15681-6-clamor95@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230221175348.15681-1-clamor95@gmail.com>
References: <20230221175348.15681-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some devices may require this entry for proper work.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../arm/boot/dts/tegra30-peripherals-opp.dtsi | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/tegra30-peripherals-opp.dtsi b/arch/arm/boot/dts/tegra30-peripherals-opp.dtsi
index d100a1a8b705..a2d557155114 100644
--- a/arch/arm/boot/dts/tegra30-peripherals-opp.dtsi
+++ b/arch/arm/boot/dts/tegra30-peripherals-opp.dtsi
@@ -210,6 +210,20 @@ opp-204000000-1250 {
 			opp-suspend;
 		};
 
+		opp-266500000-1000 {
+			opp-microvolt = <1000000 1000000 1350000>;
+			opp-hz = /bits/ 64 <266500000>;
+			opp-supported-hw = <0x0007>;
+			required-opps = <&core_opp_1000>;
+		};
+
+		opp-266500000-1250 {
+			opp-microvolt = <1250000 1250000 1350000>;
+			opp-hz = /bits/ 64 <266500000>;
+			opp-supported-hw = <0x0008>;
+			required-opps = <&core_opp_1250>;
+		};
+
 		opp-333500000-1000 {
 			opp-microvolt = <1000000 1000000 1350000>;
 			opp-hz = /bits/ 64 <333500000>;
@@ -424,6 +438,12 @@ opp-204000000 {
 			opp-suspend;
 		};
 
+		opp-266500000 {
+			opp-hz = /bits/ 64 <266500000>;
+			opp-supported-hw = <0x000F>;
+			opp-peak-kBps = <2132000>;
+		};
+
 		opp-333500000 {
 			opp-hz = /bits/ 64 <333500000>;
 			opp-supported-hw = <0x000F>;
-- 
2.37.2

