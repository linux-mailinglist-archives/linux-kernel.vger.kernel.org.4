Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5BC736FB9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 17:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233452AbjFTPER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 11:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233506AbjFTPDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 11:03:48 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295BD2132;
        Tue, 20 Jun 2023 08:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687273386; x=1718809386;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Hzw44yA3rq4A0NkiNihEuh1kmsiFbLAMHu6FhlLV5CY=;
  b=dvIOePVKAx/xtC1am05TA9fMEcxZkiSosCtYNJ65Osx2kWmXzh0MGKA7
   mtUCaTil1LOmw5q6VXagk8QJGroaBK6uqG3WTe/LtKvGra8+B/RXpRyAr
   +Qr5JbhzbKN/f1bjDNTRbi+GkHvL4RagCAub6+DI7DTHMPkTfgQ04FGZ8
   ORxNERBsxQAO+vFKvXYfi6w4av7DPDiTRCBzHvFaWOdUuyuBDw+IjbT6C
   69S2xSL4KuM/S3S4nNAgZUM+9gzaoTnXj6fXNePmPRCtiV7YmSUQMmreT
   MBe19QlcP/5B+CXCimxPMstoyhiPF+T4v+gWAh8gDRzymMNOEsP/lLG1f
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="358756249"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; 
   d="scan'208";a="358756249"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 08:01:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="888268694"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; 
   d="scan'208";a="888268694"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 20 Jun 2023 08:01:51 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5A6C2413; Tue, 20 Jun 2023 18:02:01 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/1] pktcdvd: Use clamp() instead of min()+max()
Date:   Tue, 20 Jun 2023 18:01:59 +0300
Message-Id: <20230620150159.63886-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a couple of places replace min()+max() pair by clamp().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: Switched to clamp() for strict type checking (David)
 drivers/block/pktcdvd.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index a1428538bda5..2fe56afc53d4 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -208,14 +208,11 @@ static DEVICE_ATTR_RO(size);
 static void init_write_congestion_marks(int* lo, int* hi)
 {
 	if (*hi > 0) {
-		*hi = max(*hi, 500);
-		*hi = min(*hi, 1000000);
+		*hi = clamp(*hi, 500, 1000000);
 		if (*lo <= 0)
 			*lo = *hi - 100;
-		else {
-			*lo = min(*lo, *hi - 100);
-			*lo = max(*lo, 100);
-		}
+		else
+			*lo = clamp(*lo, 100, *hi - 100);
 	} else {
 		*hi = -1;
 		*lo = -1;
-- 
2.40.0.1.gaa8946217a0b

