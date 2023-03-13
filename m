Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 548566B7C69
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 16:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbjCMPvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 11:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbjCMPuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 11:50:46 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD4A76F58
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 08:50:28 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32D5bF4C000339;
        Mon, 13 Mar 2023 10:50:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=89OqfVmfn1Au+gkokDwDQ8MKFgxhf0rl2z2ZybdFitE=;
 b=NDXR3A/ntpPiLPEVtB6ReIrXd2WuqgOYNPWWKJ1JyiDepx8iIQgpWjGYGm6qBiwBgV3M
 tQR0QACTTDfCJ4aJx0r4rXhhbBAhFy1K3NrkrlN1cw/oOAiluPxy/fjhHlHAX4pOQrhl
 tPYSYyZtMku7eloyNYMGZ/JXYfcnEz6c2Xd7+9cf4e4MUCbnSO6MkB7vt5HotEaATetW
 uN5D2t9psh05ZMjOryyThVXzuINcsF9p6CWNLelDnyEeQ7dYfWzmQ++MLI+9pnHrBpV5
 Gzs8Jf9QEb2VH59491eMh37BSgnexI2COiheBcV6iU4I8aeqivpDG1aczHNYlE9bgDCE 0w== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3p8pxvb6hn-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Mar 2023 10:50:07 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Mon, 13 Mar
 2023 10:50:06 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Mon, 13 Mar 2023 10:50:06 -0500
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.64.92])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id B3DA011D3;
        Mon, 13 Mar 2023 15:50:05 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>, <pierre-louis.bossart@linux.intel.com>
CC:     <peter.ujfalusi@linux.intel.com>,
        <yung-chuan.liao@linux.intel.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v2 4/8] ASoC: wm_adsp: Support DSPs that don't require firmware download
Date:   Mon, 13 Mar 2023 15:49:51 +0000
Message-ID: <20230313154955.4268-5-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230313154955.4268-1-rf@opensource.cirrus.com>
References: <20230313154955.4268-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: j1vjyCqDeQFFRWe6RfPZutysp51S-eZw
X-Proofpoint-GUID: j1vjyCqDeQFFRWe6RfPZutysp51S-eZw
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Simon Trimmer <simont@opensource.cirrus.com>

When a DSP can self-boot from ROM it is not necessary to download
firmware - when the DSP has the wmfw_optional flag set not finding a
wmfw firmware file is a successful outcome and not an error condition.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/wm_adsp.c | 3 +++
 sound/soc/codecs/wm_adsp.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 854d9366a745..8176b6173de9 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -850,6 +850,9 @@ static int wm_adsp_request_firmware_files(struct wm_adsp *dsp,
 		return 0;
 	}
 
+	if (dsp->wmfw_optional)
+		return 0;
+
 	adsp_err(dsp, "Failed to request firmware <%s>%s-%s-%s<-%s<%s>>.wmfw\n",
 		 cirrus_dir, dsp->part, dsp->fwf_name, wm_adsp_fw[dsp->fw].file,
 		 system_name, asoc_component_prefix);
diff --git a/sound/soc/codecs/wm_adsp.h b/sound/soc/codecs/wm_adsp.h
index dc2f7a096e26..173dcae2c260 100644
--- a/sound/soc/codecs/wm_adsp.h
+++ b/sound/soc/codecs/wm_adsp.h
@@ -34,6 +34,7 @@ struct wm_adsp {
 	unsigned int sys_config_size;
 
 	int fw;
+	bool wmfw_optional;
 
 	struct work_struct boot_work;
 	int (*pre_run)(struct wm_adsp *dsp);
-- 
2.30.2

