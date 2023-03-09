Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE016B2653
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 15:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbjCIOJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 09:09:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbjCIOJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 09:09:04 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CA2C54742C;
        Thu,  9 Mar 2023 06:07:46 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EBBCA1516;
        Thu,  9 Mar 2023 06:08:29 -0800 (PST)
Received: from e120937-lin.. (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 91EDD3F5A1;
        Thu,  9 Mar 2023 06:07:44 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        vincent.guittot@linaro.org, tarek.el-sherbiny@arm.com,
        nicola.mazzucato@arm.com, souvik.chakravarty@arm.com,
        wleavitt@marvell.com, wbartczak@marvell.com,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v2 1/3] firmware: arm_scmi: Refactor powercap get/set helpers
Date:   Thu,  9 Mar 2023 14:07:22 +0000
Message-Id: <20230309140724.2152712-2-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230309140724.2152712-1-cristian.marussi@arm.com>
References: <20230309140724.2152712-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor SCMI powercap internal get/set helpers.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/powercap.c | 65 +++++++++++++++++++---------
 1 file changed, 45 insertions(+), 20 deletions(-)

diff --git a/drivers/firmware/arm_scmi/powercap.c b/drivers/firmware/arm_scmi/powercap.c
index 83b90bde755c..2e490492f187 100644
--- a/drivers/firmware/arm_scmi/powercap.c
+++ b/drivers/firmware/arm_scmi/powercap.c
@@ -313,24 +313,33 @@ static int scmi_powercap_xfer_cap_get(const struct scmi_protocol_handle *ph,
 	return ret;
 }
 
-static int scmi_powercap_cap_get(const struct scmi_protocol_handle *ph,
-				 u32 domain_id, u32 *power_cap)
+static int __scmi_powercap_cap_get(const struct scmi_protocol_handle *ph,
+				   const struct scmi_powercap_info *dom,
+				   u32 *power_cap)
 {
-	struct scmi_powercap_info *dom;
-	struct powercap_info *pi = ph->get_priv(ph);
-
-	if (!power_cap || domain_id >= pi->num_domains)
-		return -EINVAL;
-
-	dom = pi->powercaps + domain_id;
 	if (dom->fc_info && dom->fc_info[POWERCAP_FC_CAP].get_addr) {
 		*power_cap = ioread32(dom->fc_info[POWERCAP_FC_CAP].get_addr);
 		trace_scmi_fc_call(SCMI_PROTOCOL_POWERCAP, POWERCAP_CAP_GET,
-				   domain_id, *power_cap, 0);
+				   dom->id, *power_cap, 0);
 		return 0;
 	}
 
-	return scmi_powercap_xfer_cap_get(ph, domain_id, power_cap);
+	return scmi_powercap_xfer_cap_get(ph, dom->id, power_cap);
+}
+
+static int scmi_powercap_cap_get(const struct scmi_protocol_handle *ph,
+				 u32 domain_id, u32 *power_cap)
+{
+	const struct scmi_powercap_info *dom;
+
+	if (!power_cap)
+		return -EINVAL;
+
+	dom = scmi_powercap_dom_info_get(ph, domain_id);
+	if (!dom)
+		return -EINVAL;
+
+	return __scmi_powercap_cap_get(ph, dom, power_cap);
 }
 
 static int scmi_powercap_xfer_cap_set(const struct scmi_protocol_handle *ph,
@@ -375,17 +384,20 @@ static int scmi_powercap_xfer_cap_set(const struct scmi_protocol_handle *ph,
 	return ret;
 }
 
-static int scmi_powercap_cap_set(const struct scmi_protocol_handle *ph,
-				 u32 domain_id, u32 power_cap,
-				 bool ignore_dresp)
+static int __scmi_powercap_cap_set(const struct scmi_protocol_handle *ph,
+				   struct powercap_info *pi, u32 domain_id,
+				   u32 power_cap, bool ignore_dresp)
 {
+	int ret = -EINVAL;
 	const struct scmi_powercap_info *pc;
 
 	pc = scmi_powercap_dom_info_get(ph, domain_id);
-	if (!pc || !pc->powercap_cap_config || !power_cap ||
-	    power_cap < pc->min_power_cap ||
-	    power_cap > pc->max_power_cap)
-		return -EINVAL;
+	if (!pc || !pc->powercap_cap_config)
+		return ret;
+
+	if (power_cap &&
+	    (power_cap < pc->min_power_cap || power_cap > pc->max_power_cap))
+		return ret;
 
 	if (pc->fc_info && pc->fc_info[POWERCAP_FC_CAP].set_addr) {
 		struct scmi_fc_info *fci = &pc->fc_info[POWERCAP_FC_CAP];
@@ -394,10 +406,23 @@ static int scmi_powercap_cap_set(const struct scmi_protocol_handle *ph,
 		ph->hops->fastchannel_db_ring(fci->set_db);
 		trace_scmi_fc_call(SCMI_PROTOCOL_POWERCAP, POWERCAP_CAP_SET,
 				   domain_id, power_cap, 0);
-		return 0;
+		ret = 0;
+	} else {
+		ret = scmi_powercap_xfer_cap_set(ph, pc, power_cap,
+						 ignore_dresp);
 	}
 
-	return scmi_powercap_xfer_cap_set(ph, pc, power_cap, ignore_dresp);
+	return ret;
+}
+
+static int scmi_powercap_cap_set(const struct scmi_protocol_handle *ph,
+				 u32 domain_id, u32 power_cap,
+				 bool ignore_dresp)
+{
+	struct powercap_info *pi = ph->get_priv(ph);
+
+	return __scmi_powercap_cap_set(ph, pi, domain_id,
+				       power_cap, ignore_dresp);
 }
 
 static int scmi_powercap_xfer_pai_get(const struct scmi_protocol_handle *ph,
-- 
2.34.1

