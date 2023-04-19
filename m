Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2B866E7DE4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 17:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233698AbjDSPOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 11:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233526AbjDSPNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 11:13:47 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45827ED9;
        Wed, 19 Apr 2023 08:13:37 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6a5f1503886so772514a34.2;
        Wed, 19 Apr 2023 08:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681917217; x=1684509217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eTgLrtH5EQklN+ftHi/JTGVVI8xgKYuNkrSNqoJEWrE=;
        b=WLP4dLHoxU4eBJVRRVXeCaLL5iJd9ARAjCcscUa0fMdmqO5QPV61mlBhPLCKAxu09O
         M0A+g1IvxPpLnRQa+6GD/ebt5xndFTz17Uq4WkTgXyfihoyLXVtiUIf1nuIgZ/2Ftx+h
         Ot9h9AZEvCHIYtck9iHd/madXblr8UissGk2fbi5DriUrsLTp/NijEhVnkps6Q94PyPo
         o2SHyVUMszWdv29JJJmUU+/y/yPe8tHzxw+C0HdX+gNG4ihMICpwaVGg96+gPLNU29nx
         vtOEgnf0zMPGiFgbOcKerJI5yicx1QCNAmNzedpB1lenEqDsjUMz5maXpsE9L4oWev5O
         JFLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681917217; x=1684509217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eTgLrtH5EQklN+ftHi/JTGVVI8xgKYuNkrSNqoJEWrE=;
        b=XB5RLQhx/vNN6S2rgB4sN70gOXU6UVOF8Ob5xTP/6Qo2CBZ3rrcE/Gck9HX7DctBZw
         aopPfI6q3lj4JUooqpUl5SMR5XY1bOvx5In8xN9in3myHG4NVHdzkamjdCyrdxOautgJ
         qSGV5pojhC1jmWZ9o23UCLtnp8OSmm1zR50+qpu60Ii/raYAp0g8PTK3jOZgM6ecbyml
         gyxBQssxxIxiA3RXe+ifcJCs3zDNOIU1Ang+yhuYsw9yof7ay3bwcxJlrMkDpF5/USWw
         IRDO+OH6ubmSxSIBk+pHpaM/gz4p//ooDitHeFK7zkkbZcox8hLsImUhQ7Dv+LeyI7PD
         2lFQ==
X-Gm-Message-State: AAQBX9eVAJEpfgVg7QELXiLp7Rqm4AjiohViMVU5qU7kpjm/pS8Fu3rE
        +Uo2yK3A04pWdynFjj9lKN4=
X-Google-Smtp-Source: AKy350Yhl+Y1aTB0uT29Zj+6xlB5jy/bFDNDVYh1sr+dREtJaRNH6irFJ8Hm1HU+VjasgP5Gygd5vg==
X-Received: by 2002:a05:6830:45a:b0:68f:2134:9a3a with SMTP id d26-20020a056830045a00b0068f21349a3amr2944217otc.30.1681917216973;
        Wed, 19 Apr 2023 08:13:36 -0700 (PDT)
Received: from grumpy-VECTOR.hsd1.tx.comcast.net ([2601:2c3:480:7390:e175:6963:338:7453])
        by smtp.gmail.com with ESMTPSA id f17-20020a056830205100b00690e990e61asm4308842otp.14.2023.04.19.08.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 08:13:36 -0700 (PDT)
From:   Jorge Lopez <jorgealtxwork@gmail.com>
X-Google-Original-From: Jorge Lopez <jorge.lopez2@hp.com>
To:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de
Subject: [PATCH v10 10/14] HP BIOSCFG driver  - passwdattr-interface
Date:   Wed, 19 Apr 2023 10:13:17 -0500
Message-Id: <20230419151321.6167-11-jorge.lopez2@hp.com>
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
 .../x86/hp/hp-bioscfg/passwdattr-interface.c  | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 drivers/platform/x86/hp/hp-bioscfg/passwdattr-interface.c

diff --git a/drivers/platform/x86/hp/hp-bioscfg/passwdattr-interface.c b/drivers/platform/x86/hp/hp-bioscfg/passwdattr-interface.c
new file mode 100644
index 000000000000..02fc766eb3cf
--- /dev/null
+++ b/drivers/platform/x86/hp/hp-bioscfg/passwdattr-interface.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Functions corresponding to SET password methods under
+ * HP_WMI_SET_BIOS_SETTING_GUID for use with hp-bioscfg driver.
+ *
+ * Copyright (c) 2022 Hewlett-Packard Inc.
+ */
+
+#include <linux/wmi.h>
+#include "bioscfg.h"
+
+static int bios_attr_pass_interface_probe(struct wmi_device *wdev,
+					  const void *context)
+{
+	mutex_lock(&bioscfg_drv.mutex);
+	bioscfg_drv.password_attr_wdev = wdev;
+	mutex_unlock(&bioscfg_drv.mutex);
+	return 0;
+}
+
+static void bios_attr_pass_interface_remove(struct wmi_device *wdev)
+{
+	mutex_lock(&bioscfg_drv.mutex);
+	bioscfg_drv.password_attr_wdev = NULL;
+	mutex_unlock(&bioscfg_drv.mutex);
+}
+
+static const struct wmi_device_id bios_attr_pass_interface_id_table[] = {
+	{ .guid_string = HP_WMI_SET_BIOS_SETTING_GUID },
+	{ },
+};
+static struct wmi_driver bios_attr_pass_interface_driver = {
+	.driver = {
+		.name = DRIVER_NAME"-password"
+	},
+	.probe = bios_attr_pass_interface_probe,
+	.remove = bios_attr_pass_interface_remove,
+	.id_table = bios_attr_pass_interface_id_table,
+};
+
+int init_bios_attr_pass_interface(void)
+{
+	return wmi_driver_register(&bios_attr_pass_interface_driver);
+}
+
+void exit_bios_attr_pass_interface(void)
+{
+	wmi_driver_unregister(&bios_attr_pass_interface_driver);
+}
+
+MODULE_DEVICE_TABLE(wmi, bios_attr_pass_interface_id_table);
-- 
2.34.1

