Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30EEA68255D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 08:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjAaHGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 02:06:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjAaHGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 02:06:06 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F541701;
        Mon, 30 Jan 2023 23:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675148766; x=1706684766;
  h=from:to:cc:subject:date:message-id;
  bh=ZGgufHzmQCvzFlko20VrIIH01XmxCACYYtOG7HWEiB8=;
  b=lmtC++k2Tk7VtfI/SuWi6eBDrz3faTGcCUO4/5gfzfRSePCsCdGsB3lP
   cf7VEb8oWWYmGttmo9ctPFgvtadC7b68MHylGdAsxloPVuwKQWkKL6iRh
   1EBam3+Sf8JG7LCP9sQTjKx6L0KMDyku73av4Tcyl4M7fi2K0fRt9Y+pj
   0bwWqyBtLb6QN91JnWWwdKQetT3g/nwkhAquQgQpEAuRLrsU/8LtRyDQV
   lvMkJDl+xcYy1m5IPKOupGq8YwbLNYzqptIPQVJdTcwWRRurRDVYd1mlJ
   c+R6ZSxjIByuW9FOVJ83MDVFBq0QS17qOieIx4yee1qUPI9FKr8+MnKeD
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="311391892"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="311391892"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 23:06:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="806997797"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="806997797"
Received: from storage2.sh.intel.com (HELO localhost) ([10.67.111.9])
  by fmsmga001.fm.intel.com with ESMTP; 30 Jan 2023 23:06:02 -0800
From:   Liu Xiaodong <xiaodong.liu@intel.com>
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Liu Xiaodong <xiaodong.liu@intel.com>,
        Jim Harris <james.r.harris@intel.com>,
        Ben Walker <benjamin.walker@intel.com>
Subject: [PATCH] block: ublk: extending queue_size to fix overflow
Date:   Tue, 31 Jan 2023 02:05:52 -0500
Message-Id: <20230131070552.115067-1-xiaodong.liu@intel.com>
X-Mailer: git-send-email 2.14.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When validating drafted SPDK ublk target, in a case that
assigning large queue depth to multiqueue ublk device,
ublk target would run into a weird incorrect state. During
rounds of review and debug, An overflow bug was found
in ublk driver.

In ublk_cmd.h, UBLK_MAX_QUEUE_DEPTH is 4096 which means
each ublk queue depth can be set as large as 4096. But
when setting qd for a ublk device,
sizeof(struct ublk_queue) + depth * sizeof(struct ublk_io)
will be larger than 65535 if qd is larger than 2728.
Then queue_size is overflowed, and ublk_get_queue()
references a wrong pointer position. The wrong content of
ublk_queue elements will lead to out-of-bounds memory
access.

Extend queue_size in ublk_device as "unsigned int".

Signed-off-by: Liu Xiaodong <xiaodong.liu@intel.com>
---
 drivers/block/ublk_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index e54693204630..6368b56eacf1 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -137,7 +137,7 @@ struct ublk_device {
 
 	char	*__queues;
 
-	unsigned short  queue_size;
+	unsigned int	queue_size;
 	struct ublksrv_ctrl_dev_info	dev_info;
 
 	struct blk_mq_tag_set	tag_set;
-- 
2.14.5

