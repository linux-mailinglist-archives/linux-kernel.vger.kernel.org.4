Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C1F73351E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 17:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346118AbjFPPpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 11:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346109AbjFPPpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 11:45:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ECE8359D
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 08:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686930293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DLxKEahzszph04pP7LNvqbtOeyVOwQumdUKeU8imaG0=;
        b=aQ84qE93pQ9w9q5r/0ci9Gkcm2VpO4I+cuzFzZzs99W26fjRk/4azZnQKgnvfhRieG+sUM
        9CCBb4njqwd/lgWLFRxgUybIM9fp8afvgwanmAWIJNuERv4EHKzvfaQZqn/ZK+1lLMbadh
        rLFr+fdDKqJNoNEyL/Lzlw1/6Ql1er8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-51t3TrQNM7GvWbulLT-mlQ-1; Fri, 16 Jun 2023 11:44:52 -0400
X-MC-Unique: 51t3TrQNM7GvWbulLT-mlQ-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-762225d3df8so82172885a.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 08:44:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686930292; x=1689522292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DLxKEahzszph04pP7LNvqbtOeyVOwQumdUKeU8imaG0=;
        b=I9N41MpJ4cA7jluYRNLAbBBqbG2tKGkwtmCbvZ0rQAbk5IKFiDposNAm7KmKKlVYuS
         lK8NYJ+dbE1yi1+P9TRXy66JKZjLw3maS/aHUPix4CHRU/dQIa1JW4476/N7syCfWdL0
         8VoTX5QxxNMxEQjDkg+4Z6z1zxA3mMXcwDMOhj2F+aWocOS+X6zndHYNAAIZCWMw6JDM
         yNKP5FHQFqSxCngLPNZufWuQn9GrVlPmfrsHaZfMq7MsXwlNJmhIoLPEhpaRoJn/Sd+f
         clBHlrMeIu2UB9FtZaeza+Vif1wS10RgW3/lMrLqX079ktLXOxW7cprNr0lDcedwjTOO
         Ox3w==
X-Gm-Message-State: AC+VfDw6V0e6LPhlCO8xj6h3Z4UjF2gLJ97bqmmpdMfqHQbPr7GkmzGM
        oXaqfVKBt05y7aka6corqBXAq67JNXEA8gB93mdnpobt9zlYjzaDDG56tWj0LiKkIcudUDl/NR1
        092dw9WUtFi45hCtYsoCHX0Y=
X-Received: by 2002:a05:620a:2910:b0:75e:d264:fdb5 with SMTP id m16-20020a05620a291000b0075ed264fdb5mr2361403qkp.24.1686930291895;
        Fri, 16 Jun 2023 08:44:51 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6Bjdq1H5v2oXi7Crxi6Vc1bnEVTjwJ/KPh97ESWzct/YGwWUNWKNELPjwCPGFsi/pQ7eUbug==
X-Received: by 2002:a05:620a:2910:b0:75e:d264:fdb5 with SMTP id m16-20020a05620a291000b0075ed264fdb5mr2361388qkp.24.1686930291661;
        Fri, 16 Jun 2023 08:44:51 -0700 (PDT)
Received: from klayman.redhat.com (net-2-34-28-201.cust.vodafonedsl.it. [2.34.28.201])
        by smtp.gmail.com with ESMTPSA id 27-20020a05620a079b00b007607ecd58ecsm4436931qka.59.2023.06.16.08.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 08:44:51 -0700 (PDT)
From:   Marco Pagani <marpagan@redhat.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: [PATCH v7 4/4] fpga: add configuration for the FPGA KUnit test suites.
Date:   Fri, 16 Jun 2023 17:44:05 +0200
Message-Id: <20230616154405.220502-5-marpagan@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230616154405.220502-1-marpagan@redhat.com>
References: <20230616154405.220502-1-marpagan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
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

