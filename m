Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDE9728518
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 18:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236130AbjFHQeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 12:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235717AbjFHQdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 12:33:45 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8792B2711;
        Thu,  8 Jun 2023 09:33:33 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-5523bd97c64so1217096eaf.0;
        Thu, 08 Jun 2023 09:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686242013; x=1688834013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7fEOh5rjWkHHjnI1FcGIXl+IfwcpsEG1P2j/5PMOEqA=;
        b=eODll6i2bSU6rMQcj2CfZgugdlaFkLaCVE+mJsBtklgfNyH3uuDFEFo15rPyorEAoN
         cXvUP826JMfDWwT2k9yj1RaH6s1/YuW1WGSwAH0nQalHsY6VrvayXUiuEtCK6UvOqRXq
         grGcNjTxB/EhGcsZSsp87artU8wmjax+k08hMzFJDXyqKKs8+yFQTC08TiMRv2KeYigp
         zoNdFUiikIcEEyQjmu+WBqoAHwG/H3ZXM9x36JpQ5nCHF6h7vic73wxiPzwtesvDpK6a
         /IwozcVS2K1DdkTK8if6UuPdxjAMCdu/mb3kLLiL8Tt4frDzCT4Ezz2po9TWPZm0y5vl
         bPYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686242013; x=1688834013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7fEOh5rjWkHHjnI1FcGIXl+IfwcpsEG1P2j/5PMOEqA=;
        b=S4qnuJ5W8vawNTpT2VrzrtHTkN/iUummV0f0T09fCuJPFuXN31myR4ZhoWwrwzS9gh
         OQ9p04dqWC75pOWtSyTL27c3iNRohC8thVGsm1g5stYQqYFV36jRseYLU1DQOy0JtiUc
         ZNvLUPBxNH/uPh4EibWlyhJXjKrsKskjptw5mcPXh+JYTaWMD4Ao+khiItQbKQ1f/M/6
         u7xRM1l9+JgzV7af0jAxns+8VHIpPdG6LjNuNVHh4unPApITkMugmxafoNuPHQ0JFvF2
         INxA8jgudmT6HqqZvdaqLtqlVGHHlHB6urq8mh4lcfbddtJhGPR+IUYiS0m8fdoE87Dd
         K40A==
X-Gm-Message-State: AC+VfDw5jsZr80BVUNgnk9Wmq3hPJlhJxOF8NzG7OElc7GiCjyep/8pt
        Dqof7Y5gzuJJ2PR7ykZ47jU=
X-Google-Smtp-Source: ACHHUZ4tcru/OJactgRUMiOQl0SsgfMsGi6a5gRSLoK7/hm6o2OlXMxCuxEuP3eW4No+qLKX+/w0kg==
X-Received: by 2002:a05:6808:4d0:b0:39a:c245:f567 with SMTP id a16-20020a05680804d000b0039ac245f567mr1423711oie.2.1686242012383;
        Thu, 08 Jun 2023 09:33:32 -0700 (PDT)
Received: from grumpy-VECTOR.hsd1.tx.comcast.net ([2601:2c3:480:7390:a60f:2d4d:e52b:2fca])
        by smtp.gmail.com with ESMTPSA id e10-20020acab50a000000b003942036439dsm577500oif.46.2023.06.08.09.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 09:33:32 -0700 (PDT)
From:   Jorge Lopez <jorgealtxwork@gmail.com>
X-Google-Original-From: Jorge Lopez <jorge.lopez2@hp.com>
To:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v17 09/13] hp-bioscfg: spmobj-attributes
Date:   Thu,  8 Jun 2023 11:33:15 -0500
Message-Id: <20230608163319.18934-10-jorge.lopez2@hp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230608163319.18934-1-jorge.lopez2@hp.com>
References: <20230608163319.18934-1-jorge.lopez2@hp.com>
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

Add SPM authentication attributes support to hp-bioscfg.

HP BIOS Configuration driver purpose is to provide a driver supporting
the latest sysfs class firmware attributes framework allowing the user
to change BIOS settings and security solutions on HP Inc.’s commercial
notebooks.

Signed-off-by: Jorge Lopez <jorge.lopez2@hp.com>

---
Based on the latest platform-drivers-x86.git/for-next
---
 .../x86/hp/hp-bioscfg/spmobj-attributes.c     | 386 ++++++++++++++++++
 1 file changed, 386 insertions(+)
 create mode 100644 drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c

diff --git a/drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c
new file mode 100644
index 000000000000..02291e32684f
--- /dev/null
+++ b/drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c
@@ -0,0 +1,386 @@
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
+	memcpy(bioscfg_drv.spm_data.signing_key, buf, length);
+
+	/* submit signing key payload */
+	ret = hp_wmi_perform_query(HPWMI_SECUREPLATFORM_SET_SK,
+				   HPWMI_SECUREPLATFORM,
+				   (void *)bioscfg_drv.spm_data.signing_key,
+				   count, 0);
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
+	bioscfg_drv.spm_data.auth_token = kmalloc(length, GFP_KERNEL);
+	if (!bioscfg_drv.spm_data.auth_token) {
+		ret = -ENOMEM;
+		goto exit_token;
+	}
+
+	memcpy(bioscfg_drv.spm_data.auth_token, buf, length);
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

