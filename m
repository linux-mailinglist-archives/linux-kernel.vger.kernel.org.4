Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0C1F6A8619
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 17:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjCBQSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 11:18:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjCBQS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 11:18:29 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9B018A93
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 08:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677773908; x=1709309908;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cc/SCprntliIKJSK+Q8o0WMOD/lb0OEWb6pXJBqR1zY=;
  b=lJjcTvUZfvYN12NRpixHCDTgZFM7geWgAWQCcAl2GYmxQKTBHXqQYHH1
   sWjTf8KCb5xoEAducMQyQWge1Hpdfx78UOgyTROpSPtLBN9IyY3Y0Trrf
   sasXVnzvr6tl5RhJ63WiCQyi/7FqbT0N/g/hg7owW1IfmJd8ozQCK09/q
   TpmM7GDoiNf7wYupdfGTroUtrAaQW8lMOdsF7fHxqLW1ZqY9/2fHQeS79
   7MlyioG/pkOsnqmjzHORKOv3B41EC1B18sZujQFDmsoeyG5k4du0OwpQo
   0LNGU0+ZbaHK0ErqZFxiju/fyuvFRZBsp6qVQVf11l6ATNIJFrLKO3NGO
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="397351503"
X-IronPort-AV: E=Sophos;i="5.98,228,1673942400"; 
   d="scan'208";a="397351503"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 08:11:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="739137798"
X-IronPort-AV: E=Sophos;i="5.98,228,1673942400"; 
   d="scan'208";a="739137798"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 02 Mar 2023 08:11:26 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D8387143; Thu,  2 Mar 2023 18:12:08 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v1 1/1] =?UTF-8?q?i3c:=20Correct=20reference=20to=20the=20?= =?UTF-8?q?I=C2=B2C=20device=20data=20type?=
Date:   Thu,  2 Mar 2023 18:12:06 +0200
Message-Id: <20230302161206.38106-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I²C peripheral devices that are connected to the controller are
represented in the Linux kernel as objects of the struct i2c_client.
Fix this in the header file.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/i3c/master.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index 604a126b78c8..a12cda9dc715 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -22,9 +22,10 @@
 #define I3C_BROADCAST_ADDR		0x7e
 #define I3C_MAX_ADDR			GENMASK(6, 0)
 
+struct i2c_client;
+
 struct i3c_master_controller;
 struct i3c_bus;
-struct i2c_device;
 struct i3c_device;
 
 /**
-- 
2.39.1

