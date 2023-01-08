Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40270661691
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 17:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234233AbjAHQ0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 11:26:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233389AbjAHQ0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 11:26:05 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC4F3889
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 08:26:04 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id vm8so14577081ejc.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jan 2023 08:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ytjq+5ZqtJJOKrYEaXmPKz3aw/q9ijl/XXCtqz4EuF4=;
        b=nBxZMKG4Su3gcQuvTlNYvWV6p7aYI3RgYzZUCjj1g524It6NPjhM5uobWjWpHCObQM
         loxTQCIE9XEA/6FONiv3h7uTcqCO+HbOd3oqjkiw1SJCgHB89HGEkzlmJwo6tIwFatTW
         X79104sXn0Y52iCxX+ZDporPlQow5Nd8/4AEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ytjq+5ZqtJJOKrYEaXmPKz3aw/q9ijl/XXCtqz4EuF4=;
        b=WMhC05zrNRD2rqgG0YzXTZWaUXoringevfzGJBRo8c+fAsLz7TInrrVemFl/GEK61w
         QxVa/+jsS5cXfcaK59Hu9T/0FmtcWYJEqNS97S8c2mDdwyb/FPQc5kaoDXYw7dWdvIWX
         0gv80z+H8RswZUdVYqQky7PE7Qjim4InmIBD56a6vH6JnPsVoPPYtdT6Uk5KUQhZg1aQ
         naM0dRAXfQtd+7fQxguBLSJsGf6Q0eJXqHl1zXDQtPIQZpYVoHnNotWIntgDVLpTr/yk
         qCZ4VRDM+EktVbVCxzFtTMogwyldrEKZoic+zU/xTp9ugX7j+0gFZGeySumVBgsXb0LT
         odSA==
X-Gm-Message-State: AFqh2kpF2yRLoqDq5FSBhMo+40mML9JxUpzV/YoTQA166xJu2ze02hHW
        rT/OzlxbXUF5rZu3LvGemBmJbQ5vx4N9Wqd8Eec=
X-Google-Smtp-Source: AMrXdXvfmLmkkqnchvyqIhIdujLvHzSTh+3uQqSny7DKiK5S8TLqhXfEtCIvp7yMnWFejmrlRqqhWQ==
X-Received: by 2002:a17:906:1398:b0:84d:47e3:fe49 with SMTP id f24-20020a170906139800b0084d47e3fe49mr420984ejc.39.1673195163226;
        Sun, 08 Jan 2023 08:26:03 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-80-180-23-57.pool80180.interbusiness.it. [80.180.23.57])
        by smtp.gmail.com with ESMTPSA id n3-20020aa7c443000000b00486074b4ce4sm2659614edr.68.2023.01.08.08.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 08:26:02 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>, michael@amarulasolutions.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [RESEND RFC PATCH v5 3/5] ARM: dts: stm32: add CAN support on stm32f429
Date:   Sun,  8 Jan 2023 17:25:52 +0100
Message-Id: <20230108162554.8375-4-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230108162554.8375-1-dario.binacchi@amarulasolutions.com>
References: <20230108162554.8375-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for bxcan (Basic eXtended CAN controller) to STM32F429. The
chip contains two CAN peripherals, CAN1 the master and CAN2 the slave,
that share some of the required logic like clock and filters. This means
that the slave CAN can't be used without the master CAN.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

(no changes since v4)

Changes in v4:
- Replace the node can@40006400 (compatible "st,stm32f4-bxcan-core")
  with the gcan@40006600 node ("sysnode" compatible). The gcan node
  contains clocks and memory addresses shared by the two can nodes
  of which it's no longer the parent.
- Add to can nodes the "st,gcan" property (global can memory) which
  references the gcan@40006600 node ("sysnode compatibble).

Changes in v3:
- Remove 'Dario Binacchi <dariobin@libero.it>' SOB.
- Add "clocks" to can@0 node.

 arch/arm/boot/dts/stm32f429.dtsi | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index c31ceb821231..ce08872109b8 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -362,6 +362,35 @@ i2c3: i2c@40005c00 {
 			status = "disabled";
 		};
 
+		gcan: gcan@40006600 {
+			compatible = "st,stm32f4-gcan", "syscon";
+			reg = <0x40006600 0x200>;
+			clocks = <&rcc 0 STM32F4_APB1_CLOCK(CAN1)>;
+		};
+
+		can1: can@40006400 {
+			compatible = "st,stm32f4-bxcan";
+			reg = <0x40006400 0x200>;
+			interrupts = <19>, <20>, <21>, <22>;
+			interrupt-names = "tx", "rx0", "rx1", "sce";
+			resets = <&rcc STM32F4_APB1_RESET(CAN1)>;
+			clocks = <&rcc 0 STM32F4_APB1_CLOCK(CAN1)>;
+			st,can-master;
+			st,gcan = <&gcan>;
+			status = "disabled";
+		};
+
+		can2: can@40006800 {
+			compatible = "st,stm32f4-bxcan";
+			reg = <0x40006800 0x200>;
+			interrupts = <63>, <64>, <65>, <66>;
+			interrupt-names = "tx", "rx0", "rx1", "sce";
+			resets = <&rcc STM32F4_APB1_RESET(CAN2)>;
+			clocks = <&rcc 0 STM32F4_APB1_CLOCK(CAN2)>;
+			st,gcan = <&gcan>;
+			status = "disabled";
+		};
+
 		dac: dac@40007400 {
 			compatible = "st,stm32f4-dac-core";
 			reg = <0x40007400 0x400>;
-- 
2.32.0

