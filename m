Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBE1690DDD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 17:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbjBIQFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 11:05:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbjBIQF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 11:05:26 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2FD63138
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 08:04:37 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 319EawIJ008427;
        Thu, 9 Feb 2023 10:04:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=0g2LTTHomQ8ZX/7m8Mhldc+RMEpvUFHoHk2YOhn1/mo=;
 b=eGznf1ygU957P4huemchChvH6MSWtrDh2rmDJc+/epiuMRb3veS+VlZK/59ftFCfMrrY
 ZctFUEuPphxjl0aCaRVrOAgtDbvoDx6pWXCfuHtgfBAHK3n4vUhLUrR2PYE+nt6bb7N7
 /U4lLmlzSCJrorr2noHmnI1ViEkHbNAfvAGglel711o+rb6tZXelp720d2h2TRbRHZdM
 MBINoKC9blVrbrK8OAUFGKfgft/oen5AcrnufMBHDFBe1Lx3xSO9labUoOKnIMVYdYh1
 GQBnMjGsQiKgcNbhvBbkEpRh/4NrRFEguGNL7MnkTJzbBAX4CSlIF9t8yIAHJpLDqFir EQ== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3nhnn807j2-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Feb 2023 10:04:15 -0600
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.21; Thu, 9 Feb
 2023 10:04:13 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.21 via Frontend
 Transport; Thu, 9 Feb 2023 10:04:13 -0600
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.90.202.160])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 23DF711AB;
        Thu,  9 Feb 2023 16:04:13 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v1 2/3] ALSA: hda: cs35l41: Ensure firmware/tuning pairs are always loaded
Date:   Thu, 9 Feb 2023 16:04:02 +0000
Message-ID: <20230209160403.838326-3-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230209160403.838326-1-sbinding@opensource.cirrus.com>
References: <20230209160403.838326-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: EIkyPqiG-d5bho-enOlo5OOx1DBoKsTY
X-Proofpoint-ORIG-GUID: EIkyPqiG-d5bho-enOlo5OOx1DBoKsTY
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To ensure firmware for cs35l41 is correctly running, it is necessary
that a corresponding tuning file is also loaded. Without both,
the firmware may not be performing correctly
Ensure that if we load the firmware, we have also loaded the correct
tuning file. Otherwise, fall back to default firmware and tuning.
If default tuning is also missing, then disable DSP firmware.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/pci/hda/cs35l41_hda.c | 103 ++++++++++++++++++------------------
 1 file changed, 51 insertions(+), 52 deletions(-)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index 4dc57454201e..f577b20c241e 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -178,11 +178,10 @@ static int cs35l41_request_firmware_files_spkid(struct cs35l41_hda *cs35l41,
 					    cs35l41->speaker_id, "wmfw");
 	if (!ret) {
 		/* try cirrus/part-dspN-fwtype-sub<-spkidN><-ampname>.bin */
-		cs35l41_request_firmware_file(cs35l41, coeff_firmware, coeff_filename,
-					      CS35L41_FIRMWARE_ROOT,
-					      cs35l41->acpi_subsystem_id, cs35l41->amp_name,
-					      cs35l41->speaker_id, "bin");
-		return 0;
+		return cs35l41_request_firmware_file(cs35l41, coeff_firmware, coeff_filename,
+						     CS35L41_FIRMWARE_ROOT,
+						     cs35l41->acpi_subsystem_id, cs35l41->amp_name,
+						     cs35l41->speaker_id, "bin");
 	}
 
 	/* try cirrus/part-dspN-fwtype-sub<-ampname>.wmfw */
@@ -191,10 +190,10 @@ static int cs35l41_request_firmware_files_spkid(struct cs35l41_hda *cs35l41,
 					    cs35l41->amp_name, -1, "wmfw");
 	if (!ret) {
 		/* try cirrus/part-dspN-fwtype-sub<-spkidN><-ampname>.bin */
-		cs35l41_request_firmware_file(cs35l41, coeff_firmware, coeff_filename,
-					      CS35L41_FIRMWARE_ROOT, cs35l41->acpi_subsystem_id,
-					      cs35l41->amp_name, cs35l41->speaker_id, "bin");
-		return 0;
+		return cs35l41_request_firmware_file(cs35l41, coeff_firmware, coeff_filename,
+						     CS35L41_FIRMWARE_ROOT,
+						     cs35l41->acpi_subsystem_id, cs35l41->amp_name,
+						     cs35l41->speaker_id, "bin");
 	}
 
 	/* try cirrus/part-dspN-fwtype-sub<-spkidN>.wmfw */
@@ -209,11 +208,10 @@ static int cs35l41_request_firmware_files_spkid(struct cs35l41_hda *cs35l41,
 						    cs35l41->amp_name, cs35l41->speaker_id, "bin");
 		if (ret)
 			/* try cirrus/part-dspN-fwtype-sub<-spkidN>.bin */
-			cs35l41_request_firmware_file(cs35l41, coeff_firmware, coeff_filename,
-						CS35L41_FIRMWARE_ROOT,
-						cs35l41->acpi_subsystem_id,
-						NULL, cs35l41->speaker_id, "bin");
-		return 0;
+			return cs35l41_request_firmware_file(cs35l41, coeff_firmware,
+							     coeff_filename, CS35L41_FIRMWARE_ROOT,
+							     cs35l41->acpi_subsystem_id, NULL,
+							     cs35l41->speaker_id, "bin");
 	}
 
 	/* try cirrus/part-dspN-fwtype-sub.wmfw */
@@ -224,29 +222,16 @@ static int cs35l41_request_firmware_files_spkid(struct cs35l41_hda *cs35l41,
 		/* try cirrus/part-dspN-fwtype-sub<-spkidN><-ampname>.bin */
 		ret = cs35l41_request_firmware_file(cs35l41, coeff_firmware, coeff_filename,
 						    CS35L41_FIRMWARE_ROOT,
-						    cs35l41->acpi_subsystem_id,
-						    cs35l41->amp_name, cs35l41->speaker_id, "bin");
+						    cs35l41->acpi_subsystem_id, cs35l41->amp_name,
+						    cs35l41->speaker_id, "bin");
 		if (ret)
 			/* try cirrus/part-dspN-fwtype-sub<-spkidN>.bin */
-			cs35l41_request_firmware_file(cs35l41, coeff_firmware, coeff_filename,
-						      CS35L41_FIRMWARE_ROOT,
-						      cs35l41->acpi_subsystem_id,
-						      NULL, cs35l41->speaker_id, "bin");
-		return 0;
-	}
-
-	/* fallback try cirrus/part-dspN-fwtype.wmfw */
-	ret = cs35l41_request_firmware_file(cs35l41, wmfw_firmware, wmfw_filename,
-					    CS35L41_FIRMWARE_ROOT, NULL, NULL, -1, "wmfw");
-	if (!ret) {
-		/* fallback try cirrus/part-dspN-fwtype.bin */
-		cs35l41_request_firmware_file(cs35l41, coeff_firmware, coeff_filename,
-					      CS35L41_FIRMWARE_ROOT, NULL, NULL, -1, "bin");
-		return 0;
+			return cs35l41_request_firmware_file(cs35l41, coeff_firmware,
+							     coeff_filename, CS35L41_FIRMWARE_ROOT,
+							     cs35l41->acpi_subsystem_id, NULL,
+							     cs35l41->speaker_id, "bin");
 	}
 
-	dev_warn(cs35l41->dev, "Failed to request firmware\n");
-
 	return ret;
 }
 
@@ -258,9 +243,12 @@ static int cs35l41_request_firmware_files(struct cs35l41_hda *cs35l41,
 {
 	int ret;
 
-	if (cs35l41->speaker_id > -1)
-		return cs35l41_request_firmware_files_spkid(cs35l41, wmfw_firmware, wmfw_filename,
-							    coeff_firmware, coeff_filename);
+	if (cs35l41->speaker_id > -1) {
+		ret = cs35l41_request_firmware_files_spkid(cs35l41, wmfw_firmware, wmfw_filename,
+							   coeff_firmware, coeff_filename);
+		goto out;
+
+	}
 
 	/* try cirrus/part-dspN-fwtype-sub<-ampname>.wmfw */
 	ret = cs35l41_request_firmware_file(cs35l41, wmfw_firmware, wmfw_filename,
@@ -268,10 +256,11 @@ static int cs35l41_request_firmware_files(struct cs35l41_hda *cs35l41,
 					    cs35l41->amp_name, -1, "wmfw");
 	if (!ret) {
 		/* try cirrus/part-dspN-fwtype-sub<-ampname>.bin */
-		cs35l41_request_firmware_file(cs35l41, coeff_firmware, coeff_filename,
-					      CS35L41_FIRMWARE_ROOT, cs35l41->acpi_subsystem_id,
-					      cs35l41->amp_name, -1, "bin");
-		return 0;
+		ret = cs35l41_request_firmware_file(cs35l41, coeff_firmware, coeff_filename,
+						    CS35L41_FIRMWARE_ROOT,
+						    cs35l41->acpi_subsystem_id, cs35l41->amp_name,
+						    -1, "bin");
+		goto out;
 	}
 
 	/* try cirrus/part-dspN-fwtype-sub.wmfw */
@@ -286,25 +275,35 @@ static int cs35l41_request_firmware_files(struct cs35l41_hda *cs35l41,
 						    cs35l41->amp_name, -1, "bin");
 		if (ret)
 			/* try cirrus/part-dspN-fwtype-sub.bin */
-			cs35l41_request_firmware_file(cs35l41, coeff_firmware, coeff_filename,
-						      CS35L41_FIRMWARE_ROOT,
-						      cs35l41->acpi_subsystem_id,
-						      NULL, -1, "bin");
-		return 0;
+			ret = cs35l41_request_firmware_file(cs35l41, coeff_firmware, coeff_filename,
+							    CS35L41_FIRMWARE_ROOT,
+							    cs35l41->acpi_subsystem_id, NULL, -1,
+							    "bin");
 	}
 
+out:
+	if (!ret)
+		return 0;
+
+	/* Handle fallback */
+	dev_warn(cs35l41->dev, "Falling back to default firmware.\n");
+
+	release_firmware(*wmfw_firmware);
+	kfree(*wmfw_filename);
+
 	/* fallback try cirrus/part-dspN-fwtype.wmfw */
 	ret = cs35l41_request_firmware_file(cs35l41, wmfw_firmware, wmfw_filename,
 					    CS35L41_FIRMWARE_ROOT, NULL, NULL, -1, "wmfw");
-	if (!ret) {
+	if (!ret)
 		/* fallback try cirrus/part-dspN-fwtype.bin */
-		cs35l41_request_firmware_file(cs35l41, coeff_firmware, coeff_filename,
-					      CS35L41_FIRMWARE_ROOT, NULL, NULL, -1, "bin");
-		return 0;
-	}
-
-	dev_warn(cs35l41->dev, "Failed to request firmware\n");
+		ret = cs35l41_request_firmware_file(cs35l41, coeff_firmware, coeff_filename,
+						    CS35L41_FIRMWARE_ROOT, NULL, NULL, -1, "bin");
 
+	if (ret) {
+		release_firmware(*wmfw_firmware);
+		kfree(*wmfw_filename);
+		dev_warn(cs35l41->dev, "Unable to find firmware and tuning\n");
+	}
 	return ret;
 }
 
-- 
2.34.1

