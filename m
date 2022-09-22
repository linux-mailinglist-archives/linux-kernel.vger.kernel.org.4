Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 719425E6BC3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 21:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbiIVTfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 15:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiIVTe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 15:34:58 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D693EE1185
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 12:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663875297; x=1695411297;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gMA139Nz1+YsImIs/o9xGleu/LUno1XeYEqdI+HbTD4=;
  b=R7uh0VadZHxxeSWcrvOLfra58ZlayBor4BFyRMXcMcV7NxhQXj9R4ewh
   r4BTtCi4EST3eudTNU9GaIq7T+I9dksZuNK1mu9NeviwbKDqhM6PSCoiQ
   jmIqTG9rrftK6ERXY/2ZeWGyTsEKqsjzN+yg0EelEWiuCQzqt7K7OukMS
   PcP+ErsvoHM+wfIGW+zPG5erXwX7Ud1Mkm+apV+6gqkPI17nu1bBgOZNR
   txp3uL22U4cVzsRD39uPvJR7JhmVzRxTvD7elsqYtOYj8D+RDYdBcjMa+
   xffwphF/yBD21Nwy9N+Pq4B7J41cykhnyqMV7ysHXRpU3Z2MfpICcwwo7
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="298009831"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="298009831"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 12:34:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="709023707"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Sep 2022 12:34:56 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A53F7F7; Thu, 22 Sep 2022 22:35:13 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Phil Auld <pauld@redhat.com>
Subject: [PATCH v1 1/1] cpumask: Don't waste memory for sysfs cpulist nodes
Date:   Thu, 22 Sep 2022 22:34:47 +0300
Message-Id: <20220922193447.88123-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
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
  1 .. 1860	4096		4096
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
i.e. when each second CPU is being listed. For less than 1861 and
more than 1 million CPUs the old is being used.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/cpumask.h | 45 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 1b442fb2001f..7c6416fa038d 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -1122,6 +1122,18 @@ cpumap_print_list_to_buf(char *buf, const struct cpumask *mask,
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
+ * i.e. when each second CPU is being listed. For less than 1861 and
+ * more than 1 million CPUs the old is being used as described below:
+ *
  * For cpulist 7 is (ceil(log10(NR_CPUS)) + 1) allowing for NR_CPUS to be up
  * to 2 orders of magnitude larger than 8192. And then we divide by 2 to
  * cover a worst-case of every other cpu being on one of two nodes for a
@@ -1132,6 +1144,39 @@ cpumap_print_list_to_buf(char *buf, const struct cpumask *mask,
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

