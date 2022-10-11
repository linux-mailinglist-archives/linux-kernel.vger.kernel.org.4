Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEC45FB4A3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 16:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiJKOg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 10:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiJKOg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 10:36:26 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC6049B4E
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 07:36:25 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29B6p4J4008726;
        Tue, 11 Oct 2022 09:36:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=LqOkwfdNZ/ZCmx2TzN2y0k5krzzeyl9p5lv9AobOKyY=;
 b=I/2qiTuonlcNPb9Zgd5zl1FtSDGIMm50UjN2+UW/nP/AKdY+0lT542kt4Fkrmgi19QS4
 wI6JFX2UBi+4NVN3ml3+56xjm4b5oA9W5JMhnuydC+XzPDOgGW/b2Se+T6qGhEaDCx27
 AH6nR7ZEw57eogLfuSdpl+fgoM2j+4AtkIQg1/nWI65Yi3tOAJv+kUA4LD/Q+fAOZeEC
 FOpUx+/xAM3yoTjAulHiJwFs0XeH/NOaTHwhBk00BnRrHyL4W14vKGjyzd2D6s5sTCei
 xh/TmTmd141sdFWiSs9S3fiXiPKxeuAq/LlWfmSG6bLY/0r7iyL3F5fEwblIa/AX9amE 7A== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3k35mpuhdu-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Oct 2022 09:36:15 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.12; Tue, 11 Oct
 2022 09:36:13 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.12 via Frontend Transport; Tue, 11 Oct 2022 09:36:13 -0500
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.90.202.160])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 08675356B;
        Tue, 11 Oct 2022 14:36:13 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v1 1/5] ALSA: hda: hda_cs_dsp_ctl: Minor clean and redundant code removal
Date:   Tue, 11 Oct 2022 15:35:48 +0100
Message-ID: <20221011143552.621792-2-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221011143552.621792-1-sbinding@opensource.cirrus.com>
References: <20221011143552.621792-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: eUuFYeNQKWWtPbyJ9e3-7CYlkj2OAGsn
X-Proofpoint-GUID: eUuFYeNQKWWtPbyJ9e3-7CYlkj2OAGsn
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cs_dsp core will return an error if passed a NULL cs_dsp struct so
there is no need for the hda_cs_dsp_write|read_ctl functions to manually
check that. The cs_dsp core will also check the data is within bounds of
the control so the additional bounds check is redundant too. Simplify
things a bit by removing said code.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/pci/hda/hda_cs_dsp_ctl.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/sound/pci/hda/hda_cs_dsp_ctl.c b/sound/pci/hda/hda_cs_dsp_ctl.c
index 89ee549cb7d50..41d3e8fd289d7 100644
--- a/sound/pci/hda/hda_cs_dsp_ctl.c
+++ b/sound/pci/hda/hda_cs_dsp_ctl.c
@@ -199,16 +199,10 @@ EXPORT_SYMBOL_NS_GPL(hda_cs_dsp_control_remove, SND_HDA_CS_DSP_CONTROLS);
 int hda_cs_dsp_write_ctl(struct cs_dsp *dsp, const char *name, int type,
 			 unsigned int alg, const void *buf, size_t len)
 {
-	struct cs_dsp_coeff_ctl *cs_ctl;
+	struct cs_dsp_coeff_ctl *cs_ctl = cs_dsp_get_ctl(dsp, name, type, alg);
 	struct hda_cs_dsp_coeff_ctl *ctl;
 	int ret;
 
-	cs_ctl = cs_dsp_get_ctl(dsp, name, type, alg);
-	if (!cs_ctl)
-		return -EINVAL;
-
-	ctl = cs_ctl->priv;
-
 	ret = cs_dsp_coeff_write_ctrl(cs_ctl, 0, buf, len);
 	if (ret)
 		return ret;
@@ -216,6 +210,8 @@ int hda_cs_dsp_write_ctl(struct cs_dsp *dsp, const char *name, int type,
 	if (cs_ctl->flags & WMFW_CTL_FLAG_SYS)
 		return 0;
 
+	ctl = cs_ctl->priv;
+
 	snd_ctl_notify(ctl->card, SNDRV_CTL_EVENT_MASK_VALUE, &ctl->kctl->id);
 
 	return 0;
@@ -225,13 +221,8 @@ EXPORT_SYMBOL_NS_GPL(hda_cs_dsp_write_ctl, SND_HDA_CS_DSP_CONTROLS);
 int hda_cs_dsp_read_ctl(struct cs_dsp *dsp, const char *name, int type,
 			unsigned int alg, void *buf, size_t len)
 {
-	struct cs_dsp_coeff_ctl *cs_ctl;
-
-	cs_ctl = cs_dsp_get_ctl(dsp, name, type, alg);
-	if (!cs_ctl)
-		return -EINVAL;
+	return cs_dsp_coeff_read_ctrl(cs_dsp_get_ctl(dsp, name, type, alg), 0, buf, len);
 
-	return cs_dsp_coeff_read_ctrl(cs_ctl, 0, buf, len);
 }
 EXPORT_SYMBOL_NS_GPL(hda_cs_dsp_read_ctl, SND_HDA_CS_DSP_CONTROLS);
 
-- 
2.34.1

