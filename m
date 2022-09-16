Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2A95BAE82
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 15:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiIPNsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 09:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbiIPNsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 09:48:00 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30925AE229
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 06:47:57 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id o70-20020a17090a0a4c00b00202f898fa86so10931613pjo.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 06:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=9rPQR8P/1VtjE9ENgMce5rmv248XA42Ive8e266iH3M=;
        b=LfqafN7nozXhI9fIMip1UQHI87pGyqlTaZureB4Oal0otmj1VRG+d6UpCYiy+OMbHm
         TkDiWM7BCgEhK2BQK2VeWijvslBDAwhQGV+uqGetdO0ixgY5qvNslxcCYuG39TeaSb1S
         u05VmIv0/I8A07i9645mGvk0Yn1DvZjWH+n/qAA2tFRkvxmIqq24zhGYyKykZsCJDy/J
         cjkCf8Lsnd+uEgNi3UrtWEhng4kVMyOc+e30YLmhquuwMs3Xf7WEfbtOO8DuqgMDuRRT
         sbcRn3p/CQmU/ds+X/sy7S86jPde+1g4b+zsaJOihpspbsxJCngwRp9VoapotCvSCnOh
         AyUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=9rPQR8P/1VtjE9ENgMce5rmv248XA42Ive8e266iH3M=;
        b=4CiR8qihcIb09bymS5jontcVZxshYUH2iXMk6dwOfHDilgLq+AgH+rYedpaFDkmqw9
         ypg9TYWk75nseVBIJ9z9ax0XejJf8PhTv+2lxWsx+LUhG9bmwT//AxH0s0iq6Z5lUlRT
         P15iDkwqFxXjYB45CyoYf4/dGX/LYleotLM7PXj3vzkj6EXaUPPojeafgqT3qJlHqiwS
         2N8/bxx6kuY3XMvbeCYh7wO5EqROYf76q4zdW6nyk1HjNDRWmLX/5O0Zb0vxrwYhJAqu
         WFya7hq9BGtrESCmBminahiCeA2s50EhohvvgW2xlILzRumNf6iLjzuPTxyrN+AopSGt
         /EgQ==
X-Gm-Message-State: ACrzQf2CdL3yqnwo4YoaktxZy5SmMUF+uCYhGWr8BS/QOTSF3yaUblTD
        ETpZISZMGDDjgV0whaZUoaY=
X-Google-Smtp-Source: AMsMyM7cFFkZj80RfXPlM3hdsWDRwH9lmBGI4X5wgVqp/jJpbwQZAGXr81UM3Sj9Yjp2qoXXiSe3dA==
X-Received: by 2002:a17:902:d50e:b0:178:2fe:9f60 with SMTP id b14-20020a170902d50e00b0017802fe9f60mr4820928plg.154.1663336076622;
        Fri, 16 Sep 2022 06:47:56 -0700 (PDT)
Received: from ubuntu ([175.124.254.119])
        by smtp.gmail.com with ESMTPSA id b18-20020a170903229200b00176a6ba5969sm14967953plh.98.2022.09.16.06.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 06:47:56 -0700 (PDT)
Date:   Fri, 16 Sep 2022 06:47:51 -0700
From:   Hyunwoo Kim <imv4bel@gmail.com>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, imv4bel@gmail.com,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v3] char: pcmcia: synclink_cs: Fix use-after-free in
 mgslpc_ops
Message-ID: <20220916134751.GA234676@ubuntu>
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
 drivers/char/pcmcia/synclink_cs.c | 44 ++++++++++++++++++++++++++++---
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/drivers/char/pcmcia/synclink_cs.c b/drivers/char/pcmcia/synclink_cs.c
index 8fc49b038372..c991acfbc34d 100644
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
@@ -2517,9 +2548,14 @@ static int mgslpc_open(struct tty_struct *tty, struct file * filp)
 	if (debug_level >= DEBUG_LEVEL_INFO)
 		printk("%s(%d):mgslpc_open(%s) success\n",
 			 __FILE__, __LINE__, info->device_name);
+
+	kref_get(&info->refcnt);
 	retval = 0;
+	mutex_unlock(&remove_mutex);
 
+	return retval;
 cleanup:
+	mutex_unlock(&remove_mutex);
 	return retval;
 }
 
-- 
2.25.1

