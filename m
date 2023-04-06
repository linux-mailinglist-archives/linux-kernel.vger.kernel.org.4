Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95BA56D9E5B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 19:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239809AbjDFRSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 13:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239799AbjDFRSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 13:18:33 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9757FA5F8;
        Thu,  6 Apr 2023 10:18:27 -0700 (PDT)
Received: from localhost (unknown [188.27.34.213])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 29CF666031D8;
        Thu,  6 Apr 2023 18:18:26 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680801506;
        bh=qXAW+NxBtXP2ZLN97K9FdNC+pkjm39ZBXXRQWxqaxDQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ci7RrtHc9ZBNPOLRstPWC2OfXurE6hOiXoO0xHokWOqtETMDVeKr5a2cgZfpU9qZu
         C8TCUnss3cRqVa/nrK+V1sgtwpglXXJezjiafg4mO/MvhtRUwliCQR9HAwQYcKDq10
         yt3yWVja6aB/A5t+/bBxpU6Wiuf9+XeqFoOWB57YP8uMw4KSh3RhW0YXjK0025xFdQ
         5eam5pCDuPDqVoWPzf7Lr9Jv2LOJL+v8dg5hWsGEOCyDWha7cqVk7YVwj7n4HZ6idl
         XCp9FHDM6cWwtr4hl+UXUXB62/uckrMQV/Axi/FcvnAYlYzLFoFl4nWFoc4Qt3WTZS
         8RtYV5NrCxm3w==
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
Subject: [PATCH v2 5/8] regulator: fan53555: Make use of the bit macros
Date:   Thu,  6 Apr 2023 20:18:03 +0300
Message-Id: <20230406171806.948290-6-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230406171806.948290-1-cristian.ciocaltea@collabora.com>
References: <20230406171806.948290-1-cristian.ciocaltea@collabora.com>
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

