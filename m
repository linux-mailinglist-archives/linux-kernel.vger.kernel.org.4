Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2136917C3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 05:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbjBJEv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 23:51:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbjBJEve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 23:51:34 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF0477164;
        Thu,  9 Feb 2023 20:51:08 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id s20so2770596pfe.2;
        Thu, 09 Feb 2023 20:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tEls10WodkspsIvZIvxa4LCxo5R1yCy5xPl31tNRCfY=;
        b=AI5OkR5ngOdIYwA82Bd2NHyMJ+O2BLu1AlHUiAUk5u2mES8050ILPnIi34V/HwnVmn
         UCnnl/NNHpnSFBN3X0R580Y09W5YGDjQXorCqi2JWHAwRM3mAVXKAyPB7q7B66d3DoWt
         zBvfn3AmAyRezdi5kNYRSaoRxCZe3u4hC11prURWNE0PK6ZNCw5117fr7UHA3ZhhHI6z
         ua9y3dmza6fdLajFD3iCgQy+ca3vadxm1QgxmG6b53N46lfItM+tP6BzFu/BuB6LbEC1
         2TmnClABN6Fxc12v6c0kbWm8LL7Al2NDRYIr/vhwsP9jpjc8vOPXdePVWan8RRrIxgG1
         ma/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tEls10WodkspsIvZIvxa4LCxo5R1yCy5xPl31tNRCfY=;
        b=lmJb34hiHE2MKpge1IHUKV2tS1XFwb8bxosbiT2J896tS7T4k1U1wPr3Bf+6Lr/v13
         ajnq0VRLQP4Bkjnt4+ZgptsUptt1Uv748xgPMoPuWTonR+N6ntFNtVGXnkhV2NYzG6tf
         UPidFvVoer+ubY3u08cInx1573NX4KheBnSlyM6jgJiBm1EGg5je6X7RR3eAxo1A+lAp
         fSK5ReSVZZQNT6vQCcbY+CUp0bBShk6XhIcTWn2buGbR81l/UQm3oHRRiB4p84og0z4w
         RowDodSQ9l/6YqRtn6g13hXB89guG2iuJn4sJKwbtbLydC9ZisXXEy3om50TohOAUxfM
         abzw==
X-Gm-Message-State: AO0yUKXbl0X9D01G7bu97r1DTU0rHQ4dyvDn3JUm2ZdS5mnQg7UrsrzJ
        e9EM2exKXpZPS8baTKcQsp4LYv9XdxQigg==
X-Google-Smtp-Source: AK7set+I/CPPxHXAhf5qBsL4mcZeaWR1Cid3atIIseLpDh1NtpOroP8ski833jPHpzXBgHHcqOiaLw==
X-Received: by 2002:a62:15d3:0:b0:5a8:4db3:266e with SMTP id 202-20020a6215d3000000b005a84db3266emr3828885pfv.10.1676004667360;
        Thu, 09 Feb 2023 20:51:07 -0800 (PST)
Received: from localhost.localdomain ([202.53.32.211])
        by smtp.gmail.com with ESMTPSA id t13-20020a62ea0d000000b0057fec210d33sm2269218pfh.152.2023.02.09.20.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 20:51:07 -0800 (PST)
From:   Orlando Chamberlain <orlandoch.dev@gmail.com>
To:     platform-driver-x86@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Lijo Lazar <lijo.lazar@amd.com>,
        YiPeng Chai <YiPeng.Chai@amd.com>,
        Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Bokun Zhang <Bokun.Zhang@amd.com>,
        Jack Xiao <Jack.Xiao@amd.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Rander Wang <rander.wang@intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Yong Zhi <yong.zhi@intel.com>, Evan Quan <evan.quan@amd.com>,
        Kerem Karabay <kekrby@gmail.com>,
        Aditya Garg <gargaditya08@live.com>,
        Aun-Ali Zaidi <admin@kodeit.net>,
        Orlando Chamberlain <orlandoch.dev@gmail.com>
Subject: [RFC PATCH 7/9] apple-gmux: add sysfs interface
Date:   Fri, 10 Feb 2023 15:48:24 +1100
Message-Id: <20230210044826.9834-8-orlandoch.dev@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230210044826.9834-1-orlandoch.dev@gmail.com>
References: <20230210044826.9834-1-orlandoch.dev@gmail.com>
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

Allow reading gmux ports from userspace. When the unsafe module
parameter allow_user_writes is true, writing 1 byte
values is also allowed.

For example:

cd /sys/bus/acpi/devices/APP000B:00/physical_node/
echo 4 > gmux_selected_port
cat gmux_selected_port_data | xxd -p

Will show the gmux version information (00000005 in this case)

Signed-off-by: Orlando Chamberlain <orlandoch.dev@gmail.com>
---
 drivers/platform/x86/apple-gmux.c | 129 ++++++++++++++++++++++++++++++
 1 file changed, 129 insertions(+)

diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
index c38d6ef0c15a..756059d48393 100644
--- a/drivers/platform/x86/apple-gmux.c
+++ b/drivers/platform/x86/apple-gmux.c
@@ -66,6 +66,11 @@ struct apple_gmux_data {
 	enum vga_switcheroo_client_id switch_state_external;
 	enum vga_switcheroo_state power_state;
 	struct completion powerchange_done;
+
+#ifdef CONFIG_SYSFS
+	/* sysfs data */
+	int selected_port;
+#endif /* CONFIG_SYSFS */
 };
 
 static struct apple_gmux_data *apple_gmux_data;
@@ -651,6 +656,121 @@ static void gmux_notify_handler(acpi_handle device, u32 value, void *context)
 		complete(&gmux_data->powerchange_done);
 }
 
+/**
+ * DOC: Sysfs Interface
+ *
+ * gmux ports can be read from userspace as a sysfs interface. For example:
+ *
+ * # echo 4 > /sys/bus/acpi/devices/APP000B:00/physical_node/gmux_selected_port
+ * # cat /sys/bus/acpi/devices/APP000B:00/physical_node/gmux_selected_port_data | xxd -p
+ * 00000005
+ *
+ * Reads 4 bytes from port 4 (GMUX_PORT_VERSION_MAJOR).
+ *
+ * Single byte writes are also supported, however this must be enabled with the
+ * unsafe allow_user_writes module parameter.
+ *
+ */
+
+#ifdef CONFIG_SYSFS
+
+static bool allow_user_writes;
+module_param_unsafe(allow_user_writes, bool, 0);
+MODULE_PARM_DESC(allow_user_writes, "Allow userspace to write to gmux ports (default: false) (bool)");
+
+static ssize_t gmux_selected_port_store(struct device *dev,
+		struct device_attribute *attr, const char *sysfsbuf, size_t count)
+{
+	struct apple_gmux_data *gmux_data = dev_get_drvdata(dev);
+	u8 port;
+
+	if (kstrtou8(sysfsbuf, 10, &port) < 0)
+		return -EINVAL;
+
+	/* On pio gmux's, make sure the user doesn't access too high of a port. */
+	if ((gmux_data->config == &apple_gmux_pio) &&
+		port > (gmux_data->iolen - 4))
+		return -EINVAL;
+
+	gmux_data->selected_port = port;
+	return count;
+}
+
+static ssize_t gmux_selected_port_show(struct device *dev,
+		struct device_attribute *attr, char *sysfsbuf)
+{
+	struct apple_gmux_data *gmux_data = dev_get_drvdata(dev);
+
+	return sysfs_emit(sysfsbuf, "%d\n", gmux_data->selected_port);
+}
+
+DEVICE_ATTR_RW(gmux_selected_port);
+
+static ssize_t gmux_selected_port_data_store(struct device *dev,
+		struct device_attribute *attr, const char *sysfsbuf, size_t count)
+{
+	struct apple_gmux_data *gmux_data = dev_get_drvdata(dev);
+
+	if (count == 1)
+		gmux_write8(gmux_data, gmux_data->selected_port, *sysfsbuf);
+	else
+		return -EINVAL;
+
+	return count;
+}
+
+static ssize_t gmux_selected_port_data_show(struct device *dev,
+		struct device_attribute *attr, char *sysfsbuf)
+{
+	struct apple_gmux_data *gmux_data = dev_get_drvdata(dev);
+	u32 data;
+
+	data = gmux_read32(gmux_data, gmux_data->selected_port);
+	memcpy(sysfsbuf, &data, sizeof(data));
+
+	return sizeof(data);
+}
+
+struct device_attribute dev_attr_gmux_selected_port_data_rw = __ATTR_RW(gmux_selected_port_data);
+struct device_attribute dev_attr_gmux_selected_port_data_ro = __ATTR_RO(gmux_selected_port_data);
+
+static int gmux_init_sysfs(struct pnp_dev *pnp)
+{
+	int ret;
+
+	ret = device_create_file(&pnp->dev, &dev_attr_gmux_selected_port);
+	if (ret)
+		return ret;
+	if (allow_user_writes)
+		ret = device_create_file(&pnp->dev, &dev_attr_gmux_selected_port_data_rw);
+	else
+		ret = device_create_file(&pnp->dev, &dev_attr_gmux_selected_port_data_ro);
+	if (ret)
+		device_remove_file(&pnp->dev, &dev_attr_gmux_selected_port);
+	return ret;
+}
+
+static void gmux_fini_sysfs(struct pnp_dev *pnp)
+{
+	device_remove_file(&pnp->dev, &dev_attr_gmux_selected_port);
+	if (allow_user_writes)
+		device_remove_file(&pnp->dev, &dev_attr_gmux_selected_port_data_rw);
+	else
+		device_remove_file(&pnp->dev, &dev_attr_gmux_selected_port_data_ro);
+}
+
+#else
+
+static int gmux_init_sysfs(struct pnp_dev *pnp)
+{
+	return 0;
+}
+static void gmux_fini_sysfs(struct pnp_dev *pnp)
+{
+}
+
+#endif /* CONFIG_SYSFS */
+
 static int gmux_suspend(struct device *dev)
 {
 	struct pnp_dev *pnp = to_pnp_dev(dev);
@@ -846,8 +966,16 @@ static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
 		goto err_register_handler;
 	}
 
+	ret = gmux_init_sysfs(pnp);
+	if (ret) {
+		pr_err("Failed to register gmux sysfs entries\n");
+		goto err_sysfs;
+	}
+
 	return 0;
 
+err_sysfs:
+	vga_switcheroo_unregister_handler();
 err_register_handler:
 	gmux_disable_interrupts(gmux_data);
 	apple_gmux_data = NULL;
@@ -877,6 +1005,7 @@ static void gmux_remove(struct pnp_dev *pnp)
 {
 	struct apple_gmux_data *gmux_data = pnp_get_drvdata(pnp);
 
+	gmux_fini_sysfs(pnp);
 	vga_switcheroo_unregister_handler();
 	gmux_disable_interrupts(gmux_data);
 	if (gmux_data->gpe >= 0) {
-- 
2.39.1

