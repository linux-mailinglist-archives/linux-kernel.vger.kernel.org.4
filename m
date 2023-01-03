Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3D1165C23F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 15:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237847AbjACOuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 09:50:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233299AbjACOuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 09:50:02 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C6811A3B
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 06:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672757401; x=1704293401;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KZT3GLGea18xrh0159ZCMIKk1nB2l1hDsCRc+7jdyug=;
  b=XK9OaKiX+9jjWQ6PfuChEuYJpibPtf4v0x+rCUghSeRiuKTZ6jFjNiL1
   N51NpW3QAw6tcmaRztX9S50B4PyUIVCVerhcbpXA1e9rJ0UbzJFkX8wJ9
   x1YqLaGgcwBzywPTduaeKvJfMDxoG+mb7pqAYL/Vmjz1j0KsDePjSLBw4
   +aMIhjLlBqys9DrGHgsNg37yQClPZPKJJFyYrqN0TGxukBaDTUINR6PvQ
   SxokHRQDddh5UCTDH98LVXEHThiklbTQyCFrlNDy3yUVfcgk2UwhApwoY
   ryiz2K2q5S/eKwFV2xalzZZ8/9+yiybC3v6Fulw7isCVOsYeNlfYnC6yq
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="386109542"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="386109542"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 06:50:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="718116317"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="718116317"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 03 Jan 2023 06:49:58 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id BE306F4; Tue,  3 Jan 2023 16:50:30 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Tzung-Bi Shih <tzungbi@kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Benson Leung <bleung@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] platform/chrome: cros_ec_proto: Use asm intead of asm-generic
Date:   Tue,  3 Jan 2023 16:50:23 +0200
Message-Id: <20230103145023.40055-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
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

There is no point to specify asm-generic for the unaligned.h.
Drop the 'generic' suffix.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/chrome/cros_ec_proto_test.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_proto_test.c b/drivers/platform/chrome/cros_ec_proto_test.c
index c6a83df91ae1..08c58d031593 100644
--- a/drivers/platform/chrome/cros_ec_proto_test.c
+++ b/drivers/platform/chrome/cros_ec_proto_test.c
@@ -5,7 +5,8 @@
 
 #include <kunit/test.h>
 
-#include <asm-generic/unaligned.h>
+#include <asm/unaligned.h>
+
 #include <linux/platform_data/cros_ec_commands.h>
 #include <linux/platform_data/cros_ec_proto.h>
 
-- 
2.35.1

