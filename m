Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A41F6524D8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 17:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233527AbiLTQmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 11:42:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbiLTQly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 11:41:54 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577B76348
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 08:41:53 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-3b5da1b3130so147447767b3.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 08:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ddxu02Fh985Hkv+dloyjYYVxCvgT54odhdsQPfp8+qk=;
        b=dtZ2FoIE8vSOyMFWa4Ib2Ngomw3+orv/5Y7dkDgPUC3bNOs0ezgSwkeSn3FhzekFi5
         +gfuVW12SQftxn7Y2p8SU2QoFzuMboKd9662L8TlqhdYPbal3kndZYKlSL8Lm3Pt48C3
         jSk7Qn8qVjZK1npJX+olXvODzx4FFWIouP9vnCTrPUsEO72yhmY3hlujrTOPG4peRewT
         QtwOu9q8wR161mcr23qO/wVn1d9JMnB1g4Axt95/xCAoIQXYmiad6QEDsW9BZ46N/W72
         80kxTHh6SIvmVvEB8CGQXcUU4M4KuQFWz9xUo3FyqMKIraiN9tpfY4N89eA6Illhxt7F
         fpfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ddxu02Fh985Hkv+dloyjYYVxCvgT54odhdsQPfp8+qk=;
        b=fMOevg2Yu3CMPTbktfQbPgaIOG/iVSE3jFDJJnaw1chpyCbiYPJntFOJm82tRz99VP
         lY1qArxLO4+zJOgOj1KX3U9C0rDtQHqYVbov33cj9bIhbzgnQoq7n3OVjq1SZXp09JyQ
         PeqpDU4u1xZBVqMaCiG5HUW60g+5dThreiq8w1of11HIdFTyhnoOXjX2R5oCHGFfIgQO
         aWEvEzPwMQfGfy3G2FGHITcheASEZhNAG193GWVobRmF7cQ6rV/YKp7H0P2aZsxgo+Gc
         nJO2YAkuUw3t8hLLM75ckbvMG2mUtEJZ9sS9am6cK1m6kog/dxNURRKWj/nJfMMf+8Tw
         36EQ==
X-Gm-Message-State: AFqh2krD8ogSVz9xi8WK3CnNExzq6rKXy4fLJPj+gzf/DnBTPrG7dkDp
        biPMKkNXwaaN6n9bSkaLTfUTVxp+V3JLsD+gRw==
X-Google-Smtp-Source: AMrXdXt0FTT1E3EqyHHltyedu+Wxt+iC1y/i3hWsPNEPxDe5jTUfb0lz40Vl/NsOP57vv/aBVT9mBfAPZCyTvBl9sw==
X-Received: from peternewman10.zrh.corp.google.com ([2a00:79e0:9d:6:8175:5362:6754:c66d])
 (user=peternewman job=sendgmr) by 2002:a0d:e24b:0:b0:3d7:28d5:1c6f with SMTP
 id l72-20020a0de24b000000b003d728d51c6fmr1552006ywe.227.1671554512615; Tue,
 20 Dec 2022 08:41:52 -0800 (PST)
Date:   Tue, 20 Dec 2022 17:41:32 +0100
In-Reply-To: <20221220164132.443083-1-peternewman@google.com>
Mime-Version: 1.0
References: <20221220164132.443083-1-peternewman@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221220164132.443083-2-peternewman@google.com>
Subject: [PATCH v3 2/2] x86/resctrl: Avoid redundant counter read in __mon_event_count()
From:   Peter Newman <peternewman@google.com>
To:     reinette.chatre@intel.com, fenghua.yu@intel.com
Cc:     Babu.Moger@amd.com, bp@alien8.de, dave.hansen@linux.intel.com,
        eranian@google.com, hpa@zytor.com, james.morse@arm.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        quic_jiles@quicinc.com, tan.shaopeng@fujitsu.com,
        tglx@linutronix.de, x86@kernel.org,
        Peter Newman <peternewman@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
v3:
 - changelog clarifications suggested by Reinette
v2:
 (patch introduced)

v2: https://lore.kernel.org/lkml/20221214160856.2164207-2-peternewman@google.com/
---
 arch/x86/kernel/cpu/resctrl/monitor.c | 43 ++++++++++++---------------
 1 file changed, 19 insertions(+), 24 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 77538abeb72a..e708df478077 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -366,41 +366,36 @@ void free_rmid(u32 rmid)
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
-- 
2.39.0.314.g84b9a713c41-goog

