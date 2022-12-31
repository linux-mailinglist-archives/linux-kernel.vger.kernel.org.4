Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F1165A2B7
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 06:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbiLaE7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 23:59:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiLaE66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 23:58:58 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A94D1758A;
        Fri, 30 Dec 2022 20:58:57 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id u4-20020a17090a518400b00223f7eba2c4so23251421pjh.5;
        Fri, 30 Dec 2022 20:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EufWqX9dCf4XvIcCUQnzSLEMVyrkjkBbjT33Bi0xc4k=;
        b=XTAYg1K7y9zz+zvCq04/V+eRrhtZBomSsUX1Nm5yKxVlRM8dnJDRGcG8W4MnDyiUcN
         yx3CqRn+AHyy/ldze3hahHmxcr9deIy1CTFnucHQYBfKToTtzNTvXJE3Ql5pSx0CBoGy
         35nuEM4qMb8lR+wwH7VSYbxZu25sa8EJvqZvi6QbnfHmlDfA057L5kgmXmIqsOkCD727
         dt5HhmFCHvn35m6JzK0ovS4ReLMS6NSIIQ8/0p22BuyiKifhltM7tQZICK7DNBn0mNCh
         ZadSXaop5ZPC+Ve9AI8z3mqT1jPZ29uE/aN7tF4YwHEJgdK2jHL7pPuw6ddYikjGRZfz
         VaMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EufWqX9dCf4XvIcCUQnzSLEMVyrkjkBbjT33Bi0xc4k=;
        b=3N7dbLR6lQAL7AgvNmn4S2cxFsZADreahDrj0yE6eboOqCFz1PDdyjJDGu5rxpGCzp
         8hyZtYkMgrQIIrnaBoFEWIo6jnbvQTBLo8fVFmAjNho1cteirWl1TjhOV0i//jy/Njua
         /tjBayk7mXKbt2+0nGWEvjp5BmZFxZbe3VyIX6ZAjL0+cbJgIGrntbtwvflqAqXpf/wS
         s0gnjrxaqm9vqORy5kWhFdMASodKBuP7q81HQirfywt5olpQyv/yYkBybos+3/a6IsaU
         cJpbGuN7dzYfmscoR7AciL+b9YfyRbfpYDKugfyKGVVcuVIVZ+UJR0OFdYoTcWM8vtu6
         +lAg==
X-Gm-Message-State: AFqh2kp6ZrBVjlvIIZYXlLRdDSACQVhyb6xpQ/nA44/h1ZlNdhtr/INa
        AJREMhzXv2fulRpX80Eh6h+2fOrv+7PCRA==
X-Google-Smtp-Source: AMrXdXs/vhTNrZ2Ilqc5t+CAO4dzCU+sKSGLufrR6xnnVh/kfGbMn7U08f1CSndDocrR6Mn92ZNawg==
X-Received: by 2002:a17:902:8f87:b0:189:2688:c97f with SMTP id z7-20020a1709028f8700b001892688c97fmr38074576plo.50.1672462736876;
        Fri, 30 Dec 2022 20:58:56 -0800 (PST)
Received: from localhost.localdomain (kayle.snu.ac.kr. [147.46.126.79])
        by smtp.gmail.com with ESMTPSA id 2-20020a170902c20200b00190f5e3bcd9sm15861251pll.23.2022.12.30.20.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 20:58:56 -0800 (PST)
From:   Yoochan Lee <yoochan1026@gmail.com>
To:     davem@davemloft.net
Cc:     sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yoochan Lee <yoochan1026@gmail.com>
Subject: [PATCH] \sbus: char: uctrl: Fix use-after-free in uctrl_open
Date:   Sat, 31 Dec 2022 13:58:44 +0900
Message-Id: <20221231045844.2038042-1-yoochan1026@gmail.com>
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
uctrl device while calling open().

This is a race condition between uctrl_open() function and
the uctrl_remove() function, which may lead to Use-After-Free.

Therefore, add a kref when open() uctrl driver and decrement
the kref when close() and uctrl_remove() so that the race
condition is not occured.

---------------CPU 0--------------------CPU 1-----------------
                              | p = dev_get_drvdata(&op->dev);
                              | ...
                              | kfree(p); -- (1)
uctrl_get_event_status(global
_driver); — (2)

Signed-off-by: Yoochan Lee <yoochan1026@gmail.com>
---
 drivers/sbus/char/uctrl.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/sbus/char/uctrl.c b/drivers/sbus/char/uctrl.c
index 05de0ce79cb9..17a8acdfc03a 100644
--- a/drivers/sbus/char/uctrl.c
+++ b/drivers/sbus/char/uctrl.c
@@ -189,6 +189,7 @@ static struct uctrl_driver {
 	int irq;
 	int pending;
 	struct uctrl_status status;
+	struct kref *refcnt;
 } *global_driver;
 
 static void uctrl_get_event_status(struct uctrl_driver *);
@@ -204,12 +205,28 @@ uctrl_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	return 0;
 }
 
+static void uctrl_delete(struct kref *kref)
+{
+	struct uctrl_driver *p = container_of(kref, struct uctrl_driver, refcnt);
+
+	misc_deregister(&uctrl_dev);
+	free_irq(p->irq, p);
+	of_iounmap(&op->resource[0], p->regs, resource_size(&op->resource[0]));
+	kfree(p);
+}
+
+static int uctrl_close(struct inode *inode, struct file *file)
+{
+	kref_put(&global_driver->refcnt, uctrl_delete);
+}
+
 static int
 uctrl_open(struct inode *inode, struct file *file)
 {
 	mutex_lock(&uctrl_mutex);
 	uctrl_get_event_status(global_driver);
 	uctrl_get_external_status(global_driver);
+	kref_get(&global_driver->refcnt);
 	mutex_unlock(&uctrl_mutex);
 	return 0;
 }
@@ -224,6 +241,7 @@ static const struct file_operations uctrl_fops = {
 	.llseek =	no_llseek,
 	.unlocked_ioctl =	uctrl_ioctl,
 	.open =		uctrl_open,
+	.release =	uctrl_close,
 };
 
 static struct miscdevice uctrl_dev = {
@@ -404,10 +422,7 @@ static int uctrl_remove(struct platform_device *op)
 	struct uctrl_driver *p = dev_get_drvdata(&op->dev);
 
 	if (p) {
-		misc_deregister(&uctrl_dev);
-		free_irq(p->irq, p);
-		of_iounmap(&op->resource[0], p->regs, resource_size(&op->resource[0]));
-		kfree(p);
+		kref_put(&p->refcnt, uctrl_delete);
 	}
 	return 0;
 }
-- 
2.39.0

