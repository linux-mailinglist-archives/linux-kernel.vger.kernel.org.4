Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C326874147D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 17:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbjF1PEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 11:04:09 -0400
Received: from mga17.intel.com ([192.55.52.151]:32511 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231940AbjF1PEC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 11:04:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687964642; x=1719500642;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1gfH1VI8rikXgJa4+jQmJEeCxlL86Kd/v1XPUYZdwvk=;
  b=NVudJMnQQpNBXm1om++DAR4sS4WMQ8gE4efb/0CLFQM76Pk2ZJPOZyUd
   gV05B/sGO606TeinZmruLvg+WHeBDKLQViRo9sjbX13+nw+EeuZ05+j1R
   vjq2kcTNJZu7vjaG1KRAYXet2Zr+TzWSJl5MaK5VHEUCG1uMhD2mxdbxA
   Rh82Rb9qOzcTns15KY8rcORNds/gjR9djm5swbbi2z46iy9FlfmhVngR6
   vak63fITaSc9775wpcarZyNKJ2f5eogqgfQk9W4cDeYHS2aE8xlMqaN5m
   ZanDOCcgK+PJ7OaXIY0a5oR6SuY7wafDLNvEKhGbMmoWe5rdz2A9TmSwj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="342206006"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="342206006"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 08:02:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="667159873"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="667159873"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 28 Jun 2023 08:02:46 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 63569E1; Wed, 28 Jun 2023 18:02:47 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] f2fs: Use return value of strreplace()
Date:   Wed, 28 Jun 2023 18:02:43 +0300
Message-Id: <20230628150243.17771-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since strreplace() returns the pointer to the string itself,
we may use it directly in the code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/trace/events/f2fs.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 793f82cc1515..f5994515290c 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -2234,13 +2234,11 @@ DECLARE_EVENT_CLASS(f2fs__rw_start,
 		 * because this screws up the tooling that parses
 		 * the traces.
 		 */
-		__assign_str(pathbuf, pathname);
-		(void)strreplace(__get_str(pathbuf), ' ', '_');
+		__assign_str(pathbuf, strreplace(pathname, ' ', '_'));
 		__entry->offset = offset;
 		__entry->bytes = bytes;
 		__entry->i_size = i_size_read(inode);
-		__assign_str(cmdline, command);
-		(void)strreplace(__get_str(cmdline), ' ', '_');
+		__assign_str(cmdline, strreplace(command, ' ', '_'));
 		__entry->pid = pid;
 		__entry->ino = inode->i_ino;
 	),
-- 
2.40.0.1.gaa8946217a0b

