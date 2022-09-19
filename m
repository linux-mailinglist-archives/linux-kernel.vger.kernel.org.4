Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605555BC989
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 12:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbiISK0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 06:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231730AbiISKV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 06:21:57 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE8A27B2D
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 03:18:33 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id c198so27593117pfc.13
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 03:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=nDkdrsrnlbjLvpB/eya82O2c4yvXpw5vUiNvvttIS2w=;
        b=FqzUQI6QfUBJWM50t7FDGrZ9E3Pfbzt0XjAI/oAsHNlUNxIbjohLjv1TPkKDqqYq12
         6kTQqUY4u12CwgpcJhhaXnCA21rItIfOrKBHN9WFqO+e7E/R1Kt8S1vddnwNtg5qWW0F
         SBqf77sqHUUbSCqLi1Ao4uLM+DHi0n/4zs+MhmjS65bwBwe1YIWSi4C5dQhc9iUNLSwC
         lWjwVkgXZxbxULs5jM6WWzjE5371nVTpWZuJzndvaHRMT3Kw8rPjgT2LILmeT6mOnGcN
         nHkPgmfGnRx+ZOB2jJoOg4K9X/VHZtHdqGZF4Q/F+RJj972FMFPSFDRocm2QLtz3FYU8
         Qehw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=nDkdrsrnlbjLvpB/eya82O2c4yvXpw5vUiNvvttIS2w=;
        b=qv6og06RcJxcxrYQmVB5fKX37AU8sXPJdvUnRntWbyrk7YDHoOGQH2paRXNINeZ/16
         XtxcOem6lOsMTRocX4NB3YQTpN/FkKJYzMVXNItqv0axHtC5kAYgjNZO55SfQGOySQWW
         WVv2C1IvwyRHeWsj+stzWrTcFrt9PW7CWEnU5HGYqifV6D99vWAVxcSJR2dtVcQLOcI7
         kBtyvSonouP00KRBKzaeo6X9ipBmkOr8kbFvu6DzPuGrJOnX0AK2WqDRmNd8luZGzig1
         yebyvOLz5+zrYCayFOnWhaoF5picE+XFl1jEbD7ndTY2nSrgKN95Saa27wKRiSB6IUaL
         4JXA==
X-Gm-Message-State: ACrzQf2OX5cL4LCorJ1MS4Xqs6m3LnZRZzsVHhQuhSbmsjwCQyXlxjmG
        ny8lONoYa9h3YxI23LLZ10E=
X-Google-Smtp-Source: AMsMyM5OFs7HraoCWli2hb1L0r25Lq5xmX6BcznP97lVoutsJL6ARe16aBrBR/FKtLCB6lyfa+2OwQ==
X-Received: by 2002:a63:77c4:0:b0:435:4224:98b6 with SMTP id s187-20020a6377c4000000b00435422498b6mr15187367pgc.94.1663582712424;
        Mon, 19 Sep 2022 03:18:32 -0700 (PDT)
Received: from ubuntu ([175.124.254.119])
        by smtp.gmail.com with ESMTPSA id y2-20020a17090264c200b0017544b55277sm15212707pli.126.2022.09.19.03.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 03:18:31 -0700 (PDT)
Date:   Mon, 19 Sep 2022 03:18:25 -0700
From:   Hyunwoo Kim <imv4bel@gmail.com>
To:     lkundrak@v3.sk
Cc:     linux-kernel@vger.kernel.org, imv4bel@gmail.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, linux@dominikbrodowski.net
Subject: [PATCH v5] char: pcmcia: scr24x_cs: Fix use-after-free in scr24x_fops
Message-ID: <20220919101825.GA313940@ubuntu>
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
v2: fixed issue using dev's member mutex which can be freed after kref_put()
v3: fixed using "removed" member of dev that could be freed after kref_put()
v4: fix issue referencing uninitialized dev in scr24x_open() function
v5: Fix patch reporting email format
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

base-commit: 521a547ced6477c54b4b0cc206000406c221b4d6
-- 
2.25.1

