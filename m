Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 123086F1122
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 06:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345246AbjD1Ev4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 00:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjD1Evy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 00:51:54 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20351210B;
        Thu, 27 Apr 2023 21:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682657514; x=1714193514;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OP1g6h1rDZ7rc72PeYC7NQISlOI1Jx234OuiowuyAi0=;
  b=c9phx1MBS6wuxZQTpqYbKqg7eK0EtN3tk59eKOF/dHGu2E0Q8Nbfwmwa
   1bBkv3Bbl+zifp/P6TGf4AP8JbEri8/oUnNfMDcDBCjTJ7awK3YozCjZd
   22fhm53TxRTgAGLdmEgl+QpSHXSIvYXbsocIo1JXpoPPE4x5Bd69eidoG
   w//KovmCE4yUcwoaS8IH2JuPWccrPmvVzDf1v83zDVcMjFtNT9fHzJd4H
   1LY5AxO2lWhDqUmu//RAapOulqiXIXW45BAeHYvraEnZOhF4TsxId7NdS
   zE8g4Er5Q7Gli5hAcUGRL+V0sRU5loswgpxWc3uG6ToyA9vvRweCQR0xF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="331952636"
X-IronPort-AV: E=Sophos;i="5.99,233,1677571200"; 
   d="scan'208";a="331952636"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 21:51:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="697374330"
X-IronPort-AV: E=Sophos;i="5.99,233,1677571200"; 
   d="scan'208";a="697374330"
Received: from st-server.bj.intel.com ([10.240.193.90])
  by fmsmga007.fm.intel.com with ESMTP; 27 Apr 2023 21:51:51 -0700
From:   Tao Su <tao1.su@linux.intel.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
        yukuai1@huaweicloud.com, tao1.su@linux.intel.com
Subject: [PATCH v2] block: Skip destroyed blkg when restart in blkg_destroy_all()
Date:   Fri, 28 Apr 2023 12:51:49 +0800
Message-Id: <20230428045149.1310073-1-tao1.su@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel hang in blkg_destroy_all() when total blkg greater than
BLKG_DESTROY_BATCH_SIZE, because of not removing destroyed blkg in
blkg_list. So the size of blkg_list is same after destroying a
batch of blkg, and the infinite 'restart' occurs.

Since blkg should stay on the queue list until blkg_free_workfn(),
skip destroyed blkg when restart a new round, which will solve this
kernel hang issue and satisfy the previous will to restart.

Reported-by: Xiangfei Ma <xiangfeix.ma@intel.com>
Tested-by: Xiangfei Ma <xiangfeix.ma@intel.com>
Tested-by: Farrah Chen <farrah.chen@intel.com>
Signed-off-by: Yu Kuai <yukuai1@huaweicloud.com>
Signed-off-by: Tao Su <tao1.su@linux.intel.com>
---
v2:
- change 'directly remove destroyed blkg' to 'skip destroyed blkg'

v1:
- https://lore.kernel.org/all/20230425075911.839539-1-tao1.su@linux.intel.com/

 block/blk-cgroup.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index bd50b55bdb61..75bad5d60c9f 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -528,6 +528,9 @@ static void blkg_destroy_all(struct gendisk *disk)
 	list_for_each_entry_safe(blkg, n, &q->blkg_list, q_node) {
 		struct blkcg *blkcg = blkg->blkcg;
 
+		if (hlist_unhashed(&blkg->blkcg_node))
+			continue;
+
 		spin_lock(&blkcg->lock);
 		blkg_destroy(blkg);
 		spin_unlock(&blkcg->lock);
-- 
2.34.1

