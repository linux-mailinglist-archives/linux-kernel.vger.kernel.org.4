Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73FAA6224A7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 08:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbiKIHa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 02:30:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbiKIHap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 02:30:45 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54CC1193D8;
        Tue,  8 Nov 2022 23:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667979038; x=1699515038;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PMzlzdz0ybzMH3t3AqOhxfPPE3vzhr6WZmccqfoaki8=;
  b=Wp/6K3ni/Q6hVN0lWj8Nlc1COWXhRmS3uGLjP2jsB9xTye5/z/ncfgcO
   8h9xvemQG+BJdJyytBUsL7SPwZLVc/DvqMZ+dZtXaBFzv7PFK1z41vR4u
   vS9r6Tc78HWKsNJvhYaicumEDuk8haVRLpg6QIyE1YqEx2xGtP7Fk7FZI
   ZbD7TRX1zemKjF2LriIncnAvUvlhBIerrHB6xrYJc6tsj7Mb6kRwz5kPJ
   TVDvvQeuZM1UxskyO7T97jSOXIFBrzrCF1jj/rSm9EoiQfPsDQPlF3zbM
   G8o/SObGg2pBev6QCKNBGD+v73d3loOvqbAnRq1FT/X6nQtoGchjodVkR
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="337642947"
X-IronPort-AV: E=Sophos;i="5.96,149,1665471600"; 
   d="scan'208";a="337642947"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 23:30:38 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="881827031"
X-IronPort-AV: E=Sophos;i="5.96,149,1665471600"; 
   d="scan'208";a="881827031"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.129])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 23:30:36 -0800
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org, joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] srcu: Make Tiny SRCU synchronize_srcu() more complete
Date:   Wed,  9 Nov 2022 15:36:38 +0800
Message-Id: <20221109073638.935473-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit add lockdep detection for illegal use synchronize_srcu()
in same-type SRCU (or in RCU) read-side critical section and support
early boot operations.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/srcutiny.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
index 33adafdad261..b12fb0cec44d 100644
--- a/kernel/rcu/srcutiny.c
+++ b/kernel/rcu/srcutiny.c
@@ -197,6 +197,16 @@ void synchronize_srcu(struct srcu_struct *ssp)
 {
 	struct rcu_synchronize rs;
 
+	RCU_LOCKDEP_WARN(lockdep_is_held(ssp) ||
+			lock_is_held(&rcu_bh_lock_map) ||
+			lock_is_held(&rcu_lock_map) ||
+			lock_is_held(&rcu_sched_lock_map),
+			"Illegal synchronize_srcu() in same-type SRCU (or in RCU) read-side critical section");
+
+	if (rcu_scheduler_active == RCU_SCHEDULER_INACTIVE)
+		return;
+
+	might_sleep();
 	init_rcu_head_on_stack(&rs.head);
 	init_completion(&rs.completion);
 	call_srcu(ssp, &rs.head, wakeme_after_rcu);
-- 
2.25.1

