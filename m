Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34DB5B3A56
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 16:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbiIIOCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 10:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbiIIOAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 10:00:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E219E891;
        Fri,  9 Sep 2022 07:00:36 -0700 (PDT)
Date:   Fri, 09 Sep 2022 14:00:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662732034;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ca0vCsiUTsyqOZE8tpuP2JFx8Fv8OFNyod/yKaWqRV4=;
        b=DefgKsnRTnzGC0EVCr+ETdrJeuBpAj5w+T0mvo3dKyYGUu1aVdgCC3Vk0ZPVnljlth/vXt
        vm+OA/ap+IA/6fhL8VJZwn4VFO5oHcmDsaW6Ppvb/LFAErPAQb0423wRFBFbqEmiyHKfx+
        4WOB0sFD62Vy8oFNbrqwFHdAGQTuoi1XrPrp05QlozOhH0DMJ+3KasSc0Sc3yVkPoxHXAQ
        0Ux61/j8PCA6B4zX8NT/SqAefDmg1rcT1kmoAhAoNAA38Q7b1iDutFMYmFBxPKgZr77GQd
        YoAUvLha6FNkleD+vMRNizeVjrz4818Z5Qkt2G1yB+3TL6d1VVLF4sj9VhUn3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662732034;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ca0vCsiUTsyqOZE8tpuP2JFx8Fv8OFNyod/yKaWqRV4=;
        b=PyrXVb8fdeZBdvGFk6zCqJjELwbOfTMSiQMBARHlaYhb8y9SzaUCBIJtGO6bAWNyd7EAHB
        yYwtb4OpKhUSioDg==
From:   "tip-bot2 for Tejun Heo" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/psi] kernfs: Drop unnecessary "mutex" local variable
 initialization
Cc:     Imran Khan <imran.f.khan@oracle.com>,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Tejun Heo <tj@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220828050440.734579-3-tj@kernel.org>
References: <20220828050440.734579-3-tj@kernel.org>
MIME-Version: 1.0
Message-ID: <166273203331.401.751164502927343198.tip-bot2@tip-bot2>
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

Commit-ID:     b52c2379c38ffa49cbf10e30abc9dc4f9c051d41
Gitweb:        https://git.kernel.org/tip/b52c2379c38ffa49cbf10e30abc9dc4f9c051d41
Author:        Tejun Heo <tj@kernel.org>
AuthorDate:    Sat, 27 Aug 2022 19:04:33 -10:00
Committer:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CommitterDate: Thu, 01 Sep 2022 18:08:44 +02:00

kernfs: Drop unnecessary "mutex" local variable initialization

These are unnecessary and unconventional. Remove them. Also move variable
declaration into the block that it's used. No functional changes.

Cc: Imran Khan <imran.f.khan@oracle.com>
Tested-by: Chengming Zhou <zhouchengming@bytedance.com>
Reviewed-by: Chengming Zhou <zhouchengming@bytedance.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/r/20220828050440.734579-3-tj@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/kernfs/file.c |  9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 32b16fe..6437f7c 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -555,7 +555,7 @@ static int kernfs_get_open_node(struct kernfs_node *kn,
 				struct kernfs_open_file *of)
 {
 	struct kernfs_open_node *on, *new_on = NULL;
-	struct mutex *mutex = NULL;
+	struct mutex *mutex;
 
 	mutex = kernfs_open_file_mutex_lock(kn);
 	on = kernfs_deref_open_node_locked(kn);
@@ -599,7 +599,7 @@ static void kernfs_unlink_open_file(struct kernfs_node *kn,
 				 struct kernfs_open_file *of)
 {
 	struct kernfs_open_node *on;
-	struct mutex *mutex = NULL;
+	struct mutex *mutex;
 
 	mutex = kernfs_open_file_mutex_lock(kn);
 
@@ -776,9 +776,10 @@ static int kernfs_fop_release(struct inode *inode, struct file *filp)
 {
 	struct kernfs_node *kn = inode->i_private;
 	struct kernfs_open_file *of = kernfs_of(filp);
-	struct mutex *mutex = NULL;
 
 	if (kn->flags & KERNFS_HAS_RELEASE) {
+		struct mutex *mutex;
+
 		mutex = kernfs_open_file_mutex_lock(kn);
 		kernfs_release_file(kn, of);
 		mutex_unlock(mutex);
@@ -796,7 +797,7 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
 {
 	struct kernfs_open_node *on;
 	struct kernfs_open_file *of;
-	struct mutex *mutex = NULL;
+	struct mutex *mutex;
 
 	if (!(kn->flags & (KERNFS_HAS_MMAP | KERNFS_HAS_RELEASE)))
 		return;
