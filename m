Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECAB26B2654
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 15:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbjCIOJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 09:09:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbjCIOJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 09:09:07 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 06B3DF28BD;
        Thu,  9 Mar 2023 06:07:48 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3022EC14;
        Thu,  9 Mar 2023 06:08:32 -0800 (PST)
Received: from e120937-lin.. (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AEF8A3F5A1;
        Thu,  9 Mar 2023 06:07:46 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        vincent.guittot@linaro.org, tarek.el-sherbiny@arm.com,
        nicola.mazzucato@arm.com, souvik.chakravarty@arm.com,
        wleavitt@marvell.com, wbartczak@marvell.com,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v2 2/3] firmware: arm_scmi: Add Powercap protocol enable support
Date:   Thu,  9 Mar 2023 14:07:23 +0000
Message-Id: <20230309140724.2152712-3-cristian.marussi@arm.com>
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

SCMI Powercap protocol v3.2 supports disabling the powercap on a zone
by zone basis by providing a zero valued powercap.

Expose new operations to enable/disable powercapping on a per-zone base.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v1 --> v2
- simplified enable requested checks
---
 drivers/firmware/arm_scmi/powercap.c | 110 +++++++++++++++++++++++++--
 include/linux/scmi_protocol.h        |  18 +++++
 2 files changed, 122 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/arm_scmi/powercap.c b/drivers/firmware/arm_scmi/powercap.c
index 2e490492f187..244929cb4f3e 100644
--- a/drivers/firmware/arm_scmi/powercap.c
+++ b/drivers/firmware/arm_scmi/powercap.c
@@ -108,6 +108,8 @@ struct scmi_powercap_meas_changed_notify_payld {
 };
 
 struct scmi_powercap_state {
+	bool enabled;
+	u32 last_pcap;
 	bool meas_notif_enabled;
 	u64 thresholds;
 #define THRESH_LOW(p, id)				\
@@ -412,6 +414,10 @@ static int __scmi_powercap_cap_set(const struct scmi_protocol_handle *ph,
 						 ignore_dresp);
 	}
 
+	/* Save the last explicitly set non-zero powercap value */
+	if (PROTOCOL_REV_MAJOR(pi->version) >= 0x2 && !ret && power_cap)
+		pi->states[domain_id].last_pcap = power_cap;
+
 	return ret;
 }
 
@@ -421,6 +427,20 @@ static int scmi_powercap_cap_set(const struct scmi_protocol_handle *ph,
 {
 	struct powercap_info *pi = ph->get_priv(ph);
 
+	/*
+	 * Disallow zero as a possible explicitly requested powercap:
+	 * there are enable/disable operations for this.
+	 */
+	if (!power_cap)
+		return -EINVAL;
+
+	/* Just log the last set request if acting on a disabled domain */
+	if (PROTOCOL_REV_MAJOR(pi->version) >= 0x2 &&
+	    !pi->states[domain_id].enabled) {
+		pi->states[domain_id].last_pcap = power_cap;
+		return 0;
+	}
+
 	return __scmi_powercap_cap_set(ph, pi, domain_id,
 				       power_cap, ignore_dresp);
 }
@@ -589,11 +609,78 @@ scmi_powercap_measurements_threshold_set(const struct scmi_protocol_handle *ph,
 	return ret;
 }
 
+static int scmi_powercap_cap_enable_set(const struct scmi_protocol_handle *ph,
+					u32 domain_id, bool enable)
+{
+	int ret;
+	u32 power_cap;
+	struct powercap_info *pi = ph->get_priv(ph);
+
+	if (PROTOCOL_REV_MAJOR(pi->version) < 0x2)
+		return -EINVAL;
+
+	if (enable == pi->states[domain_id].enabled)
+		return 0;
+
+	if (enable) {
+		/* Cannot enable with a zero powercap. */
+		if (!pi->states[domain_id].last_pcap)
+			return -EINVAL;
+
+		ret = __scmi_powercap_cap_set(ph, pi, domain_id,
+					      pi->states[domain_id].last_pcap,
+					      true);
+	} else {
+		ret = __scmi_powercap_cap_set(ph, pi, domain_id, 0, true);
+	}
+
+	if (ret)
+		return ret;
+
+	/*
+	 * Update our internal state to reflect final platform state: the SCMI
+	 * server could have ignored a disable request and kept enforcing some
+	 * powercap limit requested by other agents.
+	 */
+	ret = scmi_powercap_cap_get(ph, domain_id, &power_cap);
+	if (!ret)
+		pi->states[domain_id].enabled = !!power_cap;
+
+	return ret;
+}
+
+static int scmi_powercap_cap_enable_get(const struct scmi_protocol_handle *ph,
+					u32 domain_id, bool *enable)
+{
+	int ret;
+	u32 power_cap;
+	struct powercap_info *pi = ph->get_priv(ph);
+
+	*enable = true;
+	if (PROTOCOL_REV_MAJOR(pi->version) < 0x2)
+		return 0;
+
+	/*
+	 * Report always real platform state; platform could have ignored
+	 * a previous disable request. Default true on any error.
+	 */
+	ret = scmi_powercap_cap_get(ph, domain_id, &power_cap);
+	if (!ret)
+		*enable = !!power_cap;
+
+	/* Update internal state with current real platform state */
+	pi->states[domain_id].enabled = *enable;
+
+	return 0;
+}
+
 static const struct scmi_powercap_proto_ops powercap_proto_ops = {
 	.num_domains_get = scmi_powercap_num_domains_get,
 	.info_get = scmi_powercap_dom_info_get,
 	.cap_get = scmi_powercap_cap_get,
 	.cap_set = scmi_powercap_cap_set,
+	.cap_enable_set = scmi_powercap_cap_enable_set,
+	.cap_enable_get = scmi_powercap_cap_enable_get,
 	.pai_get = scmi_powercap_pai_get,
 	.pai_set = scmi_powercap_pai_set,
 	.measurements_get = scmi_powercap_measurements_get,
@@ -854,6 +941,11 @@ scmi_powercap_protocol_init(const struct scmi_protocol_handle *ph)
 	if (!pinfo->powercaps)
 		return -ENOMEM;
 
+	pinfo->states = devm_kcalloc(ph->dev, pinfo->num_domains,
+				     sizeof(*pinfo->states), GFP_KERNEL);
+	if (!pinfo->states)
+		return -ENOMEM;
+
 	/*
 	 * Note that any failure in retrieving any domain attribute leads to
 	 * the whole Powercap protocol initialization failure: this way the
@@ -868,15 +960,21 @@ scmi_powercap_protocol_init(const struct scmi_protocol_handle *ph)
 		if (pinfo->powercaps[domain].fastchannels)
 			scmi_powercap_domain_init_fc(ph, domain,
 						     &pinfo->powercaps[domain].fc_info);
-	}
 
-	pinfo->states = devm_kcalloc(ph->dev, pinfo->num_domains,
-				     sizeof(*pinfo->states), GFP_KERNEL);
-	if (!pinfo->states)
-		return -ENOMEM;
+		/* Grab initial state when disable is supported. */
+		if (PROTOCOL_REV_MAJOR(version) >= 0x2) {
+			ret = __scmi_powercap_cap_get(ph,
+						      &pinfo->powercaps[domain],
+						      &pinfo->states[domain].last_pcap);
+			if (ret)
+				return ret;
 
-	pinfo->version = version;
+			pinfo->states[domain].enabled =
+				!!pinfo->states[domain].last_pcap;
+		}
+	}
 
+	pinfo->version = version;
 	return ph->set_priv(ph, pinfo);
 }
 
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 0ce5746a4470..e6fe4f73ffe6 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -629,11 +629,25 @@ struct scmi_powercap_info {
  * @num_domains_get: get the count of powercap domains provided by SCMI.
  * @info_get: get the information for the specified domain.
  * @cap_get: get the current CAP value for the specified domain.
+ *	     On SCMI platforms supporting powercap zone disabling, this could
+ *	     report a zero value for a zone where powercapping is disabled.
  * @cap_set: set the CAP value for the specified domain to the provided value;
  *	     if the domain supports setting the CAP with an asynchronous command
  *	     this request will finally trigger an asynchronous transfer, but, if
  *	     @ignore_dresp here is set to true, this call will anyway return
  *	     immediately without waiting for the related delayed response.
+ *	     Note that the powercap requested value must NOT be zero, even if
+ *	     the platform supports disabling a powercap by setting its cap to
+ *	     zero (since SCMI v3.2): there are dedicated operations that should
+ *	     be used for that. (@cap_enable_set/get)
+ * @cap_enable_set: enable or disable the powercapping on the specified domain,
+ *		    if supported by the SCMI platform implementation.
+ *		    Note that, by the SCMI specification, the platform can
+ *		    silently ignore our disable request and decide to enforce
+ *		    anyway some other powercap value requested by another agent
+ *		    on the system: for this reason @cap_get and @cap_enable_get
+ *		    will always report the final platform view of the powercaps.
+ * @cap_enable_get: get the current CAP enable status for the specified domain.
  * @pai_get: get the current PAI value for the specified domain.
  * @pai_set: set the PAI value for the specified domain to the provided value.
  * @measurements_get: retrieve the current average power measurements for the
@@ -662,6 +676,10 @@ struct scmi_powercap_proto_ops {
 		       u32 *power_cap);
 	int (*cap_set)(const struct scmi_protocol_handle *ph, u32 domain_id,
 		       u32 power_cap, bool ignore_dresp);
+	int (*cap_enable_set)(const struct scmi_protocol_handle *ph,
+			      u32 domain_id, bool enable);
+	int (*cap_enable_get)(const struct scmi_protocol_handle *ph,
+			      u32 domain_id, bool *enable);
 	int (*pai_get)(const struct scmi_protocol_handle *ph, u32 domain_id,
 		       u32 *pai);
 	int (*pai_set)(const struct scmi_protocol_handle *ph, u32 domain_id,
-- 
2.34.1

