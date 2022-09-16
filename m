Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF9215BA623
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 06:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiIPE5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 00:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiIPE5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 00:57:42 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6278777550
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 21:57:40 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id u132so20122044pfc.6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 21:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=5Aol/gk9VBVMsyT7ww7GCLNu8j3tphSoFBR2VKxvXKg=;
        b=E9LWdr9SF5/4k4guq0EbKQ/2BEcNBP/0RhIDR9j8AQvCV65zKaH1tBqrjfVkaNx/3M
         edQ5xwFCCuQcNzEBcefOZ1vo8HZjG79reCvb/XzUET5mv2PEhayMUIvTvyExhEFbRkJj
         gzzWIxAetZIwZF3BU5v+A5uqLvGOOpJydhbl0fGwFMEXR5KqAqYYYkWFBWgV3+gBvYjF
         PyyxFr/WmtrFcPxYBBJ02rAo4/HoC6TEh/CVfhmGaIN9NVDxI6oO+rbdQ6QgqaGdTGFp
         ZPfsLflzNbl8HFkDV8XHe5HE7BS19e8npfyy1OGsfMkGARLThYi+QoT2dwW0LOR3a4+p
         86kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=5Aol/gk9VBVMsyT7ww7GCLNu8j3tphSoFBR2VKxvXKg=;
        b=m9OoCIP1+KJ9AojIbCKQHbYRnLDtqWBTxKt77gmJXlWXteb5gz3l8IqN0wFl07LqMI
         iNgHnP2uu0DPtRssXgy/W4JCRY7aWaGf0AAwCDiWLTZ7JFcGOsiz+r46RBXVR/+Cldmu
         C6ci+ThN8oPYLP6wDu1Gu71mUWKpJQP3qSnGP749+di3b6pPT7KAstO8K1YwGi/CSZLy
         aeIqHN1JVXJEWNeZGkxCaVn/NZViGtYZ1hsV5LC+1IaT/W/BIcSh54OYZ9Olt11K/9Ts
         +zqW5TfgoOThw5NZQSU+3/6KdVSmu59xM009mD4++/VKttqHc/e8hChHHk2tSGRopH0p
         KZcA==
X-Gm-Message-State: ACrzQf1LvZdURfZT28/FrrI2ZvFq3AoDWvQiPT72G6ahH5bqer/E8Q1C
        qV/zzaw7LPfBB9k1nhRM7YfnUJv/O9Q=
X-Google-Smtp-Source: AMsMyM4L54APL8jDg8TB799MQkyu7JaBghJDVDQZzub1O3BaEHckI/RMja5gyXFBgpkFZ+C6mLDMFw==
X-Received: by 2002:a63:2cce:0:b0:434:e004:a218 with SMTP id s197-20020a632cce000000b00434e004a218mr2876826pgs.241.1663304258959;
        Thu, 15 Sep 2022 21:57:38 -0700 (PDT)
Received: from ubuntu ([175.124.254.119])
        by smtp.gmail.com with ESMTPSA id ij24-20020a170902ab5800b001783f964fe3sm8372150plb.113.2022.09.15.21.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 21:57:38 -0700 (PDT)
Date:   Thu, 15 Sep 2022 21:57:34 -0700
From:   Hyunwoo Kim <imv4bel@gmail.com>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, imv4bel@gmail.com,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v2] char: pcmcia: synclink_cs: Fix use-after-free in
 mgslpc_ops
Message-ID: <20220916045734.GA187909@ubuntu>
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
 drivers/char/pcmcia/synclink_cs.c | 40 +++++++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 5 deletions(-)

diff --git a/drivers/char/pcmcia/synclink_cs.c b/drivers/char/pcmcia/synclink_cs.c
index 8fc49b038372..0b2ea77ccb7e 100644
--- a/drivers/char/pcmcia/synclink_cs.c
+++ b/drivers/char/pcmcia/synclink_cs.c
@@ -216,7 +216,9 @@ typedef struct _mgslpc_info {
 
 	/* PCMCIA support */
 	struct pcmcia_device	*p_dev;
-	int		      stop;
+	int			stop;
+	struct kref		refcnt;
+	struct mutex		remove_lock;
 
 	/* SPPP/Cisco HDLC device parts */
 	int netcount;
@@ -468,10 +470,21 @@ static void mgslpc_wait_until_sent(struct tty_struct *tty, int timeout);
 
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
@@ -534,6 +547,8 @@ static int mgslpc_probe(struct pcmcia_device *link)
 	init_waitqueue_head(&info->event_wait_q);
 	spin_lock_init(&info->lock);
 	spin_lock_init(&info->netlock);
+	kref_init(&info->refcnt);
+	mutex_init(&info->remove_lock);
 	memcpy(&info->params,&default_params,sizeof(MGSL_PARAMS));
 	info->idle_mode = HDLC_TXIDLE_FLAGS;
 	info->imra_value = 0xffff;
@@ -620,13 +635,16 @@ static void mgslpc_release(u_long arg)
 
 static void mgslpc_detach(struct pcmcia_device *link)
 {
+	MGSLPC_INFO *info = link->priv;
+
+	mutex_lock(&info->remove_lock);
 	if (debug_level >= DEBUG_LEVEL_INFO)
 		printk("mgslpc_detach(0x%p)\n", link);
 
-	((MGSLPC_INFO *)link->priv)->stop = 1;
-	mgslpc_release((u_long)link);
+	info->stop = 1;
 
-	mgslpc_remove_device((MGSLPC_INFO *)link->priv);
+	kref_put(&info->refcnt, mgslpc_delete);
+	mutex_unlock(&info->remove_lock);
 }
 
 static int mgslpc_suspend(struct pcmcia_device *link)
@@ -2341,10 +2359,13 @@ static void mgslpc_close(struct tty_struct *tty, struct file * filp)
 	
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
@@ -2465,6 +2486,7 @@ static int mgslpc_open(struct tty_struct *tty, struct file * filp)
 	int		retval, line;
 	unsigned long	flags;
 
+
 	/* verify range of specified line number */
 	line = tty->index;
 	if (line >= mgslpc_device_count) {
@@ -2480,6 +2502,9 @@ static int mgslpc_open(struct tty_struct *tty, struct file * filp)
 	if (mgslpc_paranoia_check(info, tty->name, "mgslpc_open"))
 		return -ENODEV;
 
+	mutex_lock(&info->remove_lock);
+	kref_get(&info->refcnt);
+
 	port = &info->port;
 	tty->driver_data = info;
 	tty_port_tty_set(port, tty);
@@ -2517,9 +2542,14 @@ static int mgslpc_open(struct tty_struct *tty, struct file * filp)
 	if (debug_level >= DEBUG_LEVEL_INFO)
 		printk("%s(%d):mgslpc_open(%s) success\n",
 			 __FILE__, __LINE__, info->device_name);
-	retval = 0;
 
+	retval = 0;
+	mutex_unlock(&info->remove_lock);
+	return retval;
 cleanup:
+	kref_put(&info->refcnt, mgslpc_delete);
+
+	mutex_unlock(&info->remove_lock);
 	return retval;
 }
 
-- 
2.25.1

