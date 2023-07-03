Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28123745F3B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 16:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbjGCO6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 10:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjGCO6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 10:58:47 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98940E43;
        Mon,  3 Jul 2023 07:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688396326; x=1719932326;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FHly7jrfHT4AJToL1z+8Wr8S5HSfEj4odBZvKbf6Fns=;
  b=bPOzGRbYiVt3cFLrD43eMfIv0pft+1QeLtw2++9uNdd2xm/QgU5W+iRK
   JHIG1QkRg7sZtDljdZO7Zx+PcWUMVgq6AWAfTw+rsQzZSMBEexokmeIsx
   QVw57syQWub9+D7/2Afvs1w7E6qJY+EPV4qFrHtKgwEMiaIBvjXuTgL6x
   UoJTAfmB0JtBQQdTQmJPkIRGaIS/fPCkAxUSFUGBshLO9GbOpJ6GP8IX3
   3DF+pjjahUrsIA12b4moZONZCE5hMEum77M/Ik1K106wXheoTtXEIGVL3
   nqw8Hi3FJHH3J4KFNXI5zYkmJGc9s2gSdVSSKLmSohVDdvFJlIYKwO/53
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="426587582"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="426587582"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 07:58:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="718625424"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="718625424"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 03 Jul 2023 07:58:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6170B13C; Mon,  3 Jul 2023 17:58:46 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v1 2/2] docs: printk-formats: Treat char as always unsigned
Date:   Mon,  3 Jul 2023 17:58:39 +0300
Message-Id: <20230703145839.14248-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230703145839.14248-1-andriy.shevchenko@linux.intel.com>
References: <20230703145839.14248-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Linux kernel switched to have char be equivalent to usigned char.
Reflect this in the printk specifiers.

Fixes: 3bc753c06dd0 ("kbuild: treat char as always unsigned")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 Documentation/core-api/printk-formats.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
index 2f3a6e0b3fc4..4451ef501936 100644
--- a/Documentation/core-api/printk-formats.rst
+++ b/Documentation/core-api/printk-formats.rst
@@ -15,8 +15,9 @@ Integer types
 
 	If variable is of Type,		use printk format specifier:
 	------------------------------------------------------------
-		char			%d or %hhx
+		signed char		%d or %hhx
 		unsigned char		%u or %x
+		char			%u or %x
 		short int		%d or %hx
 		unsigned short int	%u or %x
 		int			%d or %x
-- 
2.40.0.1.gaa8946217a0b

