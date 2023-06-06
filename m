Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B67723FB4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 12:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236962AbjFFKfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 06:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237302AbjFFKfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 06:35:19 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F350510F2
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 03:35:00 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3565N8jJ006095;
        Tue, 6 Jun 2023 05:34:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=eYBg8d8Hvj15ndjFUQ9ONSXAzqhuPZlCNKFw2fRkfqM=;
 b=lPERgH4VbDVJISBOYuuiYc/9MyB5ccv1+/2EAhdlbAsQJF4VYx2k3PV7Dq0dGQwsquwL
 AB1xxFkf7mPCW0+06S6t+Oh78ra9o1FZ3KsCkqNW2OH8rlSjVuX0v3dLcGI7HfKHr7vQ
 znLBodm7StYHJK+brz4Si2gLmybr6jLuSNeq1dk71SWb4sPnrv1AjkJ9pYVTjpMRzF6n
 Un/Chte2EQvQ+GJADiZpio55iyMvzizJ/0F3vHm62UXpoAE52viM07NZpn4C0EiJwPkt
 6WgB6ixA9g/TtFA0ZwVBTwBOutIrWag0oedO30kNT4aO3kwy1LfcIouoD1FCd/aVhxQx cw== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3r02x1asf3-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Jun 2023 05:34:46 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Tue, 6 Jun
 2023 11:34:44 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 6 Jun 2023 11:34:44 +0100
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.90.238.36])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 2DB09B2F;
        Tue,  6 Jun 2023 10:34:44 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v3 2/3] ALSA: hda: cs35l41: Fix endian conversions
Date:   Tue, 6 Jun 2023 11:34:35 +0100
Message-ID: <20230606103436.455348-3-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230606103436.455348-1-sbinding@opensource.cirrus.com>
References: <20230606103436.455348-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: pGAQLpAMfUUpUum8VCGzvu5H1KEWN9ym
X-Proofpoint-GUID: pGAQLpAMfUUpUum8VCGzvu5H1KEWN9ym
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Found during static analysis, ensure variables are correct
types before endian conversion.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/pci/hda/cs35l41_hda.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index d100189e15b83..ce5faa6205170 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -308,8 +308,8 @@ static int cs35l41_request_firmware_files(struct cs35l41_hda *cs35l41,
 }
 
 #if IS_ENABLED(CONFIG_EFI)
-static int cs35l41_apply_calibration(struct cs35l41_hda *cs35l41, unsigned int ambient,
-				     unsigned int r0, unsigned int status, unsigned int checksum)
+static int cs35l41_apply_calibration(struct cs35l41_hda *cs35l41, __be32 ambient, __be32 r0,
+				     __be32 status, __be32 checksum)
 {
 	int ret;
 
@@ -745,7 +745,7 @@ static int cs35l41_runtime_resume(struct device *dev)
 
 static int cs35l41_smart_amp(struct cs35l41_hda *cs35l41)
 {
-	int halo_sts;
+	__be32 halo_sts;
 	int ret;
 
 	ret = cs35l41_init_dsp(cs35l41);
@@ -773,7 +773,7 @@ static int cs35l41_smart_amp(struct cs35l41_hda *cs35l41)
 				&halo_sts, sizeof(halo_sts));
 
 	if (ret) {
-		dev_err(cs35l41->dev, "Timeout waiting for HALO Core to start. State: %d\n",
+		dev_err(cs35l41->dev, "Timeout waiting for HALO Core to start. State: %u\n",
 			 halo_sts);
 		goto clean_dsp;
 	}
-- 
2.34.1

