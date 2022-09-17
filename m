Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 289695BB6F9
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 09:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbiIQHZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 03:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiIQHYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 03:24:12 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E28C44564
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 00:24:05 -0700 (PDT)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220917072359epoutp0308919e70e68337a07a87a6a5024077fc~VlPocIDWb1145111451epoutp03C
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 07:23:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220917072359epoutp0308919e70e68337a07a87a6a5024077fc~VlPocIDWb1145111451epoutp03C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1663399439;
        bh=WT8eilAWkTa8t5HFry4jFn1w86JhqlxqX0PBHLU1jNE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sIUHtDV53RbJw+w9boMVNOXpsGGH1kkmVdP2noOIDmypIyvj563dGHKyGgQnVr/T4
         rMXP+Vl3Xx4Q57fKeoaP79dUPMe9yCS2WLloaP51zxW2LC6SrOEeZqpNhpYd88Y4KB
         N11OMMK4FGw8A/lfkNKiCfqqZ5xuhTCsqmLs0aXw=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20220917072358epcas1p4b275a1decc0c6ca70d4312c6b931014c~VlPn0Eb7d2970529705epcas1p4M;
        Sat, 17 Sep 2022 07:23:58 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.36.136]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4MV2Vj5SNDz4x9Pp; Sat, 17 Sep
        2022 07:23:57 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        3A.6D.64988.D0675236; Sat, 17 Sep 2022 16:23:57 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220917072357epcas1p17b277154f0d020435417450fa0337906~VlPmlEvQD0249402494epcas1p1Q;
        Sat, 17 Sep 2022 07:23:57 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220917072357epsmtrp15ca8750a23a350e31ca9ddba0aec4934~VlPmhcLng0556805568epsmtrp1a;
        Sat, 17 Sep 2022 07:23:57 +0000 (GMT)
X-AuditID: b6c32a39-8d3fa7000001fddc-75-6325760dd1f0
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        11.45.14392.D0675236; Sat, 17 Sep 2022 16:23:57 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.113.58]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220917072356epsmtip22d49e7b22f2e4a27d30a62f82cd2bff9~VlPmNbiKB2857628576epsmtip24;
        Sat, 17 Sep 2022 07:23:56 +0000 (GMT)
From:   Jiho Chu <jiho.chu@samsung.com>
To:     gregkh@linuxfoundation.org, arnd@arndb.de, ogabbay@kernel.org,
        krzysztof.kozlowski@linaro.org, broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, yelini.jeong@samsung.com,
        myungjoo.ham@samsung.com, jiho.chu@samsung.com
Subject: [PATCH v2 01/13] trinity: Add base driver
Date:   Sat, 17 Sep 2022 16:23:44 +0900
Message-Id: <20220917072356.2255620-2-jiho.chu@samsung.com>
In-Reply-To: <20220917072356.2255620-1-jiho.chu@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAJsWRmVeSWpSXmKPExsWy7bCmgS5vmWqywcoFKhZ/Jx1jt5j68Amb
        RfPi9WwW77t3M1vsfb2V3eLyrjlsFrcbV7BZ7Ov5yGjxfNp1FgdOj9+/JjF6bFrVyeZx59oe
        No/9c9ewe/RtWcXo8XmTXABbVLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJC
        XmJuqq2Si0+ArltmDtBVSgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwC0wK94sTc
        4tK8dL281BIrQwMDI1OgwoTsjHdnVrMU7D7OXNExewZbA+PUn0xdjJwcEgImEl939rF1MXJx
        CAnsYJT4vmQyE4TziVFi1edbUJlvjBInn91khmlp7NzNCJHYyyix4ttXVgjnM6PEz5lTGUGq
        2ARUJWbOWMMOYosIlEs0bzwBZjML5Eg8udMENklYwEhi25e/LF2MHBwsQPX/GkNAwrwC1hIb
        l3wEu49TwEbi5qYmFoi4oMTJmU9YIMbISzRvnc0MsldC4Cu7xIYZR9kgrnORaPq7BOo5YYlX
        x7ewQ9hSEi/726DsbIkpHYtYIOwCiXPPtzKD3CAhYCxxcUUKiMksoCmxfpc+RIWixM7fcxkh
        1vJJvPvawwpRzSvR0SYEUaIkseTPYajhEhJTZ3yDOsBDYvnVQyyQ0OlnlGh/eJhpAqP8LCTf
        zELyzSyEzQsYmVcxiqUWFOempxYbFpjCozU5P3cTIzhpalnuYJz+9oPeIUYmDsZDjBIczEoi
        vKqeKslCvCmJlVWpRfnxRaU5qcWHGE2BwTuRWUo0OR+YtvNK4g1NLA1MzIyMTSwMzQyVxHn1
        tBmThQTSE0tSs1NTC1KLYPqYODilGpi4viW6dsvsP/d1XX5Fuvi+MwJOeicWMPqusZ5izbuJ
        8+wvpazPkU75pXzsdz6ds9P56lP3gtuaaYfk0Uftt4TO8G10LHhxc3v6tAfe6U6LTEpXziz9
        P+WVlrBp4PE7r4L43ZLPiTquU3nIPeuF3z0NU46E3xrX2xL4fXf+7Ttxzq35xXn/2WcTFjnP
        i1K88+j6npU9RafEVh2/K7d908NFDtJZnyfe1bbMtuldnJoxo1VFmntF3vLu+s6nPl63RXUb
        Z9zfxmrfzDdR42ui3z8Tn5frdp4/fPXKpNrHMv0dYUdtVQ/sVv7msu6hbfjm63OEjxxcx8Y1
        sz9h2uJVU/6+PaG13Ku56ajii/f69xfLKrEUZyQaajEXFScCAHuFzYkjBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFLMWRmVeSWpSXmKPExsWy7bCSvC5vmWqywfEv7BZ/Jx1jt5j68Amb
        RfPi9WwW77t3M1vsfb2V3eLyrjlsFrcbV7BZ7Ov5yGjxfNp1FgdOj9+/JjF6bFrVyeZx59oe
        No/9c9ewe/RtWcXo8XmTXABbFJdNSmpOZllqkb5dAlfGuzOrWQp2H2eu6Jg9g62BcepPpi5G
        Tg4JAROJxs7djF2MXBxCArsZJX7O6maDSEhIbLq3nLmLkQPIFpY4fLgYouYjo0Rj022wGjYB
        VYmZM9awg9giArUSB4/OZwaxmQUKJGY/nckCYgsLGEls+/KXBWQOC1D9v8YQkDCvgLXExiUf
        wW7gFLCRuLmpCaxcCCg+e/pcJogaQYmTM5+wQIyUl2jeOpt5AiP/LCSpWUhSCxiZVjFKphYU
        56bnFhsWGOallusVJ+YWl+al6yXn525iBAe3luYOxu2rPugdYmTiYDzEKMHBrCTCq+qpkizE
        m5JYWZValB9fVJqTWnyIUZqDRUmc90LXyXghgfTEktTs1NSC1CKYLBMHp1QDU252auEm9u19
        y1Z1W5xdJSZXw++b8OSjakXUtSVvLr7QflXK7rg5bMGDe+HuPOZL5VcULkkPebH00UYfPoNE
        0+Kov7N91cVfsdQ8l1Pd+uHxonw7GxPtlYUM/64+e2f/pXEhzz2F42wl6t2bDx7/8dTq2dLt
        my8Ecp74XC/owrVx7Z+3O67wJT3kePM2TG1vzMNJUrevvfPInyki+k/C4s7F97Nl7bc/1l3A
        ZvqBP31REmP+90uyFW65NQyurelPs7avOb/xsoPBi3rBNo6MfRY/v5/bfj59282jt09L3/Fs
        Zl3Gpiioo9eZX5fF5Rb0jfOA/3q/w1LzDPfekf4WmF73/VNH1NZQhqd6pvxPw5RYijMSDbWY
        i4oTAU2EVbrdAgAA
X-CMS-MailID: 20220917072357epcas1p17b277154f0d020435417450fa0337906
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220917072357epcas1p17b277154f0d020435417450fa0337906
References: <20220917072356.2255620-1-jiho.chu@samsung.com>
        <CGME20220917072357epcas1p17b277154f0d020435417450fa0337906@epcas1p1.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It contains the base codes for trinity driver. Minimal codes to load and
probe device is provided. The Trinity Family is controlled by the
Memory-Mapped Registers, the register addresses and offsets are
described. And user api interfaces are presented to control device under
ioctl manner.

Signed-off-by: Jiho Chu <jiho.chu@samsung.com>
Signed-off-by: yelini-jeong <yelini.jeong@samsung.com>
Signed-off-by: Dongju Chae <dongju.chae@samsung.com>
Signed-off-by: Parichay Kapoor <pk.kapoor@samsung.com>
Signed-off-by: Wook Song <wook16.song@samsung.com>
Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
---
 drivers/misc/Kconfig                        |   1 +
 drivers/misc/Makefile                       |   1 +
 drivers/misc/trinity/Kconfig                |  25 +
 drivers/misc/trinity/Makefile               |   7 +
 drivers/misc/trinity/trinity.c              | 225 +++++++++
 drivers/misc/trinity/trinity_common.h       | 437 ++++++++++++++++++
 drivers/misc/trinity/trinity_vision2_drv.c  | 278 ++++++++++++
 drivers/misc/trinity/trinity_vision2_regs.h | 210 +++++++++
 include/uapi/misc/trinity.h                 | 476 ++++++++++++++++++++
 9 files changed, 1660 insertions(+)
 create mode 100644 drivers/misc/trinity/Kconfig
 create mode 100644 drivers/misc/trinity/Makefile
 create mode 100644 drivers/misc/trinity/trinity.c
 create mode 100644 drivers/misc/trinity/trinity_common.h
 create mode 100644 drivers/misc/trinity/trinity_vision2_drv.c
 create mode 100644 drivers/misc/trinity/trinity_vision2_regs.h
 create mode 100644 include/uapi/misc/trinity.h

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 41d2bb0ae23a..ad0d5f6af291 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -500,4 +500,5 @@ source "drivers/misc/cardreader/Kconfig"
 source "drivers/misc/habanalabs/Kconfig"
 source "drivers/misc/uacce/Kconfig"
 source "drivers/misc/pvpanic/Kconfig"
+source "drivers/misc/trinity/Kconfig"
 endmenu
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 70e800e9127f..c63f3fc89780 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -60,3 +60,4 @@ obj-$(CONFIG_XILINX_SDFEC)	+= xilinx_sdfec.o
 obj-$(CONFIG_HISI_HIKEY_USB)	+= hisi_hikey_usb.o
 obj-$(CONFIG_HI6421V600_IRQ)	+= hi6421v600-irq.o
 obj-$(CONFIG_OPEN_DICE)		+= open-dice.o
+obj-$(CONFIG_TRINITY)		+= trinity/
diff --git a/drivers/misc/trinity/Kconfig b/drivers/misc/trinity/Kconfig
new file mode 100644
index 000000000000..02ad03c2ca0e
--- /dev/null
+++ b/drivers/misc/trinity/Kconfig
@@ -0,0 +1,25 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config TRINITY
+	bool "Samsung Neural Processing Unit"
+	depends on HAS_IOMEM
+	depends on HAS_DMA
+	help
+	  Select this option to enable driver support for Samsung
+	  Neural Processing Unit (NPU).
+
+	  This driver works as a base driver of the other drivers
+	  for Trinity device family.
+
+	  This option should be enabled to support Trinity
+	  Vision 2 (TRIV2), and Trinity Audio (TRIA).
+
+config TRINITY_VISION2
+	tristate "Samsung NPU Trinity Vision 2"
+	depends on TRINITY
+	help
+	  Select this option to enable driver support for a Samsung
+	  Neural Processing Unit (NPU), Trinity Vision 2.
+
+	  This driver enables userspace system library to access the
+	  device via /dev/triv2-N.
diff --git a/drivers/misc/trinity/Makefile b/drivers/misc/trinity/Makefile
new file mode 100644
index 000000000000..a8e5697d6d85
--- /dev/null
+++ b/drivers/misc/trinity/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_TRINITY_VISION2) += trinity_vision2.o
+
+trinity-y := trinity.o
+
+trinity_vision2-objs := $(trinity-y) trinity_vision2_drv.o
diff --git a/drivers/misc/trinity/trinity.c b/drivers/misc/trinity/trinity.c
new file mode 100644
index 000000000000..1704eecfc439
--- /dev/null
+++ b/drivers/misc/trinity/trinity.c
@@ -0,0 +1,225 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Base device driver for Samsung NPU Trinity device family
+ *
+ * Copyright (C) 2020-2022 Samsung Electronics
+ * Copyright (C) 2020 Dongju Chae <dongju.chae@samsung.com>
+ * Copyright (C) 2020 Wook Song <wook16.song@samsung.com>
+ * Copyright (C) 2022 MyungJoo Ham <myungjoo.ham@samsung.com>
+ * Copyright (C) 2022 Yelin Jeong <yelini.jeong@samsung.com>
+ * Copyright (C) 2022 Jiho Chu <jiho.chu@samsung.com>
+ */
+
+#include <linux/of_address.h>
+
+#include "trinity_common.h"
+
+#define TRINITY_PADDR_BASE (0x0)
+
+static DEFINE_IDA(dev_nrs);
+static DEFINE_IDA(model_ids);
+
+/**
+ * trinity_release() - A common callback for close() in file_operations for a
+ *		Trinity	device node. If there are device-specific data to be
+ *		cleaned-up, it is required to clean them up before invoke this
+ *		callback.
+ *
+ * @inode: Inode to be closed
+ * @file: File to be closed
+ *
+ * Returns 0 on success. Otherwise, returns negative error.
+ */
+int trinity_release(struct inode *inode, struct file *file)
+{
+	return 0;
+}
+
+/**
+ * trinity_open() - A common callback for open() in file_operations for a Trinity
+ *		device node. If device-specific open() is required, this
+ *		callback should be invoked by that open().
+ *
+ * @inode: inode to be opened
+ * @f: file to be opened
+ *
+ * Returns 0 on success. Otherwise, returns negative error.
+ */
+int trinity_open(struct inode *inode, struct file *f)
+{
+	struct miscdevice *miscdev;
+	struct trinity_driver *drv;
+
+	miscdev = f->private_data;
+	drv = container_of(miscdev, struct trinity_driver, mdev);
+	f->private_data = drv;
+
+	return 0;
+}
+
+/**
+ * trinity_create_node() - Create trinity node
+ *
+ * @drv: an instance of trinity driver
+ *
+ * Returns 0 on success. Otherwise, returns negative error.
+ */
+int trinity_create_node(struct trinity_driver *drv)
+{
+	struct device *dev = drv_to_dev_ptr(drv);
+	int err;
+
+	/** register as a misc device */
+	drv->mdev.minor = MISC_DYNAMIC_MINOR;
+	drv->mdev.parent = dev;
+	drv->mdev.name = drv->name;
+	drv->mdev.fops = drv->desc->fops;
+
+	err = misc_register(&drv->mdev);
+	if (err < 0)
+		dev_err(dev, "failed to register as a misc device");
+
+	return err;
+}
+
+/**
+ * trinity_destroy_node() - Destroy trinity node
+ *
+ * @drv: an instance of trinity driver
+ */
+void trinity_destroy_node(struct trinity_driver *drv)
+{
+	misc_deregister(&drv->mdev);
+}
+
+/**
+ * trinity_probe() - Probes a new Trinity device. This is a standard interface to
+ * probe a Trinity family device.
+ *
+ * @pdev: Platform device structure to probe
+ * @desc: Device description to probe
+ *
+ * Returns 0 on success. Otherwise, returns negative error.
+ */
+int trinity_probe(struct platform_device *pdev, const struct trinity_desc *desc)
+{
+	struct device_node *np;
+	struct device *dev;
+	struct trinity_driver *drv;
+	int i, err;
+
+	dev = &pdev->dev;
+	dev->id = ((desc->ver & TRINITY_MASK_DEV) >> TRINITY_SHIFT_DEV);
+
+	/* set private data */
+	drv = devm_kzalloc(dev, sizeof(*drv), GFP_KERNEL);
+	if (!drv)
+		return -ENOMEM;
+
+	drv->dev_id = ida_alloc(&dev_nrs, GFP_KERNEL);
+	if (drv->dev_id < 0) {
+		devm_kfree(dev, drv);
+		return drv->dev_id;
+	}
+	snprintf(drv->name, DEV_NAME_LEN, "%s-%u", desc->type, drv->dev_id);
+
+	platform_set_drvdata(pdev, drv);
+	dev_set_drvdata(dev, drv);
+
+	drv->dev = dev;
+	drv->desc = desc;
+
+	np = dev->of_node;
+	if (of_property_match_string(np, "samsung,trinity-type", desc->type)) {
+		err = -EPROBE_DEFER;
+		goto err_cleanup;
+	}
+
+	/* get reg info for MMREG_BASE */
+	for (i = 0; i < TRINITY_MAX_MMREGS; i++) {
+		struct resource mmreg;
+
+		err = of_address_to_resource(np, i, &mmreg);
+		if (err < 0) {
+			dev_err(dev, "failed to get %d-th mmreg info", i);
+			goto err_cleanup;
+		}
+
+		drv->mmreg_vaddr[i] = devm_ioremap_resource(dev, &mmreg);
+		if (IS_ERR(drv->mmreg_vaddr[i])) {
+			dev_err(dev,
+				"failed to remap %d-th mmreg resource info", i);
+			err = PTR_ERR(drv->mmreg_vaddr[i]);
+			goto err_cleanup;
+		}
+		drv->mmreg_paddr[i] = mmreg.start;
+	}
+
+	/** get a TOPS property */
+	err = of_property_read_u32(np, "samsung,tops", &drv->tops);
+	if (err < 0) {
+		dev_err(dev, "failed to read 'tops' property: %d\n", err);
+		goto err_cleanup;
+	}
+
+	/** get a DSPM property */
+	err = of_property_read_u32(np, "samsung,dspm", &drv->dspm);
+	if (err < 0) {
+		dev_warn(dev, "Setting the size of DPSM to 0\n");
+		drv->dspm = 0;
+	}
+
+	/* Set IRQ handlers */
+	drv->irq = platform_get_irq(pdev, 0);
+	if (drv->irq < 0) {
+		dev_err(dev, "IRQ is not supported");
+		err = drv->irq;
+		goto err_cleanup;
+	}
+
+	/* get the IRQ number from DT and set handlers for it */
+	err = devm_request_irq(dev, drv->irq, desc->handle_irq,
+			       IRQF_TRIGGER_HIGH, desc->type, &drv->mdev);
+	if (err < 0) {
+		dev_err(dev, "failed to register handlers for IRQ %d", drv->irq);
+		goto err_cleanup;
+	}
+
+	/** Initialize device-specific variables */
+	init_completion(&drv->complete);
+	mutex_init(&drv->lock);
+	INIT_WORK(&drv->work_stop, desc->stop_reqs);
+
+	return 0;
+
+err_cleanup_common:
+	devm_free_irq(dev, drv->irq, &drv->mdev);
+
+err_cleanup:
+	ida_free(&dev_nrs, drv->dev_id);
+	devm_kfree(dev, drv);
+
+	return err;
+}
+
+/**
+ * trinity_remove() - Cleans up the device driver. This is a standard interface to
+ * remove a Trinity family device.
+ *
+ * @pdev: Platform device structure to probe
+ * @desc: Device description to probe
+ *
+ * Always returns 0.
+ */
+int trinity_remove(struct platform_device *pdev,
+		   const struct trinity_desc *desc)
+{
+	struct trinity_driver *drv = platform_get_drvdata(pdev);
+	struct device *dev = drv_to_dev_ptr(drv);
+
+	ida_free(&dev_nrs, drv->dev_id);
+	devm_free_irq(dev, drv->irq, &drv->mdev);
+	devm_kfree(dev, drv);
+
+	return 0;
+}
diff --git a/drivers/misc/trinity/trinity_common.h b/drivers/misc/trinity/trinity_common.h
new file mode 100644
index 000000000000..f35d964ab387
--- /dev/null
+++ b/drivers/misc/trinity/trinity_common.h
@@ -0,0 +1,437 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/**
+ * Common header for trinity devices
+ *
+ * Copyright (C) 2020-2022 Samsung Electronics
+ * Copyright (C) 2020 Wook Song <wook16.song@samsung.com>
+ * Copyright (C) 2020 Parichay Kapoor <pk.kapoor@samsung.com>
+ * Copyright (C) 2020 Dongju Chae <dongju.chae@samsung.com>
+ * Copyright (C) 2022 MyungJoo Ham <myungjoo.ham@samsung.com>
+ * Copyright (C) 2022 Yelin Jeong <yelini.jeong@samsung.com>
+ * Copyright (C) 2022 Jiho Chu <jiho.chu@samsung.com>
+ */
+
+#ifndef __DRIVERS_MISC_TRINITY_COMMON_H__
+#define __DRIVERS_MISC_TRINITY_COMMON_H__
+
+#include <linux/errno.h>
+#include <linux/idr.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/iommu.h>
+#include <linux/irqreturn.h>
+#include <linux/kernel.h>
+#include <linux/list_bl.h>
+#include <linux/miscdevice.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <uapi/misc/trinity.h>
+
+#include "trinity_dma.h"
+#include "trinity_hwmem.h"
+
+#define DEV_NAME_LEN (16)
+
+/** Default timeout to wait for opening device in jiffies */
+#define TRINITY_DEV_TIMEOUT_MSEC (3000)
+#define TRINITY_DEV_TIMEOUT (msecs_to_jiffies(TRINITY_DEV_TIMEOUT_MSEC))
+
+/** Default timeout to wait for running input in jiffies */
+#define TRINITY_RUN_TIMEOUT_MSEC (4000)
+#define TRINITY_RUN_TIMEOUT (msecs_to_jiffies(TRINITY_RUN_TIMEOUT_MSEC))
+
+#define TRINITY_DEV_TYPE_LEN (16)
+#define TRINITY_DEV_EACH_MAX (2)
+#define TRINITY_MAX_MMREGS (3)
+
+/** A helper function to generate the version code of the device driver */
+#define GENVER(dev, mj, mn, ex)                                         \
+	((dev << TRINITY_SHIFT_DEV) | (mj << TRINITY_SHIFT_MAJOR_VER) | \
+	 (mn << TRINITY_SHIFT_MINOR_VER) | (ex << TRINITY_SHIFT_EXTRA_VER))
+
+#define IDU_LOADED(drv) (drv->idu_set)
+
+#define trinity_get_iomem_addr(base, offset) (base + offset)
+#define drv_to_dev_ptr(d) (d->dev)
+#define drv_to_priv(drv) (drv->desc->pdata)
+
+#define TRINITY_STAT_HASH_BITS (10)
+#define TRINITY_STAT_HASH_SIZE (1 << TRINITY_STAT_HASH_BITS)
+
+#define TRINITY_MODEL_HASH_BITS (10)
+#define TRINITY_MODEL_HASH_SIZE (1 << TRINITY_MODEL_HASH_BITS)
+
+#define TIME_DIFF(t1, t2) ktime_to_ms(ktime_sub(t1, t2))
+#define TIME_DIFF_US(t1, t2) ktime_to_us(ktime_sub(t1, t2))
+
+struct trinity_desc;
+struct trinity_driver;
+struct trinity_req;
+struct trinity_stat;
+struct trinity_stat_app;
+struct trinity_stat_req;
+struct trinity_model_htable;
+struct trinity_idu;
+
+/**
+ * struct trinity_desc - a structure for device description
+ *
+ * @type: A string that indicates the type of this device.
+ * @ver: Coded version information generated via GENVER().
+ * @fops: Device-specific file_operations.
+ *
+ * @reset: reset trinity function
+ * @prepare_req: request configuration function before invoking
+ *    trinity_submit_req() (if any). This requires a registered model
+ *    to the driver.
+ * @handle_timeout: This function is invoked when the request is time-out
+ * @stop_reqs: stops current working request
+ * @drain_reqs: waits currently working requests finishes.
+ * @init_profile: initialize profile configuration
+ * @check_profile: check current profile data
+ * @get_profile_meta: get profile metadata for the target request
+ * @get_profile_buff: get profile data buffer for the target request
+ * @get_profile: get profile data
+ * @destroy_profile: destroy profile resources
+ *
+ * @idu_set: set IDU binary
+ * @idu_unset: unset IDU binary
+ * @idu_version: get IDU version info
+ * @get_state: get current state of IDU
+ * @set_state: set IDU state
+ * @alloc_req: allocate request new trinity request
+ * @dealloc_req: release request resource
+ * @invoke_req: prepare to run request and sent it to scheduler
+ *
+ * @handle_irq: Device-specific IRQ handler.
+ */
+struct trinity_desc {
+	char *type;
+	uint32_t ver;
+
+	const struct file_operations *fops;
+
+	/* Optional */
+	void (*reset)(struct trinity_driver *drv);
+	int32_t (*prepare_req)(struct trinity_driver *drv,
+			       struct trinity_req *req);
+	void (*handle_timeout)(struct trinity_driver *drv,
+			       struct trinity_req *req);
+	void (*stop_reqs)(struct work_struct *work);
+	void (*drain_reqs)(struct trinity_driver *drv);
+	void (*init_profile)(struct trinity_driver *drv,
+			     unsigned long profile_size);
+	int32_t (*check_profile)(struct trinity_driver *drv,
+				 struct trinity_req *req);
+	int32_t (*get_profile_meta)(const struct trinity_driver *drv,
+				    struct trinity_ioctl_profile_meta *meta);
+	int32_t (*get_profile_buff)(const struct trinity_driver *drv,
+				    struct trinity_ioctl_profile_buff *buff);
+	ssize_t (*get_profile)(const struct trinity_driver *drv, char *buf, int req_id);
+	void (*destroy_profile)(const struct trinity_driver *drv, void *data);
+
+	/* Mandatory */
+	int32_t (*idu_set)(struct trinity_driver *drv, struct trinity_ioctl_idu *idu);
+	void (*idu_unset)(struct trinity_driver *drv);
+	int32_t (*idu_version)(struct trinity_driver *drv, uint32_t *major,
+			       uint32_t *minor, uint32_t *extra);
+	int32_t (*get_state)(const struct trinity_driver *drv);
+	void (*set_state)(const struct trinity_driver *drv,
+			  enum trinity_state state);
+	struct trinity_req *(*alloc_req)(struct trinity_driver *drv);
+	void (*dealloc_req)(struct trinity_driver *drv,
+			    struct trinity_req *req);
+	int32_t (*invoke_req)(struct trinity_driver *drv,
+			      struct trinity_req *req, void *sched_data);
+	irq_handler_t handle_irq;
+};
+
+/**
+ * struct trinity_stat - A structure for representing a device's statistics.
+ *
+ * @lock: stat lock
+ * @hlist_bl_head: stat hash list heads
+ * @list: list head
+ * @pdata: private data
+ */
+struct trinity_stat {
+	spinlock_t lock;
+
+	struct hlist_bl_head hlist[TRINITY_STAT_HASH_SIZE];
+	struct list_head list;
+
+	void *pdata;
+};
+
+/**
+ * struct trinity_stat_app - a structure for representing statistics for each app
+ * @app_id: identifier for each app
+ * @name: name of stat
+ * @status: app status
+ * @parent: parent node
+ * @total_alloc_mem: total allocated memory size
+ * @total_free_mem: total freed memory size
+ * @list_head reqs: list of request
+ * @num_total_reqs: a number of total requests
+ * @num_kept_reqs: a number of kept requests
+ * @num_active_reqs: a number of active requests
+ * @hnode: hash node
+ * @lnode: list node
+ */
+struct trinity_stat_app {
+	int32_t app_id; /* app identifier */
+	char name[TASK_COMM_LEN];
+	enum trinity_app_status status;
+
+	struct trinity_stat *parent;
+
+	uint64_t total_alloc_mem; /* total allocated memory */
+	uint64_t total_freed_mem; /* total freed memory */
+
+	struct list_head reqs;
+	uint32_t num_total_reqs;
+	uint32_t num_kept_reqs;
+	uint32_t num_active_reqs;
+
+	struct hlist_bl_node hnode; /* hash node */
+	struct list_head lnode; /* list node */
+
+	unsigned long slot;
+};
+
+/**
+ * struct trinity_stat_req - A structure for representing statistics for each request
+ * @status: request status
+ * @priority: priority of request
+ * @parent: parent node
+ * @req_id: app identifier
+ * @req_id: request identifier
+ * @model_id: model identifier
+ * @is_kernel: requested from other kernel module
+ * @submitted: submitted time (i.e., when request is submitted to global queue)
+ * @scheduled: scheduled time (i.e., when request is scheduled to device)
+ * @completed: completed time (i.e., when output notification arrives)
+ * @num_runs: total number of runs
+ * @total_time: total execute time
+ * @prev_time: previous execute time
+ * @prev_cycles: previous execute cycles
+ * @list: list node managed by trinity_stat_app
+ * @profile: profile data
+ * @slot: request slot
+ */
+struct trinity_stat_req {
+	enum trinity_req_status status; /* status of submit result */
+	enum trinity_req_priority priority;
+
+	struct trinity_stat_app *parent;
+
+	int32_t app_id;
+	int32_t req_id;
+	uint64_t model_id;
+
+	bool is_kernel;
+
+	ktime_t submitted;
+	ktime_t scheduled;
+	ktime_t completed;
+
+	uint32_t num_runs;
+	uint32_t total_time;
+
+	uint32_t prev_time;
+	uint32_t prev_cycles;
+
+	struct list_head list;
+	void *profile;
+
+	unsigned long slot;
+};
+
+/**
+ * struct trinity_driver - A private data structure for Trinity device driver
+ * @desc: A pointer to the device description
+ * @name: The id-annotated name of the device
+ * @pdata: private data
+ * #dev_id: device id
+ * @mdev: A copy of &struct misc device to which the device is registered.
+ * @dev: A pointer to &struct device of the device.
+ * @complete: A &struct completion variable to maintain events from the device.
+ * @lock: A lock for access control to driver-level static variables
+ * @irq: acquired IRQ number used for complete event
+ * @glboal_req_id: a request id to generate id for each request
+ * @active_reqs: a number of active requests
+ * @mmreg_vaddr: The iomapped base address of memory-mapped registers
+ * @mmreg_paddr: The physical base address of memory-mapped registers
+ * @idu_set: IDU binary is set
+ * @work_stop: handle stop request
+ * @tops: Tera Operations Per Second (TOPS) of this device
+ * @dspm: The size of Data Scratch-Pad Memory (DSPM) in the DSP
+ * @stat: statistics information
+ * @debugfs_pdata: debugfs private data
+ * @sched_pdata: NPU scheduler private data
+ * @model_htable: model hash table
+ * @profile_req_id: sysfs requested profile id for show_profile
+ */
+struct trinity_driver {
+	const struct trinity_desc *desc;
+	char name[DEV_NAME_LEN];
+	void *pdata;
+
+	uint32_t dev_id;
+	struct miscdevice mdev;
+	struct device *dev;
+	struct completion complete;
+	struct mutex lock;
+	int irq;
+
+	atomic_t global_req_id;
+	atomic_t active_reqs;
+
+	void __iomem *mmreg_vaddr[TRINITY_MAX_MMREGS];
+	phys_addr_t mmreg_paddr[TRINITY_MAX_MMREGS];
+
+	bool idu_set;
+
+	struct work_struct work_stop;
+
+	uint32_t tops;
+	uint32_t dspm;
+
+	struct trinity_stat stat;
+	void *debugfs_pdata;
+	void *sched_pdata;
+
+	struct hlist_bl_head model_htable[TRINITY_MODEL_HASH_SIZE];
+
+	/* sysfs info */
+	int profile_req_id;
+};
+
+/**
+ * struct trinity_model - A structure for representing model data
+ * @config: model configuration
+ * @import_info: Cached hwmem import info.
+ * @hnode: hash node for indexing
+ * @owner_id: Identifier for owner app
+ * @refcnt: reference count
+ */
+struct trinity_model {
+	struct trinity_ioctl_model config;
+	struct trinity_hwmem_import import_info;
+	struct hlist_bl_node hnode;
+	int32_t owner_id;
+	struct kref refcnt;
+} __packed;
+
+/**
+ * struct trinity_input - A structure for representing input data
+ * @config: input configuration
+ * @import_info: Cached hwmem import info.
+ */
+struct trinity_input {
+	struct trinity_ioctl_input config;
+	struct trinity_hwmem_import import_info;
+} __packed;
+
+/**
+ * struct trinity_req - A structure for representing a request
+ * @drv: An instance of the driver.
+ * @input: Information of the input configuration to be run by this request
+ * @model: model information to be used for this request
+ * @status: Status of the submitted request
+ * @submit_retry: retry count of submit request
+ * @complete: completion information
+ * @llist: llist node for request queue
+ * @time_started: started time
+ * @is_kernel: requested from kernel module
+ * @scheduled: scheduled flag
+ * @priv: A handle of private data
+ * @note: The allocated 'trinity_req' is shared with ioctl, scheduler
+ *        and interrupt handler routines. After invoking an NPU request,
+ *        the irq handler can make complete the request at anytime, and it
+ *        causes deallocation of the struct.
+ */
+struct trinity_req {
+	/** context where the req belongs */
+	struct trinity_driver *drv;
+
+	struct trinity_input input; /* the req's input argument */
+	struct trinity_model *model;
+
+	struct trinity_stat_req *stat;
+
+	uint64_t submit_retry;
+	struct completion complete;
+	struct llist_node llist;
+
+	ktime_t time_started;
+	bool is_kernel;
+
+	bool scheduled;
+	bool timeout;
+
+	void *priv;
+};
+
+static inline void trinity_set_bit(uint32_t bit, void __iomem *addr)
+{
+	uint32_t reg = 0;
+
+	reg |= bit;
+	iowrite32(reg, addr);
+}
+
+/**
+ * trinity_get_app_id() - Get a app_id for the current opened device
+ *
+ * Returns app_id (just returns its tgid for now).
+ */
+static inline int32_t trinity_get_app_id(void)
+{
+	return task_tgid_vnr(current);
+}
+
+/*
+ * Trinity common functions
+ */
+int trinity_create_node(struct trinity_driver *drv);
+void trinity_destroy_node(struct trinity_driver *drv);
+int trinity_set_pause(struct trinity_driver *drv);
+int trinity_wait_ready(struct trinity_driver *drv);
+void trinity_init_model_htable(const struct trinity_driver *drv,
+			       struct trinity_model_htable *ht);
+int32_t trinity_get_app_id(void);
+phys_addr_t trinity_get_paddr(struct iommu_domain *domain, dma_addr_t daddr);
+
+/* File operations */
+int trinity_open(struct inode *inode, struct file *f);
+int trinity_release(struct inode *inode, struct file *f);
+long trinity_ioctl(struct file *f, unsigned int cmd, unsigned long arg);
+
+/* Device probing and removing */
+int trinity_probe(struct platform_device *pdev,
+		  const struct trinity_desc *desc);
+int trinity_remove(struct platform_device *pdev,
+		   const struct trinity_desc *desc);
+
+/* sysfs operations */
+int trinity_sysfs_init(struct trinity_driver *drv);
+int trinity_sysfs_cleanup(struct trinity_driver *drv);
+
+/* debugfs operations */
+int trinity_debug_init(void);
+void trinity_debug_exit(void);
+int trinity_debug_add(struct trinity_driver *drv);
+void trinity_debug_remove(struct trinity_driver *drv);
+void trinity_debug_clear(struct trinity_driver *drv, unsigned long msg_max);
+unsigned long trinity_debug_get_max(struct trinity_driver *drv);
+void trinity_debug_dump_msg(struct trinity_driver *drv, const char *fmt, ...);
+void trinity_debug_dump_model(struct trinity_driver *drv,
+			      const struct trinity_model *model,
+			      const char *fmt, ...);
+void trinity_debug_dump_input(struct trinity_driver *drv,
+			      const struct trinity_input *input,
+			      const char *fmt, ...);
+
+#endif /* __DRIVERS_MISC_TRINITY_COMMON_H__ */
diff --git a/drivers/misc/trinity/trinity_vision2_drv.c b/drivers/misc/trinity/trinity_vision2_drv.c
new file mode 100644
index 000000000000..bc43cafa39fb
--- /dev/null
+++ b/drivers/misc/trinity/trinity_vision2_drv.c
@@ -0,0 +1,278 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/**
+ * Samsung NPU Trinity Vision 2 driver
+ *
+ * Copyright (C) 2020-2022 Samsung Electronics
+ * Copyright (C) 2020 Wook Song <wook16.song@samsung.com>
+ * Copyright (C) 2020 Dongju Chae <dongju.chae@samsung.com>
+ * Copyright (C) 2022 MyungJoo Ham <myungjoo.ham@samsung.com>
+ * Copyright (C) 2022 Yelin Jeong <yelini.jeong@samsung.com>
+ * Copyright (C) 2022 Jiho Chu <jiho.chu@samsung.com>
+ */
+
+#include <linux/delay.h>
+#include <linux/hashtable.h>
+#include <linux/of_device.h>
+#include <linux/utsname.h>
+
+#include "trinity_common.h"
+#include "trinity_vision2_regs.h"
+
+#define TRIV2_DRV_GET_PDATA(drv) ((struct triv2_pdata *)(drv->pdata))
+#define TRIV2_DRV_GET_CMD_INFO(drv) (&(TRIV2_DRV_GET_PDATA(drv)->cmd_info))
+#define TRIV2_DRV_GET_CMD_BUF(drv) (&(TRIV2_DRV_GET_CMD_INFO(drv)->buf))
+#define TRIV2_DRV_GET_PROF_BUF(drv) (&(TRIV2_DRV_GET_PDATA(drv)->prof_buf))
+#define TRIV2_DRV_GET_BACK_BUF(drv) (&(TRIV2_DRV_GET_PDATA(drv)->back_buf))
+
+#define TRIV2_GET_CMD_FROM_SLOT(info, slot)     \
+	((struct triv2_cmd *)(info->buf.addr + \
+			      slot * sizeof(struct triv2_cmd)))
+
+#define TRIV2_GET_REQ(req) (container_of(req, struct triv2_req, req))
+
+#define HALF_PAGE_SIZE (PAGE_SIZE >> 1)
+
+enum triv2_cmd_status {
+	STATUS_CMD_NONE = 0,
+	STATUS_CMD_READY = 1,
+	STATUS_CMD_DONE = 2,
+};
+
+/** req command for triv2 */
+struct triv2_cmd {
+	union {
+		struct {
+			uint32_t slot;
+			uint32_t prog_addr;
+			uint32_t prog_size;
+			uint32_t segt_addr;
+			uint32_t num_visa;
+
+			uint32_t priority;
+			uint32_t status;
+			uint32_t input_mode;
+			uint32_t output_mode;
+
+			/** for profiling */
+			uint32_t profile_offset;
+
+			/** for preemptive scheduling */
+			uint32_t program_position;
+
+			/** for batch processing */
+			uint32_t batch_size;
+			uint32_t curr_cnt;
+			uint32_t in_addr[TRIV2_MAX_BATCH_SIZE];
+			uint32_t out_addr[TRIV2_MAX_BATCH_SIZE];
+			uint32_t poll_addr;
+			uint32_t poll_magic;
+			/* deprecated but keep for backward compatibiltiy */
+			uint32_t in_seg_idx;
+			uint32_t out_seg_idx;
+
+			uint32_t total_cycles;
+
+			/* kernel requests */
+			uint32_t in_extern_seg_num;
+			uint32_t out_extern_seg_num;
+			uint32_t in_extern_seg_idx[TRIV2_MAX_TENSORS];
+			uint32_t out_extern_seg_idx[TRIV2_MAX_TENSORS];
+		};
+		uint8_t reserved[TRIV2_MAX_CMD_SIZE];
+	};
+} __packed;
+
+struct triv2_cmd_info {
+	DECLARE_BITMAP(bitmap, TRIV2_MAX_CMDSLOTS);
+	spinlock_t lock;
+
+	struct triv2_req *reqs[TRIV2_MAX_CMDSLOTS];
+	struct triv2_cmd cur_cmd;
+};
+
+struct triv2_hashed_cmd_info {
+	struct trinity_driver *drv;
+	struct hlist_bl_node hnode;
+	struct triv2_req *req;
+	struct triv2_cmd *cmd;
+};
+
+struct triv2_kernel_req {
+	uint32_t in_seg_idx[TRIV2_MAX_TENSORS];
+	uint32_t in_seg_size[TRIV2_MAX_TENSORS];
+	uint32_t out_seg_idx[TRIV2_MAX_TENSORS];
+	uint32_t out_seg_size[TRIV2_MAX_TENSORS];
+};
+
+struct triv2_req {
+	struct trinity_req req;
+
+	int cmd_slot;
+
+	/** kernel requets */
+	struct triv2_kernel_req *kernel;
+
+	/** profiling */
+	uint32_t profile_offset;
+	uint32_t total_cycles;
+
+	/** misc */
+	uint32_t total_segment_size;
+};
+
+struct triv2_pdata {
+	struct trinity_driver *drv;
+
+	/* command info */
+	struct triv2_cmd_info cmd_info;
+};
+
+static void triv2_reset(struct trinity_driver *drv)
+{
+	struct triv2_pdata *pdata = drv->pdata;
+
+	mutex_lock(&pdata->drv->lock);
+
+	triv2_cancel_reqs(pdata->drv);
+	msleep(100);
+
+	mutex_unlock(&pdata->drv->lock);
+}
+
+static int triv2_open(struct inode *inode, struct file *f)
+{
+	int ret;
+
+	ret = trinity_open(inode, f);
+
+	return ret;
+}
+
+static int triv2_release(struct inode *inode, struct file *f)
+{
+	int ret;
+
+	ret = trinity_release(inode, f);
+
+	return ret;
+}
+
+static const struct file_operations triv2_fops = {
+	.owner = THIS_MODULE,
+	.open = triv2_open,
+	.release = triv2_release,
+	.llseek = noop_llseek,
+};
+
+static int32_t triv2_init_pdata(struct trinity_driver *drv)
+{
+	struct triv2_pdata *pdata;
+	struct triv2_cmd_info *cmd_info;
+
+	pdata = kzalloc(sizeof(struct triv2_pdata), GFP_KERNEL);
+	if (!pdata)
+		return -ENOMEM;
+
+	drv->pdata = pdata;
+	pdata->drv = drv;
+
+	cmd_info = TRIV2_DRV_GET_CMD_INFO(drv);
+
+	spin_lock_init(&cmd_info->lock);
+	/* init cmd bitmap */
+	bitmap_zero(cmd_info->bitmap, TRIV2_MAX_CMDSLOTS);
+
+	return 0;
+}
+
+/**
+ * triv2_cleanup() - Clean up initialized variables in TRIV2
+ */
+static void triv2_cleanup(struct trinity_driver *drv)
+{
+	if (!drv->pdata)
+		return;
+
+	kfree(drv->pdata);
+	drv->pdata = NULL;
+}
+
+static struct trinity_desc triv2_desc = {
+	.type = "triv2",
+	.ver = GENVER(TRINITY_DEV_VISION2, VER_MAJOR, VER_MINOR, VER_EXTRA),
+	.fops = &triv2_fops,
+	/* device management */
+	.reset = triv2_reset,
+	/* req management */
+	.alloc_req = triv2_alloc_req,
+	.dealloc_req = triv2_dealloc_req,
+	.prepare_req = triv2_prepare_req,
+	.invoke_req = triv2_invoke_req,
+};
+
+static const struct of_device_id trinity_match[] = {
+	{
+		.compatible = "samsung,trinity",
+	},
+	{ /** sentinel */ },
+};
+
+/**
+ * trinity_triv2_probe() - Probes for Trinity vision devices, inits them if found
+ */
+static int trinity_triv2_probe(struct platform_device *pdev)
+{
+	struct trinity_driver *drv;
+	int err;
+
+	err = trinity_probe(pdev, &triv2_desc);
+	if (err < 0)
+		return err;
+
+	err = triv2_init_pdata(drv);
+	if (err < 0)
+		goto out_remove;
+
+	err = trinity_create_node(drv);
+	if (err < 0) {
+		triv2_cleanup(drv);
+		goto out_remove;
+	}
+
+	dev_info(drv_to_dev_ptr(drv), "Trinity Vision2 (TRIV2)");
+
+	return 0;
+
+out_remove:
+	trinity_remove(pdev, &triv2_desc);
+	return err;
+}
+
+/**
+ * trinity_triv2_remove() - Removes an instance of a Trinity vision device
+ */
+static int trinity_triv2_remove(struct platform_device *pdev)
+{
+	struct trinity_driver *drv = platform_get_drvdata(pdev);
+
+	trinity_destroy_node(drv);
+	triv2_cleanup(drv);
+	return trinity_remove(pdev, &triv2_desc);
+}
+
+static struct platform_driver trinity_triv2 = {
+	.probe = trinity_triv2_probe,
+	.remove = trinity_triv2_remove,
+	.driver = {
+			.name = "triv2",
+			.owner = THIS_MODULE,
+			.of_match_table = of_match_ptr(trinity_match),
+		},
+};
+
+module_platform_driver(trinity_triv2);
+
+MODULE_IMPORT_NS(DMA_BUF);
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Samsung Electronics");
+MODULE_DESCRIPTION("Samsung NPU device driver for trinity vision 2");
diff --git a/drivers/misc/trinity/trinity_vision2_regs.h b/drivers/misc/trinity/trinity_vision2_regs.h
new file mode 100644
index 000000000000..58ef037d320e
--- /dev/null
+++ b/drivers/misc/trinity/trinity_vision2_regs.h
@@ -0,0 +1,210 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/**
+ * Trinity Vision2 Registers
+ *
+ * Copyright (C) 2020-2022 Samsung Electronics
+ * Copyright (C) 2022 MyungJoo Ham <myungjoo.ham@samsung.com>
+ * Copyright (C) 2022 Yelin Jeong <yelini.jeong@samsung.com>
+ * Copyright (C) 2022 Jiho Chu <jiho.chu@samsung.com>
+ */
+
+#ifndef __DRIVERS_MISC_TRINITY_VISION2_REGS_H__
+#define __DRIVERS_MISC_TRINITY_VISION2_REGS_H__
+
+/* Register offsets for NPU CP (Config) */
+#define OFFSET_CP_INFO (0x000) /* Processor Information */
+#define OFFSET_CP_PROC_STAT (0x010) /* Processor Status */
+#define OFFSET_CP_PROC_SET (0x014) /* Processor Control (Set) */
+#define OFFSET_CP_PROC_CLR (0x018) /* Processor Control (Clear) */
+#define OFFSET_CP_IMIF_BASE (0x024) /* Instruction Base Address (DRAM) */
+#define OFFSET_CP_CNT_CFG (0x200) /* CP Performance Counter */
+
+/* Register offsets for NPU CP (IDU Setup) */
+#define OFFSET_NPU_PROG_BASE (0x100) /* GPR00: Instruction Base Address */
+#define OFFSET_NPU_PROG_SIZE (0x104) /* GPR01: Program Size */
+#define OFFSET_NPU_SEGT_ADDR (0x108) /* GPR02: Segment Table Address */
+#define OFFSET_NPU_PROF_ADDR (0x10C) /* GPR03: NPU Profiling Address */
+#define OFFSET_NPU_PROF_SIZE (0x110) /* GPR04: NPU Profiling Size */
+#define OFFSET_NPU_BACK_ADDR (0x114) /* GPR05: NPU Context Backup Address */
+#define OFFSET_NPU_BACK_SIZE (0x118) /* GPR06: NPU Context Backup Size */
+#define OFFSET_NPU_PC (0x11C) /* GPR07: NPU Program Counter */
+
+/* Register offsets for NPU CP (Commands) */
+#define OFFSET_NPU_CMD_READY (0x124) /* GPR09: Command Ready Status */
+#define OFFSET_NPU_CMD_BASE (0x128) /* GPR10: Command Base Address */
+#define OFFSET_NPU_CMD_REQ (0x12C) /* GPR11: Command Request Slots (not used) */
+#define OFFSET_NPU_CMD_FREE (0x130) /* GPR12: Command Free Slots */
+
+/* Register offsets for NPU CP (Cbox Setup) */
+#define OFFSET_NPU_CBOX_BASE (0x134) /* GPR13: NPU CBOX BASE */
+
+/* Register offsets for Debugging */
+#define OFFSET_NPU_IDU_VERSION (0x138) /* GPR14: NPU IDU VERSION */
+#define OFFSET_NPU_IDU_STAGE (0x13C) /* GPR15: NPU IDU STAGE */
+
+#define OFFSET_NPU_CP_DMAI_EADDR (0x300) /* CP DMA Source Address */
+#define OFFSET_NPU_CP_DMAI_IADDR (0x304) /* CP DMA Dest Address */
+#define OFFSET_NPU_CP_DMAI_TSIZE (0x308) /* CP DMA Transfer Size */
+#define OFFSET_NPU_CP_DMAI_CONTR (0x310) /* CP DMA Status */
+#define OFFSET_NPU_CP_DMAI_CMDID (0x314) /* CP DMA Command ID */
+#define OFFSET_NPU_CP_DMAI_LSTID \
+	(0x318) /* CP DMA Command ID of the last transfer */
+
+#define OFFSET_NPU_DLA_DMAI_EADDR (0x1000) /* DLA Input External Address */
+#define OFFSET_NPU_DLA_DMAI_EYMOD \
+	(0x1004) /* DLA Input External Address Y Modifier */
+#define OFFSET_NPU_DLA_DMAI_EZMOD \
+	(0x1008) /* DLA Input External Address Z Modifier */
+#define OFFSET_NPU_DLA_DMAI_IADDR (0x100C) /* DLA Input Internal Address */
+#define OFFSET_NPU_DLA_DMAI_IYMOD \
+	(0x1010) /* DLA Input Internal Address Y Modifier */
+#define OFFSET_NPU_DLA_DMAI_IZMOD \
+	(0x1014) /* DLA Input Internal Address Z Modifier */
+#define OFFSET_NPU_DLA_DMAI_SIZE0 (0x1018) /* DLA Input Data Size 0 */
+#define OFFSET_NPU_DLA_DMAI_SIZE1 (0x101C) /* DLA Input Data Size 1 */
+#define OFFSET_NPU_DLA_DMAI_CTRL (0x1020) /* DLA Input Channel Status */
+
+#define OFFSET_NPU_DLA_DMAO_EADDR (0x1080) /* DLA Output External Address */
+#define OFFSET_NPU_DLA_DMAO_EYMOD \
+	(0x1084) /* DLA Output External Address Y Modifier */
+#define OFFSET_NPU_DLA_DMAO_EZMOD \
+	(0x1088) /* DLA Output External Address Z Modifier */
+#define OFFSET_NPU_DLA_DMAO_IADDR (0x108C) /* DLA Output Internal Address */
+#define OFFSET_NPU_DLA_DMAO_IYMOD \
+	(0x1090) /* DLA Output Internal Address Y Modifier */
+#define OFFSET_NPU_DLA_DMAO_IZMOD \
+	(0x1094) /* DLA Output Internal Address Z Modifier */
+#define OFFSET_NPU_DLA_DMAO_SIZE0 (0x1098) /* DLA Output Data Size 0 */
+#define OFFSET_NPU_DLA_DMAO_SIZE1 (0x109C) /* DLA Output Data Size 1 */
+#define OFFSET_NPU_DLA_DMAO_CTRL (0x10A0) /* DLA Output Channel Status */
+
+#define OFFSET_NPU_DLA_CORE_OPC (0x1100) /* DLA Operation Code */
+#define OFFSET_NPU_DLA_CORE_WIND_CFG (0x1104)
+#define OFFSET_NPU_DLA_CORE_SIZE0 (0x1108)
+#define OFFSET_NPU_DLA_CORE_SIZE1 (0x110C)
+#define OFFSET_NPU_DLA_CORE_ZP (0x1110)
+#define OFFSET_NPU_DLA_CORE_OUT_MULT (0x1114)
+#define OFFSET_NPU_DLA_CORE_IN0_MULT (0x1118)
+#define OFFSET_NPU_DLA_CORE_IN1_MULT (0x111C)
+#define OFFSET_NPU_DLA_CORE_OUT_CFG (0x1120)
+#define OFFSET_NPU_DLA_CORE_OUT_MOD (0x1124)
+#define OFFSET_NPU_DLA_CORE_IN0_CFG (0x1128)
+#define OFFSET_NPU_DLA_CORE_IN0_MOD (0x112C)
+#define OFFSET_NPU_DLA_CORE_IN1_CFG (0x1130)
+#define OFFSET_NPU_DLA_CORE_IN1_MOD (0x1134)
+#define OFFSET_NPU_DLA_CORE_PARAM_ADDR (0x1138)
+#define OFFSET_NPU_DLA_CORE_PSUM_ADDR (0x113C)
+#define OFFSET_NPU_DLA_CORE_CWGT_ADDR (0x1140)
+#define OFFSET_NPU_DLA_CORE_CTR (0x1144) /* DLA Core Status */
+
+#define OFFSET_NPU_DSP_DMAI_EADDR (0x2000) /* DSP Input External Address */
+#define OFFSET_NPU_DSP_DMAI_EYMOD \
+	(0x2004) /* DSP Input External Address Y Modifier */
+#define OFFSET_NPU_DSP_DMAI_EZMOD \
+	(0x2008) /* DSP Input External Address Z Modifier */
+#define OFFSET_NPU_DSP_DMAI_IADDR (0x200C) /* DSP Input Internal Address */
+#define OFFSET_NPU_DSP_DMAI_IYMOD \
+	(0x2010) /* DSP Input Internal Address Y Modifier */
+#define OFFSET_NPU_DSP_DMAI_IZMOD \
+	(0x2014) /* DSP Input Internal Address Z Modifier */
+#define OFFSET_NPU_DSP_DMAI_SIZE0 (0x2018) /* DSP Input Data Size 0 */
+#define OFFSET_NPU_DSP_DMAI_SIZE1 (0x201C) /* DSP Input Data Size 1 */
+#define OFFSET_NPU_DSP_DMAI_CTRL (0x2020) /* DSP Input Channel Status */
+
+#define OFFSET_NPU_DSP_DMAO_EADDR (0x2080) /* DSP Output External Address */
+#define OFFSET_NPU_DSP_DMAO_EYMOD \
+	(0x2084) /* DSP Output External Address Y Modifier */
+#define OFFSET_NPU_DSP_DMAO_EZMOD \
+	(0x2088) /* DSP Output External Address Z Modifier */
+#define OFFSET_NPU_DSP_DMAO_IADDR (0x208C) /* DSP Output Internal Address */
+#define OFFSET_NPU_DSP_DMAO_IYMOD \
+	(0x2090) /* DSP Output Internal Address Y Modifier */
+#define OFFSET_NPU_DSP_DMAO_IZMOD \
+	(0x2094) /* DSP Output Internal Address Z Modifier */
+#define OFFSET_NPU_DSP_DMAO_SIZE0 (0x2098) /* DSP Output Data Size 0 */
+#define OFFSET_NPU_DSP_DMAO_SIZE1 (0x209C) /* DSP Output Data Size 1 */
+#define OFFSET_NPU_DSP_DMAO_CTRL (0x20A0) /* DSP Output Channel Status */
+#define OFFSET_NPU_DSP_CORE_CTRL (0x2140) /* DSP Core Status */
+
+/* Register offsets for NPU DSP */
+#define OFFSET_DSP_INFO (0x000) /* Processor Information */
+#define OFFSET_DSP_PROC_STAT (0x010) /* Processor Status */
+#define OFFSET_DSP_PROC_SET (0x014) /* Processor Control (Set) */
+#define OFFSET_DSP_PROC_CLR (0x018) /* Processor Control (Clear) */
+#define OFFSET_DSP_IMIF_BASE (0x024) /* Instruction Base Address (DRAM) */
+
+/* Register offsets for NPU ComBox (IRQ) */
+#define OFFSET_CBOX_EXT_IRQ_MSK (0x100) /* External IRQ Output Mask */
+#define OFFSET_CBOX_EXT_IRQ_STA (0x104) /* External IRQ Output Status */
+#define OFFSET_CBOX_CP_SWI_CLR (0x134) /* CP IRQ output Clear */
+#define OFFSET_CBOX_DSP_SWI_CLR (0x154) /* DSP IRQ output Clear */
+
+/* Location of bits inside corresponding registers */
+#define BIT_CLR_IRQ_OUT BIT(24)
+#define BIT_CLR_PAUSE BIT(0)
+#define BIT_SET_SEND_EVT1 BIT(18)
+#define BIT_SET_PAUSE BIT(0)
+#define BIT_STAT_PAUSED BIT(1)
+
+/* Performance counter configurations */
+#define BIT_CNT_DST_EN BIT(6)
+#define BIT_CNT_IST_EN BIT(5)
+#define BIT_CNT_ST_EN BIT(4)
+#define BIT_CNT_FR_EN BIT(0)
+
+/* Bit masks */
+#define MASK_DSP_SWI_STA BIT_MASK(1)
+#define MASK_CP_SWI_STA BIT_MASK(0)
+
+#define MASK_STAT_WFE_PARAM GENMASK(14, 6)
+#define MASK_STAT_WFE_PARAM_EVT1 BIT_MASK(8)
+#define MASK_STAT_WFE BIT_MASK(5)
+#define MASK_STAT_PAUSED BIT_MASK(1)
+#define MASK_STAT_PAUSE BIT_MASK(0)
+
+#define VER_MAJOR (2)
+#define VER_MINOR (0)
+#define VER_EXTRA (0)
+
+#define read_idu_file(file, pos, addr, size) kernel_read(filp, addr, size, &pos)
+
+/** Macros for Instruction Decode Unit (IDU) */
+#define TRIV2_IDU_DIRPATH_FMT "/lib/modules/%s/kernel/soc/idu"
+#define TRIV2_IDU_MAX_SECTORS (3)
+#define TRIV2_IDU_ZEROIDX (0)
+#define TRIV2_IDU_DATAIDX (1)
+#define TRIV2_IDU_CODEIDX (2)
+#define TRIV2_IDU_ADDR(addr) ((uint32_t)(addr))
+#define TRIV2_IDU_MAXSIZE (1 << 20) /* 1 MiB */
+
+#define TRIV2_IDU_CP_DSPM_SIZE (0x10000)
+
+#define TRIV2_IDU_MASK_MAJOR (0xFF000000)
+#define TRIV2_IDU_MASK_MINOR (0x00FFF000)
+#define TRIV2_IDU_MASK_EXTRA (0x00000FFF)
+
+#define TRIV2_IDU_SHIFT_MAJOR (24)
+#define TRIV2_IDU_SHIFT_MINOR (12)
+
+#define TRIV2_MODEL_HASH_BITS (8)
+#define TRIV2_MODEL_HASH_SIZE (1 << TRIV2_MODEL_HASH_BITS)
+#define TRIV2_PROFILE_HASH_BITS (6)
+#define TRIV2_PROFILE_HASH_SIZE (1 << TRINITY_PROFILE_HASH_BITS)
+#define TRIV2_PROFILE_HASH_KEY(id) (hash_long((id), TRIV2_PROFILE_HASH_BITS))
+
+#define TRIV2_MAX_SEGMENTS (256)
+/** Fits in a single 4K Page */
+#define TRIV2_MAX_CMDSLOTS (PAGE_SIZE / sizeof(struct triv2_cmd))
+
+#define TRIV2_MAX_TENSORS (16)
+#define TRIV2_MAX_CMD_SIZE (512)
+#define TRIV2_MAX_BATCH_SIZE (32)
+
+#define TRIV2_DLA_GBUFFER_SIZE (0x80000)
+#define TRIV2_DSP_DSPM_OFFSET (0x10000)
+
+/* 4MiB (~300ns to flush all caches) */
+#define TRIV2_CACHE_FLUSH_THRESHOLD (0x400000)
+#define TRIV2_KERN_TIMEOUT_RESET (1000)
+
+#endif /* __DRIVERS_MISC_TRINITY_VISION2_REGS_H__ */
diff --git a/include/uapi/misc/trinity.h b/include/uapi/misc/trinity.h
new file mode 100644
index 000000000000..9f4808bfdd90
--- /dev/null
+++ b/include/uapi/misc/trinity.h
@@ -0,0 +1,476 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/**
+ * User-level header for trinity devices.
+ *
+ * Copyright (C) 2020-2022 Samsung Electronics
+ * Copyright (C) 2020 Wook Song <wook16.song@samsung.com>
+ * Copyright (C) 2020 Dongju Chae <dongju.chae@samsung.com>
+ * Copyright (C) 2020 Parichay Kapoor <pk.kapoor@samsung.com>
+ * Copyright (C) 2022 MyungJoo Ham <myungjoo.ham@samsung.com>
+ * Copyright (C) 2022 Yelin Jeong <yelini.jeong@samsung.com>
+ * Copyright (C) 2022 Jiho Chu <jiho.chu@samsung.com>
+ */
+
+#ifndef __TRINITY_H__
+#define __TRINITY_H__
+
+#include <linux/types.h>
+
+#define TRINITY_API_LEVEL 12
+
+/**
+ * enum trinity_state - Enum that describes a trinity device state
+ * @TRINITY_STATE_UNKNOWN: A device has unknown state
+ * @TRINITY_STATE_PAUSE: A device is paused
+ * @TRINITY_STATE_READY: A device is ready
+ * @TRINITY_STATE_END: End of trinity_state
+ */
+enum trinity_state {
+	TRINITY_STATE_UNKNOWN = -1,
+	TRINITY_STATE_PAUSE = 0,
+	TRINITY_STATE_READY,
+	TRINITY_STATE_END,
+};
+
+/**
+ * enum trinity_input_mode - Enum that describes an input source
+ * @TRINITY_INPUT_UNKNOWN: Unknown input mode
+ * @TRINITY_INPUT_CPU: Input feed by CPU
+ * @TRINITY_INPUT_HW: Input feed by third-party HW
+ * @TRINITY_INPUT_END: End of trinity_input_mode
+ */
+enum trinity_input_mode {
+	TRINITY_INPUT_UNKNOWN = -1,
+	TRINITY_INPUT_CPU = 0,
+	TRINITY_INPUT_HW,
+	TRINITY_INPUT_END,
+};
+
+/**
+ * enum trinity_output_mode - Enum that describes an output source
+ * @TRINITY_OUTPUT_UNKNOWN: Unknown output mode
+ * @TRINITY_OUTPUT_CPU_INTR: Output completion handling by interrupt
+ * @TRINITY_OUTPUT_CPU_POLL: Output completion handling by polling
+ * @TRINITY_OUTPUT_HW: Output completion handling by third-party HW
+ * @TRINITY_OUTPUT_END: End of trinity_output_mode
+ */
+enum trinity_output_mode {
+	TRINITY_OUTPUT_UNKNOWN = -1,
+	TRINITY_OUTPUT_CPU_INTR = 0,
+	TRINITY_OUTPUT_CPU_POLL,
+	TRINITY_OUTPUT_HW,
+	TRINITY_OUTPUT_END,
+};
+
+/**
+ * enum trinity_app_status - Enum that describes an app status
+ * @TRINITY_APP_STATUS_UNKNOWN: Unknown app status
+ * @TRINITY_APP_STATUS_ERROR: App has got some errors
+ * @TRINITY_APP_STATUS_PENDING: App is currently pending
+ * @TRINITY_APP_STATUS_STARTED: App was started
+ * @TRINITY_APP_STATUS_TERMINATED: App was terminated
+ */
+enum trinity_app_status {
+	TRINITY_APP_STATUS_UNKNOWN = 0,
+	TRINITY_APP_STATUS_ERROR = 1,
+	TRINITY_APP_STATUS_PENDING = 2,
+	TRINITY_APP_STATUS_STARTED = 3,
+	TRINITY_APP_STATUS_TERMINATED = 4
+};
+
+/**
+ * enum trinity_req_status - Enum that describes a request status
+ * @TRINITY_REQ_STATUS_UNKNOWN: Unknown request status
+ * @TRINITY_REQ_STATUS_ERROR: Request has got some errors
+ * @TRINITY_REQ_STATUS_PENDING: Request is currently pending
+ * @TRINITY_REQ_STATUS_RUNING: Request is currently running
+ * @TRINITY_REQ_STATUS_FINISHED: Request was finished
+ */
+enum trinity_req_status {
+	TRINITY_REQ_STATUS_UNKNOWN = 0,
+	TRINITY_REQ_STATUS_ERROR = 1,
+	TRINITY_REQ_STATUS_PENDING = 2, /* A request is submitted */
+	TRINITY_REQ_STATUS_RUNNING = 3, /* A request is running on NPU */
+	TRINITY_REQ_STATUS_FINISHED = 4 /* A request is just finished */
+};
+
+/**
+ * enum trinity_req_priority - Enum that describes a request priority
+ * @TRINITY_REQ_PRIORITY_LOW: Low priority
+ * @TRINITY_REQ_PRIORITY_MID: Mid priority scheduled with a higher chance than low one
+ * @TRINITY_REQ_PRIORITY_HIGH: High priority preempting lower priority requests
+ */
+enum trinity_req_priority {
+	TRINITY_REQ_PRIORITY_LOW = 0,
+	TRINITY_REQ_PRIORITY_MID = 1,
+	TRINITY_REQ_PRIORITY_HIGH = 2,
+};
+
+/**
+ * enum trinity_hwmem_type - A type of DMA buffer allocation method.
+ * @TRINITY_HWMEM_DMA_CONT: Use CMA to allocate backing stroage of DMA buffers.
+ * @TRINITY_HWMEM_DMA_IOMMU: Use IOMMU to allocate backing stroage of DMA buffers.
+ * @HWMEM_END: Sentinel.
+ */
+enum trinity_hwmem_type {
+	TRINITY_HWMEM_DMA_CONT = 0,
+	TRINITY_HWMEM_DMA_IOMMU,
+	TRINITY_HWMEM_END,
+};
+
+#ifndef TASK_COMM_LEN
+#define TASK_COMM_LEN 16
+#endif
+
+#define TRINITY_APP_NAME_MAX TASK_COMM_LEN
+#define TRINITY_APP_STAT_MAX 10
+#define TRINITY_REQ_STAT_MAX 10
+
+/**
+ * struct trinity_ioctl_stat_app - Describes stat of the target app
+ * @app_id: Trinity app id (currently, equal to pid)
+ * @name: Trinity app name
+ * @status: Trinity app status
+ * @num_total_reqs: Number of total requests in app (including finished ones)
+ * @num_active_reqs: Number of active (running or pending) requests in app
+ * @total_alloc_mem: Total size of allocated memory in the device
+ * @total_freed_mem: Total size of freed memory in the device
+ */
+struct trinity_ioctl_stat_app {
+	__s32 app_id;
+
+	char name[TRINITY_APP_NAME_MAX];
+	enum trinity_app_status status;
+
+	__u32 num_total_reqs;
+	__u32 num_active_reqs;
+
+	__u64 total_alloc_mem;
+	__u64 total_freed_mem;
+} __packed;
+
+/**
+ * struct trinity_ioctl_stat_apps - Describes stats of the latest apps
+ * @num_apps: Number of apps for the stat list
+ * @stat: Stat of the latest apps
+ */
+struct trinity_ioctl_stat_apps {
+	__u32 num_apps;
+	struct trinity_ioctl_stat_app stat[TRINITY_APP_STAT_MAX];
+} __packed;
+
+/**
+ * struct trinity_ioctl_stat_req - Describes stat of the target request
+ * @req_id: Trinity req id
+ * @model_id: Trinity model id
+ * @priority: Request priority (low, mid, or high)
+ * @status: Request status
+ * @sched_time: scheduling time in ms
+ * @infer_time: inference time in ms
+ */
+struct trinity_ioctl_stat_req {
+	__s32 req_id;
+	__u64 model_id;
+
+	enum trinity_req_priority priority;
+	enum trinity_req_status status;
+
+	__u32 sched_time;
+	__u32 infer_time;
+} __packed;
+
+/**
+ * struct trinity_ioctl_stat_reqs - Describes stats of the latest reqs
+ * @app_id: Trinity app id (0 means 'current')
+ * @num_reqs: Number of reqs for stat list
+ * @stat: Stat of the latest reqs
+ */
+struct trinity_ioctl_stat_reqs {
+	__s32 app_id;
+	__u32 num_reqs;
+	struct trinity_ioctl_stat_req stat[TRINITY_REQ_STAT_MAX];
+} __packed;
+
+/**
+ * struct trinity_ioctl_hwmem - A structure that Describes hardware memory (hwmem)
+ * @type: The type of hwmem type
+ * @size: The size of hwmem
+ * @dbuf_fd: File descriptor for dmabuf representing hwmem
+ */
+struct trinity_ioctl_hwmem {
+	enum trinity_hwmem_type type;
+	__u64 size;
+	__s32 dbuf_fd;
+} __packed;
+
+/**
+ * struct trinity_ioctl_profile_meta - Describes profiling meta info.
+ * @req_id: The target req id for profiling
+ * @total_cycles: The total number of cycles of the given req
+ * @total_ops: The total number of operations of the given req
+ * @input_footprint: The DRAM footprint of input data
+ * @output_footprint: The DRAM footprint of output data
+ * @profile_size: The size of profiling data
+ */
+struct trinity_ioctl_profile_meta {
+	__s32 req_id;
+	__s64 total_cycles;
+	__u32 total_ops;
+	__s64 input_footprint;
+	__s64 output_footprint;
+	__u32 profile_size;
+} __packed;
+
+/**
+ * struct trinity_ioctl_profile_buff - Describes profiling buff info.
+ * @req_id: The target req id for profiling
+ * @profile_pos: The start position to extract profiling data
+ * @profile_size: The size of user-allocated profiling buffer
+ * @profile_buf: The profiling buffer which user allocated
+ */
+struct trinity_ioctl_profile_buff {
+	__s32 req_id;
+	__u32 profile_pos;
+	__u32 profile_size;
+	void __user *profile_buf;
+} __packed;
+
+/**
+ * struct trinity_ioctl_model - A structure that configure a model registered on NPU
+ * @id: Id for NPU model to extract the base phys addr
+ * @dbuf_fd: File descriptor for dmabuf representing the model
+ * @program_offset_addr: Offset address for the instructions (NPU_PROG_BASE)
+ * @program_size: Size of the program instructions (NPU_PROG_SIZE)
+ * @version: The version of npubinfmt
+ * @endp_trnt_model_common: Indicator for the end of common model parameters
+ * @weight_offset_addr: Offset address for storing weights (NPU_WGT_BASE)
+ * @metadata_dbuf_fd: File descriptor for dmabuf representing the metadata
+ * @metadata_extra_addr: Offset address for the metadata extra
+ * @metadata_extra_size: Size of the metadata extra
+ * @num_visa_insts: Number of virtual ISA instructions
+ */
+struct trinity_ioctl_model {
+	__u64 id;
+	__s32 dbuf_fd;
+	__u64 program_offset_addr;
+	__u64 program_size;
+	__u32 version;
+	union {
+		__u8 endp_trnt_model_common[0];
+		struct {
+			__u64 weight_offset_addr;
+		} __packed;
+		struct {
+			__s32 metadata_dbuf_fd;
+			__s32 metadata_ext_dbuf_fd;
+			__u64 metadata_ext_size;
+			__u32 num_visa_insts;
+		} __packed;
+	};
+} __packed;
+
+/**
+ * struct trinity_ioctl_input - A structure that configure an input passed to NPU
+ * @dbuf_fd: File descriptor for dmabuf of I/O buffer (or segment table)
+ * @model_id: Model id received when setting the model in the NPU
+ * @req_id: Request id to distinguish each run_input
+ * @timeout_ms: Timeout in ms, zero is regarded as preemption
+ * @priority: Priority (LOW: 0, MID: 1, HIGH: 2)
+ * @endp_trnt_input_common: Indicator for the end of common input parameters
+ * @activation_offset_addr0: Offset address for storing weights (NPU_ACT_BASE0)
+ * @activation_offset_addr1: Offset address for storing weights (NPU_ACT_BASE1)
+ * @num_segments: Number of segments
+ * @input_mode: Input mode (who is supposed to feed input)
+ * @output_mode: Output mode (who is supposed to retrieve output)
+ * @hw_input_seg: Third-party HW's input segment idx
+ * @hw_output_seg: Third-party HW's output segment idx
+ * @task_handle: user requested task handle
+ * @subtask_idx: user requested subtask idx
+ * @task_id: kernel module requested task id
+ */
+struct trinity_ioctl_input {
+	__s32 dbuf_fd;
+	__u64 model_id;
+	__s32 req_id;
+	__s64 timeout_ms;
+	__u32 priority;
+	union {
+		__u8 endp_trnt_input_common[0];
+		struct {
+			/* added for TRIV-1 */
+			__u64 activation_offset_addr0;
+			__u64 activation_offset_addr1;
+		} __packed;
+		struct {
+			/* added for TRIV-2 */
+			__u32 num_segments;
+			enum trinity_input_mode input_mode;
+			enum trinity_output_mode output_mode;
+			__s32 hw_input_seg;
+			__s32 hw_output_seg;
+			/* [optional] vd scheduler info */
+			union {
+				struct { /* user request */
+					__u32 task_handle;
+					__u32 subtask_idx;
+				} __packed;
+				struct { /* kernel request */
+					__u32 task_id;
+				} __packed;
+			};
+		} __packed;
+	};
+} __packed;
+
+#define TRINITY_MASK_DEV (0xFF000000)
+#define TRINITY_MASK_MAJOR_VER (0x00FF0000)
+#define TRINITY_MASK_MINOR_VER (0x0000FF00)
+#define TRINITY_MASK_EXTRA_VER (0x000000FF)
+
+/**
+ * struct trinity_ioctl_fpga_memcpy - A structure that contains driver-assisted memcpy
+ * @dbuf_fd: File descriptor for dmabuf of the target buffer
+ * @dbuf_off: Offset from the dmabuf base address
+ * @user_addr: Address of user-level buffer
+ * @user_size: Size of user-level buffer
+ *
+ * @note: It's workaround structure for FPGA envionment
+ */
+struct trinity_ioctl_fpga_memcpy {
+	__s32 dbuf_fd;
+	__u32 dbuf_off;
+	void __user *user_addr;
+	__u64 user_size;
+} __packed;
+
+/**
+ * struct trinity_ioctl_idu - A structure that Describes IDU
+ * @dbuf_cp_data: CP data dmabuf which is allocated with TRINITY_IOCTL_HWMEM_ALLOC
+ * @dbuf_cp_code: CP code dmabuf which is allocated with TRINITY_IOCTL_HWMEM_ALLOC
+ * @dbuf_cp_data: dsp data dmabuf which is allocated with TRINITY_IOCTL_HWMEM_ALLOC
+ * @dbuf_dsp_code: dsp code dmabuf which is allocated with TRINITY_IOCTL_HWMEM_ALLOC
+ */
+struct trinity_ioctl_idu {
+	__s32 dbuf_cp_data;
+	__s32 dbuf_cp_code;
+	__s32 dbuf_dsp_data;
+	__s32 dbuf_dsp_code;
+} __attribute__((packed));
+
+#define TRINITY_SHIFT_DEV (24)
+#define TRINITY_SHIFT_MAJOR_VER (16)
+#define TRINITY_SHIFT_MINOR_VER (8)
+#define TRINITY_SHIFT_EXTRA_VER (0)
+#define TRINITY_SHIFT_MODEL_ID (16)
+
+#define trinity_gen_ver(dev, mj, mn, ex)                                       \
+	{                                                                      \
+		(dev << TRINITY_SHIFT_DEV) | (mj << TRINITY_SHIFT_MAJOR_VER) | \
+			(mn << TRINITY_SHIFT_MINOR_VER) |                      \
+			(ex << TRINITY_SHIFT_EXTRA_VER)                        \
+	}
+
+/**
+ * enum trinity_dev_type - Enum that describes a trinity device type
+ * @TRINITY_DEV_UNKNOWN: Unknown device type
+ * @TRINITY_DEV_VISION: Trinity Vision (TRIV)
+ * @TRINITY_DEV_AUDIO: Trinity Asr (TRIA)
+ * @TRINITY_DEV_VISION2: Trinity Vision2 (TRIV2)
+ * @TRINITY_DEV_VISION2_CUSE: Trinity Vision2 (TRIV2), CUSE-based impl.
+ * @TRINITY_DEV_END: End of trinity_dev_type
+ */
+enum trinity_dev_type {
+	TRINITY_DEV_UNKNOWN = 0,
+	TRINITY_DEV_VISION,
+	TRINITY_DEV_AUDIO,
+	TRINITY_DEV_VISION2,
+	TRINITY_DEV_VISION2_CUSE, /* CUSE-based impl. for triv2 */
+	TRINITY_DEV_END /* sentinel */
+};
+
+/**
+ * Major number can not be dynamic as ioctls need it,
+ */
+#define TRINITY_DRIVER_MAGIC 0x88
+
+#define TRINITY_IO(no) _IO(TRINITY_DRIVER_MAGIC, no)
+#define TRINITY_IOR(no, data_type) _IOR(TRINITY_DRIVER_MAGIC, no, data_type)
+#define TRINITY_IOW(no, data_type) _IOW(TRINITY_DRIVER_MAGIC, no, data_type)
+#define TRINITY_IOWR(no, data_type) _IOWR(TRINITY_DRIVER_MAGIC, no, data_type)
+
+/** Device Information */
+
+/** Get the device version information from the driver */
+#define TRINITY_IOCTL_GET_VERSION TRINITY_IOR(1, __u32)
+/** Get the device API level from the driver */
+#define TRINITY_IOCTL_GET_API_LEVEL TRINITY_IOR(2, __u32)
+/** Get the device state from the driver */
+#define TRINITY_IOCTL_GET_STATE TRINITY_IOR(3, __s32)
+/** Get the device tops information from the driver */
+#define TRINITY_IOCTL_GET_TOPS TRINITY_IOR(4, __u32)
+/** Get the device dspm information from the driver */
+#define TRINITY_IOCTL_GET_DSPM TRINITY_IOR(5, __u32)
+/** Get the next request ID from the driver */
+#define TRINITY_IOCTL_GET_NEXT_REQUEST TRINITY_IOR(6, __s32)
+
+/** Device Control */
+
+/** Allocate driver-managed memory */
+#define TRINITY_IOCTL_HWMEM_ALLOC TRINITY_IOW(21, struct trinity_ioctl_hwmem)
+
+/** De-allocate driver-managed memory */
+#define TRINITY_IOCTL_HWMEM_DEALLOC TRINITY_IOW(22, struct trinity_ioctl_hwmem)
+
+/** Register the given model config in the device and return model id */
+#define TRINITY_IOCTL_REGISTER_MODEL \
+	TRINITY_IOWR(23, struct trinity_ioctl_model)
+
+/** Unregister the model config associated with the given model_id */
+#define TRINITY_IOCTL_DEREGISTER_MODEL TRINITY_IOW(24, __u64)
+
+/** Run the device with the given input */
+#define TRINITY_IOCTL_RUN_INPUT TRINITY_IOWR(25, struct trinity_ioctl_input)
+
+/** Stop all requests submitted to the device */
+#define TRINITY_IOCTL_STOP_REQUESTS TRINITY_IO(26)
+
+/** Stop the target request with id returned by run_input */
+#define TRINITY_IOCTL_STOP_REQUEST TRINITY_IOW(27, __s32)
+
+/** Device Statistics/Profile */
+
+/** Get the current app stat in the opened device */
+#define TRINITY_IOCTL_STAT_CURRENT_APP \
+	TRINITY_IOR(51, struct trinity_ioctl_stat_app)
+
+/** Get latest apps' stat of the opened device */
+#define TRINITY_IOCTL_STAT_APPS TRINITY_IOR(52, struct trinity_ioctl_stat_apps)
+
+/** Get latest reqs' stat in the target app */
+#define TRINITY_IOCTL_STAT_REQS TRINITY_IOR(53, struct trinity_ioctl_stat_reqs)
+
+/** Get profiling metadata of the request */
+#define TRINITY_IOCTL_GET_PROFILE_META \
+	TRINITY_IOWR(54, struct trinity_ioctl_profile_meta)
+
+/** Get profiling per-op data of the request */
+#define TRINITY_IOCTL_GET_PROFILE_BUFF \
+	TRINITY_IOWR(55, struct trinity_ioctl_profile_buff)
+
+/** Set IDU binary */
+#define TRINITY_IOCTL_IDU_SET \
+	TRINITY_IOW(56, struct trinity_ioctl_idu)
+
+/** Device Testing/Workaround */
+
+/** Driver-assisted memory copy for FPGA env. */
+#define TRINITY_IOCTL_FPGA_MEMCPY \
+	TRINITY_IOWR(91, struct trinity_ioctl_fpga_memcpy)
+
+/** A wrapper of trinity_run_internal_req() */
+#define TRINITY_IOCTL_RUN_INTERNAL_REQ TRINITY_IOW(92, dev_t)
+
+#ifdef __KERNEL__
+__s32 trinity_run_internal_req(dev_t);
+#endif
+#endif /* __TRINITY_H__ */
-- 
2.25.1

