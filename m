Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A97165E8170
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 20:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232739AbiIWSDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 14:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbiIWSCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 14:02:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B6513EAE2;
        Fri, 23 Sep 2022 11:01:57 -0700 (PDT)
Date:   Fri, 23 Sep 2022 18:01:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1663956116;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z9CW80iWLgnjITPiS0sWS9rX7vZ4yDIGYCnUF6hw2JM=;
        b=hz3BfWllYkO0hCcefqWuHHDzHdubE5/SHxHWWObUnLnzHMxZWIwpFJQgHwCCbNfxKoVwYy
        zAJbwZWkb70GhQPeAS9HziFP551Eh8IkwgzSOM+nyVgK+O9TgRwhKB8D+fBhd6I6C3WlFy
        /uNXDk4CjZV2MlM8xHzDSWdDRt+F1H6LRo08Kw8AGquukOS2rtXOOypF1miy+qSylNA6o8
        v/azMu1q6I8mVfjiabGl5AZ2fMDmOYebrd6MG2wKdmVaFS71v/f7TZDMapUfWmUT4GptVu
        80jOMihXS7rJ/azNEpE2aKp7i/X7co+7LIPw/deScMOQdnruAXFaCXnRNVvsyw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1663956116;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z9CW80iWLgnjITPiS0sWS9rX7vZ4yDIGYCnUF6hw2JM=;
        b=SZjIioEfi4XaunzUy+iHO+s4LD9C4qPX8VBNmmr97zuYHKO0P0dfnxTQ8yJtIveWoPAbrh
        uC25jlYIHL7OKXDA==
From:   "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Abstract and use supports_mba_mbps()
Cc:     James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Xin Hao <xhao@linux.alibaba.com>,
        Cristian Marussi <cristian.marussi@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220902154829.30399-8-james.morse@arm.com>
References: <20220902154829.30399-8-james.morse@arm.com>
MIME-Version: 1.0
Message-ID: <166395611482.401.3273433576845656401.tip-bot2@tip-bot2>
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

Commit-ID:     b045c215866393419fb960432ed6be69a0113ee1
Gitweb:        https://git.kernel.org/tip/b045c215866393419fb960432ed6be69a0113ee1
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Fri, 02 Sep 2022 15:48:15 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 22 Sep 2022 16:10:11 +02:00

x86/resctrl: Abstract and use supports_mba_mbps()

To determine whether the mba_MBps option to resctrl should be supported,
resctrl tests the boot CPUs' x86_vendor.

This isn't portable, and needs abstracting behind a helper so this check
can be part of the filesystem code that moves to /fs/.

Re-use the tests set_mba_sc() does to determine if the mba_sc is supported
on this system. An 'alloc_capable' test is added so that support for the
controls isn't implied by the 'delay_linear' property, which is always
true for MPAM. Because mbm_update() only update mba_sc if the mbm_local
counters are enabled, supports_mba_mbps() checks is_mbm_local_enabled().
(instead of using is_mbm_enabled(), which checks both).

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Jamie Iles <quic_jiles@quicinc.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Xin Hao <xhao@linux.alibaba.com>
Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Cristian Marussi <cristian.marussi@arm.com>
Link: https://lore.kernel.org/r/20220902154829.30399-8-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index b32ceff..4ee2626 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1890,17 +1890,26 @@ void rdt_domain_reconfigure_cdp(struct rdt_resource *r)
 }
 
 /*
- * Enable or disable the MBA software controller
- * which helps user specify bandwidth in MBps.
  * MBA software controller is supported only if
  * MBM is supported and MBA is in linear scale.
  */
+static bool supports_mba_mbps(void)
+{
+	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl;
+
+	return (is_mbm_local_enabled() &&
+		r->alloc_capable && is_mba_linear());
+}
+
+/*
+ * Enable or disable the MBA software controller
+ * which helps user specify bandwidth in MBps.
+ */
 static int set_mba_sc(bool mba_sc)
 {
 	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl;
 
-	if (!is_mbm_enabled() || !is_mba_linear() ||
-	    mba_sc == is_mba_sc(r))
+	if (!supports_mba_mbps() || mba_sc == is_mba_sc(r))
 		return -EINVAL;
 
 	r->membw.mba_sc = mba_sc;
@@ -2255,7 +2264,7 @@ static int rdt_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		ctx->enable_cdpl2 = true;
 		return 0;
 	case Opt_mba_mbps:
-		if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
+		if (!supports_mba_mbps())
 			return -EINVAL;
 		ctx->enable_mba_mbps = true;
 		return 0;
