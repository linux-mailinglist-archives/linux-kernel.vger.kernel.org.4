Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92F15E8154
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 20:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232677AbiIWSCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 14:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbiIWSBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 14:01:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C146E74DCD;
        Fri, 23 Sep 2022 11:01:45 -0700 (PDT)
Date:   Fri, 23 Sep 2022 18:01:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1663956104;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NDti1OyV39+sncfhS7GCFMc6IkmajXXZ1O3NDdOj3fQ=;
        b=iLQR1PEmovgcq9oWgvDb8h0x8CF2IzuuLTUjkbFzQ8n56tATK4DvM8H7acGElH8SedHBVb
        bHw62rt0w11FtDz76aNl7pZTLs/Ba7KcSGRfZtQ53BfmvEqaA6jLTIaV52OKLYW+frNwjn
        Khfr5+WsHgObXzKP7UhOgL7a4mPj5S+AQQCy28bbwmrt1AHxJkojosDqxfPSGigzcsrBD5
        X7Tfh/yV2vT+JaaePNehQUJB28gApGsQTodikzV9IOw13CDByS8ipGUG+Z7ATaecRjcRWb
        uPyWlAhDZtyryQpvGhQ+ribe/fUNYr0G6sqeJs2r1TRwbi/cXqBdHafy3v2dXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1663956104;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NDti1OyV39+sncfhS7GCFMc6IkmajXXZ1O3NDdOj3fQ=;
        b=W1d4e8XgPC3ZlTM6bGPwtL7OueCuxpj6SXeiCT6/V0e799hDQiooZgxEGDIcmSjW+AkAnL
        Ysk+k8T9ZG4H/GAQ==
From:   "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Move get_corrected_mbm_count() into
 resctrl_arch_rmid_read()
Cc:     James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Xin Hao <xhao@linux.alibaba.com>,
        Cristian Marussi <cristian.marussi@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220902154829.30399-19-james.morse@arm.com>
References: <20220902154829.30399-19-james.morse@arm.com>
MIME-Version: 1.0
Message-ID: <166395610324.401.11983388148256206579.tip-bot2@tip-bot2>
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

Commit-ID:     38f72f50d6498ee60ac89deff3686e34ce0c2a32
Gitweb:        https://git.kernel.org/tip/38f72f50d6498ee60ac89deff3686e34ce0c2a32
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Fri, 02 Sep 2022 15:48:26 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 23 Sep 2022 14:22:53 +02:00

x86/resctrl: Move get_corrected_mbm_count() into resctrl_arch_rmid_read()

resctrl_arch_rmid_read() is intended as the function that an
architecture agnostic resctrl filesystem driver can use to
read a value in bytes from a counter. Currently the function returns
the MBM values in chunks directly from hardware. When reading a bandwidth
counter, get_corrected_mbm_count() must be used to correct the
value read.

get_corrected_mbm_count() is architecture specific, this work should be
done in resctrl_arch_rmid_read().

Move the function calls. This allows the resctrl filesystems's chunks
value to be removed in favour of the architecture private version.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Jamie Iles <quic_jiles@quicinc.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Xin Hao <xhao@linux.alibaba.com>
Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Cristian Marussi <cristian.marussi@arm.com>
Link: https://lore.kernel.org/r/20220902154829.30399-19-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/internal.h | 4 ++--
 arch/x86/kernel/cpu/resctrl/monitor.c  | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 8039e8a..bdb55c2 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -280,14 +280,12 @@ struct rftype {
 
 /**
  * struct mbm_state - status for each MBM counter in each domain
- * @chunks:	Total data moved (multiply by rdt_group.mon_scale to get bytes)
  * @prev_bw_chunks: Previous chunks value read for bandwidth calculation
  * @prev_bw:	The most recent bandwidth in MBps
  * @delta_bw:	Difference between the current and previous bandwidth
  * @delta_comp:	Indicates whether to compute the delta_bw
  */
 struct mbm_state {
-	u64	chunks;
 	u64	prev_bw_chunks;
 	u32	prev_bw;
 	u32	delta_bw;
@@ -297,10 +295,12 @@ struct mbm_state {
 /**
  * struct arch_mbm_state - values used to compute resctrl_arch_rmid_read()s
  *			   return value.
+ * @chunks:	Total data moved (multiply by rdt_group.mon_scale to get bytes)
  * @prev_msr:	Value of IA32_QM_CTR last time it was read for the RMID used to
  *		find this struct.
  */
 struct arch_mbm_state {
+	u64	chunks;
 	u64	prev_msr;
 };
 
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 862a446..27bb494 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -204,7 +204,9 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
 
 	am = get_arch_mbm_state(hw_dom, rmid, eventid);
 	if (am) {
-		*val = mbm_overflow_count(am->prev_msr, msr_val, hw_res->mbm_width);
+		am->chunks += mbm_overflow_count(am->prev_msr, msr_val,
+						 hw_res->mbm_width);
+		*val = get_corrected_mbm_count(rmid, am->chunks);
 		am->prev_msr = msr_val;
 	} else {
 		*val = msr_val;
@@ -374,9 +376,7 @@ static int __mon_event_count(u32 rmid, struct rmid_read *rr)
 		return 0;
 	}
 
-	m->chunks += tval;
-
-	rr->val += get_corrected_mbm_count(rmid, m->chunks);
+	rr->val += tval;
 
 	return 0;
 }
