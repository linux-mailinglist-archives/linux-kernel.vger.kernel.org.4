Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84BD622901
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 11:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbiKIKu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 05:50:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiKIKu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 05:50:56 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8133F1E9;
        Wed,  9 Nov 2022 02:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667991055; x=1699527055;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LWNcWECinfMb+fcqwO/G8pIM6Y4hWmoQNoCDj4j5org=;
  b=BWL0Td7VKFUcNfGwitgBM3dAnjrbkc1YqD9wraqd7/cBACrIx+DjBYmj
   dSEBNZe7GTw96PIoVXS4XY2nNDNowhn5t7uHJMpqtSKORTb3Dq71cuiID
   z0vkVzlWs0eYkYHZAn+eegC+/8a3mUGqYe+p1Xtm6U/ZOhGc1aKBF1ymy
   fbxgH2xSn7FwXH3BhkHWEKdkoC+6W2cQP5Dp+xUwoJTiCK4OPnVbz2ieO
   LqFiPHE0tGjmlIDBfSJSEJFk0tMqBU+u4SJNzeRkPOmeKU8rj4XM7bRAC
   L6tayQb+ta3DoGZ5r+OurGkC3rqr1gUzB6yFvIw/U5hamzscb2W8mkU94
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="397239950"
X-IronPort-AV: E=Sophos;i="5.96,150,1665471600"; 
   d="scan'208";a="397239950"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 02:50:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="779300606"
X-IronPort-AV: E=Sophos;i="5.96,150,1665471600"; 
   d="scan'208";a="779300606"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 09 Nov 2022 02:50:54 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 25BBDF7; Wed,  9 Nov 2022 12:51:18 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org
Subject: [PATCH v1 2/2] resource: Convert DEFINE_RES_NAMED() to be compound literal
Date:   Wed,  9 Nov 2022 12:51:14 +0200
Message-Id: <20221109105114.32886-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221109105114.32886-1-andriy.shevchenko@linux.intel.com>
References: <20221109105114.32886-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently DEFINE_RES_NAMED() can only be used to fill the static data.
In some cases it would be convenient to use it as right value in the
assignment operation. But it can't be done as is, because compiler has
no clue about the data layout. Converting it to be a compound literal
allows the above mentioned usage.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/ioport.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 27642ca15d93..67d3fb2133b6 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -155,7 +155,7 @@ enum {
 
 /* helpers to define resources */
 #define DEFINE_RES_NAMED(_start, _size, _name, _flags)			\
-	{								\
+(struct resource) {							\
 		.start = (_start),					\
 		.end = (_start) + (_size) - 1,				\
 		.name = (_name),					\
-- 
2.35.1

