Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB70563BFA7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 13:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233815AbiK2MDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 07:03:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233446AbiK2MCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 07:02:25 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C62A1C105
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 04:02:23 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-3c9960ad866so46193777b3.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 04:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=c1IfWFHp5DCIRjiKA/TeeRTh2AwfodazgUFac9Fpba4=;
        b=qrag6pK4vXNlb/XxqP9rXIRk1oPoO8kFnVqhuDBEdVcmYt1HLwpv7218GphnLolIjm
         tO0ZntJA3VdfxCbJdAsDc2m/9byccsuxHJgKbmjzVs7GuDi58E8RhVVYpQJUtCfSTEY9
         J98PQ9ZKt8hp5Ohvw9uQSe6iIsRTJzatIgZ9qIGjRCpFVa8Upd3vBwO4G39YWBkRMCqx
         d9wQ5DheEjXcuVlUbodI7d1bLpJG4Y/ESclxNLL1EXWd1tKNAMAv+OM3BorqoEcJKLdT
         XZhDx+SesoCF5XxvLNQYh7VhdDbsWbYBJ32OAWgVu1Vw4XQIPu3eNn42QOcMqmqueXfq
         NIPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c1IfWFHp5DCIRjiKA/TeeRTh2AwfodazgUFac9Fpba4=;
        b=cNzV3K/JfIVB5GQnEi7QN9f9FfBpSKLQBmsK4rW3Dn20HwHxRCNNVxLawtd46eF932
         cRW9Z/245V9pLKRixoqRHvDh2mRiQbrZAmYbGK/9XmLX25uGaecNqgmrmmokEuLEDC5T
         TNmL2DL0uL7sePigHkmozGF+qSoInVwaTT8vwZGfNSU2euJcFPObTgHg2B0EIFi9N3dZ
         ynlSuyAGpiaboa1YKtmJHXh5JjQn7CA5a+aTA3ikSx9I52XjW1ZNVR4C1FAPLYqeFwgz
         Ja3Gm3eKtu0fZRlWuir1CncMu6ISDxXFP3pri3sqhFHPMZ9fOFwMvbUeWhll+SAtS4Mk
         VCBQ==
X-Gm-Message-State: ANoB5pnXaq8wNdK4FQJUNjNAl/YlZX7hWYO490l2PA4NPD2YiLnGAGcw
        35L91QJQQZXHTty8TOXxnGyU23ub1jegZFSZfw==
X-Google-Smtp-Source: AA0mqf699TdYNuj2F80QHmXg0wt+6Cg1c10qyoBDJvmAceddZRvC+VI//i0ExoSIMAPEOooHMYDqKlVG7CaMK9kCRQ==
X-Received: from peternewman10.zrh.corp.google.com ([2a00:79e0:9d:6:e398:2261:c909:b359])
 (user=peternewman job=sendgmr) by 2002:a81:cb06:0:b0:394:5309:68f8 with SMTP
 id q6-20020a81cb06000000b00394530968f8mr7ywi.317.1669723342256; Tue, 29 Nov
 2022 04:02:22 -0800 (PST)
Date:   Tue, 29 Nov 2022 13:01:48 +0100
In-Reply-To: <20221129120149.1035444-1-peternewman@google.com>
Mime-Version: 1.0
References: <20221129120149.1035444-1-peternewman@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221129120149.1035444-2-peternewman@google.com>
Subject: [PATCH v2 1/2] x86/resctrl: Factor rdtgroup lock for multi-file ops
From:   Peter Newman <peternewman@google.com>
To:     fenghua.yu@intel.com, reinette.chatre@intel.com
Cc:     Babu.Moger@amd.com, bp@alien8.de, dave.hansen@linux.intel.com,
        eranian@google.com, gupasani@google.com, hpa@zytor.com,
        james.morse@arm.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, tglx@linutronix.de, x86@kernel.org,
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

rdtgroup_kn_lock_live() can only release a kernfs lock for a single file
before waiting on the rdtgroup_mutex, limiting its usefulness for
operations on multiple files, such as rename.

Factor the work needed to respectively break and unbreak active
protection on an individual file into rdtgroup_kn_{get,put}().

This refactoring should not result in any functional change.

Signed-off-by: Peter Newman <peternewman@google.com>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 35 ++++++++++++++++----------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index e5a48f05e787..03b51543c26d 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2026,6 +2026,26 @@ static struct rdtgroup *kernfs_to_rdtgroup(struct kernfs_node *kn)
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
@@ -2033,8 +2053,7 @@ struct rdtgroup *rdtgroup_kn_lock_live(struct kernfs_node *kn)
 	if (!rdtgrp)
 		return NULL;
 
-	atomic_inc(&rdtgrp->waitcount);
-	kernfs_break_active_protection(kn);
+	rdtgroup_kn_get(rdtgrp, kn);
 
 	mutex_lock(&rdtgroup_mutex);
 
@@ -2053,17 +2072,7 @@ void rdtgroup_kn_unlock(struct kernfs_node *kn)
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
2.38.1.584.g0f3c55d4c2-goog

