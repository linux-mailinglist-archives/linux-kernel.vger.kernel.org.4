Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4497D70545C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 18:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbjEPQuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 12:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbjEPQuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 12:50:12 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB9F983EC
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 09:50:07 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-30786c87cdaso11521816f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 09:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684255806; x=1686847806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tdB2mLN/Jjc5vavA2rUP8u1cWstj8G55vSclDdDMf8Y=;
        b=gMYGBfTwr+L4ToSraKn91NRTICcI65U2InCvcKJMM+a0KfNy9KMm4An3sUdDhKh9yL
         6M6CPfMAlfriAR/tTIU53UCuc1sSfcDGcSf7okzYNXK5hrErKu1c+/c9JltR8cXvXk79
         29d1U7NkS1xEg4q7Ybsu4Gtb+8d54eQsImgFn5dvu+4U67BThvcAtjYnCLlMPccrqvoD
         fksh46AgFVeztYEWSQtj36S57SOY3azR3paN2z7Zt4CKFf1VGHgS9NPyvtkA3awcZ/oE
         wxkWvq/cRnRXTAf18Lq+O8AqYlPgs7wnoFBNeFon5XqtzTPdQ7e0O1BqdBby0c6NtyLa
         d28A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684255806; x=1686847806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tdB2mLN/Jjc5vavA2rUP8u1cWstj8G55vSclDdDMf8Y=;
        b=digE/KV1E5POGEUiwbyohZEh+KzJSH9xGmfOPU40t079fIKtWwKGThbbrNE9fjc2WO
         TIJ6pyB5m9DsyLQHb8XexEvFmFx5CjleXijRd7QnhM6oUMYl98q6MKjl729IMAhVK6N4
         xij0KY3ssc1AVaHQ0h72hXIuAON7EfxxGkOvQBci80HIQ90K4DNgD8BGRW9H2Hsl8M/x
         k9MbUxbKTTpa4jDkbpgjOHfJA+rP3A2cS5ul7mpiNhdbBjUq2fAmJAmcB3ZkLSB/UqFz
         OKKx1Yugfupe8rEehECKKHCRzKDTp64yTnpq3JZScyYAh4HxpY3K7NdhwZUWRaC6oorv
         6PDg==
X-Gm-Message-State: AC+VfDyZU59llfSXm1AIG7u7pH3tXdL5wnMXV/7wYbc8QjkPkytLs3sD
        oJjcs6GOytvQtjnRYH6Rdw==
X-Google-Smtp-Source: ACHHUZ5t/aOviyWi34wyxgfXyl9jXnVNetV52YBN+RIIOD6QWSAB5T1aiUm1KvhHiqwqCgsWrTCS4g==
X-Received: by 2002:a5d:4f8d:0:b0:309:3c24:20c7 with SMTP id d13-20020a5d4f8d000000b003093c2420c7mr288678wru.2.1684255805722;
        Tue, 16 May 2023 09:50:05 -0700 (PDT)
Received: from localhost.localdomain ([46.53.250.37])
        by smtp.gmail.com with ESMTPSA id d10-20020adffd8a000000b002f22c44e974sm3094789wrr.102.2023.05.16.09.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 09:50:05 -0700 (PDT)
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, adobriyan@gmail.com
Subject: [PATCH 3/3] auto, proc: use "auto" instead of quite chatty macros
Date:   Tue, 16 May 2023 19:49:47 +0300
Message-Id: <20230516164947.86543-3-adobriyan@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230516164947.86543-1-adobriyan@gmail.com>
References: <20230516164947.86543-1-adobriyan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---
 fs/proc/inode.c | 32 ++++++++------------------------
 1 file changed, 8 insertions(+), 24 deletions(-)

diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index f495fdb39151..88644891b876 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -309,9 +309,7 @@ static ssize_t proc_reg_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 
 static ssize_t pde_read(struct proc_dir_entry *pde, struct file *file, char __user *buf, size_t count, loff_t *ppos)
 {
-	typeof_member(struct proc_ops, proc_read) read;
-
-	read = pde->proc_ops->proc_read;
+	auto read = pde->proc_ops->proc_read;
 	if (read)
 		return read(file, buf, count, ppos);
 	return -EIO;
@@ -333,9 +331,7 @@ static ssize_t proc_reg_read(struct file *file, char __user *buf, size_t count,
 
 static ssize_t pde_write(struct proc_dir_entry *pde, struct file *file, const char __user *buf, size_t count, loff_t *ppos)
 {
-	typeof_member(struct proc_ops, proc_write) write;
-
-	write = pde->proc_ops->proc_write;
+	auto write = pde->proc_ops->proc_write;
 	if (write)
 		return write(file, buf, count, ppos);
 	return -EIO;
@@ -357,9 +353,7 @@ static ssize_t proc_reg_write(struct file *file, const char __user *buf, size_t
 
 static __poll_t pde_poll(struct proc_dir_entry *pde, struct file *file, struct poll_table_struct *pts)
 {
-	typeof_member(struct proc_ops, proc_poll) poll;
-
-	poll = pde->proc_ops->proc_poll;
+	auto poll = pde->proc_ops->proc_poll;
 	if (poll)
 		return poll(file, pts);
 	return DEFAULT_POLLMASK;
@@ -381,9 +375,7 @@ static __poll_t proc_reg_poll(struct file *file, struct poll_table_struct *pts)
 
 static long pde_ioctl(struct proc_dir_entry *pde, struct file *file, unsigned int cmd, unsigned long arg)
 {
-	typeof_member(struct proc_ops, proc_ioctl) ioctl;
-
-	ioctl = pde->proc_ops->proc_ioctl;
+	auto ioctl = pde->proc_ops->proc_ioctl;
 	if (ioctl)
 		return ioctl(file, cmd, arg);
 	return -ENOTTY;
@@ -406,9 +398,7 @@ static long proc_reg_unlocked_ioctl(struct file *file, unsigned int cmd, unsigne
 #ifdef CONFIG_COMPAT
 static long pde_compat_ioctl(struct proc_dir_entry *pde, struct file *file, unsigned int cmd, unsigned long arg)
 {
-	typeof_member(struct proc_ops, proc_compat_ioctl) compat_ioctl;
-
-	compat_ioctl = pde->proc_ops->proc_compat_ioctl;
+	auto compat_ioctl = pde->proc_ops->proc_compat_ioctl;
 	if (compat_ioctl)
 		return compat_ioctl(file, cmd, arg);
 	return -ENOTTY;
@@ -430,9 +420,7 @@ static long proc_reg_compat_ioctl(struct file *file, unsigned int cmd, unsigned
 
 static int pde_mmap(struct proc_dir_entry *pde, struct file *file, struct vm_area_struct *vma)
 {
-	typeof_member(struct proc_ops, proc_mmap) mmap;
-
-	mmap = pde->proc_ops->proc_mmap;
+	auto mmap = pde->proc_ops->proc_mmap;
 	if (mmap)
 		return mmap(file, vma);
 	return -EIO;
@@ -457,9 +445,7 @@ pde_get_unmapped_area(struct proc_dir_entry *pde, struct file *file, unsigned lo
 			   unsigned long len, unsigned long pgoff,
 			   unsigned long flags)
 {
-	typeof_member(struct proc_ops, proc_get_unmapped_area) get_area;
-
-	get_area = pde->proc_ops->proc_get_unmapped_area;
+	auto get_area = pde->proc_ops->proc_get_unmapped_area;
 #ifdef CONFIG_MMU
 	if (!get_area)
 		get_area = current->mm->get_unmapped_area;
@@ -555,9 +541,7 @@ static int proc_reg_release(struct inode *inode, struct file *file)
 	struct pde_opener *pdeo;
 
 	if (pde_is_permanent(pde)) {
-		typeof_member(struct proc_ops, proc_release) release;
-
-		release = pde->proc_ops->proc_release;
+		auto release = pde->proc_ops->proc_release;
 		if (release) {
 			return release(inode, file);
 		}
-- 
2.40.1

