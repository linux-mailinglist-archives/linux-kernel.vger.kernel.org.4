Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B0B6F1701
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 13:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240007AbjD1Lqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 07:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjD1Lqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 07:46:48 -0400
X-Greylist: delayed 1071 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 28 Apr 2023 04:46:46 PDT
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE52F55A3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 04:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
        s=default2211; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
        Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References;
        bh=2FnTJdfVTyw80sm1fcAcV6AV8ZSf37nFfXH+BhtyVTI=; b=zQeibWxV09o9jJx8pIcN/xevgQ
        PP8WydmLeZziacMD7QFNULbIpBRT+Q/v4i2gfQ1WRiGfkgXJitrG24HkULCIXvROklYG/ZIeJGL+5
        u0djmP02/BXRYghBvBGTUch3oUPiNY/Q0rrffZnXpM/ivJq3T3uNuGFqLBTRfkg1rk3KIzzHKFL44
        BFCSIoViqiYJUEOljDz0AUnWso01YtroagIZ5w8wKMTOaXWK1Y3xnr/SwP3pe8qpSVKFwNs0bkwQ5
        sVpOJTHq4g/bu9fi/8pxFvU1jQvPjmx38xttsxySI3/2IqbL+VWPNCfWQk178M38ZUc+RO6jrstmq
        4uhqRRog==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <sean@geanix.com>)
        id 1psMHU-000Ldj-Et; Fri, 28 Apr 2023 13:28:52 +0200
Received: from [185.17.218.86] (helo=zen..)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sean@geanix.com>)
        id 1psMHU-00021I-7V; Fri, 28 Apr 2023 13:28:52 +0200
From:   Sean Nyekjaer <sean@geanix.com>
To:     Lee Jones <lee@kernel.org>
Cc:     p.paillet@st.com, Sean Nyekjaer <sean@geanix.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mfd: stpmic1: fixup main control register and bits naming
Date:   Fri, 28 Apr 2023 13:28:45 +0200
Message-Id: <20230428112847.2146348-1-sean@geanix.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.8/26890/Fri Apr 28 09:22:55 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixup main control register and bits naming so the match the naming from
the datasheet.

https://www.st.com/resource/en/datasheet/stpmic1.pdf

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/mfd/stpmic1.c       |  4 ++--
 include/linux/mfd/stpmic1.h | 12 ++++++------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/mfd/stpmic1.c b/drivers/mfd/stpmic1.c
index 8db1530d9bac..4c9b18d9dec8 100644
--- a/drivers/mfd/stpmic1.c
+++ b/drivers/mfd/stpmic1.c
@@ -19,7 +19,7 @@
 
 static const struct regmap_range stpmic1_readable_ranges[] = {
 	regmap_reg_range(TURN_ON_SR, VERSION_SR),
-	regmap_reg_range(SWOFF_PWRCTRL_CR, LDO6_STDBY_CR),
+	regmap_reg_range(MAIN_CR, LDO6_STDBY_CR),
 	regmap_reg_range(BST_SW_CR, BST_SW_CR),
 	regmap_reg_range(INT_PENDING_R1, INT_PENDING_R4),
 	regmap_reg_range(INT_CLEAR_R1, INT_CLEAR_R4),
@@ -30,7 +30,7 @@ static const struct regmap_range stpmic1_readable_ranges[] = {
 };
 
 static const struct regmap_range stpmic1_writeable_ranges[] = {
-	regmap_reg_range(SWOFF_PWRCTRL_CR, LDO6_STDBY_CR),
+	regmap_reg_range(MAIN_CR, LDO6_STDBY_CR),
 	regmap_reg_range(BST_SW_CR, BST_SW_CR),
 	regmap_reg_range(INT_CLEAR_R1, INT_CLEAR_R4),
 	regmap_reg_range(INT_SET_MASK_R1, INT_SET_MASK_R4),
diff --git a/include/linux/mfd/stpmic1.h b/include/linux/mfd/stpmic1.h
index fa3f99f7e9a1..dc00bac24f5a 100644
--- a/include/linux/mfd/stpmic1.h
+++ b/include/linux/mfd/stpmic1.h
@@ -15,7 +15,7 @@
 #define RREQ_STATE_SR		0x5
 #define VERSION_SR		0x6
 
-#define SWOFF_PWRCTRL_CR	0x10
+#define MAIN_CR			0x10
 #define PADS_PULL_CR		0x11
 #define BUCKS_PD_CR		0x12
 #define LDO14_PD_CR		0x13
@@ -148,14 +148,14 @@
 #define LDO_BYPASS_MASK			BIT(7)
 
 /* Main PMIC Control Register
- * SWOFF_PWRCTRL_CR
+ * MAIN_CR
  * Address : 0x10
  */
-#define ICC_EVENT_ENABLED		BIT(4)
+#define OCP_OFF_DBG			BIT(4)
 #define PWRCTRL_POLARITY_HIGH		BIT(3)
-#define PWRCTRL_PIN_VALID		BIT(2)
-#define RESTART_REQUEST_ENABLED		BIT(1)
-#define SOFTWARE_SWITCH_OFF_ENABLED	BIT(0)
+#define PWRCTRL_ENABLE			BIT(2)
+#define RESTART_REQUEST_ENABLE		BIT(1)
+#define SOFTWARE_SWITCH_OFF		BIT(0)
 
 /* Main PMIC PADS Control Register
  * PADS_PULL_CR
-- 
2.40.0

