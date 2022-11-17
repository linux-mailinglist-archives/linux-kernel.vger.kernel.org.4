Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5BB62DA43
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 13:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240146AbiKQMIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 07:08:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240137AbiKQMIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 07:08:45 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44BA331FB3;
        Thu, 17 Nov 2022 04:08:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DE6DDCE1D56;
        Thu, 17 Nov 2022 12:08:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3620C433D6;
        Thu, 17 Nov 2022 12:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668686917;
        bh=VGOY6CblI4x26pv4UpLJydIi/WK5ykAHqmG7x20RJnA=;
        h=From:To:Cc:Subject:Date:From;
        b=WSjGOM+trYZ/ytaSmAKqHRYxgzrz7ZJFduZdq+emlbiYqDbPmkV47wYHt99sPo25j
         Oui17QJrSjmWfp+VeWOz5pFWSYbRMKY/VkzJkpVYQfz3egkhmneZUigOO0KZjX1Mlx
         DSLe973bEgB15yKYA0CleBRQOU7hOc2SM1W9JZ1/+vNRhR9aCJKG2QHn+DrgP8UH3c
         UsGNdwq0HRdQLQ+D9T4bE1A2hJVt6H+R2l5FlpPlrebe0I73tTIP5ugn+U3slzNtw2
         CfI2jB/6e0k+U7CcVrpIgVw0AI+9R9fYC0pS/NERqAiWEK/dSuYA2Pl6wi5gaF8F9a
         n2dbfpUjy625Q==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org, balbi@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH 1/1] usb: gadget: f_hid: Conduct proper refcounting on shared f_hidg pointer
Date:   Thu, 17 Nov 2022 12:08:13 +0000
Message-Id: <20221117120813.1257583-1-lee@kernel.org>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A reference to struct f_hidg is shared with this driver's associated
character device handling component without provision for life-time
handling.  In some circumstances, this can lead to unwanted
behaviour depending on the order in which things are torn down.

Utilise, the reference counting functionality already provided by the
implanted character device structure to ensure the struct f_hidg's
memory is only freed once the character device handling has finished
with it.

Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/usb/gadget/function/f_hid.c | 47 +++++++++++++++++++++++------
 1 file changed, 37 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
index ca0a7d9eaa34e..5da8f44d47d9d 100644
--- a/drivers/usb/gadget/function/f_hid.c
+++ b/drivers/usb/gadget/function/f_hid.c
@@ -77,6 +77,8 @@ struct f_hidg {
 
 	struct usb_ep			*in_ep;
 	struct usb_ep			*out_ep;
+
+	bool				gc;
 };
 
 static inline struct f_hidg *func_to_hidg(struct usb_function *f)
@@ -84,6 +86,11 @@ static inline struct f_hidg *func_to_hidg(struct usb_function *f)
 	return container_of(f, struct f_hidg, func);
 }
 
+static inline bool f_hidg_is_open(struct f_hidg *hidg)
+{
+	return !!kref_read(&hidg->cdev.kobj.kref);
+}
+
 /*-------------------------------------------------------------------------*/
 /*                           Static descriptors                            */
 
@@ -273,6 +280,18 @@ static struct usb_gadget_strings *ct_func_strings[] = {
 	NULL,
 };
 
+static void hidg_free_resources(struct f_hidg *hidg)
+{
+       struct f_hid_opts *opts = container_of(hidg->func.fi, struct f_hid_opts, func_inst);
+
+       mutex_lock(&opts->lock);
+       kfree(hidg->report_desc);
+       kfree(hidg->set_report_buf);
+       kfree(hidg);
+       --opts->refcnt;
+       mutex_unlock(&opts->lock);
+}
+
 /*-------------------------------------------------------------------------*/
 /*                              Char Device                                */
 
@@ -539,7 +558,16 @@ static __poll_t f_hidg_poll(struct file *file, poll_table *wait)
 
 static int f_hidg_release(struct inode *inode, struct file *fd)
 {
+	struct f_hidg *hidg  = fd->private_data;
+
+	if (hidg->gc) {
+		/* Gadget has already been disconnected and we are the last f_hidg user */
+		cdev_del(&hidg->cdev);
+		hidg_free_resources(hidg);
+	}
+
 	fd->private_data = NULL;
+
 	return 0;
 }
 
@@ -1239,17 +1267,16 @@ static struct usb_function_instance *hidg_alloc_inst(void)
 
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
+	if (f_hidg_is_open(hidg))
+		/*
+		 * Gadget disconnected whilst an open dev node exists.
+		 * Delay freeing resources until it closes.
+		 */
+		hidg->gc = true;
+	else
+		hidg_free_resources(hidg);
 }
 
 static void hidg_unbind(struct usb_configuration *c, struct usb_function *f)
-- 
2.38.1.431.g37b22c650d-goog

