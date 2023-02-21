Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5693269E1FF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 15:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234087AbjBUOIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 09:08:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233656AbjBUOII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 09:08:08 -0500
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94CC82A99A;
        Tue, 21 Feb 2023 06:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1676988418; bh=oLZwRpXxfR8jKepCYgBAd0gcxoO2D6bBAKStsCYFVz8=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=ct/HGOoSPl2yfAJdpTmfbCK4kQ8qIvxaKs0L4O54Kib0xMGCCh0W34MpMfkFTJl8j
         VOcr/oyOReG12/EEQ5gUPB3DGFW3K01KcX6ECXSJqTVFA0yZHWook5MYdkKBMhrspq
         rPqb2ddx9urUVC9k78cNNCT253DHeqi8pEPTluaQ=
Received: by b-3.in.mailobj.net [192.168.90.13] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Tue, 21 Feb 2023 15:06:58 +0100 (CET)
X-EA-Auth: at9OF3ziCtOVa+pv6TzsuxHGTTSacIrTPKQNDcL9n3nWoXnaOhWUsf84g1TEAEzf2IJx/eMLezJ3x9Jg2DvqQbGUPd6TRiTO
Date:   Tue, 21 Feb 2023 19:36:52 +0530
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
Subject: [PATCH v2 2/3] perf/x86/intel/pt: Use sysfs_emit() in show()
 callback function
Message-ID: <54c16281234d057ebed1ef05bde20d2d57d70669.1676987821.git.drv@mailo.com>
References: <cover.1676987821.git.drv@mailo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1676987821.git.drv@mailo.com>
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
Changes in v2:
   - Revise patch log message to include details on the potential issues with
     current implementation and how the proposal is a better solution.
     Feedback provided by Peter Zijlstra <peterz@infradead.org>


 arch/x86/events/intel/pt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 42a55794004a..d9e6d771b458 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -96,7 +96,7 @@ static ssize_t pt_cap_show(struct device *cdev,
 		container_of(attr, struct dev_ext_attribute, attr);
 	enum pt_capabilities cap = (long)ea->var;
 
-	return snprintf(buf, PAGE_SIZE, "%x\n", intel_pt_validate_hw_cap(cap));
+	return sysfs_emit(buf, "%x\n", intel_pt_validate_hw_cap(cap));
 }
 
 static struct attribute_group pt_cap_group __ro_after_init = {
-- 
2.34.1



