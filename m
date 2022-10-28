Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C093F610CD6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 11:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbiJ1JNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 05:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiJ1JNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 05:13:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E1277541;
        Fri, 28 Oct 2022 02:13:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4E10BB8286D;
        Fri, 28 Oct 2022 09:13:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CF18C433C1;
        Fri, 28 Oct 2022 09:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666948398;
        bh=iYXZY4WsmuaHa1Ddq+Oh8cvkVFxpiuUetxLnBj6TjxI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jvhQLH+KDCqjW2so/K+XAaMCuQckB7EAlWrKywKoiXwLg5L2KXRaSV/z5UNG3sACO
         4fMVJ6y/+rDUr6CHwEbAD5BJx+PBX8i5v+MgyWlx2CtDMXgCI+iE541wIIRVP32Fon
         1SfjwVl88s+bEEQc4ozS50whc9OhL3P4r2lJdFuQ=
Date:   Fri, 28 Oct 2022 11:13:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Cixi Geng <gengcixi@gmail.com>
Cc:     Thinh.Nguyen@synopsys.com, bruce.chen@unisoc.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: dwc3: Fix dentry leak in dwc3_gadget_free_endpoints
Message-ID: <Y1udKz/0UpVJb++p@kroah.com>
References: <20221028084919.21654-1-gengcixi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221028084919.21654-1-gengcixi@gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 04:49:19PM +0800, Cixi Geng wrote:
> From: Bruce Chen <bruce.chen@unisoc.com>
> 
> When using debugfs_remove_recursive leaks a dentry with
> a hotplug stress test, the phone runs out of memory.
> 
> Thus fix the issue by using the newly created debugfs_lookup_and_remove().
> 
> Signed-off-by: Bruce Chen <bruce.chen@unisoc.com>
> Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
> ---
>  drivers/usb/dwc3/core.h    | 1 +
>  drivers/usb/dwc3/debugfs.c | 3 ++-
>  drivers/usb/dwc3/gadget.c  | 4 +---
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> index 8f9959ba9fd4..ba3ecaa7f06c 100644
> --- a/drivers/usb/dwc3/core.h
> +++ b/drivers/usb/dwc3/core.h
> @@ -1261,6 +1261,7 @@ struct dwc3 {
>  	u8			num_eps;
>  
>  	struct dwc3_hwparams	hwparams;
> +	struct dentry		*root;

You forgot to document this new variable.

And name it a bit better?

>  	struct debugfs_regset32	*regset;
>  
>  	u32			dbg_lsp_select;
> diff --git a/drivers/usb/dwc3/debugfs.c b/drivers/usb/dwc3/debugfs.c
> index f2b7675c7f62..b9af4a81f51d 100644
> --- a/drivers/usb/dwc3/debugfs.c
> +++ b/drivers/usb/dwc3/debugfs.c
> @@ -911,6 +911,7 @@ void dwc3_debugfs_init(struct dwc3 *dwc)
>  	dwc->regset->base = dwc->regs - DWC3_GLOBALS_REGS_START;
>  
>  	root = debugfs_create_dir(dev_name(dwc->dev), usb_debug_root);
> +	dwc->root = root;
>  	debugfs_create_regset32("regdump", 0444, root, dwc->regset);
>  	debugfs_create_file("lsp_dump", 0644, root, dwc, &dwc3_lsp_fops);
>  
> @@ -929,6 +930,6 @@ void dwc3_debugfs_init(struct dwc3 *dwc)
>  
>  void dwc3_debugfs_exit(struct dwc3 *dwc)
>  {
> -	debugfs_remove(debugfs_lookup(dev_name(dwc->dev), usb_debug_root));
> +	debugfs_remove(dwc->root);
>  	kfree(dwc->regset);
>  }
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index 079cd333632e..6d6c188fcbea 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -3172,9 +3172,7 @@ static void dwc3_gadget_free_endpoints(struct dwc3 *dwc)
>  			list_del(&dep->endpoint.ep_list);
>  		}
>  
> -		debugfs_remove_recursive(debugfs_lookup(dep->name,
> -				debugfs_lookup(dev_name(dep->dwc->dev),
> -					       usb_debug_root)));
> +		debugfs_lookup_and_remove(dep->name, dwc->root);
>  		kfree(dep);
>  	}
>  }
> -- 
> 2.34.1
> 

I don't think this is the full fix.

Below is a patch that I've had in a tree that I need to push out (along
with the other 33 debugfs_lookup patches) that should resolve this for
this driver in a more complete way.

Can you try this version instead?

thanks,

greg k-h

---------------------


From 49b893792579af1bea46c5004759cb35475c4fca Mon Sep 17 00:00:00 2001
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Fri, 2 Sep 2022 16:41:39 +0200
Subject: [PATCH 06/34] USB: dwc3: debugfs_lookup() fix

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
index 079cd333632e..404bb7ee61a8 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -3172,9 +3172,7 @@ static void dwc3_gadget_free_endpoints(struct dwc3 *dwc)
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
2.38.1

