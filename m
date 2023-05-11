Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9045D6FEF5A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 11:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237828AbjEKJwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 05:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237796AbjEKJwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 05:52:13 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79876A5F8
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 02:51:37 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f42ba32e24so20950055e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 02:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1683798696; x=1686390696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cAAyHozi+FY1DFhOlP3pR84DerBKbRpiLaMXvQZxeJU=;
        b=M3EmExDnpVr0yJWuzP7o+7EyACWQRW45VeqPZsDnZ+Jl3SW7uPscDs/m/CbIflCLJV
         CiAoNUM4PXdiOhOo7TFLffPk/o0kljOnCXkL/GoFFhOkI4sUGdMnM7tACqT8Hh2aorPr
         9mQ4/VJd7SL1nMjAgHDSl80lVCuf2pfD78NxwLSYpXkUBx75tXDUSnFaK8A2UKbyYqXd
         vTlP8W8MIyCWYTKib2kufQuEXqujZVrl851jp7Fy0fuuh3QOVjFRvkRTwv+mZoN9N819
         JHxEEMLMHhJzaXsOcTuuPPH8Exdfs89wMhNX8orwmWwazH5NA6YjV7eekDWUWlmcuVAx
         EMAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683798696; x=1686390696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cAAyHozi+FY1DFhOlP3pR84DerBKbRpiLaMXvQZxeJU=;
        b=BcHF15kBjtooAGt4bSMsad1bWGKyQw1dMJRFYjeuUH2wwwiux+gEQDo++8POKFvxGt
         Utw3rQJlZzdKDrOm9Hwg/ti1fJGSPKsSm8UYNpzuSGOMgQGlIP50OtvB0slTH4odt4u3
         oUGQSjqFL/zI9iexAowM4SCy5DsFAAv2DJZFo6YxdAOncgYQM7DrsSSyqSwvH6ix33sg
         KwVuIeCrmIRJA83WNUAURr/iXIjqFXA4BObcis74evE1Mk4AmMJcwRdEiQK4MllTiVYm
         8l53e1bwm1zqoKTGFz5lx3J0S0C2z6g7VmfwLK9wMmCf8Pm32WXrXyEONGSaCsRzdqIS
         /7RA==
X-Gm-Message-State: AC+VfDz7cW9awiCXinbYvFobEkx3QdF01M+qn/DCE1blDElhBC097fof
        W7BsA4+Pmua1+2EXNhEcjsbnJA==
X-Google-Smtp-Source: ACHHUZ5ZcUiyKNgLG2/sgg8gM9MIPJgPvRQ4R9jQYo7hUrMBckoHdgEuc49/kL5Ye25x+2BXNFxzkg==
X-Received: by 2002:a1c:7716:0:b0:3f4:5058:a037 with SMTP id t22-20020a1c7716000000b003f45058a037mr4199962wmi.37.1683798695919;
        Thu, 11 May 2023 02:51:35 -0700 (PDT)
Received: from baylibre-ThinkPad-T14s-Gen-2i.. (120.205.87.79.rev.sfr.net. [79.87.205.120])
        by smtp.gmail.com with ESMTPSA id z9-20020a05600c114900b003f4069417absm22389956wmz.24.2023.05.11.02.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 02:51:35 -0700 (PDT)
From:   Julien Panis <jpanis@baylibre.com>
To:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        corbet@lwn.net, arnd@arndb.de, gregkh@linuxfoundation.org,
        derek.kiernan@xilinx.com, dragan.cvetic@xilinx.com
Cc:     macro@orcam.me.uk, baolu.lu@linux.intel.com, yi.l.liu@intel.com,
        jirislaby@kernel.org, rostedt@goodmis.org, revest@chromium.org,
        gehao@kylinos.cn, akpm@linux-foundation.org, jgg@ziepe.ca,
        razor@blackwall.org, stephen@networkplumber.org,
        prabhakar.csengg@gmail.com, contact@emersion.fr,
        alex.williamson@redhat.com, akrowiak@linux.ibm.com,
        mark.rutland@arm.com, ye.xingchen@zte.com.cn, ojeda@kernel.org,
        me@kloenk.de, milan@mdaverde.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        sterzik@ti.com, u-kumar1@ti.com, eblanc@baylibre.com,
        jneanne@baylibre.com, aseketeli@baylibre.com
Subject: [PATCH v7 6/6] samples: Add userspace example for TI TPS6594 PFSM
Date:   Thu, 11 May 2023 11:51:26 +0200
Message-Id: <20230511095126.105104-7-jpanis@baylibre.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230511095126.105104-1-jpanis@baylibre.com>
References: <20230511095126.105104-1-jpanis@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds an example showing how to use PFSM devices
from a userspace application. The PMIC is armed to be triggered
by a RTC alarm to execute state transition.

Signed-off-by: Julien Panis <jpanis@baylibre.com>
---
 samples/Kconfig            |   6 ++
 samples/Makefile           |   1 +
 samples/pfsm/.gitignore    |   2 +
 samples/pfsm/Makefile      |   4 ++
 samples/pfsm/pfsm-wakeup.c | 125 +++++++++++++++++++++++++++++++++++++
 5 files changed, 138 insertions(+)
 create mode 100644 samples/pfsm/.gitignore
 create mode 100644 samples/pfsm/Makefile
 create mode 100644 samples/pfsm/pfsm-wakeup.c

diff --git a/samples/Kconfig b/samples/Kconfig
index b2db430bd3ff..3edf73a3dc9b 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -253,6 +253,12 @@ config SAMPLE_INTEL_MEI
 	help
 	  Build a sample program to work with mei device.
 
+config SAMPLE_TPS6594_PFSM
+	bool "Build example program working with TPS6594 PFSM driver"
+	depends on HEADERS_INSTALL
+	help
+	  Build a sample program to work with PFSM devices.
+
 config SAMPLE_WATCHDOG
 	bool "watchdog sample"
 	depends on CC_CAN_LINK
diff --git a/samples/Makefile b/samples/Makefile
index 7727f1a0d6d1..0a551c2b33f4 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -31,6 +31,7 @@ obj-$(CONFIG_VIDEO_PCI_SKELETON)	+= v4l/
 obj-y					+= vfio-mdev/
 subdir-$(CONFIG_SAMPLE_VFS)		+= vfs
 obj-$(CONFIG_SAMPLE_INTEL_MEI)		+= mei/
+obj-$(CONFIG_SAMPLE_TPS6594_PFSM)	+= pfsm/
 subdir-$(CONFIG_SAMPLE_WATCHDOG)	+= watchdog
 subdir-$(CONFIG_SAMPLE_WATCH_QUEUE)	+= watch_queue
 obj-$(CONFIG_SAMPLE_KMEMLEAK)		+= kmemleak/
diff --git a/samples/pfsm/.gitignore b/samples/pfsm/.gitignore
new file mode 100644
index 000000000000..f350a030a060
--- /dev/null
+++ b/samples/pfsm/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+/pfsm-wakeup
diff --git a/samples/pfsm/Makefile b/samples/pfsm/Makefile
new file mode 100644
index 000000000000..213e8d9f5dbc
--- /dev/null
+++ b/samples/pfsm/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+userprogs-always-y += pfsm-wakeup
+
+userccflags += -I usr/include
diff --git a/samples/pfsm/pfsm-wakeup.c b/samples/pfsm/pfsm-wakeup.c
new file mode 100644
index 000000000000..299dd9e1f607
--- /dev/null
+++ b/samples/pfsm/pfsm-wakeup.c
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * TPS6594 PFSM userspace example
+ *
+ * Copyright (C) 2023 BayLibre Incorporated - https://www.baylibre.com/
+ *
+ * This example shows how to use PFSMs from a userspace application,
+ * on TI j721s2 platform. The PMIC is armed to be triggered by a RTC
+ * alarm to execute state transition (RETENTION to ACTIVE).
+ */
+
+#include <fcntl.h>
+#include <stdio.h>
+#include <sys/ioctl.h>
+#include <unistd.h>
+
+#include <linux/rtc.h>
+#include <linux/tps6594_pfsm.h>
+
+#define ALARM_DELTA_SEC 30
+
+#define RTC_A "/dev/rtc0"
+
+#define PMIC_NB 3
+#define PMIC_A "/dev/pfsm-0-0x48"
+#define PMIC_B "/dev/pfsm-0-0x4c"
+#define PMIC_C "/dev/pfsm-2-0x58"
+
+static const char * const dev_pfsm[] = {PMIC_A, PMIC_B, PMIC_C};
+
+int main(int argc, char *argv[])
+{
+	int i, ret, fd_rtc, fd_pfsm[PMIC_NB] = { 0 };
+	struct rtc_time rtc_tm;
+	struct pmic_state_opt pmic_opt = { 0 };
+	unsigned long data;
+
+	fd_rtc = open(RTC_A, O_RDONLY);
+	if (fd_rtc < 0) {
+		perror("Failed to open RTC device.");
+		goto out;
+	}
+
+	for (i = 0 ; i < PMIC_NB ; i++) {
+		fd_pfsm[i] = open(dev_pfsm[i], O_RDWR);
+		if (fd_pfsm[i] < 0) {
+			perror("Failed to open PFSM device.");
+			goto out;
+		}
+	}
+
+	/* Read RTC date/time */
+	ret = ioctl(fd_rtc, RTC_RD_TIME, &rtc_tm);
+	if (ret < 0) {
+		perror("Failed to read RTC date/time.");
+		goto out;
+	}
+	printf("Current RTC date/time is %d-%d-%d, %02d:%02d:%02d.\n",
+	       rtc_tm.tm_mday, rtc_tm.tm_mon + 1, rtc_tm.tm_year + 1900,
+	       rtc_tm.tm_hour, rtc_tm.tm_min, rtc_tm.tm_sec);
+
+	/* Set RTC alarm to ALARM_DELTA_SEC sec in the future, and check for rollover */
+	rtc_tm.tm_sec += ALARM_DELTA_SEC;
+	if (rtc_tm.tm_sec >= 60) {
+		rtc_tm.tm_sec %= 60;
+		rtc_tm.tm_min++;
+	}
+	if (rtc_tm.tm_min == 60) {
+		rtc_tm.tm_min = 0;
+		rtc_tm.tm_hour++;
+	}
+	if (rtc_tm.tm_hour == 24)
+		rtc_tm.tm_hour = 0;
+	ret = ioctl(fd_rtc, RTC_ALM_SET, &rtc_tm);
+	if (ret < 0) {
+		perror("Failed to set RTC alarm.");
+		goto out;
+	}
+
+	/* Enable alarm interrupts */
+	ret = ioctl(fd_rtc, RTC_AIE_ON, 0);
+	if (ret < 0) {
+		perror("Failed to enable alarm interrupts.");
+		goto out;
+	}
+	printf("Waiting %d seconds for alarm...\n", ALARM_DELTA_SEC);
+
+	/*
+	 * Set RETENTION state with options for PMIC_C/B/A respectively.
+	 * Since PMIC_A is master, it should be the last one to be configured.
+	 */
+	pmic_opt.ddr_retention = 1;
+	for (i = PMIC_NB - 1 ; i >= 0 ; i--) {
+		printf("Set RETENTION state for PMIC_%d.\n", i);
+		sleep(1);
+		ret = ioctl(fd_pfsm[i], PMIC_SET_RETENTION_STATE, &pmic_opt);
+		if (ret < 0) {
+			perror("Failed to set RETENTION state.");
+			goto out_reset;
+		}
+	}
+
+	/* This blocks until the alarm ring causes an interrupt */
+	ret = read(fd_rtc, &data, sizeof(unsigned long));
+	if (ret < 0)
+		perror("Failed to get RTC alarm.");
+	else
+		puts("Alarm rang.\n");
+
+out_reset:
+	ioctl(fd_rtc, RTC_AIE_OFF, 0);
+
+	/* Set ACTIVE state for PMIC_A */
+	ioctl(fd_pfsm[0], PMIC_SET_ACTIVE_STATE, 0);
+
+out:
+	for (i = 0 ; i < PMIC_NB ; i++)
+		if (fd_pfsm[i])
+			close(fd_pfsm[i]);
+
+	if (fd_rtc)
+		close(fd_rtc);
+
+	return 0;
+}
-- 
2.37.3

