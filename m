Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 213737040AB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 00:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343562AbjEOWDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 18:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245711AbjEOWCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 18:02:46 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0081640CE;
        Mon, 15 May 2023 15:01:38 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3942cd86697so3371917b6e.0;
        Mon, 15 May 2023 15:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684188077; x=1686780077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wENMhZEUKQoXANDT/rq1tLQ+DSTMyGsBS/qf3ADAcCs=;
        b=a/0V3f9WK+WxJkvHE/0DTeMYQx+uTrnb2dpz/cPsFEhKjWOGnN29JuTlt8MOwpBsi8
         3s9kfra+oKjnQ2gUAUk4jiadJE3EUlpZWtrymhxLJ7YxEaU3xo5EcChaPAGU9j1UmQHG
         nuTWNFlL35dYz9EPJxGhcxT5fuesBUtxlSHW5aHDyrQ9QjtGtmlIoZAm6uKCvYS96b8v
         l7JSAqhmQpHb7oqJKvB+mtjdI1ZPyGGRycfyGJK0q2zALV8DVM6NdkmtAcp9ctBdgAnc
         YVPFDFQvtbvtmPTVIOM7FrPFgj0gHxpBELfqptvZtZuG94XY+m6VNltXXRfjwEyheYFq
         P46Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684188077; x=1686780077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wENMhZEUKQoXANDT/rq1tLQ+DSTMyGsBS/qf3ADAcCs=;
        b=aU+RiuKqCW3MUNfuOo4aIupRIudnBfdpqztDEZnN+0BM1p9HUk795UbvhX95DH3CHe
         ECXCqF0D23kjbYF27W4xARzv9XYvrYVxqVD71Q3r0eP5Dyeo2y664Hu715Uk88WTrll0
         tvSLoGhiKaawSy4eXNwknlvHlwX6MKRv4+wlhyApMcx7fxfhyHP+z23zz5hlmt5Fa5YT
         /r+FVWBZYb99D1+4FiFTpJnz+CmPe3xxi9MMVEvLq6/zQu8b76WaCJlO4nEZIq1TxJYS
         +zKZaIlPukucSIOHMRz3LgZOfNuoRiiwq4eoRwZarM2L6hBZInvhXeoK3+fZ6G5KZhOI
         3PUg==
X-Gm-Message-State: AC+VfDz1OPfruv6xQp09Km4Cuo1xy9auBuSIqO4hughMlurQ46Rf+4cI
        9GC9DRcoNfuSoznQjpM9EVL0eFSceko=
X-Google-Smtp-Source: ACHHUZ7IbjN4rfopNyVhrA7vaQLej8KAYGURbwE6nRMvFa7jRXolmsGgwDnC+BCSdTWpBCLeYkY4ow==
X-Received: by 2002:a54:448b:0:b0:38e:54da:9173 with SMTP id v11-20020a54448b000000b0038e54da9173mr11881690oiv.29.1684188076796;
        Mon, 15 May 2023 15:01:16 -0700 (PDT)
Received: from grumpy-VECTOR.hsd1.tx.comcast.net ([2601:2c3:480:7390:5391:4539:59c2:4092])
        by smtp.gmail.com with ESMTPSA id i1-20020aca0c41000000b0038e07fe2c97sm5265148oiy.42.2023.05.15.15.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 15:01:16 -0700 (PDT)
From:   Jorge Lopez <jorgealtxwork@gmail.com>
X-Google-Original-From: Jorge Lopez <jorge.lopez2@hp.com>
To:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v13 12/13] hp-bioscfg: Makefile
Date:   Mon, 15 May 2023 17:01:00 -0500
Message-Id: <20230515220101.39794-13-jorge.lopez2@hp.com>
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
 drivers/platform/x86/hp/Kconfig             | 16 ++++++++++++++++
 drivers/platform/x86/hp/Makefile            |  1 +
 drivers/platform/x86/hp/hp-bioscfg/Makefile | 11 +++++++++++
 3 files changed, 28 insertions(+)
 create mode 100644 drivers/platform/x86/hp/hp-bioscfg/Makefile

diff --git a/drivers/platform/x86/hp/Kconfig b/drivers/platform/x86/hp/Kconfig
index ae165955311c..7fef4f12e498 100644
--- a/drivers/platform/x86/hp/Kconfig
+++ b/drivers/platform/x86/hp/Kconfig
@@ -60,4 +60,20 @@ config TC1100_WMI
 	  This is a driver for the WMI extensions (wireless and bluetooth power
 	  control) of the HP Compaq TC1100 tablet.
 
+config HP_BIOSCFG
+	tristate "HP BIOS Configuration Driver"
+	default m
+	depends on ACPI_WMI
+	select NLS
+	select FW_ATTR_CLASS
+	help
+	  This driver enables administrators to securely manage BIOS settings
+	  using digital certificates and public-key cryptography that eliminate
+	  the need for passwords for both remote and local management. It supports
+	  changing BIOS settings on many HP machines from 2018 and newer without
+	  the use of any additional software.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called hp-bioscfg.
+
 endif # X86_PLATFORM_DRIVERS_HP
diff --git a/drivers/platform/x86/hp/Makefile b/drivers/platform/x86/hp/Makefile
index db1eed4cd7c7..e4f908a61acf 100644
--- a/drivers/platform/x86/hp/Makefile
+++ b/drivers/platform/x86/hp/Makefile
@@ -8,3 +8,4 @@
 obj-$(CONFIG_HP_ACCEL)		+= hp_accel.o
 obj-$(CONFIG_HP_WMI)		+= hp-wmi.o
 obj-$(CONFIG_TC1100_WMI)	+= tc1100-wmi.o
+obj-$(CONFIG_HP_BIOSCFG)	+= hp-bioscfg/
diff --git a/drivers/platform/x86/hp/hp-bioscfg/Makefile b/drivers/platform/x86/hp/hp-bioscfg/Makefile
new file mode 100644
index 000000000000..67be0d917753
--- /dev/null
+++ b/drivers/platform/x86/hp/hp-bioscfg/Makefile
@@ -0,0 +1,11 @@
+obj-$(CONFIG_HP_BIOSCFG) := hp-bioscfg.o
+
+hp-bioscfg-objs := bioscfg.o	\
+	biosattr-interface.o	\
+	enum-attributes.o	\
+	int-attributes.o	\
+	order-list-attributes.o	\
+	passwdobj-attributes.o	\
+	spmobj-attributes.o	\
+	string-attributes.o	\
+	surestart-attributes.o
-- 
2.34.1

