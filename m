Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62D9D708546
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 17:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbjERPrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 11:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbjERPrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 11:47:07 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1673E124
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 08:47:06 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f4449fa085so14078155e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 08:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684424824; x=1687016824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tdB2mLN/Jjc5vavA2rUP8u1cWstj8G55vSclDdDMf8Y=;
        b=ZqENWPXk4bNpT73UyhZxr+EWU3dR+CGJbtg+5MvivVVN4uITH/6z2v85aZyZbmbbec
         qFrfrfB8SbX4AibKZ1FLL4bK4kKK7VAPLskys+I3/h29zrEqoQfvbL4h50xorOfPj8EE
         ixvLYBdZG3KR+aCo+c+3rAzJKwDv59ZIuPmLplKkHPfYgSNHEhTT/8RiQGDNbKnlg+PN
         N8EHlRpmxzu2ZHu6eyqeoyEcPNIBzRfXIqhdPByKnhSFrGaGxtVbuu1E2uSR9o7M3Xjy
         rKkpA1uzoBrwRjTDL/hIOwC88Niczo0O/samClXRll4dBTZpID93JKKXeHSBt0OCz5Ml
         dQ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684424824; x=1687016824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tdB2mLN/Jjc5vavA2rUP8u1cWstj8G55vSclDdDMf8Y=;
        b=lImnqvrD2Sw/2FFAl3S232GvhNbRQxt3kieWRBKtgkWrZupJe5Gpbd6yo6hTpTw+Xl
         X3vKOFMd3Ab7Hry+bjaT980gDDjo4V879PencYTNSw/jnbmnxLFpt9wnlHybyizh+YwT
         qjUgoFKeh1TzZn/Rt4JzqvpEGSYU8vkwlJMjCusRw1v6DN9Cv5DFQOcR4ZIz0SE75+/u
         ZfdfmKztvI+AI8P2u/ZMfPAfej41jjZxg/pba7xvJpBn4h6eFhz1LMcHdt/hDkvQ9JG/
         iNxyp+JUns1QW1H8mB6vciEPVZwtDaqyL3xyBXPkqQ2Vkc4X9AFMu/9a/asiioLEQPRS
         ebbQ==
X-Gm-Message-State: AC+VfDzoQJfjrr6ANCkkNOZ/xZyaUz2q8NA+h+zb2VO2Feab8srVjVbX
        aqsP77mSa3sxrvtUInOc2rq9K+TQZA==
X-Google-Smtp-Source: ACHHUZ4zQpyx51WDSU0ORSd8iUU6XGaMSHUl95UUpJevFKRM3yBo9IeHoJnoJhUTNlGvXAvcxWuAOw==
X-Received: by 2002:a05:600c:218b:b0:3f4:24c8:f7c6 with SMTP id e11-20020a05600c218b00b003f424c8f7c6mr2024879wme.16.1684424824191;
        Thu, 18 May 2023 08:47:04 -0700 (PDT)
Received: from p183.Dlink ([46.53.250.37])
        by smtp.gmail.com with ESMTPSA id h2-20020a1ccc02000000b003f421979398sm5671769wmb.26.2023.05.18.08.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 08:47:03 -0700 (PDT)
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, adobriyan@gmail.com
Subject: [PATCH 3/8] auto, proc: use "auto" instead of quite chatty macros
Date:   Thu, 18 May 2023 18:46:44 +0300
Message-Id: <20230518154648.581643-3-adobriyan@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230518154648.581643-1-adobriyan@gmail.com>
References: <20230518154648.581643-1-adobriyan@gmail.com>
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

