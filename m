Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F54708491
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 17:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbjERPEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 11:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbjERPEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 11:04:11 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5576318C
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 08:03:56 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34IBl9Gl018534;
        Thu, 18 May 2023 10:02:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=9VFpFPgEoHqPkXngB8mLww3M78YV7Ay78b5OSGxLAQk=;
 b=DcfYb17zHbduk9hIZzU4/KoI+Me+3J1g5gzmOFm2ekHSH064b2f79mpoSdYYysFj9SDN
 GxzdwcZ7SewgW9p7TGNsJ3lEEEnSfixwjkd5SKxyzaA/EgzApkjiieNw8UztKnGt4tpJ
 yhRxawyrFtpOWIwO7TI7FY1ozX1BGqDBQRikanySPyMP1z6peCsDkamqqzYgeptotUsw
 HRCN5mnwcYjqtdIxFbhS0dIx3dLyRJ/B5QjhsBhCBumzQLvKT7rpkolF692etOg0biZa
 gpqGyP9Dbxa9mZmOgn0r9Gnsu0TAyNFSeX3XxRgL8P1KQQSBxXOeapfwvkepK6Wrj+Er OQ== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3qngq1ghum-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 May 2023 10:02:52 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Thu, 18 May
 2023 10:02:50 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Thu, 18 May 2023 10:02:50 -0500
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.127])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 36FA9468;
        Thu, 18 May 2023 15:02:50 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 2/3] ASoC: cs35l56: sdw_write_no_pm() should be performed under a pm_runtime request
Date:   Thu, 18 May 2023 16:02:49 +0100
Message-ID: <20230518150250.1121006-3-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230518150250.1121006-1-rf@opensource.cirrus.com>
References: <20230518150250.1121006-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: HeMTtZiSETusfRvKc2rfNgNW62xe9dvb
X-Proofpoint-ORIG-GUID: HeMTtZiSETusfRvKc2rfNgNW62xe9dvb
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Simon Trimmer <simont@opensource.cirrus.com>

SoundWire bus accesses must be performed under the guard of a pm_runtime
request, in this case the write was being performed just after the
request had been put() and so the bus could not be guaranteed to be
available.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs35l56.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
index 906aa416879b..255c442308f2 100644
--- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@ -904,15 +904,15 @@ static void cs35l56_dsp_work(struct work_struct *work)
 err_unlock:
 	mutex_unlock(&cs35l56->irq_lock);
 err:
-	pm_runtime_mark_last_busy(cs35l56->dev);
-	pm_runtime_put_autosuspend(cs35l56->dev);
-
 	/* Re-enable SoundWire interrupts */
 	if (cs35l56->sdw_peripheral) {
 		cs35l56->sdw_irq_no_unmask = false;
 		sdw_write_no_pm(cs35l56->sdw_peripheral, CS35L56_SDW_GEN_INT_MASK_1,
 				CS35L56_SDW_INT_MASK_CODEC_IRQ);
 	}
+
+	pm_runtime_mark_last_busy(cs35l56->dev);
+	pm_runtime_put_autosuspend(cs35l56->dev);
 }
 
 static int cs35l56_component_probe(struct snd_soc_component *component)
-- 
2.30.2

