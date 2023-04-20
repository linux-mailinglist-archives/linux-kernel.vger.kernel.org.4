Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B35846E9A15
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 18:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbjDTQz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 12:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbjDTQza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 12:55:30 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E04469E;
        Thu, 20 Apr 2023 09:55:11 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-187d9c205e9so710720fac.3;
        Thu, 20 Apr 2023 09:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682009711; x=1684601711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Obe2vSVBXXici55JN5j0R09I4VIG8/7jWFwQnKEIzYc=;
        b=n32strS6mhAujrsaY1EeHfNtd2VqSI80/VYG4II3M82SRNe1Wkhpgd4nDvj+sjkfor
         +NAn5dXEnYZ4NncIRN8XNIMrhrBc+7BoVGFmMyhzQcxC85Zhw4+ZNcblIHSuvMrEGpFu
         rQR/LYGjt16Frd9+GInBz38LIdzl7IACGnGJKc9llUopKSlelisu++0u7hXtChNBFCHQ
         3hBI4qovSs3qvb/HZ9OQOSWdq95oDUtnlc0vzxyyvR++iN50vaseDqnrPVv5qoxeIrb8
         6yTEw33XtwOAQDTMKKgOO6NU2fUFoXEPduZjeTuY1m3KvlC0uA0T9oOZgp6VnfhEBFcV
         JusQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682009711; x=1684601711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Obe2vSVBXXici55JN5j0R09I4VIG8/7jWFwQnKEIzYc=;
        b=Ipv9aiy+z47P+PJvueRGX2y6FX1gOGA8s8rWLOavHaD2VlENVRwyZaEmsEpABP2nG6
         oMGLYr+0NiAr1G6ifHfqPuac8PAVXO5Y2cQ5q2ZHCMxVLrdPgHrEmpB1FK4j0rN7BS1D
         rDqpHuSxqD8qEie+sg7Yx4sGausqVeWuNYwSTD6N1PYqhpqWBj/S+1iQyDdnFI9Kbmkv
         bEyU/H4iqP1HXcj0lvaAcJIdybfA2PBcHUBV11za2onDmImz65sRV6vA/tRvuup2hCD0
         ZbxQ22LMivHLfqx1iIoyn3VKBbnlL3MSM7AGzwqm+1k5p1UnUI6YBxG3DaRN0ziMkSpG
         ju8g==
X-Gm-Message-State: AAQBX9eEWyyow6ujmJCf0cMj+ehQp/QVqZZB2t7aOF/+LCL21JMEWEK7
        cyksbWvqNxgBXybzxtFlR4SKGXAqmcI=
X-Google-Smtp-Source: AKy350bImdjl+jIQnSG93LBi6Y2oiNc6MtUjjKPQ6gJJ738vcugTOzT9YS3EOcXJfANg/8cg5+bGvQ==
X-Received: by 2002:a05:6871:54c:b0:184:95:b822 with SMTP id t12-20020a056871054c00b001840095b822mr1593875oal.25.1682009711013;
        Thu, 20 Apr 2023 09:55:11 -0700 (PDT)
Received: from grumpy-VECTOR.hsd1.tx.comcast.net ([2601:2c3:480:7390:d090:9746:e449:eb46])
        by smtp.gmail.com with ESMTPSA id s129-20020a4a5187000000b005252e5b6604sm791913ooa.36.2023.04.20.09.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 09:55:10 -0700 (PDT)
From:   Jorge Lopez <jorgealtxwork@gmail.com>
X-Google-Original-From: Jorge Lopez <jorge.lopez2@hp.com>
To:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de
Subject: [PATCH v11 12/14] HP BIOSCFG driver - surestart-attributes
Date:   Thu, 20 Apr 2023 11:54:52 -0500
Message-Id: <20230420165454.9517-13-jorge.lopez2@hp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230420165454.9517-1-jorge.lopez2@hp.com>
References: <20230420165454.9517-1-jorge.lopez2@hp.com>
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
index 000000000000..72952758ffe3
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
+#define LOG_MAX_ENTRIES		254
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
+static struct kobj_attribute sure_start_audit_log_entries = __ATTR_RO(audit_log_entries);
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

