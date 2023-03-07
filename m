Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C39816AE532
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 16:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjCGPpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 10:45:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbjCGPpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 10:45:32 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E443E4ECC2
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 07:45:29 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id r18so12595299wrx.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 07:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1678203928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+OFCWs6sMvmcACVP359vGdpDLS8nF6pX77Um/B5ZzBQ=;
        b=I4Km7KvrsZJjag+t2OnVfY3qj3nEqw18rDA/g/UnXtDjeMVyd4k+jsQmwXhiEHzOOo
         kus9JATGqXhXUaxRpv72NOs1h97nszn7FihQqNJoWCZ4lJ2nBUxLH8V90eL0TPDQu0QI
         QnkjKYyyNt80BDehpoieSDTVidG4vOfOz8QARoAuzl0FpUgYUQFqaeYZtm8H+1GNymNh
         e/F9JasTMspKNjy0jKFrRUHz1uU3XzRE/rshBmRHo6TedQ2ljZi4b5ko1viqH4ExiODT
         mezb4sGJN4y4TEdKqBJ9b97gThmeClR1kvXXs5KWMhrroBsc9N/cws97ENwz8+QX6NQ7
         CQ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678203928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+OFCWs6sMvmcACVP359vGdpDLS8nF6pX77Um/B5ZzBQ=;
        b=3jtb7oA2rAyM/rjEDBpDgnqEml5Q481v8tfdJCA9YKCr8ZXx2osOxuKvK7Xd3r0nzt
         UlTCdByui4MqT1aWuHETt0U1pcn94N+fiMaPWDOdWTjFXSqlpjICQTa5J4vkIakFYtiF
         EQ9rkbT+KvVV5LOhBMSOe30ZpYENo5C970L2CLabMsBL7CH03IdmUhTKb4NJXJ/Dvp7D
         9Xgj1evzNnEXiLE7/GCe0JAQgbR0kfDvbcupoSUgExv984oX2lhaoRWh2tYJpwZ+OIa3
         VYOxyK+HOk5cYCK3/zfAi4NbktKQ8w9LgA76rl08kRdj56Tt1eZ/PHqXK5HezQ1F7Ea4
         5fuA==
X-Gm-Message-State: AO0yUKUKz1PQwljy/OerA6Vbs3XJmW8kHAMNVaomqINSyPW6jrvP85dy
        7MDjLJvU1BSQmovAdP52Y1zMIQ==
X-Google-Smtp-Source: AK7set/+bC2C/uYd0izZbbAPg4Ofkw0p/GsTZYFxd0TjK9UR7bUQOp5p/RMcGAtJ3iaLQsWPqZ5+hw==
X-Received: by 2002:a5d:4089:0:b0:2c7:3ee7:a44c with SMTP id o9-20020a5d4089000000b002c73ee7a44cmr8371471wrp.65.1678203928444;
        Tue, 07 Mar 2023 07:45:28 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-657-1-248-155.w90-24.abo.wanadoo.fr. [90.24.137.155])
        by smtp.gmail.com with ESMTPSA id f2-20020a5d50c2000000b002c704271b05sm12697905wrt.66.2023.03.07.07.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 07:45:28 -0800 (PST)
From:   bchihi@baylibre.com
To:     daniel.lezcano@linaro.org, angelogioacchino.delregno@collabora.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rdunlap@infradead.org,
        ye.xingchen@zte.com.cn, p.zabel@pengutronix.de
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        khilman@baylibre.com, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
Subject: [PATCH 1/4] dt-bindings: thermal: mediatek: Add AP domain to LVTS thermal controllers for mt8195
Date:   Tue,  7 Mar 2023 16:45:21 +0100
Message-Id: <20230307154524.118541-2-bchihi@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230307154524.118541-1-bchihi@baylibre.com>
References: <20230307154524.118541-1-bchihi@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Balsam CHIHI <bchihi@baylibre.com>

Add AP Domain to LVTS thermal controllers dt-binding definition for mt8195.

Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
---
 include/dt-bindings/thermal/mediatek,lvts-thermal.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/dt-bindings/thermal/mediatek,lvts-thermal.h b/include/dt-bindings/thermal/mediatek,lvts-thermal.h
index c09398920468..8fa5a46675c4 100644
--- a/include/dt-bindings/thermal/mediatek,lvts-thermal.h
+++ b/include/dt-bindings/thermal/mediatek,lvts-thermal.h
@@ -16,4 +16,14 @@
 #define MT8195_MCU_LITTLE_CPU2  6
 #define MT8195_MCU_LITTLE_CPU3  7
 
+#define MT8195_AP_VPU0  8
+#define MT8195_AP_VPU1  9
+#define MT8195_AP_GPU0  10
+#define MT8195_AP_GPU1  11
+#define MT8195_AP_VDEC  12
+#define MT8195_AP_IMG   13
+#define MT8195_AP_INFRA 14
+#define MT8195_AP_CAM0  15
+#define MT8195_AP_CAM1  16
+
 #endif /* __MEDIATEK_LVTS_DT_H */
-- 
2.34.1

