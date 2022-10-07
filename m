Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A33A95F7789
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 13:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiJGLf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 07:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiJGLft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 07:35:49 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4237CA8B8;
        Fri,  7 Oct 2022 04:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1665142547; x=1696678547;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2RVbvYXjr1Mv0ItSJmAN3AeJEgqHNTNSCbgYqMVw1Uk=;
  b=azUTgi5RJJ+Oyu9luDsB0G/5qXKxwmJQzArFjhY8eFYDlCQC3/ao2YLz
   fCp6BW3gDHFUkL93dZXerx0zSq0ffkHGVBmfqCFMcvaWXqPPre/jtVc7i
   7T2EOrIb/6UlAeM0WCioyqNr9twRyswa1T5EdNOZZmi9j7xI1OiaQAtBv
   tuJTES1gg7WvTrXHc6VG+QEpBcRZKkmP+eYRBPZED6nGtVzYKrQVjHiym
   sAuSRY8SeqWbv79wd829tWBwtl/ZWzXL7aOdfOKFfX3DgRwwaHrG1GmB9
   cpJoyhla1mLMsbC/x6pWdTKQaTtpRe3bINTp96MkZAXrrKFJb4nLcX3GH
   w==;
X-IronPort-AV: E=Sophos;i="5.95,166,1661842800"; 
   d="scan'208";a="117322480"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Oct 2022 04:35:46 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 7 Oct 2022 04:35:46 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Fri, 7 Oct 2022 04:35:44 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Daire McNamara <daire.mcnamara@microchip.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v11 2/4] riscv: dts: fix the icicle's #pwm-cells
Date:   Fri, 7 Oct 2022 12:35:11 +0100
Message-ID: <20221007113512.91501-3-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221007113512.91501-1-conor.dooley@microchip.com>
References: <20221007113512.91501-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

\#pwm-cells for the Icicle kit's fabric PWM was incorrectly set to 2 &
blindly overridden by the (out of tree) driver anyway. The core can
support inverted operation, so update the entry to correctly report its
capabilities.

Fixes: 72560c6559b8 ("riscv: dts: microchip: add fpga fabric section to icicle kit")
Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi
index 0d28858b83f2..e09a13aef268 100644
--- a/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi
+++ b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi
@@ -8,7 +8,7 @@ core_pwm0: pwm@41000000 {
 		compatible = "microchip,corepwm-rtl-v4";
 		reg = <0x0 0x41000000 0x0 0xF0>;
 		microchip,sync-update-mask = /bits/ 32 <0>;
-		#pwm-cells = <2>;
+		#pwm-cells = <3>;
 		clocks = <&fabric_clk3>;
 		status = "disabled";
 	};
-- 
2.37.3

