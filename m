Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 941DE6E9A12
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 18:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbjDTQzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 12:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjDTQz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 12:55:28 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F2284691;
        Thu, 20 Apr 2023 09:55:09 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-546ec98b2e2so703131eaf.2;
        Thu, 20 Apr 2023 09:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682009708; x=1684601708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eTgLrtH5EQklN+ftHi/JTGVVI8xgKYuNkrSNqoJEWrE=;
        b=RQZ3OgX5w+xtVLaqAVlPgLOaWpIRgRduFTrKGAr4II/N9L1GuqUdpabi2r+NnSjVAh
         FdZ/rNaO5lUwTzzrrMwmfrmgpUeDUE7sSI1+ZR4VHxdkKrhFLe7j6sM1I6GRszySvYnt
         RqrKCh5uyofC+L9XrAEt9ziafbHvCNW87lmOBkvksZ+RgbjZynUpfPeGhr+SnaYFTNWl
         qxeeTAQIuw6LW3qvDjn8q/d6FJmoJole7oC9z1sAcMlWOqh+MGSK5OuwQDYc6QYD4uRJ
         8x7b84yVj8+SXDOev3c384GxlEk13qa1tiHktogfyp+dGwyyzod5qBHI4wx3UxXBm4O5
         AaFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682009708; x=1684601708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eTgLrtH5EQklN+ftHi/JTGVVI8xgKYuNkrSNqoJEWrE=;
        b=FCEBq134ldYJ8FyvBDc9gQNWfX4UmbXEnL18zAPGupxMVQMEhd/AANdq9NaExT4pIr
         1JOuIPbJ1bTqE38LWVppDW/2gziqy84WMyp1Kz/DNNvAAc2ThEzmAdfOmjYu5z2Ow5zC
         zh2hmoUqn8T4ICU0B2JqrZPJrBmyliowb/80r+FG42xwnihqSpX8pp/kMoiE+dg/FG33
         /rMR28cx3Mvnc3Ht+D/PYbyDDC6iYqACrD99KqTHym2wnVDzhzYOa/ETV9gsAOTvQ3Wa
         +hXzpKm2b9s3FFSBa98Hi4w9urv9Att13biP9+SKwdK7yJR2yWJMpnuSGeaaqYSfb/uF
         67HA==
X-Gm-Message-State: AAQBX9fExrdqJZR2gO0o2pBO+shLcsV/wESNVjKaW8IZLYc2VY4d4PiZ
        K4tg5NCpg57j6Meyv/YRaczXJVLoaWo=
X-Google-Smtp-Source: AKy350YADkzlgw6IS/BEZ+HO2h01NrEkDGHNPEAc+Go6YEKx2zNXjZSTqqV0EthqAQrvqw8dxgKAkw==
X-Received: by 2002:a05:6808:9a4:b0:38b:ceab:7de7 with SMTP id e4-20020a05680809a400b0038bceab7de7mr1215322oig.32.1682009708612;
        Thu, 20 Apr 2023 09:55:08 -0700 (PDT)
Received: from grumpy-VECTOR.hsd1.tx.comcast.net ([2601:2c3:480:7390:d090:9746:e449:eb46])
        by smtp.gmail.com with ESMTPSA id s129-20020a4a5187000000b005252e5b6604sm791913ooa.36.2023.04.20.09.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 09:55:08 -0700 (PDT)
From:   Jorge Lopez <jorgealtxwork@gmail.com>
X-Google-Original-From: Jorge Lopez <jorge.lopez2@hp.com>
To:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de
Subject: [PATCH v11 10/14] HP BIOSCFG driver  - passwdattr-interface
Date:   Thu, 20 Apr 2023 11:54:50 -0500
Message-Id: <20230420165454.9517-11-jorge.lopez2@hp.com>
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

