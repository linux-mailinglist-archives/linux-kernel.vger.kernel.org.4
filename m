Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB5E967657D
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 10:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjAUJts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 04:49:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjAUJtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 04:49:33 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E115B598;
        Sat, 21 Jan 2023 01:49:32 -0800 (PST)
Date:   Sat, 21 Jan 2023 09:49:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674294566;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ebaQ3jacCL2qTuvxLK6OEKOSCR/smA3JpOla8BhqAj0=;
        b=pjgjz9i3DCs2/Cnf1pYf5x3LdpuHCiMiYOQTomBib/YlWuZynwiL5D9Fu6qvOMEdZfBqIm
        2Nu8eGBxioZQoZdlC5CdChAcPxN4s7XfEWuTOypT7tAe34LBKPSPu17QU0pCUSZS9x+s/h
        f+Hn/UIqAs0z7eyjbCLd1ov/a5trki6WBStrMPAk+fTLCt3muOPwAXQMY9BTHdhb9UHy22
        hQ1f+Y4T9CiyZCkd6Lg/P78CD7bMaoucAluMbnNXFdS6P8bImbrxo3JoaOloxRw1uPiBMn
        7ppndlG3k2eS9ex9ancLeu+gSscj3PuAMKnLcIfF57a7hoGpC3hG41hOG6cMEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674294566;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ebaQ3jacCL2qTuvxLK6OEKOSCR/smA3JpOla8BhqAj0=;
        b=e97w2b8EAl0DicnOulFpEswumLoNVWFX3Q29dF6WrlOJrmAPwkYgGXYjHK5FnM83dvXJSm
        yGqaf0jhkhEr05Aw==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/uncore: Fix potential NULL pointer in
 uncore_get_alias_name
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Petlan <mpetlan@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230112200105.733466-3-kan.liang@linux.intel.com>
References: <20230112200105.733466-3-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <167429456634.4906.5213156266186618225.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     3af548f2361077cd53762c88d62343d4e8ea1efb
Gitweb:        https://git.kernel.org/tip/3af548f2361077cd53762c88d62343d4e8ea1efb
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Thu, 12 Jan 2023 12:01:02 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 21 Jan 2023 00:06:12 +01:00

perf/x86/uncore: Fix potential NULL pointer in uncore_get_alias_name

The current code assumes that the discovery table provides valid
box_ids for the normal units. It's not the case anymore since some units
in the discovery table are broken on some SPR variants.

Factor out uncore_get_box_id(). Check the existence of the type->box_ids
before using it. If it's not available, use pmu_idx.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Michael Petlan <mpetlan@redhat.com>
Link: https://lore.kernel.org/r/20230112200105.733466-3-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index eeaa92f..271c016 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -857,6 +857,12 @@ static const struct attribute_group uncore_pmu_attr_group = {
 	.attrs = uncore_pmu_attrs,
 };
 
+static inline int uncore_get_box_id(struct intel_uncore_type *type,
+				    struct intel_uncore_pmu *pmu)
+{
+	return type->box_ids ? type->box_ids[pmu->pmu_idx] : pmu->pmu_idx;
+}
+
 void uncore_get_alias_name(char *pmu_name, struct intel_uncore_pmu *pmu)
 {
 	struct intel_uncore_type *type = pmu->type;
@@ -865,7 +871,7 @@ void uncore_get_alias_name(char *pmu_name, struct intel_uncore_pmu *pmu)
 		sprintf(pmu_name, "uncore_type_%u", type->type_id);
 	else {
 		sprintf(pmu_name, "uncore_type_%u_%d",
-			type->type_id, type->box_ids[pmu->pmu_idx]);
+			type->type_id, uncore_get_box_id(type, pmu));
 	}
 }
 
@@ -892,7 +898,7 @@ static void uncore_get_pmu_name(struct intel_uncore_pmu *pmu)
 		 * Use the box ID from the discovery table if applicable.
 		 */
 		sprintf(pmu->name, "uncore_%s_%d", type->name,
-			type->box_ids ? type->box_ids[pmu->pmu_idx] : pmu->pmu_idx);
+			uncore_get_box_id(type, pmu));
 	}
 }
 
