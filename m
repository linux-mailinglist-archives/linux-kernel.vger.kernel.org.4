Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD316ADCAA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 11:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjCGK6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 05:58:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbjCGK51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 05:57:27 -0500
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D8E5BC90
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 02:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=ps06TxmpnW1uip
        6DKrBKFug1BJdUQMidCdmlJPWOKXc=; b=uQPboEB7hHus6O/J6mOarrpsry0H3V
        cQFnc/zujgCskc310FAqOhlWQoawUwBq1W4jVG55fJYhKSsR4hquCS+ECU255LS0
        z2RVJhqSjgcoC2C8qtAC+lngT0UAyMcRJr4aNJ3qjbb28K7gaxnJ8kvFtBnwEZdW
        1SXpyG7a+z0RM=
Received: (qmail 651009 invoked from network); 7 Mar 2023 11:57:08 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 7 Mar 2023 11:57:08 +0100
X-UD-Smtp-Session: l3s3148p1@ITzXRU32eI4gAQnoAFQ+AGEn9EY5VOxJ
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 4/5] soc: renesas: rcar-sysc: remove R-Car H3 ES1.* handling
Date:   Tue,  7 Mar 2023 11:56:40 +0100
Message-Id: <20230307105645.5285-5-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230307105645.5285-1-wsa+renesas@sang-engineering.com>
References: <20230307105645.5285-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FORGED_SPF_HELO,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

R-Car H3 ES1.* was only available to an internal development group and
needed a lot of quirks and workarounds. These become a maintenance
burden now, so our development group decided to remove upstream support
and disable booting for this SoC. Public users only have ES2 onwards.

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/soc/renesas/r8a7795-sysc.c       | 10 ----------
 include/dt-bindings/power/r8a7795-sysc.h |  1 -
 2 files changed, 11 deletions(-)

diff --git a/drivers/soc/renesas/r8a7795-sysc.c b/drivers/soc/renesas/r8a7795-sysc.c
index 91074411b8cf..cbe1ff0fc583 100644
--- a/drivers/soc/renesas/r8a7795-sysc.c
+++ b/drivers/soc/renesas/r8a7795-sysc.c
@@ -38,8 +38,6 @@ static struct rcar_sysc_area r8a7795_areas[] __initdata = {
 	{ "a3vp",	0x340, 0, R8A7795_PD_A3VP,	R8A7795_PD_ALWAYS_ON },
 	{ "cr7",	0x240, 0, R8A7795_PD_CR7,	R8A7795_PD_ALWAYS_ON },
 	{ "a3vc",	0x380, 0, R8A7795_PD_A3VC,	R8A7795_PD_ALWAYS_ON },
-	/* A2VC0 exists on ES1.x only */
-	{ "a2vc0",	0x3c0, 0, R8A7795_PD_A2VC0,	R8A7795_PD_A3VC },
 	{ "a2vc1",	0x3c0, 1, R8A7795_PD_A2VC1,	R8A7795_PD_A3VC },
 	{ "3dg-a",	0x100, 0, R8A7795_PD_3DG_A,	R8A7795_PD_ALWAYS_ON },
 	{ "3dg-b",	0x100, 1, R8A7795_PD_3DG_B,	R8A7795_PD_3DG_A },
@@ -54,14 +52,10 @@ static struct rcar_sysc_area r8a7795_areas[] __initdata = {
 	 * Fixups for R-Car H3 revisions
 	 */
 
-#define HAS_A2VC0	BIT(0)		/* Power domain A2VC0 is present */
 #define NO_EXTMASK	BIT(1)		/* Missing SYSCEXTMASK register */
 
 static const struct soc_device_attribute r8a7795_quirks_match[] __initconst = {
 	{
-		.soc_id = "r8a7795", .revision = "ES1.*",
-		.data = (void *)(HAS_A2VC0 | NO_EXTMASK),
-	}, {
 		.soc_id = "r8a7795", .revision = "ES2.*",
 		.data = (void *)(NO_EXTMASK),
 	},
@@ -77,10 +71,6 @@ static int __init r8a7795_sysc_init(void)
 	if (attr)
 		quirks = (uintptr_t)attr->data;
 
-	if (!(quirks & HAS_A2VC0))
-		rcar_sysc_nullify(r8a7795_areas, ARRAY_SIZE(r8a7795_areas),
-				  R8A7795_PD_A2VC0);
-
 	if (quirks & NO_EXTMASK)
 		r8a7795_sysc_info.extmask_val = 0;
 
diff --git a/include/dt-bindings/power/r8a7795-sysc.h b/include/dt-bindings/power/r8a7795-sysc.h
index eea6ad69f0b0..ff5323858572 100644
--- a/include/dt-bindings/power/r8a7795-sysc.h
+++ b/include/dt-bindings/power/r8a7795-sysc.h
@@ -30,7 +30,6 @@
 #define R8A7795_PD_CA53_SCU		21
 #define R8A7795_PD_3DG_E		22
 #define R8A7795_PD_A3IR			24
-#define R8A7795_PD_A2VC0		25	/* ES1.x only */
 #define R8A7795_PD_A2VC1		26
 
 /* Always-on power area */
-- 
2.35.1

