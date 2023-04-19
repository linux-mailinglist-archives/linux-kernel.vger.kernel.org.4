Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B15AD6E79FC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 14:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232988AbjDSMuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 08:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbjDSMuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 08:50:51 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79EB96EAD
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 05:50:41 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-54fde069e4aso133812847b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 05:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681908640; x=1684500640;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=M55eRuHQJrupxqsaP770qxmiyWjSxTprBCDKIWruVU8=;
        b=LXjy63dN+KA/a+ihM+Hvrk/noXBuUo93Q35thIox5tSdDL2o71/NMZqFSYRW0EBM4P
         EFX9I9zPzMnxSNaBMaLHxoq+qKvEcsWsmeEXD3h2XX8VP1TN70UUtZrcF025i79nZDqa
         VYi1WpoKBj5pu+akQ/sWrJLnII87r+R3KLUmrXRQRQY92oMrME3VBmxN7sElDqCBoWrx
         lXo+oopgXDC+bwQHMXVYMf3RRHvxlbwsNLPAsX5CrT4gmHs2cj/cjZhAZINSVAWMoNCH
         n+pDViYF29j82CWSRE3IgGrfv302KxrSw7qSMoOyeUOz03lZl110Yp6DcbGXZyKaYWi0
         XLZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681908640; x=1684500640;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M55eRuHQJrupxqsaP770qxmiyWjSxTprBCDKIWruVU8=;
        b=IrvAPAUWWjfKV2APoqSn9/F+gIDeCIR3qKbb4e07tPYzvZeEdZrq9e1A//r8ue0P8a
         kpa1oKGQ1N4yWVa/bW98gxZWfnRJo3dRpAhyM9HZSBB8rrc5QeUYiCLEZJEwxMH4gld/
         FhAJT1Zz8Qbfp5OH1UjJQGaULcpMlxn7ccWTqVMWZutJf2ZRdyPOGCujWj5w70BAJSFq
         N1NhIagVcMveGmq7OyoyUaYRektHbUpcuV2pD8/auCuByJlyfNUu3lmDBZ6qexEIBs+T
         WmZWHxf6ZEKD8DZFMUSEhePcxfK10jx/zeft3h1j4W8PGmK8UC0/WmoDjogizPryeLhr
         JjdA==
X-Gm-Message-State: AAQBX9e8vaVuvay+Lj8zQ/RvRCcGUg1kk37x7GBu0OKBppwnij0SYRbd
        D1pxbbIT06v8m5dtDosqqfla2D7seuN+D/j3Pg==
X-Google-Smtp-Source: AKy350bHCu6N/9gE0Xr0AQjCLyCYOOOEiAnM+qBQM/oKHnm8lOsLRsxUyXnZgd1futy7TWNiA6JxT/4GV9CrMcsl6A==
X-Received: from peternewman0.zrh.corp.google.com ([2a00:79e0:9d:6:b36e:a25e:826d:b66a])
 (user=peternewman job=sendgmr) by 2002:a25:c245:0:b0:997:c919:4484 with SMTP
 id s66-20020a25c245000000b00997c9194484mr11392762ybf.6.1681908640818; Wed, 19
 Apr 2023 05:50:40 -0700 (PDT)
Date:   Wed, 19 Apr 2023 14:50:13 +0200
In-Reply-To: <20230419125015.693566-1-peternewman@google.com>
Mime-Version: 1.0
References: <20230419125015.693566-1-peternewman@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230419125015.693566-2-peternewman@google.com>
Subject: [PATCH v6 1/3] x86/resctrl: Factor rdtgroup lock for multi-file ops
From:   Peter Newman <peternewman@google.com>
To:     fenghua.yu@intel.com, reinette.chatre@intel.com
Cc:     Babu.Moger@amd.com, bp@alien8.de, dave.hansen@linux.intel.com,
        eranian@google.com, gupasani@google.com, hpa@zytor.com,
        james.morse@arm.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, skodak@google.com, tglx@linutronix.de,
        tony.luck@intel.com, x86@kernel.org,
        Peter Newman <peternewman@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 35 ++++++++++++++++----------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 6ad33f355861..51b869149e76 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2301,6 +2301,26 @@ static struct rdtgroup *kernfs_to_rdtgroup(struct kernfs_node *kn)
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
@@ -2308,8 +2328,7 @@ struct rdtgroup *rdtgroup_kn_lock_live(struct kernfs_node *kn)
 	if (!rdtgrp)
 		return NULL;
 
-	atomic_inc(&rdtgrp->waitcount);
-	kernfs_break_active_protection(kn);
+	rdtgroup_kn_get(rdtgrp, kn);
 
 	mutex_lock(&rdtgroup_mutex);
 
@@ -2328,17 +2347,7 @@ void rdtgroup_kn_unlock(struct kernfs_node *kn)
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
2.40.0.634.g4ca3ef3211-goog

