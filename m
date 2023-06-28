Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8158F74155D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 17:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbjF1Pfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 11:35:31 -0400
Received: from mga09.intel.com ([134.134.136.24]:20036 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232553AbjF1PeV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 11:34:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687966461; x=1719502461;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UM29w6YmyINBXCk6A+fAcfZ7rP6qST6yVT5akSdbQhM=;
  b=NSAl2M3Qb7rt9maR/OndmlJiJtvLSUjGJRAKOR45dstxFoaY0psrg0p8
   6y1td1N3yEAjfrvrSh/WNQz6bU2p/3keXXnPBrj+NnVHkx5yBTsYaD/bB
   CRfg3+4KIrOWWIs+LAhmuU8qzIQ/m6+qPEH0cl2Iqj32LXnh7g98t9oc+
   We1mga/xAsbx6NyNR9upN2QuNt78EtfO5tHI6kKGJtsrXWhl2llVPNGQJ
   wY8KURaXyV8A2mpu+gct9Fy60ueF6uXZZ6GRPpREn5Cl+eTXL9eJ9f3Bc
   bkDwjukQq+IJtEpyTZu2FMeGJJNPFbni9OtHU5X+bfFusI6zvpXLgGwGI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="364427621"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="364427621"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 08:33:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="782344837"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="782344837"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 28 Jun 2023 08:33:47 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4BDDDE1; Wed, 28 Jun 2023 18:33:48 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] kasan: Replace strreplace() with strchrnul()
Date:   Wed, 28 Jun 2023 18:33:42 +0300
Message-Id: <20230628153342.53406-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't need to traverse over the entire string and replace
occurrences of a character with '\0'. The first match will
suffice. Hence, replace strreplace() with strchrnul().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 mm/kasan/report_generic.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/kasan/report_generic.c b/mm/kasan/report_generic.c
index 51a1e8a8877f..63a34eac4a8c 100644
--- a/mm/kasan/report_generic.c
+++ b/mm/kasan/report_generic.c
@@ -264,6 +264,7 @@ static void print_decoded_frame_descr(const char *frame_descr)
 	while (num_objects--) {
 		unsigned long offset;
 		unsigned long size;
+		char *p;
 
 		/* access offset */
 		if (!tokenize_frame_descr(&frame_descr, token, sizeof(token),
@@ -282,7 +283,7 @@ static void print_decoded_frame_descr(const char *frame_descr)
 			return;
 
 		/* Strip line number; without filename it's not very helpful. */
-		strreplace(token, ':', '\0');
+		p[strchrnul(token, ':') - token] = '\0';
 
 		/* Finally, print object information. */
 		pr_err(" [%lu, %lu) '%s'", offset, offset + size, token);
-- 
2.40.0.1.gaa8946217a0b

