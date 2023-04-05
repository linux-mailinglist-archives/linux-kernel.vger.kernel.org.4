Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C95986D7950
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 12:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237707AbjDEKJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 06:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237586AbjDEKJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 06:09:29 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7864135BF
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 03:09:26 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id t10so139565857edd.12
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 03:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680689366;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q6TAMt++7cMkW1BStD+wsT/sNxqsrNSnDjvkmfey6Z4=;
        b=bEGMctTnM7DiSqO57EaQMKf5vh4yr7cDNlX1EY3Kv4Rwgb9KaAY/hM5KFna8Hffwva
         8kMd9qGJL5flWJTqF31LQyEVjPsCKAiquJoMgzOQ1f2+2DQypuHgKCa4qCyMLfLDRClF
         0trquQ6mQGzS7739tEkPSxc3CqbxgbtFlnkFzsLAf6Gd4Cy/G4yaBCvnDgVEvw5sJjhZ
         G9KyyQhHKgagyaifa8Ty4aCO2up0+O7oKj1QXklUhP4xzgRpIecqZlTI90Yz/BLdHKvd
         MEJYxlQvF1fUS+DWpsIcDefyffjc1rqgkbomvjmJ9+v8svYomd7No4uuZx+Wahbjns7U
         P5ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680689366;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q6TAMt++7cMkW1BStD+wsT/sNxqsrNSnDjvkmfey6Z4=;
        b=hdNwYJSTYRvPfJIdNQpbqFxmb8n1IPN2EYAd7xq1hm5QYDI/R6bB2CQwuL3oc0YFf4
         K36qEna4mJRueWxBPrmVzxuK16UBf25Bf2eK2ku3hKpe9p6C5VRA3VvHMqH5US2OR9Pf
         rrBWV3PHmp0zjmT4JcO+aEJ+I0hvdWiMb1w4opeuPH4Km9P90iJsSZ/MapnB5AatnA8L
         Bv6YJCvfpFvo2EwkGXg/oqHUeM1ZBTb/P7SmtQqvMHXrVUvqGqln+UbMAmwRbeqzky22
         FzSgw3s2AcwXKr+XGrKNgMlyXGZSXV6ySZ9+thODOXxiF224lrpRt23uMFPxK8eAGmHb
         9w1A==
X-Gm-Message-State: AAQBX9feH+bfWzcB1/m/1yS0sM2qnnSTOFRRhFPRBuEd8ruGxOBkcGjR
        G5xNB6o3D34w13CitE/GLzo/kQ==
X-Google-Smtp-Source: AKy350bYmVv6IV6JXDqPc1avMQOvjnTmwfb8v7QF7sgI2XiiWDSjCfdP1dWYjIQjxHFNmhoK053P8Q==
X-Received: by 2002:a17:906:22d3:b0:878:72f7:bd87 with SMTP id q19-20020a17090622d300b0087872f7bd87mr1948024eja.6.1680689365926;
        Wed, 05 Apr 2023 03:09:25 -0700 (PDT)
Received: from t480-bl003.. (2a02-8440-c20e-c930-8ace-7c3c-c02b-cb9a.rev.sfr.net. [2a02:8440:c20e:c930:8ace:7c3c:c02b:cb9a])
        by smtp.gmail.com with ESMTPSA id u13-20020a1709063b8d00b0093e261cc8bcsm7195962ejf.58.2023.04.05.03.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 03:09:25 -0700 (PDT)
From:   bchihi@baylibre.com
To:     daniel.lezcano@linaro.org, angelogioacchino.delregno@collabora.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rdunlap@infradead.org,
        ye.xingchen@zte.com.cn, p.zabel@pengutronix.de
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        wenst@chromium.org, khilman@baylibre.com, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
Subject: [PATCH] arm64: dts: mediatek: mt8195: Add AP domain thermal zones
Date:   Wed,  5 Apr 2023 12:09:07 +0200
Message-Id: <20230405100907.53740-1-bchihi@baylibre.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Balsam CHIHI <bchihi@baylibre.com>

Add AP Domain thermal zones for the mt8195 and
specify the targeted temperature thresholds.

Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>

---
This patch squashes and replaces

[PATCH 3/4] arm64: dts: mediatek: mt8195: Add AP domain thermal zones
https://lore.kernel.org/all/20230307154524.118541-4-bchihi@baylibre.com/

and

[PATCH 4/4] arm64: dts: mediatek: mt8195: Add AP domain temperature thresholds
https://lore.kernel.org/all/20230307154524.118541-5-bchihi@baylibre.com/

of the series

[PATCH 0/4] Add LVTS's AP thermal domain support for mt8195
https://lore.kernel.org/all/20230307154524.118541-1-bchihi@baylibre.com/
---
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 180 +++++++++++++++++++++++
 1 file changed, 180 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 972c5b86ddae..75da456c512b 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -2909,5 +2909,185 @@ map0 {
 				};
 			};
 		};
+
+		vpu0-thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <250>;
+			thermal-sensors = <&lvts_ap MT8195_AP_VPU0>;
+
+			trips {
+				vpu0_alert: trip-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				vpu0_crit: trip-crit {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		vpu1-thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <250>;
+			thermal-sensors = <&lvts_ap MT8195_AP_VPU1>;
+
+			trips {
+				vpu1_alert: trip-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				vpu1_crit: trip-crit {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		gpu0-thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <250>;
+			thermal-sensors = <&lvts_ap MT8195_AP_GPU0>;
+
+			trips {
+				gpu0_alert: trip-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				gpu0_crit: trip-crit {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		gpu1-thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <250>;
+			thermal-sensors = <&lvts_ap MT8195_AP_GPU1>;
+
+			trips {
+				gpu1_alert: trip-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				gpu1_crit: trip-crit {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		vdec-thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <250>;
+			thermal-sensors = <&lvts_ap MT8195_AP_VDEC>;
+
+			trips {
+				vdec_alert: trip-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				vdec_crit: trip-crit {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		img-thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <250>;
+			thermal-sensors = <&lvts_ap MT8195_AP_IMG>;
+
+			trips {
+				img_alert: trip-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				img_crit: trip-crit {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		infra-thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <250>;
+			thermal-sensors = <&lvts_ap MT8195_AP_INFRA>;
+
+			trips {
+				infra_alert: trip-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				infra_crit: trip-crit {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		cam0-thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <250>;
+			thermal-sensors = <&lvts_ap MT8195_AP_CAM0>;
+
+			trips {
+				cam0_alert: trip-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cam0_crit: trip-crit {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		cam1-thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <250>;
+			thermal-sensors = <&lvts_ap MT8195_AP_CAM1>;
+
+			trips {
+				cam1_alert: trip-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cam1_crit: trip-crit {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
 	};
 };
-- 
2.34.1

