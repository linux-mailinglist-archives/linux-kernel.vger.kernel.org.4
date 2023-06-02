Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E57A97202BE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 15:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235394AbjFBNLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 09:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235982AbjFBNLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 09:11:22 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE32E64;
        Fri,  2 Jun 2023 06:11:02 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-38dec65ab50so1752456b6e.2;
        Fri, 02 Jun 2023 06:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685711462; x=1688303462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nyFMP/6OFZeTM83vwUJOErQ+JrxpPbaie3LCiQYLuP4=;
        b=feT5lNUxSEH+bCr6Q51VRZkwai/OZbg+Fl1e7/Q1ErKEpHTzoKaaOGdOYFleJXUsas
         eHb6+wfRpnurqvCYuPRsinek4Y1tvrizCp9XSQ//o1CEA4lUyH31Pl+mXV2W9YvCHpd9
         Dd2Ci3HgzFXW7kqq2wJZRyprE22CBI0DewRWVPA9G7aM3ZrQslqtK3vXxl110xaacagx
         Yb2a9AGyS4p2J74Xv5OvTB64q2a95q08sQf4nMEjoxxWZCqb19iRM0xxGF5tVOnGGFSh
         7Vo9tCS9SfEjZU8dj6SQOhdq9a60Kwq9VToYRcjhhmGYXnqWRxvLrXI9v3kdllpxATfu
         JBkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685711462; x=1688303462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nyFMP/6OFZeTM83vwUJOErQ+JrxpPbaie3LCiQYLuP4=;
        b=hyLko9+9eXdNLi1L+oTEb7NiM1tbDgG4sOga+o6isp9lVDKZjJ/GFW4aeMn03btim9
         5sMAhEOgdoirXapN203/uPJqRRNA6TNvhr2WjIbUR1szYA9QSsyNHs0VZuyLho/drTWy
         eeTLOt/nUVV0641TT2MgKaWiiIuOMvpBSeXpDE2lHo5WK78dxdaj1HT9XJ+DN0aUmG9c
         cZMFu6n/SBQsZ9aaC0zXy7PaNtxzduvOY1/XWkfiC7qpTyXTTXw2o4H9Z5Ydm/aHP+VR
         O8flqb6Kds9dXR2QG9nrZOiJLn+TvzheIkGrc7NKi1fXdrKJZzDM4/N0gZlnQds94xr2
         iTrw==
X-Gm-Message-State: AC+VfDxPVWLvdQ1KJtR7bV2hpxRUshZYD44bcdG4Yq++xpwac3nJBcAn
        v4Rb0WH6cBTLHEff1hiCjR89lTQtGm8=
X-Google-Smtp-Source: ACHHUZ7kHFN8yyzl5bIcquQFF1odFyQCTn6YoRfnwc1eJ8+Ea+IykYjtv+ZLhezD7GV3Ffl/1CEydw==
X-Received: by 2002:aca:1a01:0:b0:398:f740:631e with SMTP id a1-20020aca1a01000000b00398f740631emr2009541oia.16.1685711461858;
        Fri, 02 Jun 2023 06:11:01 -0700 (PDT)
Received: from grumpy-VECTOR.hsd1.tx.comcast.net ([2601:2c3:480:7390:125c:6b6d:18e9:9361])
        by smtp.gmail.com with ESMTPSA id k17-20020a544691000000b0039a531d9b92sm483762oic.56.2023.06.02.06.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 06:11:01 -0700 (PDT)
From:   Jorge Lopez <jorgealtxwork@gmail.com>
X-Google-Original-From: Jorge Lopez <jorge.lopez2@hp.com>
To:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v16 11/13] hp-bioscfg: surestart-attributes
Date:   Fri,  2 Jun 2023 08:10:42 -0500
Message-Id: <20230602131044.3297-12-jorge.lopez2@hp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230602131044.3297-1-jorge.lopez2@hp.com>
References: <20230602131044.3297-1-jorge.lopez2@hp.com>
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
 .../x86/hp/hp-bioscfg/surestart-attributes.c  | 132 ++++++++++++++++++
 1 file changed, 132 insertions(+)
 create mode 100644 drivers/platform/x86/hp/hp-bioscfg/surestart-attributes.c

diff --git a/drivers/platform/x86/hp/hp-bioscfg/surestart-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/surestart-attributes.c
new file mode 100644
index 000000000000..b57e42f29282
--- /dev/null
+++ b/drivers/platform/x86/hp/hp-bioscfg/surestart-attributes.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Functions corresponding to sure start object type attributes under
+ * BIOS for use with hp-bioscfg driver
+ *
+ * Copyright (c) 2022 HP Development Company, L.P.
+ */
+
+#include "bioscfg.h"
+#include <linux/types.h>
+
+/* Maximum number of log entries supported when log entry size is 16
+ * bytes. This value is calculated by dividing 4096 (page size) by
+ * log entry size.
+ */
+#define LOG_MAX_ENTRIES		254
+
+/*
+ * Current Log entry size. This value size will change in the
+ * future. The driver reads a total of 128 bytes for each log entry
+ * provided by BIOS but only the first 16 bytes are used/read.
+ */
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
+	u8 audit_log_buffer[128];
+
+	// Get the number of event logs
+	ret = hp_wmi_perform_query(HPWMI_SURESTART_GET_LOG_COUNT,
+				   HPWMI_SURESTART,
+				   &count, 1, sizeof(count));
+
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * The show() api will not work if the audit logs ever go
+	 * beyond 4KB
+	 */
+	if (count * LOG_ENTRY_SIZE > PAGE_SIZE)
+		return -EIO;
+
+	/*
+	 * We are guaranteed the buffer is 4KB so today all the event
+	 * logs will fit
+	 */
+	for (i = 0; i < count; i++) {
+		audit_log_buffer[0] = i + 1;
+
+		/*
+		 * read audit log entry at a time. 'buf' input value
+		 * provides the audit log entry to be read. On
+		 * input, Byte 0 = Audit Log entry number from
+		 * beginning (1..254)
+		 * Entry number 1 is the newest entry whereas the
+		 * highest entry number (number of entries) is the
+		 * oldest entry.
+		 */
+		ret = hp_wmi_perform_query(HPWMI_SURESTART_GET_LOG,
+					   HPWMI_SURESTART,
+					   audit_log_buffer, 1, 128);
+
+		if (ret < 0 || (LOG_ENTRY_SIZE * i) > PAGE_SIZE) {
+			/*
+			 * Encountered a failure while reading
+			 * individual logs. Only a partial list of
+			 * audit log will be returned.
+			 */
+			break;
+		} else {
+			memcpy(buf, audit_log_buffer, LOG_ENTRY_SIZE);
+			buf += LOG_ENTRY_SIZE;
+		}
+	}
+
+	return i * LOG_ENTRY_SIZE;
+}
+
+static struct kobj_attribute sure_start_audit_log_entry_count = __ATTR_RO(audit_log_entry_count);
+static struct kobj_attribute sure_start_audit_log_entries = __ATTR_RO(audit_log_entries);
+
+static struct attribute *sure_start_attrs[] = {
+	&sure_start_audit_log_entry_count.attr,
+	&sure_start_audit_log_entries.attr,
+	NULL
+};
+
+static const struct attribute_group sure_start_attr_group = {
+	.attrs = sure_start_attrs,
+};
+
+void hp_exit_sure_start_attributes(void)
+{
+	sysfs_remove_group(bioscfg_drv.sure_start_attr_kobj,
+			   &sure_start_attr_group);
+}
+
+int hp_populate_sure_start_data(struct kobject *attr_name_kobj)
+{
+	bioscfg_drv.sure_start_attr_kobj = attr_name_kobj;
+	return sysfs_create_group(attr_name_kobj, &sure_start_attr_group);
+}
-- 
2.34.1

