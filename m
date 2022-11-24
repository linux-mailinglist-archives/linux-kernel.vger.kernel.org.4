Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D17DF6377A4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 12:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiKXL1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 06:27:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbiKXL1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 06:27:41 -0500
X-Greylist: delayed 121 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 24 Nov 2022 03:27:39 PST
Received: from mx5.didiglobal.com (mx5.didiglobal.com [111.202.70.122])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id D3FD511466
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 03:27:37 -0800 (PST)
Received: from mail.didiglobal.com (unknown [10.79.65.12])
        by mx5.didiglobal.com (Maildata Gateway V2.8) with ESMTPS id ECB8CB0148E0B;
        Thu, 24 Nov 2022 19:25:33 +0800 (CST)
Received: from didi-ThinkCentre-M930t-N000 (10.79.64.101) by
 ZJY02-ACTMBX-02.didichuxing.com (10.79.65.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 24 Nov 2022 19:25:33 +0800
Date:   Thu, 24 Nov 2022 19:25:26 +0800
X-MD-Sfrom: tiozhang@didiglobal.com
X-MD-SrcIP: 10.79.65.12
From:   Tio Zhang <tiozhang@didiglobal.com>
To:     <pmladek@suse.com>, <akpm@linux-foundation.org>,
        <peterz@infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <tiozhang@didiglobal.com>
Subject: [PATCH] kernel/hung_task: print real_parent->comm, pid in
 check_hung_task
Message-ID: <20221124112526.GA21832@didi-ThinkCentre-M930t-N000>
Mail-Followup-To: pmladek@suse.com, akpm@linux-foundation.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.79.64.101]
X-ClientProxiedBy: ZJY03-PUBMBX-01.didichuxing.com (10.79.71.12) To
 ZJY02-ACTMBX-02.didichuxing.com (10.79.65.12)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can avoid a hung task by fixing the process who causes it.
But sometimes it is difficult to find out which service 
the bad process belongs to by only knowing its pid and comm.
Since userspace tools to learn who launches the bad process
do not always work when we get a hung task, 
it is helpful printing the parent by kernel.

Signed-off-by: Tio Zhang <tiozhang@didiglobal.com>
---
 kernel/hung_task.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index c71889f3f3fc..33543d27bd5c 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -89,6 +89,7 @@ static struct notifier_block panic_block = {
 
 static void check_hung_task(struct task_struct *t, unsigned long timeout)
 {
+	struct task_struct *p = t->real_parent;
 	unsigned long switch_count = t->nvcsw + t->nivcsw;
 
 	/*
@@ -129,8 +130,8 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
 	if (sysctl_hung_task_warnings) {
 		if (sysctl_hung_task_warnings > 0)
 			sysctl_hung_task_warnings--;
-		pr_err("INFO: task %s:%d blocked for more than %ld seconds.\n",
-		       t->comm, t->pid, (jiffies - t->last_switch_time) / HZ);
+		pr_err("INFO: task %s:%d, parent %s:%d blocked for more than %ld seconds.\n",
+		       t->comm, t->pid, p->comm, p->pid, (jiffies - t->last_switch_time) / HZ);
 		pr_err("      %s %s %.*s\n",
 			print_tainted(), init_utsname()->release,
 			(int)strcspn(init_utsname()->version, " "),
-- 
2.17.1

