Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1746CABC5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 19:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbjC0RUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 13:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232207AbjC0RUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 13:20:35 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481CD3A82;
        Mon, 27 Mar 2023 10:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679937631; x=1711473631;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4hisg40aJmrsK8xqexK+I9xoMoksxoHrWuTzGu9o9F0=;
  b=KeHbdFa8Fwv/OQ8AMvGfPvg/o+W5KInMtf3kmIS+M/lFrqG2W1k8DAcb
   VbAZp+x219GD1snHBqGwHmXLpblbQqy1VdvS1uPhjcoqSvsXfHtYMtbXp
   MYOZttqmoJ5sx8NmVnxI10qr7UUd7LXgs/VSHftMRBT3bp8OmOdnUQaM8
   DfawX8sjE9YELP74utxGRfy+HSSlGfDo05GwIn9dLVOcxplfZDy14wqjL
   BycqgnATkMBbGMjYj+wkKr5Ttd7yo7ohEIwvz28vJkHgeYRl3AyxeePgX
   GrjlvdviqG6q6XhkLfjTXxrJWRb8fruzjQ9pVFTzSqdG5W7N6P864bvD2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="368086554"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="368086554"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 10:20:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="857734893"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="857734893"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 27 Mar 2023 10:20:28 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 0658380A; Mon, 27 Mar 2023 20:20:28 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>
Subject: [PATCH v1 2/2] thunderbolt: Make use of SI units from units.h
Date:   Mon, 27 Mar 2023 20:20:17 +0300
Message-Id: <20230327172017.20078-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230327172017.20078-1-andriy.shevchenko@linux.intel.com>
References: <20230327172017.20078-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a couple of places it seems reasonable to use MEGA intead
of explicit number. It makes code more readable and robust.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/thunderbolt/usb4.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/thunderbolt/usb4.c b/drivers/thunderbolt/usb4.c
index 2d4b6f3e6141..12355929e586 100644
--- a/drivers/thunderbolt/usb4.c
+++ b/drivers/thunderbolt/usb4.c
@@ -9,6 +9,7 @@
 
 #include <linux/delay.h>
 #include <linux/ktime.h>
+#include <linux/units.h>
 
 #include "sb_regs.h"
 #include "tb.h"
@@ -1995,7 +1996,7 @@ static unsigned int usb3_bw_to_mbps(u32 bw, u8 scale)
 	unsigned long uframes;
 
 	uframes = bw * 512UL << scale;
-	return DIV_ROUND_CLOSEST(uframes * 8000, 1000 * 1000);
+	return DIV_ROUND_CLOSEST(uframes * 8000, MEGA);
 }
 
 static u32 mbps_to_usb3_bw(unsigned int mbps, u8 scale)
@@ -2003,7 +2004,7 @@ static u32 mbps_to_usb3_bw(unsigned int mbps, u8 scale)
 	unsigned long uframes;
 
 	/* 1 uframe is 1/8 ms (125 us) -> 1 / 8000 s */
-	uframes = ((unsigned long)mbps * 1000 *  1000) / 8000;
+	uframes = ((unsigned long)mbps * MEGA) / 8000;
 	return DIV_ROUND_UP(uframes, 512UL << scale);
 }
 
-- 
2.40.0.1.gaa8946217a0b

