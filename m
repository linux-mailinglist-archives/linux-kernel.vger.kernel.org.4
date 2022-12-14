Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF2964CDB4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 17:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238407AbiLNQJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 11:09:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238763AbiLNQJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 11:09:25 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EECC23BE2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 08:09:24 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-3ceb4c331faso2692977b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 08:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VGK0E4ycnuqQrwZSaCfYQzl+oEBemoUae4RgweF6XeQ=;
        b=XGAKWHiuWQFlu6EENpET/7efF/JlU9+FcquL8yQ4TGnbRqLL65ipCmxc3rOvoxOka/
         S6QrwJSh7Fjj7peGO0pPnSrfiQcwQNwQezXo7H4yUSsDHjPCa7RVKgkBnOUP3nIgKxBZ
         prMzsbdmMXNx3oSpVLq9WUva71y+kaEx05Q+Otqupx5ZRJ2RQ/dZMOgOavcsclDMB7Ci
         YogqNiUBwBxKg0rSZ4a8HdyIPxjxeLR+dmKOJEdwf+HRjTa7rGe6eJ40zxW2Z0H+FM6d
         NZUhgw6UjnMaPsYXWkVVFzwtsA7ybPBT8VWNjEG7B5YUvZKrogSQ8fIHARqbYW8hQJ6y
         DjJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VGK0E4ycnuqQrwZSaCfYQzl+oEBemoUae4RgweF6XeQ=;
        b=Lwr68T9fnubWZlncj2KbxmCuijZ0QTdAjmpxNxmVPWbHahRVlTK1oRnkErhgj9VpQS
         Roc+Ez3Z5qwmn/u4zW2Ku3ILhqYpYBcuT7gjGXkBf2ir51PUtG8Bs3M1aORLQNfB9r4K
         09zXX1uRNenW3XtSVXVYV8hYVWVvoiEmgbpkT8w75lmzEoRpPifoqMv4JYD0qWlBSHYP
         v3BncV9Op6eVNUIJ9jNhEjzAXDFVwELaXtg2s5AZjx6j5vC5D++dpeFVHWf6XOQ3n6Qh
         YtM9EkyDPmXIyWw65wqGGx0uNsF+hhoiy3jj1f5ne8F0r7yRA2U7+VM45J65HceEV8FO
         VpJQ==
X-Gm-Message-State: ANoB5pnumZYc5DEZuINvj+ShU2bpJUtXejijhN/3AfMT6BC4smbYZEDc
        ZNpmvyDqAtftafHt+JcwPEUR0BT99+iN3/eu1g==
X-Google-Smtp-Source: AA0mqf77KJ67F5HAQFySn17fQ9wG6CMCnQ/0Z9VqeKejeVmk8QOh9V8HQdsIgvGCA//776i30gaIHbyapnpSifhwTw==
X-Received: from peternewman-vh.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:30cc])
 (user=peternewman job=sendgmr) by 2002:a25:9006:0:b0:705:2982:c937 with SMTP
 id s6-20020a259006000000b007052982c937mr10617289ybl.420.1671034163807; Wed,
 14 Dec 2022 08:09:23 -0800 (PST)
Date:   Wed, 14 Dec 2022 17:08:56 +0100
In-Reply-To: <20221214160856.2164207-1-peternewman@google.com>
Mime-Version: 1.0
References: <20221214160856.2164207-1-peternewman@google.com>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
Message-ID: <20221214160856.2164207-2-peternewman@google.com>
Subject: [PATCH v2 2/2] x86/resctrl: Avoid redundant counter read in __mon_event_count()
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
counter is unnecessary.

Following return from resctrl_arch_reset_rmid(), just clear the
mbm_state and return.

Also, move the mbm_state lookup into the rr->first case, as it's not
needed for regular event count reads: the QOS_L3_OCCUP_EVENT_ID case was
redundant with the accumulating logic at the end of the function.

Signed-off-by: Peter Newman <peternewman@google.com>
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
2.39.0.rc1.256.g54fd8350bd-goog

