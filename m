Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23960720DEA
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 07:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbjFCFYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 01:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjFCFYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 01:24:07 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79744A2;
        Fri,  2 Jun 2023 22:24:06 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6af6f5fc42aso2816825a34.1;
        Fri, 02 Jun 2023 22:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685769846; x=1688361846;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=toBw9nUuf6WSVaDwJ5WhYaRBSOkx/ry8bMBeK7UQV9g=;
        b=l0Mlvcv8X0GAMywHOWpumUadWNJ73cIx/FCA50VQWZMHObfoNEjv7fPbJNw5Vs4YrD
         6O/P7GLOj4ZZBZyhe7aommRkH2FDyVrN0SVkg0CN7/cREQO1OZanCGY61Et82SrxDcFa
         5b+t7Rmgtu4NQInVYUDZjFdCujy/yyAxComUe9vLw43WAaP6jgCD5BEdYqF0WQLZE/jE
         8Wo67r9tFRnB3sOsQvaPPEswya2G2CMs3PLZVw86tQ7I0N/pX4B8Vhon9Mc9HULXWCit
         Lv3oXT6ZO1B0//f5Uq3ekM4Yseclq5Ezz/m9fqLUAiS3ZydFniKSbDor5S1/CH0FDHM6
         3RJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685769846; x=1688361846;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=toBw9nUuf6WSVaDwJ5WhYaRBSOkx/ry8bMBeK7UQV9g=;
        b=ZVC3FuQMQeo28WV8ibDqKyoP3K7RBEMkbPAPvD534XjqjuRdhqeWxO0LzbE5+ul0m2
         eMaAZsoaTmPaB+LJaZfRm5VucQtQLljSauNC9j5pJbIy5pVs6ghVIMxQCiexBa/jd8Iw
         T5K3ZdC1BBtS5sYy0sly5ikwLuuDX494hrHS2HzNURjms+2A2qcRFDO0k0fMD/NCISlP
         NrvtpkM8UcwEu2zOLtxVdF6dttvFGm87IuDYpqWYegX4b9hTF+J2sSJhLf02w9YwyE14
         IEjwZgd5UdLjad3HWIbBYWm9L5wvpMkEunt4z5QPazRuOk0BPQi9Q6S0wI7IoqCZeqgy
         YKAQ==
X-Gm-Message-State: AC+VfDwmK8WdtQLhJELwcxxjObs9WqLq7YBkhN9atffrNA80BbkNBDY/
        osh1UlLOektDgSqIA80UMskXn2x4D0Kz/RVV
X-Google-Smtp-Source: ACHHUZ5hYwedOMf4CnZrFOk98naDKtpfTCIjXXrqIal8+tuHfcoKn4EA8zL0Jee3yMkt/LJ5JB/rmw==
X-Received: by 2002:a9d:6246:0:b0:6ab:1338:fed5 with SMTP id i6-20020a9d6246000000b006ab1338fed5mr4806358otk.11.1685769845743;
        Fri, 02 Jun 2023 22:24:05 -0700 (PDT)
Received: from localhost.localdomain ([98.97.118.17])
        by smtp.gmail.com with ESMTPSA id j20-20020a635954000000b00519c3475f21sm2074767pgm.46.2023.06.02.22.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 22:24:05 -0700 (PDT)
From:   Ben Schneider <bschnei@gmail.com>
X-Google-Original-From: Ben Schneider <ben@bens.haus>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Linux Arm Kernel <linux-arm-kernel@lists.infradead.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Devicetree <devicetree@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Ben Schneider <ben@bens.haus>
Subject: [PATCH] arm64: dts: marvell: Fix espressobin-ultra boot failure and wifi
Date:   Sat,  3 Jun 2023 05:23:56 +0000
Message-Id: <20230603052356.3530-1-ben@bens.haus>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <87o7lys5x7.fsf@BL-laptop>
References: <87o7lys5x7.fsf@BL-laptop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Boot hangs on EspressoBIN Ultra (Armada 3720) after a message that device
vcc_sd1 had been disabled. The device manufacturer patched this issue in
their kernel fork noting that vcc_sd1 is used by the EspressoBIN model
but not the EspressoBIN Ultra. Removing the device from the tree fixes
the boot hang and wifi.

Signed-off-by: Ben Schneider <ben@bens.haus>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
index d29d2da95..f9abef8dc 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
@@ -24,6 +24,8 @@
 		ethernet5 = &switch0port4;
 	};
 
+	/delete-node/ regulator;
+
 	reg_usb3_vbus: usb3-vbus {
 		compatible = "regulator-fixed";
 		regulator-name = "usb3-vbus";
@@ -66,6 +68,7 @@
 };
 
 &sdhci1 {
+	/delete-property/ vqmmc-supply;
 	status = "disabled";
 };
 
-- 
2.17.1

