Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E24E683A93
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 00:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjAaXiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 18:38:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjAaXiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 18:38:03 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA74CEB4F;
        Tue, 31 Jan 2023 15:38:02 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id m7so15735118wru.8;
        Tue, 31 Jan 2023 15:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v+YMYC51/WU7rHvsB72Vb4yJc2h/8pry0Bzxn3JMbPw=;
        b=jJGgNquttUQwCxezsTVAGik485T7IANNTmUj2wMkPeIl2cHXLPW8NTgpRbvOfe5C+X
         uXieltcHyjoDFlI+sR6mURyp66QxIlPVo7/ceamF4MpXjRljhbDcBal7XXrTMtG54iUg
         r8xr5TPC6IH8UMc0l8pa9X7mnVmvf2maoiKIkh8Ip4usf5RP2CRLh6IdrCwV40DmU9Cm
         arapYCbwtIw5UbBR8OKvfPMfDR0XrGqg/qommmUBXA7aWU3/AO3aNuBG3bGVNexEnwe9
         iXE5PvnAOTfZk9/E9SlSCUa+rUGEl7Hiqy/mHizt3A4kXg38yl5ZmsLkzhP80ZYgFiKw
         /RkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v+YMYC51/WU7rHvsB72Vb4yJc2h/8pry0Bzxn3JMbPw=;
        b=PFPiCehNKtWVdnfH9RviHINzPziWZ7hM91dYGQi9oE0zz8QTO+Nvq2BkheWlR3LZkQ
         9FvscLKvKT6cb9jgvqgTz55BfZJVlJFzjrjzriSF000mi7EpKLJbE++Lgpoi6colRy9q
         NB4zz5POXKJxwiTiOHQTjBG2s+9yBG4o5F7YMU+wJjmRR8dQoaWnFL8yexFN0RCehP+B
         uH/7s8AY5HTLCO6LP2K2PfIeP6yS78fO9krfKsPF+ReVA91bnq5Iubp3Hqh0srujfKs0
         TQAak03vVw1phjz6uf1EibqqWOoSXbKmoPXxOPHNGT80gICeRYCDMGsvv9Tc6PxGafCA
         m9rg==
X-Gm-Message-State: AO0yUKUZkakgRBFE/4fJc7qRclAlNcGQxtFVGdUYgqJJGFSAHdJ+k9Ac
        +suO/B6yJRXsAD0Kmu+/2dCIMTolqxIwnNT21ko=
X-Google-Smtp-Source: AK7set8pgsRDo/VrakZ80kDZd2ZS67/srcUmnM3oHzNtYSJgnG1cEsTqNrU1y8gzLuT5fuMG/QvHKQ==
X-Received: by 2002:a05:6000:cb:b0:2bf:eee9:2d23 with SMTP id q11-20020a05600000cb00b002bfeee92d23mr642956wrx.56.1675208280672;
        Tue, 31 Jan 2023 15:38:00 -0800 (PST)
Received: from PC-PEDRO-ARCH.lan ([2001:8a0:7280:5801:9441:3dce:686c:bfc7])
        by smtp.gmail.com with ESMTPSA id f21-20020a5d58f5000000b00236883f2f5csm15947462wrd.94.2023.01.31.15.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 15:38:00 -0800 (PST)
From:   Pedro Falcato <pedro.falcato@gmail.com>
To:     linux-acpi@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org,
        rui.zhang@intel.com, Pedro Falcato <pedro.falcato@gmail.com>,
        Hang Zhang <zh.nvgt@gmail.com>,
        Swift Geek <swiftgeek@gmail.com>
Subject: [PATCH] ACPI: Make custom_method use per-open state
Date:   Tue, 31 Jan 2023 23:37:55 +0000
Message-Id: <20230131233755.58942-1-pedro.falcato@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make custom_method keep its own per-file-open state instead of global
state in order to avoid race conditions[1] and other possible conflicts
with other concurrent users.

Link: https://lore.kernel.org/linux-acpi/20221227063335.61474-1-zh.nvgt@gmail.com/ # [1]
Reported-by: Hang Zhang <zh.nvgt@gmail.com>
Cc: Swift Geek <swiftgeek@gmail.com>
Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>
---
 This patch addresses Hang's problems plus the ones raised by Rafael in his review (see link above).
 https://lore.kernel.org/lkml/2667007.mvXUDI8C0e@kreacher/ was submitted but since there were still people
 that wanted this feature, I took my time to write up a patch that should fix the issues.
 Hopefully the linux-acpi maintainers have not decided to remove custom_method just yet.

 drivers/acpi/custom_method.c | 119 +++++++++++++++++++++++++++--------
 1 file changed, 92 insertions(+), 27 deletions(-)

diff --git a/drivers/acpi/custom_method.c b/drivers/acpi/custom_method.c
index d39a9b47472..034fb14f118 100644
--- a/drivers/acpi/custom_method.c
+++ b/drivers/acpi/custom_method.c
@@ -17,73 +17,138 @@ MODULE_LICENSE("GPL");
 
 static struct dentry *cm_dentry;
 
+struct custom_method_state {
+	char *buf;
+	u32 max_size;
+	u32 uncopied_bytes;
+	struct mutex lock;
+};
+
+static int cm_open(struct inode *inode, struct file *file)
+{
+	struct custom_method_state *state;
+
+	state = kzalloc(sizeof(struct custom_method_state), GFP_KERNEL);
+
+	if (!state)
+		return -ENOMEM;
+
+	file->private_data = state;
+	mutex_init(&state->lock);
+
+	return 0;
+}
+
+static int cm_release(struct inode *inode, struct file *file)
+{
+	struct custom_method_state *state;
+
+	state = file->private_data;
+
+	mutex_destroy(&state->lock);
+
+	/* Make sure the buf gets freed */
+	kfree(state->buf);
+
+	kfree(state);
+	return 0;
+}
+
 /* /sys/kernel/debug/acpi/custom_method */
 
 static ssize_t cm_write(struct file *file, const char __user *user_buf,
 			size_t count, loff_t *ppos)
 {
-	static char *buf;
-	static u32 max_size;
-	static u32 uncopied_bytes;
+	struct custom_method_state *state;
+	char *buf;
 
 	struct acpi_table_header table;
 	acpi_status status;
 	int ret;
 
+	state = file->private_data;
+	buf = state->buf;
+
 	ret = security_locked_down(LOCKDOWN_ACPI_TABLES);
 	if (ret)
 		return ret;
 
+	mutex_lock(&state->lock);
+
 	if (!(*ppos)) {
 		/* parse the table header to get the table length */
-		if (count <= sizeof(struct acpi_table_header))
-			return -EINVAL;
+		if (count <= sizeof(struct acpi_table_header)) {
+			count = -EINVAL;
+			goto out;
+		}
+
 		if (copy_from_user(&table, user_buf,
-				   sizeof(struct acpi_table_header)))
-			return -EFAULT;
-		uncopied_bytes = max_size = table.length;
+				   sizeof(struct acpi_table_header))) {
+			count = -EFAULT;
+			goto out;
+		}
+
+		state->uncopied_bytes = state->max_size = table.length;
 		/* make sure the buf is not allocated */
 		kfree(buf);
-		buf = kzalloc(max_size, GFP_KERNEL);
-		if (!buf)
-			return -ENOMEM;
+		buf = state->buf = kzalloc(state->max_size, GFP_KERNEL);
+		if (!buf) {
+			count = -ENOMEM;
+			goto out;
+		}
 	}
 
-	if (buf == NULL)
-		return -EINVAL;
+	/* Check if someone seeked ahead or if we errored out
+	 * (buf will be NULL)
+	 */
+	if (buf == NULL) {
+		count = -EINVAL;
+		goto out;
+	}
 
-	if ((*ppos > max_size) ||
-	    (*ppos + count > max_size) ||
+	if ((*ppos > state->max_size) ||
+	    (*ppos + count > state->max_size) ||
 	    (*ppos + count < count) ||
-	    (count > uncopied_bytes)) {
-		kfree(buf);
-		buf = NULL;
-		return -EINVAL;
+	    (count > state->uncopied_bytes)) {
+		count = -EINVAL;
+		goto err_free;
 	}
 
 	if (copy_from_user(buf + (*ppos), user_buf, count)) {
-		kfree(buf);
-		buf = NULL;
-		return -EFAULT;
+		count = -EFAULT;
+		goto err_free;
 	}
 
-	uncopied_bytes -= count;
+	state->uncopied_bytes -= count;
 	*ppos += count;
 
-	if (!uncopied_bytes) {
+	if (!state->uncopied_bytes) {
 		status = acpi_install_method(buf);
 		kfree(buf);
-		buf = NULL;
-		if (ACPI_FAILURE(status))
-			return -EINVAL;
+		state->buf = NULL;
+
+		if (ACPI_FAILURE(status)) {
+			count = -EINVAL;
+			goto out;
+		}
+
 		add_taint(TAINT_OVERRIDDEN_ACPI_TABLE, LOCKDEP_NOW_UNRELIABLE);
 	}
 
+out:
+	mutex_unlock(&state->lock);
+	return count;
+err_free:
+	mutex_unlock(&state->lock);
+	kfree(buf);
+	state->buf = NULL;
 	return count;
 }
 
 static const struct file_operations cm_fops = {
 	.write = cm_write,
+	.open = cm_open,
+	.release = cm_release,
 	.llseek = default_llseek,
 };
 
-- 
2.39.0

