Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93CA6D0767
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 15:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbjC3N4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 09:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbjC3N4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 09:56:16 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3EA67ED3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 06:56:14 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id p12-20020a25420c000000b00b6eb3c67574so18710889yba.11
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 06:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680184574;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Db8tOgMamx6SeqgPHUVcNRbWY9TzQjouDMjbLfKO9Bs=;
        b=smbJl9qFP0l+li/hTveSDyoWOwzoPsoLgc8Y/ZUlzb4z79RlsRniVMcWs8fQnlPjSe
         aZIByw2LkyVG+iujSfkEbBIxijps0U3JAGOLzKQD9VF1QS6DCfGVK5PsbLIIh3MtvbGo
         T3VY05+yvWDx1cCieWInbheUEtsfNdp1dtZDEiXe5SSdR+eR8joFUtII4AWaimvlXvG/
         sfl8ELaGwsoupYMFHqtKEz38EFqsNC1R1YPxJO4rYlNrGruq5MFrZBGFSN37GhwGY3YM
         EiffeAwYzCqWYR2AfbaJ5EMGJt94EYC2UWzEKmgiyjaM0LGsMIo42eXzY/vwAOpfHseR
         5XvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680184574;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Db8tOgMamx6SeqgPHUVcNRbWY9TzQjouDMjbLfKO9Bs=;
        b=gU9E7ULLyDdmcirBkjTeTWqU4+iGJdrcdwnCLHw7oP7fkqL5krbwnGGb/oOrnYis3f
         Jx+p2aNKbLcrYy/La0AzK0NIOheOmkO346hXUuI2Y4z881rqzphx07V3Fh0AyBxhjrAE
         57WpW+bRcoF7FfJByqZfijavVtvNdlwIjLysTBS68fZUD+nVuvUKF4I2A93ERrJRcmVj
         7fOi7n+AJEPS4zYjCqlxwQsv4XX5Fm6IZsl31TFTyUNHoCO8o9biOxCEeXKTJjrBInLj
         P25jVRmkbTToM/VOVB3/ZdQBMe76u6h8/yzX8R2wXJ0OzGa44SRQyXYEltfxkOZ4qaeY
         70oQ==
X-Gm-Message-State: AAQBX9eiwQxG2JrDdXoFDNb9fot4l2s91+f2wduds3/LdH6P1KlFiI5n
        07YzujE2xLt8AK7bNISKFfeqk1Ud01trBIPKXg==
X-Google-Smtp-Source: AKy350Ynv1vxx40E2oldcA4Py+mSsLVEYWd4jHB1q+kGBD7GhiGINNV6dTkxr5askTOXvA2Ej4MyLxfovDjmFHGkMw==
X-Received: from peternewman-vh.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:30cc])
 (user=peternewman job=sendgmr) by 2002:a25:d9d6:0:b0:b80:e387:f6af with SMTP
 id q205-20020a25d9d6000000b00b80e387f6afmr50312ybg.2.1680184574244; Thu, 30
 Mar 2023 06:56:14 -0700 (PDT)
Date:   Thu, 30 Mar 2023 15:55:56 +0200
In-Reply-To: <20230330135558.1019658-1-peternewman@google.com>
Mime-Version: 1.0
References: <20230330135558.1019658-1-peternewman@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230330135558.1019658-2-peternewman@google.com>
Subject: [PATCH v5 1/3] x86/resctrl: Factor rdtgroup lock for multi-file ops
From:   Peter Newman <peternewman@google.com>
To:     reinette.chatre@intel.com, fenghua.yu@intel.com
Cc:     Babu.Moger@amd.com, bp@alien8.de, dave.hansen@linux.intel.com,
        eranian@google.com, gupasani@google.com, hpa@zytor.com,
        james.morse@arm.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, skodak@google.com, tglx@linutronix.de,
        tony.luck@intel.com, x86@kernel.org,
        Peter Newman <peternewman@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
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
2.40.0.348.gf938b09366-goog

