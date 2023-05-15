Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A59F27040A6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 00:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343545AbjEOWD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 18:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245446AbjEOWCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 18:02:44 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C44C5903A;
        Mon, 15 May 2023 15:01:33 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6aaf9092c52so3846124a34.1;
        Mon, 15 May 2023 15:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684188073; x=1686780073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GmJiBF9aZ/rjxXh674y9zjBZAdGcTZ4RoPDtWUhq39g=;
        b=igKR62sTVMXFgAj1Q4xt37VDV3rZ6RhkY7DgvVTU2NsZrEv4vxp/EUcBm0iwlPo20d
         SFQh0LUH7a/Es/M0b4rPVC/7LCLJklHqNNRHtTClGUWCFQrSPRBujHP1dBBoh5OCfECF
         Vg3SupK+AkL+sI/y+etRFixvWlgLgI3oj1Tr231PE0sEYZQO+jdQv5jB6/DkLHyabC+Y
         cQQQJSMS6us3c2vRMfhEB4ilCOD420yt+jJb7mdjOH/epkyTgEEmXKDgw5uutcKmi/We
         EJG8XwUS+0UX9yp4nDIwYDRy23Ctim0QOqogMHzxCfhYx9uLM94ls0Ykz7X0qYEqFBMA
         Mq+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684188073; x=1686780073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GmJiBF9aZ/rjxXh674y9zjBZAdGcTZ4RoPDtWUhq39g=;
        b=JzDSEWRRiQWaLFwM0x51AGz/GfX8WFXUUYsKi72ug1GOnR/vs/Da98nvPoVjmcJjf/
         h83CwoKaoEymNqAg9sFhsr29L1m5YVTgs2BruDC7R57Q7AF0yZ5zBw7n6SVIMn5yI8EC
         Bg5Bd8Grsd38ATRTsWEloZkdVoqFdzygcjHfqKl/SJIW9rpa9/24hZZs6xQfDRBbmvUF
         5R3WUyrXOAjW0RTRw4niFKpz7HlbtEsDU+d8wYG91pjiOYhaXbmm2bhM8IKwOqOuQh4m
         3cI5BcqBk9zn7c2DPHUIRQQ2tEgx5A+1nBhBIMSrmQ7GXOq2xw8nqKguufn/4shMPfAZ
         uwIg==
X-Gm-Message-State: AC+VfDxt8zwYeviCj7IIN+uMDdOYKYd5hDge8+VIVR/wR5FtXEm+L0z1
        njd6JdmWlFCb9k4yGOu8Yyk=
X-Google-Smtp-Source: ACHHUZ6UZfKm5vmn8YDBzmMFKne+CkZVFyXUD6Gt5AuBeTc031RqxSAoTtCCp00bIUWQv3zm60zGvg==
X-Received: by 2002:a05:6808:180b:b0:395:fc76:bda0 with SMTP id bh11-20020a056808180b00b00395fc76bda0mr3318050oib.53.1684188073384;
        Mon, 15 May 2023 15:01:13 -0700 (PDT)
Received: from grumpy-VECTOR.hsd1.tx.comcast.net ([2601:2c3:480:7390:5391:4539:59c2:4092])
        by smtp.gmail.com with ESMTPSA id i1-20020aca0c41000000b0038e07fe2c97sm5265148oiy.42.2023.05.15.15.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 15:01:12 -0700 (PDT)
From:   Jorge Lopez <jorgealtxwork@gmail.com>
X-Google-Original-From: Jorge Lopez <jorge.lopez2@hp.com>
To:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v13 09/13] hp-bioscfg: spmobj-attributes
Date:   Mon, 15 May 2023 17:00:57 -0500
Message-Id: <20230515220101.39794-10-jorge.lopez2@hp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230515220101.39794-1-jorge.lopez2@hp.com>
References: <20230515220101.39794-1-jorge.lopez2@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HP BIOS Configuration driver purpose is to provide a driver supporting
the latest sysfs class firmware attributes framework allowing the user
to change BIOS settings and security solutions on HP Inc.’s commercial
notebooks.

Many features of HP Commercial notebooks can be managed using Windows
Management Instrumentation (WMI). WMI is an implementation of Web-Based
Enterprise Management (WBEM) that provides a standards-based interface
for changing and monitoring system settings. HP BIOSCFG driver provides
a native Linux solution and the exposed features facilitates the
migration to Linux environments.

The Linux security features to be provided in hp-bioscfg driver enables
managing the BIOS settings and security solutions via sysfs, a virtual
filesystem that can be used by user-mode applications. The new
documentation cover HP-specific firmware sysfs attributes such Secure
Platform Management and Sure Start. Each section provides security
feature description and identifies sysfs directories and files exposed
by the driver.

Many HP Commercial notebooks include a feature called Secure Platform
Management (SPM), which replaces older password-based BIOS settings
management with public key cryptography. PC secure product management
begins when a target system is provisioned with cryptographic keys
that are used to ensure the integrity of communications between system
management utilities and the BIOS.

HP Commercial notebooks have several BIOS settings that control its
behaviour and capabilities, many of which are related to security.
To prevent unauthorized changes to these settings, the system can
be configured to use a cryptographic signature-based authorization
string that the BIOS will use to verify authorization to modify the
setting.

Linux Security components are under development and not published yet.
The only linux component is the driver (hp bioscfg) at this time.
Other published security components are under Windows.

Signed-off-by: Jorge Lopez <jorge.lopez2@hp.com>

---
Based on the latest platform-drivers-x86.git/for-next
---
 .../x86/hp/hp-bioscfg/spmobj-attributes.c     | 389 ++++++++++++++++++
 1 file changed, 389 insertions(+)
 create mode 100644 drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c

diff --git a/drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c
new file mode 100644
index 000000000000..66f025b5d113
--- /dev/null
+++ b/drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c
@@ -0,0 +1,389 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Functions corresponding to secure platform management object type
+ * attributes under BIOS PASSWORD for use with hp-bioscfg driver
+ *
+ * Copyright (c) 2022 HP Development Company, L.P.
+ */
+
+#include "bioscfg.h"
+
+static const char * const spm_state_types[] = {
+	"not provisioned",
+	"provisioned",
+	"provisioning in progress",
+};
+
+static const char * const spm_mechanism_types[] = {
+	"not provisioned",
+	"signing-key",
+	"endorsement-key",
+};
+
+struct secureplatform_provisioning_data {
+	u8 state;
+	u8 version[2];
+	u8 reserved1;
+	u32 features;
+	u32 nonce;
+	u8 reserved2[28];
+	u8 sk_mod[MAX_KEY_MOD_SIZE];
+	u8 kek_mod[MAX_KEY_MOD_SIZE];
+};
+
+/**
+ * hp_calculate_security_buffer() - determines size of security buffer
+ * for authentication scheme
+ *
+ * @authentication: the authentication content
+ *
+ * Currently only supported type is Admin password
+ */
+size_t hp_calculate_security_buffer(const char *authentication)
+{
+	size_t size, authlen;
+
+	if (!authentication)
+		return sizeof(u16) * 2;
+
+	authlen = strlen(authentication);
+	if (!authlen)
+		return sizeof(u16) * 2;
+
+	size = sizeof(u16) + authlen * sizeof(u16);
+	if (!strstarts(authentication, BEAM_PREFIX))
+		size += strlen(UTF_PREFIX) * sizeof(u16);
+
+	return size;
+}
+
+/**
+ * hp_populate_security_buffer() - builds a security buffer for
+ * authentication scheme
+ *
+ * @authbuf: the security buffer
+ * @authentication: the authentication content
+ *
+ * Currently only supported type is PLAIN TEXT
+ */
+int hp_populate_security_buffer(u16 *authbuf, const char *authentication)
+{
+	u16 *auth = authbuf;
+	char *strprefix = NULL;
+	int ret = 0;
+
+	if (strstarts(authentication, BEAM_PREFIX)) {
+		/*
+		 * BEAM_PREFIX is append to authbuf when a signature
+		 * is provided and Sure Admin is enabled in BIOS
+		 */
+		/* BEAM_PREFIX found, convert part to unicode */
+		auth = hp_ascii_to_utf16_unicode(auth, authentication);
+		if (!auth)
+			return -EINVAL;
+
+	} else {
+		/*
+		 * UTF-16 prefix is append to the * authbuf when a BIOS
+		 * admin password is configured in BIOS
+		 */
+
+		/* append UTF_PREFIX to part and then convert it to unicode */
+		strprefix = kasprintf(GFP_KERNEL, "%s%s", UTF_PREFIX,
+				      authentication);
+		if (!strprefix)
+			return -ENOMEM;
+
+		auth = hp_ascii_to_utf16_unicode(auth, strprefix);
+		kfree(strprefix);
+
+		if (!auth) {
+			ret = -EINVAL;
+			goto out_buffer;
+		}
+	}
+
+out_buffer:
+	return ret;
+}
+
+static ssize_t update_spm_state(void)
+{
+	struct secureplatform_provisioning_data data;
+	int ret;
+
+	ret = hp_wmi_perform_query(HPWMI_SECUREPLATFORM_GET_STATE,
+				   HPWMI_SECUREPLATFORM, &data, 0,
+				   sizeof(data));
+	if (ret < 0)
+		return ret;
+
+	bioscfg_drv.spm_data.mechanism = data.state;
+	if (bioscfg_drv.spm_data.mechanism)
+		bioscfg_drv.spm_data.is_enabled = 1;
+
+	return 0;
+}
+
+static ssize_t statusbin(struct kobject *kobj,
+			 struct kobj_attribute *attr,
+			 struct secureplatform_provisioning_data *buf)
+{
+	int ret = hp_wmi_perform_query(HPWMI_SECUREPLATFORM_GET_STATE,
+				       HPWMI_SECUREPLATFORM, buf, 0,
+				       sizeof(*buf));
+
+	if (ret < 0)
+		return ret;
+
+	return sizeof(struct secureplatform_provisioning_data);
+}
+
+/*
+ * status_show - Reads SPM status
+ */
+static ssize_t status_show(struct kobject *kobj, struct kobj_attribute
+			   *attr, char *buf)
+{
+	int ret, i;
+	int len = 0;
+	struct secureplatform_provisioning_data data;
+
+	ret = statusbin(kobj, attr, &data);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * 'status' is a read-only file that returns ASCII text in
+	 * JSON format reporting the status information.
+	 *
+	 * "State": "not provisioned | provisioned | provisioning in progress ",
+	 * "Version": " Major. Minor ",
+	 * "Nonce": <16-bit unsigned number display in base 10>,
+	 * "FeaturesInUse": <16-bit unsigned number display in base 10>,
+	 * "EndorsementKeyMod": "<256 bytes in base64>",
+	 * "SigningKeyMod": "<256 bytes in base64>"
+	 */
+
+	len += sysfs_emit_at(buf, len, "{\n");
+	len += sysfs_emit_at(buf, len, "\t\"State\": \"%s\",\n",
+			     spm_state_types[data.state]);
+	len += sysfs_emit_at(buf, len, "\t\"Version\": \"%d.%d\"",
+			     data.version[0], data.version[1]);
+
+	/*
+	 * state == 0 means secure platform management
+	 * feature is not configured in BIOS.
+	 */
+	if (data.state == 0) {
+		len += sysfs_emit_at(buf, len, "\n");
+		goto status_exit;
+	} else {
+		len += sysfs_emit_at(buf, len, ",\n");
+	}
+
+	len += sysfs_emit_at(buf, len, "\t\"Nonce\": %d,\n", data.nonce);
+	len += sysfs_emit_at(buf, len, "\t\"FeaturesInUse\": %d,\n", data.features);
+	len += sysfs_emit_at(buf, len, "\t\"EndorsementKeyMod\": \"");
+
+	for (i = 255; i >= 0; i--)
+		len += sysfs_emit_at(buf, len, " %u", data.kek_mod[i]);
+
+	len += sysfs_emit_at(buf, len, " \",\n");
+	len += sysfs_emit_at(buf, len, "\t\"SigningKeyMod\": \"");
+
+	for (i = 255; i >= 0; i--)
+		len += sysfs_emit_at(buf, len, " %u", data.sk_mod[i]);
+
+	/* Return buf contents */
+	len += sysfs_emit_at(buf, len, " \"\n");
+
+status_exit:
+	len += sysfs_emit_at(buf, len, "}\n");
+
+	return len;
+}
+
+static struct kobj_attribute password_spm_status = __ATTR_RO(status);
+
+ATTRIBUTE_SPM_N_PROPERTY_SHOW(is_enabled, spm);
+static struct kobj_attribute password_spm_is_key_enabled = __ATTR_RO(is_enabled);
+
+static ssize_t key_mechanism_show(struct kobject *kobj, struct kobj_attribute *attr,
+				  char *buf)
+{
+	return sysfs_emit(buf, "%s\n",
+			  spm_mechanism_types[bioscfg_drv.spm_data.mechanism]);
+}
+
+static struct kobj_attribute password_spm_key_mechanism = __ATTR_RO(key_mechanism);
+
+static ssize_t sk_store(struct kobject *kobj,
+			struct kobj_attribute *attr,
+			const char *buf, size_t count)
+{
+	int ret;
+	int length;
+
+	length = count;
+	if (buf[length - 1] == '\n')
+		length--;
+
+	/* allocate space and copy current signing key */
+	bioscfg_drv.spm_data.signing_key = kmalloc(length, GFP_KERNEL);
+	if (!bioscfg_drv.spm_data.signing_key)
+		return -ENOMEM;
+
+	strscpy(bioscfg_drv.spm_data.signing_key, buf, length);
+	bioscfg_drv.spm_data.signing_key[length] = '\0';
+
+	/* submit signing key payload */
+	ret = hp_wmi_perform_query(HPWMI_SECUREPLATFORM_SET_SK,
+				   HPWMI_SECUREPLATFORM,
+				   bioscfg_drv.spm_data.signing_key,
+				   length, 0);
+
+	if (!ret) {
+		bioscfg_drv.spm_data.mechanism = SIGNING_KEY;
+		hp_set_reboot_and_signal_event();
+	}
+
+	kfree(bioscfg_drv.spm_data.signing_key);
+	bioscfg_drv.spm_data.signing_key = NULL;
+
+	return ret ? ret : count;
+}
+
+static struct kobj_attribute password_spm_signing_key = __ATTR_WO(sk);
+
+static ssize_t kek_store(struct kobject *kobj,
+			 struct kobj_attribute *attr,
+			 const char *buf, size_t count)
+{
+	int ret;
+	int length;
+
+	length = count;
+	if (buf[length - 1] == '\n')
+		length--;
+
+	/* allocate space and copy current signing key */
+	bioscfg_drv.spm_data.endorsement_key = kmalloc(length, GFP_KERNEL);
+	if (!bioscfg_drv.spm_data.endorsement_key) {
+		ret = -ENOMEM;
+		goto exit_kek;
+	}
+
+	memcpy(bioscfg_drv.spm_data.endorsement_key, buf, length);
+	bioscfg_drv.spm_data.endorsement_key[length] = '\0';
+
+	ret = hp_wmi_perform_query(HPWMI_SECUREPLATFORM_SET_KEK,
+				   HPWMI_SECUREPLATFORM,
+				   (void *)bioscfg_drv.spm_data.endorsement_key,
+				   count, 0);
+
+	if (!ret) {
+		bioscfg_drv.spm_data.mechanism = ENDORSEMENT_KEY;
+		hp_set_reboot_and_signal_event();
+	}
+
+exit_kek:
+	kfree(bioscfg_drv.spm_data.endorsement_key);
+	bioscfg_drv.spm_data.endorsement_key = NULL;
+
+	return ret ? ret : count;
+}
+
+static struct kobj_attribute password_spm_endorsement_key = __ATTR_WO(kek);
+
+static ssize_t role_show(struct kobject *kobj, struct kobj_attribute *attr,
+			 char *buf)
+{
+	return sysfs_emit(buf, "%s\n", BIOS_SPM);
+}
+
+static struct kobj_attribute password_spm_role = __ATTR_RO(role);
+
+static ssize_t auth_token_store(struct kobject *kobj,
+				struct kobj_attribute *attr,
+				const char *buf, size_t count)
+{
+	int ret = 0;
+	int length;
+
+	length = count;
+	if (buf[length - 1] == '\n')
+		length--;
+
+	/* allocate space and copy current auth token */
+	bioscfg_drv.spm_data.auth_token = kmalloc(count, GFP_KERNEL);
+	if (!bioscfg_drv.spm_data.auth_token) {
+		ret = -ENOMEM;
+		goto exit_token;
+	}
+
+	memcpy(bioscfg_drv.spm_data.auth_token, buf, count);
+	bioscfg_drv.spm_data.auth_token[length] = '\0';
+	return count;
+
+exit_token:
+	kfree(bioscfg_drv.spm_data.auth_token);
+	bioscfg_drv.spm_data.auth_token = NULL;
+
+	return ret;
+}
+
+static struct kobj_attribute password_spm_auth_token = __ATTR_WO(auth_token);
+
+static struct attribute *secure_platform_attrs[] = {
+	&password_spm_is_key_enabled.attr,
+	&password_spm_signing_key.attr,
+	&password_spm_endorsement_key.attr,
+	&password_spm_key_mechanism.attr,
+	&password_spm_status.attr,
+	&password_spm_role.attr,
+	&password_spm_auth_token.attr,
+	NULL,
+};
+
+static const struct attribute_group secure_platform_attr_group = {
+	.attrs = secure_platform_attrs,
+};
+
+void hp_exit_secure_platform_attributes(void)
+{
+	/* remove secure platform sysfs entry and free key data*/
+
+	kfree(bioscfg_drv.spm_data.endorsement_key);
+	bioscfg_drv.spm_data.endorsement_key = NULL;
+
+	kfree(bioscfg_drv.spm_data.signing_key);
+	bioscfg_drv.spm_data.signing_key = NULL;
+
+	kfree(bioscfg_drv.spm_data.auth_token);
+	bioscfg_drv.spm_data.auth_token = NULL;
+
+	if (bioscfg_drv.spm_data.attr_name_kobj)
+		sysfs_remove_group(bioscfg_drv.spm_data.attr_name_kobj,
+				   &secure_platform_attr_group);
+}
+
+int hp_populate_secure_platform_data(struct kobject *attr_name_kobj)
+{
+	/* Populate data for Secure Platform Management */
+	bioscfg_drv.spm_data.attr_name_kobj = attr_name_kobj;
+
+	strscpy(bioscfg_drv.spm_data.attribute_name, SPM_STR,
+		sizeof(bioscfg_drv.spm_data.attribute_name));
+
+	bioscfg_drv.spm_data.is_enabled = 0;
+	bioscfg_drv.spm_data.mechanism = 0;
+	bioscfg_drv.pending_reboot = false;
+	update_spm_state();
+
+	bioscfg_drv.spm_data.endorsement_key = NULL;
+	bioscfg_drv.spm_data.signing_key = NULL;
+	bioscfg_drv.spm_data.auth_token = NULL;
+
+	return sysfs_create_group(attr_name_kobj, &secure_platform_attr_group);
+}
-- 
2.34.1

