Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C287F5BAF00
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 16:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbiIPOMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 10:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbiIPOL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 10:11:58 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFDBBB07E8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 07:11:57 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id y127so21370215pfy.5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 07:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=gNzYPf46uur5QNrJ/NP5ZuN52uuLDS2suD9n8cLkosA=;
        b=Hup/4PPX75nSAKh6vVEW5pA9Olj2PHQAdZtmVtstwoCOaSqowyhEi7URIpYJbrga2s
         efLTq/Gzt2Sn0Djw5RO3ljRI29sYt7MVTrSZKdiI3coC5U6cv2aWG/EoemjkqO/tZKXd
         mWdk1T277ctZ0ex0YPgX9mAoOYm8/20cDDM1sUetxABqn4SF/gtcz7JdvAlmoPUf0/6r
         iJE9nu9nBdknFJr6vrZYVvIjNE4DtPn9ksn7QfoeeABc5bBhu0xMloQcYn47W5RmbYwA
         MbZlVqinC8n1kQvqkwgZ38n8ztIrte5IrSnFkoiVOCvGcLHibzOjURp55ac2EHeNX26/
         20Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=gNzYPf46uur5QNrJ/NP5ZuN52uuLDS2suD9n8cLkosA=;
        b=nEiFTOacC0FotzaYxDQ6JMhTVBbpStDlLbVvVYq0qr/F/Jpe8snIGHLgvYxBkI7wOg
         BDsHx21g+QDj2LG+O55LzGrK35ljFBmBFVJL/Hswoc+IYBHvBSOjJvHwvfFnqsJ+TfRB
         0cyO3OJ8airZEYW5INQ/f8iIg2APH3UoOxoRN93I2wnYqUt64vC6VAE70wzgsssrt+/W
         hbfA5rUi+iG6/mWos33Dw+iejUBgxbu+64lmaVMeOantdNEpqDb86mwXFePzNWkOgS7Y
         5DWzJm0ZejU9LvXGqCXzhOum+KAPzml/fNIM8iJfFO1AzJQF1BDUVX/UJzJ+X5nWKg7u
         tiBg==
X-Gm-Message-State: ACrzQf2bH0Fy28TsHNRPPANtuiRn/oQTGvmJKploVvqAD1a/YtNHu1ME
        cVzRCIIL6zAuPmf46LxHLFo=
X-Google-Smtp-Source: AMsMyM7dLrzDqFQK3yHt/vWgHBceSuluw15C5oqECT6y9WldG0gx6I4vN5N8POVltPsauM6/49C1dA==
X-Received: by 2002:a63:cf56:0:b0:439:41ed:78fc with SMTP id b22-20020a63cf56000000b0043941ed78fcmr4869061pgj.419.1663337517335;
        Fri, 16 Sep 2022 07:11:57 -0700 (PDT)
Received: from ubuntu ([175.124.254.119])
        by smtp.gmail.com with ESMTPSA id k12-20020a65434c000000b00438e0db80dasm11018180pgq.65.2022.09.16.07.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 07:11:56 -0700 (PDT)
Date:   Fri, 16 Sep 2022 07:11:52 -0700
From:   Hyunwoo Kim <imv4bel@gmail.com>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, imv4bel@gmail.com,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v4] char: pcmcia: synclink_cs: Fix use-after-free in
 mgslpc_ops
Message-ID: <20220916141152.GA236495@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A race condition may occur if the user physically removes
the pcmcia device while calling ioctl() for this tty device node.

This is a race condition between the mgslpc_ioctl() function and
the mgslpc_detach() function, which may eventually result in UAF.

So, add a refcount check to mgslpc_detach() to free the structure
after the tty device node is close()d.

Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 drivers/char/pcmcia/synclink_cs.c | 43 +++++++++++++++++++++++++++----
 1 file changed, 38 insertions(+), 5 deletions(-)

diff --git a/drivers/char/pcmcia/synclink_cs.c b/drivers/char/pcmcia/synclink_cs.c
index 8fc49b038372..f0e4ec3821ac 100644
--- a/drivers/char/pcmcia/synclink_cs.c
+++ b/drivers/char/pcmcia/synclink_cs.c
@@ -216,7 +216,9 @@ typedef struct _mgslpc_info {
 
 	/* PCMCIA support */
 	struct pcmcia_device	*p_dev;
-	int		      stop;
+	int			stop;
+	int			removed;
+	struct kref		refcnt;
 
 	/* SPPP/Cisco HDLC device parts */
 	int netcount;
@@ -228,6 +230,8 @@ typedef struct _mgslpc_info {
 
 } MGSLPC_INFO;
 
+static DEFINE_MUTEX(remove_mutex);
+
 #define MGSLPC_MAGIC 0x5402
 
 /*
@@ -468,10 +472,21 @@ static void mgslpc_wait_until_sent(struct tty_struct *tty, int timeout);
 
 /* PCMCIA prototypes */
 
+static void mgslpc_delete(struct kref *kref);
 static int mgslpc_config(struct pcmcia_device *link);
 static void mgslpc_release(u_long arg);
 static void mgslpc_detach(struct pcmcia_device *p_dev);
 
+static void mgslpc_delete(struct kref *kref)
+{
+	MGSLPC_INFO *info = container_of(kref, MGSLPC_INFO, refcnt);
+	struct pcmcia_device *link = info->p_dev;
+
+	mgslpc_release((u_long)link);
+
+	mgslpc_remove_device(info);
+}
+
 /*
  * 1st function defined in .text section. Calling this function in
  * init_module() followed by a breakpoint allows a remote debugger
@@ -534,6 +549,7 @@ static int mgslpc_probe(struct pcmcia_device *link)
 	init_waitqueue_head(&info->event_wait_q);
 	spin_lock_init(&info->lock);
 	spin_lock_init(&info->netlock);
+	kref_init(&info->refcnt);
 	memcpy(&info->params,&default_params,sizeof(MGSL_PARAMS));
 	info->idle_mode = HDLC_TXIDLE_FLAGS;
 	info->imra_value = 0xffff;
@@ -620,13 +636,17 @@ static void mgslpc_release(u_long arg)
 
 static void mgslpc_detach(struct pcmcia_device *link)
 {
+	MGSLPC_INFO *info = link->priv;
+
+	mutex_lock(&remove_mutex);
 	if (debug_level >= DEBUG_LEVEL_INFO)
 		printk("mgslpc_detach(0x%p)\n", link);
 
-	((MGSLPC_INFO *)link->priv)->stop = 1;
-	mgslpc_release((u_long)link);
+	info->stop = 1;
 
-	mgslpc_remove_device((MGSLPC_INFO *)link->priv);
+	kref_put(&info->refcnt, mgslpc_delete);
+	info->removed = 1;
+	mutex_unlock(&remove_mutex);
 }
 
 static int mgslpc_suspend(struct pcmcia_device *link)
@@ -2341,10 +2361,13 @@ static void mgslpc_close(struct tty_struct *tty, struct file * filp)
 	
 	tty_port_close_end(port, tty);
 	tty_port_tty_set(port, NULL);
+
 cleanup:
 	if (debug_level >= DEBUG_LEVEL_INFO)
 		printk("%s(%d):mgslpc_close(%s) exit, count=%d\n", __FILE__, __LINE__,
 			tty->driver->name, port->count);
+
+	kref_put(&info->refcnt, mgslpc_delete);
 }
 
 /* Wait until the transmitter is empty.
@@ -2465,6 +2488,7 @@ static int mgslpc_open(struct tty_struct *tty, struct file * filp)
 	int		retval, line;
 	unsigned long	flags;
 
+
 	/* verify range of specified line number */
 	line = tty->index;
 	if (line >= mgslpc_device_count) {
@@ -2480,6 +2504,13 @@ static int mgslpc_open(struct tty_struct *tty, struct file * filp)
 	if (mgslpc_paranoia_check(info, tty->name, "mgslpc_open"))
 		return -ENODEV;
 
+	mutex_lock(&remove_mutex);
+
+	if (info->removed == 1) {
+		retval = -ENODEV;
+		goto cleanup;
+	}
+
 	port = &info->port;
 	tty->driver_data = info;
 	tty_port_tty_set(port, tty);
@@ -2517,9 +2548,11 @@ static int mgslpc_open(struct tty_struct *tty, struct file * filp)
 	if (debug_level >= DEBUG_LEVEL_INFO)
 		printk("%s(%d):mgslpc_open(%s) success\n",
 			 __FILE__, __LINE__, info->device_name);
-	retval = 0;
 
+	kref_get(&info->refcnt);
+	retval = 0;
 cleanup:
+	mutex_unlock(&remove_mutex);
 	return retval;
 }
 
-- 
2.25.1

