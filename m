Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01C35BDD9C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 08:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbiITGs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 02:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbiITGsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 02:48:54 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B14D5E540
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 23:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663656534; x=1695192534;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RGdm1aXssN9TFvb1NrVDWI/D7fOta/uR4tLNgHnBB94=;
  b=gW+oOuCliVebTJ3v1YjDCWY1ptu1sWYceFk6FlXjH+e5rL9tqJks59mV
   ALknc40nbX7AQ4Px+bYMonyqXwLTurvE19ymqgI0MLHukwmOwrn39rQEk
   +q9sKxkjPnj1rHAUlYHRE4l+AYp/3mEhrVSdE6gcpF/ta1lurTRV2ce89
   GDXyGeB/k/GqaSPoqY7j7yAGkywiGU7iP29lhp38vWFufXSPP7nXt/Gzi
   oScpyTiG0Y6Nns/2yP4zLqaj8b8XCOdBZDE3KYVBmcQqo1YXG4iRUBaeU
   uHMAiVSCBMcKcQQbbsE0O5omyqu3oPEBL6hA5sYnlVh9grtc1tFNuvGiA
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="363573553"
X-IronPort-AV: E=Sophos;i="5.93,329,1654585200"; 
   d="scan'208";a="363573553"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 23:48:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,329,1654585200"; 
   d="scan'208";a="681172664"
Received: from linux-pnp-server-13.sh.intel.com ([10.239.176.176])
  by fmsmga008.fm.intel.com with ESMTP; 19 Sep 2022 23:48:49 -0700
From:   Jiebin Sun <jiebin.sun@intel.com>
To:     akpm@linux-foundation.org, vasily.averin@linux.dev,
        shakeelb@google.com, dennis@kernel.org, tj@kernel.org,
        cl@linux.com, ebiederm@xmission.com, legion@kernel.org,
        manfred@colorfullife.com, alexander.mikhalitsyn@virtuozzo.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     tim.c.chen@intel.com, feng.tang@intel.com, ying.huang@intel.com,
        tianyou.li@intel.com, wangyang.guo@intel.com, jiebin.sun@intel.com,
        Manfred Spraul <manfred@colorfullif.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: [PATCH] ipc/msg: avoid negative value by overflow in msginfo
Date:   Tue, 20 Sep 2022 23:08:09 +0800
Message-Id: <20220920150809.4014944-1-jiebin.sun@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <8d74a7d4-b80f-2a0f-ee95-243bdbd51ccd@colorfullife.com>
References: <8d74a7d4-b80f-2a0f-ee95-243bdbd51ccd@colorfullife.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 32-bit value in msginfo struct could be negative if we get it
from signed 64-bit. Clamping it to INT_MAX helps to avoid the
negative value by overflow.

Signed-off-by: Jiebin Sun <jiebin.sun@intel.com>
Reviewed-by: Manfred Spraul <manfred@colorfullif.com>
Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 ipc/msg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ipc/msg.c b/ipc/msg.c
index f2bb4c193ecf..65f437e28c9b 100644
--- a/ipc/msg.c
+++ b/ipc/msg.c
@@ -501,8 +501,8 @@ static int msgctl_info(struct ipc_namespace *ns, int msqid,
 	max_idx = ipc_get_maxidx(&msg_ids(ns));
 	up_read(&msg_ids(ns).rwsem);
 	if (cmd == MSG_INFO) {
-		msginfo->msgmap = percpu_counter_sum(&ns->percpu_msg_hdrs);
-		msginfo->msgtql = percpu_counter_sum(&ns->percpu_msg_bytes);
+		msginfo->msgmap = min(percpu_counter_sum(&ns->percpu_msg_hdrs), INT_MAX);
+		msginfo->msgtql = min(percpu_counter_sum(&ns->percpu_msg_bytes), INT_MAX);
 	} else {
 		msginfo->msgmap = MSGMAP;
 		msginfo->msgpool = MSGPOOL;
-- 
2.31.1

