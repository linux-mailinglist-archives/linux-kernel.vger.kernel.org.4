Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371F56EDD7A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 09:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233301AbjDYH7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 03:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233383AbjDYH7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 03:59:31 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE0AE4E;
        Tue, 25 Apr 2023 00:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682409570; x=1713945570;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Gocix4vBihVS2BVVbk9Z88th8E0zeu5NrQL381uKtvk=;
  b=ZQbyszvvJQ3k/bVwlHm0JKpwPubxESydTSY4zjIiZggljrpuhGEErtj4
   4DjLtPqJ9S4BsmZuFeqgZUfiCpKvl8S+KVPwopRbE6dlXL+0wctlKCNt3
   SnTKJbASd5JPhLY7xvIbJWQNMqn1WP0JKSe+p5mgIaKo7iEsA5+u1OC7w
   juuq7DBfOaCUGuUvEPkhjojvTuXVZ+u2tABb5AKB0p0ltZMfRHCieZPE6
   8dvegy95WdsCy3ujpPrVt9KFUA5HffzC5JwTqXroDHLvcAbZ5aBmfHy2+
   BxI+4u4iOJNGkvDlHOSbLSv19a0BHyAN+vMTNlsKyf2PnDiofpNFIbsVm
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="409630585"
X-IronPort-AV: E=Sophos;i="5.99,225,1677571200"; 
   d="scan'208";a="409630585"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2023 00:59:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="1023038048"
X-IronPort-AV: E=Sophos;i="5.99,225,1677571200"; 
   d="scan'208";a="1023038048"
Received: from st-server.bj.intel.com ([10.240.193.90])
  by fmsmga005.fm.intel.com with ESMTP; 25 Apr 2023 00:59:14 -0700
From:   Tao Su <tao1.su@linux.intel.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
        tao1.su@linux.intel.com
Subject: [PATCH] Remove blkg node after destroying blkg
Date:   Tue, 25 Apr 2023 15:59:11 +0800
Message-Id: <20230425075911.839539-1-tao1.su@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel hang when poweroff or reboot, due to infinite restart in function
blkg_destroy_all. It will goto restart label when a batch of blkgs are
destroyed, but not remove blkg node in blkg_list. So the blkg_list is
same in every 'restart' and result in kernel hang.

By adding list_del to remove blkg node after destroying, can solve this
kernel hang issue and satisfy the previous will to 'restart'.

Reported-by: Xiangfei Ma <xiangfeix.ma@intel.com>
Tested-by: Xiangfei Ma <xiangfeix.ma@intel.com>
Tested-by: Farrah Chen <farrah.chen@intel.com>
Signed-off-by: Tao Su <tao1.su@linux.intel.com>
---
 block/blk-cgroup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index bd50b55bdb61..960eb538a704 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -530,6 +530,7 @@ static void blkg_destroy_all(struct gendisk *disk)
 
 		spin_lock(&blkcg->lock);
 		blkg_destroy(blkg);
+		list_del(&blkg->q_node);
 		spin_unlock(&blkcg->lock);
 
 		/*
-- 
2.34.1

