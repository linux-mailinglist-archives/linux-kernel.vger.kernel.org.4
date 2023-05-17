Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6D2706D4F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 17:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbjEQPvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 11:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbjEQPu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 11:50:59 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6BAAD18;
        Wed, 17 May 2023 08:50:44 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1926e90d257so408206fac.0;
        Wed, 17 May 2023 08:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684338644; x=1686930644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wENMhZEUKQoXANDT/rq1tLQ+DSTMyGsBS/qf3ADAcCs=;
        b=TMcVkiXalyBHHzpkrZz2EV3IhbWjStKe3R3cyU/2J/zfxVbucAyTf2WtlD9CGTA/9U
         kemo8+8z3Oo/uAuq1oDLddVEmzbrIUpbDZJJg3a7ZTOSh5go6GxWzCmastLZkIAFOSBg
         lm10ak+HgIEAP8DBmxYJZQNAtwjoFWz0/fMp9sJ1BPebwVHZ1TbygGc42687+CLWwMUL
         //bcmERc3khgJYKd1c5KMYy658UAY4KEd9A/Zaq2wmEphdeVKTMKRv9fYeuX6ni2BgJf
         ub6M6JYgsUIKhIhk0GmLy0cSIk+kFeACuV95BSrpTY9nhdJn1pNPcOkO2UdMJxA8DaIH
         /reQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684338644; x=1686930644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wENMhZEUKQoXANDT/rq1tLQ+DSTMyGsBS/qf3ADAcCs=;
        b=IY7Bjjvr11Z0Wb14WzSTdraclFaQSkt3wCSPK+0RKPOgJd0w+30rPG355Uw+rQNqEf
         M198Fd/qLxWiUfwSi4oaZndMYH+JeHiImQemtkJiP/gHrZsQL4bJ2rKgt9tHiVqGO6I2
         Y2Ys3OXnm/bCbfFRqeLK/LJl/5ROtq8tj84jiug5iKYNkyrq3ysQh5s9v2a3EzbUIECV
         jTUP7xL5K9len0l9KoR05Wio6G0ljVOj6QnfzETkMatKqRCBmfL4eAH0apnK85M8zmrh
         1YTSDm86or468MP/HZzOzuyg5/48i85pRwNlpohTwIcm6Ky19cb2T8+vuJwFMw/dwm31
         wyIg==
X-Gm-Message-State: AC+VfDz3aIF8OFwWkuySyTQQDohIeGNLwgKs4oG9RGqOX6XE2YGImGXT
        8yfajHZRUqp7YiFHfAlXcgc=
X-Google-Smtp-Source: ACHHUZ5WeRikpLsEtdkYljsHlQDBjqyEgtVLYG+moW/fv8q1qe/ox3LENN5390YV377avILBkJwlyQ==
X-Received: by 2002:a05:6870:4293:b0:17a:bf1b:cab8 with SMTP id y19-20020a056870429300b0017abf1bcab8mr23153344oah.4.1684338643908;
        Wed, 17 May 2023 08:50:43 -0700 (PDT)
Received: from grumpy-VECTOR.hsd1.tx.comcast.net ([2601:2c3:480:7390:3754:4771:3b5:e909])
        by smtp.gmail.com with ESMTPSA id j5-20020a056870a48500b0018b12e3a392sm14214468oal.42.2023.05.17.08.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 08:50:43 -0700 (PDT)
From:   Jorge Lopez <jorgealtxwork@gmail.com>
X-Google-Original-From: Jorge Lopez <jorge.lopez2@hp.com>
To:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v14 12/13] hp-bioscfg: Makefile
Date:   Wed, 17 May 2023 10:50:25 -0500
Message-Id: <20230517155026.28535-13-jorge.lopez2@hp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230517155026.28535-1-jorge.lopez2@hp.com>
References: <20230517155026.28535-1-jorge.lopez2@hp.com>
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

