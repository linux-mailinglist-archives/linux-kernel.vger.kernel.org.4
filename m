Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53704666E61
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 10:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240057AbjALJhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 04:37:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239640AbjALJhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 04:37:00 -0500
Received: from mx5.didiglobal.com (mx5.didiglobal.com [111.202.70.122])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 7D39454D87
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 01:29:55 -0800 (PST)
Received: from mail.didiglobal.com (unknown [10.79.65.15])
        by mx5.didiglobal.com (Maildata Gateway V2.8) with ESMTPS id ACA47B0041C0F;
        Thu, 12 Jan 2023 17:29:47 +0800 (CST)
Received: from zwp-5820-Tower (10.79.65.102) by
 ZJY02-ACTMBX-05.didichuxing.com (10.79.65.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 12 Jan 2023 17:29:47 +0800
Date:   Thu, 12 Jan 2023 17:29:42 +0800
X-MD-Sfrom: zhangweiping@didiglobal.com
X-MD-SrcIP: 10.79.65.15
From:   Weiping Zhang <zhangweiping@didiglobal.com>
To:     <pmladek@suse.com>, <akpm@linux-foundation.org>,
        <peterz@infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <zwp10758@gmail.com>
Subject: [RFC PATCH] hung_task: show sysctl_hung_task_warnings
Message-ID: <Y7/TBtWz5BE55SzD@zwp-5820-Tower>
Mail-Followup-To: pmladek@suse.com, akpm@linux-foundation.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        zwp10758@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-Originating-IP: [10.79.65.102]
X-ClientProxiedBy: ZJY03-PUBMBX-01.didichuxing.com (10.79.71.12) To
 ZJY02-ACTMBX-05.didichuxing.com (10.79.65.15)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch try to add more debug info to detect lost kernel log or no
hung task was detected.

The user set 10 to the hung_task_timeout_secs, the kernel log:

[ 3942.642220] INFO: task mount:19066 blocked for more than 10 seconds.
[ 3952.876768] INFO: task kworker/u81:0:7 blocked for more than 10 seconds.
[ 3952.877088] INFO: task scsi_eh_0:506 blocked for more than 10 seconds.
[ 3952.878212] INFO: task mount:19066 blocked for more than 10 seconds.
[ 3963.116805] INFO: task kworker/u81:0:7 blocked for more than 10 seconds.
[ 3963.117137] INFO: task scsi_eh_0:506 blocked for more than 10 seconds.
[ 3963.118275] INFO: task mount:19066 blocked for more than 10 seconds.
[ 3973.356837] INFO: task kworker/u81:0:7 blocked for more than 10 seconds.
[ 3973.357148] INFO: task scsi_eh_0:506 blocked for more than 10 seconds.
[ 3973.358247] INFO: task mount:19066 blocked for more than 10 seconds.
[ 3993.836899] INFO: task kworker/u81:0:7 blocked for more than 10 seconds.
[ 3993.837238] INFO: task scsi_eh_0:506 blocked for more than 10 seconds.
[ 3993.838356] INFO: task mount:19066 blocked for more than 10 seconds.

There is no any log at about 3983, it's hard to know if kernel log was
lost or there is no hung task was detected at that moment. So this patch
print sysctl_hung_task_warnings to distinguish the above two cases.

Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
---
 kernel/hung_task.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index c71889f3f3fc..ca917931473d 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -127,8 +127,11 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
 	 * complain:
 	 */
 	if (sysctl_hung_task_warnings) {
-		if (sysctl_hung_task_warnings > 0)
+		if (sysctl_hung_task_warnings > 0) {
 			sysctl_hung_task_warnings--;
+			pr_err("sysctl_hung_task_warnings: %d\n",
+				sysctl_hung_task_warnings);
+		}
 		pr_err("INFO: task %s:%d blocked for more than %ld seconds.\n",
 		       t->comm, t->pid, (jiffies - t->last_switch_time) / HZ);
 		pr_err("      %s %s %.*s\n",
-- 
2.34.1

