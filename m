Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91566BC1B1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 00:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232895AbjCOXq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 19:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232661AbjCOXq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 19:46:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA3D15540;
        Wed, 15 Mar 2023 16:45:57 -0700 (PDT)
Date:   Wed, 15 Mar 2023 23:36:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1678923379;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=41dIEGEGewUxp2qWhqXvFItcme40IVFHqdBSwxA8Mg4=;
        b=oSw0bUclzmXJy5ukltY/PYfkqMioLCRNAIYazgnPvBaw9j12Y+xQF4jTq/pohCkIwqTEG9
        xme3sssPl7onc30B/+mOF+3BQ4OsLrOUpKswlrsOXDOzCZgpKQDwlc0XOl9OMLtB/7IqE/
        FIaAi4b/xSz4mLjCWet8Bs3ZybcmqmI0cQSYkLV4luzYe0Rt03SOau3+59OUqnV1kOTptt
        HtE6Jayr4o2pQCkflFKfIDLuFUdOACic0w8S/ZhrBVgOpyMhuXMNU0EnipT7yZ+lOjqymz
        DEyRGm1elovo5W9+4DM2jqe+JMwbqHzL6CTw37cmElf09uRtEEO13g3fnFYRKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1678923379;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=41dIEGEGewUxp2qWhqXvFItcme40IVFHqdBSwxA8Mg4=;
        b=TXJVi1UZOcZBV50a2x3ao2DTC9q4/7jpIvkBb1a8q6YTiMVvZBLmeITrnXVFxo0kuRWDRJ
        uYYj8aY2DrJP5XCQ==
From:   "tip-bot2 for Peter Newman" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Avoid redundant counter read in
 __mon_event_count()
Cc:     Peter Newman <peternewman@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Babu Moger <babu.moger@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <167892337886.5837.12368110501318980479.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     322b72e0fd10101f2da8985b31b4af70f184bf79
Gitweb:        https://git.kernel.org/tip/322b72e0fd10101f2da8985b31b4af70f184bf79
Author:        Peter Newman <peternewman@google.com>
AuthorDate:    Tue, 20 Dec 2022 17:41:32 +01:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 15 Mar 2023 15:44:15 -07:00

x86/resctrl: Avoid redundant counter read in __mon_event_count()

__mon_event_count() does the per-RMID, per-domain work for
user-initiated event count reads and the initialization of new monitor
groups.

In the initialization case, after resctrl_arch_reset_rmid() calls
__rmid_read() to record an initial count for a new monitor group, it
immediately calls resctrl_arch_rmid_read(). This re-read of the hardware
counter is unnecessary and the following computations are ignored by the
caller during initialization.

Following return from resctrl_arch_reset_rmid(), just clear the
mbm_state and return. This involves moving the mbm_state lookup into the
rr->first case, as it's not needed for regular event count reads: the
QOS_L3_OCCUP_EVENT_ID case was redundant with the accumulating logic at
the end of the function.

Signed-off-by: Peter Newman <peternewman@google.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Link: https://lore.kernel.org/all/20221220164132.443083-2-peternewman%40google.com
---
 arch/x86/kernel/cpu/resctrl/monitor.c | 43 +++++++++++---------------
 1 file changed, 19 insertions(+), 24 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 7fe5148..2095241 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -383,41 +383,36 @@ void free_rmid(u32 rmid)
 		list_add_tail(&entry->list, &rmid_free_lru);
 }
 
+static struct mbm_state *get_mbm_state(struct rdt_domain *d, u32 rmid,
+				       enum resctrl_event_id evtid)
+{
+	switch (evtid) {
+	case QOS_L3_MBM_TOTAL_EVENT_ID:
+		return &d->mbm_total[rmid];
+	case QOS_L3_MBM_LOCAL_EVENT_ID:
+		return &d->mbm_local[rmid];
+	default:
+		return NULL;
+	}
+}
+
 static int __mon_event_count(u32 rmid, struct rmid_read *rr)
 {
 	struct mbm_state *m;
 	u64 tval = 0;
 
-	if (rr->first)
+	if (rr->first) {
 		resctrl_arch_reset_rmid(rr->r, rr->d, rmid, rr->evtid);
+		m = get_mbm_state(rr->d, rmid, rr->evtid);
+		if (m)
+			memset(m, 0, sizeof(struct mbm_state));
+		return 0;
+	}
 
 	rr->err = resctrl_arch_rmid_read(rr->r, rr->d, rmid, rr->evtid, &tval);
 	if (rr->err)
 		return rr->err;
 
-	switch (rr->evtid) {
-	case QOS_L3_OCCUP_EVENT_ID:
-		rr->val += tval;
-		return 0;
-	case QOS_L3_MBM_TOTAL_EVENT_ID:
-		m = &rr->d->mbm_total[rmid];
-		break;
-	case QOS_L3_MBM_LOCAL_EVENT_ID:
-		m = &rr->d->mbm_local[rmid];
-		break;
-	default:
-		/*
-		 * Code would never reach here because an invalid
-		 * event id would fail in resctrl_arch_rmid_read().
-		 */
-		return -EINVAL;
-	}
-
-	if (rr->first) {
-		memset(m, 0, sizeof(struct mbm_state));
-		return 0;
-	}
-
 	rr->val += tval;
 
 	return 0;
