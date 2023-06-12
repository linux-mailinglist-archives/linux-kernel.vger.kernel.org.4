Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDF672D493
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 00:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237066AbjFLWkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 18:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238880AbjFLWki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 18:40:38 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B911701;
        Mon, 12 Jun 2023 15:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686609637; x=1718145637;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nmy6zHBx+bkBSYjlmBky7iQxIWpRhMEDa79EgpifsIM=;
  b=Jk+OiHaUmGtAzT4Qz74/yKmZBG/24TmDSYjxtBK2iaTWUxRbZ1przRXJ
   Of8uo+yDgyAuhZ6WlmYrORVxYUCpy3q8d26lnPVNxmr02fbEhFFLdaa3b
   mOdCf8dLZN1zKJopMjdJrT+jabPmf3KEXjr0TtevU81tDHgrfLKYAdmuM
   3ZqJJ97+vJctFNPBQ8hAcwSP/sztPH/A0uDRBB19iypI7xdjKcAqM9SVV
   jb58Vmo13RDMnynyClIKzRG0M+NdihEON3L7fOkw7EowFP7hqtSfGlozw
   +4sIoPdZeiTH1NlpGwAuO/0vGlH+tsP7gurz+Y8hhKHrwPPq5czK4tsM0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="347829715"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="347829715"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 15:40:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="688805723"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="688805723"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by orsmga006.jf.intel.com with ESMTP; 12 Jun 2023 15:40:35 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 2/2] platform/x86: ISST: Fix usage counter
Date:   Mon, 12 Jun 2023 15:40:33 -0700
Message-Id: <20230612224033.2382527-3-srinivas.pandruvada@linux.intel.com>
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

On multi package system, the TPMI SST instance is getting allocated
again as the usage counter is not getting incremented. Here the
instance is allocated only when the usage count is zero. There is
no need to allocate again.

Increment usage ID on successful return from isst_if_cdev_register().

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
index 664d2ee60385..63faa2ea8327 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
@@ -1414,6 +1414,8 @@ int tpmi_sst_init(void)
 	ret = isst_if_cdev_register(ISST_IF_DEV_TPMI, &cb);
 	if (ret)
 		kfree(isst_common.sst_inst);
+	else
+		++isst_core_usage_count;
 init_done:
 	mutex_unlock(&isst_tpmi_dev_lock);
 	return ret;
-- 
2.38.1

