Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1EF66AE698
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 17:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjCGQbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 11:31:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjCGQbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 11:31:32 -0500
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B16B8537E
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 08:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=k1; bh=2
        xmX64li5R8XVTY3e1IAV+jsSJYToTSbgonh9QmzGO8=; b=Asljh3Po8WQaM88UM
        /Qq2Lpzu4SxwtJIev27pFgr42fbPqqVDHXgovSh6/rAueps5ji3Y76gowGbtp9Qi
        HP1dbCiOJCFgwEYaiGQjEoam7gl0rx9DZ0B5ppkUZ6AqeCJF1T2X6XTCBQ4huIg9
        sJIqXFRFl+YsGj4lRQLREZ7rK8=
Received: (qmail 751992 invoked from network); 7 Mar 2023 17:31:04 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 7 Mar 2023 17:31:04 +0100
X-UD-Smtp-Session: l3s3148p1@a1AX8FH2XI0gAQnoAFQ+AGEn9EY5VOxJ
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/11] media: rcar-vin: csi2: remove R-Car H3 ES1.* handling
Date:   Tue,  7 Mar 2023 17:30:32 +0100
Message-Id: <20230307163041.3815-5-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230307163041.3815-1-wsa+renesas@sang-engineering.com>
References: <20230307163041.3815-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
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
Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
Please apply individually per subsystem. There are no dependencies and the SoC
doesn't boot anymore since v6.3-rc1.

 .../media/platform/renesas/rcar-vin/rcar-csi2.c   | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/media/platform/renesas/rcar-vin/rcar-csi2.c b/drivers/media/platform/renesas/rcar-vin/rcar-csi2.c
index 174aa6176f54..5dbd0daa8735 100644
--- a/drivers/media/platform/renesas/rcar-vin/rcar-csi2.c
+++ b/drivers/media/platform/renesas/rcar-vin/rcar-csi2.c
@@ -345,7 +345,7 @@ static const struct rcsi2_mbps_reg hsfreqrange_h3_v3h_m3n[] = {
 	{ /* sentinel */ },
 };
 
-static const struct rcsi2_mbps_reg hsfreqrange_m3w_h3es1[] = {
+static const struct rcsi2_mbps_reg hsfreqrange_m3w[] = {
 	{ .mbps =   80,	.reg = 0x00 },
 	{ .mbps =   90,	.reg = 0x10 },
 	{ .mbps =  100,	.reg = 0x20 },
@@ -1369,11 +1369,6 @@ static const struct rcar_csi2_info rcar_csi2_info_r8a7795 = {
 	.clear_ulps = true,
 };
 
-static const struct rcar_csi2_info rcar_csi2_info_r8a7795es1 = {
-	.hsfreqrange = hsfreqrange_m3w_h3es1,
-	.num_channels = 4,
-};
-
 static const struct rcar_csi2_info rcar_csi2_info_r8a7795es2 = {
 	.init_phtw = rcsi2_init_phtw_h3es2,
 	.hsfreqrange = hsfreqrange_h3_v3h_m3n,
@@ -1383,12 +1378,12 @@ static const struct rcar_csi2_info rcar_csi2_info_r8a7795es2 = {
 };
 
 static const struct rcar_csi2_info rcar_csi2_info_r8a7796 = {
-	.hsfreqrange = hsfreqrange_m3w_h3es1,
+	.hsfreqrange = hsfreqrange_m3w,
 	.num_channels = 4,
 };
 
 static const struct rcar_csi2_info rcar_csi2_info_r8a77961 = {
-	.hsfreqrange = hsfreqrange_m3w_h3es1,
+	.hsfreqrange = hsfreqrange_m3w,
 	.num_channels = 4,
 };
 
@@ -1481,10 +1476,6 @@ static const struct of_device_id rcar_csi2_of_table[] = {
 MODULE_DEVICE_TABLE(of, rcar_csi2_of_table);
 
 static const struct soc_device_attribute r8a7795[] = {
-	{
-		.soc_id = "r8a7795", .revision = "ES1.*",
-		.data = &rcar_csi2_info_r8a7795es1,
-	},
 	{
 		.soc_id = "r8a7795", .revision = "ES2.*",
 		.data = &rcar_csi2_info_r8a7795es2,
-- 
2.35.1

