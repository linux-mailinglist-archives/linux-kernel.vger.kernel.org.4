Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF5B6A9651
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 12:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjCCLbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 06:31:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbjCCLbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 06:31:33 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808C55F22E;
        Fri,  3 Mar 2023 03:30:58 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id 6-20020a17090a190600b00237c5b6ecd7so5803988pjg.4;
        Fri, 03 Mar 2023 03:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677843057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ke2Xq6JkzOHJeaW2xUHi+wBDvgOFsG9d52tymACvPdk=;
        b=NR+uDqI47mWmUxv2LXOghnB2XuSdJKFMr6HdJp+YQNYa0+an3IO/3ZDm9Nl8FQxOUp
         EXg04oClvAvhSs7c742B3I5o/Yn0qfHy+Vp7oA8YZ8YiuERZk60iVD+HcQUyOJmhNj4I
         W9aWoMGAE+nlAIxqHkJB8QTNjSh6QKN0k4yFuAnN858xSO3rNn9WbSCqDxnJjKuvRhcf
         kptc7S3qxavi4otaXgQX3xO8IM4znklI6FJ2gewqecsUom/au8fDcPg+h9uAF/UWpZ6H
         57wAjvxIgq48KfmER9CLqXWyGoWQcyCbLqr9NC2uF7Ib/CEYHhx6m+6c5KZl6Tr4u6JF
         cHww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677843057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ke2Xq6JkzOHJeaW2xUHi+wBDvgOFsG9d52tymACvPdk=;
        b=ZUxdaLv2n+KURaGv5hgy6Jx2XxWiUtHmB8WBYf12ONoIZDnlIkn9JK+OERgsQcL1f9
         mKbtOjU8eUR71fhg0IHQN3lIlGD+1nTkVpTggro3U1FiHNlz+iaa6eJqPAgUjF4QljAR
         JslA2wgcDS1F9+CPrgD07iab0nU7zcDGn7OT4OGJ4qTCDiaokwnCLOERA1W3w2qqoG65
         X7L3Adk/zOHPIBCPFhaZNb+s4D+A+91xYyz9BiTf8t4rwlnH4tRR+YG7lzke/i9l8Sp9
         aP25Jhr9rJyx6MyDm/1YoIKS28kmUWUI0ly7XK+yxFtmASR76B+GbiJsCcRvzrDHfYGb
         wyvQ==
X-Gm-Message-State: AO0yUKWtr6noW6J5l4m6O88ew4pTX3Fx+lLYyUnI5nRQarDo/jxMEgqG
        12T8F14+MPyonOD0QG0fYn4=
X-Google-Smtp-Source: AK7set/O/sH6TF3TOVlklmFLrqOaTIiErgiBUhW4RNtc1sTzz5ArE+SokxQjfEjgoillbNN/k8veQw==
X-Received: by 2002:a05:6a20:4281:b0:cc:a8d7:ad62 with SMTP id o1-20020a056a20428100b000cca8d7ad62mr2569827pzj.27.1677843057312;
        Fri, 03 Mar 2023 03:30:57 -0800 (PST)
Received: from localhost.localdomain (124-148-239-17.tpgi.com.au. [124.148.239.17])
        by smtp.gmail.com with ESMTPSA id n4-20020a62e504000000b005a8c92f7c27sm1356262pff.212.2023.03.03.03.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 03:30:57 -0800 (PST)
From:   Orlando Chamberlain <orlandoch.dev@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Wunner <lukas@wunner.de>,
        Seth Forshee <sforshee@kernel.org>,
        Aditya Garg <gargaditya08@live.com>,
        Aun-Ali Zaidi <admin@kodeit.net>,
        Kerem Karabay <kekrby@gmail.com>,
        Orlando Chamberlain <orlandoch.dev@gmail.com>
Subject: [PATCH v4 4/4] apple-gmux: add debugfs interface
Date:   Fri,  3 Mar 2023 22:28:43 +1100
Message-Id: <20230303112842.3094-5-orlandoch.dev@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230303112842.3094-1-orlandoch.dev@gmail.com>
References: <20230303112842.3094-1-orlandoch.dev@gmail.com>
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

Allow reading and writing gmux ports from userspace.

For example:

echo 4 > /sys/kernel/debug/apple_gmux/selected_port
cat /sys/kernel/debug/apple_gmux/selected_port_data | xxd -p

Will show the gmux version information (00000005 in this case)

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Orlando Chamberlain <orlandoch.dev@gmail.com>
---
v3->v4: Collect Hans' review
 drivers/platform/x86/apple-gmux.c | 82 +++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
index 79809fc5cf0c..53805aa7b14e 100644
--- a/drivers/platform/x86/apple-gmux.c
+++ b/drivers/platform/x86/apple-gmux.c
@@ -22,6 +22,7 @@
 #include <linux/delay.h>
 #include <linux/pci.h>
 #include <linux/vga_switcheroo.h>
+#include <linux/debugfs.h>
 #include <asm/io.h>
 
 /**
@@ -73,6 +74,10 @@ struct apple_gmux_data {
 	enum vga_switcheroo_client_id switch_state_external;
 	enum vga_switcheroo_state power_state;
 	struct completion powerchange_done;
+
+	/* debugfs data */
+	u8 selected_port;
+	struct dentry *debug_dentry;
 };
 
 static struct apple_gmux_data *apple_gmux_data;
@@ -670,6 +675,81 @@ static void gmux_notify_handler(acpi_handle device, u32 value, void *context)
 		complete(&gmux_data->powerchange_done);
 }
 
+/**
+ * DOC: Debugfs Interface
+ *
+ * gmux ports can be accessed from userspace as a debugfs interface. For example:
+ *
+ * # echo 4 > /sys/kernel/debug/apple_gmux/selected_port
+ * # cat /sys/kernel/debug/apple_gmux/selected_port_data | xxd -p
+ * 00000005
+ *
+ * Reads 4 bytes from port 4 (GMUX_PORT_VERSION_MAJOR).
+ *
+ * 1 and 4 byte writes are also allowed.
+ */
+
+static ssize_t gmux_selected_port_data_write(struct file *file,
+		const char __user *userbuf, size_t count, loff_t *ppos)
+{
+	struct apple_gmux_data *gmux_data = file->private_data;
+	int ret;
+
+	if (*ppos)
+		return -EINVAL;
+
+	if (count == 1) {
+		u8 data;
+
+		ret = copy_from_user(&data, userbuf, 1);
+		if (ret)
+			return ret;
+		gmux_write8(gmux_data, gmux_data->selected_port, data);
+	} else if (count == 4) {
+		u32 data;
+
+		ret = copy_from_user(&data, userbuf, 4);
+		if (ret)
+			return ret;
+		gmux_write32(gmux_data, gmux_data->selected_port, data);
+	} else
+		return -EINVAL;
+
+	return count;
+}
+
+static ssize_t gmux_selected_port_data_read(struct file *file,
+		char __user *userbuf, size_t count, loff_t *ppos)
+{
+	struct apple_gmux_data *gmux_data = file->private_data;
+	u32 data;
+
+	data = gmux_read32(gmux_data, gmux_data->selected_port);
+
+	return simple_read_from_buffer(userbuf, count, ppos, &data, sizeof(data));
+}
+
+static const struct file_operations gmux_port_data_ops = {
+	.open = simple_open,
+	.write = gmux_selected_port_data_write,
+	.read = gmux_selected_port_data_read
+};
+
+static void gmux_init_debugfs(struct apple_gmux_data *gmux_data)
+{
+	gmux_data->debug_dentry = debugfs_create_dir(KBUILD_MODNAME, NULL);
+
+	debugfs_create_u8("selected_port", 0644, gmux_data->debug_dentry,
+			&gmux_data->selected_port);
+	debugfs_create_file("selected_port_data", 0644, gmux_data->debug_dentry,
+			gmux_data, &gmux_port_data_ops);
+}
+
+static void gmux_fini_debugfs(struct apple_gmux_data *gmux_data)
+{
+	debugfs_remove_recursive(gmux_data->debug_dentry);
+}
+
 static int gmux_suspend(struct device *dev)
 {
 	struct pnp_dev *pnp = to_pnp_dev(dev);
@@ -870,6 +950,7 @@ static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
 		goto err_register_handler;
 	}
 
+	gmux_init_debugfs(gmux_data);
 	return 0;
 
 err_register_handler:
@@ -901,6 +982,7 @@ static void gmux_remove(struct pnp_dev *pnp)
 {
 	struct apple_gmux_data *gmux_data = pnp_get_drvdata(pnp);
 
+	gmux_fini_debugfs(gmux_data);
 	vga_switcheroo_unregister_handler();
 	gmux_disable_interrupts(gmux_data);
 	if (gmux_data->gpe >= 0) {
-- 
2.39.2

