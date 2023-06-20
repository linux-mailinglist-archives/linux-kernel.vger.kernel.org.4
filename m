Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D337377C9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 01:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjFTXCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 19:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjFTXB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 19:01:58 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2191219B;
        Tue, 20 Jun 2023 16:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687302117; x=1718838117;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xOPnzUp7CuyZvBUd8tWM9+6hiuInfL7osBFcWmep3ps=;
  b=MBxu0Dx/VUkKp4R3Rvvzj87gxGZTqQNnDnNp4FtuM7L5seGwC1oCiReQ
   vb5DMq+HZKlqHw2yViDdxsOn0utIUd032tH0U447jZCieUrZdvJuwuhbS
   PTsVFj6kCP9KTXfjSl2B1IIgepkXVTozlNb5yrONwRjXiOM0+h6/L6i4+
   0av8JZ/Kkolg5zxY6pp51o2qs3V83B/HyeeEwO0wPW9nOGl31wkiRimcv
   htcdwM1kFIw2VuZLfTne1gqAbCXdIMCg+r3+5iIefZcEfjdA8T8Kp5et8
   h94AUY3Z9wTRYCN9vro+SKKZEIAjYlbzRJjIJ+cCekJJIXt9uRP++DZFH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="340347306"
X-IronPort-AV: E=Sophos;i="6.00,258,1681196400"; 
   d="scan'208";a="340347306"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 16:01:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="1044465342"
X-IronPort-AV: E=Sophos;i="6.00,258,1681196400"; 
   d="scan'208";a="1044465342"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by fmsmga005.fm.intel.com with ESMTP; 20 Jun 2023 16:01:55 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 7/7] selftests/thermel/intel: Add test to read workload hint
Date:   Tue, 20 Jun 2023 16:01:50 -0700
Message-Id: <20230620230150.3068704-8-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230620230150.3068704-1-srinivas.pandruvada@linux.intel.com>
References: <20230620230150.3068704-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some SoCs have in built firmware support to classify current running
workload and pass to OS for making power management decisions.

This test program waits for notification of workload type change
and prints. This program can be used to test this feature and also
allows other user space programs to use as a reference.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../testing/selftests/thermal/intel/Makefile  |  16 +++
 .../thermal/intel/workload_hint_test.c        | 114 ++++++++++++++++++
 2 files changed, 130 insertions(+)
 create mode 100644 tools/testing/selftests/thermal/intel/Makefile
 create mode 100644 tools/testing/selftests/thermal/intel/workload_hint_test.c

diff --git a/tools/testing/selftests/thermal/intel/Makefile b/tools/testing/selftests/thermal/intel/Makefile
new file mode 100644
index 000000000000..02459e271ef7
--- /dev/null
+++ b/tools/testing/selftests/thermal/intel/Makefile
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0
+ifndef CROSS_COMPILE
+uname_M := $(shell uname -m 2>/dev/null || echo not)
+ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
+
+ifeq ($(ARCH),x86)
+TEST_PROGS := workload_hint_test
+
+all: $(TEST_PROGS)
+
+include ../../lib.mk
+
+clean:
+	rm -fr $(TEST_PROGS)
+endif
+endif
diff --git a/tools/testing/selftests/thermal/intel/workload_hint_test.c b/tools/testing/selftests/thermal/intel/workload_hint_test.c
new file mode 100644
index 000000000000..69a48a8ccbb4
--- /dev/null
+++ b/tools/testing/selftests/thermal/intel/workload_hint_test.c
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+
+#include <stdio.h>
+#include <string.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <poll.h>
+
+#define WORKLOAD_NOTIFICATION_DELAY_ATTRIBUTE "/sys/bus/pci/devices/0000:00:04.0/workload_hint/notification_delay_ms"
+#define WORKLOAD_ENABLE_ATTRIBUTE "/sys/bus/pci/devices/0000:00:04.0/workload_hint/workload_hint_enable"
+#define WORKLOAD_TYPE_INDEX_ATTRIBUTE  "/sys/bus/pci/devices/0000:00:04.0/workload_hint/workload_type_index"
+
+static const char * const workload_types[] = {
+	"idle",
+	"battery_life",
+	"sustained",
+	"bursty",
+	NULL
+};
+
+#define WORKLOAD_TYPE_MAX_INDEX	3
+
+int main(int argc, char **argv) {
+	struct pollfd ufd;
+	char index_str[4];
+	int fd, ret, index;
+	int delay = 0;
+
+	if (argc > 1) {
+		char delay_str[64];
+
+		sscanf(argv[1], "%d", &delay);
+		printf("Setting notification delay to %d ms\n", delay);
+
+		if (delay < 0)
+			exit(1);
+
+		sprintf(delay_str, "%s\n", argv[1]);
+
+		if ((fd = open(WORKLOAD_NOTIFICATION_DELAY_ATTRIBUTE, O_RDWR)) < 0) {
+			perror("Unable to open workload notification delay\n");
+			exit(1);
+		}
+
+		if (write(fd, delay_str, strlen(delay_str)) < 0) {
+			perror("Can't set delay\n");
+			exit(1);
+		}
+
+		close(fd);
+
+	}
+
+	/* Enable feature via sysfs knob */
+	if ((fd = open(WORKLOAD_ENABLE_ATTRIBUTE, O_RDWR)) < 0) {
+		perror("Unable to open workload type feature enable file\n");
+		exit(1);
+	}
+
+	if (write(fd, "1\n", 2) < 0) {
+		perror("Can' enable workload hints\n");
+		exit(1);
+	}
+
+	close(fd);
+
+	while (1) {
+		if ((fd = open(WORKLOAD_TYPE_INDEX_ATTRIBUTE, O_RDONLY)) < 0) {
+			perror("Unable to open workload type file\n");
+			exit(1);
+		}
+
+		if ((lseek(fd, 0L, SEEK_SET)) < 0) {
+			fprintf(stderr, "Failed to set pointer to beginning\n");
+			exit(1);
+		}
+
+		if (read(fd, index_str, sizeof(index_str)) < 0) {
+			fprintf(stderr, "Failed to read from:%s\n",
+			WORKLOAD_TYPE_INDEX_ATTRIBUTE);
+			exit(1);
+		}
+
+		ufd.fd = fd;
+		ufd.events = POLLPRI;
+
+		if ((ret = poll(&ufd, 1, -1)) < 0) {
+			perror("poll error");
+			exit(1);
+		} else if (ret == 0) {
+			printf("Poll Timeout\n");
+		} else {
+			if ((lseek(fd, 0L, SEEK_SET)) < 0) {
+				fprintf(stderr, "Failed to set pointer to beginning\n");
+				exit(1);
+			}
+
+			if (read(fd, index_str, sizeof(index_str)) < 0) {
+				exit(0);
+			}
+
+			sscanf(index_str, "%d", &index);
+			if (index > WORKLOAD_TYPE_MAX_INDEX)
+				printf("Invalid workload type index\n");
+			else
+				printf("workload type:%s\n", workload_types[index]);
+		}
+
+		close(fd);
+	}
+}
-- 
2.38.1

