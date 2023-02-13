Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C16569489E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 15:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbjBMOuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 09:50:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbjBMOuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 09:50:32 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8B11A96A
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 06:50:28 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31D5UX5E028354;
        Mon, 13 Feb 2023 08:50:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=ea/rFFhINu/phNw7OHU5UmtWWEBCiXfiwatQeZgF6Vg=;
 b=SOxPYNDZFNUrzaVkKlZRZtxz523HSCLbevaahZ/tzQH+l/xe5xA7q5LncoK4dzjkmm2o
 UujSsWbLwiKkZJpDmo4YTC9gw2TDDa4EShF+8gRjwRhBbsLEE/03l4u/RqrPS5KR0rVZ
 6bQPCKM4MCbP/SycEBbPmsvWh3/6EEFORpot6TvGmwi6gJidroVbWJhJpF76uQga5VOd
 iMQ4WMYZp0po6womMlIYNMk3Af+KngDWFXrhdumV4KRYa03eXkE8kxA/xSQTZfp9zMnx
 ZXUGcxmFGvU3i0dmDqlU7Fc/C4+6vOvLK/4L17G9/id+5U56JHQqd9AmkJrQ9QYA9klv Hg== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3np9a72amh-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 08:50:14 -0600
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.21; Mon, 13 Feb
 2023 08:50:11 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.21 via Frontend
 Transport; Mon, 13 Feb 2023 08:50:11 -0600
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.90.202.160])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 0FF69B0E;
        Mon, 13 Feb 2023 14:50:11 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v2 2/3] ALSA: hda: cs35l41: Ensure firmware/tuning pairs are always loaded
Date:   Mon, 13 Feb 2023 14:50:07 +0000
Message-ID: <20230213145008.1215849-3-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230213145008.1215849-1-sbinding@opensource.cirrus.com>
References: <20230213145008.1215849-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 4OBsQf7bp4e6wQ_oYQPMR7uCXMz1H5mJ
X-Proofpoint-ORIG-GUID: 4OBsQf7bp4e6wQ_oYQPMR7uCXMz1H5mJ
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
index f7815ee24f83..1aad2604b9db 100644
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

