Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF8D9745F3A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 16:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjGCO6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 10:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjGCO6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 10:58:47 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5EFE41;
        Mon,  3 Jul 2023 07:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688396326; x=1719932326;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Eaq+kIyDnmuZd4kwGRL+DNWZzWxEKTUANC5sgsGgATs=;
  b=Y7nE4vB8LktoOe3uWBXND/pwPXWF2W/MszkQCnSCYXSVfERtOiDPEtQ2
   7T447UcwWfrRpTdygWj23H2Xss4UBXLI/pyPoIXb4KeNCEjDy5Cr4gTST
   a5sTDIPcu+ByENMyN/bKrUZh6A9zxo8SmdGpOr4eeIfOF9asYm7yVk6l/
   3sd+8BzkIuhoWRg6gUvR/1Kf0DdAxjLJCDyCxhqcV/j1LEEJ0rdC3++j1
   lKI873Iib/XhA1HP419NRNQuWFFqysixchUnXwA2YR1ackHwqjuVR2ufa
   ec+Qt0/a6O1t7AnXAfiLt132QnmqAbgd8LNB/4wzc8O9i+n8WVyngiVf5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="361761404"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="361761404"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 07:58:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="695838542"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="695838542"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 03 Jul 2023 07:58:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 53BB3170; Mon,  3 Jul 2023 17:58:46 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v1 1/2] docs: printk-formats: Fix hex printing of signed values
Date:   Mon,  3 Jul 2023 17:58:38 +0300
Message-Id: <20230703145839.14248-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit cbacb5ab0aa0 ("docs: printk-formats: Stop encouraging use of
unnecessary %h[xudi] and %hh[xudi]") obviously missed the point of sign
promotion for the signed values lesser than int. In such case %x prints
not the same as %h[h]x. Restore back those specifiers for the signed hex
cases.

Fixes: cbacb5ab0aa0 ("docs: printk-formats: Stop encouraging use of unnecessary %h[xudi] and %hh[xudi]")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 Documentation/core-api/printk-formats.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
index dfe7e75a71de..2f3a6e0b3fc4 100644
--- a/Documentation/core-api/printk-formats.rst
+++ b/Documentation/core-api/printk-formats.rst
@@ -15,9 +15,9 @@ Integer types
 
 	If variable is of Type,		use printk format specifier:
 	------------------------------------------------------------
-		char			%d or %x
+		char			%d or %hhx
 		unsigned char		%u or %x
-		short int		%d or %x
+		short int		%d or %hx
 		unsigned short int	%u or %x
 		int			%d or %x
 		unsigned int		%u or %x
@@ -27,9 +27,9 @@ Integer types
 		unsigned long long	%llu or %llx
 		size_t			%zu or %zx
 		ssize_t			%zd or %zx
-		s8			%d or %x
+		s8			%d or %hhx
 		u8			%u or %x
-		s16			%d or %x
+		s16			%d or %hx
 		u16			%u or %x
 		s32			%d or %x
 		u32			%u or %x
-- 
2.40.0.1.gaa8946217a0b

