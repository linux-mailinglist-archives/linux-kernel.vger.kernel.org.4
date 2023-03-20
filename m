Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB8006C0A40
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 06:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjCTFxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 01:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjCTFxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 01:53:17 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1511ACDC;
        Sun, 19 Mar 2023 22:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679291596; x=1710827596;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=s53Y8E43SOnt3MzV0UsGCY+fSn4146kqhXgcjhNK8eQ=;
  b=oHJzsoTUSnqaV61e1fh88qdiLlR/juRU8vw84VvUGDfbuHrC1E2DZWpa
   6Rq+I/KCaL7oMOOaVrHuXmy4ZWkGVfIuFQS5IBzpvzVJkAEhMsrAJxzKE
   KJ34QU8V7w4BpH1D3QeuYh/AxTTdWY1cSI2+uT/7JOiENfSbbw39NuZ0M
   /VXbB+wtNhX02ANJNOQR9eMxswo9Rc9AYUhEMFlrKLNdA4an4BQn8z1H7
   ZPP/U3rB2gY3MrAroi0/RdkIYuO60whSlUuYaZkNB5/3cTcEEbR7QIWuL
   jH9To9Vo1D0WjEYHJo7uNAdrG3GfNq9RMvj0ZA0Yn5VKL/+aeeVATDW7d
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="337295804"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="337295804"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2023 22:53:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="804789228"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="804789228"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.129])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2023 22:53:14 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org, joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] srcu: Fix srcu structure's->srcu_sup memory leak in init_srcu_struct_fields()
Date:   Mon, 20 Mar 2023 13:57:51 +0800
Message-Id: <20230320055751.4120251-1-qiang1.zhang@intel.com>
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

When use init_srcu_struct() to initializing srcu structure, and
will allocate memory for srcu structure's->sda and ->srcu_sup,
however, if allocate srcu structure's->sda memory failed, the
srcu structure's->srcu_sup memory need to be released.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/srcutree.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index d86ff4eb015a..1fb078abbdc9 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -255,8 +255,11 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
 	ssp->srcu_sup->sda_is_static = is_static;
 	if (!is_static)
 		ssp->sda = alloc_percpu(struct srcu_data);
-	if (!ssp->sda)
+	if (!ssp->sda) {
+		if (!is_static)
+			kfree(ssp->srcu_sup);
 		return -ENOMEM;
+	}
 	init_srcu_struct_data(ssp);
 	ssp->srcu_sup->srcu_gp_seq_needed_exp = 0;
 	ssp->srcu_sup->srcu_last_gp_end = ktime_get_mono_fast_ns();
@@ -265,6 +268,7 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
 			if (!ssp->srcu_sup->sda_is_static) {
 				free_percpu(ssp->sda);
 				ssp->sda = NULL;
+				kfree(ssp->srcu_sup);
 				return -ENOMEM;
 			}
 		} else {
-- 
2.25.1

