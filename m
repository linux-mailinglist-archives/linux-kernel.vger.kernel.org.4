Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA8F6D127F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 00:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbjC3WsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 18:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbjC3Wru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 18:47:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ABEF1114B;
        Thu, 30 Mar 2023 15:47:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2918621BB;
        Thu, 30 Mar 2023 22:47:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52401C433D2;
        Thu, 30 Mar 2023 22:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680216448;
        bh=E9GTy32jkGXjdmoTYxiGB6g5bP4dr0pfdets2Um+Or8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u+uDNVTC3lJmsZ4zrN0/meReh7P86RPhejFgW8UZcT8mLI8U9KWrnSLNGCwdTcDAO
         Jr4q4p6UXtOQjklFwhWVZVW+AmxW8rK/+l3Cpqxpr2j0gZWsXu2GhFH+FHd/LUR0pn
         nZkYmpfbiN37yMvPvJm+1/1OBsSIQ6Evh7AWyTPu0+9LB+j/TIgD4CE9o/gLVzqrjz
         bT7iytN6w8QjGpDaHda8rYf8oAKbjjECZlHmwZRSkNo1z3oamujrB4vi8Wr2v2y2f1
         ctdA3zdUXvEemNfUu3pX5YpKew8TZd4XlmEVhr387auhS7tIWaYMwgPVd+rskpW6YD
         efUAYG28klMKQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id EC2791540476; Thu, 30 Mar 2023 15:47:27 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, hch@lst.de,
        "Paul E. McKenney" <paulmck@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH rcu 01/20] rcu-tasks: Fix warning for unused tasks_rcu_exit_srcu
Date:   Thu, 30 Mar 2023 15:47:07 -0700
Message-Id: <20230330224726.662344-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.0.rc2
In-Reply-To: <f1b6cd5f-f0b7-4748-abd5-0dcfef0ce126@paulmck-laptop>
References: <f1b6cd5f-f0b7-4748-abd5-0dcfef0ce126@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tasks_rcu_exit_srcu variable is used only by kernels built
with CONFIG_TASKS_RCU=y, but is defined for all kernesl with
CONFIG_TASKS_RCU_GENERIC=y.  Therefore, in kernels built with
CONFIG_TASKS_RCU_GENERIC=y but CONFIG_TASKS_RCU=n, this gives
a "defined but not used" warning.

This commit therefore moves this variable under CONFIG_TASKS_RCU.

Link: https://lore.kernel.org/oe-kbuild-all/202303191536.XzMSyzTl-lkp@intel.com/
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index bfb5e1549f2b..185358c2f08d 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -136,8 +136,10 @@ static struct rcu_tasks rt_name =							\
 	.kname = #rt_name,								\
 }
 
+#ifdef CONFIG_TASKS_RCU
 /* Track exiting tasks in order to allow them to be waited for. */
 DEFINE_STATIC_SRCU(tasks_rcu_exit_srcu);
+#endif
 
 /* Avoid IPIing CPUs early in the grace period. */
 #define RCU_TASK_IPI_DELAY (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB) ? HZ / 2 : 0)
-- 
2.40.0.rc2

