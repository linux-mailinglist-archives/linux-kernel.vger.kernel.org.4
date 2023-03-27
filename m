Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD9B6CA78C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 16:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232975AbjC0O1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 10:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjC0O13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 10:27:29 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E386E72B2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 07:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679927203; x=1711463203;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=83pEQ9KTFneyFbioXCE2oteqihcip/h5EwzkIU0AfBo=;
  b=g69vc9q2dLYw38hVZCFiJ36NoKjUJWS0fQl5uTwykUdQDf6ys0HKSg3U
   +t9M6660vlZS24rcU0rW4MaPI1ddCkqb9LTJoT8+UEDxXXuJxtfH7RiSN
   qAgUL/TA2f5+txWKZoCTxp2Z9JB5xCEYQNRpwKW1ugvotCgYjFTCdFVFu
   TIp5blzQZxm8xYavcrJk4wlx6KXvZ4TtnhrPxUGlcLYJTkjyJAJoib+Fl
   6pM5wqeU910eByF710Y9rb6NMA9SQSN0fiD7RPG/FKMUmi8tEhlvG/cVF
   V2hhT1wDc9Duq57XKqgCvTH4n9SJYmQ9yq75+oRWy2q5RfjTKoXux61Nd
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="340305407"
X-IronPort-AV: E=Sophos;i="5.98,294,1673942400"; 
   d="scan'208";a="340305407"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 07:26:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="857668805"
X-IronPort-AV: E=Sophos;i="5.98,294,1673942400"; 
   d="scan'208";a="857668805"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 27 Mar 2023 07:26:08 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C88F579C; Mon, 27 Mar 2023 17:26:08 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] lib/test-string_helpers: Replace UNESCAPE_ANY by UNESCAPE_ALL_MASK
Date:   Mon, 27 Mar 2023 17:26:04 +0300
Message-Id: <20230327142604.48213-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we get a random number to generate a flag in the valid range
of UNESCAPE flags, use UNESCAPE_ALL_MASK, It's more correct and
prevents from missed updates of the test coverage in the future
if any.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/test-string_helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test-string_helpers.c b/lib/test-string_helpers.c
index 41d3447bc3b4..9a68849a5d55 100644
--- a/lib/test-string_helpers.c
+++ b/lib/test-string_helpers.c
@@ -587,7 +587,7 @@ static int __init test_string_helpers_init(void)
 	for (i = 0; i < UNESCAPE_ALL_MASK + 1; i++)
 		test_string_unescape("unescape", i, false);
 	test_string_unescape("unescape inplace",
-			     get_random_u32_below(UNESCAPE_ANY + 1), true);
+			     get_random_u32_below(UNESCAPE_ALL_MASK + 1), true);
 
 	/* Without dictionary */
 	for (i = 0; i < ESCAPE_ALL_MASK + 1; i++)
-- 
2.40.0.1.gaa8946217a0b

