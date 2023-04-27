Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 402036F04B1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 13:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243505AbjD0LF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 07:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243269AbjD0LFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 07:05:25 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CAC8BB
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 04:05:24 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33R5FBOL004611;
        Thu, 27 Apr 2023 06:05:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=e+uZVxVZOBI4/nOG9R68nqSUwYP2oO1jBt1tk3mwG+A=;
 b=XFN7t/MQ+ODDiT3YsTs4K+A0Jy0jSyno13wuFgPyxUEYDvOXxN67J1SJae3aIvLvjFK7
 I6b9lujkfm4qqkveTgki/hI9xMmsxxCjOqpks90P+rYpZg91FlZ187alcF6Mtwm/97q0
 D0VuQHdNAtk9TlfRZJnLl93HWbWHUGpIR8mKKKTLlI8uRNQGqUJ40E40QBSRSvCeHPR0
 2W71IVCo50JT4iThcxNHDLvKKC5LUqvpQx97vB6MKL0tVaQtc+2XkIAsaJgbYfiG45XN
 4kASa/TYug8S+Pr+Q+h30lxFH6uNl1wpC832hGgKhPKEZQpfDtgGfnu3QEFhZADLD83d MA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3q4c0pqqw1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Apr 2023 06:05:04 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Thu, 27 Apr
 2023 06:05:03 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 27 Apr 2023 06:05:03 -0500
Received: from lon-bigdaddy.ad.cirrus.com (LONN76BT3D3.ad.cirrus.com [198.90.238.185])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id D3DB511C6;
        Thu, 27 Apr 2023 11:05:02 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Subject: [PATCH] ALSA: hda/realtek: Add quirk for ThinkPad P1 Gen 6
Date:   Thu, 27 Apr 2023 12:04:52 +0100
Message-ID: <20230427110452.13787-1-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: G8yE1dUBU_OPKhHXtEA2VwmVQIuGFiF5
X-Proofpoint-ORIG-GUID: G8yE1dUBU_OPKhHXtEA2VwmVQIuGFiF5
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lenovo ThinkPad P1 Gen 6 laptop has 2 CS35L41 amplifies
on I2C bus connected to Realtek codec.

Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/pci/hda/patch_realtek.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index ab938fa1d65d..d973ebb77743 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9691,6 +9691,8 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x22f1, "Thinkpad", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x17aa, 0x22f2, "Thinkpad", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x17aa, 0x22f3, "Thinkpad", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x17aa, 0x2316, "Thinkpad P1 Gen 6", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x17aa, 0x2317, "Thinkpad P1 Gen 6", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x17aa, 0x30bb, "ThinkCentre AIO", ALC233_FIXUP_LENOVO_LINE2_MIC_HOTKEY),
 	SND_PCI_QUIRK(0x17aa, 0x30e2, "ThinkCentre AIO", ALC233_FIXUP_LENOVO_LINE2_MIC_HOTKEY),
 	SND_PCI_QUIRK(0x17aa, 0x310c, "ThinkCentre Station", ALC294_FIXUP_LENOVO_MIC_LOCATION),
-- 
2.34.1

