Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47145BC1F3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 06:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiISEJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 00:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiISEJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 00:09:01 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9FB5BF78
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 21:09:00 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id i15-20020a17090a4b8f00b0020073b4ac27so4912652pjh.3
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 21:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=vKVWMBC/lzkC1dBkLl/PpdF7wlteKW3GRb48j93XLSY=;
        b=p3C+Ao+yYwbUhf+o8rEnuJMcZWEGEUBeUFxlvEGwN161ugqeabJHLaCSbIl8UJmfpe
         H4cmVlADg7g34lIkR3fCVhqXhCfePyqkQco8HyHOn8wutusfSKN5q85tiEVHgsQLTMuN
         fo+X32L00vDfZYOY+g1kI4/0HN4MmYK8QkzmgXTs29+4lFQXd/XuqfucUwcO3Yt1K6qm
         Em1oulLusf3dGqkKccIBh7/flk71vTsgLPsByPyG0KmgGtpuTEO5X1pUzY097rwj14bQ
         132tgs0hIUYhp/vPAHuW3G4FZGzExnua19zltfhgEG/bTd0tNThdo1dZhFoW6aZJMicD
         G6GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=vKVWMBC/lzkC1dBkLl/PpdF7wlteKW3GRb48j93XLSY=;
        b=Rbtg3VmO5hU2wQm06ySdbxdTwzagDQIO23qfr+TUG7RRBoX0V7IWbBowwpMOuPLGD3
         +pwXFNnzcANQqEcoPX7xei5kbMXSILaIvu5y+4kk/bw50fAmjmmLgLSdKsydHhMMON8g
         fhoAA9SwTFRg0pbsnPEMJEC/6/amBpc1jpOejWkqnw13bnBUAX/nPuVQov0fwrJG+6Pw
         skNk9yZxghVM6h45jHDVQRdMiEhF4aI2WwPDN1kagamSMSRiU7o/S5Tr4DaQ7j6q2JBR
         4FytHX8SypaGeuyaLSU9XCmcAFRI2Fx0M//ZQl3umpVdTczBXKUWE/H2EXDESvTMpSes
         lICg==
X-Gm-Message-State: ACrzQf2I6ZMIbCDlbsFCH8RKRGEkyJHXx1Mhre1QP60UmQh1wCpvbzYi
        k+wmtJUxGca3VVLmbFPOhmY=
X-Google-Smtp-Source: AMsMyM4DkiTRsG5AMCceEzMxJnyp/OmT4CgxZo5vqI1rygXhrtwd9KjJuG4reCMga3fSwYYGFq1TBQ==
X-Received: by 2002:a17:90a:31c5:b0:200:a749:4857 with SMTP id j5-20020a17090a31c500b00200a7494857mr18417232pjf.148.1663560540187;
        Sun, 18 Sep 2022 21:09:00 -0700 (PDT)
Received: from ubuntu ([175.124.254.119])
        by smtp.gmail.com with ESMTPSA id w28-20020a637b1c000000b004393cb720afsm11513991pgc.38.2022.09.18.21.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Sep 2022 21:08:59 -0700 (PDT)
Date:   Sun, 18 Sep 2022 21:08:54 -0700
From:   Hyunwoo Kim <imv4bel@gmail.com>
To:     lkundrak@v3.sk
Cc:     linux-kernel@vger.kernel.org, imv4bel@gmail.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, linux@dominikbrodowski.net
Subject: [PATCH v3] char: pcmcia: scr24x_cs: Fix use-after-free in scr24x_fops
Message-ID: <20220919040854.GA302968@ubuntu>
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

A race condition may occur if the user physically removes the
pcmcia device while calling open() for this char device node.

This is a race condition between the scr24x_open() function and
the scr24x_remove() function, which may eventually result in UAF.

So, add a mutex to the scr24x_open() and scr24x_remove() functions
to avoid race contidion of krefs.

Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 drivers/char/pcmcia/scr24x_cs.c | 72 +++++++++++++++++++++++----------
 1 file changed, 51 insertions(+), 21 deletions(-)

diff --git a/drivers/char/pcmcia/scr24x_cs.c b/drivers/char/pcmcia/scr24x_cs.c
index 1bdce08fae3d..57fe08b3c03a 100644
--- a/drivers/char/pcmcia/scr24x_cs.c
+++ b/drivers/char/pcmcia/scr24x_cs.c
@@ -33,6 +33,7 @@
 
 struct scr24x_dev {
 	struct device *dev;
+	struct pcmcia_device *p_dev;
 	struct cdev c_dev;
 	unsigned char buf[CCID_MAX_LEN];
 	int devno;
@@ -42,15 +43,31 @@ struct scr24x_dev {
 };
 
 #define SCR24X_DEVS 8
-static DECLARE_BITMAP(scr24x_minors, SCR24X_DEVS);
+static struct pcmcia_device *dev_table[SCR24X_DEVS];
+static DEFINE_MUTEX(remove_mutex);
 
 static struct class *scr24x_class;
 static dev_t scr24x_devt;
 
 static void scr24x_delete(struct kref *kref)
 {
-	struct scr24x_dev *dev = container_of(kref, struct scr24x_dev,
-								refcnt);
+	struct scr24x_dev *dev = container_of(kref, struct scr24x_dev, refcnt);
+	struct pcmcia_device *link = dev->p_dev;
+	int devno;
+
+	for (devno = 0; devno < SCR24X_DEVS; devno++) {
+		if (dev_table[devno] == link)
+			break;
+	}
+	if (devno == SCR24X_DEVS)
+		return;
+
+	device_destroy(scr24x_class, MKDEV(MAJOR(scr24x_devt), dev->devno));
+	mutex_lock(&dev->lock);
+	pcmcia_disable_device(link);
+	cdev_del(&dev->c_dev);
+	dev->dev = NULL;
+	mutex_unlock(&dev->lock);
 
 	kfree(dev);
 }
@@ -73,11 +90,23 @@ static int scr24x_wait_ready(struct scr24x_dev *dev)
 
 static int scr24x_open(struct inode *inode, struct file *filp)
 {
-	struct scr24x_dev *dev = container_of(inode->i_cdev,
-				struct scr24x_dev, c_dev);
+	struct scr24x_dev *dev;
+	struct pcmcia_device *link;
+	int minor = iminor(inode);
+
+	if (minor >= SCR24X_DEVS)
+		return -ENODEV;
+
+	mutex_lock(&remove_mutex);
+	link = dev_table[minor];
+	if (link == NULL) {
+		mutex_unlock(&remove_mutex);
+		return -ENODEV;
+	}
 
 	kref_get(&dev->refcnt);
 	filp->private_data = dev;
+	mutex_unlock(&remove_mutex);
 
 	return stream_open(inode, filp);
 }
@@ -232,24 +261,31 @@ static int scr24x_config_check(struct pcmcia_device *link, void *priv_data)
 static int scr24x_probe(struct pcmcia_device *link)
 {
 	struct scr24x_dev *dev;
-	int ret;
+	int i, ret;
+
+	for (i = 0; i < SCR24X_DEVS; i++) {
+		if (dev_table[i] == NULL)
+			break;
+	}
+
+	if (i == SCR24X_DEVS)
+		return -ENODEV;
 
 	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
 	if (!dev)
 		return -ENOMEM;
 
-	dev->devno = find_first_zero_bit(scr24x_minors, SCR24X_DEVS);
-	if (dev->devno >= SCR24X_DEVS) {
-		ret = -EBUSY;
-		goto err;
-	}
+	dev->devno = i;
 
 	mutex_init(&dev->lock);
 	kref_init(&dev->refcnt);
 
 	link->priv = dev;
+	dev->p_dev = link;
 	link->config_flags |= CONF_ENABLE_IRQ | CONF_AUTO_SET_IO;
 
+	dev_table[i] = link;
+
 	ret = pcmcia_loop_config(link, scr24x_config_check, NULL);
 	if (ret < 0)
 		goto err;
@@ -282,8 +318,8 @@ static int scr24x_probe(struct pcmcia_device *link)
 	return 0;
 
 err:
-	if (dev->devno < SCR24X_DEVS)
-		clear_bit(dev->devno, scr24x_minors);
+	dev_table[i] = NULL;
+
 	kfree (dev);
 	return ret;
 }
@@ -292,15 +328,9 @@ static void scr24x_remove(struct pcmcia_device *link)
 {
 	struct scr24x_dev *dev = (struct scr24x_dev *)link->priv;
 
-	device_destroy(scr24x_class, MKDEV(MAJOR(scr24x_devt), dev->devno));
-	mutex_lock(&dev->lock);
-	pcmcia_disable_device(link);
-	cdev_del(&dev->c_dev);
-	clear_bit(dev->devno, scr24x_minors);
-	dev->dev = NULL;
-	mutex_unlock(&dev->lock);
-
+	mutex_lock(&remove_mutex);
 	kref_put(&dev->refcnt, scr24x_delete);
+	mutex_unlock(&remove_mutex);
 }
 
 static const struct pcmcia_device_id scr24x_ids[] = {
-- 
2.25.1


Dear,


I fixed the wrong patch referencing "dev" after kref_put() in the previous version of the patch.


Regards,
Hyunwoo Kim.
