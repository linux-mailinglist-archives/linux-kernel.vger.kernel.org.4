Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 763BC5BC1E9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 06:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiISEDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 00:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiISEC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 00:02:58 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507C11A06C
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 21:02:57 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so5671566pjq.3
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 21:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=+LXQwmF+JR6l2F1cvPFKtSSvx2LAjPVF0goEFiMRM54=;
        b=iZupHwORKvWHJ9UdDLZRN3DSg9LTaaYyWqBGAXrngLI6Fu6OSI2+ud9kt3C+Nw3I7K
         Z8Byab4r2+7YdivvUSM5SrEewxVTA0Cxu1F2ZOa0DgQx3L6Fz+YdNV9M2hvNZoKR1t0r
         Z5SQpGstHZncb1pcBW76XeH1lEZwcbJWWxyddXJUwTVbOqgzBbyZiOt/FcIZErmoXUmJ
         XMhV0JXtrF84l5qa2pguOkWoJ1scytMvXS77OHXyGxkmnZHdbGRXTdgswR37bbubixtP
         brmedLaylP6sOYADfYXvg2yU3kGNnA1vR2WP2SUS6f5ZRBZdj3GePdZFW+9VLeEJHVph
         iB0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=+LXQwmF+JR6l2F1cvPFKtSSvx2LAjPVF0goEFiMRM54=;
        b=3PPtdpw3UWcSw3IyN3ckZF7f9R01U+5sXyXCl2F6RWF7a50dS+MGQRZAX8VwM4TKzh
         4jBL4brIncL1w6sZB7+p0Mrj8pZbVzkckSn2vB/N2z7zwA1JIZYCEhfP5VidF6tI+GI1
         PcNJe7a4F2c2u0e3dzbFOTbGAgjJ6HgZ8ywdjITx0nxzOAUH4e3PJRx5uq8+PgYZab3K
         7iLttqI2wM/Kzqzi+bcodXYFeQI7N8/HPdw6IxFStVyR0RNMv5QO1wM3SFmzL3L0AhuR
         Oga1tMftyqO/eikiw8LQIijX4fVzZdVdeEa2rdwOY/kxpwOLy9HkpdAJdbY37InDsZ4I
         7s2w==
X-Gm-Message-State: ACrzQf2k+XQew9K8z1JCa5lVHYyeMP09+U4ppFW+WePSRdFUx2GMGJ7t
        q+0Pw+KEpi0U1QtfTFAYDfaigjRWY+I=
X-Google-Smtp-Source: AMsMyM6S55QVAA/wSPO37iWkQtfTpmQ6sWhIscEkpt2X2pCrIBjlfhs1F37wjtLhd9agoouSFOFdXg==
X-Received: by 2002:a17:902:7c07:b0:178:2984:450 with SMTP id x7-20020a1709027c0700b0017829840450mr11338750pll.43.1663560176763;
        Sun, 18 Sep 2022 21:02:56 -0700 (PDT)
Received: from ubuntu ([175.124.254.119])
        by smtp.gmail.com with ESMTPSA id s15-20020a170902ea0f00b00176dc67df44sm18077369plg.132.2022.09.18.21.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Sep 2022 21:02:56 -0700 (PDT)
Date:   Sun, 18 Sep 2022 21:02:51 -0700
From:   Hyunwoo Kim <imv4bel@gmail.com>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, imv4bel@gmail.com,
        ilpo.jarvinen@linux.intel.com, paulkf@microgate.com,
        linux@dominikbrodowski.net
Subject: [PATCH v5] char: pcmcia: synclink_cs: Fix use-after-free in
 mgslpc_ops
Message-ID: <20220919040251.GA302541@ubuntu>
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
 drivers/char/pcmcia/synclink_cs.c | 35 +++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/drivers/char/pcmcia/synclink_cs.c b/drivers/char/pcmcia/synclink_cs.c
index 8fc49b038372..0dfba8833a67 100644
--- a/drivers/char/pcmcia/synclink_cs.c
+++ b/drivers/char/pcmcia/synclink_cs.c
@@ -216,7 +216,8 @@ typedef struct _mgslpc_info {
 
 	/* PCMCIA support */
 	struct pcmcia_device	*p_dev;
-	int		      stop;
+	int			stop;
+	struct kref		refcnt;
 
 	/* SPPP/Cisco HDLC device parts */
 	int netcount;
@@ -228,6 +229,8 @@ typedef struct _mgslpc_info {
 
 } MGSLPC_INFO;
 
+static DEFINE_MUTEX(remove_mutex);
+
 #define MGSLPC_MAGIC 0x5402
 
 /*
@@ -468,10 +471,21 @@ static void mgslpc_wait_until_sent(struct tty_struct *tty, int timeout);
 
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
@@ -534,6 +548,7 @@ static int mgslpc_probe(struct pcmcia_device *link)
 	init_waitqueue_head(&info->event_wait_q);
 	spin_lock_init(&info->lock);
 	spin_lock_init(&info->netlock);
+	kref_init(&info->refcnt);
 	memcpy(&info->params,&default_params,sizeof(MGSL_PARAMS));
 	info->idle_mode = HDLC_TXIDLE_FLAGS;
 	info->imra_value = 0xffff;
@@ -620,13 +635,15 @@ static void mgslpc_release(u_long arg)
 
 static void mgslpc_detach(struct pcmcia_device *link)
 {
+	MGSLPC_INFO *info = link->priv;
+
+	mutex_lock(&remove_mutex);
 	if (debug_level >= DEBUG_LEVEL_INFO)
 		printk("mgslpc_detach(0x%p)\n", link);
 
-	((MGSLPC_INFO *)link->priv)->stop = 1;
-	mgslpc_release((u_long)link);
-
-	mgslpc_remove_device((MGSLPC_INFO *)link->priv);
+	info->stop = 1;
+	kref_put(&info->refcnt, mgslpc_delete);
+	mutex_unlock(&remove_mutex);
 }
 
 static int mgslpc_suspend(struct pcmcia_device *link)
@@ -2341,10 +2358,13 @@ static void mgslpc_close(struct tty_struct *tty, struct file * filp)
 	
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
@@ -2465,6 +2485,8 @@ static int mgslpc_open(struct tty_struct *tty, struct file * filp)
 	int		retval, line;
 	unsigned long	flags;
 
+	mutex_lock(&remove_mutex);
+
 	/* verify range of specified line number */
 	line = tty->index;
 	if (line >= mgslpc_device_count) {
@@ -2517,9 +2539,10 @@ static int mgslpc_open(struct tty_struct *tty, struct file * filp)
 	if (debug_level >= DEBUG_LEVEL_INFO)
 		printk("%s(%d):mgslpc_open(%s) success\n",
 			 __FILE__, __LINE__, info->device_name);
-	retval = 0;
 
+	kref_get(&info->refcnt);
 cleanup:
+	mutex_unlock(&remove_mutex);
 	return retval;
 }
 
-- 
2.25.1

Dear,


I fixed the wrong patch referencing "info" after kref_put() in the previous version of the patch.


Regards,
Hyunwoo Kim.
