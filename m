Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C81747B77
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 04:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjGECUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 22:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjGECUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 22:20:09 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AABD10E3
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 19:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688523608; x=1720059608;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LfdV5CNoYjK7UQgvI7xVw/46x3sR/AWcKvOG1E3NDnM=;
  b=eiTwTrMrC0W9a/oxh/tHw0sWwLLZ3tXewfjWDzAw5X63iYUGIGO/dEh9
   6W9Wq8YnINM+riYFSMrkWuWLmg8jE2T7nxUDlX8XUl7vgDOVukDJJurTM
   KNm5zeUS3oXokwQdOxqtx8EzulDEYfEC4eTamLoo6pEP+gNyJZTdOEeER
   SPE/UhyMtsAFtlFkkrqN/wDKqtEhWYDLfNNxhh5kbZwzM/YOiqtbKB9ix
   pDKw4F2179S0uwYYd5/lWh3rBPRyxNBjMKd204SR+oQM1jj6a3/9k2kPj
   LqjMDRD9kSu+tnTzPCcPtKkZl7BL45Y4HFL00PQNAR8qRUKnVhiKiwMqv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10761"; a="353058742"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="353058742"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2023 19:20:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10761"; a="713029258"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="713029258"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.117])
  by orsmga007.jf.intel.com with ESMTP; 04 Jul 2023 19:20:07 -0700
From:   kah.jing.lee@intel.com
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-kernel@vger.kernel.org, tien.sung.ang@intel.com,
        Kah Jing Lee <kah.jing.lee@intel.com>
Subject: [PATCH] firmware: stratix10-rsu: prevent io block when sending RSU messages
Date:   Wed,  5 Jul 2023 10:18:47 +0800
Message-Id: <20230705021846.1536829-1-kah.jing.lee@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kah Jing Lee <kah.jing.lee@intel.com>

Fix the issue for preventing recursive rsu mutex lock
issue in RSU update command.

Signed-off-by: Kah Jing Lee <kah.jing.lee@intel.com>
---
 drivers/firmware/stratix10-rsu.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/stratix10-rsu.c b/drivers/firmware/stratix10-rsu.c
index e51c95f8d445..0a7542e9bb6f 100644
--- a/drivers/firmware/stratix10-rsu.c
+++ b/drivers/firmware/stratix10-rsu.c
@@ -280,7 +280,9 @@ static int rsu_send_msg(struct stratix10_rsu_priv *priv,
 	struct stratix10_svc_client_msg msg;
 	int ret;
 
-	mutex_lock(&priv->lock);
+	if (!mutex_trylock(&priv->lock))
+		return -EAGAIN;
+
 	reinit_completion(&priv->completion);
 	priv->client.receive_cb = callback;
 
@@ -525,7 +527,9 @@ static ssize_t reboot_image_store(struct device *dev,
 
 	ret = rsu_send_msg(priv, COMMAND_RSU_UPDATE,
 			   address, rsu_command_callback);
-	if (ret) {
+	if (ret == -EAGAIN)
+		return 0;
+	else if (ret) {
 		dev_err(dev, "Error, RSU update returned %i\n", ret);
 		return ret;
 	}
-- 
2.25.1

