Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4E496E7DEE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 17:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233725AbjDSPOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 11:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbjDSPNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 11:13:54 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125917680;
        Wed, 19 Apr 2023 08:13:40 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6a5f03551fdso1482914a34.0;
        Wed, 19 Apr 2023 08:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681917219; x=1684509219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7EkWErFrWVVVguCZXrs5/K/s3WGppdVFRB9CPm2mWr4=;
        b=FO3OuJIGLQrMA/LoQxR+43iT8BQ70ilkBDHd+gEJMY2wIae6xF4YZMaYrB9+dYJcp5
         9dfXFA/zkc93FQoy4fMIOLUNSABMqSvt8M0o3i5iGPIw4f2eKQBo32hY2damV7Xc27hM
         U0PIrTNnGk0g0EhjPw5bDPZpaqlmSHj7oonFTUh9hWqblND1eJVXTXvWSDMCVRZWGxbI
         LzXgsejetE6J9LhJ+8MJ+DTRQILGCxCJbcRul9HShm89mNl0KYn5aJYxYKXTLX3jmdwy
         rdwHMwdZXXWrpRqIoPkppksLrthNbBKzocYcZqU5kUqx7MSz8LsqgNKb9GC5KRzKOP6E
         jF1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681917219; x=1684509219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7EkWErFrWVVVguCZXrs5/K/s3WGppdVFRB9CPm2mWr4=;
        b=ihPk/Cr1AVIJrHfx9zxfYwjHK82UcRUQalT5e/0mYOYBDqZPsXOOauBHjMKCzmp9ol
         tIvEfpp+49B19CBt4SHmB5M3IaW6SS0Z5mkCcEw4TPSfK1x3/rRp+lRhW3yKok6jZORp
         N2OKMhMpksdoqYp5mikWG3yaRuaQLCHysz8Nnf6qHTa0nv6hp1u6cOJJY6KWbhDaxK3e
         pF5p1eaOnJrpzFIf9078mflP70n3NOE8nWBArqtGWHV6MqH5Y4z0olWBgpkvKzeQ8mON
         /f95JlMUx6+9FnrxtzyxZgENyEep2BvLy2I2OphsxSvcsvqquVTMqePzrEqTbVPArNFZ
         pKvA==
X-Gm-Message-State: AAQBX9eOoMyxUUVs+w+FvSIAynnLloYPV+E65NYRFgzYipsf5RqijRlM
        IGVUdW7Vbi3atErKKMRMLAe7Z24Xgbg=
X-Google-Smtp-Source: AKy350bUiewnLNzlexxoQ8kMiRm0j8obytrzPgBPYc0Gcvss5+OdZxDYvWAD9YW9i5XzSVx+TfUoPg==
X-Received: by 2002:a05:6830:13c7:b0:6a4:32e7:e559 with SMTP id e7-20020a05683013c700b006a432e7e559mr2960359otq.33.1681917219391;
        Wed, 19 Apr 2023 08:13:39 -0700 (PDT)
Received: from grumpy-VECTOR.hsd1.tx.comcast.net ([2601:2c3:480:7390:e175:6963:338:7453])
        by smtp.gmail.com with ESMTPSA id f17-20020a056830205100b00690e990e61asm4308842otp.14.2023.04.19.08.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 08:13:39 -0700 (PDT)
From:   Jorge Lopez <jorgealtxwork@gmail.com>
X-Google-Original-From: Jorge Lopez <jorge.lopez2@hp.com>
To:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de
Subject: [PATCH v10 12/14] HP BIOSCFG driver  - surestart-attributes
Date:   Wed, 19 Apr 2023 10:13:19 -0500
Message-Id: <20230419151321.6167-13-jorge.lopez2@hp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230419151321.6167-1-jorge.lopez2@hp.com>
References: <20230419151321.6167-1-jorge.lopez2@hp.com>
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
 .../x86/hp/hp-bioscfg/surestart-attributes.c  | 130 ++++++++++++++++++
 1 file changed, 130 insertions(+)
 create mode 100644 drivers/platform/x86/hp/hp-bioscfg/surestart-attributes.c

diff --git a/drivers/platform/x86/hp/hp-bioscfg/surestart-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/surestart-attributes.c
new file mode 100644
index 000000000000..43bd405403e9
--- /dev/null
+++ b/drivers/platform/x86/hp/hp-bioscfg/surestart-attributes.c
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Functions corresponding to sure start object type attributes under
+ * BIOS for use with hp-bioscfg driver
+ *
+ *  Copyright (c) 2022 HP Development Company, L.P.
+ */
+
+#include "bioscfg.h"
+#include <asm-generic/posix_types.h>
+
+#define LOG_MAX_ENTRIES	254
+#define LOG_ENTRY_SIZE		16
+
+/*
+ * audit_log_entry_count_show - Reports the number of
+ *				existing audit log entries available
+ *				to be read
+ */
+static ssize_t audit_log_entry_count_show(struct kobject *kobj,
+					  struct kobj_attribute *attr, char *buf)
+{
+	int ret;
+	u32 count = 0;
+
+	ret = hp_wmi_perform_query(HPWMI_SURESTART_GET_LOG_COUNT,
+				   HPWMI_SURESTART,
+				   &count, 1, sizeof(count));
+
+	if (ret < 0)
+		return ret;
+
+	return sysfs_emit(buf, "%d,%d,%d\n", count, LOG_ENTRY_SIZE,
+			  LOG_MAX_ENTRIES);
+}
+
+/*
+ * audit_log_entries_show() - Return all entries found in log file
+ */
+static ssize_t audit_log_entries_show(struct kobject *kobj,
+				      struct kobj_attribute *attr, char *buf)
+{
+	int ret;
+	int i;
+	u32 count = 0;
+
+	// Get the number of event logs
+	ret = hp_wmi_perform_query(HPWMI_SURESTART_GET_LOG_COUNT,
+				   HPWMI_SURESTART,
+				   &count, 1, sizeof(count));
+
+	/*
+	 * The show() api will not work if the audit logs ever go
+	 *  beyond 4KB
+	 */
+	if (count * LOG_ENTRY_SIZE > PAGE_SIZE)
+		return -EFAULT;
+
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * We are guaranteed the buffer is 4KB so today all the event
+	 * logs will fit
+	 */
+
+	for (i = 0; ((i < count) & (ret >= 0)); i++) {
+		*buf = (i + 1);
+		ret = hp_wmi_perform_query(HPWMI_SURESTART_GET_LOG,
+					   HPWMI_SURESTART,
+					   buf, 1, 128);
+		if (ret >= 0)
+			buf += LOG_ENTRY_SIZE;
+	}
+
+	return (count * LOG_ENTRY_SIZE);
+}
+
+static struct kobj_attribute sure_start_audit_log_entry_count = __ATTR_RO(audit_log_entry_count);
+struct kobj_attribute sure_start_audit_log_entries = __ATTR_RO(audit_log_entries);
+
+static ssize_t type_show(struct kobject *kobj, struct kobj_attribute *attr,
+			 char *buf)
+{
+	return sysfs_emit(buf, "sure-start\n");
+}
+static struct kobj_attribute sure_start_type = __ATTR_RO(type);
+
+static ssize_t display_name_language_code_show(struct kobject *kobj,
+					       struct kobj_attribute *attr,
+					       char *buf)
+{
+	return sysfs_emit(buf, "%s\n", LANG_CODE_STR);
+}
+
+static struct kobj_attribute sure_start_display_langcode =
+		__ATTR_RO(display_name_language_code);
+
+
+static ssize_t display_name_show(struct kobject *kobj,
+				 struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%s\n", SURE_START_DESC);
+}
+static struct kobj_attribute sure_start_display_name = __ATTR_RO(display_name);
+
+static struct attribute *sure_start_attrs[] = {
+	&sure_start_display_name.attr,
+	&sure_start_display_langcode.attr,
+	&sure_start_audit_log_entry_count.attr,
+	&sure_start_audit_log_entries.attr,
+	&sure_start_type.attr,
+	NULL
+};
+
+static const struct attribute_group sure_start_attr_group = {
+	.attrs = sure_start_attrs,
+};
+
+void exit_sure_start_attributes(void)
+{
+	sysfs_remove_group(bioscfg_drv.sure_start_attr_kobj,
+			   &sure_start_attr_group);
+}
+
+int populate_sure_start_data(struct kobject *attr_name_kobj)
+{
+	bioscfg_drv.sure_start_attr_kobj = attr_name_kobj;
+	return sysfs_create_group(attr_name_kobj, &sure_start_attr_group);
+}
-- 
2.34.1

