Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFFF5ECADB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 19:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbiI0RaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 13:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232402AbiI0RaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 13:30:01 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4775E6CD3A;
        Tue, 27 Sep 2022 10:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664299799; x=1695835799;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LtIRyR8kxAEXhrL4ex1wZ7Rxv9QJ+zQ05SYLHG0tBEc=;
  b=K2Q6yvM9yn6361umwrvxKcfJVhJouDwUgx5VrZuSs1+eGo78dIKrLHje
   NX3nKe7xhAocBa0Ldnm76SqGSYyfSQQwo36LuCmBTLexFe3XDbR+DaY4i
   g6WUSZa3mSSdGGG2EC3me/QWN6R+bmajHCN1VIfY9Z2PtCTIqPcX7uLr0
   fo9OHFMN8Ek4U0/Qnt0woNmy+2ljJzZ4e9Kn/KrmNnZV983lhQH/TEZxI
   3IUW0cazsKNwdIX0tbXujQZyXqre99fVXlHw6p6zPSKdjfuEDgnWklc3J
   szYyhQPbfac/FKwcIEykVgHFpMO4vLL8iHNOeR4MjDy4xLBD9jNPBuxF6
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="284507594"
X-IronPort-AV: E=Sophos;i="5.93,350,1654585200"; 
   d="scan'208";a="284507594"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 10:29:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="599257238"
X-IronPort-AV: E=Sophos;i="5.93,350,1654585200"; 
   d="scan'208";a="599257238"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 27 Sep 2022 10:29:55 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 149337C; Tue, 27 Sep 2022 20:30:13 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-media@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] staging: media: tegra-video: Replace custom implementation of device_match_fwnode()
Date:   Tue, 27 Sep 2022 20:30:11 +0300
Message-Id: <20220927173011.72571-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace custom implementation of the device_match_fwnode().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/staging/media/tegra-video/vi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/tegra-video/vi.c b/drivers/staging/media/tegra-video/vi.c
index 9d46a36cc014..11dd142c98c5 100644
--- a/drivers/staging/media/tegra-video/vi.c
+++ b/drivers/staging/media/tegra-video/vi.c
@@ -1811,7 +1811,7 @@ static int tegra_vi_graph_parse_one(struct tegra_vi_channel *chan,
 		}
 
 		/* skip entities that are already processed */
-		if (remote == dev_fwnode(vi->dev) ||
+		if (device_match_fwnode(vi->dev, remote) ||
 		    tegra_vi_graph_find_entity(chan, remote)) {
 			fwnode_handle_put(remote);
 			continue;
-- 
2.35.1

