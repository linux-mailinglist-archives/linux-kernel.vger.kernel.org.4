Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64EB25F8B85
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 15:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiJINKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 09:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiJINKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 09:10:39 -0400
Received: from cae.in-ulm.de (cae.in-ulm.de [217.10.14.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E9B1B19024
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 06:10:37 -0700 (PDT)
Received: by cae.in-ulm.de (Postfix, from userid 1000)
        id A7DCE14026A; Sun,  9 Oct 2022 15:10:36 +0200 (CEST)
Date:   Sun, 9 Oct 2022 15:10:36 +0200
From:   "Christian A. Ehrhardt" <lk@c--e.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>,
        syzbot <syzbot+534ee3d24c37c411f37f@syzkaller.appspotmail.com>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        Yosry Ahmed <yosryahmed@google.com>
Subject: [PATCH] cgroup: Fix crash with CLONE_INTO_CGROUP and v1 cgroups
Message-ID: <Y0LITEA/22Z7YVSa@cae.in-ulm.de>
References: <000000000000385cbf05ea3f1862@google.com>
 <00000000000028a44005ea40352b@google.com>
 <Y0CbtVwW6+QIYJdQ@slm.duckdns.org>
 <Y0HBlJ4AoZba93Uf@cae.in-ulm.de>
 <20221009084039.cw6meqbvy4362lsa@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221009084039.cw6meqbvy4362lsa@wittgenstein>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Since commit f3a2aebdd6, Version 1 cgroups no longer cause an
error when used with CLONE_INTO_CGROUP. However, the permission
checks performed during clone assume a Version 2 cgroup.

Restore the error check for V1 cgroups in the clone() path.

Reported-by: syzbot+534ee3d24c37c411f37f@syzkaller.appspotmail.com
Link: https://lore.kernel.org/lkml/000000000000385cbf05ea3f1862@google.com/
Fixes: f3a2aebdd6 ("cgroup: enable cgroup_get_from_file() on cgroup1")
Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
---
 kernel/cgroup/cgroup.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index b6e3110b3ea7..f7fc3afa88c1 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6244,6 +6244,11 @@ static int cgroup_css_set_fork(struct kernel_clone_args *kargs)
 		goto err;
 	}
 
+	if (!cgroup_on_dfl(dst_cgrp)) {
+		ret = -EBADF;
+		goto err;
+	}
+
 	if (cgroup_is_dead(dst_cgrp)) {
 		ret = -ENODEV;
 		goto err;
-- 
2.34.1

