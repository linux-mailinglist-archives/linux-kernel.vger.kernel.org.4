Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB4569B01A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 17:01:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjBQQBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 11:01:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjBQQA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 11:00:59 -0500
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC1D6FF0A;
        Fri, 17 Feb 2023 08:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1676649618; bh=wB3ZPtCGa5PrJ93JY1yIkav8LyCt0ajpRd6tRiIfc/I=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=ojRUod/HyzYRmrh4lI3SyTbTiA8YiLEmum4FtWfI5VAcmQit7cVOsEd7MhK+IPXoE
         WXpbIHv3ifGjhPRV596qQGAkT/D+3fphZHhrGDvRtDtFzG01ZxMXf04ej7fhHsWq6v
         zpcL5rR3Xydsnn7WzPmUeFuYH7cG5ih/VsTX1Hlw=
Received: by b-5.in.mailobj.net [192.168.90.15] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Fri, 17 Feb 2023 17:00:18 +0100 (CET)
X-EA-Auth: BdYOlj2NrjJjrAs+Rzq1GDtXgCk6fB/Aq7d7XEgknADjOjaT57Ntx1JGFn/P1Tn43rCp7Jx3MNK6FXoZrJtpVp9h/TAYq2QS
Date:   Fri, 17 Feb 2023 21:30:08 +0530
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
Subject: [PATCH 3/3] perf/x86/intel: Use sysfs_emit() in show() callback
 function
Message-ID: <fbd829c476c8fb953fb2e05ee6112b0a89849a75.1676649045.git.drv@mailo.com>
References: <cover.1676649045.git.drv@mailo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1676649045.git.drv@mailo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using sprintf/snprintf functions are error prone and suggested to be
replaced by scnprintf/vscnrptintf as outlined in this [1] LWN article.

A more recent recommendation is to use sysfs_emit() or sysfs_emit_at()
as per Documentation/filesystems/sysfs.rst in show() callback function
when formatting values to be returned to user-space. These helper
functions are PAGE_SIZE aware and wrap a safer call to vscnprintf().

[1] https://lwn.net/Articles/69419/

Issue identified using the coccinelle device_attr_show.cocci script.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
 arch/x86/events/intel/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index bafdc2be479a..8fb1225123ef 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5273,7 +5273,7 @@ static ssize_t show_sysctl_tfa(struct device *cdev,
 			      struct device_attribute *attr,
 			      char *buf)
 {
-	return snprintf(buf, 40, "%d\n", allow_tsx_force_abort);
+	return sysfs_emit(buf, "%d\n", allow_tsx_force_abort);
 }
 
 static ssize_t set_sysctl_tfa(struct device *cdev,
@@ -5307,7 +5307,7 @@ static ssize_t branches_show(struct device *cdev,
 			     struct device_attribute *attr,
 			     char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%d\n", x86_pmu.lbr_nr);
+	return sysfs_emit(buf, "%d\n", x86_pmu.lbr_nr);
 }
 
 static DEVICE_ATTR_RO(branches);
@@ -5323,7 +5323,7 @@ static ssize_t pmu_name_show(struct device *cdev,
 			     struct device_attribute *attr,
 			     char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%s\n", pmu_name_str);
+	return sysfs_emit(buf, "%s\n", pmu_name_str);
 }
 
 static DEVICE_ATTR_RO(pmu_name);
-- 
2.34.1



