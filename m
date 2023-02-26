Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB486A3331
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 18:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjBZRcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 12:32:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjBZRcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 12:32:14 -0500
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B9613DC1;
        Sun, 26 Feb 2023 09:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1677432705; bh=G3YJe+kKHyMy1tZ4zRvdixDsMk9Nsq26rrWMIw2P9PI=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=WWmwd75Wg7zo53mZy7rXFj9vSaArWZ5y7XT49N3fcen580mffuBOYc5ni7X5XCP5x
         8p/Jy/cUbIqKH+zgxX7de8COpLf+lTNbRI2XiCWLAp4tbI/K8US2qZSZZvR5G3yu15
         +VyuLLK+JicyVq5YZyyBT99uaGGD0iRodSdGDwSU=
Received: by b-3.in.mailobj.net [192.168.90.13] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Sun, 26 Feb 2023 18:31:45 +0100 (CET)
X-EA-Auth: pRYlgKORJEAre/qpX2WFvfeHJfJwl+ydoWZtKitRbEvAfMuTYx5eU4HewOUNtO0sQwssNeMGNKTBHEGOccQrbsaQXUWczipn
Date:   Sun, 26 Feb 2023 23:01:39 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Deepak R Varma <drv@mailo.com>
Subject: [PATCH v3 3/3] perf/x86/intel: Use sysfs_emit() in show() callback
 function
Message-ID: <e88697a9e217961ffcbf5843588a78e8b0b19854.1677431992.git.drv@mailo.com>
References: <cover.1677431992.git.drv@mailo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1677431992.git.drv@mailo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per C99 standard, snprintf() returns the number of bytes that would
be encoded in the destination buffer when it is sufficiently large. This
return value may be different from what the caller is expecting and hence
may lead to potential errors in the program.
Kernel release 2.6.2 introduced scnprintf() & vscnprintf() which precisely
return the actual bytes encoded into the destination buffer.

For the sysfs attribute show() callback functions, which returns the number
of bytes to the user space, a more recent recommendation is to use
sysfs_emit() or sysfs_emit_at() instead of sprintf() family of functions.
This is recorded in the Documentation/filesystems/sysfs.rst Kernel
documentation file.

Issue identified using the coccinelle device_attr_show.cocci script.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
Changes in v3:
   - None.

Changes in v2:
   - Revise patch log message to include details on the potential issues with
     current implementation and how the proposal is a better solution.
     Feedback provided by Peter Zijlstra <peterz@infradead.org>

 arch/x86/events/intel/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 9fce2d1247a7..75ab89ff3a0f 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5387,7 +5387,7 @@ static ssize_t show_sysctl_tfa(struct device *cdev,
 			      struct device_attribute *attr,
 			      char *buf)
 {
-	return snprintf(buf, 40, "%d\n", allow_tsx_force_abort);
+	return sysfs_emit(buf, "%d\n", allow_tsx_force_abort);
 }
 
 static ssize_t set_sysctl_tfa(struct device *cdev,
@@ -5421,7 +5421,7 @@ static ssize_t branches_show(struct device *cdev,
 			     struct device_attribute *attr,
 			     char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%d\n", x86_pmu.lbr_nr);
+	return sysfs_emit(buf, "%d\n", x86_pmu.lbr_nr);
 }
 
 static DEVICE_ATTR_RO(branches);
@@ -5437,7 +5437,7 @@ static ssize_t pmu_name_show(struct device *cdev,
 			     struct device_attribute *attr,
 			     char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%s\n", pmu_name_str);
+	return sysfs_emit(buf, "%s\n", pmu_name_str);
 }
 
 static DEVICE_ATTR_RO(pmu_name);
-- 
2.34.1



