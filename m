Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8846DA1B6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 21:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237744AbjDFTmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 15:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237645AbjDFTmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 15:42:21 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D42393EB;
        Thu,  6 Apr 2023 12:42:19 -0700 (PDT)
Received: from localhost (unknown [188.27.34.213])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1769D66031D9;
        Thu,  6 Apr 2023 20:42:18 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680810138;
        bh=qXAW+NxBtXP2ZLN97K9FdNC+pkjm39ZBXXRQWxqaxDQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TgS7KSHKboSv+CoImq/CKFcCgmLJj45/PlLVqOVMSP3e9kEM8tGV9UzfeUui/1YVX
         db0p4Be/OLxL3fcUbchrp40Vd5cMCCn3Jqfa+Vf1Ws0qtqJsQhO4D5pVQAvhosTyNv
         oh0ihIRa7DueIIuVFS+YD/xwGrnhDYjznf22qRohUJxyabGXM5RcjizseK7UtJe1lN
         J79ftHnjTCQqtusGY8UKy9oxE7sl3u6VORkiE/mdfIRLxFpM6SrW8pI8XV+g6I7xVK
         n1HA+YidW2h7dvG4e07FAsnnZIZilxeXmZZmEJxQGvnUNzhRjpMrB5ZIE1j1aGpuvF
         YT1BfbvqXqlhQ==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Joseph Chen <chenjh@rock-chips.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCH v3 5/8] regulator: fan53555: Make use of the bit macros
Date:   Thu,  6 Apr 2023 22:41:55 +0300
Message-Id: <20230406194158.963352-6-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230406194158.963352-1-cristian.ciocaltea@collabora.com>
References: <20230406194158.963352-1-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For consistency and improved clarity, use BIT() and GENMASK() macros for
defining the bitfields inside the registers. No functional changes
intended.

While here, also fix DIE_{ID,REV} inconsistent indentation.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/regulator/fan53555.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/regulator/fan53555.c b/drivers/regulator/fan53555.c
index 68ebcd4ccef7..181e5eb00e7a 100644
--- a/drivers/regulator/fan53555.c
+++ b/drivers/regulator/fan53555.c
@@ -41,23 +41,23 @@
 #define FAN53555_MONITOR	0x05
 
 /* VSEL bit definitions */
-#define VSEL_BUCK_EN	(1 << 7)
-#define VSEL_MODE		(1 << 6)
+#define VSEL_BUCK_EN		BIT(7)
+#define VSEL_MODE		BIT(6)
 /* Chip ID and Verison */
-#define DIE_ID		0x0F	/* ID1 */
-#define DIE_REV		0x0F	/* ID2 */
+#define DIE_ID			0x0F	/* ID1 */
+#define DIE_REV			0x0F	/* ID2 */
 /* Control bit definitions */
-#define CTL_OUTPUT_DISCHG	(1 << 7)
-#define CTL_SLEW_MASK		(0x7 << 4)
-#define CTL_RESET			(1 << 2)
+#define CTL_OUTPUT_DISCHG	BIT(7)
+#define CTL_SLEW_MASK		GENMASK(6, 4)
+#define CTL_RESET		BIT(2)
 #define CTL_MODE_VSEL0_MODE	BIT(0)
 #define CTL_MODE_VSEL1_MODE	BIT(1)
 
 #define FAN53555_NVOLTAGES	64	/* Numbers of voltages */
 #define FAN53526_NVOLTAGES	128
 
-#define TCS_VSEL0_MODE		(1 << 7)
-#define TCS_VSEL1_MODE		(1 << 6)
+#define TCS_VSEL0_MODE		BIT(7)
+#define TCS_VSEL1_MODE		BIT(6)
 
 #define TCS_SLEW_MASK		GENMASK(4, 3)
 
-- 
2.40.0

