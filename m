Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF66710DC9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 16:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241456AbjEYOAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 10:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241296AbjEYOAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 10:00:30 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E73E4A
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 07:00:19 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34P8Mm6O016336;
        Thu, 25 May 2023 09:00:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=K1cH0ZtWLCX8sI+lF/y9e1IRq9QfXxo07nEhVezuoz8=;
 b=Ri4YGLK3FZa9c9GfrDkby/4rbuLaStJrwhynXGQAFAahKrJDEOKPlcnwDe2fqwFgNUF8
 1G9rWJU3gXbHYKPaQpAsX7Oy4sKBPcT0gvzCdvFV1uypki79q0qRQnL7X9g67bCN3fpS
 QAZcWEi2THpSRpQr76ikxZo9VYqfuKHk2ovHHdeJtb4C/5+rpEA0pZxbIaD7njfn8Hnx
 EmVpb2TzgrhZIncTyl2mkqlB90vuRbNFVx4cNsdaAue/kwckxmAsgUvR3xnntbm3pCPb
 I5jv0nar1g7wdKEcRQD11SfYKkbtVR+YEmWUFhC0Y7SbhOcyajW9/lyv6CjHIAEazL5r Lg== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3qsde8hsqk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 09:00:05 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Thu, 25 May
 2023 09:00:03 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 25 May 2023 09:00:03 -0500
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.90.238.43])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 5A26E11D4;
        Thu, 25 May 2023 14:00:03 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH RESEND v1 2/3] ALSA: hda: cs35l41: Fix endian conversions
Date:   Thu, 25 May 2023 14:59:54 +0100
Message-ID: <20230525135955.2108140-3-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230525135955.2108140-1-sbinding@opensource.cirrus.com>
References: <20230525135955.2108140-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: pHXjP75wp6WerhLDKNYkfpBqR2QQBN9R
X-Proofpoint-GUID: pHXjP75wp6WerhLDKNYkfpBqR2QQBN9R
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
 sound/pci/hda/cs35l41_hda.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index d100189e15b83..b02462ae21f04 100644
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
 
@@ -379,10 +379,10 @@ static int cs35l41_save_calibration(struct cs35l41_hda *cs35l41)
 
 				/* Calibration can only be applied whilst the DSP is not running */
 				ret = cs35l41_apply_calibration(cs35l41,
-								cpu_to_be32(cl->calAmbient),
-								cpu_to_be32(cl->calR),
-								cpu_to_be32(cl->calStatus),
-								cpu_to_be32(cl->calR + 1));
+								(__be32)cpu_to_be32(cl->calAmbient),
+								(__be32)cpu_to_be32(cl->calR),
+								(__be32)cpu_to_be32(cl->calStatus),
+								(__be32)cpu_to_be32(cl->calR + 1));
 			}
 		}
 		vfree(data);
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

