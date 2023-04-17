Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA796E4DA5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 17:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbjDQPtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 11:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbjDQPtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 11:49:12 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37AD5CC14
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 08:48:50 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id r15so4491482wmo.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 08:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1681746519; x=1684338519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e0h+J/jYcaxGhbd0pdA4CgX5WMFp5uXSi4au+HMftas=;
        b=GZU+WEcqcJ5ETGd+OMLIOz2JDfTfCKx1fLvHAh33HI6v9ifYSyAacFjt5Ra4lLXIGa
         G6b1USWz/U9WgK/VAIXTSbjKvPrF116D7sK8Y1flODJWuFbtE/ArqTXfhSx7sawYpFym
         Z5bCVNDOwgK9Wc3e22BTL4Tqv9vmasd+pkFrCWkK169RadCcLYOB/ZnY1M4VXe+1O64r
         R8X0L/ar5tgqKyDhqyUk6pAV3SsSdsnX7nYLnz9rIqdjTL8xD5BOzOcLCGTXuXm9DFmJ
         ZpPdcW0u4T+9hdm8KjbfAqF4JICmXz0vD/e5xCXvBk5u9Z2NWeMpO6Mxt/Yu/1zUKPva
         TqRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681746519; x=1684338519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e0h+J/jYcaxGhbd0pdA4CgX5WMFp5uXSi4au+HMftas=;
        b=VFZZX8vhIf8h5V4gMaGtxWXeSWybubNDvZvudPTghfZSQLzJhLEsRyGlVGanYgxLSc
         0rtb5eaIXUWcQjhRmISFr/ec12XqCmH/O5N2PO8cz/LW76k1s4+YDF1OEa9vdnBkECPD
         ogf8ysG2xIrexYx6PoXpWLkCHjLHcwm6Ia0Xwx3qiKMvYNIeqP2wPdFSAKxELtq5tHKa
         vgOfQR52C3tjj5G45a01V8wBO4fdaU0CpECytaWv8r3mhISMmoPmxE3NTfxEAFS4Pbyf
         3waZoHbcXpZSMqgL4wTr+epg5QZet78mHnhypPwuzW1OQqyz3OvMWBQgvd0MkovsRrdQ
         Zjeg==
X-Gm-Message-State: AAQBX9dgxwtYrvPXd4RV9z++zyWvfXebTKbZJ9bgsXaSo+H++/0IGt6K
        PFjoeQ/MV4sfhJqwgwg2pq4xbA==
X-Google-Smtp-Source: AKy350Yr5V4HDtI2LlckrjoBLXRET8KbX322cJ1SYcPNvT2xX4ACSrobYUD+ljvRyiU3IfVZmcSIzg==
X-Received: by 2002:a05:600c:3c8d:b0:3f1:88b:bd40 with SMTP id bg13-20020a05600c3c8d00b003f1088bbd40mr6664825wmb.14.1681746519093;
        Mon, 17 Apr 2023 08:48:39 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:28d:66d0:5888:afdf:3f10:3b2b])
        by smtp.gmail.com with ESMTPSA id v5-20020a05600c444500b003f09cda253esm16189932wmn.34.2023.04.17.08.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 08:48:38 -0700 (PDT)
From:   Esteban Blanc <eblanc@baylibre.com>
To:     nm@ti.com, vigneshr@ti.com, kristo@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, sterzik@ti.com, u-kumar1@ti.com,
        eblanc@baylibre.com, jneanne@baylibre.com, jpanis@baylibre.com,
        aseketeli@baylibre.com
Subject: [PATCH v3 4/6] arm64: dts: ti: k3-j784s4-evm: Fix wakeup gpio pinmux interrupt range
Date:   Mon, 17 Apr 2023 17:48:30 +0200
Message-Id: <20230417154832.216774-5-eblanc@baylibre.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230417154832.216774-1-eblanc@baylibre.com>
References: <20230417154832.216774-1-eblanc@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Apelete Seketeli <aseketeli@baylibre.com>

This patch fixes the interrupt range of wakeup gpio used by TPS6594 PMIC.

Signed-off-by: Apelete Seketeli <aseketeli@baylibre.com>
Signed-off-by: Esteban Blanc <eblanc@baylibre.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
index 93952af618f6..a4b19b94b71a 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
@@ -65,7 +65,7 @@ wkup_gpio_intr: interrupt-controller@42200000 {
 		#interrupt-cells = <1>;
 		ti,sci = <&sms>;
 		ti,sci-dev-id = <177>;
-		ti,interrupt-ranges = <16 928 16>;
+		ti,interrupt-ranges = <16 960 16>;
 	};
 
 	mcu_conf: syscon@40f00000 {
-- 
2.39.2

