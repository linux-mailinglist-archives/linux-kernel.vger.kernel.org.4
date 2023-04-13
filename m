Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEAC16E03B9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 03:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjDMBce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 21:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjDMBcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 21:32:32 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B201712;
        Wed, 12 Apr 2023 18:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681349552; x=1712885552;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ILsidFKzCVxsGAABpc4qrhew3cGTXES9pdfYjscYrKQ=;
  b=QVjHoXWe9fVteOLuw+raqM5FSKu7/+ufAy48/GlvnDCKeCWNj3BVcfl+
   ui9vSAEpHWzuLbmtoyICdgV6clhH5GP3AmRAB1yLAVhSQaeBAQaunwJgW
   37lf0o84RMcwUwqT9dgsxwjrQOnL/LJzAuiaDfbmYXlY3kJnIVrNFzfy8
   x8mS2Oh+CzFnIU0Cxp822+83AjNwZo5s8yzb9U1+UpKwHoOTNp2VuaFwL
   bQe/O7PoBDMihRMLOizaL25EHCPUKgkmzxUiTiNFVvrZDNXx61qrninNR
   BgLjQ+E8FQTz8MrBmEWcHL69I1c297qaeMY5R/f+FKv5iAeL8tilRFl0K
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="346744380"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="346744380"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 18:32:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="800575177"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="800575177"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 12 Apr 2023 18:32:31 -0700
Received: from debox1-desk4.intel.com (unknown [10.251.6.61])
        by linux.intel.com (Postfix) with ESMTP id 02F71580AFF;
        Wed, 12 Apr 2023 18:32:30 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     david.e.box@linux.intel.com, hdegoede@redhat.com,
        markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86/intel/sdsi: Change mailbox timeout
Date:   Wed, 12 Apr 2023 18:32:30 -0700
Message-Id: <20230413013230.1521584-1-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some platforms, it may take up to 400ms for the ready bit to be set in a
successful mailbox transaction. Set the timeout to 500ms to cover the worst
case.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/platform/x86/intel/sdsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/sdsi.c b/drivers/platform/x86/intel/sdsi.c
index 9e0ea2cdd704..556e7c6dbb05 100644
--- a/drivers/platform/x86/intel/sdsi.c
+++ b/drivers/platform/x86/intel/sdsi.c
@@ -49,7 +49,7 @@
 #define SDSI_MBOX_CMD_SUCCESS		0x40
 #define SDSI_MBOX_CMD_TIMEOUT		0x80
 
-#define MBOX_TIMEOUT_US			2000
+#define MBOX_TIMEOUT_US			500000
 #define MBOX_TIMEOUT_ACQUIRE_US		1000
 #define MBOX_POLLING_PERIOD_US		100
 #define MBOX_ACQUIRE_NUM_RETRIES	5

base-commit: 5b309e80f457ebb41770e0122766825a78cfc11b
-- 
2.34.1

