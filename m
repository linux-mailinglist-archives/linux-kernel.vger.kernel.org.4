Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457866F8A07
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 22:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbjEEUKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 16:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjEEUKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 16:10:44 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3A8CB3A9F;
        Fri,  5 May 2023 13:10:41 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 23AD81FB;
        Fri,  5 May 2023 13:11:25 -0700 (PDT)
Received: from e120937-lin.. (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 437B53F64C;
        Fri,  5 May 2023 13:10:39 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     cristian.marussi@arm.com
Cc:     Oleksii_Moisieiev@epam.com, linus.walleij@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, michal.simek@amd.com,
        peng.fan@oss.nxp.com, sudeep.holla@arm.com
Subject: [PATCH] [REVIEW][PINCTRL]: Misc Fixes and refactor
Date:   Fri,  5 May 2023 21:10:12 +0100
Message-Id: <20230505201012.3171817-1-cristian.marussi@arm.com>
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

A few TENTATIVE misc fixes and refactor as a reference

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/pinctrl.c | 271 +++++++++-------------------
 1 file changed, 90 insertions(+), 181 deletions(-)

diff --git a/drivers/firmware/arm_scmi/pinctrl.c b/drivers/firmware/arm_scmi/pinctrl.c
index 1c643d21390f..10c4cd1ae844 100644
--- a/drivers/firmware/arm_scmi/pinctrl.c
+++ b/drivers/firmware/arm_scmi/pinctrl.c
@@ -11,8 +11,6 @@
 
 #include "protocols.h"
 
-#define SET_TYPE(x) FIELD_PREP(GENMASK(1, 0), (x))
-
 #define REG_TYPE_BITS GENMASK(9, 8)
 #define REG_CONFIG GENMASK(7, 0)
 
@@ -54,16 +52,6 @@ struct scmi_msg_pinctrl_protocol_attributes {
 	__le32 attributes_high;
 };
 
-struct scmi_msg_ext_name {
-	__le32 identifier;
-	__le32 flags;
-};
-
-struct scmi_resp_ext_name {
-	__le32 flags;
-	u8 name[SCMI_MAX_STR_SIZE];
-};
-
 struct scmi_msg_pinctrl_attributes {
 	__le32 identifier;
 	__le32 flags;
@@ -98,21 +86,21 @@ struct scmi_msg_request {
 
 struct scmi_group_info {
 	bool present;
-	char *name;
+	char name[SCMI_MAX_STR_SIZE];
 	unsigned int *group_pins;
 	unsigned int nr_pins;
 };
 
 struct scmi_function_info {
 	bool present;
-	char *name;
+	char name[SCMI_MAX_STR_SIZE];
 	unsigned int *groups;
 	unsigned int nr_groups;
 };
 
 struct scmi_pin_info {
 	bool present;
-	char *name;
+	char name[SCMI_MAX_STR_SIZE];
 };
 
 struct scmi_pinctrl_info {
@@ -145,9 +133,10 @@ static int scmi_pinctrl_attributes_get(const struct scmi_protocol_handle *ph,
 	ret = ph->xops->do_xfer(ph, t);
 	if (!ret) {
 		pi->nr_functions =
-			le16_to_cpu(GET_FUNCTIONS_NR(attr->attributes_high));
-		pi->nr_groups = le16_to_cpu(GET_GROUPS_NR(attr->attributes_low));
-		pi->nr_pins = le16_to_cpu(GET_PINS_NR(attr->attributes_low));
+			GET_FUNCTIONS_NR(le32_to_cpu(attr->attributes_high));
+		pi->nr_groups =
+			GET_GROUPS_NR(le32_to_cpu(attr->attributes_low));
+		pi->nr_pins = GET_PINS_NR(le32_to_cpu(attr->attributes_low));
 	}
 
 	ph->xops->xfer_put(ph, t);
@@ -159,9 +148,6 @@ static int scmi_pinctrl_get_count(const struct scmi_protocol_handle *ph,
 {
 	struct scmi_pinctrl_info *pi;
 
-	if (!ph)
-		return -ENODEV;
-
 	pi = ph->get_priv(ph);
 	if (!pi)
 		return -ENODEV;
@@ -184,9 +170,6 @@ static int scmi_pinctrl_validate_id(const struct scmi_protocol_handle *ph,
 {
 	int value;
 
-	if (!ph)
-		return -ENODEV;
-
 	value = scmi_pinctrl_get_count(ph, type);
 	if (value < 0)
 		return value;
@@ -197,60 +180,18 @@ static int scmi_pinctrl_validate_id(const struct scmi_protocol_handle *ph,
 	return 0;
 }
 
-static int scmi_pinctrl_get_ext_name(const struct scmi_protocol_handle *ph,
-				     u32 identifier,
-				     enum scmi_pinctrl_selector_type type,
-				     char **name)
-{
-	struct scmi_xfer *t;
-	int ret = 0;
-	struct scmi_msg_ext_name *tx;
-	struct scmi_resp_ext_name *rx;
-
-	if (!ph || !name)
-		return -EINVAL;
-
-	ret = scmi_pinctrl_validate_id(ph, identifier, type);
-	if (ret)
-		return ret;
-
-	ret = ph->xops->xfer_get_init(ph, PINCTRL_NAME_GET, sizeof(*tx),
-				      sizeof(*rx), &t);
-
-	tx = t->tx.buf;
-	rx = t->rx.buf;
-	tx->identifier = identifier;
-	tx->flags = SET_TYPE(cpu_to_le32(type));
-
-	ret = ph->xops->do_xfer(ph, t);
-	if (ret)
-		goto out;
-
-	if (rx->flags) {
-		ret = -EINVAL;
-		goto out;
-	}
-
-	*name = kasprintf(GFP_KERNEL, "%s", rx->name);
-	if (!*name)
-		ret = -ENOMEM;
- out:
-	ph->xops->xfer_put(ph, t);
-
-	return ret;
-}
-
 static int scmi_pinctrl_attributes(const struct scmi_protocol_handle *ph,
 				   enum scmi_pinctrl_selector_type type,
-				   u32 selector, char **name,
+				   u32 selector, char *name,
 				   unsigned int *n_elems)
 {
-	int ret = 0;
+	int ret;
+	u32 attrs;
 	struct scmi_xfer *t;
 	struct scmi_msg_pinctrl_attributes *tx;
 	struct scmi_resp_pinctrl_attributes *rx;
 
-	if (!ph || !name)
+	if (!name)
 		return -EINVAL;
 
 	ret = scmi_pinctrl_validate_id(ph, selector, type);
@@ -264,24 +205,27 @@ static int scmi_pinctrl_attributes(const struct scmi_protocol_handle *ph,
 
 	tx = t->tx.buf;
 	rx = t->rx.buf;
-	tx->identifier = selector;
-	tx->flags = SET_TYPE(cpu_to_le32(type));
+	tx->identifier = cpu_to_le32(selector);
+	tx->flags = cpu_to_le32(type);
 
 	ret = ph->xops->do_xfer(ph, t);
-	if (ret)
-		goto out;
-
-	*n_elems = NUM_ELEMS(rx->attributes);
-
-	if (!EXT_NAME_FLAG(rx->attributes)) {
-		*name = kasprintf(GFP_KERNEL, "%s", rx->name);
-		if (!*name)
-			ret = -ENOMEM;
-	} else {
-		ret = scmi_pinctrl_get_ext_name(ph, selector, type, name);
+	if (!ret) {
+		attrs = le32_to_cpu(rx->attributes);
+		if (n_elems)
+			*n_elems = NUM_ELEMS(attrs);
+		strscpy(name, rx->name, SCMI_SHORT_NAME_MAX_SIZE);
 	}
- out:
+
 	ph->xops->xfer_put(ph, t);
+
+	/*
+	 * If supported overwrite short name with the extended one;
+	 * on error just carry on and use already provided short name.
+	 */
+	if (!ret && EXT_NAME_FLAG(attrs))
+		ph->hops->extended_name_get(ph, PINCTRL_NAME_GET, selector,
+					    (u32 *)&type, name,
+					    SCMI_MAX_STR_SIZE);
 	return ret;
 }
 
@@ -299,7 +243,7 @@ static void iter_pinctrl_assoc_prepare_message(void *message,
 	const struct scmi_pinctrl_ipriv *p = priv;
 
 	msg->identifier = cpu_to_le32(p->selector);
-	msg->flags = SET_TYPE(cpu_to_le32(p->type));
+	msg->flags = cpu_to_le32(p->type);
 	/* Set the number of OPPs to be skipped/already read */
 	msg->index = cpu_to_le32(desc_index);
 }
@@ -307,10 +251,12 @@ static void iter_pinctrl_assoc_prepare_message(void *message,
 static int iter_pinctrl_assoc_update_state(struct scmi_iterator_state *st,
 					   const void *response, void *priv)
 {
+	u32 flags;
 	const struct scmi_resp_pinctrl_list_assoc *r = response;
 
-	st->num_returned = le32_to_cpu(RETURNED(r->flags));
-	st->num_remaining = le32_to_cpu(REMAINING(r->flags));
+	flags = le32_to_cpu(r->flags);
+	st->num_returned = RETURNED(flags);
+	st->num_remaining = REMAINING(flags);
 
 	return 0;
 }
@@ -347,10 +293,7 @@ static int scmi_pinctrl_list_associations(const struct scmi_protocol_handle *ph,
 		.array = array,
 	};
 
-	if (!ph || !array || !size)
-		return -EINVAL;
-
-	if (type == PIN_TYPE)
+	if (!array || !size || type == PIN_TYPE)
 		return -EINVAL;
 
 	ret = scmi_pinctrl_validate_id(ph, selector, type);
@@ -373,13 +316,12 @@ static int scmi_pinctrl_get_config(const struct scmi_protocol_handle *ph,
 				   enum scmi_pinctrl_selector_type type,
 				   u8 config_type, u32 *config_value)
 {
+	int ret;
+	u32 attributes;
 	struct scmi_xfer *t;
 	struct scmi_msg_conf_get *tx;
-	__le32 *le_config;
-	u32 attributes = 0;
-	int ret;
 
-	if (!ph || !config_value || type == FUNCTION_TYPE)
+	if (!config_value || type == FUNCTION_TYPE)
 		return -EINVAL;
 
 	ret = scmi_pinctrl_validate_id(ph, selector, type);
@@ -387,22 +329,19 @@ static int scmi_pinctrl_get_config(const struct scmi_protocol_handle *ph,
 		return ret;
 
 	ret = ph->xops->xfer_get_init(ph, PINCTRL_CONFIG_GET, sizeof(*tx),
-				      sizeof(*le_config), &t);
+				      sizeof(__le32), &t);
 	if (ret)
 		return ret;
 
 	tx = t->tx.buf;
-	le_config = t->rx.buf;
 	tx->identifier = cpu_to_le32(selector);
 	attributes = FIELD_PREP(REG_TYPE_BITS, type) |
 		FIELD_PREP(REG_CONFIG, config_type);
-
 	tx->attributes = cpu_to_le32(attributes);
 
 	ret = ph->xops->do_xfer(ph, t);
-
 	if (!ret)
-		*config_value = le32_to_cpu(*le_config);
+		*config_value = get_unaligned_le32(t->rx.buf);
 
 	ph->xops->xfer_put(ph, t);
 	return ret;
@@ -418,7 +357,7 @@ static int scmi_pinctrl_set_config(const struct scmi_protocol_handle *ph,
 	u32 attributes = 0;
 	int ret;
 
-	if (!ph || type == FUNCTION_TYPE)
+	if (type == FUNCTION_TYPE)
 		return -EINVAL;
 
 	ret = scmi_pinctrl_validate_id(ph, selector, type);
@@ -448,11 +387,11 @@ static int scmi_pinctrl_function_select(const struct scmi_protocol_handle *ph,
 					enum scmi_pinctrl_selector_type type,
 					u32 function_id)
 {
+	int ret;
 	struct scmi_xfer *t;
 	struct scmi_msg_func_set *tx;
-	int ret;
 
-	if (!ph || type == FUNCTION_TYPE)
+	if (type == FUNCTION_TYPE)
 		return -EINVAL;
 
 	ret = scmi_pinctrl_validate_id(ph, identifier, type);
@@ -467,7 +406,7 @@ static int scmi_pinctrl_function_select(const struct scmi_protocol_handle *ph,
 	tx = t->tx.buf;
 	tx->identifier = cpu_to_le32(identifier);
 	tx->function_id = cpu_to_le32(function_id);
-	tx->flags = SET_TYPE(cpu_to_le32(type));
+	tx->flags = cpu_to_le32(type);
 
 	ret = ph->xops->do_xfer(ph, t);
 	ph->xops->xfer_put(ph, t);
@@ -479,11 +418,11 @@ static int scmi_pinctrl_request(const struct scmi_protocol_handle *ph,
 				u32 identifier,
 				enum scmi_pinctrl_selector_type type)
 {
-	struct scmi_xfer *t;
 	int ret;
+	struct scmi_xfer *t;
 	struct scmi_msg_request *tx;
 
-	if (!ph || type == FUNCTION_TYPE)
+	if (type == FUNCTION_TYPE)
 		return -EINVAL;
 
 	ret = scmi_pinctrl_validate_id(ph, identifier, type);
@@ -494,8 +433,8 @@ static int scmi_pinctrl_request(const struct scmi_protocol_handle *ph,
 				      0, &t);
 
 	tx = t->tx.buf;
-	tx->identifier = identifier;
-	tx->flags = SET_TYPE(cpu_to_le32(type));
+	tx->identifier = cpu_to_le32(identifier);
+	tx->flags = cpu_to_le32(type);
 
 	ret = ph->xops->do_xfer(ph, t);
 	ph->xops->xfer_put(ph, t);
@@ -513,11 +452,11 @@ static int scmi_pinctrl_free(const struct scmi_protocol_handle *ph,
 			     u32 identifier,
 			     enum scmi_pinctrl_selector_type type)
 {
-	struct scmi_xfer *t;
 	int ret;
+	struct scmi_xfer *t;
 	struct scmi_msg_request *tx;
 
-	if (!ph || type == FUNCTION_TYPE)
+	if (type == FUNCTION_TYPE)
 		return -EINVAL;
 
 	ret = scmi_pinctrl_validate_id(ph, identifier, type);
@@ -528,8 +467,8 @@ static int scmi_pinctrl_free(const struct scmi_protocol_handle *ph,
 				      sizeof(*tx), 0, &t);
 
 	tx = t->tx.buf;
-	tx->identifier = identifier;
-	tx->flags = SET_TYPE(cpu_to_le32(type));
+	tx->identifier = cpu_to_le32(identifier);
+	tx->flags = cpu_to_le32(type);
 
 	ret = ph->xops->do_xfer(ph, t);
 	ph->xops->xfer_put(ph, t);
@@ -546,13 +485,13 @@ static int scmi_pinctrl_get_group_info(const struct scmi_protocol_handle *ph,
 				       u32 selector,
 				       struct scmi_group_info *group)
 {
-	int ret = 0;
+	int ret;
 
-	if (!ph || !group)
+	if (!group)
 		return -EINVAL;
 
 	ret = scmi_pinctrl_attributes(ph, GROUP_TYPE, selector,
-				      &group->name,
+				      group->name,
 				      &group->nr_pins);
 	if (ret)
 		return ret;
@@ -565,33 +504,26 @@ static int scmi_pinctrl_get_group_info(const struct scmi_protocol_handle *ph,
 	group->group_pins = devm_kmalloc_array(ph->dev, group->nr_pins,
 					       sizeof(*group->group_pins),
 					       GFP_KERNEL);
-	if (!group->group_pins) {
-		ret = -ENOMEM;
-		goto err;
-	}
+	if (!group->group_pins)
+		return -ENOMEM;
 
 	ret = scmi_pinctrl_list_associations(ph, selector, GROUP_TYPE,
 					     group->nr_pins, group->group_pins);
-	if (ret)
-		goto err_groups;
+	if (ret) {
+		devm_kfree(ph->dev, group->group_pins);
+		return ret;
+	}
 
 	group->present = true;
 	return 0;
-
- err_groups:
-	kfree(group->group_pins);
- err:
-	kfree(group->name);
-	return ret;
 }
 
 static int scmi_pinctrl_get_group_name(const struct scmi_protocol_handle *ph,
 				       u32 selector, const char **name)
 {
-	int ret;
 	struct scmi_pinctrl_info *pi;
 
-	if (!ph || !name)
+	if (!name)
 		return -EINVAL;
 
 	pi = ph->get_priv(ph);
@@ -602,6 +534,8 @@ static int scmi_pinctrl_get_group_name(const struct scmi_protocol_handle *ph,
 		return -EINVAL;
 
 	if (!pi->groups[selector].present) {
+		int ret;
+
 		ret = scmi_pinctrl_get_group_info(ph, selector,
 						  &pi->groups[selector]);
 		if (ret)
@@ -617,10 +551,9 @@ static int scmi_pinctrl_get_group_pins(const struct scmi_protocol_handle *ph,
 				       u32 selector, const unsigned int **pins,
 				       unsigned int *nr_pins)
 {
-	int ret;
 	struct scmi_pinctrl_info *pi;
 
-	if (!ph || !pins || !nr_pins)
+	if (!pins || !nr_pins)
 		return -EINVAL;
 
 	pi = ph->get_priv(ph);
@@ -631,6 +564,8 @@ static int scmi_pinctrl_get_group_pins(const struct scmi_protocol_handle *ph,
 		return -EINVAL;
 
 	if (!pi->groups[selector].present) {
+		int ret;
+
 		ret = scmi_pinctrl_get_group_info(ph, selector,
 						  &pi->groups[selector]);
 		if (ret)
@@ -640,20 +575,20 @@ static int scmi_pinctrl_get_group_pins(const struct scmi_protocol_handle *ph,
 	*pins = pi->groups[selector].group_pins;
 	*nr_pins = pi->groups[selector].nr_pins;
 
-	return ret;
+	return 0;
 }
 
 static int scmi_pinctrl_get_function_info(const struct scmi_protocol_handle *ph,
 					  u32 selector,
 					  struct scmi_function_info *func)
 {
-	int ret = 0;
+	int ret;
 
-	if (!ph || !func)
+	if (!func)
 		return -EINVAL;
 
 	ret = scmi_pinctrl_attributes(ph, FUNCTION_TYPE, selector,
-				      &func->name,
+				      func->name,
 				      &func->nr_groups);
 	if (ret)
 		return ret;
@@ -666,33 +601,26 @@ static int scmi_pinctrl_get_function_info(const struct scmi_protocol_handle *ph,
 	func->groups = devm_kmalloc_array(ph->dev, func->nr_groups,
 					  sizeof(*func->groups),
 					  GFP_KERNEL);
-	if (!func->groups) {
-		ret = -ENOMEM;
-		goto err;
-	}
+	if (!func->groups)
+		return -ENOMEM;
 
 	ret = scmi_pinctrl_list_associations(ph, selector, FUNCTION_TYPE,
 					     func->nr_groups, func->groups);
-	if (ret)
-		goto err_funcs;
+	if (ret) {
+		devm_kfree(ph->dev, func->groups);
+		return ret;
+	}
 
 	func->present = true;
 	return 0;
-
- err_funcs:
-	kfree(func->groups);
- err:
-	kfree(func->name);
-	return ret;
 }
 
 static int scmi_pinctrl_get_function_name(const struct scmi_protocol_handle *ph,
 					  u32 selector, const char **name)
 {
-	int ret;
 	struct scmi_pinctrl_info *pi;
 
-	if (!ph || !name)
+	if (!name)
 		return -EINVAL;
 
 	pi = ph->get_priv(ph);
@@ -703,6 +631,8 @@ static int scmi_pinctrl_get_function_name(const struct scmi_protocol_handle *ph,
 		return -EINVAL;
 
 	if (!pi->functions[selector].present) {
+		int ret;
+
 		ret = scmi_pinctrl_get_function_info(ph, selector,
 						     &pi->functions[selector]);
 		if (ret)
@@ -718,10 +648,9 @@ static int scmi_pinctrl_get_function_groups(const struct scmi_protocol_handle *p
 					    unsigned int *nr_groups,
 					    const unsigned int **groups)
 {
-	int ret;
 	struct scmi_pinctrl_info *pi;
 
-	if (!ph || !groups || !nr_groups)
+	if (!groups || !nr_groups)
 		return -EINVAL;
 
 	pi = ph->get_priv(ph);
@@ -732,6 +661,8 @@ static int scmi_pinctrl_get_function_groups(const struct scmi_protocol_handle *p
 		return -EINVAL;
 
 	if (!pi->functions[selector].present) {
+		int ret;
+
 		ret = scmi_pinctrl_get_function_info(ph, selector,
 						     &pi->functions[selector]);
 		if (ret)
@@ -741,7 +672,7 @@ static int scmi_pinctrl_get_function_groups(const struct scmi_protocol_handle *p
 	*groups = pi->functions[selector].groups;
 	*nr_groups = pi->functions[selector].nr_groups;
 
-	return ret;
+	return 0;
 }
 
 static int scmi_pinctrl_set_mux(const struct scmi_protocol_handle *ph,
@@ -754,11 +685,10 @@ static int scmi_pinctrl_set_mux(const struct scmi_protocol_handle *ph,
 static int scmi_pinctrl_get_pin_info(const struct scmi_protocol_handle *ph,
 				     u32 selector, struct scmi_pin_info *pin)
 {
-	int ret = 0;
+	int ret;
 	struct scmi_pinctrl_info *pi;
-	unsigned int n_elems;
 
-	if (!ph || !pin)
+	if (!pin)
 		return -EINVAL;
 
 	pi = ph->get_priv(ph);
@@ -766,37 +696,20 @@ static int scmi_pinctrl_get_pin_info(const struct scmi_protocol_handle *ph,
 		return -EINVAL;
 
 	ret = scmi_pinctrl_attributes(ph, PIN_TYPE, selector,
-				      &pin->name,
-				      &n_elems);
+				      pin->name, NULL);
 	if (ret)
 		return ret;
 
-	if (n_elems != pi->nr_pins) {
-		dev_err(ph->dev, "Wrong pin count expected %d has %d",
-			pi->nr_pins, n_elems);
-		return -ENODATA;
-	}
-
-	if (*pin->name == 0) {
-		dev_err(ph->dev, "Pin name is empty");
-		goto err;
-	}
-
 	pin->present = true;
 	return 0;
-
- err:
-	kfree(pin->name);
-	return ret;
 }
 
 static int scmi_pinctrl_get_pin_name(const struct scmi_protocol_handle *ph,
 				     u32 selector, const char **name)
 {
-	int ret;
 	struct scmi_pinctrl_info *pi;
 
-	if (!ph || !name)
+	if (!name)
 		return -EINVAL;
 
 	pi = ph->get_priv(ph);
@@ -807,6 +720,8 @@ static int scmi_pinctrl_get_pin_name(const struct scmi_protocol_handle *ph,
 		return -EINVAL;
 
 	if (!pi->pins[selector].present) {
+		int ret;
+
 		ret = scmi_pinctrl_get_pin_info(ph, selector,
 						&pi->pins[selector]);
 		if (ret)
@@ -849,12 +764,9 @@ static const struct scmi_pinctrl_proto_ops pinctrl_proto_ops = {
 
 static int scmi_pinctrl_protocol_init(const struct scmi_protocol_handle *ph)
 {
+	int ret;
 	u32 version;
 	struct scmi_pinctrl_info *pinfo;
-	int ret;
-
-	if (!ph)
-		return -EINVAL;
 
 	ret = ph->xops->version_get(ph, &version);
 	if (ret)
@@ -899,9 +811,6 @@ static int scmi_pinctrl_protocol_deinit(const struct scmi_protocol_handle *ph)
 	int i;
 	struct scmi_pinctrl_info *pi;
 
-	if (!ph)
-		return -EINVAL;
-
 	pi = ph->get_priv(ph);
 	if (!pi)
 		return -EINVAL;
-- 
2.34.1

