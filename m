Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2152C68C0DA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 16:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjBFPBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 10:01:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjBFPA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 10:00:58 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13CACC3A
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 07:00:56 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 316BqM0S002041;
        Mon, 6 Feb 2023 09:00:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=QYdOhby/b5tYO8DIOi6LljJwi9QVEQ1B07mtLXDq7/M=;
 b=n6rhygeouS/c7IAa3PXJHuTErmJu5uGD5jU4dRqwt4NnE2ETSGpy+py789Gl9aNOhDNb
 7g6Rj0VhEFa1KaZqlPA3Xi0gNDIEm8CbSTdP0kDq073dt+d/goto/rHxwiZFOBG+h7+8
 y/du0Vj5QrQPlDtE/UyEOPNMwflb8YgCVNFgCR1Z1FY1To49FkFg8c+9JggDkKJsNEHQ
 moocn6QIBn8FGwA4WA+716P1ZpyBaQZnFQwLFy3WK/3QGq+fnti/6r1PsL7Lf/DZ9AC2
 zeSS03wZCaN+v32pVmWYgvvFCKjerwLgVslaFDcmCCR/kt4L6Gi0HCbadq0XV/ITS8+5 Yw== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3nhmnutkh9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 09:00:26 -0600
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.21; Mon, 6 Feb
 2023 09:00:25 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.21 via Frontend
 Transport; Mon, 6 Feb 2023 09:00:25 -0600
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.90.202.160])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id C81F7475;
        Mon,  6 Feb 2023 15:00:24 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v1] ALSA: hda/realtek: Add quirk for ASUS UM3402 using CS35L41
Date:   Mon, 6 Feb 2023 15:00:19 +0000
Message-ID: <20230206150019.3825120-1-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 8eOnuoD3DHaBWN4RwAuZCK7oBqsR8Gsy
X-Proofpoint-ORIG-GUID: 8eOnuoD3DHaBWN4RwAuZCK7oBqsR8Gsy
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This Asus Zenbook laptop use Realtek HDA codec combined with
2xCS35L41 Amplifiers using I2C with External Boost.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 4055a8f5880a..251b58069d6c 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9480,6 +9480,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1d4e, "ASUS TM420", ALC256_FIXUP_ASUS_HPE),
 	SND_PCI_QUIRK(0x1043, 0x1e02, "ASUS UX3402", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x1e11, "ASUS Zephyrus G15", ALC289_FIXUP_ASUS_GA502),
+	SND_PCI_QUIRK(0x1043, 0x1e12, "ASUS UM3402", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x1043, 0x1e51, "ASUS Zephyrus M15", ALC294_FIXUP_ASUS_GU502_PINS),
 	SND_PCI_QUIRK(0x1043, 0x1e5e, "ASUS ROG Strix G513", ALC294_FIXUP_ASUS_G513_PINS),
 	SND_PCI_QUIRK(0x1043, 0x1e8e, "ASUS Zephyrus G15", ALC289_FIXUP_ASUS_GA401),
-- 
2.34.1

