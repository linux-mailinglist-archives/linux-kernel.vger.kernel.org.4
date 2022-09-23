Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4DB35E816D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 20:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbiIWSDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 14:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232650AbiIWSCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 14:02:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751CA13EEAA;
        Fri, 23 Sep 2022 11:02:00 -0700 (PDT)
Date:   Fri, 23 Sep 2022 18:01:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1663956119;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wk9ByOGWhYGaJSRveqF77XxGxLJRdBox3MOCpChVo5g=;
        b=pXNEkCsMLOWVqwACB928I4Qf9+Nn5c/OKC6troXVG4kaLcuBonXUiME3gxPhgaWwUz3x+n
        Gvcil2hdxnDyf+7ZwumhxMGWdRHqHSfj02JW6EZEu1KK1Q4cProeddvPpO08jC/sjqgYGv
        v9IkB9wFs2iy6SqmQ944L1nARonHAnW1NY1hKoFjDbHA4uhHnskYU3+qWifEewz1tPPqsY
        ORPh0ql5CIyCe8kEADn3FRNJ1SkmlFqx6+RVIxf2z/g+1mXwl8XNjk+5Kr5F5Q4PriwWfQ
        lKQgRX0e+OzIZ6RLgXPue+OUpnuCTW56FmiUYXHPUQdQf3jC3kItgqFlnXuNKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1663956119;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wk9ByOGWhYGaJSRveqF77XxGxLJRdBox3MOCpChVo5g=;
        b=60sXgjXKZHJOTLmlJNP1gzcl/jgbGt9iDv7Un76jdaOd14QM69GDHbkrq3RSPSPOYconjy
        lApsGKa/rl+dC3Bg==
From:   "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Group struct rdt_hw_domain cleanup
Cc:     James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Xin Hao <xhao@linux.alibaba.com>,
        Cristian Marussi <cristian.marussi@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220902154829.30399-5-james.morse@arm.com>
References: <20220902154829.30399-5-james.morse@arm.com>
MIME-Version: 1.0
Message-ID: <166395611790.401.175925430801977412.tip-bot2@tip-bot2>
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

Commit-ID:     7add3af4178d9e25afc8d990a7d1000ccb22b6a0
Gitweb:        https://git.kernel.org/tip/7add3af4178d9e25afc8d990a7d1000ccb22b6a0
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Fri, 02 Sep 2022 15:48:12 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 22 Sep 2022 15:27:15 +02:00

x86/resctrl: Group struct rdt_hw_domain cleanup

domain_add_cpu() and domain_remove_cpu() need to kfree() the child
arrays that were allocated by domain_setup_ctrlval().

As this memory is moved around, and new arrays are created, adjusting
the error handling cleanup code becomes noisier.

To simplify this, move all the kfree() calls into a domain_free() helper.
This depends on struct rdt_hw_domain being kzalloc()d, allowing it to
unconditionally kfree() all the child arrays.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Jamie Iles <quic_jiles@quicinc.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Xin Hao <xhao@linux.alibaba.com>
Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Cristian Marussi <cristian.marussi@arm.com>
Link: https://lore.kernel.org/r/20220902154829.30399-5-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/core.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 25f3014..e37889f 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -414,6 +414,13 @@ void setup_default_ctrlval(struct rdt_resource *r, u32 *dc, u32 *dm)
 	}
 }
 
+static void domain_free(struct rdt_hw_domain *hw_dom)
+{
+	kfree(hw_dom->ctrl_val);
+	kfree(hw_dom->mbps_val);
+	kfree(hw_dom);
+}
+
 static int domain_setup_ctrlval(struct rdt_resource *r, struct rdt_domain *d)
 {
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
@@ -488,7 +495,7 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
 	rdt_domain_reconfigure_cdp(r);
 
 	if (r->alloc_capable && domain_setup_ctrlval(r, d)) {
-		kfree(hw_dom);
+		domain_free(hw_dom);
 		return;
 	}
 
@@ -497,9 +504,7 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
 	err = resctrl_online_domain(r, d);
 	if (err) {
 		list_del(&d->list);
-		kfree(hw_dom->ctrl_val);
-		kfree(hw_dom->mbps_val);
-		kfree(hw_dom);
+		domain_free(hw_dom);
 	}
 }
 
@@ -547,12 +552,10 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
 		if (d->plr)
 			d->plr->d = NULL;
 
-		kfree(hw_dom->ctrl_val);
-		kfree(hw_dom->mbps_val);
 		bitmap_free(d->rmid_busy_llc);
 		kfree(d->mbm_total);
 		kfree(d->mbm_local);
-		kfree(hw_dom);
+		domain_free(hw_dom);
 		return;
 	}
 
