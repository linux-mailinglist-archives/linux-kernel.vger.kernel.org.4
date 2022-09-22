Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462095E6BFD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 21:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbiIVTtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 15:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232430AbiIVTtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 15:49:43 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B9A2316E
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 12:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663876182; x=1695412182;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/8lVvT4s7GIthRd7iR4yh43Ja2mwMI0mXbrx3ril/iQ=;
  b=ZbfMywHKkNyYdSTns0sYK22DFAzDUOGOzUgeSuRIuTppikGy3AnLaBmt
   5GemNMVTwcYO2TPSpDJejyvPMk4mKEXO5N/+tK+PkhBNJnpZ9Z+w5Kvlg
   WKAiiMBnid4xtWAc3d5UVjCGvoJ6dj0lWX3cxOahIxN7My8hRQfimZtDc
   cx6AXERkJ/mEkPPtFTAj8myjy+X5losxxGr8MieYKnKvnc41joNpGVkQi
   xQIB4w4qp/P3Ta0CMfaoo5HykoMA/ARMqyn4niSor2taAAQt4UFbLM8zL
   ecwNbRsX8ird0iQksLjmcvAKYijF/rDyvt9aPIBR+JZHyCryShXKbFk/F
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="280783036"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="280783036"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 12:49:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="682371974"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 22 Sep 2022 12:49:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id DF2D8F7; Thu, 22 Sep 2022 22:49:57 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Phil Auld <pauld@redhat.com>
Subject: [PATCH v2 1/1] cpumask: Don't waste memory for sysfs cpulist nodes
Date:   Thu, 22 Sep 2022 22:49:54 +0300
Message-Id: <20220922194954.1078-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the approximation is used which wastes the more memory
the more CPUs are present on the system. Proposed change calculates
the exact maximum needed in the worst case:

  NR_CPUS	old		new
  -------	---		---
  1 .. 1170	4096		4096
  1171 .. 1860	4098 ..	6510	4096
  ...		...		...
  2*4096	28672		19925
  4*4096	57344		43597
  8*4096	114688		92749
  16*4096	229376		191053
  32*4096	458752		403197
  64*4096	917504		861949
  128*4096	1835008		1779453
  256*4096	3670016		3670016

Under the hood the reccurent formula is being used:
  (5 - 0) * 2 +
    (50 - 5) * 3 +
      (500 - 50) * 4 +
        (5000 - 500) * 5 +
          ...
            (X[i] - X[i-1]) * i

which allows to count the exact maximum length in the worst case,
i.e. when each second CPU is being listed. For backward compatibility
for more than 1170 and less than 1861 CPUs the page size is preserved.

For less than 1171 and more than 1 million CPUs the old is being used.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: described better the advantage for 1171..1860 CPUs cases
 include/linux/cpumask.h | 48 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 1b442fb2001f..12cf0905ca74 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -1122,6 +1122,21 @@ cpumap_print_list_to_buf(char *buf, const struct cpumask *mask,
  *
  * for cpumap NR_CPUS * 9/32 - 1 should be an exact length.
  *
+ * for cpulist the reccurent formula is being used:
+ *   (5 - 0) * 2 +
+ *     (50 - 5) * 3 +
+ *       (500 - 50) * 4 +
+ *         (5000 - 500) * 5 +
+ *           ...
+ *             (X[i] - X[i-1]) * i
+ *
+ * which allows to count the exact maximum length in the worst case,
+ * i.e. when each second CPU is being listed. For backward compatibility
+ * for more than 1170 and less than 1861 CPUs the page size is preserved.
+ *
+ * For less than 1171 and more than 1 million CPUs the old is being used
+ * as described below:
+ *
  * For cpulist 7 is (ceil(log10(NR_CPUS)) + 1) allowing for NR_CPUS to be up
  * to 2 orders of magnitude larger than 8192. And then we divide by 2 to
  * cover a worst-case of every other cpu being on one of two nodes for a
@@ -1132,6 +1147,39 @@ cpumap_print_list_to_buf(char *buf, const struct cpumask *mask,
  */
 #define CPUMAP_FILE_MAX_BYTES  (((NR_CPUS * 9)/32 > PAGE_SIZE) \
 					? (NR_CPUS * 9)/32 - 1 : PAGE_SIZE)
+
+#define __CPULIST_FOR_10(x)		(((x + 1) / 2 - 0)     * 2)
+#define __CPULIST_FOR_100(x)		(((x + 1) / 2 - 5)     * 3)
+#define __CPULIST_FOR_1000(x)		(((x + 1) / 2 - 50)    * 4)
+#define __CPULIST_FOR_10000(x)		(((x + 1) / 2 - 500)   * 5)
+#define __CPULIST_FOR_100000(x)		(((x + 1) / 2 - 5000)  * 6)
+#define __CPULIST_FOR_1000000(x)	(((x + 1) / 2 - 50000) * 7)
+
+#if NR_CPUS < 1861
+#define CPULIST_FILE_MAX_BYTES	PAGE_SIZE
+#elif NR_CPUS < 10000
+#define CPULIST_FILE_MAX_BYTES			\
+	 (__CPULIST_FOR_10(10) +		\
+	  __CPULIST_FOR_100(100) +		\
+	  __CPULIST_FOR_1000(1000) +		\
+	  __CPULIST_FOR_10000(NR_CPUS))
+#elif NR_CPUS < 100000
+#define CPULIST_FILE_MAX_BYTES			\
+	 (__CPULIST_FOR_10(10) +		\
+	  __CPULIST_FOR_100(100) +		\
+	  __CPULIST_FOR_1000(1000) +		\
+	  __CPULIST_FOR_10000(10000) +		\
+	  __CPULIST_FOR_100000(NR_CPUS))
+#elif NR_CPUS < 1000000
+#define CPULIST_FILE_MAX_BYTES			\
+	 (__CPULIST_FOR_10(10) +		\
+	  __CPULIST_FOR_100(100) +		\
+	  __CPULIST_FOR_1000(1000) +		\
+	  __CPULIST_FOR_10000(10000) +		\
+	  __CPULIST_FOR_100000(100000) +	\
+	  __CPULIST_FOR_1000000(NR_CPUS))
+#else
 #define CPULIST_FILE_MAX_BYTES  (((NR_CPUS * 7)/2 > PAGE_SIZE) ? (NR_CPUS * 7)/2 : PAGE_SIZE)
+#endif
 
 #endif /* __LINUX_CPUMASK_H */
-- 
2.35.1

