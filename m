Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA6067AF6B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 11:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjAYKNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 05:13:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235280AbjAYKNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 05:13:50 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D2013502
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 02:13:47 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id z17-20020a256651000000b007907852ca4dso19450926ybm.16
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 02:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=heLbD3mGJYiSLYw01jzlG4oQZAdBRW0StN/Xjg7KmmU=;
        b=Th14K2HTVuAxor9Fx9q3Xy5v5o3773fGlKrMPidDRNgJYlCoaDOCwYh2TpFQ2l5ksz
         /8IZZzhgATWifp2hRAlsFEaDE9uwMgxmJfCrJm9s/XXkazoDIz/Qhf606nhToseZGQFv
         lqk/PlcxoDLPW129p6EO0rJXpAhFADFgmFf0aZTa6O2Ft2RHSe4stYbcLrJCmhuay8aH
         wHOe4UWzsm+op9vlAKcD69x+IBndt3UsXq9RzuNvsvGG3YO7A53ixYRIepgQV1y2Gk2P
         ytP7pVWbDhaMNAVHX2y6pvo/kYSmOXbWH57iH4sKJncE6ukUZM2hZFRPDogjK1xacjNH
         vw4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=heLbD3mGJYiSLYw01jzlG4oQZAdBRW0StN/Xjg7KmmU=;
        b=Mzal7/otAx8b5bp1to1YWo+buPpzn/19GWdCWWvb+qIgZ6h79khoiz2lCYRbTF472n
         yF7ZB66AaBlso0aCROrZssc8YHr1+Pitv9wHVinq4WWpQEM1ri9fw2O19lPJkuVwd9I1
         nF1Wx1AlOfhAdUDOgOsKL9+WrJXbWnfTFX1PnKuTuIHf+kYkQ6uP38CjuPyywU1MnTr0
         xX+FOPqRHOQsrLrGhjqIYSSfvgSLQMrYUBeydKz3DQKOMycNPaQ1SfXqmE+Kqe/NDanq
         rd+JFEzsyf0KEjXXQKdl6wuH8WYy2S+I/Ebur9GdEof7rylTKAlBLzvpxYDcLYTGSKId
         hkJw==
X-Gm-Message-State: AFqh2kqQdh21U7x8uIgABqnGTqrICgnUoe32c9kdTznQuTH/3sN3qWM5
        guL5GJofwfFWOunyLUjNIO2KY/Cn9wGZnxVwkg==
X-Google-Smtp-Source: AMrXdXuLCNuTwodY1z6nZ5WVqBNMBc/D4RkFmhUQ4sfWNBdxqTTApao9GOPXDLTuVbIaqrQc5kTHC39z/FZMlHiR4w==
X-Received: from peternewman10.zrh.corp.google.com ([2a00:79e0:9d:6:e533:80e6:38fe:22c])
 (user=peternewman job=sendgmr) by 2002:a25:4d55:0:b0:7b4:fa63:5519 with SMTP
 id a82-20020a254d55000000b007b4fa635519mr3595149ybb.270.1674641626979; Wed,
 25 Jan 2023 02:13:46 -0800 (PST)
Date:   Wed, 25 Jan 2023 11:13:32 +0100
In-Reply-To: <20230125101334.1069060-1-peternewman@google.com>
Mime-Version: 1.0
References: <20230125101334.1069060-1-peternewman@google.com>
X-Mailer: git-send-email 2.39.1.405.gd4c25cc71f-goog
Message-ID: <20230125101334.1069060-2-peternewman@google.com>
Subject: [PATCH v3 1/3] x86/resctrl: Factor rdtgroup lock for multi-file ops
From:   Peter Newman <peternewman@google.com>
To:     reinette.chatre@intel.com, fenghua.yu@intel.com
Cc:     Babu.Moger@amd.com, bp@alien8.de, dave.hansen@linux.intel.com,
        eranian@google.com, gupasani@google.com, hpa@zytor.com,
        james.morse@arm.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, skodak@google.com, tony.luck@intel.com,
        tglx@linutronix.de, x86@kernel.org,
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

This should not result in any functional change.

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
2.39.1.405.gd4c25cc71f-goog

