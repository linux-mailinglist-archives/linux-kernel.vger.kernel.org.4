Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC87679426
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 10:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233496AbjAXJ1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 04:27:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233208AbjAXJ0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 04:26:41 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D9D10F7;
        Tue, 24 Jan 2023 01:26:41 -0800 (PST)
Date:   Tue, 24 Jan 2023 09:26:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674552397;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IMmH2nkQPBruaPwChM+jV4tzxmnqk+FPpcB4Po85YRA=;
        b=Um+XANj8rLy1UC9dQC18GaxHDuOGD3WjhFe1fZ4HX2CUoP8hjSYYlpD/Bx0zjYOk21huLt
        ohFrgrbjafA0UHsnyMN083n4jO8MIiiX1W5B7cTk8WBHKtQKrqYPmawnpgt5G9ZvmT+CAU
        gEo0QLWtAlW78ZwBY5btNqZZQkwNhrgWwNisZ7jVxmdXHczU4lLNbON5W3j0HfCwfEH9B4
        caF1DPgsU0qWHqyBB13pI/ht3TNrHNoAtKxbivU1BQJY8tXk+CbYyRN6lczfKTTF91maNJ
        Lhj50kl78GX0I/kfURVZC+oyoYZLR0Nl+b2h8gMRed14mr9orxYBwyd0YiCFew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674552397;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IMmH2nkQPBruaPwChM+jV4tzxmnqk+FPpcB4Po85YRA=;
        b=V8mxHR7avRpMdGbeBPks4Hmbzl16gVzq7K/y+IFDp8SJdXDi9BejjA2I/Ow4slwjyJxkbn
        7AcwQrYmr2mtLsBA==
From:   "tip-bot2 for Babu Moger" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Support monitor configuration
Cc:     Babu Moger <babu.moger@amd.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230113152039.770054-9-babu.moger@amd.com>
References: <20230113152039.770054-9-babu.moger@amd.com>
MIME-Version: 1.0
Message-ID: <167455239681.4906.11148306465942613946.tip-bot2@tip-bot2>
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

Commit-ID:     d507f83ced55eda848a3f397cf87b07ab11384b9
Gitweb:        https://git.kernel.org/tip/d507f83ced55eda848a3f397cf87b07ab11384b9
Author:        Babu Moger <babu.moger@amd.com>
AuthorDate:    Fri, 13 Jan 2023 09:20:34 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 23 Jan 2023 17:40:21 +01:00

x86/resctrl: Support monitor configuration

Add a new field in struct mon_evt to support Bandwidth Monitoring Event
Configuration (BMEC) and also update the "mon_features" display.

The resctrl file "mon_features" will display the supported events
and files that can be used to configure those events if monitor
configuration is supported.

Before the change:

  $ cat /sys/fs/resctrl/info/L3_MON/mon_features
  llc_occupancy
  mbm_total_bytes
  mbm_local_bytes

After the change when BMEC is supported:

  $ cat /sys/fs/resctrl/info/L3_MON/mon_features
  llc_occupancy
  mbm_total_bytes
  mbm_total_bytes_config
  mbm_local_bytes
  mbm_local_bytes_config

Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/r/20230113152039.770054-9-babu.moger@amd.com
---
 arch/x86/kernel/cpu/resctrl/internal.h | 2 ++
 arch/x86/kernel/cpu/resctrl/monitor.c  | 7 +++++++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 5 ++++-
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index f16b8bc..0605b04 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -52,11 +52,13 @@ DECLARE_STATIC_KEY_FALSE(rdt_mon_enable_key);
  * struct mon_evt - Entry in the event list of a resource
  * @evtid:		event id
  * @name:		name of the event
+ * @configurable:	true if the event is configurable
  * @list:		entry in &rdt_resource->evt_list
  */
 struct mon_evt {
 	enum resctrl_event_id	evtid;
 	char			*name;
+	bool			configurable;
 	struct list_head	list;
 };
 
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 5665ab9..cf7b6e5 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -800,6 +800,13 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 	if (ret)
 		return ret;
 
+	if (rdt_cpu_has(X86_FEATURE_BMEC)) {
+		if (rdt_cpu_has(X86_FEATURE_CQM_MBM_TOTAL))
+			mbm_total_event.configurable = true;
+		if (rdt_cpu_has(X86_FEATURE_CQM_MBM_LOCAL))
+			mbm_local_event.configurable = true;
+	}
+
 	l3_mon_evt_init(r);
 
 	r->mon_capable = true;
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 7516968..bf0bd43 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -998,8 +998,11 @@ static int rdt_mon_features_show(struct kernfs_open_file *of,
 	struct rdt_resource *r = of->kn->parent->priv;
 	struct mon_evt *mevt;
 
-	list_for_each_entry(mevt, &r->evt_list, list)
+	list_for_each_entry(mevt, &r->evt_list, list) {
 		seq_printf(seq, "%s\n", mevt->name);
+		if (mevt->configurable)
+			seq_printf(seq, "%s_config\n", mevt->name);
+	}
 
 	return 0;
 }
