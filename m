Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6ED5E816F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 20:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbiIWSDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 14:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232752AbiIWSCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 14:02:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9185513E7E1;
        Fri, 23 Sep 2022 11:01:58 -0700 (PDT)
Date:   Fri, 23 Sep 2022 18:01:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1663956117;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fsAIyuj4x0iEQg9cqv5G9BqMj5jKXDRAGq1wmpP6RCM=;
        b=KfMpyNoyBP/Eq2IcUPPxbiqfzamWtBMQzsYgFBZi2lqliOlSHXHAYKFuAOr4TSGJMyesfH
        rfgif7rfc7VFet8pY06dT4nUL6qhjfViPX6cDpnU5JUSMNNQcL/JwupN26ellSiSgHX+Sy
        O8ZsFOSg6vJBdIdRpP0ZredNGorrbzBh/Av8i4JEGjxMps88HgFY68+CQi3g+qIjkWyIKa
        xG6W1d2imYY2lNpgy6NXAf7k9Pba8M1ub08ziMu01JwY1R3zkMDo/bD0z6kWtjs4gNx4Wz
        Zf2wd7X7I6JjOkkrMJrFK2A5xJy6XcMV33d7gz+WHoiBFmfASrBOrGfoYqqV2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1663956117;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fsAIyuj4x0iEQg9cqv5G9BqMj5jKXDRAGq1wmpP6RCM=;
        b=lmrKcNPW3vmwjQbsNxCOvnVuLCII87nnZpPrUNVGhtkEqWIK7Uug9lVFOd770jOs97qqhF
        QBHCt1EyFy6CajAg==
From:   "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Remove set_mba_sc()s control array
 re-initialisation
Cc:     James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Xin Hao <xhao@linux.alibaba.com>,
        Cristian Marussi <cristian.marussi@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220902154829.30399-7-james.morse@arm.com>
References: <20220902154829.30399-7-james.morse@arm.com>
MIME-Version: 1.0
Message-ID: <166395611583.401.8392213412380309845.tip-bot2@tip-bot2>
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

Commit-ID:     1644dfe727cb042ef7f2e773015747954fd0e746
Gitweb:        https://git.kernel.org/tip/1644dfe727cb042ef7f2e773015747954fd0e746
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Fri, 02 Sep 2022 15:48:14 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 22 Sep 2022 16:08:20 +02:00

x86/resctrl: Remove set_mba_sc()s control array re-initialisation

set_mba_sc() enables the 'software controller' to regulate the bandwidth
based on the byte counters. This can be managed entirely in the parts
of resctrl that move to /fs/, without any extra support from the
architecture specific code. set_mba_sc() is called by rdt_enable_ctx()
during mount and unmount. It currently resets the arch code's ctrl_val[]
and mbps_val[] arrays.

The ctrl_val[] was already reset when the domain was created, and by
reset_all_ctrls() when the filesystem was last unmounted. Doing the work
in set_mba_sc() is not necessary as the values are already at their
defaults due to the creation of the domain, or were previously reset
during umount(), or are about to reset during umount().

Add a reset of the mbps_val[] in reset_all_ctrls(), allowing the code in
set_mba_sc() that reaches in to the architecture specific structures to
be removed.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Jamie Iles <quic_jiles@quicinc.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Xin Hao <xhao@linux.alibaba.com>
Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Cristian Marussi <cristian.marussi@arm.com>
Link: https://lore.kernel.org/r/20220902154829.30399-7-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 5830905..b32ceff 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1898,18 +1898,12 @@ void rdt_domain_reconfigure_cdp(struct rdt_resource *r)
 static int set_mba_sc(bool mba_sc)
 {
 	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl;
-	struct rdt_hw_domain *hw_dom;
-	struct rdt_domain *d;
 
 	if (!is_mbm_enabled() || !is_mba_linear() ||
 	    mba_sc == is_mba_sc(r))
 		return -EINVAL;
 
 	r->membw.mba_sc = mba_sc;
-	list_for_each_entry(d, &r->domains, list) {
-		hw_dom = resctrl_to_arch_dom(d);
-		setup_default_ctrlval(r, hw_dom->ctrl_val, hw_dom->mbps_val);
-	}
 
 	return 0;
 }
@@ -2327,8 +2321,10 @@ static int reset_all_ctrls(struct rdt_resource *r)
 		hw_dom = resctrl_to_arch_dom(d);
 		cpumask_set_cpu(cpumask_any(&d->cpu_mask), cpu_mask);
 
-		for (i = 0; i < hw_res->num_closid; i++)
+		for (i = 0; i < hw_res->num_closid; i++) {
 			hw_dom->ctrl_val[i] = r->default_ctrl;
+			hw_dom->mbps_val[i] = MBA_MAX_MBPS;
+		}
 	}
 	cpu = get_cpu();
 	/* Update CBM on this cpu if it's in cpu_mask. */
