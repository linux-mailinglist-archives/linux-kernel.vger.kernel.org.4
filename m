Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8EC6D90E7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 09:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236164AbjDFH5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 03:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235974AbjDFH4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 03:56:46 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602D87EE8
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 00:56:42 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id l15-20020a05600c4f0f00b003ef6d684102so19752026wmq.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 00:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680767800; x=1683359800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gNi9s5gsbe8ZjVGEZMnnCOMkzPyfbeqhmcsiMSNwzak=;
        b=jQB72RF1kU2G9Mv2bjPTvKAtczkjUDgx89Jx/89j+1/m+dfFIidmgc/fnI9OIhxtnF
         n3D+940jqaQ1dzjmET4xLHOVouKS1Z1nUckKsYvAojjQQ2dp1h74luglG+4tL8u10zNK
         qvzU/KNnS9ba+bCixZzgRMUoGun3eNMHJh529QG7kdOyLt3jICkEIk+k+xyl3xZcvNWB
         47KAzshbPJfLtxsANfzznHQbPcOvuv06mGsfJAmNRWx+MoaVJWFvk+zqMFv4WEY5Ulri
         KpCskKuh1ZZIUIWomPOqBOdbUZyx+lYZVQ0J/IOt8FFOdRjT/2d8tViwzi6W7o7mzlQG
         8Z3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680767800; x=1683359800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gNi9s5gsbe8ZjVGEZMnnCOMkzPyfbeqhmcsiMSNwzak=;
        b=qttPiR8uhY01Z3EqWdu1fCzPU0WSCH1z1ueHYwdJOh8Sl4Si6nIdXT7iIybTu/pBx0
         ZBBtjzURylC4UsTA4BvwaXYgj9tBVSbXYlbSKHYoDZke2stAshV6aX1a/vj4ghojuoUv
         QyIycKTpjZNMSLb2IxyNRu8cVozpSJg/zHXWn24oTLb8J8f6xNjo7RgN33T4wC9Qxvz9
         ISo9KSpJKkTApdQEV5FhECgHKOBkdxC2X33P37tpkvp2P8aygacqmBUL+QcDHD+om31+
         SWiQyrCZXZdY0V6eFtFwmYHJFZmY9vL/shSm1T7zqPUyZP0lF5Q6SByxT50At9OHtro3
         UfJg==
X-Gm-Message-State: AAQBX9d8be6hfoG2GZuNrvgvPaIKNt+6tlBRhhUGIxE73uw2L5hLm87e
        kvt+i9A2Luin0A/9qsbsVkUPZQ==
X-Google-Smtp-Source: AKy350YJeINcgkSiFHsUzfuZMGAxe7IIkCg1m4Fm0xCZiGLP73LWn332XVr1GUER7zuKnKfgxQKtow==
X-Received: by 2002:a05:600c:2296:b0:3ed:e4ac:d532 with SMTP id 22-20020a05600c229600b003ede4acd532mr7188353wmf.36.1680767800608;
        Thu, 06 Apr 2023 00:56:40 -0700 (PDT)
Received: from baylibre-ThinkPad-T14s-Gen-2i.. (151.31.102.84.rev.sfr.net. [84.102.31.151])
        by smtp.gmail.com with ESMTPSA id r15-20020a05600c458f00b003f03d483966sm4572651wmo.44.2023.04.06.00.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 00:56:40 -0700 (PDT)
From:   Julien Panis <jpanis@baylibre.com>
To:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, corbet@lwn.net, arnd@arndb.de,
        gregkh@linuxfoundation.org, derek.kiernan@xilinx.com,
        dragan.cvetic@xilinx.com
Cc:     yi.l.liu@intel.com, jgg@ziepe.ca, razor@blackwall.org,
        stephen@networkplumber.org, prabhakar.csengg@gmail.com,
        contact@emersion.fr, macro@orcam.me.uk, dsahern@kernel.org,
        alex.williamson@redhat.com, akrowiak@linux.ibm.com,
        mark.rutland@arm.com, ye.xingchen@zte.com.cn, ojeda@kernel.org,
        keescook@chromium.org, me@kloenk.de, mhiramat@kernel.org,
        milan@mdaverde.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        sterzik@ti.com, u-kumar1@ti.com, eblanc@baylibre.com,
        jneanne@baylibre.com
Subject: [PATCH v6 6/6] samples: Add userspace example for TI TPS6594 PFSM
Date:   Thu,  6 Apr 2023 09:56:22 +0200
Message-Id: <20230406075622.8990-7-jpanis@baylibre.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230406075622.8990-1-jpanis@baylibre.com>
References: <20230406075622.8990-1-jpanis@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
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
index 30ef8bd48ba3..f23aa60a74cf 100644
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
index 7cb632ef88ee..231e45d7ed70 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -31,6 +31,7 @@ obj-$(CONFIG_VIDEO_PCI_SKELETON)	+= v4l/
 obj-y					+= vfio-mdev/
 subdir-$(CONFIG_SAMPLE_VFS)		+= vfs
 obj-$(CONFIG_SAMPLE_INTEL_MEI)		+= mei/
+obj-$(CONFIG_SAMPLE_TPS6594_PFSM)	+= pfsm/
 subdir-$(CONFIG_SAMPLE_WATCHDOG)	+= watchdog
 subdir-$(CONFIG_SAMPLE_WATCH_QUEUE)	+= watch_queue
 obj-$(CONFIG_DEBUG_KMEMLEAK_TEST)	+= kmemleak/
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

