Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C052D6CA79C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 16:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233189AbjC0O2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 10:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232617AbjC0O2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 10:28:15 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79710659B
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 07:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679927257; x=1711463257;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bwHaYJuF6V1NJzur1wTeCyoLa0ib0Nh/wjM0jlUNCOo=;
  b=YicTcMlLw2rwrSH/GukA+0spntmptxHLG6jkf6wubgZBIyyIraomfCmX
   Z9dNeD8tctvlSelbEZSdIPKbM+ZoqOMus1qyvle+yqBBFFEJUX+pIYbWq
   f1fSY13fGx/8+3FVYk0wb6yQfpIfUu6NVv0lEV2A0MWl7fF4PyWZCvF0g
   yA/tfpYuDfF17EAmne8gvcsYsbLse9gqXMezRb3+iK8MZpI7fGA+pTBJN
   tMmwVhcsSIM0/7AejIKeMv3b3ubV5sxhlQqhxTK6Jij5xgUBqzC/Oh7iF
   ME+sc4g/R+lh3SA7gzrjQrjqzmeLpNF6PtITFZal9Bns9z18R2otiG8rG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="320676727"
X-IronPort-AV: E=Sophos;i="5.98,294,1673942400"; 
   d="scan'208";a="320676727"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 07:27:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="676981809"
X-IronPort-AV: E=Sophos;i="5.98,294,1673942400"; 
   d="scan'208";a="676981809"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 27 Mar 2023 07:27:34 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6753479C; Mon, 27 Mar 2023 17:27:35 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v1 1/1] lib/vsprintf: Use isodigit() for the octal number check
Date:   Mon, 27 Mar 2023 17:27:21 +0300
Message-Id: <20230327142721.48378-1-andriy.shevchenko@linux.intel.com>
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

Use isodigit() to test the octal number instead of homegrown approach.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/vsprintf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index fbe320b5e89f..40f560959b16 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -3642,7 +3642,7 @@ int vsscanf(const char *buf, const char *fmt, va_list args)
 		if (!digit
 		    || (base == 16 && !isxdigit(digit))
 		    || (base == 10 && !isdigit(digit))
-		    || (base == 8 && (!isdigit(digit) || digit > '7'))
+		    || (base == 8 && !isodigit(digit))
 		    || (base == 0 && !isdigit(digit)))
 			break;
 
-- 
2.40.0.1.gaa8946217a0b

