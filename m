Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C11B5E81F9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 20:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232860AbiIWSqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 14:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbiIWSqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 14:46:32 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9233120583;
        Fri, 23 Sep 2022 11:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663958791; x=1695494791;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D42fxf/LEPjQZXKiJb/KVJ5udjtoI05vUX7hP10VSl0=;
  b=lXHzOqzF2LLhSNr+fgBvz6bC9Bxshs+gX7SXtHTuWKIep+TXV/1zBXKM
   Q4GHCNf2Yrs2chkghhg106C1FwMn2FbQ/Am8t3N0IXPxPWCWpdmAisfBt
   pZlK1aDQPVdeCwcqbWllt0L7Yrp3i32JtN5hjX+8OuJPZM7zN9yVjb24+
   wC046QJdh3AgGMbfEaBNdRH7osqsdIAlm2/inV15MxaFioX7S1Simhh8q
   gM4c4/2NSHlyK6ees1drQpC7xBYJkOTBnClbiZuv8k4FvFP1ALy5w+yLj
   b/diHdv8LzxQEBjcgx532gydq+7A321MQPuiMAy8E4qsJf71HPITLpFBN
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10479"; a="302116091"
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="302116091"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 11:46:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="795607571"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 23 Sep 2022 11:46:18 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id BB58E86; Fri, 23 Sep 2022 21:46:36 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v1 2/2] Input: matrix_keypad - replace header inclusions by forward declarations
Date:   Fri, 23 Sep 2022 21:46:32 +0300
Message-Id: <20220923184632.2157-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220923184632.2157-1-andriy.shevchenko@linux.intel.com>
References: <20220923184632.2157-1-andriy.shevchenko@linux.intel.com>
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

When the data structure is only referred by pointer, compiler may not need
to see the contents of the data type. Thus, we may replace header inclusions
by respective forward declarations.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/input/matrix_keypad.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/input/matrix_keypad.h b/include/linux/input/matrix_keypad.h
index 9476768c3b90..b8d8d69eba29 100644
--- a/include/linux/input/matrix_keypad.h
+++ b/include/linux/input/matrix_keypad.h
@@ -3,8 +3,9 @@
 #define _MATRIX_KEYPAD_H
 
 #include <linux/types.h>
-#include <linux/input.h>
-#include <linux/of.h>
+
+struct device;
+struct input_dev;
 
 #define MATRIX_MAX_ROWS		32
 #define MATRIX_MAX_COLS		32
-- 
2.35.1

