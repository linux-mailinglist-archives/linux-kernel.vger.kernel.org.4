Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7674C72B83B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 08:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234358AbjFLGob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 02:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232917AbjFLGo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 02:44:28 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004EE10FE;
        Sun, 11 Jun 2023 23:39:27 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-30fc2b44281so448747f8f.2;
        Sun, 11 Jun 2023 23:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686551703; x=1689143703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YepcUjgWrlzucwsUXaypG8Xwm55IhlbZIwruLgPvyBE=;
        b=RAXWAKcHr2fHDZy3084Pxh1fAS1mmoeTzWF5mIkFo5KvN9KS3JJfQ3y73umfQ0ADHO
         Vw+SRA+WDZVGXcS4S/Isa3SytBHIvvaEUbzE0r3P9ip4b6CtT3Kky1e58l2snslsRBu/
         xmaazXnxnvAKUpMTV+FMsNRdwCIt6LcPQmlVGh/GnZJdJ7DqBgbtBHl/0lVQdDaNFMTw
         Dp9pLsEB4RAANHU7SjPr1ZsHFvjZc8WIFY0bNgYOOEIy21dHtiNl0bbFmN8cmCyelI47
         u7X3RODmEuxrdx5zfCcYC7+ZDeXW6wEevJpi5ChryoPT0a6RGJkZ12UD8Ue+yxwN7AzC
         6bbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686551703; x=1689143703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YepcUjgWrlzucwsUXaypG8Xwm55IhlbZIwruLgPvyBE=;
        b=TYaZ3BDMYpPWnonGUcLT28R1QHJvvU+6Vi/XcZNrT1eQ3C0PuKGMOgvOgPvdk5RblB
         Sv1w00zEe4dUlgmqoIIbBxL7ns5MDMouwKrAgLTL9jsAVAYpzw+7RE8FGbyM378A94N0
         hhEBU6ruJKibQxutSpLnHP5r2+1I6wB5bPPN7CuOecPlvkw4WayudPL8vqPYhb8QbM35
         rtl04lvih2BVJadVcS4Z1svqoTSKX7HmihLSFvvEqVKdNwTytChWmm+4HE/A8zf9LAmD
         oW3HWQ/28P57ntwyFsa/TzuK+IpkmKH7PPHoxhaFPbkURfLLpfwDz5HZ1N3+FnuQtFN2
         jwTg==
X-Gm-Message-State: AC+VfDyRq6mAGwys1Xub9gzsfZ8kIB4ykGQyj3m8ZaAc/eVVrvlg2UNi
        MDg41B9TTfhXUoH0pK5Feqv9AzNObFr5JjML
X-Google-Smtp-Source: ACHHUZ5c3ENgnxBDmdwbKjJgG2r9vxDmmJ8OSLRnoLrVlqqVH1uW93jhBfXPDDywePJyx2FDodyO4g==
X-Received: by 2002:adf:fec7:0:b0:2ef:b052:1296 with SMTP id q7-20020adffec7000000b002efb0521296mr4041601wrs.22.1686551702900;
        Sun, 11 Jun 2023 23:35:02 -0700 (PDT)
Received: from user-PC.. ([178.134.198.138])
        by smtp.gmail.com with ESMTPSA id o7-20020adfeac7000000b002fed865c55esm11484811wrn.56.2023.06.11.23.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 23:35:02 -0700 (PDT)
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
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-riscv@lists.infradead.org
Subject: [PATCH v4 2/3] thermal: sun8i: Add D1/T113s THS controller support
Date:   Mon, 12 Jun 2023 09:34:18 +0300
Message-Id: <20230612063429.3343061-3-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230612063429.3343061-1-bigunclemax@gmail.com>
References: <20230612063429.3343061-1-bigunclemax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxim Kiselev <bigunclemax@gmail.com>

This patch adds a thermal sensor controller support for the D1/T113s,
which is similar to the one on H6, but with only one sensor and
different scale and offset values.

Signed-off-by: Maxim Kiselev <bigunclemax@gmail.com>
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

