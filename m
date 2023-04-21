Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 711236EACAB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 16:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbjDUOTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 10:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232400AbjDUOSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 10:18:08 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2B413C0B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 07:18:05 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-54f855ecb9cso23424457b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 07:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682086685; x=1684678685;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=W6639SD0H0EtLqB4ey0Z/SCfQQd2BwEFoKtAHXawttg=;
        b=F99tHTPdoQ7C9Ix3lhzgS+44QzUBAXokIJ7FiF1lJ2iBIJ3DQYl/MLze6AckhIXvdc
         Hn1QgxpX5Y0KkD6eTmkiklywcUgCl65/mQAQ80srV+i65MYkbmqxNV6Wuv9hhHPEJgYj
         hj+Bvt+Bxx/5LGd0tPAx/FTKSotEpkvZ8kjx5jYAVY0+ZyZBlSdJuheD1Xo4AwSjku6L
         dt04yxCX5IT74kYysO2NmG5vOOht4o5PPfR6VATD2lZ3ZJXCc50kxU8yoAvhAHZBevKb
         84pRmjxRdUbiYE/VJLBlphZEamluppZApe1XIXNcNQGXa6KhQTOAtfRelsZKUhgS7kOl
         u/dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682086685; x=1684678685;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W6639SD0H0EtLqB4ey0Z/SCfQQd2BwEFoKtAHXawttg=;
        b=c+LP5NPfcppbn3UNioXDM1axzdkS5eBWOOXAkp8WLK5fsF0vMwFo/fvEqnEf4su+nB
         RdyMcobBcbmxBC9BLjJqGt6oYbx5hOxCJEJhYv+YuRDoqzLZDfSY473JLqqStfydXdKG
         SvlBJmqfuTXRBsDH1IwGL625V6vhV9IHBJGyfQGg6AGsnswHu+THh9ydGKIo+nWxQwM9
         SShkAdQbF2S1Vnt8iurhld+whY55a51yOOXs7ggT3i5zlJZmPO0tdQvKr1hIVEZfFV3U
         QmSIgSIHGyd7SnPjCc3ibkrcdC/AM2bmhF9Yk3sdfkNPMH4gVUAnoe0+Ck76ZwbIfjYb
         ruLg==
X-Gm-Message-State: AAQBX9fZgTLcS1tpykYcKFe3w9bZGWi8YmSSAP9zINkUjn6UxgT9vPAz
        Ua28HditBgjkPzjJ6UID09vEQnUvG9RZD1Fgaw==
X-Google-Smtp-Source: AKy350Zqg4pAFdUI6twozs01y17oAXKmGbDox7mIzThIQRrL0cyze52D8zeEHvJU+8u/Ow1KWrdOeo4oh9evn0a9dA==
X-Received: from peternewman0.zrh.corp.google.com ([2a00:79e0:9d:6:c801:daa2:428c:d3fc])
 (user=peternewman job=sendgmr) by 2002:a81:b149:0:b0:54f:bb37:4a1c with SMTP
 id p70-20020a81b149000000b0054fbb374a1cmr1291578ywh.8.1682086684958; Fri, 21
 Apr 2023 07:18:04 -0700 (PDT)
Date:   Fri, 21 Apr 2023 16:17:21 +0200
In-Reply-To: <20230421141723.2405942-1-peternewman@google.com>
Mime-Version: 1.0
References: <20230421141723.2405942-1-peternewman@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230421141723.2405942-8-peternewman@google.com>
Subject: [PATCH v1 7/9] x86/resctrl: Assign HW RMIDs to CPUs for soft RMID
From:   Peter Newman <peternewman@google.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>
Cc:     Babu Moger <babu.moger@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Stephane Eranian <eranian@google.com>,
        James Morse <james.morse@arm.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Peter Newman <peternewman@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To implement soft RMIDs, each CPU needs a HW RMID that is unique within
its L3 cache domain. This is the minimum number of RMIDs needed to
monitor all CPUs.

This is accomplished by determining the rank of each CPU's mask bit
within its L3 shared_cpu_mask in resctrl_online_cpu().

Signed-off-by: Peter Newman <peternewman@google.com>
---
 arch/x86/kernel/cpu/resctrl/core.c | 39 +++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 47b1c37a81f8..b0d873231b1e 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -596,6 +596,38 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
 	}
 }
 
+/* Assign each CPU an RMID that is unique within its cache domain. */
+static u32 determine_hw_rmid_for_cpu(int cpu)
+{
+	struct cpu_cacheinfo *ci = get_cpu_cacheinfo(cpu);
+	struct cacheinfo *l3ci = NULL;
+	u32 rmid;
+	int i;
+
+	/* Locate the cacheinfo for this CPU's L3 cache. */
+	for (i = 0; i < ci->num_leaves; i++) {
+		if (ci->info_list[i].level == 3 &&
+		    (ci->info_list[i].attributes & CACHE_ID)) {
+			l3ci = &ci->info_list[i];
+			break;
+		}
+	}
+	WARN_ON(!l3ci);
+
+	if (!l3ci)
+		return 0;
+
+	/* Use the position of cpu in its shared_cpu_mask as its RMID. */
+	rmid = 0;
+	for_each_cpu(i, &l3ci->shared_cpu_map) {
+		if (i == cpu)
+			break;
+		rmid++;
+	}
+
+	return rmid;
+}
+
 static void clear_closid_rmid(int cpu)
 {
 	struct resctrl_pqr_state *state = this_cpu_ptr(&pqr_state);
@@ -604,7 +636,12 @@ static void clear_closid_rmid(int cpu)
 	state->default_rmid = 0;
 	state->cur_closid = 0;
 	state->cur_rmid = 0;
-	wrmsr(MSR_IA32_PQR_ASSOC, 0, 0);
+	state->hw_rmid = 0;
+
+	if (static_branch_likely(&rdt_soft_rmid_enable_key))
+		state->hw_rmid = determine_hw_rmid_for_cpu(cpu);
+
+	wrmsr(MSR_IA32_PQR_ASSOC, state->hw_rmid, 0);
 }
 
 static int resctrl_online_cpu(unsigned int cpu)
-- 
2.40.0.634.g4ca3ef3211-goog

