Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E32436EB4E1
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 00:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234017AbjDUWdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 18:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233924AbjDUWch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 18:32:37 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75166421E
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 15:32:12 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-94a342f7c4cso374107666b.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 15:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682116324; x=1684708324;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GrIFJywIqc8DnQ0zBuegXcsaO3im7Q1tAGm/ILbr8Kk=;
        b=jG+oHZ5NecaKFNM1SiYGALcJ63fuE7TSU14Zt9RA1TtFkhpXzyJa4mCM48eNJiOLy8
         19P0x9i1zYprOlJFkwGdqji/U/FeohXnfH6/eikwEkHHNBtIqa4JPVLuinTZOEfl2GP5
         0RxN+3lpUCpz4EtEFrVSvKpmi4T/dEafEEpGEzaF2DVB2uHuzCQz4xw2PPOG4tjmvWdI
         Krlw3ES2+kTRB5UH5B95CrePlBpXUDE0kGtksHN8iXzFkftK+YDKhk/emrKsXB/bgcR6
         9gMTSsnWaQn6g5jvtaz9C/V/0B1ckFneYWXbUiETsLTSU2WDlm7ftVtZVJA8k3RY4czi
         EOxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682116324; x=1684708324;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GrIFJywIqc8DnQ0zBuegXcsaO3im7Q1tAGm/ILbr8Kk=;
        b=HeYvkdBVW6MAS9PHgf0q57B0r1cZ6Yj1omeePvMVRmgtERSMvUym1Cn6aWq9qMX0oF
         9ZZwtv4ZckimHiVQ6GC5QiwU6fCtwvBPjkY/CSSSPcnolq0w4P7IWJNK36PisG09/YTK
         NPe+Kl4Mn/3SYrWlu8TP4cezokFRk6TKxQEpkPkfwotg7Kvg2UEYwzY2ABAQopL9R5ZV
         N7Sp7OzQZipczQHJBq3uOBW3SgRTYcajjCK/RM8smLbu1ueKsW5luNL45+1c/h95sHVK
         3qFPjfNxKHUan2YJBMRGEl3wOR3lx1iPMSGgSKUdkH9F3Za1vnGmvYt2YdM0tyRFp+Ug
         xP7w==
X-Gm-Message-State: AAQBX9dTQeQfOn4j4mLHvkfzbUTrSpqEIjGNnVbsMZeJp8Yma906v/7B
        ciXTl+Ja+lNJFO6bDiXP9m93LQ==
X-Google-Smtp-Source: AKy350aIV8NFYW3zqZYluWeNmduj1PzsSP4HgoSSPpntUhj/54MWl4SpDaITAUZPjMYInZNZBX2zag==
X-Received: by 2002:a17:906:d72:b0:94e:ec0f:455 with SMTP id s18-20020a1709060d7200b0094eec0f0455mr4508851ejh.54.1682116324478;
        Fri, 21 Apr 2023 15:32:04 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:687d:8c5:41cb:9883])
        by smtp.gmail.com with ESMTPSA id e24-20020a17090681d800b0094f54c032e3sm2566277ejx.103.2023.04.21.15.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 15:32:04 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Chester Lin <clin@suse.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Matthias Brugger <mbrugger@suse.com>,
        NXP S32 Linux Team <s32@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: s32: add missing cache properties
Date:   Sat, 22 Apr 2023 00:32:02 +0200
Message-Id: <20230421223202.115472-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As all level 2 and level 3 caches are unified, add required
cache-unified properties to fix warnings like:

  s32g274a-evb.dtb: l2-cache1: 'cache-unified' is a required property

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Please take the patch via sub-arch SoC tree.
---
 arch/arm64/boot/dts/freescale/s32g2.dtsi   | 2 ++
 arch/arm64/boot/dts/freescale/s32v234.dtsi | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/s32g2.dtsi b/arch/arm64/boot/dts/freescale/s32g2.dtsi
index d8c82da88ca0..5ac1cc9ff50e 100644
--- a/arch/arm64/boot/dts/freescale/s32g2.dtsi
+++ b/arch/arm64/boot/dts/freescale/s32g2.dtsi
@@ -53,11 +53,13 @@ cpu3: cpu@101 {
 		cluster0_l2: l2-cache0 {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 
 		cluster1_l2: l2-cache1 {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/freescale/s32v234.dtsi b/arch/arm64/boot/dts/freescale/s32v234.dtsi
index 3e306218d533..42409ec56792 100644
--- a/arch/arm64/boot/dts/freescale/s32v234.dtsi
+++ b/arch/arm64/boot/dts/freescale/s32v234.dtsi
@@ -62,11 +62,13 @@ cpu3: cpu@101 {
 		cluster0_l2_cache: l2-cache0 {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 
 		cluster1_l2_cache: l2-cache1 {
 			compatible = "cache";
 			cache-level = <2>;
+			cache-unified;
 		};
 	};
 
-- 
2.34.1

