Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D20629DE6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 16:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238142AbiKOPpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 10:45:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbiKOPps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 10:45:48 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779FF10565
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 07:45:47 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-370624ca2e8so138944817b3.16
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 07:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cUFeRtZYB7UeTgxIn2ZhYMocLTGExrmRKO4xcP78LzE=;
        b=Si5zz34w8W5OUKEmuwma1mET23o1UNMM0e+o9fGg5w5QBLXN0EQOINeapJXw0xkhN5
         jIBGAQpEgsaEeu2F7RJfTUTekBnD5xmh7oO3DT9e/g5GH9xCDINR/nnIH1JQBtjCA8Ky
         cGd2mkkePepc9zsCKoQBhNWoANyqmXIHeOPNSUqILXJ+JDo0m+Fg58+w9dEi+qyzv9PK
         mkkEjCyPJL2UD0KfMddbIdEX6IIwT+BCGM1qp7vQZJ89JXMBRgZua0U4jSF0TfY/8A3L
         P5OCi+bq6OzDA/4TybR/avT7cMQ6ZUIN1MQpCKdkmJhl6PAQflUILq9El2VnyO7VmIPI
         Ckig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cUFeRtZYB7UeTgxIn2ZhYMocLTGExrmRKO4xcP78LzE=;
        b=UAoHqmIwUjv6pmHoHfLUzdnwzEEavYeH5PIg7sBNDDyfPF/szhhHAxawbSnelet5v9
         z0C+rTMXMmMjyT+TW96ti0hrcMVK7WPJFJGkZqJWXx9oenxvbYNyHvw2uuDnntNLVeJr
         r4hN+leZO8qlwdt0o+9sr6ouXLGjrUhTAC6umz2gpNxv1hIXIdYj/G6wvKdNUvvbUKHK
         7sBOQuExuKbLpKo7OAjBcxD910I9MbGVJ7oTkOoQfTHCzbevutu17iH+xWVSAiWUDy3C
         VafdGZfURm6GY7nByFRNSSM9fgGzQqgnsukO1BlRo8HPwk7WzopofWAry5rP+/Dam4+q
         37FA==
X-Gm-Message-State: ANoB5pmqsQSnvWCN+RWeDRP6OajdBGKggHz8xkbxLT2QpE5PV+NWQmG5
        qP4LYytun7sphLNWJfh6IIc18IJgS/0egFZvPg==
X-Google-Smtp-Source: AA0mqf69A0hZw4IJg/9Hpym+IBCNApy2UjMUCdqSJlD8FX/eyVqv53ZuVqcM51FoPNf2fzyMh+wKHprvlaeRH4bg9Q==
X-Received: from peternewman10.zrh.corp.google.com ([2a00:79e0:9d:6:fe62:9ede:ae13:6fda])
 (user=peternewman job=sendgmr) by 2002:a25:40ce:0:b0:6d5:34ad:10c5 with SMTP
 id n197-20020a2540ce000000b006d534ad10c5mr28033116yba.494.1668527146292; Tue,
 15 Nov 2022 07:45:46 -0800 (PST)
Date:   Tue, 15 Nov 2022 16:45:14 +0100
In-Reply-To: <20221115154515.952783-1-peternewman@google.com>
Mime-Version: 1.0
References: <20221115154515.952783-1-peternewman@google.com>
X-Mailer: git-send-email 2.38.1.493.g58b659f92b-goog
Message-ID: <20221115154515.952783-2-peternewman@google.com>
Subject: [PATCH v1 1/2] x86/resctrl: factor rdtgroup lock for multi-file ops
From:   Peter Newman <peternewman@google.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        James Morse <james.morse@arm.com>,
        Stephane Eranian <eranian@google.com>,
        Gaurang Upasani <gupasani@google.com>,
        Babu Moger <Babu.Moger@amd.com>, linux-kernel@vger.kernel.org,
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

To help implement kernfs operations on multiple files, such as rename,
factor the work needed to respectively break and unbreak active
protection on an individual file into rdtgroup_kn_{get,put}().

The existing rdtgroup_kn_lock_live() could only release the kernfs lock
for a single file before waiting on the rdtgroup_mutex.

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
2.38.1.493.g58b659f92b-goog

