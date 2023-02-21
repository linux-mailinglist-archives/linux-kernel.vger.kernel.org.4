Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E2769DA14
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 05:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232864AbjBUE1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 23:27:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232246AbjBUE11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 23:27:27 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053D11DB9C;
        Mon, 20 Feb 2023 20:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676953646; x=1708489646;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5YJ43hxMipF5xu85Pb0p9sSULFrCt3o2ltZBRAD0gEc=;
  b=UaJXoYx6hGLoDj0qA+RNuTi19wgfYD5B5CDspDuiAIEeFFs3MG3jqRJF
   pwewnArhnnct3IpoxCwdN3PqEz40FTGeD2dIbb9+VCvreO3VEq73PtnFy
   vlGqsNFnns/1tPPsYiGcPTxDAjh3n2mHHzV/hyeaykDYEI88f4+6cIbZJ
   X5dVvWSJyRXSw3On0ON04+grGCmkOCMInnG57sDu/PAzoVCgbVlkQP5Ui
   08UzAdR01GOQNXzDLu+5dCiD7sSSO3lBJEqk+g5RgbE6aXaFngsQakNeh
   iDOpunW//w0NOZDebAdtWnomgWJ6IT2o/NjTRMzynBp1lXSJxw8krSKUC
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="332549096"
X-IronPort-AV: E=Sophos;i="5.97,314,1669104000"; 
   d="scan'208";a="332549096"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2023 20:27:26 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10627"; a="671505425"
X-IronPort-AV: E=Sophos;i="5.97,314,1669104000"; 
   d="scan'208";a="671505425"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.129])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2023 20:27:24 -0800
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org, joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rcu-tasks: Allow RCU-Task trace stall warning dump late IPI CPU stacks
Date:   Tue, 21 Feb 2023 12:32:19 +0800
Message-Id: <20230221043219.2384044-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The task structure's->trc_ipi_to_cpu and percpu trc_ipi_to_cpu is
used to record whether the IPI is completed, if the percpu trc_ipi_to_cpu
is true and task structure's->trc_ipi_to_cpu is non-negative value,
indicates that IPI is not completed, if the IPI is unresponsive for
along time for some reason, there will be a possibility of causing
RCU-Tasks trace stall. this commit therefore allow dump late IPI CPU
stacks to show the path that current CPU is executing.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 In the real world, the IPI delay will be very small, so the
 probability of triggering dump_cpu_stack() may be very low,
 so if I makes noise, please ignore it.

 kernel/rcu/tasks.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index baf7ec178155..85237fc1d0f0 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1658,8 +1658,13 @@ static void show_stalled_ipi_trace(void)
 	int cpu;
 
 	for_each_possible_cpu(cpu)
-		if (per_cpu(trc_ipi_to_cpu, cpu))
+		if (per_cpu(trc_ipi_to_cpu, cpu)) {
 			pr_alert("\tIPI outstanding to CPU %d\n", cpu);
+			if (cpu_is_offline(cpu))
+				pr_alert("offline CPU %d blocking gp\n", cpu);
+			else
+				dump_cpu_task(cpu);
+		}
 }
 
 /* Do one scan of the holdout list. */
-- 
2.25.1

