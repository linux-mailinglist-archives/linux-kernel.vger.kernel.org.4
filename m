Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59210741DC7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 03:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbjF2BnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 21:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbjF2BnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 21:43:01 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60167A2;
        Wed, 28 Jun 2023 18:43:00 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-765a651a3b6so17817685a.2;
        Wed, 28 Jun 2023 18:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688002979; x=1690594979;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tgxYvAPdy6cyYY8LJa7G8IIHJkOD0bja0wPM1W6sg8I=;
        b=kYRdRF781JvgnGIHMt7HYd+5MaL1yKxgHkiBDnqeZFA6wF29CnpwbiUV3clBpaloO7
         drEIGPBxQVuSJYm19tWtqVFQZ+VClwZuNrMBQeSR+R4OAiQTCQBIbHc9iQmV8D5Gzl8Q
         kGPvDWcnzS5bByXw5pxflYLR4aEsZzAtX7MX06i3neVT/BwVd5SX9IFmwkSI1hvPR80j
         ZZMLPPHVruwyb6mjIROG6FwMwQGzKnKGUO4DgenASJKjZQqDzrx6F5f020/gR8vkkquK
         /URnBdpsP+opzzeHXKKyPYhkksRkTfDrUvoUtv1AQpQyt9LOWUsOMG4eYpkLfFvxOgDk
         v9iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688002979; x=1690594979;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tgxYvAPdy6cyYY8LJa7G8IIHJkOD0bja0wPM1W6sg8I=;
        b=TMe4UGvTg5jUCgG8l0K0RpxfWVTiTl2jS7iHlM1R+RSLSJmHqm9vY0NBIx1dD7hoIL
         gKx45O6zIrLU2szzcvfF5xjtednVB/PQxlohx34AmYYNhPdjBIloOK/5QcS9PBYOyhhP
         pdvUNMfRLTrhMuvy+oTCYSHmYG6oQduvK/+5rmXFjYzNAxrZNNvGH0L8KP55wLKi7MBN
         u0lbxtFZC0Gh37iPFTVgkTx1r1hzNy2kGOCW2YX3q8PjUtRKzHN/mHha4yu3lcIV9jsD
         fmMD5B5yXAATCx0BxAxpBD07JNLpJlBcKjJev/BQNwvYj39g1WnPzV2Cm1c765EsOGXD
         DAcQ==
X-Gm-Message-State: AC+VfDxEcAlZoPC62932RKzizL6dq3MnfAYk+SXcxwUgvl5jj7BTcuOu
        bUdyzHPTnVYUIouJQczYxQk=
X-Google-Smtp-Source: ACHHUZ4IiaFAB5haGGNU3e6va9vsg0mwQnLalhUUzD8uL9LkFN+/FfZ/TFb9itQHpEDCNyYCXOF/Pw==
X-Received: by 2002:a05:620a:2785:b0:765:9c07:18ea with SMTP id g5-20020a05620a278500b007659c0718eamr12515394qkp.64.1688002979313;
        Wed, 28 Jun 2023 18:42:59 -0700 (PDT)
Received: from anyang.. ([106.250.177.234])
        by smtp.googlemail.com with ESMTPSA id m7-20020a17090a414700b00262d368b220sm7707123pjg.40.2023.06.28.18.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 18:42:58 -0700 (PDT)
From:   Dongjin Kim <tobetter@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] arm64: dts: meson-sm1: reorder device aliases
Date:   Thu, 29 Jun 2023 10:42:51 +0900
Message-Id: <20230629014253.2007625-1-tobetter@gmail.com>
X-Mailer: git-send-email 2.34.1
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

This patch is simply to reoder the device aliases.

Signed-off-by: Dongjin Kim <tobetter@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-sm1-ac2xx.dtsi    | 2 +-
 arch/arm64/boot/dts/amlogic/meson-sm1-bananapi.dtsi | 2 +-
 arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi   | 2 +-
 arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts    | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-ac2xx.dtsi b/arch/arm64/boot/dts/amlogic/meson-sm1-ac2xx.dtsi
index 46a34731f7e2..c63edf3e43af 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-ac2xx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-ac2xx.dtsi
@@ -15,8 +15,8 @@
 
 / {
 	aliases {
-		serial0 = &uart_AO;
 		ethernet0 = &ethmac;
+		serial0 = &uart_AO;
 	};
 
 	chosen {
diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi.dtsi b/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi.dtsi
index 17045ff81c69..7c01e6995bfb 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi.dtsi
@@ -24,8 +24,8 @@ button-sw3 {
 	};
 
 	aliases {
-		serial0 = &uart_AO;
 		ethernet0 = &ethmac;
+		serial0 = &uart_AO;
 	};
 
 	chosen {
diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi
index 2fce44939f45..ddac04ac60ab 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi
@@ -10,8 +10,8 @@
 
 / {
 	aliases {
-		serial0 = &uart_AO;
 		ethernet0 = &ethmac;
+		serial0 = &uart_AO;
 	};
 
 	chosen {
diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
index 9068a334ea57..7d490e1b56f0 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
@@ -16,8 +16,8 @@ / {
 	model = "SEI Robotics SEI610";
 
 	aliases {
-		serial0 = &uart_AO;
 		ethernet0 = &ethmac;
+		serial0 = &uart_AO;
 	};
 
 	mono_dac: audio-codec-0 {
-- 
2.34.1

