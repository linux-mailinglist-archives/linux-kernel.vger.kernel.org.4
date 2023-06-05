Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 802C6722B09
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 17:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234599AbjFEP3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 11:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234205AbjFEP3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 11:29:17 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0080F7
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 08:29:15 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3558sEEH030588;
        Mon, 5 Jun 2023 10:29:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=eYBg8d8Hvj15ndjFUQ9ONSXAzqhuPZlCNKFw2fRkfqM=;
 b=XVQdMUiwFCV1xgNobYOpoj9ynBGEzVnZ6JJ3gBWqNrVNWPfPo4muzn0cPgaqmzqzAnjq
 wGLZBoykwwYlRmpypyPmNla7qZl4URHILlna33kGiE5Iur9bKKpZERte/bCgH6bl1Pqh
 M6dUfgQBsrbM+SVU4hItxeSFTVG55wzaZcF8QpKFvLHEO7io2k6q0YTXuA1m0jehNhUc
 uaL7o14dtL6d4+YItJ4qrfM5iEjb3akyAFSPGHbNL5B6iDEsSvB5UdVHW1CklS5782A2
 BGvayWngHQPc+xCFZhxXhAvURIFIDyk/eN1oBFAXIwYnzG07nPuCPEPE8322/BYaOQz8 8A== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3r01xna179-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Jun 2023 10:29:05 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Mon, 5 Jun
 2023 16:29:03 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Mon, 5 Jun 2023 16:29:03 +0100
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (NEWNC1SL3J3.ad.cirrus.com [198.90.238.20])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 322B611C6;
        Mon,  5 Jun 2023 15:29:03 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v2 2/3] ALSA: hda: cs35l41: Fix endian conversions
Date:   Mon, 5 Jun 2023 16:28:54 +0100
Message-ID: <20230605152855.448115-3-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230605152855.448115-1-sbinding@opensource.cirrus.com>
References: <20230605152855.448115-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: jfXpQQwIbuQLEB63hjr0rcaSYRFwu9AC
X-Proofpoint-GUID: jfXpQQwIbuQLEB63hjr0rcaSYRFwu9AC
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

