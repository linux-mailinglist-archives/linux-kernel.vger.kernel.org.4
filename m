Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F9E5E8159
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 20:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbiIWSCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 14:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232542AbiIWSB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 14:01:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9684513B02B;
        Fri, 23 Sep 2022 11:01:50 -0700 (PDT)
Date:   Fri, 23 Sep 2022 18:01:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1663956108;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RP33hmU47JCBRwoHwo7pdXT4kEvbG5wa9NDdI5mr7kI=;
        b=NUU5ob5iKaAwbK5dI1fnRorO//SdGZ+jI8WrIhCjA20uac1gMbRxS1VljH/KlcHHHs9lD5
        jRjpjxhwGTDqs10bYA1YpUnWChB2SeppTzSJ0XOJah+74RTeCI723k5YLUoS0m7nYR/Cow
        4eb5V+PFSCsCHAMjGhOpGB/DYGoGYuZr+QA8yKqUs9om/JqI6RO0D6MTIVycyDvimaoNCr
        tRaGm4BrIwkvCKrdmNMxwHfBt48YEO65YacPUSKfHndACk1TdxAyuNP48PMyeKfVaFfaBW
        hkNH68EvxjlcQLu8ggJ8BmMeFBCCP6TpgKrThWdAas3v2mBfH2MWiqAKls1hBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1663956108;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RP33hmU47JCBRwoHwo7pdXT4kEvbG5wa9NDdI5mr7kI=;
        b=5Cmub1qeXiASyRFY1Y40j6gsOZmCXK0Dr7u67Vg5GLLrdwn53UTE3UJedoMXbKMTTcqt8E
        5BpNj7o26OnvJJBQ==
From:   "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Allow per-rmid arch private storage to be reset
Cc:     James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Xin Hao <xhao@linux.alibaba.com>,
        Cristian Marussi <cristian.marussi@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220902154829.30399-15-james.morse@arm.com>
References: <20220902154829.30399-15-james.morse@arm.com>
MIME-Version: 1.0
Message-ID: <166395610745.401.14525671499008071933.tip-bot2@tip-bot2>
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

Commit-ID:     fea62d370d7a1ba288d71d0cae7ad47c2a02b839
Gitweb:        https://git.kernel.org/tip/fea62d370d7a1ba288d71d0cae7ad47c2a02b839
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Fri, 02 Sep 2022 15:48:22 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 23 Sep 2022 12:49:04 +02:00

x86/resctrl: Allow per-rmid arch private storage to be reset

To abstract the rmid counters into a helper that returns the number
of bytes counted, architecture specific per-rmid state is needed.

It needs to be possible to reset this hidden state, as the values
may outlive the life of an rmid, or the mount time of the filesystem.

mon_event_read() is called with first = true when an rmid is first
allocated in mkdir_mondata_subdir(). Add resctrl_arch_reset_rmid()
and call it from __mon_event_count()'s rr->first check.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Jamie Iles <quic_jiles@quicinc.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Xin Hao <xhao@linux.alibaba.com>
Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Cristian Marussi <cristian.marussi@arm.com>
Link: https://lore.kernel.org/r/20220902154829.30399-15-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/internal.h | 18 +++----------
 arch/x86/kernel/cpu/resctrl/monitor.c  | 35 ++++++++++++++++++++++++-
 include/linux/resctrl.h                | 23 ++++++++++++++++-
 3 files changed, 62 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 4de8e5b..b34a140 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -22,14 +22,6 @@
 
 #define L2_QOS_CDP_ENABLE		0x01ULL
 
-/*
- * Event IDs are used to program IA32_QM_EVTSEL before reading event
- * counter from IA32_QM_CTR
- */
-#define QOS_L3_OCCUP_EVENT_ID		0x01
-#define QOS_L3_MBM_TOTAL_EVENT_ID	0x02
-#define QOS_L3_MBM_LOCAL_EVENT_ID	0x03
-
 #define CQM_LIMBOCHECK_INTERVAL	1000
 
 #define MBM_CNTR_WIDTH_BASE		24
@@ -73,7 +65,7 @@ DECLARE_STATIC_KEY_FALSE(rdt_mon_enable_key);
  * @list:		entry in &rdt_resource->evt_list
  */
 struct mon_evt {
-	u32			evtid;
+	enum resctrl_event_id	evtid;
 	char			*name;
 	struct list_head	list;
 };
@@ -90,9 +82,9 @@ struct mon_evt {
 union mon_data_bits {
 	void *priv;
 	struct {
-		unsigned int rid	: 10;
-		unsigned int evtid	: 8;
-		unsigned int domid	: 14;
+		unsigned int rid		: 10;
+		enum resctrl_event_id evtid	: 8;
+		unsigned int domid		: 14;
 	} u;
 };
 
@@ -100,7 +92,7 @@ struct rmid_read {
 	struct rdtgroup		*rgrp;
 	struct rdt_resource	*r;
 	struct rdt_domain	*d;
-	int			evtid;
+	enum resctrl_event_id	evtid;
 	bool			first;
 	u64			val;
 };
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 2d81b6c..e975514 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -137,7 +137,37 @@ static inline struct rmid_entry *__rmid_entry(u32 rmid)
 	return entry;
 }
 
-static u64 __rmid_read(u32 rmid, u32 eventid)
+static struct arch_mbm_state *get_arch_mbm_state(struct rdt_hw_domain *hw_dom,
+						 u32 rmid,
+						 enum resctrl_event_id eventid)
+{
+	switch (eventid) {
+	case QOS_L3_OCCUP_EVENT_ID:
+		return NULL;
+	case QOS_L3_MBM_TOTAL_EVENT_ID:
+		return &hw_dom->arch_mbm_total[rmid];
+	case QOS_L3_MBM_LOCAL_EVENT_ID:
+		return &hw_dom->arch_mbm_local[rmid];
+	}
+
+	/* Never expect to get here */
+	WARN_ON_ONCE(1);
+
+	return NULL;
+}
+
+void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_domain *d,
+			     u32 rmid, enum resctrl_event_id eventid)
+{
+	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
+	struct arch_mbm_state *am;
+
+	am = get_arch_mbm_state(hw_dom, rmid, eventid);
+	if (am)
+		memset(am, 0, sizeof(*am));
+}
+
+static u64 __rmid_read(u32 rmid, enum resctrl_event_id eventid)
 {
 	u64 val;
 
@@ -291,6 +321,9 @@ static u64 __mon_event_count(u32 rmid, struct rmid_read *rr)
 	struct mbm_state *m;
 	u64 chunks, tval;
 
+	if (rr->first)
+		resctrl_arch_reset_rmid(rr->r, rr->d, rmid, rr->evtid);
+
 	tval = __rmid_read(rmid, rr->evtid);
 	if (tval & (RMID_VAL_ERROR | RMID_VAL_UNAVAIL)) {
 		return tval;
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index f4c9101..8184567 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -32,6 +32,16 @@ enum resctrl_conf_type {
 
 #define CDP_NUM_TYPES	(CDP_DATA + 1)
 
+/*
+ * Event IDs, the values match those used to program IA32_QM_EVTSEL before
+ * reading IA32_QM_CTR on RDT systems.
+ */
+enum resctrl_event_id {
+	QOS_L3_OCCUP_EVENT_ID		= 0x01,
+	QOS_L3_MBM_TOTAL_EVENT_ID	= 0x02,
+	QOS_L3_MBM_LOCAL_EVENT_ID	= 0x03,
+};
+
 /**
  * struct resctrl_staged_config - parsed configuration to be applied
  * @new_ctrl:		new ctrl value to be loaded
@@ -210,4 +220,17 @@ u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
 int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d);
 void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d);
 
+/**
+ * resctrl_arch_reset_rmid() - Reset any private state associated with rmid
+ *			       and eventid.
+ * @r:		The domain's resource.
+ * @d:		The rmid's domain.
+ * @rmid:	The rmid whose counter values should be reset.
+ * @eventid:	The eventid whose counter values should be reset.
+ *
+ * This can be called from any CPU.
+ */
+void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_domain *d,
+			     u32 rmid, enum resctrl_event_id eventid);
+
 #endif /* _RESCTRL_H */
