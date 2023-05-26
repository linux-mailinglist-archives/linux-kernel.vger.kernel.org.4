Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F091712D74
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 21:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242889AbjEZT2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 15:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbjEZT2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 15:28:51 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E840813D;
        Fri, 26 May 2023 12:28:48 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f6dfc4dffaso8117115e9.0;
        Fri, 26 May 2023 12:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685129327; x=1687721327;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r2u7HYAYhnPpwbg8AoNL/Nc2mv0TMbNbzkSuUSQa/5I=;
        b=XqJptVdkBB/silXVsUCtPljqQLf5sgpMp3WiGmOoZJx37ZogVB6n4p6J47b0bCQXiR
         sFAroUXnXoy76OENOGf6rNjLEXU4GSGDCzV7fAJ+ca5KR8IKKhAK8dZNCebNwPXdc8Wm
         V5qX3sbmH1BQJp3huDm13c1GmFFCT5MxNW3QXeUijuifqt9ED2uFewxfQCQU9d5NUNLJ
         C0foTfBf8ApQqNSMtIMYBUDaSViZDI4HKbIPF8Wil3EPDHlvaEvo0pUuww7cOOz1UlRk
         2OeuArscQr3IlLkkrD0ROJ/FYlJqI7s+D7i1Kfm8C6JYx2Wc/LVYcrL3ic/JbdPqXGFT
         WtVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685129327; x=1687721327;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r2u7HYAYhnPpwbg8AoNL/Nc2mv0TMbNbzkSuUSQa/5I=;
        b=iwAfZxktcZIZiD/HcCiBwHjPx/7amHpl2Pzl9uPMLLHOFHJE0z3n3Ff4aPjkHcV02a
         XqHguPi7MBALCgI/gliSDRZbVCZUEQGl4oKz5TYaX+ESqgndfRLuOTg3PlFQwzbkhXC/
         sK4YDT1NikLaNbWPt85gsVQ1CRUh7my9wV+Rgg2hkE8QWqSHKOtNy16PxG66WTrS1/uH
         Xyj8CGA1eKGL9qOmBmCCTcfLWSrl+cX/KLEQmGeVAWyr7o0eZgZEMJSJhsdANSMCU3Fl
         SrhBmKiE5Sv9Yq4n0aDEqyRKpfJFD8bmaUt28YIip/clhShtD0VToHJXSJu8uOFRMJZO
         NppQ==
X-Gm-Message-State: AC+VfDzrUKU3EidvfRqEvcBdzEHv5lWG8fbMQo2NzLOGjOh6jTDU8bIq
        UdXZBH3ZFtI/kT6aPbJ8bro=
X-Google-Smtp-Source: ACHHUZ76B7WrmZ9dS6igCOIhwUK56AjTNcL+DxOyFf3CBY69l+gOimJbAkjqOB6mP1IjetYrWz1oCA==
X-Received: by 2002:a7b:ca4d:0:b0:3f4:2374:3515 with SMTP id m13-20020a7bca4d000000b003f423743515mr2232979wml.5.1685129327375;
        Fri, 26 May 2023 12:28:47 -0700 (PDT)
Received: from standask-GA-A55M-S2HP ([188.123.113.247])
        by smtp.gmail.com with ESMTPSA id c3-20020a05600c0ac300b003f50e88ffc1sm9786371wmr.0.2023.05.26.12.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 12:28:47 -0700 (PDT)
Date:   Fri, 26 May 2023 21:28:45 +0200
From:   Stanislav Jakubek <stano.jakubek@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] ARM: dts: bcm-mobile: change "" includes to <> where
 applicable
Message-ID: <04aa10d644eb183f6c0c5b944e527e36d56e2110.1685127525.git.stano.jakubek@gmail.com>
References: <cover.1685127525.git.stano.jakubek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1685127525.git.stano.jakubek@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While at it, also sort the includes alphabetically.

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
 arch/arm/boot/dts/bcm11351.dtsi | 3 +--
 arch/arm/boot/dts/bcm21664.dtsi | 3 +--
 arch/arm/boot/dts/bcm23550.dtsi | 5 ++---
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/bcm11351.dtsi b/arch/arm/boot/dts/bcm11351.dtsi
index c30ff1b02e03..f395e95e0177 100644
--- a/arch/arm/boot/dts/bcm11351.dtsi
+++ b/arch/arm/boot/dts/bcm11351.dtsi
@@ -1,11 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0-only
 // Copyright (C) 2012-2013 Broadcom Corporation
 
+#include <dt-bindings/clock/bcm281xx.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 
-#include "dt-bindings/clock/bcm281xx.h"
-
 / {
 	#address-cells = <1>;
 	#size-cells = <1>;
diff --git a/arch/arm/boot/dts/bcm21664.dtsi b/arch/arm/boot/dts/bcm21664.dtsi
index 4e96656dc36a..2a426125f9fe 100644
--- a/arch/arm/boot/dts/bcm21664.dtsi
+++ b/arch/arm/boot/dts/bcm21664.dtsi
@@ -1,11 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0-only
 // Copyright (C) 2014 Broadcom Corporation
 
+#include <dt-bindings/clock/bcm21664.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 
-#include "dt-bindings/clock/bcm21664.h"
-
 / {
 	#address-cells = <1>;
 	#size-cells = <1>;
diff --git a/arch/arm/boot/dts/bcm23550.dtsi b/arch/arm/boot/dts/bcm23550.dtsi
index e1a5f1b40ef5..424c818d7a1b 100644
--- a/arch/arm/boot/dts/bcm23550.dtsi
+++ b/arch/arm/boot/dts/bcm23550.dtsi
@@ -30,12 +30,11 @@
  * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
+/* BCM23550 and BCM21664 have almost identical clocks */
+#include <dt-bindings/clock/bcm21664.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 
-/* BCM23550 and BCM21664 have almost identical clocks */
-#include "dt-bindings/clock/bcm21664.h"
-
 / {
 	#address-cells = <1>;
 	#size-cells = <1>;
-- 
2.25.1

