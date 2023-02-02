Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3080D688240
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 16:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232891AbjBBP3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 10:29:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232960AbjBBP3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 10:29:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC99774C06;
        Thu,  2 Feb 2023 07:28:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 61792B82686;
        Thu,  2 Feb 2023 15:28:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6307C433D2;
        Thu,  2 Feb 2023 15:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675351709;
        bh=QXbJp24qmcK6lYcyTK8wss5IGk1Z25hZs1W+6i2bJrs=;
        h=From:To:Cc:Subject:Date:From;
        b=Vh8tHZ/1MOHOK3y4pQ1qo16OoIzhMj8LZX66eDgcBpB9UbDYyNzN0KIwFqB/s6noG
         M7xCxhwdc/oakHlLWfcEs31BkH+d9lgUhwe4s9dcrDqae4pAOhIwJaAvac/66Jkuxn
         V0hdvnpQ4SxJhqegY/M+GlmoNRhzlOpZc9fXAaH0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-usb@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bruce Chen <bruce.chen@unisoc.com>,
        Cixi Geng <cixi.geng1@unisoc.com>,
        Cixi Geng <gengcixi@gmail.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] USB: dwc3: fix memory leak with using debugfs_lookup()
Date:   Thu,  2 Feb 2023 16:28:20 +0100
Message-Id: <20230202152820.2409908-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4944; i=gregkh@linuxfoundation.org; h=from:subject; bh=QXbJp24qmcK6lYcyTK8wss5IGk1Z25hZs1W+6i2bJrs=; b=owGbwMvMwCRo6H6F97bub03G02pJDMm3r02afWf7kzMpmU9+b/u/+CNTdTDzXfuyfbFuH+2CZsdo iSikdcSyMAgyMciKKbJ82cZzdH/FIUUvQ9vTMHNYmUCGMHBxCsBE5JsYZjFdE5zmmng82CD/dqe8Pt e/OaH6IQwLOoSrlHqSTYq0WtPCCz8dWXTs8pxpAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling debugfs_lookup() the result must have dput() called on it,
otherwise the memory will leak over time.  To make things simpler, just
call debugfs_lookup_and_remove() instead which handles all of the logic
at once.

Note, the root dentry for the debugfs directory for the device needs to
be saved so we don't have to keep looking it up, which required a bit
more refactoring to properly create and remove it when needed.

Reported-by: Bruce Chen <bruce.chen@unisoc.com>
Reported-by: Cixi Geng <cixi.geng1@unisoc.com>
Tested-by: Cixi Geng <gengcixi@gmail.com>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/dwc3/core.h    |  2 ++
 drivers/usb/dwc3/debug.h   |  3 +++
 drivers/usb/dwc3/debugfs.c | 19 ++++++++-----------
 drivers/usb/dwc3/gadget.c  |  4 +---
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 8f9959ba9fd4..582ebd9cf9c2 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1117,6 +1117,7 @@ struct dwc3_scratchpad_array {
  *		     address.
  * @num_ep_resized: carries the current number endpoints which have had its tx
  *		    fifo resized.
+ * @debug_root: root debugfs directory for this device to put its files in.
  */
 struct dwc3 {
 	struct work_struct	drd_work;
@@ -1332,6 +1333,7 @@ struct dwc3 {
 	int			max_cfg_eps;
 	int			last_fifo_depth;
 	int			num_ep_resized;
+	struct dentry		*debug_root;
 };
 
 #define INCRX_BURST_MODE 0
diff --git a/drivers/usb/dwc3/debug.h b/drivers/usb/dwc3/debug.h
index 48b44b88dc25..8bb2c9e3b9ac 100644
--- a/drivers/usb/dwc3/debug.h
+++ b/drivers/usb/dwc3/debug.h
@@ -414,11 +414,14 @@ static inline const char *dwc3_gadget_generic_cmd_status_string(int status)
 
 #ifdef CONFIG_DEBUG_FS
 extern void dwc3_debugfs_create_endpoint_dir(struct dwc3_ep *dep);
+extern void dwc3_debugfs_remove_endpoint_dir(struct dwc3_ep *dep);
 extern void dwc3_debugfs_init(struct dwc3 *d);
 extern void dwc3_debugfs_exit(struct dwc3 *d);
 #else
 static inline void dwc3_debugfs_create_endpoint_dir(struct dwc3_ep *dep)
 {  }
+static inline void dwc3_debugfs_remove_endpoint_dir(struct dwc3_ep *dep)
+{  }
 static inline void dwc3_debugfs_init(struct dwc3 *d)
 {  }
 static inline void dwc3_debugfs_exit(struct dwc3 *d)
diff --git a/drivers/usb/dwc3/debugfs.c b/drivers/usb/dwc3/debugfs.c
index f2b7675c7f62..850df0e6bcab 100644
--- a/drivers/usb/dwc3/debugfs.c
+++ b/drivers/usb/dwc3/debugfs.c
@@ -873,27 +873,23 @@ static const struct dwc3_ep_file_map dwc3_ep_file_map[] = {
 	{ "GDBGEPINFO", &dwc3_ep_info_register_fops, },
 };
 
-static void dwc3_debugfs_create_endpoint_files(struct dwc3_ep *dep,
-		struct dentry *parent)
+void dwc3_debugfs_create_endpoint_dir(struct dwc3_ep *dep)
 {
+	struct dentry		*dir;
 	int			i;
 
+	dir = debugfs_create_dir(dep->name, dep->dwc->debug_root);
 	for (i = 0; i < ARRAY_SIZE(dwc3_ep_file_map); i++) {
 		const struct file_operations *fops = dwc3_ep_file_map[i].fops;
 		const char *name = dwc3_ep_file_map[i].name;
 
-		debugfs_create_file(name, 0444, parent, dep, fops);
+		debugfs_create_file(name, 0444, dir, dep, fops);
 	}
 }
 
-void dwc3_debugfs_create_endpoint_dir(struct dwc3_ep *dep)
+void dwc3_debugfs_remove_endpoint_dir(struct dwc3_ep *dep)
 {
-	struct dentry		*dir;
-	struct dentry		*root;
-
-	root = debugfs_lookup(dev_name(dep->dwc->dev), usb_debug_root);
-	dir = debugfs_create_dir(dep->name, root);
-	dwc3_debugfs_create_endpoint_files(dep, dir);
+	debugfs_lookup_and_remove(dep->name, dep->dwc->debug_root);
 }
 
 void dwc3_debugfs_init(struct dwc3 *dwc)
@@ -911,6 +907,7 @@ void dwc3_debugfs_init(struct dwc3 *dwc)
 	dwc->regset->base = dwc->regs - DWC3_GLOBALS_REGS_START;
 
 	root = debugfs_create_dir(dev_name(dwc->dev), usb_debug_root);
+	dwc->debug_root = root;
 	debugfs_create_regset32("regdump", 0444, root, dwc->regset);
 	debugfs_create_file("lsp_dump", 0644, root, dwc, &dwc3_lsp_fops);
 
@@ -929,6 +926,6 @@ void dwc3_debugfs_init(struct dwc3 *dwc)
 
 void dwc3_debugfs_exit(struct dwc3 *dwc)
 {
-	debugfs_remove(debugfs_lookup(dev_name(dwc->dev), usb_debug_root));
+	debugfs_lookup_and_remove(dev_name(dwc->dev), usb_debug_root);
 	kfree(dwc->regset);
 }
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 89dcfac01235..3c63fa97a680 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -3194,9 +3194,7 @@ static void dwc3_gadget_free_endpoints(struct dwc3 *dwc)
 			list_del(&dep->endpoint.ep_list);
 		}
 
-		debugfs_remove_recursive(debugfs_lookup(dep->name,
-				debugfs_lookup(dev_name(dep->dwc->dev),
-					       usb_debug_root)));
+		dwc3_debugfs_remove_endpoint_dir(dep);
 		kfree(dep);
 	}
 }
-- 
2.39.1

