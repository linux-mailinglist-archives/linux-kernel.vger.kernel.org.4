Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECAC6AE699
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 17:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjCGQby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 11:31:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjCGQbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 11:31:32 -0500
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3220C85A42
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 08:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=BL47/9gshlsQiA
        D5V7ioQV+yS8e/Scob5w8583YxF3o=; b=JDSYoj8VlQmdXygO7ag7zGmEizmUR4
        rmYi5kQbOz4dp6qm+SOZ12S6B5zg5R1o8Kg9yxr6EmDyWyo4SJUD5Ia8qNI39dSv
        rvXDSYTdsSwBBj/B8rb1CLBD2QULzLezh88j6DLbeUFrATr7zs1eJiy2ajVsPO9y
        U02JKNT4atRw8=
Received: (qmail 752025 invoked from network); 7 Mar 2023 17:31:05 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 7 Mar 2023 17:31:05 +0100
X-UD-Smtp-Session: l3s3148p1@ROgh8FH2bI0gAQnoAFQ+AGEn9EY5VOxJ
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/11] media: renesas: fdp1: remove R-Car H3 ES1.* handling
Date:   Tue,  7 Mar 2023 17:30:33 +0100
Message-Id: <20230307163041.3815-6-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230307163041.3815-1-wsa+renesas@sang-engineering.com>
References: <20230307163041.3815-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
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

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
Please apply individually per subsystem. There are no dependencies and the SoC
doesn't boot anymore since v6.3-rc1.

 drivers/media/platform/renesas/rcar_fdp1.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/media/platform/renesas/rcar_fdp1.c b/drivers/media/platform/renesas/rcar_fdp1.c
index 37ecf489d112..f4a1fc8ce595 100644
--- a/drivers/media/platform/renesas/rcar_fdp1.c
+++ b/drivers/media/platform/renesas/rcar_fdp1.c
@@ -254,7 +254,6 @@ MODULE_PARM_DESC(debug, "activate debug info");
 
 /* Internal Data (HW Version) */
 #define FD1_IP_INTDATA			0x0800
-#define FD1_IP_H3_ES1			0x02010101
 #define FD1_IP_M3W			0x02010202
 #define FD1_IP_H3			0x02010203
 #define FD1_IP_M3N			0x02010204
@@ -2359,9 +2358,6 @@ static int fdp1_probe(struct platform_device *pdev)
 
 	hw_version = fdp1_read(fdp1, FD1_IP_INTDATA);
 	switch (hw_version) {
-	case FD1_IP_H3_ES1:
-		dprintk(fdp1, "FDP1 Version R-Car H3 ES1\n");
-		break;
 	case FD1_IP_M3W:
 		dprintk(fdp1, "FDP1 Version R-Car M3-W\n");
 		break;
-- 
2.35.1

