Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3E9F62D92D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 12:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234817AbiKQLPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 06:15:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234729AbiKQLO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 06:14:57 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66832B02;
        Thu, 17 Nov 2022 03:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668683696; x=1700219696;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=v04Ag2ceXqVcD6vlEr0yMJgTmBUx6AYrMeEO/PVcnzE=;
  b=TUlY7ARYQLeZW0+40xt1ivtVwnWYr3VbUDzxkiWGdALGh9ZwXbISCaFP
   sc+AN1wDgLUy8Uu7wCaByiVXbTEvO+2i4YQKkg2R5+PJtVijQ0N6lvMpP
   h+MXqYjuDf0gPLaOPoclq5YTw+wvfLVChVDIPaK2C4/XBG5wexsX/OgOF
   DOVD/X5luuHlxzlN76GmDfOjsTEbPM50Yy19SyzZAIGzSs2itAe0ngRUm
   ryA3RbBji/ZeTL90vr6OAibRm9AhY4iZMdvXp9FUZMSxqwBqiW5/KPo4H
   8d6InvXRru/+lkUPDaefS7PYp8TQpb7BNjb4oiU7Ne5ME1hWoSD9rHSJh
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="311528571"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="311528571"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 03:14:56 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="814483089"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="814483089"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.129])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 03:14:53 -0800
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org, joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] srcu: Add detection of boot CPU srcu_data structure's->srcu_cblist
Date:   Thu, 17 Nov 2022 19:20:50 +0800
Message-Id: <20221117112050.3942407-1-qiang1.zhang@intel.com>
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

Before SRCU_SIZE_WAIT_CALL srcu_size_state is reached, the srcu
callback only insert to boot-CPU srcu_data structure's->srcu_cblist
and other CPU srcu_data structure's->srcu_cblist is always empty. so
before SRCU_SIZE_WAIT_CALL is reached, need to correctly check boot-CPU
pend cbs in srcu_might_be_idle().

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/srcutree.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 6af031200580..6d9af9901765 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1098,8 +1098,11 @@ static bool srcu_might_be_idle(struct srcu_struct *ssp)
 	unsigned long tlast;
 
 	check_init_srcu_struct(ssp);
-	/* If the local srcu_data structure has callbacks, not idle.  */
-	sdp = raw_cpu_ptr(ssp->sda);
+	/* If the boot CPU or local srcu_data structure has callbacks, not idle.  */
+	if (smp_load_acquire(&ssp->srcu_size_state) < SRCU_SIZE_WAIT_CALL)
+		sdp = per_cpu_ptr(ssp->sda, get_boot_cpu_id());
+	else
+		sdp = raw_cpu_ptr(ssp->sda);
 	spin_lock_irqsave_rcu_node(sdp, flags);
 	if (rcu_segcblist_pend_cbs(&sdp->srcu_cblist)) {
 		spin_unlock_irqrestore_rcu_node(sdp, flags);
-- 
2.25.1

