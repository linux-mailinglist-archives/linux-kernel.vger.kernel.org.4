Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC4F6C10B1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 12:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjCTLXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 07:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjCTLW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 07:22:59 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE4819AB
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 04:22:56 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32K6vbPn027039;
        Mon, 20 Mar 2023 06:22:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=AhHzewF/a8Pi4XOIK3HkeTNQoW8FqMDSxy5e171h1ek=;
 b=hmo7DgSdbdAu84j9wCyEUHHLJ/UsONjxm+cWxXS6nZNSKJI3VBxTQABSQKfNZhAnGCmW
 yO5gARAYFSdQsys/FwIL6E3P1uf97mq5igeqMsvXfwbECkAFLcTQj2bJdJQjCjzsJeXN
 1mWMdnatSBk5Lrkx028DzJINkW7+lhqAobIt5qPU0BIkDyzuI2U5fDwA2ZPEdB6d3SHM
 5EOwV9qoKty4MHt7pfbdmZknoxUPgVfzt2yO02YonN7v7KMFIkd0yd0kpJKNfF4eHbBY
 N2N/YDc5yIRnNdYCR8RJYVW7lt1Jii7oWmM8JxyPYeF1ekukz0eiWPPSyhUYzY/GV5kx lQ== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3pd9qptc81-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Mar 2023 06:22:47 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Mon, 20 Mar
 2023 06:22:45 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Mon, 20 Mar 2023 06:22:45 -0500
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.127])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id A320311DA;
        Mon, 20 Mar 2023 11:22:45 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>, <pierre-louis.bossart@linux.intel.com>
CC:     <peter.ujfalusi@linux.intel.com>,
        <yung-chuan.liao@linux.intel.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v3 2/8] ASoC: wm_adsp: Use no_core_startstop to prevent creating preload control
Date:   Mon, 20 Mar 2023 11:22:39 +0000
Message-ID: <20230320112245.115720-3-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230320112245.115720-1-rf@opensource.cirrus.com>
References: <20230320112245.115720-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Go6gZYVdb6JWw6-KneQkpsXWpDhcXrT6
X-Proofpoint-ORIG-GUID: Go6gZYVdb6JWw6-KneQkpsXWpDhcXrT6
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

The no_core_startstop flag indicates a self-booting DSP - they are
considered to be always running and therefore cannot be pre-loaded.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/wm_adsp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index ea0dbc634ecf..854d9366a745 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -1102,8 +1102,10 @@ int wm_adsp2_component_probe(struct wm_adsp *dsp, struct snd_soc_component *comp
 {
 	char preload[32];
 
-	snprintf(preload, ARRAY_SIZE(preload), "%s Preload", dsp->cs_dsp.name);
-	snd_soc_component_disable_pin(component, preload);
+	if (!dsp->cs_dsp.no_core_startstop) {
+		snprintf(preload, ARRAY_SIZE(preload), "%s Preload", dsp->cs_dsp.name);
+		snd_soc_component_disable_pin(component, preload);
+	}
 
 	cs_dsp_init_debugfs(&dsp->cs_dsp, component->debugfs_root);
 
-- 
2.30.2

