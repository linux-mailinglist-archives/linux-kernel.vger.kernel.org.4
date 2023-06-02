Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFE47202C5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 15:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235866AbjFBNLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 09:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236063AbjFBNLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 09:11:23 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6FF0E6B;
        Fri,  2 Jun 2023 06:11:03 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6af86627460so1908843a34.1;
        Fri, 02 Jun 2023 06:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685711463; x=1688303463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wENMhZEUKQoXANDT/rq1tLQ+DSTMyGsBS/qf3ADAcCs=;
        b=I44RzOw2tbwDqTnLw3HDaFA+1oD8TrEvDltU5Jd04njsCC9KnMZyAqsogTp2AgydhY
         Pt02P0i9ERi7VklW7tBl4tNXyfbwKEkXBaSMmAn21r28QAzkxielT7JZsDgj+S+OGXl7
         pRdtZdIQmh5ulpqvcxR3DkSZABfhFIBXVNJZGRHEuV8WH9zliURKVZPdGwDCGUzyGbJq
         SiHva2vH/nJ8o8+dYIGP+oKFT412zTc0PCjiBN260T+mZytg1WbnbVdkDrrfRvwZhjc2
         EtPLkkHJ5AdujCml/FTqu0w/RsYg1ZfXf7GSTODhKSX85da9HxGmkQwEROuN3Hsj7uyU
         Heww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685711463; x=1688303463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wENMhZEUKQoXANDT/rq1tLQ+DSTMyGsBS/qf3ADAcCs=;
        b=YppC73NrP5RDAZDrQBvf+JOILvGnMMFnKN/CsEmT4cwuon0gfPB7OyBDmrwPx148L1
         z0O5qeedQ9UVDPy8wAUmBEIyP6SWLpyfdHE+ylu/NzneclU5Dyof7EFQYw4Jgx+rEuKV
         Z4ZT6SLcPknuw5H7JAO4zPF3LLsNk5bbJ2Dbv3bw9sJhATaWjAsDlQM7DvBbZPcA5qse
         XkphVYMirIDR0E19HDVXcmn5UDxXxDM1njEbxXqg3qnSjfeRtvmGkOAmL+M1QhZFlPs2
         IATFfFg7obkN79F1TMO1V8rLJMfaYw6oBkztiG6yKvzyGqob/gCpT2ZDb3TGARJmwpxk
         hK8A==
X-Gm-Message-State: AC+VfDzxOUXoSxlUnPOQSaTea+iXCnYO7BE7acY/gS2jTMan3iugD2Zu
        r1Rxn7P9WpKHAdx0tPWODR8=
X-Google-Smtp-Source: ACHHUZ4372lQDnEDnbCXVDjjMlpw1wnO0U+2fjy56vHnl3ojMAeV54jQTQnfRqndzvwZCN9r6CMuFA==
X-Received: by 2002:a05:6808:2888:b0:38b:c4e0:a23 with SMTP id eu8-20020a056808288800b0038bc4e00a23mr2115053oib.57.1685711462920;
        Fri, 02 Jun 2023 06:11:02 -0700 (PDT)
Received: from grumpy-VECTOR.hsd1.tx.comcast.net ([2601:2c3:480:7390:125c:6b6d:18e9:9361])
        by smtp.gmail.com with ESMTPSA id k17-20020a544691000000b0039a531d9b92sm483762oic.56.2023.06.02.06.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 06:11:02 -0700 (PDT)
From:   Jorge Lopez <jorgealtxwork@gmail.com>
X-Google-Original-From: Jorge Lopez <jorge.lopez2@hp.com>
To:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v16 12/13] hp-bioscfg: Makefile
Date:   Fri,  2 Jun 2023 08:10:43 -0500
Message-Id: <20230602131044.3297-13-jorge.lopez2@hp.com>
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

