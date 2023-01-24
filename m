Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9DF67941B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 10:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233404AbjAXJ0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 04:26:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232655AbjAXJ0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 04:26:40 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084D330DA;
        Tue, 24 Jan 2023 01:26:38 -0800 (PST)
Date:   Tue, 24 Jan 2023 09:26:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674552396;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ct2YeEw2dOfd6zgVilPjVDho3QHvvy7ymXWT7oYhq6k=;
        b=D2jT6PJEYpRxaEjNNCK5ma/f04N9eLvkhA8eBEiCspy7XkgP8DpUt53hzVqiABGIDasGQU
        m1moVyxLKYhL9aBDTulkchPjiBRMWdfvnGLWs8RxYp/899IVK+VO04reylhipQpVgJag3x
        3KPKgPPvKD5DYfTCl5+CW9GU2UCAmZQteRgL83UhPkB7rpsr0Ds+CnjgIxKU95ixVqF9s8
        y7XS4INYNt+nWnAssEXqvJmfQiB6wKZbiV/tXBDrFdi9oiAQ/Cas6eFG2NlWzCywljXDRj
        sxkUnk8Nc8lCUxXpYwyvGoNmYKUGje8rgrz02INKwaFIdI3aGHBXJ4kjlRSi/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674552396;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ct2YeEw2dOfd6zgVilPjVDho3QHvvy7ymXWT7oYhq6k=;
        b=RzRAsVnQJPN6Ifj2+u8SwuQR/WJe3p2Qzgi5oV+rY+zNCFS03XI1BDwpW+jLPCl0A1WQQk
        f/K0tTDagZmufbCQ==
From:   "tip-bot2 for Babu Moger" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Add interface to read mbm_local_bytes_config
Cc:     Babu Moger <babu.moger@amd.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230113152039.770054-11-babu.moger@amd.com>
References: <20230113152039.770054-11-babu.moger@amd.com>
MIME-Version: 1.0
Message-ID: <167455239634.4906.11848181129312661544.tip-bot2@tip-bot2>
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

Commit-ID:     73afb2d3ce2d7e0f9eee14e3f2b53d2bbfefd9c8
Gitweb:        https://git.kernel.org/tip/73afb2d3ce2d7e0f9eee14e3f2b53d2bbfefd9c8
Author:        Babu Moger <babu.moger@amd.com>
AuthorDate:    Fri, 13 Jan 2023 09:20:36 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 23 Jan 2023 17:40:27 +01:00

x86/resctrl: Add interface to read mbm_local_bytes_config

The event configuration can be viewed by the user by reading the configuration
file /sys/fs/resctrl/info/L3_MON/mbm_local_bytes_config.  The event
configuration settings are domain specific and will affect all the CPUs in the
domain.

Following are the types of events supported:

  ====  ===========================================================
  Bits   Description
  ====  ===========================================================
  6      Dirty Victims from the QOS domain to all types of memory
  5      Reads to slow memory in the non-local NUMA domain
  4      Reads to slow memory in the local NUMA domain
  3      Non-temporal writes to non-local NUMA domain
  2      Non-temporal writes to local NUMA domain
  1      Reads to memory in the non-local NUMA domain
  0      Reads to memory in the local NUMA domain
  ====  ===========================================================

By default, the mbm_local_bytes_config is set to 0x15 to count all the local
event types.

For example:

  $cat /sys/fs/resctrl/info/L3_MON/mbm_local_bytes_config
  0=0x15;1=0x15;2=0x15;3=0x15

In this case, the event mbm_local_bytes is configured with 0x15 on
domains 0 to 3.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/r/20230113152039.770054-11-babu.moger@amd.com
---
 arch/x86/kernel/cpu/resctrl/monitor.c  |  4 +++-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 16 ++++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 0ff45e3..28c6500 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -805,8 +805,10 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 			mbm_total_event.configurable = true;
 			mbm_config_rftype_init("mbm_total_bytes_config");
 		}
-		if (rdt_cpu_has(X86_FEATURE_CQM_MBM_LOCAL))
+		if (rdt_cpu_has(X86_FEATURE_CQM_MBM_LOCAL)) {
 			mbm_local_event.configurable = true;
+			mbm_config_rftype_init("mbm_local_bytes_config");
+		}
 	}
 
 	l3_mon_evt_init(r);
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index cd4e668..ad3c701 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1507,6 +1507,16 @@ static int mbm_total_bytes_config_show(struct kernfs_open_file *of,
 	return 0;
 }
 
+static int mbm_local_bytes_config_show(struct kernfs_open_file *of,
+				       struct seq_file *seq, void *v)
+{
+	struct rdt_resource *r = of->kn->parent->priv;
+
+	mbm_config_show(seq, r, QOS_L3_MBM_LOCAL_EVENT_ID);
+
+	return 0;
+}
+
 /* rdtgroup information files for one cache resource. */
 static struct rftype res_common_files[] = {
 	{
@@ -1612,6 +1622,12 @@ static struct rftype res_common_files[] = {
 		.seq_show	= mbm_total_bytes_config_show,
 	},
 	{
+		.name		= "mbm_local_bytes_config",
+		.mode		= 0444,
+		.kf_ops		= &rdtgroup_kf_single_ops,
+		.seq_show	= mbm_local_bytes_config_show,
+	},
+	{
 		.name		= "cpus",
 		.mode		= 0644,
 		.kf_ops		= &rdtgroup_kf_single_ops,
