Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67F8172D335
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 23:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237548AbjFLVYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 17:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjFLVXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 17:23:50 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0E11BC5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 14:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686604804; x=1718140804;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wMZPTtx8u8CHnjsziAekYWVXiKMiaDnPOgDW1Y4rfl8=;
  b=kY/5mV4qf3fhqTARv3HplwhWydhi4pRtha0jijzM6GWYA9f5g+Tg2iB+
   wj/SwCKlC6RmlPjDUq+AAhrTs15LJ+9WpR9VHKfphgQUA8pRMVDhaMbUn
   fs/10zGsBp3EteFXvgKot4ujO+zMeU3ITrt8bWPv1lH40yaX+QE07jhQL
   ZRKnUgDdOP/AvV/6HqX4JOt+CCAcVE3jSe8NdZVSwi6tQRoK04ibfujN1
   AEWutwI13UoFnWt8pcZ5LcbHW6KUO/a+fkCzt4fPe9edy1hyIlb7+XcaD
   abFB4Q1KxoyRP/LoOeKkgG95zl3cga3lJ9wUevES/2+Q00zGdfCvzefkS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="342851033"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="342851033"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 14:20:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="741179096"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="741179096"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 12 Jun 2023 14:20:02 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D1C8B357; Tue, 13 Jun 2023 00:20:10 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] mfd: ipaq-micro: Use %*ph for printing hexdump of a small buffer
Date:   Tue, 13 Jun 2023 00:20:07 +0300
Message-Id: <20230612212007.3621-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel already has a helper to print a hexdump of a small
buffer via pointer extension. Use that instead of open coded
variant.

In long term it helps to kill pr_cont() or at least narrow down
its use.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/ipaq-micro.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/ipaq-micro.c b/drivers/mfd/ipaq-micro.c
index 6d3968458e81..57fb7874fc91 100644
--- a/drivers/mfd/ipaq-micro.c
+++ b/drivers/mfd/ipaq-micro.c
@@ -131,10 +131,8 @@ static void micro_rx_msg(struct ipaq_micro *micro, u8 id, int len, u8 *data)
 		break;
 	default:
 		dev_err(micro->dev,
-			"unknown msg %d [%d] ", id, len);
-		for (i = 0; i < len; ++i)
-			pr_cont("0x%02x ", data[i]);
-		pr_cont("\n");
+			"unknown msg %d [%d] %*ph\n", id, len, len, data);
+		break;
 	}
 	spin_unlock(&micro->lock);
 }
-- 
2.40.0.1.gaa8946217a0b

