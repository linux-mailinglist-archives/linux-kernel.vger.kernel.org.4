Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8392F717C82
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 11:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235761AbjEaJzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 05:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235704AbjEaJzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 05:55:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CD0132
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 02:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685526882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t8p5As54IODAWEuMUBGCZ69QipPSMaA1FAFPHeV+xLY=;
        b=BnbfF8JprJkw67XN/uH56bW4OI5CgPvTRwgPpSyMsC/nKUaGX3/4AmgaLRlbPyFhZmHE9N
        4It05ywHAgxO/QbRb20pys9wo9nPNdsUtsyMsQ3DtWIaTlzUZqzsfcxP0skFkHatZ0/QVq
        72/xT4X450GN8I5BzfFTryRN/iGwBRs=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-hPG0GQgiN0aBltTDpoj9VQ-1; Wed, 31 May 2023 05:54:41 -0400
X-MC-Unique: hPG0GQgiN0aBltTDpoj9VQ-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-75b67a4f16aso418190885a.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 02:54:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685526880; x=1688118880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t8p5As54IODAWEuMUBGCZ69QipPSMaA1FAFPHeV+xLY=;
        b=Jv+wWd1b2D3tvgj8VkUxkhEI0Iu8tpEiuvinMNPkNW3IJLgw1laDJpD9deAq1E2kXp
         fVuQGCkXjVZOliNB3fMtfrQE8bdIRf/T4Upe1f8KdTiowxv4Rl5NtAvkgDsfLwBx51hG
         U7x6nlSMAL5uo4lm405BzIcHMhI0urenUD8MRlZZR2Y5QcNli32wF8l+ILru/ZCZFYL1
         K2cjzyqCQord2pUaOE6VB18AnOp9SrjNAQ3jHHIAB2ATP927/QP7EVyVsAF9CKDIqq4T
         Fuh2iBwJD/6PGoKrswMo6NXt+tv/m8SDqbkMyvxhcUnJtt17JtegmAJMS9smfJWMNIMl
         gdiw==
X-Gm-Message-State: AC+VfDzCeK7ZP2FFTS1wT7NXQfv97A7//g5hcxoDzC98UOt66k1EzaFS
        Pi3W/Ei/GP+sbJpWug1w2vYEBmyDl9BJ7BjSN88TdCBamHn4t68AQd+xqZTY6/hfKqaf64+ycv5
        batOLup7gXHxaUtLYpind4vw2EwlIuf8=
X-Received: by 2002:a05:620a:4481:b0:75b:23a0:e7cc with SMTP id x1-20020a05620a448100b0075b23a0e7ccmr6788999qkp.45.1685526880645;
        Wed, 31 May 2023 02:54:40 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6btEUgAGW57fh8lfK7D9Rww+Idw1YOrqlgxEjca9xiHjbnfhPZLBevKQ1JKsPq43k04SQ8JA==
X-Received: by 2002:a05:620a:4481:b0:75b:23a0:e7cc with SMTP id x1-20020a05620a448100b0075b23a0e7ccmr6788987qkp.45.1685526880422;
        Wed, 31 May 2023 02:54:40 -0700 (PDT)
Received: from klayman.redhat.com (net-2-34-28-169.cust.vodafonedsl.it. [2.34.28.169])
        by smtp.gmail.com with ESMTPSA id k25-20020a05620a139900b0074def53eca5sm4902404qki.53.2023.05.31.02.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 02:54:40 -0700 (PDT)
From:   Marco Pagani <marpagan@redhat.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: [RFC PATCH v6 4/4] fpga: add configuration for the KUnit test suites.
Date:   Wed, 31 May 2023 11:54:05 +0200
Message-Id: <20230531095405.342080-5-marpagan@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230531095405.342080-1-marpagan@redhat.com>
References: <20230531095405.342080-1-marpagan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Marco Pagani <marpagan@redhat.com>
---
 drivers/fpga/Kconfig            |  2 ++
 drivers/fpga/Makefile           |  3 +++
 drivers/fpga/tests/.kunitconfig |  5 +++++
 drivers/fpga/tests/Kconfig      | 11 +++++++++++
 drivers/fpga/tests/Makefile     |  5 +++++
 5 files changed, 26 insertions(+)
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
index 000000000000..faa5fa230ab0
--- /dev/null
+++ b/drivers/fpga/tests/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_FPGA_KUNIT_TESTS) += fpga-mgr-test.o
+obj-$(CONFIG_FPGA_KUNIT_TESTS) += fpga-bridge-test.o
+obj-$(CONFIG_FPGA_KUNIT_TESTS) += fpga-region-test.o
-- 
2.40.1

