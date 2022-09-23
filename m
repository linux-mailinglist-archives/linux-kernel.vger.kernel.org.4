Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED91C5E814F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 20:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbiIWSBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 14:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbiIWSBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 14:01:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B3611E5CC;
        Fri, 23 Sep 2022 11:01:43 -0700 (PDT)
Date:   Fri, 23 Sep 2022 18:01:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1663956102;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h5kvcIo0g99vR5yOZYWaTuCCzeDg6P86/sFcyfvHn2g=;
        b=r73Y456BdCzPGga9U9RWiUcg4c9FR3fD4Wq5c1IGiUKrH6I2pSTsBvYONv5FyZbOlLJBzq
        tqOo4IH8vkHKozWj2KG5l7uzK5sLEq9Ek9DjmH1rdmiQANrakgERQGf23it18Ww6qf0QEn
        Tj14ebjlMScAkbhg+kMu16lTUl7cMBYcj85Q5ncbgWrw/TuktcMM+rKkfMuX+l7NPYAMr4
        AeMJBpv3Eicvsv57XyGZxrIhaUqvwue5jGrR6RRvqK94rD01YmhTZ8srBqJKALqGHtVVY9
        AviAzvFJMQnduI/4kiMvJje+gt8o8ZiunkBZp5tgS6kyrXUva4gzR9yTvdYYMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1663956102;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h5kvcIo0g99vR5yOZYWaTuCCzeDg6P86/sFcyfvHn2g=;
        b=lq5dvc8IZt8xcWo1rabpRaqIta0Njlm4MTuYJZa01UQ6+HYbUAjWkNyPDnn737YYStmNcf
        hLpMQCXBzk8aE7CA==
From:   "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Add resctrl_rmid_realloc_limit to
 abstract x86's boot_cpu_data
Cc:     James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Xin Hao <xhao@linux.alibaba.com>,
        Cristian Marussi <cristian.marussi@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220902154829.30399-21-james.morse@arm.com>
References: <20220902154829.30399-21-james.morse@arm.com>
MIME-Version: 1.0
Message-ID: <166395610108.401.14386026108602409429.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     d80975e264c8f01518890f3d91ab5bada8fa7f5e
Gitweb:        https://git.kernel.org/tip/d80975e264c8f01518890f3d91ab5bada8fa7f5e
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Fri, 02 Sep 2022 15:48:28 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 23 Sep 2022 14:24:16 +02:00

x86/resctrl: Add resctrl_rmid_realloc_limit to abstract x86's boot_cpu_data

resctrl_rmid_realloc_threshold can be set by user-space. The maximum
value is specified by the architecture.

Currently max_threshold_occ_write() reads the maximum value from
boot_cpu_data.x86_cache_size, which is not portable to another
architecture.

Add resctrl_rmid_realloc_limit to describe the maximum size in bytes
that user-space can set the threshold to.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Jamie Iles <quic_jiles@quicinc.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Xin Hao <xhao@linux.alibaba.com>
Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Cristian Marussi <cristian.marussi@arm.com>
Link: https://lore.kernel.org/r/20220902154829.30399-21-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/monitor.c  |  9 +++++++--
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |  2 +-
 include/linux/resctrl.h                |  1 +
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index e91afe9..8d15568 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -67,6 +67,11 @@ unsigned int rdt_mon_features;
  */
 unsigned int resctrl_rmid_realloc_threshold;
 
+/*
+ * This is the maximum value for the reallocation threshold, in bytes.
+ */
+unsigned int resctrl_rmid_realloc_limit;
+
 #define CF(cf)	((unsigned long)(1048576 * (cf) + 0.5))
 
 /*
@@ -747,10 +752,10 @@ int rdt_get_mon_l3_config(struct rdt_resource *r)
 {
 	unsigned int mbm_offset = boot_cpu_data.x86_cache_mbm_width_offset;
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
-	unsigned int cl_size = boot_cpu_data.x86_cache_size;
 	unsigned int threshold;
 	int ret;
 
+	resctrl_rmid_realloc_limit = boot_cpu_data.x86_cache_size * 1024;
 	hw_res->mon_scale = boot_cpu_data.x86_cache_occ_scale;
 	r->num_rmid = boot_cpu_data.x86_cache_max_rmid + 1;
 	hw_res->mbm_width = MBM_CNTR_WIDTH_BASE;
@@ -767,7 +772,7 @@ int rdt_get_mon_l3_config(struct rdt_resource *r)
 	 *
 	 * For a 35MB LLC and 56 RMIDs, this is ~1.8% of the LLC.
 	 */
-	threshold = cl_size * 1024 / r->num_rmid;
+	threshold = resctrl_rmid_realloc_limit / r->num_rmid;
 
 	/*
 	 * Because num_rmid may not be a power of two, round the value
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 849bdec..e5a48f0 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1059,7 +1059,7 @@ static ssize_t max_threshold_occ_write(struct kernfs_open_file *of,
 	if (ret)
 		return ret;
 
-	if (bytes > (boot_cpu_data.x86_cache_size * 1024))
+	if (bytes > resctrl_rmid_realloc_limit)
 		return -EINVAL;
 
 	resctrl_rmid_realloc_threshold = resctrl_arch_round_mon_val(bytes);
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 9995d04..cb857f7 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -251,5 +251,6 @@ void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_domain *d,
 			     u32 rmid, enum resctrl_event_id eventid);
 
 extern unsigned int resctrl_rmid_realloc_threshold;
+extern unsigned int resctrl_rmid_realloc_limit;
 
 #endif /* _RESCTRL_H */
