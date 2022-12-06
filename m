Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9396441FA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 12:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232839AbiLFLWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 06:22:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234211AbiLFLWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 06:22:00 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEEF8B7FD
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 03:21:57 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NRJ0M5Q2xz8RTZG;
        Tue,  6 Dec 2022 19:21:55 +0800 (CST)
Received: from xaxapp03.zte.com.cn ([10.88.40.52])
        by mse-fl1.zte.com.cn with SMTP id 2B6BLnp4012360;
        Tue, 6 Dec 2022 19:21:49 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Tue, 6 Dec 2022 19:21:52 +0800 (CST)
Date:   Tue, 6 Dec 2022 19:21:52 +0800 (CST)
X-Zmail-TransId: 2af9638f25d060b938de
X-Mailer: Zmail v1.0
Message-ID: <202212061921524930043@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <suzuki.poulose@arm.com>
Cc:     <mathieu.poirier@linaro.org>, <mike.leach@linaro.org>,
        <leo.yan@linaro.org>, <alexander.shishkin@linux.intel.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: =?UTF-8?B?W1BBVENIXSBjb3Jlc2lnaHQ6IENvbnZlcnQgdG8gdXNlIHN5c2ZzX2VtaXQoKS9zeXNmc19lbWl0X2F0KCkgQVBJcw==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 2B6BLnp4012360
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.137.novalocal with ID 638F25D3.000 by FangMail milter!
X-FangMail-Envelope: 1670325715/4NRJ0M5Q2xz8RTZG/638F25D3.000/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 638F25D3.000/4NRJ0M5Q2xz8RTZG
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Follow the advice of the Documentation/filesystems/sysfs.rst and show()
should only use sysfs_emit() or sysfs_emit_at() when formatting the
value to be returned to user space.

Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/hwtracing/coresight/coresight-core.c  |   4 +-
 .../hwtracing/coresight/coresight-etm-perf.c  |   4 +-
 .../coresight/coresight-etm3x-sysfs.c         |   2 +-
 .../coresight/coresight-etm4x-sysfs.c         | 114 +++++++++---------
 drivers/hwtracing/coresight/coresight-stm.c   |   8 +-
 .../coresight/coresight-syscfg-configfs.c     |  25 ++--
 6 files changed, 77 insertions(+), 80 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index f3068175ca9d..d5d5080cce78 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -1236,7 +1236,7 @@ static ssize_t enable_sink_show(struct device *dev,
 {
 	struct coresight_device *csdev = to_coresight_device(dev);

-	return scnprintf(buf, PAGE_SIZE, "%u\n", csdev->activated);
+	return  sysfs_emit(buf, "%u\n", csdev->activated);
 }

 static ssize_t enable_sink_store(struct device *dev,
@@ -1266,7 +1266,7 @@ static ssize_t enable_source_show(struct device *dev,
 {
 	struct coresight_device *csdev = to_coresight_device(dev);

-	return scnprintf(buf, PAGE_SIZE, "%u\n", csdev->enable);
+	return sysfs_emit(buf, "%u\n", csdev->enable);
 }

 static ssize_t enable_source_store(struct device *dev,
diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 43bbd5dc3d3b..8bf8dbf4b7c2 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -726,7 +726,7 @@ static ssize_t etm_perf_sink_name_show(struct device *dev,
 	struct dev_ext_attribute *ea;

 	ea = container_of(dattr, struct dev_ext_attribute, attr);
-	return scnprintf(buf, PAGE_SIZE, "0x%lx\n", (unsigned long)(ea->var));
+	return sysfs_emit(buf, "0x%lx\n", (unsigned long)(ea->var));
 }

 static struct dev_ext_attribute *
@@ -818,7 +818,7 @@ static ssize_t etm_perf_cscfg_event_show(struct device *dev,
 	struct dev_ext_attribute *ea;

 	ea = container_of(dattr, struct dev_ext_attribute, attr);
-	return scnprintf(buf, PAGE_SIZE, "configid=0x%lx\n", (unsigned long)(ea->var));
+	return sysfs_emit(buf, "configid=0x%lx\n", (unsigned long)(ea->var));
 }

 int etm_perf_add_symlink_cscfg(struct device *dev, struct cscfg_config_desc *config_desc)
diff --git a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
index fd81eca3ec18..3cb811853d64 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
@@ -1181,7 +1181,7 @@ static ssize_t cpu_show(struct device *dev,
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);

 	val = drvdata->cpu;
-	return scnprintf(buf, PAGE_SIZE, "%d\n", val);
+	return sysfs_emit(buf, "%d\n", val);

 }
 static DEVICE_ATTR_RO(cpu);
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index 9cac848cffaf..46509fb6a373 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -62,7 +62,7 @@ static ssize_t nr_pe_cmp_show(struct device *dev,
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);

 	val = drvdata->nr_pe_cmp;
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 static DEVICE_ATTR_RO(nr_pe_cmp);

@@ -74,7 +74,7 @@ static ssize_t nr_addr_cmp_show(struct device *dev,
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);

 	val = drvdata->nr_addr_cmp;
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 static DEVICE_ATTR_RO(nr_addr_cmp);

@@ -86,7 +86,7 @@ static ssize_t nr_cntr_show(struct device *dev,
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);

 	val = drvdata->nr_cntr;
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 static DEVICE_ATTR_RO(nr_cntr);

@@ -98,7 +98,7 @@ static ssize_t nr_ext_inp_show(struct device *dev,
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);

 	val = drvdata->nr_ext_inp;
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 static DEVICE_ATTR_RO(nr_ext_inp);

@@ -110,7 +110,7 @@ static ssize_t numcidc_show(struct device *dev,
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);

 	val = drvdata->numcidc;
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 static DEVICE_ATTR_RO(numcidc);

@@ -122,7 +122,7 @@ static ssize_t numvmidc_show(struct device *dev,
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);

 	val = drvdata->numvmidc;
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 static DEVICE_ATTR_RO(numvmidc);

@@ -134,7 +134,7 @@ static ssize_t nrseqstate_show(struct device *dev,
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);

 	val = drvdata->nrseqstate;
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 static DEVICE_ATTR_RO(nrseqstate);

@@ -146,7 +146,7 @@ static ssize_t nr_resource_show(struct device *dev,
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);

 	val = drvdata->nr_resource;
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 static DEVICE_ATTR_RO(nr_resource);

@@ -158,7 +158,7 @@ static ssize_t nr_ss_cmp_show(struct device *dev,
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);

 	val = drvdata->nr_ss_cmp;
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 static DEVICE_ATTR_RO(nr_ss_cmp);

@@ -285,7 +285,7 @@ static ssize_t mode_show(struct device *dev,
 	struct etmv4_config *config = &drvdata->config;

 	val = config->mode;
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }

 static ssize_t mode_store(struct device *dev,
@@ -451,7 +451,7 @@ static ssize_t pe_show(struct device *dev,
 	struct etmv4_config *config = &drvdata->config;

 	val = config->pe_sel;
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }

 static ssize_t pe_store(struct device *dev,
@@ -486,7 +486,7 @@ static ssize_t event_show(struct device *dev,
 	struct etmv4_config *config = &drvdata->config;

 	val = config->eventctrl0;
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }

 static ssize_t event_store(struct device *dev,
@@ -535,7 +535,7 @@ static ssize_t event_instren_show(struct device *dev,
 	struct etmv4_config *config = &drvdata->config;

 	val = FIELD_GET(TRCEVENTCTL1R_INSTEN_MASK, config->eventctrl1);
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }

 static ssize_t event_instren_store(struct device *dev,
@@ -591,7 +591,7 @@ static ssize_t event_ts_show(struct device *dev,
 	struct etmv4_config *config = &drvdata->config;

 	val = config->ts_ctrl;
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }

 static ssize_t event_ts_store(struct device *dev,
@@ -621,7 +621,7 @@ static ssize_t syncfreq_show(struct device *dev,
 	struct etmv4_config *config = &drvdata->config;

 	val = config->syncfreq;
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }

 static ssize_t syncfreq_store(struct device *dev,
@@ -651,7 +651,7 @@ static ssize_t cyc_threshold_show(struct device *dev,
 	struct etmv4_config *config = &drvdata->config;

 	val = config->ccctlr;
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }

 static ssize_t cyc_threshold_store(struct device *dev,
@@ -684,7 +684,7 @@ static ssize_t bb_ctrl_show(struct device *dev,
 	struct etmv4_config *config = &drvdata->config;

 	val = config->bb_ctrl;
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }

 static ssize_t bb_ctrl_store(struct device *dev,
@@ -724,7 +724,7 @@ static ssize_t event_vinst_show(struct device *dev,
 	struct etmv4_config *config = &drvdata->config;

 	val = FIELD_GET(TRCVICTLR_EVENT_MASK, config->vinst_ctrl);
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }

 static ssize_t event_vinst_store(struct device *dev,
@@ -756,7 +756,7 @@ static ssize_t s_exlevel_vinst_show(struct device *dev,
 	struct etmv4_config *config = &drvdata->config;

 	val = FIELD_GET(TRCVICTLR_EXLEVEL_S_MASK, config->vinst_ctrl);
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }

 static ssize_t s_exlevel_vinst_store(struct device *dev,
@@ -791,7 +791,7 @@ static ssize_t ns_exlevel_vinst_show(struct device *dev,

 	/* EXLEVEL_NS, bits[23:20] */
 	val = FIELD_GET(TRCVICTLR_EXLEVEL_NS_MASK, config->vinst_ctrl);
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }

 static ssize_t ns_exlevel_vinst_store(struct device *dev,
@@ -825,7 +825,7 @@ static ssize_t addr_idx_show(struct device *dev,
 	struct etmv4_config *config = &drvdata->config;

 	val = config->addr_idx;
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }

 static ssize_t addr_idx_store(struct device *dev,
@@ -864,7 +864,7 @@ static ssize_t addr_instdatatype_show(struct device *dev,
 	spin_lock(&drvdata->spinlock);
 	idx = config->addr_idx;
 	val = FIELD_GET(TRCACATRn_TYPE_MASK, config->addr_acc[idx]);
-	len = scnprintf(buf, PAGE_SIZE, "%s\n",
+	len = sysfs_emit(buf, "%s\n",
 			val == TRCACATRn_TYPE_ADDR ? "instr" :
 			(val == TRCACATRn_TYPE_DATA_LOAD_ADDR ? "data_load" :
 			(val == TRCACATRn_TYPE_DATA_STORE_ADDR ? "data_store" :
@@ -916,7 +916,7 @@ static ssize_t addr_single_show(struct device *dev,
 	}
 	val = (unsigned long)config->addr_val[idx];
 	spin_unlock(&drvdata->spinlock);
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }

 static ssize_t addr_single_store(struct device *dev,
@@ -972,7 +972,7 @@ static ssize_t addr_range_show(struct device *dev,
 	val1 = (unsigned long)config->addr_val[idx];
 	val2 = (unsigned long)config->addr_val[idx + 1];
 	spin_unlock(&drvdata->spinlock);
-	return scnprintf(buf, PAGE_SIZE, "%#lx %#lx\n", val1, val2);
+	return sysfs_emit(buf, "%#lx %#lx\n", val1, val2);
 }

 static ssize_t addr_range_store(struct device *dev,
@@ -1047,7 +1047,7 @@ static ssize_t addr_start_show(struct device *dev,

 	val = (unsigned long)config->addr_val[idx];
 	spin_unlock(&drvdata->spinlock);
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }

 static ssize_t addr_start_store(struct device *dev,
@@ -1102,7 +1102,7 @@ static ssize_t addr_stop_show(struct device *dev,

 	val = (unsigned long)config->addr_val[idx];
 	spin_unlock(&drvdata->spinlock);
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }

 static ssize_t addr_stop_store(struct device *dev,
@@ -1150,7 +1150,7 @@ static ssize_t addr_ctxtype_show(struct device *dev,
 	idx = config->addr_idx;
 	/* CONTEXTTYPE, bits[3:2] */
 	val = FIELD_GET(TRCACATRn_CONTEXTTYPE_MASK, config->addr_acc[idx]);
-	len = scnprintf(buf, PAGE_SIZE, "%s\n", val == ETM_CTX_NONE ? "none" :
+	len = sysfs_emit(buf, "%s\n", val == ETM_CTX_NONE ? "none" :
 			(val == ETM_CTX_CTXID ? "ctxid" :
 			(val == ETM_CTX_VMID ? "vmid" : "all")));
 	spin_unlock(&drvdata->spinlock);
@@ -1217,7 +1217,7 @@ static ssize_t addr_context_show(struct device *dev,
 	/* context ID comparator bits[6:4] */
 	val = FIELD_GET(TRCACATRn_CONTEXT_MASK, config->addr_acc[idx]);
 	spin_unlock(&drvdata->spinlock);
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }

 static ssize_t addr_context_store(struct device *dev,
@@ -1260,7 +1260,7 @@ static ssize_t addr_exlevel_s_ns_show(struct device *dev,
 	idx = config->addr_idx;
 	val = FIELD_GET(TRCACATRn_EXLEVEL_MASK, config->addr_acc[idx]);
 	spin_unlock(&drvdata->spinlock);
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }

 static ssize_t addr_exlevel_s_ns_store(struct device *dev,
@@ -1323,17 +1323,16 @@ static ssize_t addr_cmp_view_show(struct device *dev,
 	}
 	spin_unlock(&drvdata->spinlock);
 	if (addr_type) {
-		size = scnprintf(buf, PAGE_SIZE, "addr_cmp[%i] %s %#lx", idx,
+		size = sysfs_emit(buf, "addr_cmp[%i] %s %#lx", idx,
 				 addr_type_names[addr_type], addr_v);
 		if (addr_type == ETM_ADDR_TYPE_RANGE) {
-			size += scnprintf(buf + size, PAGE_SIZE - size,
+			size += sysfs_emit_at(buf, size,
 					  " %#lx %s", addr_v2,
 					  exclude ? "exclude" : "include");
 		}
-		size += scnprintf(buf + size, PAGE_SIZE - size,
-				  " ctrl(%#lx)\n", addr_ctrl);
+		size += sysfs_emit_at(buf, size, " ctrl(%#lx)\n", addr_ctrl);
 	} else {
-		size = scnprintf(buf, PAGE_SIZE, "addr_cmp[%i] unused\n", idx);
+		size = sysfs_emit(buf, "addr_cmp[%i] unused\n", idx);
 	}
 	return size;
 }
@@ -1350,7 +1349,7 @@ static ssize_t vinst_pe_cmp_start_stop_show(struct device *dev,
 	if (!drvdata->nr_pe_cmp)
 		return -EINVAL;
 	val = config->vipcssctlr;
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 static ssize_t vinst_pe_cmp_start_stop_store(struct device *dev,
 					     struct device_attribute *attr,
@@ -1381,7 +1380,7 @@ static ssize_t seq_idx_show(struct device *dev,
 	struct etmv4_config *config = &drvdata->config;

 	val = config->seq_idx;
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }

 static ssize_t seq_idx_store(struct device *dev,
@@ -1417,7 +1416,7 @@ static ssize_t seq_state_show(struct device *dev,
 	struct etmv4_config *config = &drvdata->config;

 	val = config->seq_state;
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }

 static ssize_t seq_state_store(struct device *dev,
@@ -1451,7 +1450,7 @@ static ssize_t seq_event_show(struct device *dev,
 	idx = config->seq_idx;
 	val = config->seq_ctrl[idx];
 	spin_unlock(&drvdata->spinlock);
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }

 static ssize_t seq_event_store(struct device *dev,
@@ -1484,7 +1483,7 @@ static ssize_t seq_reset_event_show(struct device *dev,
 	struct etmv4_config *config = &drvdata->config;

 	val = config->seq_rst;
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }

 static ssize_t seq_reset_event_store(struct device *dev,
@@ -1514,7 +1513,7 @@ static ssize_t cntr_idx_show(struct device *dev,
 	struct etmv4_config *config = &drvdata->config;

 	val = config->cntr_idx;
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }

 static ssize_t cntr_idx_store(struct device *dev,
@@ -1554,7 +1553,7 @@ static ssize_t cntrldvr_show(struct device *dev,
 	idx = config->cntr_idx;
 	val = config->cntrldvr[idx];
 	spin_unlock(&drvdata->spinlock);
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }

 static ssize_t cntrldvr_store(struct device *dev,
@@ -1592,7 +1591,7 @@ static ssize_t cntr_val_show(struct device *dev,
 	idx = config->cntr_idx;
 	val = config->cntr_val[idx];
 	spin_unlock(&drvdata->spinlock);
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }

 static ssize_t cntr_val_store(struct device *dev,
@@ -1630,7 +1629,7 @@ static ssize_t cntr_ctrl_show(struct device *dev,
 	idx = config->cntr_idx;
 	val = config->cntr_ctrl[idx];
 	spin_unlock(&drvdata->spinlock);
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }

 static ssize_t cntr_ctrl_store(struct device *dev,
@@ -1662,7 +1661,7 @@ static ssize_t res_idx_show(struct device *dev,
 	struct etmv4_config *config = &drvdata->config;

 	val = config->res_idx;
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }

 static ssize_t res_idx_store(struct device *dev,
@@ -1706,7 +1705,7 @@ static ssize_t res_ctrl_show(struct device *dev,
 	idx = config->res_idx;
 	val = config->res_ctrl[idx];
 	spin_unlock(&drvdata->spinlock);
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }

 static ssize_t res_ctrl_store(struct device *dev,
@@ -1744,7 +1743,7 @@ static ssize_t sshot_idx_show(struct device *dev,
 	struct etmv4_config *config = &drvdata->config;

 	val = config->ss_idx;
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }

 static ssize_t sshot_idx_store(struct device *dev,
@@ -1778,7 +1777,7 @@ static ssize_t sshot_ctrl_show(struct device *dev,
 	spin_lock(&drvdata->spinlock);
 	val = config->ss_ctrl[config->ss_idx];
 	spin_unlock(&drvdata->spinlock);
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }

 static ssize_t sshot_ctrl_store(struct device *dev,
@@ -1813,7 +1812,7 @@ static ssize_t sshot_status_show(struct device *dev,
 	spin_lock(&drvdata->spinlock);
 	val = config->ss_status[config->ss_idx];
 	spin_unlock(&drvdata->spinlock);
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 static DEVICE_ATTR_RO(sshot_status);

@@ -1828,7 +1827,7 @@ static ssize_t sshot_pe_ctrl_show(struct device *dev,
 	spin_lock(&drvdata->spinlock);
 	val = config->ss_pe_cmp[config->ss_idx];
 	spin_unlock(&drvdata->spinlock);
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }

 static ssize_t sshot_pe_ctrl_store(struct device *dev,
@@ -1862,7 +1861,7 @@ static ssize_t ctxid_idx_show(struct device *dev,
 	struct etmv4_config *config = &drvdata->config;

 	val = config->ctxid_idx;
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }

 static ssize_t ctxid_idx_store(struct device *dev,
@@ -1909,7 +1908,7 @@ static ssize_t ctxid_pid_show(struct device *dev,
 	idx = config->ctxid_idx;
 	val = (unsigned long)config->ctxid_pid[idx];
 	spin_unlock(&drvdata->spinlock);
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }

 static ssize_t ctxid_pid_store(struct device *dev,
@@ -1970,7 +1969,7 @@ static ssize_t ctxid_masks_show(struct device *dev,
 	val1 = config->ctxid_mask0;
 	val2 = config->ctxid_mask1;
 	spin_unlock(&drvdata->spinlock);
-	return scnprintf(buf, PAGE_SIZE, "%#lx %#lx\n", val1, val2);
+	return sysfs_emit(buf, "%#lx %#lx\n", val1, val2);
 }

 static ssize_t ctxid_masks_store(struct device *dev,
@@ -2088,7 +2087,7 @@ static ssize_t vmid_idx_show(struct device *dev,
 	struct etmv4_config *config = &drvdata->config;

 	val = config->vmid_idx;
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }

 static ssize_t vmid_idx_store(struct device *dev,
@@ -2133,7 +2132,7 @@ static ssize_t vmid_val_show(struct device *dev,
 	spin_lock(&drvdata->spinlock);
 	val = (unsigned long)config->vmid_val[config->vmid_idx];
 	spin_unlock(&drvdata->spinlock);
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }

 static ssize_t vmid_val_store(struct device *dev,
@@ -2185,7 +2184,7 @@ static ssize_t vmid_masks_show(struct device *dev,
 	val1 = config->vmid_mask0;
 	val2 = config->vmid_mask1;
 	spin_unlock(&drvdata->spinlock);
-	return scnprintf(buf, PAGE_SIZE, "%#lx %#lx\n", val1, val2);
+	return sysfs_emit(buf, "%#lx %#lx\n", val1, val2);
 }

 static ssize_t vmid_masks_store(struct device *dev,
@@ -2301,8 +2300,7 @@ static ssize_t cpu_show(struct device *dev,
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);

 	val = drvdata->cpu;
-	return scnprintf(buf, PAGE_SIZE, "%d\n", val);
-
+	return sysfs_emit(buf, "%d\n", val);
 }
 static DEVICE_ATTR_RO(cpu);

@@ -2441,7 +2439,7 @@ static ssize_t coresight_etm4x_reg_show(struct device *dev,
 	val = etmv4_cross_read(drvdata, offset);
 	pm_runtime_put_sync(dev->parent);

-	return scnprintf(buf, PAGE_SIZE, "0x%x\n", val);
+	return sysfs_emit(buf, "0x%x\n", val);
 }

 static inline bool
diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
index 463f449cfb79..3a1b07217932 100644
--- a/drivers/hwtracing/coresight/coresight-stm.c
+++ b/drivers/hwtracing/coresight/coresight-stm.c
@@ -466,7 +466,7 @@ static ssize_t hwevent_enable_show(struct device *dev,
 	struct stm_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	unsigned long val = drvdata->stmheer;

-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }

 static ssize_t hwevent_enable_store(struct device *dev,
@@ -495,7 +495,7 @@ static ssize_t hwevent_select_show(struct device *dev,
 	struct stm_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	unsigned long val = drvdata->stmhebsr;

-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }

 static ssize_t hwevent_select_store(struct device *dev,
@@ -530,7 +530,7 @@ static ssize_t port_select_show(struct device *dev,
 		spin_unlock(&drvdata->spinlock);
 	}

-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }

 static ssize_t port_select_store(struct device *dev,
@@ -577,7 +577,7 @@ static ssize_t port_enable_show(struct device *dev,
 		spin_unlock(&drvdata->spinlock);
 	}

-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }

 static ssize_t port_enable_store(struct device *dev,
diff --git a/drivers/hwtracing/coresight/coresight-syscfg-configfs.c b/drivers/hwtracing/coresight/coresight-syscfg-configfs.c
index 433ede94dd63..20effbd5fb80 100644
--- a/drivers/hwtracing/coresight/coresight-syscfg-configfs.c
+++ b/drivers/hwtracing/coresight/coresight-syscfg-configfs.c
@@ -29,7 +29,7 @@ static ssize_t cscfg_cfg_description_show(struct config_item *item, char *page)
 	struct cscfg_fs_config *fs_config = container_of(to_config_group(item),
 							 struct cscfg_fs_config, group);

-	return scnprintf(page, PAGE_SIZE, "%s", fs_config->config_desc->description);
+	return sysfs_emit(page, "%s", fs_config->config_desc->description);
 }
 CONFIGFS_ATTR_RO(cscfg_cfg_, description);

@@ -42,8 +42,7 @@ static ssize_t cscfg_cfg_feature_refs_show(struct config_item *item, char *page)
 	int i;

 	for (i = 0; i < config_desc->nr_feat_refs; i++)
-		ch_used += scnprintf(page + ch_used, PAGE_SIZE - ch_used,
-				     "%s\n", config_desc->feat_ref_names[i]);
+		ch_used += sysfs_emit_at(page, ch_used, "%s\n", config_desc->feat_ref_names[i]);
 	return ch_used;
 }
 CONFIGFS_ATTR_RO(cscfg_cfg_, feature_refs);
@@ -75,14 +74,14 @@ static ssize_t cscfg_cfg_values_show(struct config_item *item, char *page)
 	for (i = 0; i < config_desc->nr_feat_refs; i++) {
 		feat_desc = cscfg_get_named_feat_desc(config_desc->feat_ref_names[i]);
 		for (j = 0; j < feat_desc->nr_params; j++) {
-			used += scnprintf(page + used, PAGE_SIZE - used,
+			used += sysfs_emit_at(page, used,
 					  "%s.%s = 0x%llx ",
 					  feat_desc->name,
 					  feat_desc->params_desc[j].name,
 					  config_desc->presets[val_idx++]);
 		}
 	}
-	used += scnprintf(page + used, PAGE_SIZE - used, "\n");
+	used += sysfs_emit_at(page, used, "\n");

 	return used;
 }
@@ -93,7 +92,7 @@ static ssize_t cscfg_cfg_enable_show(struct config_item *item, char *page)
 	struct cscfg_fs_config *fs_config = container_of(to_config_group(item),
 							 struct cscfg_fs_config, group);

-	return scnprintf(page, PAGE_SIZE, "%d\n", fs_config->active);
+	return sysfs_emit(page, "%d\n", fs_config->active);
 }

 static ssize_t cscfg_cfg_enable_store(struct config_item *item,
@@ -121,7 +120,7 @@ static ssize_t cscfg_cfg_preset_show(struct config_item *item, char *page)
 	struct cscfg_fs_config *fs_config = container_of(to_config_group(item),
 							 struct cscfg_fs_config, group);

-	return scnprintf(page, PAGE_SIZE, "%d\n", fs_config->preset);
+	return sysfs_emit(page, "%d\n", fs_config->preset);
 }

 static ssize_t cscfg_cfg_preset_store(struct config_item *item,
@@ -233,7 +232,7 @@ static ssize_t cscfg_feat_description_show(struct config_item *item, char *page)
 	struct cscfg_fs_feature *fs_feat = container_of(to_config_group(item),
 							struct cscfg_fs_feature, group);

-	return scnprintf(page, PAGE_SIZE, "%s", fs_feat->feat_desc->description);
+	return sysfs_emit(page, "%s", fs_feat->feat_desc->description);
 }
 CONFIGFS_ATTR_RO(cscfg_feat_, description);

@@ -245,12 +244,12 @@ static ssize_t cscfg_feat_matches_show(struct config_item *item, char *page)
 	int used = 0;

 	if (match_flags & CS_CFG_MATCH_CLASS_SRC_ALL)
-		used = scnprintf(page, PAGE_SIZE, "SRC_ALL ");
+		used = sysfs_emit(page, "SRC_ALL ");

 	if (match_flags & CS_CFG_MATCH_CLASS_SRC_ETM4)
-		used += scnprintf(page + used, PAGE_SIZE - used, "SRC_ETMV4 ");
+		used += sysfs_emit_at(page, used, "SRC_ETMV4 ");

-	used += scnprintf(page + used, PAGE_SIZE - used, "\n");
+	used += sysfs_emit_at(page, used, "\n");
 	return used;
 }
 CONFIGFS_ATTR_RO(cscfg_feat_, matches);
@@ -260,7 +259,7 @@ static ssize_t cscfg_feat_nr_params_show(struct config_item *item, char *page)
 	struct cscfg_fs_feature *fs_feat = container_of(to_config_group(item),
 							struct cscfg_fs_feature, group);

-	return scnprintf(page, PAGE_SIZE, "%d\n", fs_feat->feat_desc->nr_params);
+	return sysfs_emit(page, "%d\n", fs_feat->feat_desc->nr_params);
 }
 CONFIGFS_ATTR_RO(cscfg_feat_, nr_params);

@@ -283,7 +282,7 @@ static ssize_t cscfg_param_value_show(struct config_item *item, char *page)
 							 struct cscfg_fs_param, group);
 	u64 value = param_item->feat_desc->params_desc[param_item->param_idx].value;

-	return scnprintf(page, PAGE_SIZE, "0x%llx\n", value);
+	return sysfs_emit(page, "0x%llx\n", value);
 }

 static ssize_t cscfg_param_value_store(struct config_item *item,
-- 
2.25.1
