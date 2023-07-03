Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5CE745E31
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 16:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjGCOKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 10:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbjGCOKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 10:10:03 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDF9106
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 07:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688393389; x=1719929389;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YOrJBVE9SyEgwY+WN9IMaBLHIF3QU0EF4DUsRLc6TyA=;
  b=fSYHgugssxD7NNYlOmSprYF1J4yt3MZuNyjEaFR2jCXOvzQsmMmml51q
   0EkxYio74QqDb30ibOgIhMO/zGIZbC5zWzH+bBJ/bpVacS/haqgxCF5qC
   b13hA5o576+Av0aBO6t3V7ZJH2OtRuev+RQzp1yeyUPzAHCW2HD5fjX/D
   s5cK2Dq67M6usyL845zdolfCrNyQH6nwp9V7wsiMCzo7Yi3nNrEtE5gCF
   ZA/0pUKv9W9IY3l6Dwh+vVnz+Zk0bt/N4IbdmXmjUHnZVQDmABdlhIYjx
   kGa4s6/sYdh1jCqV5lcJXRmUQgGFdyjWfqAv8XWufGTMlEIG2GmSd19+U
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="366375376"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="366375376"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 07:09:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="695822929"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="695822929"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 03 Jul 2023 07:09:21 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B2C49170; Mon,  3 Jul 2023 17:09:24 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/2] mfd: ipaq-micro: Use %*ph for printing hexdump of a small buffer
Date:   Mon,  3 Jul 2023 17:09:22 +0300
Message-Id: <20230703140923.2840-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
v2: split another change to a separate patch (Lee)
 drivers/mfd/ipaq-micro.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/mfd/ipaq-micro.c b/drivers/mfd/ipaq-micro.c
index 6d3968458e81..cddfd2e808f2 100644
--- a/drivers/mfd/ipaq-micro.c
+++ b/drivers/mfd/ipaq-micro.c
@@ -131,10 +131,7 @@ static void micro_rx_msg(struct ipaq_micro *micro, u8 id, int len, u8 *data)
 		break;
 	default:
 		dev_err(micro->dev,
-			"unknown msg %d [%d] ", id, len);
-		for (i = 0; i < len; ++i)
-			pr_cont("0x%02x ", data[i]);
-		pr_cont("\n");
+			"unknown msg %d [%d] %*ph\n", id, len, len, data);
 	}
 	spin_unlock(&micro->lock);
 }
-- 
2.40.0.1.gaa8946217a0b

