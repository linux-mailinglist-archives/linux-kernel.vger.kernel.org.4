Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 198F46C032B
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 17:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbjCSQd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 12:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbjCSQdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 12:33:14 -0400
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB6F20044;
        Sun, 19 Mar 2023 09:32:45 -0700 (PDT)
Received: by mail-il1-f176.google.com with SMTP id j6so5400632ilr.7;
        Sun, 19 Mar 2023 09:32:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679243565;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p4tdtu/BoCpyFQiT8nwjBdDJ+pofDzulK4/CMjUXkl4=;
        b=eUtkKrRwx+4RUtBp4V8QUPBoN7ckAUv1yR1jeXXlBRTWF40gYm19CFBqviz9OksDD2
         Qif3fx03Vzqo1h4SW7NtqxVK+RyFq4tdSwbsVGw4astqC8CxK8ibWARuBlJuvYl/YuSo
         CgI7Nd6/8PT2fxxLkJMSGOtQE/DY1JrCDXcds/wgsyzEbJe5ERYb4tbVwZyad1kJjE7H
         nNyqJSJwARnPhGxku3LUpEURMieYr9dOUXuXPi+C73N8hCTA6o0OO5EmrdOjwM3VUKAB
         q0UxMuArpxHE7BMTzYsab6PCzdoCLYHG+UyqEu4Dc97ecAijyD4ADPCf46cakS31fOWx
         qXCA==
X-Gm-Message-State: AO0yUKXAHkDtZnHpu0Zcf6KNLZ7UwxW3y3oZ/eF3NOmOZWJYvXNmSxaV
        m2OHQaHzGaTh5T0Vh/a8Ag==
X-Google-Smtp-Source: AK7set/D7386HxB0VdBbnYp8YAwsuBsb57CjrBk1CpenJ2pFHzjL+CaQ3SfHzxMJ8WK6IWZ51RjccQ==
X-Received: by 2002:a92:d64c:0:b0:313:fddb:6e6f with SMTP id x12-20020a92d64c000000b00313fddb6e6fmr3472469ilp.9.1679243564944;
        Sun, 19 Mar 2023 09:32:44 -0700 (PDT)
Received: from robh_at_kernel.org ([2605:ef80:80c7:2689:137d:d795:47e4:3de1])
        by smtp.gmail.com with ESMTPSA id y19-20020a056e02119300b0031830e2c987sm2193842ili.20.2023.03.19.09.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 09:32:44 -0700 (PDT)
Received: (nullmailer pid 226928 invoked by uid 1000);
        Sun, 19 Mar 2023 16:32:40 -0000
From:   Rob Herring <robh@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] thermal: mediatek: Use of_address_to_resource()
Date:   Sun, 19 Mar 2023 11:32:31 -0500
Message-Id: <20230319163231.226738-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace of_get_address() and of_translate_address() calls with single
call to of_address_to_resource().

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/thermal/mediatek/auxadc_thermal.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/mediatek/auxadc_thermal.c b/drivers/thermal/mediatek/auxadc_thermal.c
index ab730f9552d0..c8a3acaf56c1 100644
--- a/drivers/thermal/mediatek/auxadc_thermal.c
+++ b/drivers/thermal/mediatek/auxadc_thermal.c
@@ -897,14 +897,12 @@ static void mtk_thermal_init_bank(struct mtk_thermal *mt, int num,
 
 static u64 of_get_phys_base(struct device_node *np)
 {
-	u64 size64;
-	const __be32 *regaddr_p;
+	struct resource res;
 
-	regaddr_p = of_get_address(np, 0, &size64, NULL);
-	if (!regaddr_p)
+	if (of_address_to_resource(np, 0, &res))
 		return OF_BAD_ADDR;
 
-	return of_translate_address(np, regaddr_p);
+	return res.start;
 }
 
 static int mtk_thermal_extract_efuse_v1(struct mtk_thermal *mt, u32 *buf)
-- 
2.39.2

