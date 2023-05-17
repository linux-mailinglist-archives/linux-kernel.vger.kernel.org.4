Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3615C7068B2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 14:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbjEQMzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 08:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbjEQMzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 08:55:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5921C2D68;
        Wed, 17 May 2023 05:55:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E185D6449E;
        Wed, 17 May 2023 12:55:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C1ABC433EF;
        Wed, 17 May 2023 12:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684328138;
        bh=xzTFDNsRybxFIhfNkT5pB/3ffJE+aIzn77Ij9JsNwhQ=;
        h=From:To:Cc:Subject:Date:From;
        b=rEDgMEQLFO1dHrTu7bk05PSagPHSLbTz1soCR9EqbVytR1qDw1CdCDpr1gTBIArLp
         4Cw0/Ce9LHK5C0X9w9BavIkXm8rDgBeduEKjGPPyZ9FVgRUWbbSd0T1RKcpDwx8Rqg
         f75QcnNaqJn2rS+98JjDV2RveeLeB3EF8HAaLFhGPhBMJdwoI3QNA6/8xCuFjJJAk4
         Ib+SHm+mYwlO33nBBfFnkCYn8wbzMirsE4hPYInVtidxX7Zx4tj1ZPPZqO94cpzHs8
         pQYzRbnQMwJ4d5zNG9wnmNYRy7fFZ47xzC/cc3ZKSlwxzdHUZLCNgHHeZfDL6dE8KF
         wNPaEFdrVTzvw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Jane Chu <jane.chu@oracle.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Gregory Price <gregory.price@memverge.com>,
        nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dax: fix missing-prototype warnings
Date:   Wed, 17 May 2023 14:55:09 +0200
Message-Id: <20230517125532.931157-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

dev_dax_probe declaration for this function was removed with the only
caller outside of device.c. Mark it static to avoid a W=1
warning:
drivers/dax/device.c:399:5: error: no previous prototype for 'dev_dax_probe'

Similarly, run_dax() causes a warning, but this one is because the
declaration needs to be included:

drivers/dax/super.c:337:6: error: no previous prototype for 'run_dax'

Fixes: 83762cb5c7c4 ("dax: Kill DEV_DAX_PMEM_COMPAT")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/dax/device.c | 3 +--
 drivers/dax/super.c  | 1 +
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index af9930c03c9c..30665a3ff6ea 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -396,7 +396,7 @@ static void dev_dax_kill(void *dev_dax)
 	kill_dev_dax(dev_dax);
 }
 
-int dev_dax_probe(struct dev_dax *dev_dax)
+static int dev_dax_probe(struct dev_dax *dev_dax)
 {
 	struct dax_device *dax_dev = dev_dax->dax_dev;
 	struct device *dev = &dev_dax->dev;
@@ -471,7 +471,6 @@ int dev_dax_probe(struct dev_dax *dev_dax)
 	run_dax(dax_dev);
 	return devm_add_action_or_reset(dev, dev_dax_kill, dev_dax);
 }
-EXPORT_SYMBOL_GPL(dev_dax_probe);
 
 static struct dax_device_driver device_dax_driver = {
 	.probe = dev_dax_probe,
diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index c4c4728a36e4..8c05dae19bfe 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -14,6 +14,7 @@
 #include <linux/dax.h>
 #include <linux/fs.h>
 #include "dax-private.h"
+#include "bus.h"
 
 /**
  * struct dax_device - anchor object for dax services
-- 
2.39.2

