Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA1E5BC590
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 11:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbiISJiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 05:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiISJiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 05:38:07 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364A813D59
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 02:38:06 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id q3so27219256pjg.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 02:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=cDlH4OUMa1OZd9ZnX/QPWLd9DHpJXBzxL+H+3m4JtSg=;
        b=ZZZMKKdIjNLxmLKVahGkJw9gOJ6Lds6jLBftOtTr0E+Wb8sXUPEjrdvI/vfbTV1/ck
         pqWzwD6EdpNC2xYlMPcfLo+qZeiG5LvKJihIxQq+UFhI70aAx8zPjW2x11qfnuqxTwLe
         0DHDvr4FPm+5GmOXb3zWTacEjIwFBkLYl4xVex4zZ38EIvQeY6yfQBwxlxg0CF8oKc1+
         puAp0wtJFnbrn30ihbDCUcEKPvAODduZWu1vPlnLHkOZY4bArC0MHB00kb+7k3s6uzZX
         QpWu0BspYwhV2Vv6FZ7XLqRkNRC73SfWyAwXMGwKKIBOhTUaDE1tOoyTzYzm7HP7ehro
         B3dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=cDlH4OUMa1OZd9ZnX/QPWLd9DHpJXBzxL+H+3m4JtSg=;
        b=0SSVLNQS5nJddghrCwc3zid2rqogXbOOor0fxuyeULJztHY2oYRVQ62wokgqTyji6u
         IiejnDaw/J98l121qAXVFR8F446U6fiX/neziKS3cW1/ExQ6m3qgjK71CQzdHVAnyX4R
         7auW1gZ6eRCPU11bTNEbBc2Z9pchm67DzUHPabJMzjB3MPD3ZS8MKCv3R6JTMpdAWyRX
         ywH27BYf/JauwktFrz5DlptTBLnquBrrLcmmR4SaFiU2vkMkmcUNXoBJ1kzKuXBW9m39
         Nm+iRFBKXoLs7vLnNDcMRTyLH7BvSWfi9FgDHuBs6I1E9IfvsEvykoZOXTygyzDDCgMT
         1lgw==
X-Gm-Message-State: ACrzQf3pOZypBymc+D5stX96asolT8+d3xleaBRAmDlmYDiVmiOKoCwR
        2d2xhyyk3d9rusHE8bSyrKI=
X-Google-Smtp-Source: AMsMyM5mBNqSGs+KkxkKrcj5RgyP0eAgi0vzcgR6/RNEwH+JdaqTbY0EaiO5qo+e4+iQxD+DRGG5ug==
X-Received: by 2002:a17:903:189:b0:178:3df7:f32e with SMTP id z9-20020a170903018900b001783df7f32emr12011797plg.47.1663580285664;
        Mon, 19 Sep 2022 02:38:05 -0700 (PDT)
Received: from ubuntu ([175.124.254.119])
        by smtp.gmail.com with ESMTPSA id h24-20020a632118000000b00439103a6c3bsm7453859pgh.94.2022.09.19.02.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 02:38:05 -0700 (PDT)
Date:   Mon, 19 Sep 2022 02:38:01 -0700
From:   Hyunwoo Kim <imv4bel@gmail.com>
To:     lkundrak@v3.sk
Cc:     linux-kernel@vger.kernel.org, imv4bel@gmail.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, linux@dominikbrodowski.net
Subject: [PATCH v4] char: pcmcia: scr24x_cs: Fix use-after-free in scr24x_fops
Message-ID: <20220919093801.GA307492@ubuntu>
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
Reported-by: kernel test robot <lkp@intel.com>
---
 drivers/char/pcmcia/scr24x_cs.c | 73 +++++++++++++++++++++++----------
 1 file changed, 52 insertions(+), 21 deletions(-)

diff --git a/drivers/char/pcmcia/scr24x_cs.c b/drivers/char/pcmcia/scr24x_cs.c
index 1bdce08fae3d..039d44ee0ebe 100644
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
@@ -73,11 +90,24 @@ static int scr24x_wait_ready(struct scr24x_dev *dev)
 
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
 
+	dev = link->priv;
 	kref_get(&dev->refcnt);
 	filp->private_data = dev;
+	mutex_unlock(&remove_mutex);
 
 	return stream_open(inode, filp);
 }
@@ -232,24 +262,31 @@ static int scr24x_config_check(struct pcmcia_device *link, void *priv_data)
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
@@ -282,8 +319,8 @@ static int scr24x_probe(struct pcmcia_device *link)
 	return 0;
 
 err:
-	if (dev->devno < SCR24X_DEVS)
-		clear_bit(dev->devno, scr24x_minors);
+	dev_table[i] = NULL;
+
 	kfree (dev);
 	return ret;
 }
@@ -292,15 +329,9 @@ static void scr24x_remove(struct pcmcia_device *link)
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

