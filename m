Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B4F6F8A0D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 22:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbjEEUO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 16:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbjEEUO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 16:14:56 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BFA632125;
        Fri,  5 May 2023 13:14:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF4E11FB;
        Fri,  5 May 2023 13:15:38 -0700 (PDT)
Received: from e120937-lin.. (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 10E843F64C;
        Fri,  5 May 2023 13:14:52 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     cristian.marussi@arm.com
Cc:     Oleksii_Moisieiev@epam.com, linus.walleij@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, michal.simek@amd.com,
        peng.fan@oss.nxp.com, sudeep.holla@arm.com
Subject: [PATCH] firmware: arm_scmi: Add optional flags to extended names helper
Date:   Fri,  5 May 2023 21:14:40 +0100
Message-Id: <20230505201440.3196734-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZFVeY3jVNfAkW1G9@e120937-lin>
References: <ZFVeY3jVNfAkW1G9@e120937-lin>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some recently added SCMI protocols needs an additional flags parameter to
be able to properly configure the command used to query the extended name
of a resource.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/clock.c     | 2 +-
 drivers/firmware/arm_scmi/driver.c    | 8 ++++++--
 drivers/firmware/arm_scmi/perf.c      | 3 ++-
 drivers/firmware/arm_scmi/power.c     | 2 +-
 drivers/firmware/arm_scmi/powercap.c  | 2 +-
 drivers/firmware/arm_scmi/protocols.h | 3 ++-
 drivers/firmware/arm_scmi/reset.c     | 3 ++-
 drivers/firmware/arm_scmi/sensors.c   | 2 +-
 drivers/firmware/arm_scmi/voltage.c   | 2 +-
 9 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
index 96060bf90a24..e6e087686e8c 100644
--- a/drivers/firmware/arm_scmi/clock.c
+++ b/drivers/firmware/arm_scmi/clock.c
@@ -169,7 +169,7 @@ static int scmi_clock_attributes_get(const struct scmi_protocol_handle *ph,
 	if (!ret && PROTOCOL_REV_MAJOR(version) >= 0x2) {
 		if (SUPPORTS_EXTENDED_NAMES(attributes))
 			ph->hops->extended_name_get(ph, CLOCK_NAME_GET, clk_id,
-						    clk->name,
+						    NULL, clk->name,
 						    SCMI_MAX_STR_SIZE);
 
 		if (SUPPORTS_RATE_CHANGED_NOTIF(attributes))
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index e7d97b59963b..5be931a07c84 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -1438,6 +1438,7 @@ struct scmi_msg_resp_domain_name_get {
  * @ph: A protocol handle reference.
  * @cmd_id: The specific command ID to use.
  * @res_id: The specific resource ID to use.
+ * @flags: A pointer to specific flags to use, if any.
  * @name: A pointer to the preallocated area where the retrieved name will be
  *	  stored as a NULL terminated string.
  * @len: The len in bytes of the @name char array.
@@ -1445,8 +1446,8 @@ struct scmi_msg_resp_domain_name_get {
  * Return: 0 on Succcess
  */
 static int scmi_common_extended_name_get(const struct scmi_protocol_handle *ph,
-					 u8 cmd_id, u32 res_id, char *name,
-					 size_t len)
+					 u8 cmd_id, u32 res_id, u32 *flags,
+					 char *name, size_t len)
 {
 	int ret;
 	struct scmi_xfer *t;
@@ -1458,6 +1459,9 @@ static int scmi_common_extended_name_get(const struct scmi_protocol_handle *ph,
 		goto out;
 
 	put_unaligned_le32(res_id, t->tx.buf);
+	if (flags)
+		put_unaligned_le32(*flags,
+				   (u8 *)t->tx.buf + sizeof(res_id));
 	resp = t->rx.buf;
 
 	ret = ph->xops->do_xfer(ph, t);
diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index ecf5c4de851b..d85d4a0e3605 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -237,7 +237,8 @@ scmi_perf_domain_attributes_get(const struct scmi_protocol_handle *ph,
 	if (!ret && PROTOCOL_REV_MAJOR(version) >= 0x3 &&
 	    SUPPORTS_EXTENDED_NAMES(flags))
 		ph->hops->extended_name_get(ph, PERF_DOMAIN_NAME_GET, domain,
-					    dom_info->name, SCMI_MAX_STR_SIZE);
+					    NULL, dom_info->name,
+					    SCMI_MAX_STR_SIZE);
 
 	return ret;
 }
diff --git a/drivers/firmware/arm_scmi/power.c b/drivers/firmware/arm_scmi/power.c
index 356e83631664..077767d6e902 100644
--- a/drivers/firmware/arm_scmi/power.c
+++ b/drivers/firmware/arm_scmi/power.c
@@ -133,7 +133,7 @@ scmi_power_domain_attributes_get(const struct scmi_protocol_handle *ph,
 	if (!ret && PROTOCOL_REV_MAJOR(version) >= 0x3 &&
 	    SUPPORTS_EXTENDED_NAMES(flags)) {
 		ph->hops->extended_name_get(ph, POWER_DOMAIN_NAME_GET,
-					    domain, dom_info->name,
+					    domain, NULL, dom_info->name,
 					    SCMI_MAX_STR_SIZE);
 	}
 
diff --git a/drivers/firmware/arm_scmi/powercap.c b/drivers/firmware/arm_scmi/powercap.c
index 244929cb4f3e..86c9a0b5a765 100644
--- a/drivers/firmware/arm_scmi/powercap.c
+++ b/drivers/firmware/arm_scmi/powercap.c
@@ -270,7 +270,7 @@ scmi_powercap_domain_attributes_get(const struct scmi_protocol_handle *ph,
 	 */
 	if (!ret && SUPPORTS_EXTENDED_NAMES(flags))
 		ph->hops->extended_name_get(ph, POWERCAP_DOMAIN_NAME_GET,
-					    domain, dom_info->name,
+					    domain, NULL, dom_info->name,
 					    SCMI_MAX_STR_SIZE);
 
 	return ret;
diff --git a/drivers/firmware/arm_scmi/protocols.h b/drivers/firmware/arm_scmi/protocols.h
index 78e1a01eb656..b3c6314bb4b8 100644
--- a/drivers/firmware/arm_scmi/protocols.h
+++ b/drivers/firmware/arm_scmi/protocols.h
@@ -256,7 +256,8 @@ struct scmi_fc_info {
  */
 struct scmi_proto_helpers_ops {
 	int (*extended_name_get)(const struct scmi_protocol_handle *ph,
-				 u8 cmd_id, u32 res_id, char *name, size_t len);
+				 u8 cmd_id, u32 res_id, u32 *flags, char *name,
+				 size_t len);
 	void *(*iter_response_init)(const struct scmi_protocol_handle *ph,
 				    struct scmi_iterator_ops *ops,
 				    unsigned int max_resources, u8 msg_id,
diff --git a/drivers/firmware/arm_scmi/reset.c b/drivers/firmware/arm_scmi/reset.c
index e9afa8cab730..7217fd7c6afa 100644
--- a/drivers/firmware/arm_scmi/reset.c
+++ b/drivers/firmware/arm_scmi/reset.c
@@ -128,7 +128,8 @@ scmi_reset_domain_attributes_get(const struct scmi_protocol_handle *ph,
 	if (!ret && PROTOCOL_REV_MAJOR(version) >= 0x3 &&
 	    SUPPORTS_EXTENDED_NAMES(attributes))
 		ph->hops->extended_name_get(ph, RESET_DOMAIN_NAME_GET, domain,
-					    dom_info->name, SCMI_MAX_STR_SIZE);
+					    NULL, dom_info->name,
+					    SCMI_MAX_STR_SIZE);
 
 	return ret;
 }
diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
index 0b5853fa9d87..9952a7bc6682 100644
--- a/drivers/firmware/arm_scmi/sensors.c
+++ b/drivers/firmware/arm_scmi/sensors.c
@@ -644,7 +644,7 @@ iter_sens_descr_process_response(const struct scmi_protocol_handle *ph,
 	if (PROTOCOL_REV_MAJOR(si->version) >= 0x3 &&
 	    SUPPORTS_EXTENDED_NAMES(attrl))
 		ph->hops->extended_name_get(ph, SENSOR_NAME_GET, s->id,
-					    s->name, SCMI_MAX_STR_SIZE);
+					    NULL, s->name, SCMI_MAX_STR_SIZE);
 
 	if (s->extended_scalar_attrs) {
 		s->sensor_power = le32_to_cpu(sdesc->power);
diff --git a/drivers/firmware/arm_scmi/voltage.c b/drivers/firmware/arm_scmi/voltage.c
index eaa8d944926a..36e2df77738c 100644
--- a/drivers/firmware/arm_scmi/voltage.c
+++ b/drivers/firmware/arm_scmi/voltage.c
@@ -242,7 +242,7 @@ static int scmi_voltage_descriptors_get(const struct scmi_protocol_handle *ph,
 			if (SUPPORTS_EXTENDED_NAMES(attributes))
 				ph->hops->extended_name_get(ph,
 							VOLTAGE_DOMAIN_NAME_GET,
-							v->id, v->name,
+							v->id, NULL, v->name,
 							SCMI_MAX_STR_SIZE);
 			if (SUPPORTS_ASYNC_LEVEL_SET(attributes))
 				v->async_level_set = true;
-- 
2.34.1

