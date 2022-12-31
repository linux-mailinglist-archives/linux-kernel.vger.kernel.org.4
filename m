Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A087065A2CC
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 06:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbiLaFx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 00:53:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiLaFxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 00:53:24 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E47413E3A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 21:53:24 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id n12so11429190pjp.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 21:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r9klQXftJia+hhSXJqgN4jzPRrbsbZE3tQlxMBq2je4=;
        b=VKyNbtFQFHuw31BhRRrx8S3iTyuPknna8qQYsMd6tUMEWrKCZ9oo7fP15wF8bYeiml
         GI927RhrDoiXjNsUVZPERIVMsDhXfaR9Ad8D98FGqM/VIynFlrE5ZK12pEdTBynrXJ7b
         giO8oTJa+CigcHQCiWQalAM5lQrBjRGoX0CWYOOoN97iE2kHHw00q/ID4hQLRv59Vs5k
         Uv5SGgOtxe/LKM4K6YBlWjjU5mvcyenM0DlUP8lhKx7/yVuQnrhBXbZ0B/zfPw3HGKLF
         cKyliCRsvDnsPkH/SfmezElNETkKuV5jOwV9PDhjBew5SpesV6kSGPX+J9ByfbFbY9eE
         34zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r9klQXftJia+hhSXJqgN4jzPRrbsbZE3tQlxMBq2je4=;
        b=b8xlk3SH3pFdV2wPNh4LA0ssufvIDrE2sLsPAG+M2+J1Jn8UqnhsnFbzd915tRLXhX
         EEd8QJZf5GqrQ/ZU0xSRt+vqwZQUuq2jFpasH3y/usSNBdo7ee4eBMQBO8nFG7jjlIFn
         ewnKTZw75d0G60jLfgcTL+z6j+ESIPnE1lbOT4HI6J3cTPWO9h/OkWomHRvTaPtgFGNY
         nfsCjqYEgpAVkNWTft11k/MJOEVJLJ/2UNnnN6neBsIPtNL0u4O3wMhQPli7VuozerU8
         MK6GWxKQJPfsj0kP28uf9eAuJehJ9e8j/yZxLRDGgcIZUp64X+VFA0vPc/AFrii0346A
         h03g==
X-Gm-Message-State: AFqh2krYa+60+gtyReIepn6VbwNVwcaVxH4p2rnSbcD44mBxL/MVoHXN
        FU3qhyUkSdHxUqk8sdZTSo0=
X-Google-Smtp-Source: AMrXdXuzL68ciE0H93EGOk997rBzziRTy6F3uXV9ndNSzVVALQMRs7VI5fJJU17kOLlk217dT8S6mg==
X-Received: by 2002:a17:902:6b08:b0:191:3c6:1748 with SMTP id o8-20020a1709026b0800b0019103c61748mr36226500plk.11.1672466003391;
        Fri, 30 Dec 2022 21:53:23 -0800 (PST)
Received: from localhost.localdomain (kayle.snu.ac.kr. [147.46.126.79])
        by smtp.gmail.com with ESMTPSA id d22-20020a170902aa9600b00189c93ce5easm15851560plr.166.2022.12.30.21.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 21:53:22 -0800 (PST)
From:   Yoochan Lee <yoochan1026@gmail.com>
To:     matt.hsiao@hpe.com
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, Yoochan Lee <yoochan1026@gmail.com>
Subject: [PATCH] misc: hpilo: Fix use-after-free in ilo_open
Date:   Sat, 31 Dec 2022 14:53:10 +0900
Message-Id: <20221231055310.2040648-1-yoochan1026@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
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
hpilo device while calling open().

This is a race condition between ilo_open() function and
the ilo_remove() function, which may lead to Use-After-Free.

Therefore, add a refcount check to ilo_remove() function
to free the "ilo_hwinfo" structure after the device is close()d.

---------------CPU 0--------------------CPU 1-----------------
            ilo_open()        |        ilo_remove()
--------------------------------------------------------------
hw = container_of(ip->i_cdev, |
struct ilo_hwinfo, cdev); -(1)|
                              | struct ilo_hwinfo *ilo_hw = pci_get_drvdata(pdev);
                              | ...
                              | kfree(ilo_hw); -(2)
spin_lock(&hw->open_lock);-(3)|

Signed-off-by: Yoochan Lee <yoochan1026@gmail.com>
---
 drivers/misc/hpilo.c | 53 ++++++++++++++++++++++++++------------------
 drivers/misc/hpilo.h |  1 +
 2 files changed, 33 insertions(+), 21 deletions(-)

diff --git a/drivers/misc/hpilo.c b/drivers/misc/hpilo.c
index 8d00df9243c4..b4a99676a642 100644
--- a/drivers/misc/hpilo.c
+++ b/drivers/misc/hpilo.c
@@ -532,6 +532,34 @@ static __poll_t ilo_poll(struct file *fp, poll_table *wait)
 	return 0;
 }
 
+static void ilo_delete(struct kref *kref)
+{
+	struct ilo_hwinfo *ilo_hw = container_of(kref, struct ilo_hwinfo, refcnt);
+
+	clear_device(ilo_hw);
+
+	minor = MINOR(ilo_hw->cdev.dev);
+	for (i = minor; i < minor + max_ccb; i++)
+		device_destroy(ilo_class, MKDEV(ilo_major, i));
+
+	cdev_del(&ilo_hw->cdev);
+	ilo_disable_interrupts(ilo_hw);
+	free_irq(pdev->irq, ilo_hw);
+	ilo_unmap_device(pdev, ilo_hw);
+	pci_release_regions(pdev);
+	/*
+	 * pci_disable_device(pdev) used to be here. But this PCI device has
+	 * two functions with interrupt lines connected to a single pin. The
+	 * other one is a USB host controller. So when we disable the PIN here
+	 * e.g. by rmmod hpilo, the controller stops working. It is because
+	 * the interrupt link is disabled in ACPI since it is not refcounted
+	 * yet. See acpi_pci_link_free_irq called from acpi_pci_irq_disable.
+	 */
+	kfree(ilo_hw);
+	ilo_hwdev[(minor / max_ccb)] = 0;
+
+}
+
 static int ilo_close(struct inode *ip, struct file *fp)
 {
 	int slot;
@@ -558,6 +586,7 @@ static int ilo_close(struct inode *ip, struct file *fp)
 	} else
 		hw->ccb_alloc[slot]->ccb_cnt--;
 
+	kref_put(&hw->refcnt, ilo_delete);
 	spin_unlock(&hw->open_lock);
 
 	return 0;
@@ -629,6 +658,7 @@ static int ilo_open(struct inode *ip, struct file *fp)
 		}
 	}
 out:
+	kref_get(&hw->refcnt);
 	spin_unlock(&hw->open_lock);
 
 	if (!error)
@@ -748,27 +778,7 @@ static void ilo_remove(struct pci_dev *pdev)
 	if (!ilo_hw)
 		return;
 
-	clear_device(ilo_hw);
-
-	minor = MINOR(ilo_hw->cdev.dev);
-	for (i = minor; i < minor + max_ccb; i++)
-		device_destroy(ilo_class, MKDEV(ilo_major, i));
-
-	cdev_del(&ilo_hw->cdev);
-	ilo_disable_interrupts(ilo_hw);
-	free_irq(pdev->irq, ilo_hw);
-	ilo_unmap_device(pdev, ilo_hw);
-	pci_release_regions(pdev);
-	/*
-	 * pci_disable_device(pdev) used to be here. But this PCI device has
-	 * two functions with interrupt lines connected to a single pin. The
-	 * other one is a USB host controller. So when we disable the PIN here
-	 * e.g. by rmmod hpilo, the controller stops working. It is because
-	 * the interrupt link is disabled in ACPI since it is not refcounted
-	 * yet. See acpi_pci_link_free_irq called from acpi_pci_irq_disable.
-	 */
-	kfree(ilo_hw);
-	ilo_hwdev[(minor / max_ccb)] = 0;
+	kref_put(&hw->refcnt, ilo_delete);
 }
 
 static int ilo_probe(struct pci_dev *pdev,
@@ -810,6 +820,7 @@ static int ilo_probe(struct pci_dev *pdev,
 	spin_lock_init(&ilo_hw->alloc_lock);
 	spin_lock_init(&ilo_hw->fifo_lock);
 	spin_lock_init(&ilo_hw->open_lock);
+	kref_init(&iol_hw->refcnt);
 
 	error = pci_enable_device(pdev);
 	if (error)
diff --git a/drivers/misc/hpilo.h b/drivers/misc/hpilo.h
index d57c34680b09..ebc677eb45ae 100644
--- a/drivers/misc/hpilo.h
+++ b/drivers/misc/hpilo.h
@@ -62,6 +62,7 @@ struct ilo_hwinfo {
 	spinlock_t fifo_lock;
 
 	struct cdev cdev;
+	struct kref refcnt;
 };
 
 /* offset from mmio_vaddr for enabling doorbell interrupts */
-- 
2.39.0

