Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A46496C3F35
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 01:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjCVAiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 20:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjCVAiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 20:38:09 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753AD903B;
        Tue, 21 Mar 2023 17:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679445487; x=1710981487;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Jo23zFkwsDwbXcptMJ4++GJBxyXgWzFG3F/uuQmQl5Q=;
  b=gaLcHnpAAbed5hukxpasQuKmRIoCiTSLhsJJl1vFpYT5XPJVPirAr6Mu
   Qz/Ze/s31kSAFnUji9aNwhzFCWHS5zY5Vo1SCiJumLhpECMs7xkyHYEuK
   TwUloyyc2gC7mmDCcKbNJpCzTALweISut7II7+ULgrAM6Uh2HdFMvuAIF
   wGI6rt/XEpUAkXb3EqL5K4n3gZWWasKMDXz3FdikUyTJzCGUEoUBJEpSO
   UvNysFw5mVTGN2YQE7D64HJ+ZgueaTe7idjlC7h56xwbhZhzYUAmUDqlO
   5Hsl1smBfPMO4w9pl5y438AIr354gaEnEyJJaxH+ysdy3wzxTiLR1JFCo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="322934949"
X-IronPort-AV: E=Sophos;i="5.98,280,1673942400"; 
   d="scan'208";a="322934949"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 17:38:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="675076061"
X-IronPort-AV: E=Sophos;i="5.98,280,1673942400"; 
   d="scan'208";a="675076061"
Received: from jithujos.sc.intel.com ([172.25.103.66])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 17:38:06 -0700
From:   Jithu Joseph <jithu.joseph@intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        gregkh@linuxfoundation.org, rostedt@goodmis.org,
        jithu.joseph@intel.com, ashok.raj@intel.com, tony.luck@intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@lists.linux.dev, ravi.v.shankar@intel.com,
        thiago.macieira@intel.com, athenas.jimenez.gonzalez@intel.com,
        sohil.mehta@intel.com
Subject: [PATCH v4 7/9] platform/x86/intel/ifs: Implement Array BIST test
Date:   Tue, 21 Mar 2023 17:33:57 -0700
Message-Id: <20230322003359.213046-8-jithu.joseph@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230322003359.213046-1-jithu.joseph@intel.com>
References: <20230301015942.462799-1-jithu.joseph@intel.com>
 <20230322003359.213046-1-jithu.joseph@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Array BIST test (for a particular core) is triggered by writing
to MSR_ARRAY_BIST from one sibling of the core.

This will initiate a test for all supported arrays on that
CPU. Array BIST test may be aborted before completing all the
arrays in the event of an interrupt or other reasons.
In this case, kernel will restart the test from that point
onwards. Array test will also be aborted when the test fails,
in which case the test is stopped immediately without further
retry.

Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 drivers/platform/x86/intel/ifs/ifs.h     | 12 ++++
 drivers/platform/x86/intel/ifs/runtest.c | 81 ++++++++++++++++++++++++
 2 files changed, 93 insertions(+)

diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
index a7d87fb4c412..048131df13bc 100644
--- a/drivers/platform/x86/intel/ifs/ifs.h
+++ b/drivers/platform/x86/intel/ifs/ifs.h
@@ -127,6 +127,7 @@
 #include <linux/device.h>
 #include <linux/miscdevice.h>
 
+#define MSR_ARRAY_BIST				0x00000105
 #define MSR_COPY_SCAN_HASHES			0x000002c2
 #define MSR_SCAN_HASHES_STATUS			0x000002c3
 #define MSR_AUTHENTICATE_AND_COPY_CHUNK		0x000002c4
@@ -192,6 +193,17 @@ union ifs_status {
 	};
 };
 
+/* MSR_ARRAY_BIST bit fields */
+union ifs_array {
+	u64	data;
+	struct {
+		u32	array_bitmask;
+		u16	array_bank;
+		u16	rsvd			:15;
+		u16	ctrl_result		:1;
+	};
+};
+
 /*
  * Driver populated error-codes
  * 0xFD: Test timed out before completing all the chunks.
diff --git a/drivers/platform/x86/intel/ifs/runtest.c b/drivers/platform/x86/intel/ifs/runtest.c
index 323752fe5034..1061eb7ec399 100644
--- a/drivers/platform/x86/intel/ifs/runtest.c
+++ b/drivers/platform/x86/intel/ifs/runtest.c
@@ -229,6 +229,85 @@ static void ifs_test_core(int cpu, struct device *dev)
 	}
 }
 
+#define SPINUNIT 100 /* 100 nsec */
+static atomic_t array_cpus_out;
+
+/*
+ * Simplified cpu sibling rendezvous loop based on microcode loader __wait_for_cpus()
+ */
+static void wait_for_sibling_cpu(atomic_t *t, long long timeout)
+{
+	int cpu = smp_processor_id();
+	const struct cpumask *smt_mask = cpu_smt_mask(cpu);
+	int all_cpus = cpumask_weight(smt_mask);
+
+	atomic_inc(t);
+	while (atomic_read(t) < all_cpus) {
+		if (timeout < SPINUNIT)
+			return;
+		ndelay(SPINUNIT);
+		timeout -= SPINUNIT;
+		touch_nmi_watchdog();
+	}
+}
+
+static int do_array_test(void *data)
+{
+	union ifs_array *command = data;
+	int cpu = smp_processor_id();
+	int first;
+
+	/*
+	 * Only one logical CPU on a core needs to trigger the Array test via MSR write.
+	 */
+	first = cpumask_first(cpu_smt_mask(cpu));
+
+	if (cpu == first) {
+		wrmsrl(MSR_ARRAY_BIST, command->data);
+		/* Pass back the result of the test */
+		rdmsrl(MSR_ARRAY_BIST, command->data);
+	}
+
+	/* Tests complete faster if the sibling is spinning here */
+	wait_for_sibling_cpu(&array_cpus_out, NSEC_PER_SEC);
+
+	return 0;
+}
+
+static void ifs_array_test_core(int cpu, struct device *dev)
+{
+	union ifs_array command = {};
+	bool timed_out = false;
+	struct ifs_data *ifsd;
+	unsigned long timeout;
+
+	ifsd = ifs_get_data(dev);
+
+	command.array_bitmask = ~0U;
+	timeout = jiffies + HZ / 2;
+
+	do {
+		if (time_after(jiffies, timeout)) {
+			timed_out = true;
+			break;
+		}
+		atomic_set(&array_cpus_out, 0);
+		stop_core_cpuslocked(cpu, do_array_test, &command);
+
+		if (command.ctrl_result)
+			break;
+	} while (command.array_bitmask);
+
+	ifsd->scan_details = command.data;
+
+	if (command.ctrl_result)
+		ifsd->status = SCAN_TEST_FAIL;
+	else if (timed_out || command.array_bitmask)
+		ifsd->status = SCAN_NOT_TESTED;
+	else
+		ifsd->status = SCAN_TEST_PASS;
+}
+
 /*
  * Initiate per core test. It wakes up work queue threads on the target cpu and
  * its sibling cpu. Once all sibling threads wake up, the scan test gets executed and
@@ -256,6 +335,8 @@ int do_core_test(int cpu, struct device *dev)
 		ifs_test_core(cpu, dev);
 		break;
 	case IFS_TYPE_ARRAY_BIST:
+		ifs_array_test_core(cpu, dev);
+		break;
 	default:
 		return -EINVAL;
 	}
-- 
2.25.1

