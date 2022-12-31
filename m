Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 410A165A2D8
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 07:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbiLaGFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 01:05:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiLaGFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 01:05:06 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A19E2DDF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 22:05:05 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id o8-20020a17090a9f8800b00223de0364beso27594849pjp.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 22:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t2p2Lq9XG1VuX6MXgE4UL8IrKFgPv26IxXAqxAO06lA=;
        b=H8s+imttZtpZVSnCniNX9ReJ6LbU1NkI3Wgv72yl8hsXjtuC4J1/EnTbINwJ5HO8Jr
         CLybNoDZrfHCv3BCQzoAsaydCnYwbkOZqJCLgom7PzWMxmP0ho2HrXOFkp+8hfISsVjE
         715LNDNnlJvW6mWCRM65vPBnEocUu3+6lpTVVUR2tLfEvHu6IqjbcFjpzj/gXmak5+i7
         G0IENg6HDstVOfOqR3qUySO6gH3e+qEx2LjEsc8jyRJ/F8F1P3qxiPx79nMZ1+yklDBQ
         Rq1Qa28lqfEHdd3gwBVGMQ1S1NzM/k5bLEfopgUbDIBF4bggc4CRBki0/I+zgPITfRE0
         B5vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t2p2Lq9XG1VuX6MXgE4UL8IrKFgPv26IxXAqxAO06lA=;
        b=AOxjZ2tFlbt4m9Oow5qWimZzvcbSAOyxICX4YydE78wVxdkMG7EfTFrYeyR50IHvFn
         LXvzmk5t1C+JI75TQg25a/f/0oLeoYp6ie5FZdVchyBcxOi/VfuG8OMJztjxpCfFYoqR
         /P8x94Kn2QZ2+lcvxzGJXQkssqExuv6+ti6sFRDhBFBVDVhi2SDhKDTlMspEmxeUBbkS
         2hO+sTwT6u4ldhX17yQVSYhr8MwWKzBKm9+qzLNQHP8HEfvgGk/+MxGoTUbxooM8lpkH
         jpWiFp0nb4ng8lHyg0xAj9AprZbnM7xLB/JdK5bMEWlR1GR0z32cZM21tkAburIQSKgG
         d8hg==
X-Gm-Message-State: AFqh2kqtAvPX9zTE3IjRezwC1M4eeuOZfGa14oFHD243+Tfxjba1IpRj
        FYfd2l312t+2IZO/cLtXhic=
X-Google-Smtp-Source: AMrXdXtHn8SvMko5DVtVwS80nTIadR59zMuzIlgsK2I3EecWvBGeDWrJU/tp9rQvReu+VzVcTlAonQ==
X-Received: by 2002:a05:6a20:a5a7:b0:af:8786:f7d7 with SMTP id bc39-20020a056a20a5a700b000af8786f7d7mr46262541pzb.21.1672466704575;
        Fri, 30 Dec 2022 22:05:04 -0800 (PST)
Received: from localhost.localdomain (kayle.snu.ac.kr. [147.46.126.79])
        by smtp.gmail.com with ESMTPSA id c21-20020a621c15000000b00581498190efsm8674863pfc.161.2022.12.30.22.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 22:05:04 -0800 (PST)
From:   Yoochan Lee <yoochan1026@gmail.com>
To:     jirislaby@kernel.org
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, Yoochan Lee <yoochan1026@gmail.com>
Subject: [PATCH] misc: phantom: Fix use-after-free in phantom_open
Date:   Sat, 31 Dec 2022 15:04:59 +0900
Message-Id: <20221231060459.2041173-1-yoochan1026@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A race condition may occur if the user physically removes the
phantom device while calling open().

This is a race condition between phantom_open() function and
the phantom_remove() function, which may lead to Use-After-Free.

Therefore, add a refcount check to phantom_remove() function
to free the "phantom_device" structure after the device is close()d.

---------------CPU 0--------------------CPU 1-----------------
         phantom_open()             |     phantom_remove()
--------------------------------------------------------------
struct phantom_device *dev =        |
container_of(inode->i_cdev,         |
struct phantom_device, cdev); — (1) |
                                    | struct phantom_device *pht
                                    | = pci_get_drvdata(pdev);
                                    | ...
                                    | kfree(pht); — (2)
if (dev->opened) { — (3)            |

Signed-off-by: Yoochan Lee <yoochan1026@gmail.com>
---
 drivers/misc/phantom.c | 50 ++++++++++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 19 deletions(-)

diff --git a/drivers/misc/phantom.c b/drivers/misc/phantom.c
index ce72e46a2e73..ee75aa1f56ae 100644
--- a/drivers/misc/phantom.c
+++ b/drivers/misc/phantom.c
@@ -55,6 +55,7 @@ struct phantom_device {
 	/* used in NOT_OH mode */
 	struct phm_regs oregs;
 	u32 ctl_reg;
+	struct kref refcnt;
 };
 
 static unsigned char phantom_devices[PHANTOM_MAX_MINORS];
@@ -78,6 +79,32 @@ static int phantom_status(struct phantom_device *dev, unsigned long newstat)
 	return 0;
 }
 
+static void phantom_delete(struct kref *kref)
+{
+	struct phantom_device *pht = container_of(kref, struct phantom_device, refcnt);
+
+	device_destroy(phantom_class, MKDEV(phantom_major, minor));
+
+	cdev_del(&pht->cdev);
+
+	iowrite32(0, pht->caddr + PHN_IRQCTL);
+	ioread32(pht->caddr + PHN_IRQCTL); /* PCI posting */
+	free_irq(pdev->irq, pht);
+
+	pci_iounmap(pdev, pht->oaddr);
+	pci_iounmap(pdev, pht->iaddr);
+	pci_iounmap(pdev, pht->caddr);
+
+	kfree(pht);
+
+	pci_release_regions(pdev);
+
+	phantom_devices[minor] = 0;
+
+	pci_disable_device(pdev);
+
+}
+
 /*
  * File ops
  */
@@ -232,6 +259,7 @@ static int phantom_open(struct inode *inode, struct file *file)
 
 	atomic_set(&dev->counter, 0);
 	dev->opened++;
+	kref_get(&dev->refcnt);
 	mutex_unlock(&dev->open_lock);
 	mutex_unlock(&phantom_mutex);
 	return 0;
@@ -247,6 +275,7 @@ static int phantom_release(struct inode *inode, struct file *file)
 	phantom_status(dev, dev->status & ~PHB_RUNNING);
 	dev->status &= ~PHB_NOT_OH;
 
+	kref_put(&dev->refcnt, phantom_delete);
 	mutex_unlock(&dev->open_lock);
 
 	return 0;
@@ -384,6 +413,7 @@ static int phantom_probe(struct pci_dev *pdev,
 
 	mutex_init(&pht->open_lock);
 	spin_lock_init(&pht->regs_lock);
+	kref_init(&pht->refcnt);
 	init_waitqueue_head(&pht->wait);
 	cdev_init(&pht->cdev, &phantom_file_ops);
 	pht->cdev.owner = THIS_MODULE;
@@ -436,25 +466,7 @@ static void phantom_remove(struct pci_dev *pdev)
 	struct phantom_device *pht = pci_get_drvdata(pdev);
 	unsigned int minor = MINOR(pht->cdev.dev);
 
-	device_destroy(phantom_class, MKDEV(phantom_major, minor));
-
-	cdev_del(&pht->cdev);
-
-	iowrite32(0, pht->caddr + PHN_IRQCTL);
-	ioread32(pht->caddr + PHN_IRQCTL); /* PCI posting */
-	free_irq(pdev->irq, pht);
-
-	pci_iounmap(pdev, pht->oaddr);
-	pci_iounmap(pdev, pht->iaddr);
-	pci_iounmap(pdev, pht->caddr);
-
-	kfree(pht);
-
-	pci_release_regions(pdev);
-
-	phantom_devices[minor] = 0;
-
-	pci_disable_device(pdev);
+	kref_put(&pht->refcnt, phantom_delete);
 }
 
 static int __maybe_unused phantom_suspend(struct device *dev_d)
-- 
2.39.0

