Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 036095B3A47
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 16:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbiIIOB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 10:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbiIIOAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 10:00:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D278A6FC;
        Fri,  9 Sep 2022 07:00:27 -0700 (PDT)
Date:   Fri, 09 Sep 2022 14:00:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662732026;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jOuVbKQXTlZ31neaC6shUn0CS98gD3q+wAn9vPt2B9A=;
        b=bKAj3YzKZu5H2AXPvrGkLJUaN9HqzEVCm2e2WmhmFoYoTR8kU4rFfApFbTqVU8oNDTAvrl
        8XV+iiMjfKpG8rxhzTegBVgrMxEcq0lsw50pgffVsHkbkbYf9CeRVp4Q9dpFeO1p1PmO0Z
        CwABrnSsNwieFX2uxsfQrT9KCj0S/nqcand+o2/Da+OuKXcwXSIJ7iCzEAcdnXdzPw74/M
        8R8iz5f7I+3iHOTE9ku0JnRl3+lyfehld759F35idLBVqhJ7hQ+3d1mrA4TnFgna1fULiB
        dB6mbFTN6F002Lm3E7XLUEIlez8LymXNBdVGaAJO80r/zKz33eln/AUpGZYMzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662732026;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jOuVbKQXTlZ31neaC6shUn0CS98gD3q+wAn9vPt2B9A=;
        b=TtqP4IX5EoJ3R7SdoPlga84ZraDpZROu7rRUfI/OGjfOCY7HwP29ZVLXuntz49QdBQdBSa
        zJ9XRqixs+Q2lrDg==
From:   "tip-bot2 for Tejun Heo" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/psi] cgroup: Implement cgroup_file_show()
Cc:     Chengming Zhou <zhouchengming@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220828050440.734579-10-tj@kernel.org>
References: <20220828050440.734579-10-tj@kernel.org>
MIME-Version: 1.0
Message-ID: <166273202517.401.11532505009516572799.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/psi branch of tip:

Commit-ID:     e2691f6b44ed2135bfd005ad5fbabac4f433a7a1
Gitweb:        https://git.kernel.org/tip/e2691f6b44ed2135bfd005ad5fbabac4f433a7a1
Author:        Tejun Heo <tj@kernel.org>
AuthorDate:    Sat, 27 Aug 2022 19:04:40 -10:00
Committer:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CommitterDate: Thu, 01 Sep 2022 18:08:44 +02:00

cgroup: Implement cgroup_file_show()

Add cgroup_file_show() which allows toggling visibility of a cgroup file
using the new kernfs_show(). This will be used to hide psi interface files
on cgroups where it's disabled.

Cc: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Tested-by: Chengming Zhou <zhouchengming@bytedance.com>
Reviewed-by: Chengming Zhou <zhouchengming@bytedance.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/r/20220828050440.734579-10-tj@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/cgroup.h |  1 +
 kernel/cgroup/cgroup.c | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index ed53bfe..f61dd13 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -114,6 +114,7 @@ int cgroup_add_dfl_cftypes(struct cgroup_subsys *ss, struct cftype *cfts);
 int cgroup_add_legacy_cftypes(struct cgroup_subsys *ss, struct cftype *cfts);
 int cgroup_rm_cftypes(struct cftype *cfts);
 void cgroup_file_notify(struct cgroup_file *cfile);
+void cgroup_file_show(struct cgroup_file *cfile, bool show);
 
 int task_cgroup_path(struct task_struct *task, char *buf, size_t buflen);
 int cgroupstats_build(struct cgroupstats *stats, struct dentry *dentry);
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index ffaccd6..217469a 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -4340,6 +4340,26 @@ void cgroup_file_notify(struct cgroup_file *cfile)
 }
 
 /**
+ * cgroup_file_show - show or hide a hidden cgroup file
+ * @cfile: target cgroup_file obtained by setting cftype->file_offset
+ * @show: whether to show or hide
+ */
+void cgroup_file_show(struct cgroup_file *cfile, bool show)
+{
+	struct kernfs_node *kn;
+
+	spin_lock_irq(&cgroup_file_kn_lock);
+	kn = cfile->kn;
+	kernfs_get(kn);
+	spin_unlock_irq(&cgroup_file_kn_lock);
+
+	if (kn)
+		kernfs_show(kn, show);
+
+	kernfs_put(kn);
+}
+
+/**
  * css_next_child - find the next child of a given css
  * @pos: the current position (%NULL to initiate traversal)
  * @parent: css whose children to walk
