Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C55126043D1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 13:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbiJSLtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 07:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbiJSLs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 07:48:27 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F0F65246;
        Wed, 19 Oct 2022 04:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666178859; x=1697714859;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XMFggGUT5rB2EsYur5TAIr34+vLXDytXkSJIKAo1bvg=;
  b=DxSXXWH4LM/YFHBvb92HeFFZi9Rx+tAQB8SzL0aApKUbM+mpn+OQEgT2
   xfTWv1YEon3Oe8xHa/98C1hxlWyn5axdeJfohS/G9PgnXZjXyO2jfPQr4
   AVbMdKgNgaY0o4hIosY5SVHfHFkS/4pm4jDS0bquz8jP93OLkvUz9VAr2
   2QRmKmveLPHZIvrBezeY+Kqiku2dwfcUjs0L4z3y7Sgh/7meEfbvoDyr7
   txKBmhhG2cWGS7wAZb1XE0MnhjM8NV2lw5qmf5g7ZDzUy3pZOtUCqsniY
   lZ4tTvnMZifatltrXUf1lfm1o5QxHm1esC+GP2NNjnMn8Sv4RVlXFNhsj
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="392677104"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="392677104"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 03:55:18 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="580282738"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="580282738"
Received: from sponnura-mobl1.amr.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.214.35])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 03:55:16 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 2/2] tty: Cleanup tty buffer align mask
Date:   Wed, 19 Oct 2022 13:55:04 +0300
Message-Id: <20221019105504.16800-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221019105504.16800-1-ilpo.jarvinen@linux.intel.com>
References: <20221019105504.16800-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't use decimal for mask. Don't use literal for aligning.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/tty_buffer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index b408d830fcbc..2df86ed90574 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -21,7 +21,7 @@
 #include "tty.h"
 
 #define MIN_TTYB_SIZE	256
-#define TTYB_ALIGN_MASK	255
+#define TTYB_ALIGN_MASK	0xff
 
 /*
  * Byte threshold to limit memory consumption for flip buffers.
@@ -37,7 +37,7 @@
  * logic this must match.
  */
 
-#define TTY_BUFFER_PAGE	(((PAGE_SIZE - sizeof(struct tty_buffer)) / 2) & ~0xFF)
+#define TTY_BUFFER_PAGE	(((PAGE_SIZE - sizeof(struct tty_buffer)) / 2) & ~TTYB_ALIGN_MASK)
 
 /**
  * tty_buffer_lock_exclusive	-	gain exclusive access to buffer
-- 
2.30.2

