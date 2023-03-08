Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01BB16B0853
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 14:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbjCHNTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 08:19:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231435AbjCHNS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 08:18:28 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9558160A81
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 05:15:07 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id m31-20020a05600c3b1f00b003e9de8c95easo5861816wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 05:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678281305;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=geKZ0b9prEjt0Vyx6WHp2kYThqOYNTypo8c4MCHr/Ug=;
        b=htYNEPtk6BdX8z3OZd8E1kcZH+GqH/PCqaiMJMhmag7qj17psAkY2Q4aOOaLwjtnKA
         ICKCRsPwtxEk2RNuOTIBzhMA1Mt+gL91pBWSMnnb/hZhK5eR+5irRQ394J1SuHaRRivX
         2RniGgFV5szp0oEbB1EmyNEweQaK2vHlHyMQi6pVlQP0lBxP53m0WvQheg9e6AIIyv7g
         9ZrVgv/xplCIwomQ2sIwvZW3P6V8VMF0JxHIMBX4cJjdMi4mtmY+z3fdEn1+9Oyn1kcz
         X4HAN3S6l/Y85mtD4ZMZic7/xgPPDaIN58ioUIRx5QMh3VK14D+BufUr1a0h5R2Otf/2
         31sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678281305;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=geKZ0b9prEjt0Vyx6WHp2kYThqOYNTypo8c4MCHr/Ug=;
        b=38X34LkOqMktEvrzfnicyJ0vwLaqDgO4CGb3/QhzWOZmlOqB8lAksx687/w/XEtUTy
         yvTTksGWcA+LVJuXTNpLCmKLQuqxOl6BqajatfTs7TM9j5Tu6+CaX3Sjbacv6vW9dL2Y
         RXUqOh3JGwf3PXdPjfr5UAr++dUKOVMpxwMhgFL14cieBTGYgqvGytdn4yr9PmfTgGiL
         /oPEZ2HiDih8gcV6wasscqB/SX5AXse4kQYYNizNRf/FczDH1HHAqKgFLM4Kz7vArKb/
         n+fWgvPB9xOm+FGGrhRenrxLqsAoJQnSb8Nw1y5LvyMBhEt9rPsaBUk1Y6J20jtwEr5u
         X1zQ==
X-Gm-Message-State: AO0yUKWzyzyoJfZVQMVQZOJJg8LRkjTgc5u2h69D7dT2SVkxExLWseyW
        QaFLJUKHtrGSWZb71mJ998Ms9d7YYtGB6F0JfQ==
X-Google-Smtp-Source: AK7set/d3HjzTgsMqD9lr8qdZINBXsOe+YOvLtFpbnHdwJj+9iGVz8gC4oUpjeqi7T8S/Lx4gTwbMfv8Y/THdYqPZw==
X-Received: from peternewman-vh.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:30cc])
 (user=peternewman job=sendgmr) by 2002:a5d:608a:0:b0:2c8:2cbc:7a2e with SMTP
 id w10-20020a5d608a000000b002c82cbc7a2emr3545133wrt.4.1678281305672; Wed, 08
 Mar 2023 05:15:05 -0800 (PST)
Date:   Wed,  8 Mar 2023 14:14:50 +0100
In-Reply-To: <20230308131452.383914-1-peternewman@google.com>
Mime-Version: 1.0
References: <20230308131452.383914-1-peternewman@google.com>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Message-ID: <20230308131452.383914-2-peternewman@google.com>
Subject: [PATCH v4 1/3] x86/resctrl: Factor rdtgroup lock for multi-file ops
From:   Peter Newman <peternewman@google.com>
To:     reinette.chatre@intel.com, fenghua.yu@intel.com
Cc:     Babu.Moger@amd.com, bp@alien8.de, dave.hansen@linux.intel.com,
        eranian@google.com, gupasani@google.com, hpa@zytor.com,
        james.morse@arm.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, skodak@google.com, tglx@linutronix.de,
        tony.luck@intel.com, x86@kernel.org,
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

rdtgroup_kn_lock_live() can only release a kernfs reference for a single
file before waiting on the rdtgroup_mutex, limiting its usefulness for
operations on multiple files, such as rename.

Factor the work needed to respectively break and unbreak active
protection on an individual file into rdtgroup_kn_{get,put}().

No functional change.

Signed-off-by: Peter Newman <peternewman@google.com>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 35 ++++++++++++++++----------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 5993da21d822..c3fb525d52e9 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2028,6 +2028,26 @@ static struct rdtgroup *kernfs_to_rdtgroup(struct kernfs_node *kn)
 	}
 }
 
+static void rdtgroup_kn_get(struct rdtgroup *rdtgrp, struct kernfs_node *kn)
+{
+	atomic_inc(&rdtgrp->waitcount);
+	kernfs_break_active_protection(kn);
+}
+
+static void rdtgroup_kn_put(struct rdtgroup *rdtgrp, struct kernfs_node *kn)
+{
+	if (atomic_dec_and_test(&rdtgrp->waitcount) &&
+	    (rdtgrp->flags & RDT_DELETED)) {
+		if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP ||
+		    rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED)
+			rdtgroup_pseudo_lock_remove(rdtgrp);
+		kernfs_unbreak_active_protection(kn);
+		rdtgroup_remove(rdtgrp);
+	} else {
+		kernfs_unbreak_active_protection(kn);
+	}
+}
+
 struct rdtgroup *rdtgroup_kn_lock_live(struct kernfs_node *kn)
 {
 	struct rdtgroup *rdtgrp = kernfs_to_rdtgroup(kn);
@@ -2035,8 +2055,7 @@ struct rdtgroup *rdtgroup_kn_lock_live(struct kernfs_node *kn)
 	if (!rdtgrp)
 		return NULL;
 
-	atomic_inc(&rdtgrp->waitcount);
-	kernfs_break_active_protection(kn);
+	rdtgroup_kn_get(rdtgrp, kn);
 
 	mutex_lock(&rdtgroup_mutex);
 
@@ -2055,17 +2074,7 @@ void rdtgroup_kn_unlock(struct kernfs_node *kn)
 		return;
 
 	mutex_unlock(&rdtgroup_mutex);
-
-	if (atomic_dec_and_test(&rdtgrp->waitcount) &&
-	    (rdtgrp->flags & RDT_DELETED)) {
-		if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP ||
-		    rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED)
-			rdtgroup_pseudo_lock_remove(rdtgrp);
-		kernfs_unbreak_active_protection(kn);
-		rdtgroup_remove(rdtgrp);
-	} else {
-		kernfs_unbreak_active_protection(kn);
-	}
+	rdtgroup_kn_put(rdtgrp, kn);
 }
 
 static int mkdir_mondata_all(struct kernfs_node *parent_kn,
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

