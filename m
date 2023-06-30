Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87720743EC6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 17:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbjF3P1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 11:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232819AbjF3P1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 11:27:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD773C24
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 08:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688138749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rGGDOW/9MqaKjCCuoAeyhkddjPlv60nFOxRpD56k1bo=;
        b=H0L/nkTpTx+ltJts17I1eS9YrdAD+ocoxAilt0XnN+WxxElkhFpluOJ2LjNFpQr1G35Xa9
        naAxxJMA+tsGs3Wc+Svmu1kc2cWU0MP67BRcREvDS7GuR4x00tFWlqmecp/YbjVh3mu/Ao
        NDl0xZu8aLdZ4RVQcKB1feeHq7agXrc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-HzwFi0sIOeazPhXvtt4jyQ-1; Fri, 30 Jun 2023 11:25:46 -0400
X-MC-Unique: HzwFi0sIOeazPhXvtt4jyQ-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-51dd5868fddso2389312a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 08:25:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688138745; x=1690730745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rGGDOW/9MqaKjCCuoAeyhkddjPlv60nFOxRpD56k1bo=;
        b=AXG2Ym8lPZ0UsADMJbdvoROIgKJFG/t1W8+Rb7QSyMcMJkeyBISDxwZcuWFoWecboS
         hd+wvFhUhT8YEE4Y+z2cW7WOjdhuTkMeBhqTWyC2XnhQgkswpIBKTxp1tmRpjEt5PzcN
         3ccD4jkrOS5apkgPe5OIWJxm3dw6Cb5d8Yds1vu+WIqWHd+sfSfWCYK8/8yKy4DQ0YPA
         rNE6VKoS4zCWKtaYVMJRsrYEogKqt/L3mWUgM3iM0euF6j2h3j3wpeV+vooYI+WC2Gec
         JtTSd7tbXmzHuFSrbUxuRvH8eBuQYSE4wcKoKqgecT14Gxcm/UsCi2hbOOibzo7DszyE
         EZJA==
X-Gm-Message-State: ABy/qLabqtk4beuZd9/X/l79eaqDBQq2D60Rjt1WKxB70llCvPjAH4uH
        0YuTdg2JIBvAxYnaTa9cyTUlKbhmTcAcoRQMEfJTB2QPvqe3/ioxMPUGNazHcO33MkX+IvlcbSI
        aYGzsc/nk51bKRtQ8sXHWJG0=
X-Received: by 2002:aa7:c398:0:b0:51d:e2ee:33ff with SMTP id k24-20020aa7c398000000b0051de2ee33ffmr3567015edq.7.1688138745274;
        Fri, 30 Jun 2023 08:25:45 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFXxmvZEGcnejUR+XfxT+Fn8P/5pYATOMHIPPdbQMd40IijySgfCOV/OB4B0eMkCQcsZpst2w==
X-Received: by 2002:aa7:c398:0:b0:51d:e2ee:33ff with SMTP id k24-20020aa7c398000000b0051de2ee33ffmr3567000edq.7.1688138745060;
        Fri, 30 Jun 2023 08:25:45 -0700 (PDT)
Received: from klayman.station (net-2-34-24-242.cust.vodafonedsl.it. [2.34.24.242])
        by smtp.gmail.com with ESMTPSA id k24-20020aa7c398000000b0051def9be785sm813230edq.85.2023.06.30.08.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 08:25:44 -0700 (PDT)
From:   Marco Pagani <marpagan@redhat.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: [PATCH v8 4/4] fpga: add configuration for the FPGA KUnit test suites.
Date:   Fri, 30 Jun 2023 17:25:07 +0200
Message-ID: <20230630152507.30219-5-marpagan@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230630152507.30219-1-marpagan@redhat.com>
References: <20230630152507.30219-1-marpagan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add configuration for the KUnit test suites for the core components
of the FPGA subsystem.

Signed-off-by: Marco Pagani <marpagan@redhat.com>
---
 drivers/fpga/Kconfig            |  2 ++
 drivers/fpga/Makefile           |  3 +++
 drivers/fpga/tests/.kunitconfig |  5 +++++
 drivers/fpga/tests/Kconfig      | 11 +++++++++++
 drivers/fpga/tests/Makefile     |  6 ++++++
 5 files changed, 27 insertions(+)
 create mode 100644 drivers/fpga/tests/.kunitconfig
 create mode 100644 drivers/fpga/tests/Kconfig
 create mode 100644 drivers/fpga/tests/Makefile

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 0a00763b9f28..2f689ac4ba3a 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -276,4 +276,6 @@ config FPGA_MGR_LATTICE_SYSCONFIG_SPI
 	  FPGA manager driver support for Lattice FPGAs programming over slave
 	  SPI sysCONFIG interface.
 
+source "drivers/fpga/tests/Kconfig"
+
 endif # FPGA
diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index 72e554b4d2f7..352a2612623e 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -55,3 +55,6 @@ obj-$(CONFIG_FPGA_DFL_NIOS_INTEL_PAC_N3000)	+= dfl-n3000-nios.o
 
 # Drivers for FPGAs which implement DFL
 obj-$(CONFIG_FPGA_DFL_PCI)		+= dfl-pci.o
+
+# KUnit tests
+obj-$(CONFIG_FPGA_KUNIT_TESTS)		+= tests/
diff --git a/drivers/fpga/tests/.kunitconfig b/drivers/fpga/tests/.kunitconfig
new file mode 100644
index 000000000000..a1c2a2974c39
--- /dev/null
+++ b/drivers/fpga/tests/.kunitconfig
@@ -0,0 +1,5 @@
+CONFIG_KUNIT=y
+CONFIG_FPGA=y
+CONFIG_FPGA_REGION=y
+CONFIG_FPGA_BRIDGE=y
+CONFIG_FPGA_KUNIT_TESTS=y
diff --git a/drivers/fpga/tests/Kconfig b/drivers/fpga/tests/Kconfig
new file mode 100644
index 000000000000..e4a64815f16d
--- /dev/null
+++ b/drivers/fpga/tests/Kconfig
@@ -0,0 +1,11 @@
+config FPGA_KUNIT_TESTS
+	tristate "KUnit test for the FPGA subsystem" if !KUNIT_ALL_TESTS
+	depends on FPGA && FPGA_REGION && FPGA_BRIDGE && KUNIT=y
+	default KUNIT_ALL_TESTS
+        help
+          This builds unit tests for the FPGA subsystem
+
+          For more information on KUnit and unit tests in general,
+          please refer to the KUnit documentation in Documentation/dev-tools/kunit/.
+
+          If unsure, say N.
diff --git a/drivers/fpga/tests/Makefile b/drivers/fpga/tests/Makefile
new file mode 100644
index 000000000000..bb78215c645c
--- /dev/null
+++ b/drivers/fpga/tests/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for KUnit test suites for the FPGA subsystem
+#
+
+obj-$(CONFIG_FPGA_KUNIT_TESTS) += fpga-mgr-test.o fpga-bridge-test.o fpga-region-test.o
-- 
2.41.0

