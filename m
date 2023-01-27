Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F08D867E9FF
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 16:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbjA0PvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 10:51:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232618AbjA0PvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 10:51:12 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4B71F92E
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 07:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674834665; x=1706370665;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Kg/dDu1ZvAKAl33YqhJ2EaO1DfCuAYOzwv0JQ3tQAiY=;
  b=MeJDalpQJaVvDkqNkVGDaBWlV97vBTAbBvb4YwSw9H/Fs2CQ/pdLqWr0
   jhSTfQeTjDj3IPdT0et5LhsdEB/pioEss3+2MN9Bl0BqcS8laWQien8Z9
   s3ovnrYgIFBWAapG+U9BcAXboWGwx9UPumtvQs3MvPMWioJ3CNzx6UfQf
   bIqnpvNQUwHCxlwTA9dpQUDd7rT8staH0890NE0ps1C33cyaiYJkTU5Ju
   irT0hxLVNb8PZETSVLVwknvdT2CaNge/4iDHoz4R4Z0uRl3D2cr5t2VXs
   VH/t5Dt5odl06OqF3mVapMYo4sax52zz47OdmYO/4aPVyn58Gvd3h93CH
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="310733718"
X-IronPort-AV: E=Sophos;i="5.97,251,1669104000"; 
   d="scan'208";a="310733718"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 07:51:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="613227269"
X-IronPort-AV: E=Sophos;i="5.97,251,1669104000"; 
   d="scan'208";a="613227269"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 27 Jan 2023 07:51:03 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 99F82152; Fri, 27 Jan 2023 17:51:39 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] lib/string: Use strchr() in strpbrk()
Date:   Fri, 27 Jan 2023 17:51:35 +0200
Message-Id: <20230127155135.27153-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use strchr() instead of open coding it as it's done elsewhere in
the same file. Either we will have similar to what it was or possibly
better performance in case architecture implements its own strchr().

Memory wise on x86_64 bloat-o-meter shows the following

  Function           old     new   delta
  strsep             111     102      -9
  Total: Before=2763, After=2754, chg -0.33%

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/string.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/lib/string.c b/lib/string.c
index 4fb566ea610f..3d55ef890106 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -480,13 +480,11 @@ EXPORT_SYMBOL(strcspn);
  */
 char *strpbrk(const char *cs, const char *ct)
 {
-	const char *sc1, *sc2;
+	const char *sc;
 
-	for (sc1 = cs; *sc1 != '\0'; ++sc1) {
-		for (sc2 = ct; *sc2 != '\0'; ++sc2) {
-			if (*sc1 == *sc2)
-				return (char *)sc1;
-		}
+	for (sc = cs; *sc != '\0'; ++sc) {
+		if (strchr(ct, *sc))
+			return (char *)sc;
 	}
 	return NULL;
 }
-- 
2.39.0

