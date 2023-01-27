Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE3267E162
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 11:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233472AbjA0KSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 05:18:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233477AbjA0KSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 05:18:35 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7460526F
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 02:18:32 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id l41-20020a05600c1d2900b003daf986faaeso3068848wms.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 02:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xAkXrBOeYq2uPJ9Lzg7NjCsv3k9QcgmeUOGZZPQ4XP0=;
        b=i8SJqbujrO1qBvakjXDZYjGm9F1LrnLmfkxQJp9DEfTyD6g3x6QIGJuvbK54SllfWj
         BiplNzPxSzh3/XH53mtp5PiNXgmnoeAl0dMty/Yt5HPAL+dFn3WvN5nYuFCOdDpbpX1y
         5clOr2zovh50XfpS3HiyShcMGswqXmcwUo1uWOm0ez08/0rvemYw36HnTTDX8V3NGqw3
         8LzSXY5d77NDN4rpRryNznVisIiQF0ywy0CpmRXK7y0jOjmhMV7mrTS29yA/0S4ULUSj
         zib1A424nDSBtgqnx7Ouhi2MDoE92v7TnJ0kc92RUqZQBUCCA/APQjdcU0+jhycemBQU
         XH+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xAkXrBOeYq2uPJ9Lzg7NjCsv3k9QcgmeUOGZZPQ4XP0=;
        b=JmLaFeD7W9h2pGCH9vRMXnT2pFQXi9yb/N1mL4OjF7+9+zidHZPrKUF+J32Go/KWep
         midfznRAaoYKKePDFVZpqJ+G0dbbQN3uXUp6eXEt/IULeUsycbN+XLUIbIdhvvhi+FdW
         ga1BRKR9lxeatKmgvFu5Wnj7SZ8mveZgG86CXb23SYxPKOWgttf+yoJE4JVl+b12mli9
         Ukz9BQK7xlv+OV6TiImrOvKgBdfBXklVtxJVzI3TiacpQ8rpXwePKc/cqx4fKNXwllPz
         8UK0iNb40hH45WaGMga71ZiWf5HAZOkq4BIeSuDy89c3B7syACQZO7dYimx56Nb/jzcq
         eJOA==
X-Gm-Message-State: AO0yUKWKiFhu2Jgh/aegs2NFptuYuBJu4WDZbLVrErqx0azEJjXVkWjH
        b/wrXfKHcyRblIWhSPapbjL4xw==
X-Google-Smtp-Source: AK7set+Drbgf6OSSEHkeOwsvOfzXakxGsZV8okTZ3G8AjjDvI7ooCF+eiP4qYQ2+vTJLQ8DLTycsmg==
X-Received: by 2002:a05:600c:4fcb:b0:3dc:1687:9b9a with SMTP id o11-20020a05600c4fcb00b003dc16879b9amr12271562wmq.37.1674814711381;
        Fri, 27 Jan 2023 02:18:31 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id a5-20020adfeec5000000b002bfae6b17d2sm3629503wrp.55.2023.01.27.02.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 02:18:31 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Brijesh Singh <brijeshkumar.singh@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: amd: use "okay" for status
Date:   Fri, 27 Jan 2023 11:18:29 +0100
Message-Id: <20230127101829.93761-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"okay" over "ok" is preferred for status property.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../boot/dts/amd/amd-overdrive-rev-b0.dts     | 16 ++++++-------
 .../boot/dts/amd/amd-overdrive-rev-b1.dts     | 24 +++++++++----------
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/boot/dts/amd/amd-overdrive-rev-b0.dts b/arch/arm64/boot/dts/amd/amd-overdrive-rev-b0.dts
index 02bff65e5fd6..21149acb6b31 100644
--- a/arch/arm64/boot/dts/amd/amd-overdrive-rev-b0.dts
+++ b/arch/arm64/boot/dts/amd/amd-overdrive-rev-b0.dts
@@ -26,7 +26,7 @@ psci {
 };
 
 &ccp0 {
-	status = "ok";
+	status = "okay";
 	amd,zlib-support = <1>;
 };
 
@@ -34,31 +34,31 @@ &ccp0 {
  * NOTE: In Rev.B, gpio0 is reserved.
  */
 &gpio1 {
-	status = "ok";
+	status = "okay";
 };
 
 &gpio4 {
-	status = "ok";
+	status = "okay";
 };
 
 &i2c0 {
-	status = "ok";
+	status = "okay";
 };
 
 &i2c1 {
-	status = "ok";
+	status = "okay";
 };
 
 &pcie0 {
-	status = "ok";
+	status = "okay";
 };
 
 &spi0 {
-	status = "ok";
+	status = "okay";
 };
 
 &spi1 {
-	status = "ok";
+	status = "okay";
 	sdcard0: sdcard@0 {
 		compatible = "mmc-spi-slot";
 		reg = <0>;
diff --git a/arch/arm64/boot/dts/amd/amd-overdrive-rev-b1.dts b/arch/arm64/boot/dts/amd/amd-overdrive-rev-b1.dts
index 07dab1f1e3c8..99205ae1b46b 100644
--- a/arch/arm64/boot/dts/amd/amd-overdrive-rev-b1.dts
+++ b/arch/arm64/boot/dts/amd/amd-overdrive-rev-b1.dts
@@ -26,7 +26,7 @@ psci {
 };
 
 &ccp0 {
-	status = "ok";
+	status = "okay";
 	amd,zlib-support = <1>;
 };
 
@@ -34,43 +34,43 @@ &ccp0 {
  * NOTE: In Rev.B, gpio0 is reserved.
  */
 &gpio1 {
-	status = "ok";
+	status = "okay";
 };
 
 &gpio2 {
-	status = "ok";
+	status = "okay";
 };
 
 &gpio3 {
-	status = "ok";
+	status = "okay";
 };
 
 &gpio4 {
-	status = "ok";
+	status = "okay";
 };
 
 &i2c0 {
-	status = "ok";
+	status = "okay";
 };
 
 &i2c1 {
-	status = "ok";
+	status = "okay";
 };
 
 &pcie0 {
-	status = "ok";
+	status = "okay";
 };
 
 &sata1 {
-	status = "ok";
+	status = "okay";
 };
 
 &spi0 {
-	status = "ok";
+	status = "okay";
 };
 
 &spi1 {
-	status = "ok";
+	status = "okay";
 	sdcard0: sdcard@0 {
 		compatible = "mmc-spi-slot";
 		reg = <0>;
@@ -85,7 +85,7 @@ sdcard0: sdcard@0 {
 };
 
 &ipmi_kcs {
-	status = "ok";
+	status = "okay";
 };
 
 &smb0 {
-- 
2.34.1

