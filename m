Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53FA374FAB5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 00:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbjGKWKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 18:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbjGKWKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 18:10:05 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481B7170E;
        Tue, 11 Jul 2023 15:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689113404; x=1720649404;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k3E1tQ1O4ThXJCHrWKSmtS5nCbAQMLnu5/Dj8fpnRNk=;
  b=GkPYbedEZgdr91XKXzhCI9jHcl6abUfwX3XiBxOvVgdLgNk0Zb89+8eV
   pMrpBylHchQIOEZhI6LWcRqI8a89dIt7lrtgc/6dJOrfZ39rwz9Rem2eK
   DIgmnUpMJuhQuuPi8nyomaJ9iJoWcPvxGNNbnpnDX0RkIl5y/L3w2QjEi
   QonUkNHyktTBwU7VaM2rTfMGzCQce1ZbND38q5FeMsuQLo01fy8CyNl1d
   dprE8TAcrY2UWcfAVK/WKpxPi6tkBkOYXwu7bgl4hqspp68ZqWEzFTbdc
   5md5wIv2S6L+mOn1zKFPDJJvHPd6PFB80KrZTl7XJLkak4JqTf7tyTzDu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="345058988"
X-IronPort-AV: E=Sophos;i="6.01,197,1684825200"; 
   d="scan'208";a="345058988"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 15:10:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="786795081"
X-IronPort-AV: E=Sophos;i="6.01,197,1684825200"; 
   d="scan'208";a="786795081"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by fmsmga008.fm.intel.com with ESMTP; 11 Jul 2023 15:10:01 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com, andriy.shevchenko@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 3/3] doc: TPMI: Add debugfs documentation
Date:   Tue, 11 Jul 2023 15:09:49 -0700
Message-Id: <20230711220949.71881-4-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230711220949.71881-1-srinivas.pandruvada@linux.intel.com>
References: <20230711220949.71881-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Describe fields in the TPMI debugfs folder.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
v2
New.

 Documentation/ABI/testing/debugfs-tpmi | 31 ++++++++++++++++++++++++++
 MAINTAINERS                            |  1 +
 2 files changed, 32 insertions(+)
 create mode 100644 Documentation/ABI/testing/debugfs-tpmi

diff --git a/Documentation/ABI/testing/debugfs-tpmi b/Documentation/ABI/testing/debugfs-tpmi
new file mode 100644
index 000000000000..9b530c1aaa2d
--- /dev/null
+++ b/Documentation/ABI/testing/debugfs-tpmi
@@ -0,0 +1,31 @@
+What:		/sys/kernel/debug/tpmi-<n>/pfs_dump
+Date:		December 2023
+KernelVersion:	6.6
+Contact:	srinivas.pandruvada@linux.intel.com
+Description:
+The PFS (PM Feature Structure) table, shows details of each power
+management feature. This includes:
+tpmi_id, number of entries, entry size, offset, vsec offset, lock status
+and disabled status.
+Users:		Debugging, any user space test suite
+
+What:		/sys/kernel/debug/tpmi-<n>/tpmi-id-<n>/mem_dump
+Date:		December 2023
+KernelVersion:	6.6
+Contact:	srinivas.pandruvada@linux.intel.com
+Description:
+Shows the memory dump of the MMIO region for a TPMI ID.
+Users:		Debugging, any user space test suite
+
+What:		/sys/kernel/debug/tpmi-<n>/tpmi-id-<n>/mem_write
+Date:		December 2023
+KernelVersion:	6.6
+Contact:	srinivas.pandruvada@linux.intel.com
+Description:
+Allows to write at any offset. It doesn't check for Read/Write access
+as hardware will not allow to write at read-only memory. This write is
+at offset multiples of 4. The format is instance,offset,contents.
+Example:
+echo 0,0x20,0xff > mem_write
+echo 1,64,64 > mem_write
+Users:		Debugging, any user space test suite
diff --git a/MAINTAINERS b/MAINTAINERS
index 5761b02183a7..4d439121fb36 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10720,6 +10720,7 @@ INTEL TPMI DRIVER
 M:	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
+F:	Documentation/ABI/testing/debugfs-tpmi
 F:	drivers/platform/x86/intel/tpmi.c
 F:	include/linux/intel_tpmi.h
 
-- 
2.40.1

