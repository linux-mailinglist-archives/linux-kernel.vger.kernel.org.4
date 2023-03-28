Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8665F6CC041
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 15:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbjC1NLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 09:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232884AbjC1NLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 09:11:19 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CAA8186
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 06:10:58 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32SBZ9Ds017317;
        Tue, 28 Mar 2023 08:10:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=SBVBP2O6FRWAWRziwk3kwVUhqi3kDk6Wgiv1InxnKQc=;
 b=OboXFdq9msq/5KIHuVG9FATmfjrZGOdanjSKjVr3Ca7PMz26NCL4shVh7atwx98/7ab6
 YyTgls/fyg6lqSuoQxCJWobmLYKZsbxqZyUnfo5Wg/QOst2TGFizxtToahtAfCZ/O2ag
 uL+rFkF38zs1gL/nSVt+SwUaJOSkLUPZ4Uoo7n5Xu6/7W3tmY36NQnWaeSwGvMMmEaEk
 26la93AN89waxQGCQfppS3BXOwWZ6f7kB8rKBZY0VVtDXczCsQv/LvzIrEs9bdpifgDG
 qC8vlbOA/LVCYWZMoEdtD6H+7GOaLttz0S2sMHH2rFWCQBcXal+6HjxB72B+0LQJ73S+ sw== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3phxc2kpbc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Mar 2023 08:10:27 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Tue, 28 Mar
 2023 08:10:25 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.25 via Frontend
 Transport; Tue, 28 Mar 2023 08:10:25 -0500
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.65.23])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id E5AB411D3;
        Tue, 28 Mar 2023 13:10:24 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v2] firmware: cs_dsp: Add a debugfs entry containing control details
Date:   Tue, 28 Mar 2023 14:10:18 +0100
Message-ID: <20230328131018.6820-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: YFUHLCytYklMFS0KhTsHdOZ1wm3BhZHD
X-Proofpoint-ORIG-GUID: YFUHLCytYklMFS0KhTsHdOZ1wm3BhZHD
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Simon Trimmer <simont@opensource.cirrus.com>

The file named 'controls' in the DSP's debugfs root contains a
formatted table describing the controls defined within the loaded DSP
firmware, it is of the form

  name: len region:offset addr fwname algid ctltype flags en dirty

Where flags is represented as a character for each flag if set, or '-',
enabled is whether the control is enabled or disabled and dirty is
whether the control value is set in the cache but not the hardware.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 drivers/firmware/cirrus/cs_dsp.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/firmware/cirrus/cs_dsp.c b/drivers/firmware/cirrus/cs_dsp.c
index 513136a924cf..e4ccfb6a8fa5 100644
--- a/drivers/firmware/cirrus/cs_dsp.c
+++ b/drivers/firmware/cirrus/cs_dsp.c
@@ -14,6 +14,7 @@
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 
@@ -457,6 +458,33 @@ static const struct {
 	},
 };
 
+static int cs_dsp_coeff_base_reg(struct cs_dsp_coeff_ctl *ctl, unsigned int *reg,
+				 unsigned int off);
+
+static int cs_dsp_debugfs_read_controls_show(struct seq_file *s, void *ignored)
+{
+	struct cs_dsp *dsp = s->private;
+	struct cs_dsp_coeff_ctl *ctl;
+	unsigned int reg;
+
+	list_for_each_entry(ctl, &dsp->ctl_list, list) {
+		cs_dsp_coeff_base_reg(ctl, &reg, 0);
+		seq_printf(s, "%22.*s: %#8zx %s:%08x %#8x %s %#8x %#4x %c%c%c%c %s %s\n",
+			   ctl->subname_len, ctl->subname, ctl->len,
+			   cs_dsp_mem_region_name(ctl->alg_region.type),
+			   ctl->offset, reg, ctl->fw_name, ctl->alg_region.alg, ctl->type,
+			   ctl->flags & WMFW_CTL_FLAG_VOLATILE ? 'V' : '-',
+			   ctl->flags & WMFW_CTL_FLAG_SYS ? 'S' : '-',
+			   ctl->flags & WMFW_CTL_FLAG_READABLE ? 'R' : '-',
+			   ctl->flags & WMFW_CTL_FLAG_WRITEABLE ? 'W' : '-',
+			   ctl->enabled ? "enabled" : "disabled",
+			   ctl->set ? "dirty" : "clean");
+	}
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(cs_dsp_debugfs_read_controls);
+
 /**
  * cs_dsp_init_debugfs() - Create and populate DSP representation in debugfs
  * @dsp: pointer to DSP structure
@@ -479,6 +507,9 @@ void cs_dsp_init_debugfs(struct cs_dsp *dsp, struct dentry *debugfs_root)
 		debugfs_create_file(cs_dsp_debugfs_fops[i].name, 0444, root,
 				    dsp, &cs_dsp_debugfs_fops[i].fops);
 
+	debugfs_create_file("controls", 0444, root, dsp,
+			    &cs_dsp_debugfs_read_controls_fops);
+
 	dsp->debugfs_root = root;
 }
 EXPORT_SYMBOL_NS_GPL(cs_dsp_init_debugfs, FW_CS_DSP);
-- 
2.30.2

