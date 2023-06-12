Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D6D72D33C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 23:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235206AbjFLVZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 17:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239061AbjFLVZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 17:25:24 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DBE010EB
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 14:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686605011; x=1718141011;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OnJIaM6mT/0GSvLlclpAypaShpM1x4qhu+renP9R2l8=;
  b=F6ntnhE3FWIL9X9D2UpCRhDiFP8LmqvXbopQKVJVhMWirTIReZbWTYkD
   jSWFta9+x73qUF/etA+PmnGccaiCCAvgCJpbYyTfeZr8flHfIDC+lJr/4
   Na8z8dId058+TRlsrRcKxOfK9+f2RfUh0/VYH98kBLSwlkVsuObTFb2yc
   FRVUbeCIdfor0tXCP3auqxLMdaQ5xcO1cEN7S9+klxARitJmScWjFZKM8
   XcyCpZ6/2saCd75+l1WgC22UmusQalIJnUYYdHLstfBwtdGJUgCUX1TMv
   RenIz1vUfVYP6XkQ5CrUHiNFOJ8AAcsM/kuhLhbr8xL4Ga82InOFIOwPo
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="444542960"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="444542960"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 14:23:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="705539158"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="705539158"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 12 Jun 2023 14:23:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id DF037357; Tue, 13 Jun 2023 00:23:37 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH v1 1/1] platform/chrome: cros_ec_spi: Use %*ph for printing hexdump of a small buffer
Date:   Tue, 13 Jun 2023 00:23:36 +0300
Message-Id: <20230612212336.4961-1-andriy.shevchenko@linux.intel.com>
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
 drivers/platform/chrome/cros_ec_spi.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_spi.c b/drivers/platform/chrome/cros_ec_spi.c
index 21143dba8970..3e88cc92e819 100644
--- a/drivers/platform/chrome/cros_ec_spi.c
+++ b/drivers/platform/chrome/cros_ec_spi.c
@@ -104,13 +104,7 @@ static void debug_packet(struct device *dev, const char *name, u8 *ptr,
 			 int len)
 {
 #ifdef DEBUG
-	int i;
-
-	dev_dbg(dev, "%s: ", name);
-	for (i = 0; i < len; i++)
-		pr_cont(" %02x", ptr[i]);
-
-	pr_cont("\n");
+	dev_dbg(dev, "%s: %*ph\n", name, len, ptr);
 #endif
 }
 
-- 
2.40.0.1.gaa8946217a0b

