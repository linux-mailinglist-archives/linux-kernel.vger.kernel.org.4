Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 197D6600DBE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 13:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiJQL2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 07:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbiJQL2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 07:28:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEA0631E0;
        Mon, 17 Oct 2022 04:28:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3B600B815E8;
        Mon, 17 Oct 2022 11:28:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32BB9C433D7;
        Mon, 17 Oct 2022 11:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666006083;
        bh=HvV5N2RmstkSA0mu3VCUSYUNzjEb/bQT9r3d68LFYfI=;
        h=From:To:Cc:Subject:Date:From;
        b=qwuH1S+M/qQOtfqYrwdDzVBcDzDUz8H9hCNAC4jXQy6dTqMS67Wg7yyMDP11PI7xS
         XS7AWgfvJZnOheVem1gxBwsPbyeuP0f90W+a1KqNcuCoYfl8YdWGrUbCjR4Adt2RkA
         0/jmk0ELm/g78lfBEeGJ3FGwAPsVuBlJFIOfkd/ehc+utyjxqraig5S08mhLH+MVpE
         mZzSCQlOcEdA2+AllSdZ8VVIxCY0h4PwVk2kv6PV4lA/KQgAbk16ND+r/k7WqLeoj+
         8fzNHG5tO6AB9guQbuIhwLjR063hxicz7TQ9BXWddoOLvQGpDSpQ05+AOL5Q6+OWLI
         BhTcFGC+KMRQA==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org
Cc:     linux-kernel@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Subject: [PATCH 1/1] usb: gadget: f_hid: Conduct proper refcounting on shared f_hidg pointer
Date:   Mon, 17 Oct 2022 12:27:37 +0100
Message-Id: <20221017112737.230772-1-lee@kernel.org>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A pointer to the main HID gadget struct (*f_hidg) is shared with the
character device handing (read() and write(), etc support) on open().
However external references are presently not tracked.  This could
easily lead to some unsavoury behaviour if gadget support is disabled
/ disconnected.  Keeping track of the refcount ensures that resources
are only freed *after* they are no longer in use.

Cc: Felipe Balbi <balbi@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/usb/gadget/function/f_hid.c | 37 +++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
index ca0a7d9eaa34e..79d4ee8a5647f 100644
--- a/drivers/usb/gadget/function/f_hid.c
+++ b/drivers/usb/gadget/function/f_hid.c
@@ -9,6 +9,7 @@
 #include <linux/module.h>
 #include <linux/hid.h>
 #include <linux/idr.h>
+#include <linux/kref.h>
 #include <linux/cdev.h>
 #include <linux/mutex.h>
 #include <linux/poll.h>
@@ -77,6 +78,8 @@ struct f_hidg {
 
 	struct usb_ep			*in_ep;
 	struct usb_ep			*out_ep;
+
+	struct kref			refcount;
 };
 
 static inline struct f_hidg *func_to_hidg(struct usb_function *f)
@@ -273,6 +276,19 @@ static struct usb_gadget_strings *ct_func_strings[] = {
 	NULL,
 };
 
+static void hidg_free_resources(struct kref *ref)
+{
+	struct f_hidg *hidg = container_of(ref, struct f_hidg, refcount);
+	struct f_hid_opts *opts = container_of(hidg->func.fi, struct f_hid_opts, func_inst);
+
+	mutex_lock(&opts->lock);
+	kfree(hidg->report_desc);
+	kfree(hidg->set_report_buf);
+	kfree(hidg);
+	--opts->refcnt;
+	mutex_unlock(&opts->lock);
+}
+
 /*-------------------------------------------------------------------------*/
 /*                              Char Device                                */
 
@@ -539,7 +555,13 @@ static __poll_t f_hidg_poll(struct file *file, poll_table *wait)
 
 static int f_hidg_release(struct inode *inode, struct file *fd)
 {
+	struct f_hidg *hidg =
+		container_of(inode->i_cdev, struct f_hidg, cdev);
+
 	fd->private_data = NULL;
+
+	kref_put(&hidg->refcount, hidg_free_resources);
+
 	return 0;
 }
 
@@ -548,6 +570,8 @@ static int f_hidg_open(struct inode *inode, struct file *fd)
 	struct f_hidg *hidg =
 		container_of(inode->i_cdev, struct f_hidg, cdev);
 
+	kref_get(&hidg->refcount);
+
 	fd->private_data = hidg;
 
 	return 0;
@@ -1239,17 +1263,9 @@ static struct usb_function_instance *hidg_alloc_inst(void)
 
 static void hidg_free(struct usb_function *f)
 {
-	struct f_hidg *hidg;
-	struct f_hid_opts *opts;
+	struct f_hidg *hidg = func_to_hidg(f);
 
-	hidg = func_to_hidg(f);
-	opts = container_of(f->fi, struct f_hid_opts, func_inst);
-	kfree(hidg->report_desc);
-	kfree(hidg->set_report_buf);
-	kfree(hidg);
-	mutex_lock(&opts->lock);
-	--opts->refcnt;
-	mutex_unlock(&opts->lock);
+	kref_put(&hidg->refcount, hidg_free_resources);
 }
 
 static void hidg_unbind(struct usb_configuration *c, struct usb_function *f)
@@ -1271,6 +1287,7 @@ static struct usb_function *hidg_alloc(struct usb_function_instance *fi)
 	hidg = kzalloc(sizeof(*hidg), GFP_KERNEL);
 	if (!hidg)
 		return ERR_PTR(-ENOMEM);
+	kref_init(&hidg->refcount);
 
 	opts = container_of(fi, struct f_hid_opts, func_inst);
 
-- 
2.38.0.413.g74048e4d9e-goog

