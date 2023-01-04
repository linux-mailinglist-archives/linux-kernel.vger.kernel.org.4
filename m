Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF5165D543
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 15:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239597AbjADONc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 09:13:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239558AbjADOMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 09:12:54 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C6912635;
        Wed,  4 Jan 2023 06:12:53 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id 3so18058766iou.12;
        Wed, 04 Jan 2023 06:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FT85qHg6jD8BoFUh0eh/A7wsqPFKPrl5rJEH5SdJkPI=;
        b=jbwDODxRaL8XWlbYZ7g3ZpGV3UtwDabsR+ej+Hi0SVGzL5eMofk+CFuCi2wECQhxAH
         mC2LDx2430m7c3VAs69zffBssI2SoECBf9s2eCBYFb6/Wbj2pWIBypYKg2/yICvXim5Q
         IfrusqIbQoHFJoA07cPJIOBjE3Zdtsz/Xzsjj9Riuw8oCD2HTmoY2to5wJZWfJFsLYPj
         ql/ObITlGdD1t2jh1LZ1apgEp9wvSCipYt5SBfQLHRdJpAvgz4Q0+2tjOJAESQmyBuBr
         yDejtDE6UIMtbrjwHkXCAjyIpEj+gehsGKavYJMFTM6kqpWsbx6a8dKvelWG5OTYsnmF
         d4sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FT85qHg6jD8BoFUh0eh/A7wsqPFKPrl5rJEH5SdJkPI=;
        b=RZL+e2LA8R9vL3BWnXil3WpQKKS88b7M7t9EGoa/NJ7EynItuQg9HJxSBrq37sF9vD
         DDhXD1XOw+AfhTE+HkxbTBNgkA0r2dhEpmYgCqJIeiQQ7pwmnBMpAEL4OLbtCKcB7nYC
         tBlgZg8dVB/KOyvT6r3QtwkmLGsNHoi7v5WwSYuE7CN0vd3nUu8v3jFKz++ZEYDOT178
         FZ3dMzUy1upRBj4riMJgIiYQ6o4/h2qlr9ci3t6QFiQORuorNnztC4ax5aOixO5KV/DC
         RiaIuW65xlf36pwJJvikcshYRKxmqQfW1W059wG76HVhKA9fxM6Wws7RhYHykc5rXN+l
         STKw==
X-Gm-Message-State: AFqh2kq63eUndkT6hSOjnNjUDEjGqUmvqFYC8mVx18rdTmLs0syhDqGc
        0p1YJL51sROFF9TAD+uyYQC4dqY3EDI=
X-Google-Smtp-Source: AMrXdXtQcBpaSveZnn8jVYa9SNXp5SkPZ9/6B7MkaKzxriaJ7R7p2+LIpzSAKtDDAk+RVSh0CSliQw==
X-Received: by 2002:a05:6602:5cd:b0:6bc:d712:8bcd with SMTP id w13-20020a05660205cd00b006bcd7128bcdmr27919673iox.21.1672841572057;
        Wed, 04 Jan 2023 06:12:52 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:447:d001:9aea:58ca:a321:54c8:c288])
        by smtp.gmail.com with ESMTPSA id ay28-20020a056638411c00b0038a5af5e831sm11353451jab.100.2023.01.04.06.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 06:12:51 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] arm64: dts: renesas: r8a774[a/b/e]1-beacon: Update corporate name
Date:   Wed,  4 Jan 2023 08:12:44 -0600
Message-Id: <20230104141245.8407-3-aford173@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230104141245.8407-1-aford173@gmail.com>
References: <20230104141245.8407-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the end of 2021, Beacon EmbeddedWorks was sold off from Compass.
Its legal name is now 'Logic PD, Inc. dba Beacon EmbeddedWorks" and
as far as I know Compass Electronics doesn't exist anymore.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/renesas/beacon-renesom-baseboard.dtsi b/arch/arm64/boot/dts/renesas/beacon-renesom-baseboard.dtsi
index 8b6fe235a8f0..b7741c10e778 100644
--- a/arch/arm64/boot/dts/renesas/beacon-renesom-baseboard.dtsi
+++ b/arch/arm64/boot/dts/renesas/beacon-renesom-baseboard.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright 2020, Compass Electronics Group, LLC
+ * Copyright 2020, Logic PD, Inc. dba Beacon EmbeddedWorks
  */
 
 #include <dt-bindings/gpio/gpio.h>
diff --git a/arch/arm64/boot/dts/renesas/beacon-renesom-som.dtsi b/arch/arm64/boot/dts/renesas/beacon-renesom-som.dtsi
index 1eb713530878..86a9d6381166 100644
--- a/arch/arm64/boot/dts/renesas/beacon-renesom-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/beacon-renesom-som.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright 2020, Compass Electronics Group, LLC
+ * Copyright 2020, Logic PD, Inc. dba Beacon EmbeddedWorks
  */
 
 #include <dt-bindings/gpio/gpio.h>
diff --git a/arch/arm64/boot/dts/renesas/r8a774a1-beacon-rzg2m-kit.dts b/arch/arm64/boot/dts/renesas/r8a774a1-beacon-rzg2m-kit.dts
index 9ae67263c0df..7c0e3252ce65 100644
--- a/arch/arm64/boot/dts/renesas/r8a774a1-beacon-rzg2m-kit.dts
+++ b/arch/arm64/boot/dts/renesas/r8a774a1-beacon-rzg2m-kit.dts
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright 2020, Compass Electronics Group, LLC
+ * Copyright 2020, Logic PD, Inc. dba Beacon EmbeddedWorks
  */
 
 /dts-v1/;
diff --git a/arch/arm64/boot/dts/renesas/r8a774b1-beacon-rzg2n-kit.dts b/arch/arm64/boot/dts/renesas/r8a774b1-beacon-rzg2n-kit.dts
index 89d708346ba8..f1fbd687d0f4 100644
--- a/arch/arm64/boot/dts/renesas/r8a774b1-beacon-rzg2n-kit.dts
+++ b/arch/arm64/boot/dts/renesas/r8a774b1-beacon-rzg2n-kit.dts
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright 2020, Compass Electronics Group, LLC
+ * Copyright 2020, Logic PD, Inc. dba Beacon EmbeddedWorks
  */
 
 /dts-v1/;
diff --git a/arch/arm64/boot/dts/renesas/r8a774e1-beacon-rzg2h-kit.dts b/arch/arm64/boot/dts/renesas/r8a774e1-beacon-rzg2h-kit.dts
index 3e9ced3b2d33..7ee1a1bed212 100644
--- a/arch/arm64/boot/dts/renesas/r8a774e1-beacon-rzg2h-kit.dts
+++ b/arch/arm64/boot/dts/renesas/r8a774e1-beacon-rzg2h-kit.dts
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright 2020, Compass Electronics Group, LLC
+ * Copyright 2020, Logic PD, Inc. dba Beacon EmbeddedWorks
  */
 
 /dts-v1/;
-- 
2.34.1

