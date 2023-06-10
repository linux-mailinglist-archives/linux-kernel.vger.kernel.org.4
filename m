Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC0772AC2C
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 16:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235304AbjFJOSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 10:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235207AbjFJOSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 10:18:09 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4BE3AA3;
        Sat, 10 Jun 2023 07:18:07 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f736e0c9a8so20648315e9.2;
        Sat, 10 Jun 2023 07:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686406685; x=1688998685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e9cOOb3r9v8BRSMkdUQlBjQ12Gi0JnIYbGoQ0F774a0=;
        b=kNwy6UQTNhOxiYaxn0QFVJliYWZalve47Symz95XFyBIaz9YlzqeRGPP2Gk2ZX/S4e
         2XSb++WWR7c6+CEHm+6NxWdHPWmwQ9OWaK3Y2fLZGFPRq/7e3e6xfyCF441UX5d/TCVH
         o+BBxEhrQ1ulFxmPKAyrmVHElgN3SI2DEYycJBbPnELadGQ/D/R9q1Hdkp+2dqc5f2I4
         lHd9xVRtvrPfhvt/7sttgKpsBU70eHal+9s5GpesiZjzMlJEVC2bMT1J6VhxUXdssXd9
         f5Rt3kCxdZ8iyt7NJ68SUW+B74PFwiw2116CwZZ5L5szsaeJwXMbJ1gXynQhn3j31f6B
         lMDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686406685; x=1688998685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e9cOOb3r9v8BRSMkdUQlBjQ12Gi0JnIYbGoQ0F774a0=;
        b=AD/cfvW3fA9SdBxnBD7jo3whN5j3cMpduqk52GGKGppphJ+fPHR0h0RlSzhI/JyPnC
         AOKIcHZ2KfjjGUSMDE94wDc7I41DKG1vPzM7k08jW2gxRxfE9VdhqImyTa6qp+bJnHXS
         6fzTQ4GE6qrDH/B82dbAu+veCmtlJxYrlAPRXeYTzr9gN+X5eZ4LxcHgF363663r6hKs
         w+lZFvFEDjcbv4/gnZHpdB6K8gJbgsrzgZut1EcQJzux5RwA2C2h7vtNoHGmnKipZ/hI
         F1Yeepx1k+0Q+Rube5HUNQEakV2eY+MyEga/tVsPjNtz5ry/tM4+LTl6dP75uWNJdfz6
         J3HQ==
X-Gm-Message-State: AC+VfDzjmd20NADsGeCitwKGNaHDS6ye193cIIFn6uEvuj2m5fXBzkkN
        bICDn4L68TMeyyz3fZimpLiOjTM32sNX7WCf
X-Google-Smtp-Source: ACHHUZ4t6WdLMB1a1Zu/zRrvwabow/BVaPFCOtPx57pKegTzzSQLjim87rOjjJ0/4WboYFgCeASoBQ==
X-Received: by 2002:a7b:c454:0:b0:3f7:e6d7:f711 with SMTP id l20-20020a7bc454000000b003f7e6d7f711mr2743988wmi.7.1686406685338;
        Sat, 10 Jun 2023 07:18:05 -0700 (PDT)
Received: from user-PC.. ([178.134.198.138])
        by smtp.gmail.com with ESMTPSA id z10-20020a05600c220a00b003f735d6fa74sm5841488wml.9.2023.06.10.07.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 07:18:05 -0700 (PDT)
From:   Maksim Kiselev <bigunclemax@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Maxim Kiselev <bigunclemax@gmail.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-riscv@lists.infradead.org
Subject: [PATCH v1 1/3] thermal: sun8i: Add D1/T113s THS controller support
Date:   Sat, 10 Jun 2023 17:17:32 +0300
Message-Id: <20230610141739.999268-2-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230610141739.999268-1-bigunclemax@gmail.com>
References: <20230610141739.999268-1-bigunclemax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxim Kiselev <bigunclemax@gmail.com>

This patch adds a thermal sensor controller support for the D1/T113s,
which is similar to the one on H6, but with only one sensor and
different scale and offset values.

Signed-off-by: Maxim Kiselev <bigunclemax@gmail.com>
Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
---
 drivers/thermal/sun8i_thermal.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index 793ddce72132..01cc4e130892 100644
--- a/drivers/thermal/sun8i_thermal.c
+++ b/drivers/thermal/sun8i_thermal.c
@@ -628,6 +628,18 @@ static const struct ths_thermal_chip sun50i_h6_ths = {
 	.calc_temp = sun8i_ths_calc_temp,
 };
 
+static const struct ths_thermal_chip sun20i_d1_ths = {
+	.sensor_num = 1,
+	.has_bus_clk_reset = true,
+	.offset = 188552,
+	.scale = 673,
+	.temp_data_base = SUN50I_H6_THS_TEMP_DATA,
+	.calibrate = sun50i_h6_ths_calibrate,
+	.init = sun50i_h6_thermal_init,
+	.irq_ack = sun50i_h6_irq_ack,
+	.calc_temp = sun8i_ths_calc_temp,
+};
+
 static const struct of_device_id of_ths_match[] = {
 	{ .compatible = "allwinner,sun8i-a83t-ths", .data = &sun8i_a83t_ths },
 	{ .compatible = "allwinner,sun8i-h3-ths", .data = &sun8i_h3_ths },
@@ -636,6 +648,7 @@ static const struct of_device_id of_ths_match[] = {
 	{ .compatible = "allwinner,sun50i-a100-ths", .data = &sun50i_a100_ths },
 	{ .compatible = "allwinner,sun50i-h5-ths", .data = &sun50i_h5_ths },
 	{ .compatible = "allwinner,sun50i-h6-ths", .data = &sun50i_h6_ths },
+	{ .compatible = "allwinner,sun20i-d1-ths", .data = &sun20i_d1_ths },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, of_ths_match);
-- 
2.39.2

