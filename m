Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1B15BC1EF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 06:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiISEHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 00:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiISEHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 00:07:08 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502871A078
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 21:07:07 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id k21so16246266pls.11
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 21:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=88NVVVQ2B32kV1LLC8ocgurk1Nd2TGC/t8d76Ycn7R0=;
        b=lt4+S6pAdv6T7RtMNADaDkPlLrWbyGc7TNjUXTpNjcTpmaK0v0jLrfFXBriNN5S/J0
         anmr3yHoiQfjOfU6WZaSZPHEc70CdFP2T7AbxfPVweQlgz01hE/FzpcIPA79PMC6POiV
         1smpOvkRSsTA4jAdGx4AJo1PWedF9qhqkSMYKTLHaSVnyKCQILtf/G5PJX07qrwB0XyI
         8fVmMTHXrC1eyWfsC5H4zhAQvgGN7XZfEs0U03I6giO4TGvPtnTOnivgPe3B8AopYzDP
         Wd4mc9QDPfCfZbJcarxZM6i/xDdhNjKkmg2YpAY4NA+t+JISWzLKr2SmFx44L9w5tIJ3
         HQMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=88NVVVQ2B32kV1LLC8ocgurk1Nd2TGC/t8d76Ycn7R0=;
        b=hvRCvnvmVoDlc2N7gDf9Ed1xzCgoYUestwtFd8xVLVkodaujtPNTOg2IN3i1zAxPzz
         QabENtWp9uiHjXhjzGs2eW7zp21yE0zZMxa+VvzDmDAsvi4rZuTbgX6Ymv/XmlzZ74Rv
         b85HZpUhIF3CUQHpYv3Kt8xRqtFSjNovALnteODW0P62/vfkiJWoi87fJsKT3jAmXZ3c
         f0Expan99qRf7GzVzyGyZnA1w8vjKJ7KAv8bNvZ0V1AVcK/nnrE8+LbJkWOpYgkdKxuJ
         w60j/zzeaU7MRSbYOIi0+qWOYYFBmNaCYtknMaKpdms5yvugAHvXywTK2UjoMK3PIvPK
         c8uQ==
X-Gm-Message-State: ACrzQf0PF6Bs21RrrPR0lo/CYxSfegOukHrhftgN/2sbSf1A6mm5RNgR
        hr/Q3f5V+HxYvlwP5gcdzVk=
X-Google-Smtp-Source: AMsMyM7hndYNjY0wBGCp6C7BtndE1yy9u3hVEULUV8ttv+FiPtb9YKpbqCxzv4NiN/XfC3feMC7Bvw==
X-Received: by 2002:a17:90b:3c8a:b0:200:b874:804 with SMTP id pv10-20020a17090b3c8a00b00200b8740804mr29357368pjb.151.1663560426568;
        Sun, 18 Sep 2022 21:07:06 -0700 (PDT)
Received: from ubuntu ([175.124.254.119])
        by smtp.gmail.com with ESMTPSA id ij4-20020a170902ab4400b00177e5d83d3dsm19227775plb.170.2022.09.18.21.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Sep 2022 21:07:06 -0700 (PDT)
Date:   Sun, 18 Sep 2022 21:07:01 -0700
From:   Hyunwoo Kim <imv4bel@gmail.com>
To:     laforge@gnumonks.org
Cc:     linux-kernel@vger.kernel.org, imv4bel@gmail.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, linux@dominikbrodowski.net
Subject: [PATCH v3] char: pcmcia: cm4000_cs: Fix use-after-free in cm4000_fops
Message-ID: <20220919040701.GA302806@ubuntu>
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

A race condition may occur if the user physically removes the pcmcia
device while calling open() for this char device node.

This is a race condition between the cmm_open() function and the
cm4000_detach() function, which may eventually result in UAF.

So, add a refcount check to cm4000_detach() to free the "dev" structure
after the char device node is close()d.

Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 drivers/char/pcmcia/cm4000_cs.c | 58 +++++++++++++++++++++++----------
 1 file changed, 41 insertions(+), 17 deletions(-)

diff --git a/drivers/char/pcmcia/cm4000_cs.c b/drivers/char/pcmcia/cm4000_cs.c
index adaec8fd4b16..7103812b4019 100644
--- a/drivers/char/pcmcia/cm4000_cs.c
+++ b/drivers/char/pcmcia/cm4000_cs.c
@@ -55,6 +55,7 @@
 	} while (0)
 
 static DEFINE_MUTEX(cmm_mutex);
+static DEFINE_MUTEX(remove_mutex);
 
 #define	T_1SEC		(HZ)
 #define	T_10MSEC	msecs_to_jiffies(10)
@@ -103,7 +104,8 @@ static int major;		/* major number we get from the kernel */
 #define REG_STOPBITS(x)		(x + 7)
 
 struct cm4000_dev {
-	struct pcmcia_device *p_dev;
+	struct pcmcia_device	*p_dev;
+	struct kref		refcnt;
 
 	unsigned char atr[MAX_ATR];
 	unsigned char rbuf[512];
@@ -146,6 +148,9 @@ struct cm4000_dev {
 
 #define	ZERO_DEV(dev)	memset(&((dev)->init), 0, sizeof((dev)->init))
 
+static void stop_monitor(struct cm4000_dev *dev);
+static void cm4000_delete(struct kref *kref);
+
 static struct pcmcia_device *dev_table[CM4000_MAX_DEV];
 static struct class *cmm_class;
 
@@ -416,6 +421,30 @@ static struct card_fixup card_fixups[] = {
 	},
 };
 
+
+static void cm4000_delete(struct kref *kref)
+{
+	struct cm4000_dev *dev = container_of(kref, struct cm4000_dev, refcnt);
+	struct pcmcia_device *link = dev->p_dev;
+	int devno;
+
+	/* find device */
+	for (devno = 0; devno < CM4000_MAX_DEV; devno++)
+		if (dev_table[devno] == link)
+			break;
+	if (devno == CM4000_MAX_DEV)
+		return;
+
+	stop_monitor(dev);
+
+	cm4000_release(link);
+
+	dev_table[devno] = NULL;
+	kfree(dev);
+
+	device_destroy(cmm_class, MKDEV(major, devno));
+}
+
 static void set_cardparameter(struct cm4000_dev *dev)
 {
 	int i;
@@ -1629,6 +1658,7 @@ static int cmm_open(struct inode *inode, struct file *filp)
 	if (minor >= CM4000_MAX_DEV)
 		return -ENODEV;
 
+	mutex_lock(&remove_mutex);
 	mutex_lock(&cmm_mutex);
 	link = dev_table[minor];
 	if (link == NULL || !pcmcia_dev_present(link)) {
@@ -1673,8 +1703,12 @@ static int cmm_open(struct inode *inode, struct file *filp)
 
 	DEBUGP(2, dev, "<- cmm_open\n");
 	ret = stream_open(inode, filp);
+
+	kref_get(&dev->refcnt);
 out:
 	mutex_unlock(&cmm_mutex);
+	mutex_unlock(&remove_mutex);
+
 	return ret;
 }
 
@@ -1703,6 +1737,8 @@ static int cmm_close(struct inode *inode, struct file *filp)
 	link->open = 0;		/* only one open per device */
 	wake_up(&dev->devq);	/* socket removed? */
 
+	kref_put(&dev->refcnt, cm4000_delete);
+
 	DEBUGP(2, dev, "cmm_close\n");
 	return 0;
 }
@@ -1808,6 +1844,7 @@ static int cm4000_probe(struct pcmcia_device *link)
 	init_waitqueue_head(&dev->ioq);
 	init_waitqueue_head(&dev->atrq);
 	init_waitqueue_head(&dev->readq);
+	kref_init(&dev->refcnt);
 
 	ret = cm4000_config(link, i);
 	if (ret) {
@@ -1824,23 +1861,10 @@ static int cm4000_probe(struct pcmcia_device *link)
 static void cm4000_detach(struct pcmcia_device *link)
 {
 	struct cm4000_dev *dev = link->priv;
-	int devno;
-
-	/* find device */
-	for (devno = 0; devno < CM4000_MAX_DEV; devno++)
-		if (dev_table[devno] == link)
-			break;
-	if (devno == CM4000_MAX_DEV)
-		return;
-
-	stop_monitor(dev);
-
-	cm4000_release(link);
 
-	dev_table[devno] = NULL;
-	kfree(dev);
-
-	device_destroy(cmm_class, MKDEV(major, devno));
+	mutex_lock(&remove_mutex);
+	kref_put(&dev->refcnt, cm4000_delete);
+	mutex_unlock(&remove_mutex);
 
 	return;
 }
-- 
2.25.1


Dear,


I fixed the wrong patch referencing "dev" after kref_put() in the previous version of the patch.


Regards,
Hyunwoo Kim.
