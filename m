Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F51656788
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 07:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbiL0Geh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 01:34:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiL0Gef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 01:34:35 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0042C3891;
        Mon, 26 Dec 2022 22:34:33 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id n8so4964805oih.0;
        Mon, 26 Dec 2022 22:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0XXscYgKIA7/S8ggDNARrFFW3CWIO448R3pDI8wQKfg=;
        b=cRurO+C13CQNxeixYaLjbgSrDVnlzOMU1zpFJy8rP9QQ7NtBG3ZBnAsSiSd5KMqLHC
         fndDhWcnHBqHHybfod++2kgoJfQyrz1P/yxsk2yM8mGQRPcXg691HMjRceByiuplXKkb
         m0wWUDIRVRZAIlrrmbBArjMg3Glyr8IYq0XGZQCaeoPkZRz4URlFLTCGNdDByiz4+c62
         r0sLZQ4xnR/xZAOzGBOEr36wiKQItG45bNl21Wbaq9OosA/rOJ62BNQODoRXxrHJWfQw
         Qya0f/g5lULr8zZ98qTG6LB/5Z6VWBgLQfwn1S/MlZ7dfOSZYFIBEK0CODHVilGBL57z
         vOdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0XXscYgKIA7/S8ggDNARrFFW3CWIO448R3pDI8wQKfg=;
        b=kfzr9Ar4ppP6G3I1oYeLOmx4EI91j8F9xXUV8v/EoSKIO0KOtkNQCkGmHVFCRNiDrg
         s7EL/uhtBytjka8r08TEZlzrgyu8FAZZOodpTo4n83eSZz8HNqI8HIBVfjGW01/v1QeX
         Xf9pF29H2beNkXvnS+ZBDxLDcRNR6XMY5KUOWn/IJpIACsze+teSXv9gCyr4omTJXuOo
         SwtjPd1d29Y1E3korNn3kbqRxYZwJnQI2BEFs/W+CkoOnh7S2l3tpcqLwDCzGaslUmEk
         FP0ZPcOfzfyx8NHYmo34qGNLh+JSWOXVozHEeDXRZGThe6R7Ny4srUsV7yaIy3B5W7kG
         COwg==
X-Gm-Message-State: AFqh2koraMgpKfyiXFhRAvGgtAXpbYlyGC8qdPTasohZxrYuAGHJ4/DQ
        paGMxJtQspS+/Dvb/k0y0AShZzRrvII=
X-Google-Smtp-Source: AMrXdXvzWb+PqL9kVPTn4TyXp1pfHJe9F0f2WTDXAntOkZiwefQZAdSiT8Zw7APAcCVSjy4BkFrwRw==
X-Received: by 2002:aca:1c19:0:b0:355:1de8:de4b with SMTP id c25-20020aca1c19000000b003551de8de4bmr9645946oic.36.1672122873304;
        Mon, 26 Dec 2022 22:34:33 -0800 (PST)
Received: from protoss.cs.ucr.edu (protoss.cs.ucr.edu. [169.235.26.60])
        by smtp.gmail.com with ESMTPSA id be15-20020a056808218f00b0035e7c48d08esm5551965oib.15.2022.12.26.22.34.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Dec 2022 22:34:32 -0800 (PST)
From:   Hang Zhang <zh.nvgt@gmail.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hang Zhang <zh.nvgt@gmail.com>
Subject: [PATCH] ACPI: custom_method: fix potential use-after-free issues
Date:   Mon, 26 Dec 2022 22:33:35 -0800
Message-Id: <20221227063335.61474-1-zh.nvgt@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cm_write() is the .write callback of the custom_method debugfs
interface, it operates on a global pointer "buf" (e.g., dereference,
allocate, free, and nullification), the problem is that cm_write()
is not protected by any locks, so concurrent invocations of it
may cause use-after-free issues for "buf", e.g., one invocation
may have just freed "buf" while being preempted before nullifying
the pointer, then another invocation can dereference the now dangling
"buf" pointer.

Fix the issue by protecting the "buf" operations in cm_write() with
the inode write lock. Note that the .llseek callback of the debugfs
interface has been protected by the same lock, this patch basically
introduces it to the .write callback as well.

Signed-off-by: Hang Zhang <zh.nvgt@gmail.com>
---
 drivers/acpi/custom_method.c | 43 +++++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/custom_method.c b/drivers/acpi/custom_method.c
index d39a9b474727..e3de5a06d903 100644
--- a/drivers/acpi/custom_method.c
+++ b/drivers/acpi/custom_method.c
@@ -29,28 +29,38 @@ static ssize_t cm_write(struct file *file, const char __user *user_buf,
 	struct acpi_table_header table;
 	acpi_status status;
 	int ret;
+	struct inode *inode = file_inode(file);
 
 	ret = security_locked_down(LOCKDOWN_ACPI_TABLES);
 	if (ret)
 		return ret;
 
+	inode_lock(inode);
 	if (!(*ppos)) {
 		/* parse the table header to get the table length */
-		if (count <= sizeof(struct acpi_table_header))
-			return -EINVAL;
+		if (count <= sizeof(struct acpi_table_header)) {
+			ret = -EINVAL;
+			goto err;
+		}
 		if (copy_from_user(&table, user_buf,
-				   sizeof(struct acpi_table_header)))
-			return -EFAULT;
+				   sizeof(struct acpi_table_header))) {
+			ret = -EFAULT;
+			goto err;
+		}
 		uncopied_bytes = max_size = table.length;
 		/* make sure the buf is not allocated */
 		kfree(buf);
 		buf = kzalloc(max_size, GFP_KERNEL);
-		if (!buf)
-			return -ENOMEM;
+		if (!buf) {
+			ret = -ENOMEM;
+			goto err;
+		}
 	}
 
-	if (buf == NULL)
-		return -EINVAL;
+	if (buf == NULL) {
+		ret = -EINVAL;
+		goto err;
+	}
 
 	if ((*ppos > max_size) ||
 	    (*ppos + count > max_size) ||
@@ -58,13 +68,15 @@ static ssize_t cm_write(struct file *file, const char __user *user_buf,
 	    (count > uncopied_bytes)) {
 		kfree(buf);
 		buf = NULL;
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err;
 	}
 
 	if (copy_from_user(buf + (*ppos), user_buf, count)) {
 		kfree(buf);
 		buf = NULL;
-		return -EFAULT;
+		ret = -EFAULT;
+		goto err;
 	}
 
 	uncopied_bytes -= count;
@@ -74,12 +86,17 @@ static ssize_t cm_write(struct file *file, const char __user *user_buf,
 		status = acpi_install_method(buf);
 		kfree(buf);
 		buf = NULL;
-		if (ACPI_FAILURE(status))
-			return -EINVAL;
+		if (ACPI_FAILURE(status)) {
+			ret = -EINVAL;
+			goto err;
+		}
 		add_taint(TAINT_OVERRIDDEN_ACPI_TABLE, LOCKDEP_NOW_UNRELIABLE);
 	}
 
-	return count;
+	ret = count;
+err:
+	inode_unlock(inode);
+	return ret;
 }
 
 static const struct file_operations cm_fops = {
-- 
2.39.0

