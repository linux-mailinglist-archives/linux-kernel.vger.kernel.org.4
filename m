Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA3D72D492
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 00:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235721AbjFLWkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 18:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238008AbjFLWkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 18:40:37 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9D1171F;
        Mon, 12 Jun 2023 15:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686609636; x=1718145636;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W0g3K9LOGENgGUyAE6TRJpAv9/VDpuKKRjJ9zM72D7k=;
  b=cdegRwzGWE9VoAhcMTJCeK+VZMCt6Ff/8GhAenx5zJPkbJJjdA9j/osB
   +FHh9dfSyHYrQh92/g0kuJwpmjwtGGpqvQ1MgnepQbZX26yB1QMWWkOnd
   GOPPACfq0o+pR2Z7dVu4s9wBRWngZRnP+pG7Qi62/IbOFV8ueuD7mOv0U
   bYkWV9YX8cehmWHp60srhdfxfZq2nd21hGS50nUh87WLFWO5a/jsLhO4k
   W9sRCu48FGM0W6qZHFTlwz3y0GLTI8wUlUgtmBRvW/z1DMfGA97VzPbqa
   dOxEkZ643vUDAiGcayMYqdosuoHl9sa/wyttODcFjHhyEoqt4Kc07jq0p
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="347829710"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="347829710"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 15:40:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="688805722"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="688805722"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by orsmga006.jf.intel.com with ESMTP; 12 Jun 2023 15:40:35 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 1/2] platform/x86: ISST: Reset default callback on unregister
Date:   Mon, 12 Jun 2023 15:40:32 -0700
Message-Id: <20230612224033.2382527-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230612224033.2382527-1-srinivas.pandruvada@linux.intel.com>
References: <20230612224033.2382527-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When multiple clients are registered and some of those modules are
removed, the default IOCTL callback for those clients are still not
NULL. Calling them will result in crash.

Set the default IOCTL callback pointer to NULL on unregister.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/platform/x86/intel/speed_select_if/isst_if_common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
index e0572a29212e..352bf5118d17 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
@@ -831,6 +831,7 @@ void isst_if_cdev_unregister(int device_type)
 {
 	isst_misc_unreg();
 	mutex_lock(&punit_misc_dev_open_lock);
+	punit_callbacks[device_type].def_ioctl = NULL;
 	punit_callbacks[device_type].registered = 0;
 	if (device_type == ISST_IF_DEV_MBOX)
 		isst_delete_hash();
-- 
2.38.1

