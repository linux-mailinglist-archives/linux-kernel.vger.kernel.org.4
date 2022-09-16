Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37B525BAE89
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 15:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbiIPNvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 09:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbiIPNvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 09:51:18 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2416DA1D48
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 06:51:18 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id w20so9433325ply.12
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 06:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=w3xcFXH0fspP1aXfpiR06tynCXWqviT3tIty9Sh0zLQ=;
        b=VOqaP1sEVS5p2iR/KZhl5But403chD/JjUkwr9IH8rH8O9wh8Bkah2zFE1s4bdQvg1
         x1cThoDWhUgRa6h9lvP0ZknOZnMrmYsMLNpWX0EHR3WoE1ju7pdlb969e/5dLlaIfoo6
         lJVQeAn0elf6tcGBTkRL01GhGXzd/lgDBWN15fv6HeEE0TdQY0sO8xkouIcqUL3A84ZE
         kVVsUOgkogO/LXvC7TfvmfINkAWu8kXvlhsaeSmds641uFwSaGfUZILsUHvUaM44bisz
         Vpc93uzG+AUqeujPdgTHpnt5GcPGTtEDEPs4cjwukxLKDi4MAWmcDwf2ldaegkb/5y3B
         P5Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=w3xcFXH0fspP1aXfpiR06tynCXWqviT3tIty9Sh0zLQ=;
        b=Dv3SyuLZBsZQQZB0zuj3ABku+4+TH+RUDVF16fOjWF5Y7HLF3BnoKHLeRc62HTUoTQ
         z//w6SFr9ttAXnWPOtWx2impqRlpoAnl4e6dOOg0J/XBl7hDyIgRtCqIdoJdL1Z4Im0c
         dpOFUnza6zN4hNuD8OBqdxnUrsg+F6Eypf1BWD9pyX8IVgxzxBbU+z44u/elA9KqauQD
         EABObugAtVzAtylI36aFy6cGw0sgqHBw6LaiEk3NVRpyyy0ZXFq7nD7CrWMgmtFyWDhd
         8HiuxK6eevmadeza2Lu0OMDnX83iC8CA/hVPAgYT7F81I4GNXGiIWblDVKZS4LXQ3c0y
         hvRg==
X-Gm-Message-State: ACrzQf2ul5w1ii5t01FYyoUVLm46/rOwge37l9L57NbbHNjDL88VMhEL
        ypooz+jn7s5cqKAXRoOH194=
X-Google-Smtp-Source: AMsMyM5owMp0kmBBMcBP2Nb1hkqLDKG/rXCLcBhxVp0UkN4W0qIsru18vexa8jAmrH7xyqmP1me2wA==
X-Received: by 2002:a17:902:d890:b0:16c:abb4:94d0 with SMTP id b16-20020a170902d89000b0016cabb494d0mr5001340plz.50.1663336277717;
        Fri, 16 Sep 2022 06:51:17 -0700 (PDT)
Received: from ubuntu ([175.124.254.119])
        by smtp.gmail.com with ESMTPSA id y75-20020a62644e000000b005365aee486bsm14432549pfb.192.2022.09.16.06.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 06:51:17 -0700 (PDT)
Date:   Fri, 16 Sep 2022 06:51:13 -0700
From:   Hyunwoo Kim <imv4bel@gmail.com>
To:     lkundrak@v3.sk
Cc:     linux-kernel@vger.kernel.org, imv4bel@gmail.com,
        gregkh@linuxfoundation.org, arnd@arndb.de
Subject: [PATCH v2] char: pcmcia: scr24x_cs: Fix use-after-free in scr24x_fops
Message-ID: <20220916135113.GA235070@ubuntu>
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
 drivers/char/pcmcia/scr24x_cs.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/char/pcmcia/scr24x_cs.c b/drivers/char/pcmcia/scr24x_cs.c
index 1bdce08fae3d..f630da554cc4 100644
--- a/drivers/char/pcmcia/scr24x_cs.c
+++ b/drivers/char/pcmcia/scr24x_cs.c
@@ -39,10 +39,12 @@ struct scr24x_dev {
 	struct mutex lock;
 	struct kref refcnt;
 	u8 __iomem *regs;
+	int removed;
 };
 
 #define SCR24X_DEVS 8
 static DECLARE_BITMAP(scr24x_minors, SCR24X_DEVS);
+static DEFINE_MUTEX(remove_mutex);
 
 static struct class *scr24x_class;
 static dev_t scr24x_devt;
@@ -76,8 +78,15 @@ static int scr24x_open(struct inode *inode, struct file *filp)
 	struct scr24x_dev *dev = container_of(inode->i_cdev,
 				struct scr24x_dev, c_dev);
 
+	mutex_lock(&remove_mutex);
+	if (dev->removed == 1) {
+		mutex_unlock(&remove_mutex);
+		return -ENODEV;
+	}
+
 	kref_get(&dev->refcnt);
 	filp->private_data = dev;
+	mutex_unlock(&remove_mutex);
 
 	return stream_open(inode, filp);
 }
@@ -292,6 +301,7 @@ static void scr24x_remove(struct pcmcia_device *link)
 {
 	struct scr24x_dev *dev = (struct scr24x_dev *)link->priv;
 
+	mutex_lock(&remove_mutex);
 	device_destroy(scr24x_class, MKDEV(MAJOR(scr24x_devt), dev->devno));
 	mutex_lock(&dev->lock);
 	pcmcia_disable_device(link);
@@ -301,6 +311,8 @@ static void scr24x_remove(struct pcmcia_device *link)
 	mutex_unlock(&dev->lock);
 
 	kref_put(&dev->refcnt, scr24x_delete);
+	dev->removed = 1;
+	mutex_unlock(&remove_mutex);
 }
 
 static const struct pcmcia_device_id scr24x_ids[] = {
-- 
2.25.1

