Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3396A4124
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 12:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjB0LsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 06:48:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjB0LsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 06:48:17 -0500
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312501E9EE;
        Mon, 27 Feb 2023 03:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1677498451; bh=CI8s0gM0tMtJHBxeXCTI0IQpxz9851TtDO86l4aVjx8=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=dJliIvk6QlvwU3rCzUk7QBq8DjwevOBDejXxpnGzrv5IRr35EL9X+AqYuXMlkhaBZ
         rA4TE7VY6Drey4OqIjNoESTa/LM0N9qYlr1cSr6j7eAjQu4C3E4b5jMK1WnrbuMku0
         qo7RAi3ekl3i4jnj2hO9r0hCJfIVVXR4Axqs7SmQ=
Received: by b-1.in.mailobj.net [192.168.90.11] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Mon, 27 Feb 2023 12:47:31 +0100 (CET)
X-EA-Auth: vnFL1j1Pzw06bs3ZGVnme+e34tOLBxQ0GRjIE9QE87xaKerSboINzXlNieTuym4CdlL72C+mDKJR3y52TlF1tA==
Date:   Mon, 27 Feb 2023 17:17:25 +0530
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
Subject: [PATCH] perf/x86/core: Remove repeating test expression
Message-ID: <Y/yYTY7c7L0+d+Gb@ubun2204.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current implementation already checks validity of the cpu_type for the
hybrid pmu two lines above. Hence there is no need to again include
it in the immediate if test evaluation.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
 arch/x86/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 87a7f0cd77fd..89db2352deb9 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1893,7 +1893,7 @@ ssize_t events_hybrid_sysfs_show(struct device *dev,
 	for (i = 0; i < x86_pmu.num_hybrid_pmus; i++) {
 		if (!(x86_pmu.hybrid_pmu[i].cpu_type & pmu_attr->pmu_type))
 			continue;
-		if (x86_pmu.hybrid_pmu[i].cpu_type & pmu->cpu_type) {
+		if (pmu->cpu_type) {
 			next_str = strchr(str, ';');
 			if (next_str)
 				return snprintf(page, next_str - str + 1, "%s", str);
-- 
2.34.1



