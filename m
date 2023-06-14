Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 549C4729429
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 11:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241098AbjFIJFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 05:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240774AbjFIJFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 05:05:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB232134;
        Fri,  9 Jun 2023 02:05:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D137F60B89;
        Fri,  9 Jun 2023 09:05:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 905DFC433D2;
        Fri,  9 Jun 2023 09:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686301516;
        bh=ziMSqiERzDi98xKbzS1LkONb2vqjHECZUMj0dHyG8L8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UaJhT+dmYy3DE7m1exj4pmWOOvkHur9jFhmOembpUlVfl4JHeja6qSXwIpELzJznZ
         /ZhZBoX5MIAjT+4bau54TcSjfXGPWQYC89BlkTuZ2S4uTCS1K4LAngrqWFjxyVui3V
         qh9W3PD+dlqv8fB0mO2WJ6GX0SNbsROoFxuPktLo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 4.14.317
Date:   Fri,  9 Jun 2023 11:05:07 +0200
Message-ID: <2023060906-tiptoeing-cartel-9ca1@gregkh>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <2023060906-chevy-throwing-aed3@gregkh>
References: <2023060906-chevy-throwing-aed3@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index 4962d14e36a9..b5b5835afcc7 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 4
 PATCHLEVEL = 14
-SUBLEVEL = 316
+SUBLEVEL = 317
 EXTRAVERSION =
 NAME = Petit Gorille
 
@@ -731,6 +731,10 @@ endif
 KBUILD_CFLAGS += $(call cc-disable-warning, unused-but-set-variable)
 
 KBUILD_CFLAGS += $(call cc-disable-warning, unused-const-variable)
+
+# These result in bogus false positives
+KBUILD_CFLAGS += $(call cc-disable-warning, dangling-pointer)
+
 ifdef CONFIG_FRAME_POINTER
 KBUILD_CFLAGS	+= -fno-omit-frame-pointer -fno-optimize-sibling-calls
 else
diff --git a/arch/arm/kernel/unwind.c b/arch/arm/kernel/unwind.c
index 314cfb232a63..f2bb090373c6 100644
--- a/arch/arm/kernel/unwind.c
+++ b/arch/arm/kernel/unwind.c
@@ -313,6 +313,29 @@ static int unwind_exec_pop_subset_r0_to_r3(struct unwind_ctrl_block *ctrl,
 	return URC_OK;
 }
 
+static unsigned long unwind_decode_uleb128(struct unwind_ctrl_block *ctrl)
+{
+	unsigned long bytes = 0;
+	unsigned long insn;
+	unsigned long result = 0;
+
+	/*
+	 * unwind_get_byte() will advance `ctrl` one instruction at a time, so
+	 * loop until we get an instruction byte where bit 7 is not set.
+	 *
+	 * Note: This decodes a maximum of 4 bytes to output 28 bits data where
+	 * max is 0xfffffff: that will cover a vsp increment of 1073742336, hence
+	 * it is sufficient for unwinding the stack.
+	 */
+	do {
+		insn = unwind_get_byte(ctrl);
+		result |= (insn & 0x7f) << (bytes * 7);
+		bytes++;
+	} while (!!(insn & 0x80) && (bytes != sizeof(result)));
+
+	return result;
+}
+
 /*
  * Execute the current unwind instruction.
  */
@@ -366,7 +389,7 @@ static int unwind_exec_insn(struct unwind_ctrl_block *ctrl)
 		if (ret)
 			goto error;
 	} else if (insn == 0xb2) {
-		unsigned long uleb128 = unwind_get_byte(ctrl);
+		unsigned long uleb128 = unwind_decode_uleb128(ctrl);
 
 		ctrl->vrs[SP] += 0x204 + (uleb128 << 2);
 	} else {
diff --git a/arch/x86/boot/boot.h b/arch/x86/boot/boot.h
index ef5a9cc66fb8..a4c5fb92b1cb 100644
--- a/arch/x86/boot/boot.h
+++ b/arch/x86/boot/boot.h
@@ -114,66 +114,78 @@ typedef unsigned int addr_t;
 
 static inline u8 rdfs8(addr_t addr)
 {
+	u8 *ptr = (u8 *)absolute_pointer(addr);
 	u8 v;
-	asm volatile("movb %%fs:%1,%0" : "=q" (v) : "m" (*(u8 *)addr));
+	asm volatile("movb %%fs:%1,%0" : "=q" (v) : "m" (*ptr));
 	return v;
 }
 static inline u16 rdfs16(addr_t addr)
 {
+	u16 *ptr = (u16 *)absolute_pointer(addr);
 	u16 v;
-	asm volatile("movw %%fs:%1,%0" : "=r" (v) : "m" (*(u16 *)addr));
+	asm volatile("movw %%fs:%1,%0" : "=r" (v) : "m" (*ptr));
 	return v;
 }
 static inline u32 rdfs32(addr_t addr)
 {
+	u32 *ptr = (u32 *)absolute_pointer(addr);
 	u32 v;
-	asm volatile("movl %%fs:%1,%0" : "=r" (v) : "m" (*(u32 *)addr));
+	asm volatile("movl %%fs:%1,%0" : "=r" (v) : "m" (*ptr));
 	return v;
 }
 
 static inline void wrfs8(u8 v, addr_t addr)
 {
-	asm volatile("movb %1,%%fs:%0" : "+m" (*(u8 *)addr) : "qi" (v));
+	u8 *ptr = (u8 *)absolute_pointer(addr);
+	asm volatile("movb %1,%%fs:%0" : "+m" (*ptr) : "qi" (v));
 }
 static inline void wrfs16(u16 v, addr_t addr)
 {
-	asm volatile("movw %1,%%fs:%0" : "+m" (*(u16 *)addr) : "ri" (v));
+	u16 *ptr = (u16 *)absolute_pointer(addr);
+	asm volatile("movw %1,%%fs:%0" : "+m" (*ptr) : "ri" (v));
 }
 static inline void wrfs32(u32 v, addr_t addr)
 {
-	asm volatile("movl %1,%%fs:%0" : "+m" (*(u32 *)addr) : "ri" (v));
+	u32 *ptr = (u32 *)absolute_pointer(addr);
+	asm volatile("movl %1,%%fs:%0" : "+m" (*ptr) : "ri" (v));
 }
 
 static inline u8 rdgs8(addr_t addr)
 {
+	u8 *ptr = (u8 *)absolute_pointer(addr);
 	u8 v;
-	asm volatile("movb %%gs:%1,%0" : "=q" (v) : "m" (*(u8 *)addr));
+	asm volatile("movb %%gs:%1,%0" : "=q" (v) : "m" (*ptr));
 	return v;
 }
 static inline u16 rdgs16(addr_t addr)
 {
+	u16 *ptr = (u16 *)absolute_pointer(addr);
 	u16 v;
-	asm volatile("movw %%gs:%1,%0" : "=r" (v) : "m" (*(u16 *)addr));
+	asm volatile("movw %%gs:%1,%0" : "=r" (v) : "m" (*ptr));
 	return v;
 }
 static inline u32 rdgs32(addr_t addr)
 {
+	u32 *ptr = (u32 *)absolute_pointer(addr);
 	u32 v;
-	asm volatile("movl %%gs:%1,%0" : "=r" (v) : "m" (*(u32 *)addr));
+	asm volatile("movl %%gs:%1,%0" : "=r" (v) : "m" (*ptr));
 	return v;
 }
 
 static inline void wrgs8(u8 v, addr_t addr)
 {
-	asm volatile("movb %1,%%gs:%0" : "+m" (*(u8 *)addr) : "qi" (v));
+	u8 *ptr = (u8 *)absolute_pointer(addr);
+	asm volatile("movb %1,%%gs:%0" : "+m" (*ptr) : "qi" (v));
 }
 static inline void wrgs16(u16 v, addr_t addr)
 {
-	asm volatile("movw %1,%%gs:%0" : "+m" (*(u16 *)addr) : "ri" (v));
+	u16 *ptr = (u16 *)absolute_pointer(addr);
+	asm volatile("movw %1,%%gs:%0" : "+m" (*ptr) : "ri" (v));
 }
 static inline void wrgs32(u32 v, addr_t addr)
 {
-	asm volatile("movl %1,%%gs:%0" : "+m" (*(u32 *)addr) : "ri" (v));
+	u32 *ptr = (u32 *)absolute_pointer(addr);
+	asm volatile("movl %1,%%gs:%0" : "+m" (*ptr) : "ri" (v));
 }
 
 /* Note: these only return true/false, not a signed return value! */
diff --git a/arch/x86/boot/main.c b/arch/x86/boot/main.c
index 9bcea386db65..98b4ff1c51f3 100644
--- a/arch/x86/boot/main.c
+++ b/arch/x86/boot/main.c
@@ -34,7 +34,7 @@ static void copy_boot_params(void)
 		u16 cl_offset;
 	};
 	const struct old_cmdline * const oldcmd =
-		(const struct old_cmdline *)OLD_CL_ADDRESS;
+		absolute_pointer(OLD_CL_ADDRESS);
 
 	BUILD_BUG_ON(sizeof boot_params != 4096);
 	memcpy(&boot_params.hdr, &hdr, sizeof hdr);
diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 3bdab6eb33bf..cceb5ca357de 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -1172,8 +1172,6 @@ static int acpi_thermal_resume(struct device *dev)
 		return -EINVAL;
 
 	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
-		if (!(&tz->trips.active[i]))
-			break;
 		if (!tz->trips.active[i].flags.valid)
 			break;
 		tz->trips.active[i].flags.enabled = 1;
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index fdf7b5edd520..5728f458aad8 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3054,18 +3054,36 @@ static unsigned int atapi_xlat(struct ata_queued_cmd *qc)
 	return 0;
 }
 
-static struct ata_device *ata_find_dev(struct ata_port *ap, int devno)
+static struct ata_device *ata_find_dev(struct ata_port *ap, unsigned int devno)
 {
-	if (!sata_pmp_attached(ap)) {
-		if (likely(devno >= 0 &&
-			   devno < ata_link_max_devices(&ap->link)))
+	/*
+	 * For the non-PMP case, ata_link_max_devices() returns 1 (SATA case),
+	 * or 2 (IDE master + slave case). However, the former case includes
+	 * libsas hosted devices which are numbered per scsi host, leading
+	 * to devno potentially being larger than 0 but with each struct
+	 * ata_device having its own struct ata_port and struct ata_link.
+	 * To accommodate these, ignore devno and always use device number 0.
+	 */
+	if (likely(!sata_pmp_attached(ap))) {
+		int link_max_devices = ata_link_max_devices(&ap->link);
+
+		if (link_max_devices == 1)
+			return &ap->link.device[0];
+
+		if (devno < link_max_devices)
 			return &ap->link.device[devno];
-	} else {
-		if (likely(devno >= 0 &&
-			   devno < ap->nr_pmp_links))
-			return &ap->pmp_link[devno].device[0];
+
+		return NULL;
 	}
 
+	/*
+	 * For PMP-attached devices, the device number corresponds to C
+	 * (channel) of SCSI [H:C:I:L], indicating the port pmp link
+	 * for the device.
+	 */
+	if (devno < ap->nr_pmp_links)
+		return &ap->pmp_link[devno].device[0];
+
 	return NULL;
 }
 
diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index f01b8860ba14..eb2ca7f6ab3a 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1531,7 +1531,7 @@ static int nbd_dev_dbg_init(struct nbd_device *nbd)
 		return -EIO;
 
 	dir = debugfs_create_dir(nbd_name(nbd), nbd_dbg_dir);
-	if (!dir) {
+	if (IS_ERR(dir)) {
 		dev_err(nbd_to_dev(nbd), "Failed to create debugfs dir for '%s'\n",
 			nbd_name(nbd));
 		return -EIO;
@@ -1557,7 +1557,7 @@ static int nbd_dbg_init(void)
 	struct dentry *dbg_dir;
 
 	dbg_dir = debugfs_create_dir("nbd", NULL);
-	if (!dbg_dir)
+	if (IS_ERR(dbg_dir))
 		return -EIO;
 
 	nbd_dbg_dir = dbg_dir;
diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index a8cea236099a..982b69d017cd 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -1041,7 +1041,7 @@ static bool _trigger(struct pl330_thread *thrd)
 	return true;
 }
 
-static bool _start(struct pl330_thread *thrd)
+static bool pl330_start_thread(struct pl330_thread *thrd)
 {
 	switch (_state(thrd)) {
 	case PL330_STATE_FAULT_COMPLETING:
@@ -1584,7 +1584,7 @@ static int pl330_update(struct pl330_dmac *pl330)
 			thrd->req_running = -1;
 
 			/* Get going again ASAP */
-			_start(thrd);
+			pl330_start_thread(thrd);
 
 			/* For now, just make a list of callbacks to be done */
 			list_add_tail(&descdone->rqd, &pl330->req_done);
@@ -1974,7 +1974,7 @@ static void pl330_tasklet(unsigned long data)
 	} else {
 		/* Make sure the PL330 Channel thread is active */
 		spin_lock(&pch->thread->dmac->lock);
-		_start(pch->thread);
+		pl330_start_thread(pch->thread);
 		spin_unlock(&pch->thread->dmac->lock);
 	}
 
@@ -1992,7 +1992,7 @@ static void pl330_tasklet(unsigned long data)
 			if (power_down) {
 				pch->active = true;
 				spin_lock(&pch->thread->dmac->lock);
-				_start(pch->thread);
+				pl330_start_thread(pch->thread);
 				spin_unlock(&pch->thread->dmac->lock);
 				power_down = false;
 			}
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 1b0161c2cd7a..be30fdbc37c5 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -743,7 +743,7 @@ static int wacom_intuos_inout(struct wacom_wac *wacom)
 	/* Enter report */
 	if ((data[1] & 0xfc) == 0xc0) {
 		/* serial number of the tool */
-		wacom->serial[idx] = ((data[3] & 0x0f) << 28) +
+		wacom->serial[idx] = ((__u64)(data[3] & 0x0f) << 28) +
 			(data[4] << 20) + (data[5] << 12) +
 			(data[6] << 4) + (data[7] >> 4);
 
diff --git a/drivers/iio/adc/mxs-lradc-adc.c b/drivers/iio/adc/mxs-lradc-adc.c
index 8c193d006967..abf0e3ccb44d 100644
--- a/drivers/iio/adc/mxs-lradc-adc.c
+++ b/drivers/iio/adc/mxs-lradc-adc.c
@@ -769,13 +769,13 @@ static int mxs_lradc_adc_probe(struct platform_device *pdev)
 
 	ret = mxs_lradc_adc_trigger_init(iio);
 	if (ret)
-		goto err_trig;
+		return ret;
 
 	ret = iio_triggered_buffer_setup(iio, &iio_pollfunc_store_time,
 					 &mxs_lradc_adc_trigger_handler,
 					 &mxs_lradc_adc_buffer_ops);
 	if (ret)
-		return ret;
+		goto err_trig;
 
 	adc->vref_mv = mxs_lradc_adc_vref_mv[lradc->soc];
 
@@ -813,9 +813,9 @@ static int mxs_lradc_adc_probe(struct platform_device *pdev)
 
 err_dev:
 	mxs_lradc_adc_hw_stop(adc);
-	mxs_lradc_adc_trigger_remove(iio);
-err_trig:
 	iio_triggered_buffer_cleanup(iio);
+err_trig:
+	mxs_lradc_adc_trigger_remove(iio);
 	return ret;
 }
 
@@ -826,8 +826,8 @@ static int mxs_lradc_adc_remove(struct platform_device *pdev)
 
 	iio_device_unregister(iio);
 	mxs_lradc_adc_hw_stop(adc);
-	mxs_lradc_adc_trigger_remove(iio);
 	iio_triggered_buffer_cleanup(iio);
+	mxs_lradc_adc_trigger_remove(iio);
 
 	return 0;
 }
diff --git a/drivers/iio/dac/mcp4725.c b/drivers/iio/dac/mcp4725.c
index fe3e42defb33..3b987a378bef 100644
--- a/drivers/iio/dac/mcp4725.c
+++ b/drivers/iio/dac/mcp4725.c
@@ -50,12 +50,18 @@ static int mcp4725_suspend(struct device *dev)
 	struct mcp4725_data *data = iio_priv(i2c_get_clientdata(
 		to_i2c_client(dev)));
 	u8 outbuf[2];
+	int ret;
 
 	outbuf[0] = (data->powerdown_mode + 1) << 4;
 	outbuf[1] = 0;
 	data->powerdown = true;
 
-	return i2c_master_send(data->client, outbuf, 2);
+	ret = i2c_master_send(data->client, outbuf, 2);
+	if (ret < 0)
+		return ret;
+	else if (ret != 2)
+		return -EIO;
+	return 0;
 }
 
 static int mcp4725_resume(struct device *dev)
@@ -63,13 +69,19 @@ static int mcp4725_resume(struct device *dev)
 	struct mcp4725_data *data = iio_priv(i2c_get_clientdata(
 		to_i2c_client(dev)));
 	u8 outbuf[2];
+	int ret;
 
 	/* restore previous DAC value */
 	outbuf[0] = (data->dac_value >> 8) & 0xf;
 	outbuf[1] = data->dac_value & 0xff;
 	data->powerdown = false;
 
-	return i2c_master_send(data->client, outbuf, 2);
+	ret = i2c_master_send(data->client, outbuf, 2);
+	if (ret < 0)
+		return ret;
+	else if (ret != 2)
+		return -EIO;
+	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
diff --git a/drivers/mailbox/mailbox-test.c b/drivers/mailbox/mailbox-test.c
index 546ba140f83d..1dbbc9036bb8 100644
--- a/drivers/mailbox/mailbox-test.c
+++ b/drivers/mailbox/mailbox-test.c
@@ -16,6 +16,7 @@
 #include <linux/kernel.h>
 #include <linux/mailbox_client.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/poll.h>
@@ -43,6 +44,7 @@ struct mbox_test_device {
 	char			*signal;
 	char			*message;
 	spinlock_t		lock;
+	struct mutex		mutex;
 	wait_queue_head_t	waitq;
 	struct fasync_struct	*async_queue;
 };
@@ -99,6 +101,7 @@ static ssize_t mbox_test_message_write(struct file *filp,
 				       size_t count, loff_t *ppos)
 {
 	struct mbox_test_device *tdev = filp->private_data;
+	char *message;
 	void *data;
 	int ret;
 
@@ -114,10 +117,13 @@ static ssize_t mbox_test_message_write(struct file *filp,
 		return -EINVAL;
 	}
 
-	tdev->message = kzalloc(MBOX_MAX_MSG_LEN, GFP_KERNEL);
-	if (!tdev->message)
+	message = kzalloc(MBOX_MAX_MSG_LEN, GFP_KERNEL);
+	if (!message)
 		return -ENOMEM;
 
+	mutex_lock(&tdev->mutex);
+
+	tdev->message = message;
 	ret = copy_from_user(tdev->message, userbuf, count);
 	if (ret) {
 		ret = -EFAULT;
@@ -148,6 +154,8 @@ static ssize_t mbox_test_message_write(struct file *filp,
 	kfree(tdev->message);
 	tdev->signal = NULL;
 
+	mutex_unlock(&tdev->mutex);
+
 	return ret < 0 ? ret : count;
 }
 
@@ -396,6 +404,7 @@ static int mbox_test_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, tdev);
 
 	spin_lock_init(&tdev->lock);
+	mutex_init(&tdev->mutex);
 
 	if (tdev->rx_channel) {
 		tdev->rx_buffer = devm_kzalloc(&pdev->dev,
diff --git a/drivers/media/dvb-core/dvb_ca_en50221.c b/drivers/media/dvb-core/dvb_ca_en50221.c
index 56114d85510f..5dc8b2d14352 100644
--- a/drivers/media/dvb-core/dvb_ca_en50221.c
+++ b/drivers/media/dvb-core/dvb_ca_en50221.c
@@ -161,6 +161,12 @@ struct dvb_ca_private {
 
 	/* mutex serializing ioctls */
 	struct mutex ioctl_mutex;
+
+	/* A mutex used when a device is disconnected */
+	struct mutex remove_mutex;
+
+	/* Whether the device is disconnected */
+	int exit;
 };
 
 static void dvb_ca_private_free(struct dvb_ca_private *ca)
@@ -1713,12 +1719,22 @@ static int dvb_ca_en50221_io_open(struct inode *inode, struct file *file)
 
 	dprintk("%s\n", __func__);
 
-	if (!try_module_get(ca->pub->owner))
+	mutex_lock(&ca->remove_mutex);
+
+	if (ca->exit) {
+		mutex_unlock(&ca->remove_mutex);
+		return -ENODEV;
+	}
+
+	if (!try_module_get(ca->pub->owner)) {
+		mutex_unlock(&ca->remove_mutex);
 		return -EIO;
+	}
 
 	err = dvb_generic_open(inode, file);
 	if (err < 0) {
 		module_put(ca->pub->owner);
+		mutex_unlock(&ca->remove_mutex);
 		return err;
 	}
 
@@ -1743,6 +1759,7 @@ static int dvb_ca_en50221_io_open(struct inode *inode, struct file *file)
 
 	dvb_ca_private_get(ca);
 
+	mutex_unlock(&ca->remove_mutex);
 	return 0;
 }
 
@@ -1762,6 +1779,8 @@ static int dvb_ca_en50221_io_release(struct inode *inode, struct file *file)
 
 	dprintk("%s\n", __func__);
 
+	mutex_lock(&ca->remove_mutex);
+
 	/* mark the CA device as closed */
 	ca->open = 0;
 	dvb_ca_en50221_thread_update_delay(ca);
@@ -1772,6 +1791,13 @@ static int dvb_ca_en50221_io_release(struct inode *inode, struct file *file)
 
 	dvb_ca_private_put(ca);
 
+	if (dvbdev->users == 1 && ca->exit == 1) {
+		mutex_unlock(&ca->remove_mutex);
+		wake_up(&dvbdev->wait_queue);
+	} else {
+		mutex_unlock(&ca->remove_mutex);
+	}
+
 	return err;
 }
 
@@ -1896,6 +1922,7 @@ int dvb_ca_en50221_init(struct dvb_adapter *dvb_adapter,
 	}
 
 	mutex_init(&ca->ioctl_mutex);
+	mutex_init(&ca->remove_mutex);
 
 	if (signal_pending(current)) {
 		ret = -EINTR;
@@ -1939,6 +1966,14 @@ void dvb_ca_en50221_release(struct dvb_ca_en50221 *pubca)
 
 	dprintk("%s\n", __func__);
 
+	mutex_lock(&ca->remove_mutex);
+	ca->exit = 1;
+	mutex_unlock(&ca->remove_mutex);
+
+	if (ca->dvbdev->users < 1)
+		wait_event(ca->dvbdev->wait_queue,
+				ca->dvbdev->users == 1);
+
 	/* shutdown the thread if there was one */
 	kthread_stop(ca->thread);
 
diff --git a/drivers/media/dvb-core/dvb_frontend.c b/drivers/media/dvb-core/dvb_frontend.c
index e3a4a4688c2e..651234584eb2 100644
--- a/drivers/media/dvb-core/dvb_frontend.c
+++ b/drivers/media/dvb-core/dvb_frontend.c
@@ -301,14 +301,22 @@ static int dvb_frontend_get_event(struct dvb_frontend *fe,
 	}
 
 	if (events->eventw == events->eventr) {
-		int ret;
+		struct wait_queue_entry wait;
+		int ret = 0;
 
 		if (flags & O_NONBLOCK)
 			return -EWOULDBLOCK;
 
-		ret = wait_event_interruptible(events->wait_queue,
-					       dvb_frontend_test_event(fepriv, events));
-
+		init_waitqueue_entry(&wait, current);
+		add_wait_queue(&events->wait_queue, &wait);
+		while (!dvb_frontend_test_event(fepriv, events)) {
+			wait_woken(&wait, TASK_INTERRUPTIBLE, 0);
+			if (signal_pending(current)) {
+				ret = -ERESTARTSYS;
+				break;
+			}
+		}
+		remove_wait_queue(&events->wait_queue, &wait);
 		if (ret < 0)
 			return ret;
 	}
diff --git a/drivers/media/pci/netup_unidvb/netup_unidvb_core.c b/drivers/media/pci/netup_unidvb/netup_unidvb_core.c
index 4f2ea0f035ae..0a9086f8c759 100644
--- a/drivers/media/pci/netup_unidvb/netup_unidvb_core.c
+++ b/drivers/media/pci/netup_unidvb/netup_unidvb_core.c
@@ -897,12 +897,7 @@ static int netup_unidvb_initdev(struct pci_dev *pci_dev,
 		ndev->lmmio0, (u32)pci_resource_len(pci_dev, 0),
 		ndev->lmmio1, (u32)pci_resource_len(pci_dev, 1),
 		pci_dev->irq);
-	if (request_irq(pci_dev->irq, netup_unidvb_isr, IRQF_SHARED,
-			"netup_unidvb", pci_dev) < 0) {
-		dev_err(&pci_dev->dev,
-			"%s(): can't get IRQ %d\n", __func__, pci_dev->irq);
-		goto irq_request_err;
-	}
+
 	ndev->dma_size = 2 * 188 *
 		NETUP_DMA_BLOCKS_COUNT * NETUP_DMA_PACKETS_COUNT;
 	ndev->dma_virt = dma_alloc_coherent(&pci_dev->dev,
@@ -943,6 +938,14 @@ static int netup_unidvb_initdev(struct pci_dev *pci_dev,
 		dev_err(&pci_dev->dev, "netup_unidvb: DMA setup failed\n");
 		goto dma_setup_err;
 	}
+
+	if (request_irq(pci_dev->irq, netup_unidvb_isr, IRQF_SHARED,
+			"netup_unidvb", pci_dev) < 0) {
+		dev_err(&pci_dev->dev,
+			"%s(): can't get IRQ %d\n", __func__, pci_dev->irq);
+		goto dma_setup_err;
+	}
+
 	dev_info(&pci_dev->dev,
 		"netup_unidvb: device has been initialized\n");
 	return 0;
@@ -961,8 +964,6 @@ static int netup_unidvb_initdev(struct pci_dev *pci_dev,
 	dma_free_coherent(&pci_dev->dev, ndev->dma_size,
 			ndev->dma_virt, ndev->dma_phys);
 dma_alloc_err:
-	free_irq(pci_dev->irq, pci_dev);
-irq_request_err:
 	iounmap(ndev->lmmio1);
 pci_bar1_error:
 	iounmap(ndev->lmmio0);
diff --git a/drivers/media/usb/dvb-usb-v2/ce6230.c b/drivers/media/usb/dvb-usb-v2/ce6230.c
index e596031a708d..80a07aab3b4b 100644
--- a/drivers/media/usb/dvb-usb-v2/ce6230.c
+++ b/drivers/media/usb/dvb-usb-v2/ce6230.c
@@ -111,6 +111,10 @@ static int ce6230_i2c_master_xfer(struct i2c_adapter *adap,
 		if (num > i + 1 && (msg[i+1].flags & I2C_M_RD)) {
 			if (msg[i].addr ==
 				ce6230_zl10353_config.demod_address) {
+				if (msg[i].len < 1) {
+					i = -EOPNOTSUPP;
+					break;
+				}
 				req.cmd = DEMOD_READ;
 				req.value = msg[i].addr >> 1;
 				req.index = msg[i].buf[0];
@@ -127,6 +131,10 @@ static int ce6230_i2c_master_xfer(struct i2c_adapter *adap,
 		} else {
 			if (msg[i].addr ==
 				ce6230_zl10353_config.demod_address) {
+				if (msg[i].len < 1) {
+					i = -EOPNOTSUPP;
+					break;
+				}
 				req.cmd = DEMOD_WRITE;
 				req.value = msg[i].addr >> 1;
 				req.index = msg[i].buf[0];
diff --git a/drivers/media/usb/dvb-usb-v2/ec168.c b/drivers/media/usb/dvb-usb-v2/ec168.c
index 1db8aeef3655..19605958501e 100644
--- a/drivers/media/usb/dvb-usb-v2/ec168.c
+++ b/drivers/media/usb/dvb-usb-v2/ec168.c
@@ -125,6 +125,10 @@ static int ec168_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 	while (i < num) {
 		if (num > i + 1 && (msg[i+1].flags & I2C_M_RD)) {
 			if (msg[i].addr == ec168_ec100_config.demod_address) {
+				if (msg[i].len < 1) {
+					i = -EOPNOTSUPP;
+					break;
+				}
 				req.cmd = READ_DEMOD;
 				req.value = 0;
 				req.index = 0xff00 + msg[i].buf[0]; /* reg */
@@ -141,6 +145,10 @@ static int ec168_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 			}
 		} else {
 			if (msg[i].addr == ec168_ec100_config.demod_address) {
+				if (msg[i].len < 1) {
+					i = -EOPNOTSUPP;
+					break;
+				}
 				req.cmd = WRITE_DEMOD;
 				req.value = msg[i].buf[1]; /* val */
 				req.index = 0xff00 + msg[i].buf[0]; /* reg */
@@ -149,6 +157,10 @@ static int ec168_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 				ret = ec168_ctrl_msg(d, &req);
 				i += 1;
 			} else {
+				if (msg[i].len < 1) {
+					i = -EOPNOTSUPP;
+					break;
+				}
 				req.cmd = WRITE_I2C;
 				req.value = msg[i].buf[0]; /* val */
 				req.index = 0x0100 + msg[i].addr; /* I2C addr */
diff --git a/drivers/media/usb/dvb-usb-v2/rtl28xxu.c b/drivers/media/usb/dvb-usb-v2/rtl28xxu.c
index bfce2d6addf7..5c0ad2dc315a 100644
--- a/drivers/media/usb/dvb-usb-v2/rtl28xxu.c
+++ b/drivers/media/usb/dvb-usb-v2/rtl28xxu.c
@@ -189,6 +189,10 @@ static int rtl28xxu_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 			ret = -EOPNOTSUPP;
 			goto err_mutex_unlock;
 		} else if (msg[0].addr == 0x10) {
+			if (msg[0].len < 1 || msg[1].len < 1) {
+				ret = -EOPNOTSUPP;
+				goto err_mutex_unlock;
+			}
 			/* method 1 - integrated demod */
 			if (msg[0].buf[0] == 0x00) {
 				/* return demod page from driver cache */
@@ -202,6 +206,10 @@ static int rtl28xxu_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 				ret = rtl28xxu_ctrl_msg(d, &req);
 			}
 		} else if (msg[0].len < 2) {
+			if (msg[0].len < 1) {
+				ret = -EOPNOTSUPP;
+				goto err_mutex_unlock;
+			}
 			/* method 2 - old I2C */
 			req.value = (msg[0].buf[0] << 8) | (msg[0].addr << 1);
 			req.index = CMD_I2C_RD;
@@ -230,8 +238,16 @@ static int rtl28xxu_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 			ret = -EOPNOTSUPP;
 			goto err_mutex_unlock;
 		} else if (msg[0].addr == 0x10) {
+			if (msg[0].len < 1) {
+				ret = -EOPNOTSUPP;
+				goto err_mutex_unlock;
+			}
 			/* method 1 - integrated demod */
 			if (msg[0].buf[0] == 0x00) {
+				if (msg[0].len < 2) {
+					ret = -EOPNOTSUPP;
+					goto err_mutex_unlock;
+				}
 				/* save demod page for later demod access */
 				dev->page = msg[0].buf[1];
 				ret = 0;
@@ -244,6 +260,10 @@ static int rtl28xxu_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 				ret = rtl28xxu_ctrl_msg(d, &req);
 			}
 		} else if ((msg[0].len < 23) && (!dev->new_i2c_write)) {
+			if (msg[0].len < 1) {
+				ret = -EOPNOTSUPP;
+				goto err_mutex_unlock;
+			}
 			/* method 2 - old I2C */
 			req.value = (msg[0].buf[0] << 8) | (msg[0].addr << 1);
 			req.index = CMD_I2C_WR;
diff --git a/drivers/media/usb/dvb-usb/az6027.c b/drivers/media/usb/dvb-usb/az6027.c
index f2b5ba1d2809..05988c5ce63c 100644
--- a/drivers/media/usb/dvb-usb/az6027.c
+++ b/drivers/media/usb/dvb-usb/az6027.c
@@ -991,6 +991,10 @@ static int az6027_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msg[], int n
 			/* write/read request */
 			if (i + 1 < num && (msg[i + 1].flags & I2C_M_RD)) {
 				req = 0xB9;
+				if (msg[i].len < 1) {
+					i = -EOPNOTSUPP;
+					break;
+				}
 				index = (((msg[i].buf[0] << 8) & 0xff00) | (msg[i].buf[1] & 0x00ff));
 				value = msg[i].addr + (msg[i].len << 8);
 				length = msg[i + 1].len + 6;
@@ -1004,6 +1008,10 @@ static int az6027_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msg[], int n
 
 				/* demod 16bit addr */
 				req = 0xBD;
+				if (msg[i].len < 1) {
+					i = -EOPNOTSUPP;
+					break;
+				}
 				index = (((msg[i].buf[0] << 8) & 0xff00) | (msg[i].buf[1] & 0x00ff));
 				value = msg[i].addr + (2 << 8);
 				length = msg[i].len - 2;
@@ -1029,6 +1037,10 @@ static int az6027_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msg[], int n
 			} else {
 
 				req = 0xBD;
+				if (msg[i].len < 1) {
+					i = -EOPNOTSUPP;
+					break;
+				}
 				index = msg[i].buf[0] & 0x00FF;
 				value = msg[i].addr + (1 << 8);
 				length = msg[i].len - 1;
diff --git a/drivers/media/usb/dvb-usb/digitv.c b/drivers/media/usb/dvb-usb/digitv.c
index 20d33f0544ed..0e2cffa946f6 100644
--- a/drivers/media/usb/dvb-usb/digitv.c
+++ b/drivers/media/usb/dvb-usb/digitv.c
@@ -66,6 +66,10 @@ static int digitv_i2c_xfer(struct i2c_adapter *adap,struct i2c_msg msg[],int num
 		warn("more than 2 i2c messages at a time is not handled yet. TODO.");
 
 	for (i = 0; i < num; i++) {
+		if (msg[i].len < 1) {
+			i = -EOPNOTSUPP;
+			break;
+		}
 		/* write/read request */
 		if (i+1 < num && (msg[i+1].flags & I2C_M_RD)) {
 			if (digitv_ctrl_msg(d, USB_READ_COFDM, msg[i].buf[0], NULL, 0,
diff --git a/drivers/media/usb/dvb-usb/dw2102.c b/drivers/media/usb/dvb-usb/dw2102.c
index 98770a95721b..2c9c4432a0e6 100644
--- a/drivers/media/usb/dvb-usb/dw2102.c
+++ b/drivers/media/usb/dvb-usb/dw2102.c
@@ -951,7 +951,7 @@ static int su3000_read_mac_address(struct dvb_usb_device *d, u8 mac[6])
 	for (i = 0; i < 6; i++) {
 		obuf[1] = 0xf0 + i;
 		if (i2c_transfer(&d->i2c_adap, msg, 2) != 2)
-			break;
+			return -1;
 		else
 			mac[i] = ibuf[0];
 	}
diff --git a/drivers/media/usb/ttusb-dec/ttusb_dec.c b/drivers/media/usb/ttusb-dec/ttusb_dec.c
index cad274615816..d41ba8088175 100644
--- a/drivers/media/usb/ttusb-dec/ttusb_dec.c
+++ b/drivers/media/usb/ttusb-dec/ttusb_dec.c
@@ -1571,8 +1571,7 @@ static void ttusb_dec_exit_dvb(struct ttusb_dec *dec)
 	dvb_dmx_release(&dec->demux);
 	if (dec->fe) {
 		dvb_unregister_frontend(dec->fe);
-		if (dec->fe->ops.release)
-			dec->fe->ops.release(dec->fe);
+		dvb_frontend_detach(dec->fe);
 	}
 	dvb_unregister_adapter(&dec->adapter);
 }
diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
index 8ab330dc7208..85d0a171256d 100644
--- a/drivers/mmc/host/vub300.c
+++ b/drivers/mmc/host/vub300.c
@@ -1718,6 +1718,9 @@ static void construct_request_response(struct vub300_mmc_host *vub300,
 	int bytes = 3 & less_cmd;
 	int words = less_cmd >> 2;
 	u8 *r = vub300->resp.response.command_response;
+
+	if (!resp_len)
+		return;
 	if (bytes == 3) {
 		cmd->resp[words] = (r[1 + (words << 2)] << 24)
 			| (r[2 + (words << 2)] << 16)
diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index ef016c9f7c74..e8f6d70c1ec6 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -4060,7 +4060,7 @@ static int mv88e6xxx_probe(struct mdio_device *mdiodev)
 		}
 	}
 	if (chip->reset)
-		usleep_range(1000, 2000);
+		usleep_range(10000, 20000);
 
 	err = mv88e6xxx_mdios_register(chip, np);
 	if (err)
diff --git a/drivers/net/ethernet/sun/cassini.c b/drivers/net/ethernet/sun/cassini.c
index ba546f993fb5..0d26e8047d70 100644
--- a/drivers/net/ethernet/sun/cassini.c
+++ b/drivers/net/ethernet/sun/cassini.c
@@ -1349,7 +1349,7 @@ static void cas_init_rx_dma(struct cas *cp)
 	writel(val, cp->regs + REG_RX_PAGE_SIZE);
 
 	/* enable the header parser if desired */
-	if (CAS_HP_FIRMWARE == cas_prog_null)
+	if (&CAS_HP_FIRMWARE[0] == &cas_prog_null[0])
 		return;
 
 	val = CAS_BASE(HP_CFG_NUM_CPU, CAS_NCPUS > 63 ? 0 : CAS_NCPUS);
@@ -3819,7 +3819,7 @@ static void cas_reset(struct cas *cp, int blkflag)
 
 	/* program header parser */
 	if ((cp->cas_flags & CAS_FLAG_TARGET_ABORT) ||
-	    (CAS_HP_ALT_FIRMWARE == cas_prog_null)) {
+	    (&CAS_HP_ALT_FIRMWARE[0] == &cas_prog_null[0])) {
 		cas_load_firmware(cp, CAS_HP_FIRMWARE);
 	} else {
 		cas_load_firmware(cp, CAS_HP_ALT_FIRMWARE);
diff --git a/drivers/net/usb/cdc_ncm.c b/drivers/net/usb/cdc_ncm.c
index 7e4595510c93..ac6091ceb5f8 100644
--- a/drivers/net/usb/cdc_ncm.c
+++ b/drivers/net/usb/cdc_ncm.c
@@ -175,10 +175,17 @@ static u32 cdc_ncm_check_tx_max(struct usbnet *dev, u32 new_tx)
 	u32 val, max, min;
 
 	/* clamp new_tx to sane values */
-	min = ctx->max_datagram_size + ctx->max_ndp_size + sizeof(struct usb_cdc_ncm_nth16);
-	max = min_t(u32, CDC_NCM_NTB_MAX_SIZE_TX, le32_to_cpu(ctx->ncm_parm.dwNtbOutMaxSize));
-	if (max == 0)
+	if (ctx->is_ndp16)
+		min = ctx->max_datagram_size + ctx->max_ndp_size + sizeof(struct usb_cdc_ncm_nth16);
+	else
+		min = ctx->max_datagram_size + ctx->max_ndp_size + sizeof(struct usb_cdc_ncm_nth32);
+
+	if (le32_to_cpu(ctx->ncm_parm.dwNtbOutMaxSize) == 0)
 		max = CDC_NCM_NTB_MAX_SIZE_TX; /* dwNtbOutMaxSize not set */
+	else
+		max = clamp_t(u32, le32_to_cpu(ctx->ncm_parm.dwNtbOutMaxSize),
+			      USB_CDC_NCM_NTB_MIN_OUT_SIZE,
+			      CDC_NCM_NTB_MAX_SIZE_TX);
 
 	/* some devices set dwNtbOutMaxSize too low for the above default */
 	min = min(min, max);
@@ -309,10 +316,17 @@ static ssize_t ndp_to_end_store(struct device *d,  struct device_attribute *attr
 	if (enable == (ctx->drvflags & CDC_NCM_FLAG_NDP_TO_END))
 		return len;
 
-	if (enable && !ctx->delayed_ndp16) {
-		ctx->delayed_ndp16 = kzalloc(ctx->max_ndp_size, GFP_KERNEL);
-		if (!ctx->delayed_ndp16)
-			return -ENOMEM;
+	if (enable) {
+		if (ctx->is_ndp16 && !ctx->delayed_ndp16) {
+			ctx->delayed_ndp16 = kzalloc(ctx->max_ndp_size, GFP_KERNEL);
+			if (!ctx->delayed_ndp16)
+				return -ENOMEM;
+		}
+		if (!ctx->is_ndp16 && !ctx->delayed_ndp32) {
+			ctx->delayed_ndp32 = kzalloc(ctx->max_ndp_size, GFP_KERNEL);
+			if (!ctx->delayed_ndp32)
+				return -ENOMEM;
+		}
 	}
 
 	/* flush pending data before changing flag */
@@ -514,6 +528,9 @@ static int cdc_ncm_init(struct usbnet *dev)
 			dev_err(&dev->intf->dev, "SET_CRC_MODE failed\n");
 	}
 
+	/* use ndp16 by default */
+	ctx->is_ndp16 = 1;
+
 	/* set NTB format, if both formats are supported.
 	 *
 	 * "The host shall only send this command while the NCM Data
@@ -521,14 +538,27 @@ static int cdc_ncm_init(struct usbnet *dev)
 	 */
 	if (le16_to_cpu(ctx->ncm_parm.bmNtbFormatsSupported) &
 						USB_CDC_NCM_NTB32_SUPPORTED) {
-		dev_dbg(&dev->intf->dev, "Setting NTB format to 16-bit\n");
-		err = usbnet_write_cmd(dev, USB_CDC_SET_NTB_FORMAT,
-				       USB_TYPE_CLASS | USB_DIR_OUT
-				       | USB_RECIP_INTERFACE,
-				       USB_CDC_NCM_NTB16_FORMAT,
-				       iface_no, NULL, 0);
-		if (err < 0)
+		if (ctx->drvflags & CDC_NCM_FLAG_PREFER_NTB32) {
+			ctx->is_ndp16 = 0;
+			dev_dbg(&dev->intf->dev, "Setting NTB format to 32-bit\n");
+			err = usbnet_write_cmd(dev, USB_CDC_SET_NTB_FORMAT,
+					       USB_TYPE_CLASS | USB_DIR_OUT
+					       | USB_RECIP_INTERFACE,
+					       USB_CDC_NCM_NTB32_FORMAT,
+					       iface_no, NULL, 0);
+		} else {
+			ctx->is_ndp16 = 1;
+			dev_dbg(&dev->intf->dev, "Setting NTB format to 16-bit\n");
+			err = usbnet_write_cmd(dev, USB_CDC_SET_NTB_FORMAT,
+					       USB_TYPE_CLASS | USB_DIR_OUT
+					       | USB_RECIP_INTERFACE,
+					       USB_CDC_NCM_NTB16_FORMAT,
+					       iface_no, NULL, 0);
+		}
+		if (err < 0) {
+			ctx->is_ndp16 = 1;
 			dev_err(&dev->intf->dev, "SET_NTB_FORMAT failed\n");
+		}
 	}
 
 	/* set initial device values */
@@ -551,7 +581,10 @@ static int cdc_ncm_init(struct usbnet *dev)
 		ctx->tx_max_datagrams = CDC_NCM_DPT_DATAGRAMS_MAX;
 
 	/* set up maximum NDP size */
-	ctx->max_ndp_size = sizeof(struct usb_cdc_ncm_ndp16) + (ctx->tx_max_datagrams + 1) * sizeof(struct usb_cdc_ncm_dpe16);
+	if (ctx->is_ndp16)
+		ctx->max_ndp_size = sizeof(struct usb_cdc_ncm_ndp16) + (ctx->tx_max_datagrams + 1) * sizeof(struct usb_cdc_ncm_dpe16);
+	else
+		ctx->max_ndp_size = sizeof(struct usb_cdc_ncm_ndp32) + (ctx->tx_max_datagrams + 1) * sizeof(struct usb_cdc_ncm_dpe32);
 
 	/* initial coalescing timer interval */
 	ctx->timer_interval = CDC_NCM_TIMER_INTERVAL_USEC * NSEC_PER_USEC;
@@ -736,7 +769,10 @@ static void cdc_ncm_free(struct cdc_ncm_ctx *ctx)
 		ctx->tx_curr_skb = NULL;
 	}
 
-	kfree(ctx->delayed_ndp16);
+	if (ctx->is_ndp16)
+		kfree(ctx->delayed_ndp16);
+	else
+		kfree(ctx->delayed_ndp32);
 
 	kfree(ctx);
 }
@@ -774,10 +810,8 @@ int cdc_ncm_bind_common(struct usbnet *dev, struct usb_interface *intf, u8 data_
 	u8 *buf;
 	int len;
 	int temp;
-	int err;
 	u8 iface_no;
 	struct usb_cdc_parsed_header hdr;
-	__le16 curr_ntb_format;
 
 	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
@@ -882,32 +916,6 @@ int cdc_ncm_bind_common(struct usbnet *dev, struct usb_interface *intf, u8 data_
 		goto error2;
 	}
 
-	/*
-	 * Some Huawei devices have been observed to come out of reset in NDP32 mode.
-	 * Let's check if this is the case, and set the device to NDP16 mode again if
-	 * needed.
-	*/
-	if (ctx->drvflags & CDC_NCM_FLAG_RESET_NTB16) {
-		err = usbnet_read_cmd(dev, USB_CDC_GET_NTB_FORMAT,
-				      USB_TYPE_CLASS | USB_DIR_IN | USB_RECIP_INTERFACE,
-				      0, iface_no, &curr_ntb_format, 2);
-		if (err < 0) {
-			goto error2;
-		}
-
-		if (curr_ntb_format == cpu_to_le16(USB_CDC_NCM_NTB32_FORMAT)) {
-			dev_info(&intf->dev, "resetting NTB format to 16-bit");
-			err = usbnet_write_cmd(dev, USB_CDC_SET_NTB_FORMAT,
-					       USB_TYPE_CLASS | USB_DIR_OUT
-					       | USB_RECIP_INTERFACE,
-					       USB_CDC_NCM_NTB16_FORMAT,
-					       iface_no, NULL, 0);
-
-			if (err < 0)
-				goto error2;
-		}
-	}
-
 	cdc_ncm_find_endpoints(dev, ctx->data);
 	cdc_ncm_find_endpoints(dev, ctx->control);
 	if (!dev->in || !dev->out || !dev->status) {
@@ -932,9 +940,15 @@ int cdc_ncm_bind_common(struct usbnet *dev, struct usb_interface *intf, u8 data_
 
 	/* Allocate the delayed NDP if needed. */
 	if (ctx->drvflags & CDC_NCM_FLAG_NDP_TO_END) {
-		ctx->delayed_ndp16 = kzalloc(ctx->max_ndp_size, GFP_KERNEL);
-		if (!ctx->delayed_ndp16)
-			goto error2;
+		if (ctx->is_ndp16) {
+			ctx->delayed_ndp16 = kzalloc(ctx->max_ndp_size, GFP_KERNEL);
+			if (!ctx->delayed_ndp16)
+				goto error2;
+		} else {
+			ctx->delayed_ndp32 = kzalloc(ctx->max_ndp_size, GFP_KERNEL);
+			if (!ctx->delayed_ndp32)
+				goto error2;
+		}
 		dev_info(&intf->dev, "NDP will be placed at end of frame for this device.");
 	}
 
@@ -1059,7 +1073,7 @@ static void cdc_ncm_align_tail(struct sk_buff *skb, size_t modulus, size_t remai
 /* return a pointer to a valid struct usb_cdc_ncm_ndp16 of type sign, possibly
  * allocating a new one within skb
  */
-static struct usb_cdc_ncm_ndp16 *cdc_ncm_ndp(struct cdc_ncm_ctx *ctx, struct sk_buff *skb, __le32 sign, size_t reserve)
+static struct usb_cdc_ncm_ndp16 *cdc_ncm_ndp16(struct cdc_ncm_ctx *ctx, struct sk_buff *skb, __le32 sign, size_t reserve)
 {
 	struct usb_cdc_ncm_ndp16 *ndp16 = NULL;
 	struct usb_cdc_ncm_nth16 *nth16 = (void *)skb->data;
@@ -1114,12 +1128,73 @@ static struct usb_cdc_ncm_ndp16 *cdc_ncm_ndp(struct cdc_ncm_ctx *ctx, struct sk_
 	return ndp16;
 }
 
+static struct usb_cdc_ncm_ndp32 *cdc_ncm_ndp32(struct cdc_ncm_ctx *ctx, struct sk_buff *skb, __le32 sign, size_t reserve)
+{
+	struct usb_cdc_ncm_ndp32 *ndp32 = NULL;
+	struct usb_cdc_ncm_nth32 *nth32 = (void *)skb->data;
+	size_t ndpoffset = le32_to_cpu(nth32->dwNdpIndex);
+
+	/* If NDP should be moved to the end of the NCM package, we can't follow the
+	 * NTH32 header as we would normally do. NDP isn't written to the SKB yet, and
+	 * the wNdpIndex field in the header is actually not consistent with reality. It will be later.
+	 */
+	if (ctx->drvflags & CDC_NCM_FLAG_NDP_TO_END) {
+		if (ctx->delayed_ndp32->dwSignature == sign)
+			return ctx->delayed_ndp32;
+
+		/* We can only push a single NDP to the end. Return
+		 * NULL to send what we've already got and queue this
+		 * skb for later.
+		 */
+		else if (ctx->delayed_ndp32->dwSignature)
+			return NULL;
+	}
+
+	/* follow the chain of NDPs, looking for a match */
+	while (ndpoffset) {
+		ndp32 = (struct usb_cdc_ncm_ndp32 *)(skb->data + ndpoffset);
+		if  (ndp32->dwSignature == sign)
+			return ndp32;
+		ndpoffset = le32_to_cpu(ndp32->dwNextNdpIndex);
+	}
+
+	/* align new NDP */
+	if (!(ctx->drvflags & CDC_NCM_FLAG_NDP_TO_END))
+		cdc_ncm_align_tail(skb, ctx->tx_ndp_modulus, 0, ctx->tx_curr_size);
+
+	/* verify that there is room for the NDP and the datagram (reserve) */
+	if ((ctx->tx_curr_size - skb->len - reserve) < ctx->max_ndp_size)
+		return NULL;
+
+	/* link to it */
+	if (ndp32)
+		ndp32->dwNextNdpIndex = cpu_to_le32(skb->len);
+	else
+		nth32->dwNdpIndex = cpu_to_le32(skb->len);
+
+	/* push a new empty NDP */
+	if (!(ctx->drvflags & CDC_NCM_FLAG_NDP_TO_END))
+		ndp32 = skb_put_zero(skb, ctx->max_ndp_size);
+	else
+		ndp32 = ctx->delayed_ndp32;
+
+	ndp32->dwSignature = sign;
+	ndp32->wLength = cpu_to_le16(sizeof(struct usb_cdc_ncm_ndp32) + sizeof(struct usb_cdc_ncm_dpe32));
+	return ndp32;
+}
+
 struct sk_buff *
 cdc_ncm_fill_tx_frame(struct usbnet *dev, struct sk_buff *skb, __le32 sign)
 {
 	struct cdc_ncm_ctx *ctx = (struct cdc_ncm_ctx *)dev->data[0];
-	struct usb_cdc_ncm_nth16 *nth16;
-	struct usb_cdc_ncm_ndp16 *ndp16;
+	union {
+		struct usb_cdc_ncm_nth16 *nth16;
+		struct usb_cdc_ncm_nth32 *nth32;
+	} nth;
+	union {
+		struct usb_cdc_ncm_ndp16 *ndp16;
+		struct usb_cdc_ncm_ndp32 *ndp32;
+	} ndp;
 	struct sk_buff *skb_out;
 	u16 n = 0, index, ndplen;
 	u8 ready2send = 0;
@@ -1159,6 +1234,9 @@ cdc_ncm_fill_tx_frame(struct usbnet *dev, struct sk_buff *skb, __le32 sign)
 			 * further.
 			 */
 			if (skb_out == NULL) {
+				/* If even the smallest allocation fails, abort. */
+				if (ctx->tx_curr_size == USB_CDC_NCM_NTB_MIN_OUT_SIZE)
+					goto alloc_failed;
 				ctx->tx_low_mem_max_cnt = min(ctx->tx_low_mem_max_cnt + 1,
 							      (unsigned)CDC_NCM_LOW_MEM_MAX_CNT);
 				ctx->tx_low_mem_val = ctx->tx_low_mem_max_cnt;
@@ -1177,20 +1255,23 @@ cdc_ncm_fill_tx_frame(struct usbnet *dev, struct sk_buff *skb, __le32 sign)
 			skb_out = alloc_skb(ctx->tx_curr_size, GFP_ATOMIC);
 
 			/* No allocation possible so we will abort */
-			if (skb_out == NULL) {
-				if (skb != NULL) {
-					dev_kfree_skb_any(skb);
-					dev->net->stats.tx_dropped++;
-				}
-				goto exit_no_skb;
-			}
+			if (!skb_out)
+				goto alloc_failed;
 			ctx->tx_low_mem_val--;
 		}
-		/* fill out the initial 16-bit NTB header */
-		nth16 = skb_put_zero(skb_out, sizeof(struct usb_cdc_ncm_nth16));
-		nth16->dwSignature = cpu_to_le32(USB_CDC_NCM_NTH16_SIGN);
-		nth16->wHeaderLength = cpu_to_le16(sizeof(struct usb_cdc_ncm_nth16));
-		nth16->wSequence = cpu_to_le16(ctx->tx_seq++);
+		if (ctx->is_ndp16) {
+			/* fill out the initial 16-bit NTB header */
+			nth.nth16 = skb_put_zero(skb_out, sizeof(struct usb_cdc_ncm_nth16));
+			nth.nth16->dwSignature = cpu_to_le32(USB_CDC_NCM_NTH16_SIGN);
+			nth.nth16->wHeaderLength = cpu_to_le16(sizeof(struct usb_cdc_ncm_nth16));
+			nth.nth16->wSequence = cpu_to_le16(ctx->tx_seq++);
+		} else {
+			/* fill out the initial 32-bit NTB header */
+			nth.nth32 = skb_put_zero(skb_out, sizeof(struct usb_cdc_ncm_nth32));
+			nth.nth32->dwSignature = cpu_to_le32(USB_CDC_NCM_NTH32_SIGN);
+			nth.nth32->wHeaderLength = cpu_to_le16(sizeof(struct usb_cdc_ncm_nth32));
+			nth.nth32->wSequence = cpu_to_le16(ctx->tx_seq++);
+		}
 
 		/* count total number of frames in this NTB */
 		ctx->tx_curr_frame_num = 0;
@@ -1212,13 +1293,17 @@ cdc_ncm_fill_tx_frame(struct usbnet *dev, struct sk_buff *skb, __le32 sign)
 		}
 
 		/* get the appropriate NDP for this skb */
-		ndp16 = cdc_ncm_ndp(ctx, skb_out, sign, skb->len + ctx->tx_modulus + ctx->tx_remainder);
+		if (ctx->is_ndp16)
+			ndp.ndp16 = cdc_ncm_ndp16(ctx, skb_out, sign, skb->len + ctx->tx_modulus + ctx->tx_remainder);
+		else
+			ndp.ndp32 = cdc_ncm_ndp32(ctx, skb_out, sign, skb->len + ctx->tx_modulus + ctx->tx_remainder);
 
 		/* align beginning of next frame */
 		cdc_ncm_align_tail(skb_out,  ctx->tx_modulus, ctx->tx_remainder, ctx->tx_curr_size);
 
 		/* check if we had enough room left for both NDP and frame */
-		if (!ndp16 || skb_out->len + skb->len + delayed_ndp_size > ctx->tx_curr_size) {
+		if ((ctx->is_ndp16 && !ndp.ndp16) || (!ctx->is_ndp16 && !ndp.ndp32) ||
+		    skb_out->len + skb->len + delayed_ndp_size > ctx->tx_curr_size) {
 			if (n == 0) {
 				/* won't fit, MTU problem? */
 				dev_kfree_skb_any(skb);
@@ -1240,13 +1325,22 @@ cdc_ncm_fill_tx_frame(struct usbnet *dev, struct sk_buff *skb, __le32 sign)
 		}
 
 		/* calculate frame number withing this NDP */
-		ndplen = le16_to_cpu(ndp16->wLength);
-		index = (ndplen - sizeof(struct usb_cdc_ncm_ndp16)) / sizeof(struct usb_cdc_ncm_dpe16) - 1;
+		if (ctx->is_ndp16) {
+			ndplen = le16_to_cpu(ndp.ndp16->wLength);
+			index = (ndplen - sizeof(struct usb_cdc_ncm_ndp16)) / sizeof(struct usb_cdc_ncm_dpe16) - 1;
+
+			/* OK, add this skb */
+			ndp.ndp16->dpe16[index].wDatagramLength = cpu_to_le16(skb->len);
+			ndp.ndp16->dpe16[index].wDatagramIndex = cpu_to_le16(skb_out->len);
+			ndp.ndp16->wLength = cpu_to_le16(ndplen + sizeof(struct usb_cdc_ncm_dpe16));
+		} else {
+			ndplen = le16_to_cpu(ndp.ndp32->wLength);
+			index = (ndplen - sizeof(struct usb_cdc_ncm_ndp32)) / sizeof(struct usb_cdc_ncm_dpe32) - 1;
 
-		/* OK, add this skb */
-		ndp16->dpe16[index].wDatagramLength = cpu_to_le16(skb->len);
-		ndp16->dpe16[index].wDatagramIndex = cpu_to_le16(skb_out->len);
-		ndp16->wLength = cpu_to_le16(ndplen + sizeof(struct usb_cdc_ncm_dpe16));
+			ndp.ndp32->dpe32[index].dwDatagramLength = cpu_to_le32(skb->len);
+			ndp.ndp32->dpe32[index].dwDatagramIndex = cpu_to_le32(skb_out->len);
+			ndp.ndp32->wLength = cpu_to_le16(ndplen + sizeof(struct usb_cdc_ncm_dpe32));
+		}
 		skb_put_data(skb_out, skb->data, skb->len);
 		ctx->tx_curr_frame_payload += skb->len;	/* count real tx payload data */
 		dev_kfree_skb_any(skb);
@@ -1293,13 +1387,22 @@ cdc_ncm_fill_tx_frame(struct usbnet *dev, struct sk_buff *skb, __le32 sign)
 
 	/* If requested, put NDP at end of frame. */
 	if (ctx->drvflags & CDC_NCM_FLAG_NDP_TO_END) {
-		nth16 = (struct usb_cdc_ncm_nth16 *)skb_out->data;
-		cdc_ncm_align_tail(skb_out, ctx->tx_ndp_modulus, 0, ctx->tx_curr_size - ctx->max_ndp_size);
-		nth16->wNdpIndex = cpu_to_le16(skb_out->len);
-		skb_put_data(skb_out, ctx->delayed_ndp16, ctx->max_ndp_size);
+		if (ctx->is_ndp16) {
+			nth.nth16 = (struct usb_cdc_ncm_nth16 *)skb_out->data;
+			cdc_ncm_align_tail(skb_out, ctx->tx_ndp_modulus, 0, ctx->tx_curr_size - ctx->max_ndp_size);
+			nth.nth16->wNdpIndex = cpu_to_le16(skb_out->len);
+			skb_put_data(skb_out, ctx->delayed_ndp16, ctx->max_ndp_size);
+
+			/* Zero out delayed NDP - signature checking will naturally fail. */
+			ndp.ndp16 = memset(ctx->delayed_ndp16, 0, ctx->max_ndp_size);
+		} else {
+			nth.nth32 = (struct usb_cdc_ncm_nth32 *)skb_out->data;
+			cdc_ncm_align_tail(skb_out, ctx->tx_ndp_modulus, 0, ctx->tx_curr_size - ctx->max_ndp_size);
+			nth.nth32->dwNdpIndex = cpu_to_le32(skb_out->len);
+			skb_put_data(skb_out, ctx->delayed_ndp32, ctx->max_ndp_size);
 
-		/* Zero out delayed NDP - signature checking will naturally fail. */
-		ndp16 = memset(ctx->delayed_ndp16, 0, ctx->max_ndp_size);
+			ndp.ndp32 = memset(ctx->delayed_ndp32, 0, ctx->max_ndp_size);
+		}
 	}
 
 	/* If collected data size is less or equal ctx->min_tx_pkt
@@ -1322,8 +1425,13 @@ cdc_ncm_fill_tx_frame(struct usbnet *dev, struct sk_buff *skb, __le32 sign)
 	}
 
 	/* set final frame length */
-	nth16 = (struct usb_cdc_ncm_nth16 *)skb_out->data;
-	nth16->wBlockLength = cpu_to_le16(skb_out->len);
+	if (ctx->is_ndp16) {
+		nth.nth16 = (struct usb_cdc_ncm_nth16 *)skb_out->data;
+		nth.nth16->wBlockLength = cpu_to_le16(skb_out->len);
+	} else {
+		nth.nth32 = (struct usb_cdc_ncm_nth32 *)skb_out->data;
+		nth.nth32->dwBlockLength = cpu_to_le32(skb_out->len);
+	}
 
 	/* return skb */
 	ctx->tx_curr_skb = NULL;
@@ -1341,6 +1449,11 @@ cdc_ncm_fill_tx_frame(struct usbnet *dev, struct sk_buff *skb, __le32 sign)
 
 	return skb_out;
 
+alloc_failed:
+	if (skb) {
+		dev_kfree_skb_any(skb);
+		dev->net->stats.tx_dropped++;
+	}
 exit_no_skb:
 	/* Start timer, if there is a remaining non-empty skb */
 	if (ctx->tx_curr_skb != NULL && n > 0)
@@ -1406,7 +1519,12 @@ cdc_ncm_tx_fixup(struct usbnet *dev, struct sk_buff *skb, gfp_t flags)
 		goto error;
 
 	spin_lock_bh(&ctx->mtx);
-	skb_out = cdc_ncm_fill_tx_frame(dev, skb, cpu_to_le32(USB_CDC_NCM_NDP16_NOCRC_SIGN));
+
+	if (ctx->is_ndp16)
+		skb_out = cdc_ncm_fill_tx_frame(dev, skb, cpu_to_le32(USB_CDC_NCM_NDP16_NOCRC_SIGN));
+	else
+		skb_out = cdc_ncm_fill_tx_frame(dev, skb, cpu_to_le32(USB_CDC_NCM_NDP32_NOCRC_SIGN));
+
 	spin_unlock_bh(&ctx->mtx);
 	return skb_out;
 
@@ -1467,6 +1585,54 @@ int cdc_ncm_rx_verify_nth16(struct cdc_ncm_ctx *ctx, struct sk_buff *skb_in)
 }
 EXPORT_SYMBOL_GPL(cdc_ncm_rx_verify_nth16);
 
+int cdc_ncm_rx_verify_nth32(struct cdc_ncm_ctx *ctx, struct sk_buff *skb_in)
+{
+	struct usbnet *dev = netdev_priv(skb_in->dev);
+	struct usb_cdc_ncm_nth32 *nth32;
+	int len;
+	int ret = -EINVAL;
+
+	if (ctx == NULL)
+		goto error;
+
+	if (skb_in->len < (sizeof(struct usb_cdc_ncm_nth32) +
+					sizeof(struct usb_cdc_ncm_ndp32))) {
+		netif_dbg(dev, rx_err, dev->net, "frame too short\n");
+		goto error;
+	}
+
+	nth32 = (struct usb_cdc_ncm_nth32 *)skb_in->data;
+
+	if (nth32->dwSignature != cpu_to_le32(USB_CDC_NCM_NTH32_SIGN)) {
+		netif_dbg(dev, rx_err, dev->net,
+			  "invalid NTH32 signature <%#010x>\n",
+			  le32_to_cpu(nth32->dwSignature));
+		goto error;
+	}
+
+	len = le32_to_cpu(nth32->dwBlockLength);
+	if (len > ctx->rx_max) {
+		netif_dbg(dev, rx_err, dev->net,
+			  "unsupported NTB block length %u/%u\n", len,
+			  ctx->rx_max);
+		goto error;
+	}
+
+	if ((ctx->rx_seq + 1) != le16_to_cpu(nth32->wSequence) &&
+	    (ctx->rx_seq || le16_to_cpu(nth32->wSequence)) &&
+	    !((ctx->rx_seq == 0xffff) && !le16_to_cpu(nth32->wSequence))) {
+		netif_dbg(dev, rx_err, dev->net,
+			  "sequence number glitch prev=%d curr=%d\n",
+			  ctx->rx_seq, le16_to_cpu(nth32->wSequence));
+	}
+	ctx->rx_seq = le16_to_cpu(nth32->wSequence);
+
+	ret = le32_to_cpu(nth32->dwNdpIndex);
+error:
+	return ret;
+}
+EXPORT_SYMBOL_GPL(cdc_ncm_rx_verify_nth32);
+
 /* verify NDP header and return number of datagrams, or negative error */
 int cdc_ncm_rx_verify_ndp16(struct sk_buff *skb_in, int ndpoffset)
 {
@@ -1503,6 +1669,42 @@ int cdc_ncm_rx_verify_ndp16(struct sk_buff *skb_in, int ndpoffset)
 }
 EXPORT_SYMBOL_GPL(cdc_ncm_rx_verify_ndp16);
 
+/* verify NDP header and return number of datagrams, or negative error */
+int cdc_ncm_rx_verify_ndp32(struct sk_buff *skb_in, int ndpoffset)
+{
+	struct usbnet *dev = netdev_priv(skb_in->dev);
+	struct usb_cdc_ncm_ndp32 *ndp32;
+	int ret = -EINVAL;
+
+	if ((ndpoffset + sizeof(struct usb_cdc_ncm_ndp32)) > skb_in->len) {
+		netif_dbg(dev, rx_err, dev->net, "invalid NDP offset  <%u>\n",
+			  ndpoffset);
+		goto error;
+	}
+	ndp32 = (struct usb_cdc_ncm_ndp32 *)(skb_in->data + ndpoffset);
+
+	if (le16_to_cpu(ndp32->wLength) < USB_CDC_NCM_NDP32_LENGTH_MIN) {
+		netif_dbg(dev, rx_err, dev->net, "invalid DPT32 length <%u>\n",
+			  le16_to_cpu(ndp32->wLength));
+		goto error;
+	}
+
+	ret = ((le16_to_cpu(ndp32->wLength) -
+					sizeof(struct usb_cdc_ncm_ndp32)) /
+					sizeof(struct usb_cdc_ncm_dpe32));
+	ret--; /* we process NDP entries except for the last one */
+
+	if ((sizeof(struct usb_cdc_ncm_ndp32) +
+	     ret * (sizeof(struct usb_cdc_ncm_dpe32))) > skb_in->len) {
+		netif_dbg(dev, rx_err, dev->net, "Invalid nframes = %d\n", ret);
+		ret = -EINVAL;
+	}
+
+error:
+	return ret;
+}
+EXPORT_SYMBOL_GPL(cdc_ncm_rx_verify_ndp32);
+
 int cdc_ncm_rx_fixup(struct usbnet *dev, struct sk_buff *skb_in)
 {
 	struct sk_buff *skb;
@@ -1511,34 +1713,66 @@ int cdc_ncm_rx_fixup(struct usbnet *dev, struct sk_buff *skb_in)
 	int nframes;
 	int x;
 	int offset;
-	struct usb_cdc_ncm_ndp16 *ndp16;
-	struct usb_cdc_ncm_dpe16 *dpe16;
+	union {
+		struct usb_cdc_ncm_ndp16 *ndp16;
+		struct usb_cdc_ncm_ndp32 *ndp32;
+	} ndp;
+	union {
+		struct usb_cdc_ncm_dpe16 *dpe16;
+		struct usb_cdc_ncm_dpe32 *dpe32;
+	} dpe;
+
 	int ndpoffset;
 	int loopcount = 50; /* arbitrary max preventing infinite loop */
 	u32 payload = 0;
 
-	ndpoffset = cdc_ncm_rx_verify_nth16(ctx, skb_in);
+	if (ctx->is_ndp16)
+		ndpoffset = cdc_ncm_rx_verify_nth16(ctx, skb_in);
+	else
+		ndpoffset = cdc_ncm_rx_verify_nth32(ctx, skb_in);
+
 	if (ndpoffset < 0)
 		goto error;
 
 next_ndp:
-	nframes = cdc_ncm_rx_verify_ndp16(skb_in, ndpoffset);
-	if (nframes < 0)
-		goto error;
+	if (ctx->is_ndp16) {
+		nframes = cdc_ncm_rx_verify_ndp16(skb_in, ndpoffset);
+		if (nframes < 0)
+			goto error;
 
-	ndp16 = (struct usb_cdc_ncm_ndp16 *)(skb_in->data + ndpoffset);
+		ndp.ndp16 = (struct usb_cdc_ncm_ndp16 *)(skb_in->data + ndpoffset);
 
-	if (ndp16->dwSignature != cpu_to_le32(USB_CDC_NCM_NDP16_NOCRC_SIGN)) {
-		netif_dbg(dev, rx_err, dev->net,
-			  "invalid DPT16 signature <%#010x>\n",
-			  le32_to_cpu(ndp16->dwSignature));
-		goto err_ndp;
+		if (ndp.ndp16->dwSignature != cpu_to_le32(USB_CDC_NCM_NDP16_NOCRC_SIGN)) {
+			netif_dbg(dev, rx_err, dev->net,
+				  "invalid DPT16 signature <%#010x>\n",
+				  le32_to_cpu(ndp.ndp16->dwSignature));
+			goto err_ndp;
+		}
+		dpe.dpe16 = ndp.ndp16->dpe16;
+	} else {
+		nframes = cdc_ncm_rx_verify_ndp32(skb_in, ndpoffset);
+		if (nframes < 0)
+			goto error;
+
+		ndp.ndp32 = (struct usb_cdc_ncm_ndp32 *)(skb_in->data + ndpoffset);
+
+		if (ndp.ndp32->dwSignature != cpu_to_le32(USB_CDC_NCM_NDP32_NOCRC_SIGN)) {
+			netif_dbg(dev, rx_err, dev->net,
+				  "invalid DPT32 signature <%#010x>\n",
+				  le32_to_cpu(ndp.ndp32->dwSignature));
+			goto err_ndp;
+		}
+		dpe.dpe32 = ndp.ndp32->dpe32;
 	}
-	dpe16 = ndp16->dpe16;
 
-	for (x = 0; x < nframes; x++, dpe16++) {
-		offset = le16_to_cpu(dpe16->wDatagramIndex);
-		len = le16_to_cpu(dpe16->wDatagramLength);
+	for (x = 0; x < nframes; x++) {
+		if (ctx->is_ndp16) {
+			offset = le16_to_cpu(dpe.dpe16->wDatagramIndex);
+			len = le16_to_cpu(dpe.dpe16->wDatagramLength);
+		} else {
+			offset = le32_to_cpu(dpe.dpe32->dwDatagramIndex);
+			len = le32_to_cpu(dpe.dpe32->dwDatagramLength);
+		}
 
 		/*
 		 * CDC NCM ch. 3.7
@@ -1569,10 +1803,19 @@ int cdc_ncm_rx_fixup(struct usbnet *dev, struct sk_buff *skb_in)
 			usbnet_skb_return(dev, skb);
 			payload += len;	/* count payload bytes in this NTB */
 		}
+
+		if (ctx->is_ndp16)
+			dpe.dpe16++;
+		else
+			dpe.dpe32++;
 	}
 err_ndp:
 	/* are there more NDPs to process? */
-	ndpoffset = le16_to_cpu(ndp16->wNextNdpIndex);
+	if (ctx->is_ndp16)
+		ndpoffset = le16_to_cpu(ndp.ndp16->wNextNdpIndex);
+	else
+		ndpoffset = le32_to_cpu(ndp.ndp32->dwNextNdpIndex);
+
 	if (ndpoffset && loopcount--)
 		goto next_ndp;
 
diff --git a/drivers/net/usb/huawei_cdc_ncm.c b/drivers/net/usb/huawei_cdc_ncm.c
index 63f28908afda..ac86fb0efb25 100644
--- a/drivers/net/usb/huawei_cdc_ncm.c
+++ b/drivers/net/usb/huawei_cdc_ncm.c
@@ -81,11 +81,11 @@ static int huawei_cdc_ncm_bind(struct usbnet *usbnet_dev,
 	 */
 	drvflags |= CDC_NCM_FLAG_NDP_TO_END;
 
-	/* Additionally, it has been reported that some Huawei E3372H devices, with
-	 * firmware version 21.318.01.00.541, come out of reset in NTB32 format mode, hence
-	 * needing to be set to the NTB16 one again.
+	/* For many Huawei devices the NTB32 mode is the default and the best mode
+	 * they work with. Huawei E5785 and E5885 devices refuse to work in NTB16 mode at all.
 	 */
-	drvflags |= CDC_NCM_FLAG_RESET_NTB16;
+	drvflags |= CDC_NCM_FLAG_PREFER_NTB32;
+
 	ret = cdc_ncm_bind_common(usbnet_dev, intf, 1, drvflags);
 	if (ret)
 		goto err;
diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index 68547724a101..1a35c99b0770 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1274,7 +1274,7 @@ static const struct usb_device_id products[] = {
 	{QMI_FIXED_INTF(0x2001, 0x7e3d, 4)},	/* D-Link DWM-222 A2 */
 	{QMI_FIXED_INTF(0x2020, 0x2031, 4)},	/* Olicard 600 */
 	{QMI_FIXED_INTF(0x2020, 0x2033, 4)},	/* BroadMobi BM806U */
-	{QMI_FIXED_INTF(0x2020, 0x2060, 4)},	/* BroadMobi BM818 */
+	{QMI_QUIRK_SET_DTR(0x2020, 0x2060, 4)},	/* BroadMobi BM818 */
 	{QMI_FIXED_INTF(0x0f3d, 0x68a2, 8)},    /* Sierra Wireless MC7700 */
 	{QMI_FIXED_INTF(0x114f, 0x68a2, 8)},    /* Sierra Wireless MC7750 */
 	{QMI_FIXED_INTF(0x1199, 0x68a2, 8)},	/* Sierra Wireless MC7710 in QMI mode */
diff --git a/drivers/net/wireless/broadcom/b43/b43.h b/drivers/net/wireless/broadcom/b43/b43.h
index b77d1a904f7e..a449561fccf2 100644
--- a/drivers/net/wireless/broadcom/b43/b43.h
+++ b/drivers/net/wireless/broadcom/b43/b43.h
@@ -651,7 +651,7 @@ struct b43_iv {
 	union {
 		__be16 d16;
 		__be32 d32;
-	} data __packed;
+	} __packed data;
 } __packed;
 
 
diff --git a/drivers/net/wireless/broadcom/b43legacy/b43legacy.h b/drivers/net/wireless/broadcom/b43legacy/b43legacy.h
index 6b0cec467938..f49365d14619 100644
--- a/drivers/net/wireless/broadcom/b43legacy/b43legacy.h
+++ b/drivers/net/wireless/broadcom/b43legacy/b43legacy.h
@@ -379,7 +379,7 @@ struct b43legacy_iv {
 	union {
 		__be16 d16;
 		__be32 d32;
-	} data __packed;
+	} __packed data;
 } __packed;
 
 #define B43legacy_PHYMODE(phytype)	(1 << (phytype))
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
index c1163f2a0925..1913b51c1e80 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
@@ -1268,6 +1268,7 @@ struct rtl8xxxu_priv {
 	u32 rege9c;
 	u32 regeb4;
 	u32 regebc;
+	u32 regrcr;
 	int next_mbox;
 	int nr_out_eps;
 
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 1c9f7e1f63cf..bfd704b17a44 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -4051,6 +4051,7 @@ static int rtl8xxxu_init_device(struct ieee80211_hw *hw)
 		RCR_ACCEPT_MGMT_FRAME | RCR_HTC_LOC_CTRL |
 		RCR_APPEND_PHYSTAT | RCR_APPEND_ICV | RCR_APPEND_MIC;
 	rtl8xxxu_write32(priv, REG_RCR, val32);
+	priv->regrcr = val32;
 
 	/*
 	 * Accept all multicast
@@ -5591,7 +5592,7 @@ static void rtl8xxxu_configure_filter(struct ieee80211_hw *hw,
 				      unsigned int *total_flags, u64 multicast)
 {
 	struct rtl8xxxu_priv *priv = hw->priv;
-	u32 rcr = rtl8xxxu_read32(priv, REG_RCR);
+	u32 rcr = priv->regrcr;
 
 	dev_dbg(&priv->udev->dev, "%s: changed_flags %08x, total_flags %08x\n",
 		__func__, changed_flags, *total_flags);
@@ -5637,6 +5638,7 @@ static void rtl8xxxu_configure_filter(struct ieee80211_hw *hw,
 	 */
 
 	rtl8xxxu_write32(priv, REG_RCR, rcr);
+	priv->regrcr = rcr;
 
 	*total_flags &= (FIF_ALLMULTI | FIF_FCSFAIL | FIF_BCN_PRBRESP_PROMISC |
 			 FIF_CONTROL | FIF_OTHER_BSS | FIF_PSPOLL |
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c
index de98d88199d6..53734250479c 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c
@@ -2414,14 +2414,10 @@ void rtl92d_phy_reload_iqk_setting(struct ieee80211_hw *hw, u8 channel)
 			RT_TRACE(rtlpriv, COMP_SCAN, DBG_LOUD,
 				 "Just Read IQK Matrix reg for channel:%d....\n",
 				 channel);
-			if ((rtlphy->iqk_matrix[indexforchannel].
-			     value[0] != NULL)
-				/*&&(regea4 != 0) */)
+			if (rtlphy->iqk_matrix[indexforchannel].value[0][0] != 0)
 				_rtl92d_phy_patha_fill_iqk_matrix(hw, true,
-					rtlphy->iqk_matrix[
-					indexforchannel].value,	0,
-					(rtlphy->iqk_matrix[
-					indexforchannel].value[0][2] == 0));
+					rtlphy->iqk_matrix[indexforchannel].value, 0,
+					rtlphy->iqk_matrix[indexforchannel].value[0][2] == 0);
 			if (IS_92D_SINGLEPHY(rtlhal->version)) {
 				if ((rtlphy->iqk_matrix[
 					indexforchannel].value[0][4] != 0)
diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 37b5743ce35e..49d351027d0e 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -1817,8 +1817,8 @@ static void bq27xxx_external_power_changed(struct power_supply *psy)
 {
 	struct bq27xxx_device_info *di = power_supply_get_drvdata(psy);
 
-	cancel_delayed_work_sync(&di->work);
-	schedule_delayed_work(&di->work, 0);
+	/* After charger plug in/out wait 0.5s for things to stabilize */
+	mod_delayed_work(system_wq, &di->work, HZ / 2);
 }
 
 int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
diff --git a/drivers/regulator/da9052-regulator.c b/drivers/regulator/da9052-regulator.c
index bd91c95f73e0..99713d0e9f0c 100644
--- a/drivers/regulator/da9052-regulator.c
+++ b/drivers/regulator/da9052-regulator.c
@@ -421,7 +421,7 @@ static int da9052_regulator_probe(struct platform_device *pdev)
 	config.dev = &pdev->dev;
 	config.driver_data = regulator;
 	config.regmap = da9052->regmap;
-	if (pdata && pdata->regulators) {
+	if (pdata) {
 		config.init_data = pdata->regulators[cell->id];
 	} else {
 #ifdef CONFIG_OF
diff --git a/drivers/regulator/da9055-regulator.c b/drivers/regulator/da9055-regulator.c
index d029c941a1e1..a118f63f9366 100644
--- a/drivers/regulator/da9055-regulator.c
+++ b/drivers/regulator/da9055-regulator.c
@@ -612,7 +612,7 @@ static int da9055_regulator_probe(struct platform_device *pdev)
 	config.driver_data = regulator;
 	config.regmap = da9055->regmap;
 
-	if (pdata && pdata->regulators) {
+	if (pdata) {
 		config.init_data = pdata->regulators[pdev->id];
 	} else {
 		ret = da9055_regulator_dt_init(pdev, regulator, &config,
diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index 881906dc33b8..ba1bfb30a272 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -480,7 +480,7 @@ config SCSI_MVUMI
 
 config SCSI_DPT_I2O
 	tristate "Adaptec I2O RAID support "
-	depends on SCSI && PCI && VIRT_TO_BUS
+	depends on SCSI && PCI
 	help
 	  This driver supports all of Adaptec's I2O based RAID controllers as 
 	  well as the DPT SmartRaid V cards.  This is an Adaptec maintained
diff --git a/drivers/scsi/dpt_i2o.c b/drivers/scsi/dpt_i2o.c
index fd172b0890d3..bbd358993e5c 100644
--- a/drivers/scsi/dpt_i2o.c
+++ b/drivers/scsi/dpt_i2o.c
@@ -59,7 +59,7 @@ MODULE_DESCRIPTION("Adaptec I2O RAID Driver");
 
 #include <asm/processor.h>	/* for boot_cpu_data */
 #include <asm/pgtable.h>
-#include <asm/io.h>		/* for virt_to_bus, etc. */
+#include <asm/io.h>
 
 #include <scsi/scsi.h>
 #include <scsi/scsi_cmnd.h>
@@ -630,51 +630,6 @@ static struct scsi_cmnd *
 	return NULL;
 }
 
-/*
- *	Turn a pointer to ioctl reply data into an u32 'context'
- */
-static u32 adpt_ioctl_to_context(adpt_hba * pHba, void *reply)
-{
-#if BITS_PER_LONG == 32
-	return (u32)(unsigned long)reply;
-#else
-	ulong flags = 0;
-	u32 nr, i;
-
-	spin_lock_irqsave(pHba->host->host_lock, flags);
-	nr = ARRAY_SIZE(pHba->ioctl_reply_context);
-	for (i = 0; i < nr; i++) {
-		if (pHba->ioctl_reply_context[i] == NULL) {
-			pHba->ioctl_reply_context[i] = reply;
-			break;
-		}
-	}
-	spin_unlock_irqrestore(pHba->host->host_lock, flags);
-	if (i >= nr) {
-		printk(KERN_WARNING"%s: Too many outstanding "
-				"ioctl commands\n", pHba->name);
-		return (u32)-1;
-	}
-
-	return i;
-#endif
-}
-
-/*
- *	Go from an u32 'context' to a pointer to ioctl reply data.
- */
-static void *adpt_ioctl_from_context(adpt_hba *pHba, u32 context)
-{
-#if BITS_PER_LONG == 32
-	return (void *)(unsigned long)context;
-#else
-	void *p = pHba->ioctl_reply_context[context];
-	pHba->ioctl_reply_context[context] = NULL;
-
-	return p;
-#endif
-}
-
 /*===========================================================================
  * Error Handling routines
  *===========================================================================
@@ -1698,201 +1653,6 @@ static int adpt_close(struct inode *inode, struct file *file)
 	return 0;
 }
 
-
-static int adpt_i2o_passthru(adpt_hba* pHba, u32 __user *arg)
-{
-	u32 msg[MAX_MESSAGE_SIZE];
-	u32* reply = NULL;
-	u32 size = 0;
-	u32 reply_size = 0;
-	u32 __user *user_msg = arg;
-	u32 __user * user_reply = NULL;
-	void *sg_list[pHba->sg_tablesize];
-	u32 sg_offset = 0;
-	u32 sg_count = 0;
-	int sg_index = 0;
-	u32 i = 0;
-	u32 rcode = 0;
-	void *p = NULL;
-	dma_addr_t addr;
-	ulong flags = 0;
-
-	memset(&msg, 0, MAX_MESSAGE_SIZE*4);
-	// get user msg size in u32s 
-	if(get_user(size, &user_msg[0])){
-		return -EFAULT;
-	}
-	size = size>>16;
-
-	user_reply = &user_msg[size];
-	if(size > MAX_MESSAGE_SIZE){
-		return -EFAULT;
-	}
-	size *= 4; // Convert to bytes
-
-	/* Copy in the user's I2O command */
-	if(copy_from_user(msg, user_msg, size)) {
-		return -EFAULT;
-	}
-	get_user(reply_size, &user_reply[0]);
-	reply_size = reply_size>>16;
-	if(reply_size > REPLY_FRAME_SIZE){
-		reply_size = REPLY_FRAME_SIZE;
-	}
-	reply_size *= 4;
-	reply = kzalloc(REPLY_FRAME_SIZE*4, GFP_KERNEL);
-	if(reply == NULL) {
-		printk(KERN_WARNING"%s: Could not allocate reply buffer\n",pHba->name);
-		return -ENOMEM;
-	}
-	sg_offset = (msg[0]>>4)&0xf;
-	msg[2] = 0x40000000; // IOCTL context
-	msg[3] = adpt_ioctl_to_context(pHba, reply);
-	if (msg[3] == (u32)-1) {
-		kfree(reply);
-		return -EBUSY;
-	}
-
-	memset(sg_list,0, sizeof(sg_list[0])*pHba->sg_tablesize);
-	if(sg_offset) {
-		// TODO add 64 bit API
-		struct sg_simple_element *sg =  (struct sg_simple_element*) (msg+sg_offset);
-		sg_count = (size - sg_offset*4) / sizeof(struct sg_simple_element);
-		if (sg_count > pHba->sg_tablesize){
-			printk(KERN_DEBUG"%s:IOCTL SG List too large (%u)\n", pHba->name,sg_count);
-			kfree (reply);
-			return -EINVAL;
-		}
-
-		for(i = 0; i < sg_count; i++) {
-			int sg_size;
-
-			if (!(sg[i].flag_count & 0x10000000 /*I2O_SGL_FLAGS_SIMPLE_ADDRESS_ELEMENT*/)) {
-				printk(KERN_DEBUG"%s:Bad SG element %d - not simple (%x)\n",pHba->name,i,  sg[i].flag_count);
-				rcode = -EINVAL;
-				goto cleanup;
-			}
-			sg_size = sg[i].flag_count & 0xffffff;      
-			/* Allocate memory for the transfer */
-			p = dma_alloc_coherent(&pHba->pDev->dev, sg_size, &addr, GFP_KERNEL);
-			if(!p) {
-				printk(KERN_DEBUG"%s: Could not allocate SG buffer - size = %d buffer number %d of %d\n",
-						pHba->name,sg_size,i,sg_count);
-				rcode = -ENOMEM;
-				goto cleanup;
-			}
-			sg_list[sg_index++] = p; // sglist indexed with input frame, not our internal frame.
-			/* Copy in the user's SG buffer if necessary */
-			if(sg[i].flag_count & 0x04000000 /*I2O_SGL_FLAGS_DIR*/) {
-				// sg_simple_element API is 32 bit
-				if (copy_from_user(p,(void __user *)(ulong)sg[i].addr_bus, sg_size)) {
-					printk(KERN_DEBUG"%s: Could not copy SG buf %d FROM user\n",pHba->name,i);
-					rcode = -EFAULT;
-					goto cleanup;
-				}
-			}
-			/* sg_simple_element API is 32 bit, but addr < 4GB */
-			sg[i].addr_bus = addr;
-		}
-	}
-
-	do {
-		/*
-		 * Stop any new commands from enterring the
-		 * controller while processing the ioctl
-		 */
-		if (pHba->host) {
-			scsi_block_requests(pHba->host);
-			spin_lock_irqsave(pHba->host->host_lock, flags);
-		}
-		rcode = adpt_i2o_post_wait(pHba, msg, size, FOREVER);
-		if (rcode != 0)
-			printk("adpt_i2o_passthru: post wait failed %d %p\n",
-					rcode, reply);
-		if (pHba->host) {
-			spin_unlock_irqrestore(pHba->host->host_lock, flags);
-			scsi_unblock_requests(pHba->host);
-		}
-	} while (rcode == -ETIMEDOUT);
-
-	if(rcode){
-		goto cleanup;
-	}
-
-	if(sg_offset) {
-	/* Copy back the Scatter Gather buffers back to user space */
-		u32 j;
-		// TODO add 64 bit API
-		struct sg_simple_element* sg;
-		int sg_size;
-
-		// re-acquire the original message to handle correctly the sg copy operation
-		memset(&msg, 0, MAX_MESSAGE_SIZE*4); 
-		// get user msg size in u32s 
-		if(get_user(size, &user_msg[0])){
-			rcode = -EFAULT; 
-			goto cleanup; 
-		}
-		size = size>>16;
-		size *= 4;
-		if (size > MAX_MESSAGE_SIZE) {
-			rcode = -EINVAL;
-			goto cleanup;
-		}
-		/* Copy in the user's I2O command */
-		if (copy_from_user (msg, user_msg, size)) {
-			rcode = -EFAULT;
-			goto cleanup;
-		}
-		sg_count = (size - sg_offset*4) / sizeof(struct sg_simple_element);
-
-		// TODO add 64 bit API
-		sg 	 = (struct sg_simple_element*)(msg + sg_offset);
-		for (j = 0; j < sg_count; j++) {
-			/* Copy out the SG list to user's buffer if necessary */
-			if(! (sg[j].flag_count & 0x4000000 /*I2O_SGL_FLAGS_DIR*/)) {
-				sg_size = sg[j].flag_count & 0xffffff; 
-				// sg_simple_element API is 32 bit
-				if (copy_to_user((void __user *)(ulong)sg[j].addr_bus,sg_list[j], sg_size)) {
-					printk(KERN_WARNING"%s: Could not copy %p TO user %x\n",pHba->name, sg_list[j], sg[j].addr_bus);
-					rcode = -EFAULT;
-					goto cleanup;
-				}
-			}
-		}
-	} 
-
-	/* Copy back the reply to user space */
-	if (reply_size) {
-		// we wrote our own values for context - now restore the user supplied ones
-		if(copy_from_user(reply+2, user_msg+2, sizeof(u32)*2)) {
-			printk(KERN_WARNING"%s: Could not copy message context FROM user\n",pHba->name);
-			rcode = -EFAULT;
-		}
-		if(copy_to_user(user_reply, reply, reply_size)) {
-			printk(KERN_WARNING"%s: Could not copy reply TO user\n",pHba->name);
-			rcode = -EFAULT;
-		}
-	}
-
-
-cleanup:
-	if (rcode != -ETIME && rcode != -EINTR) {
-		struct sg_simple_element *sg =
-				(struct sg_simple_element*) (msg +sg_offset);
-		kfree (reply);
-		while(sg_index) {
-			if(sg_list[--sg_index]) {
-				dma_free_coherent(&pHba->pDev->dev,
-					sg[sg_index].flag_count & 0xffffff,
-					sg_list[sg_index],
-					sg[sg_index].addr_bus);
-			}
-		}
-	}
-	return rcode;
-}
-
 #if defined __ia64__ 
 static void adpt_ia64_info(sysInfo_S* si)
 {
@@ -2019,8 +1779,6 @@ static int adpt_ioctl(struct inode *inode, struct file *file, uint cmd, ulong ar
 			return -EFAULT;
 		}
 		break;
-	case I2OUSRCMD:
-		return adpt_i2o_passthru(pHba, argp);
 
 	case DPT_CTRLINFO:{
 		drvrHBAinfo_S HbaInfo;
@@ -2154,7 +1912,7 @@ static irqreturn_t adpt_isr(int irq, void *dev_id)
 		} else {
 			/* Ick, we should *never* be here */
 			printk(KERN_ERR "dpti: reply frame not from pool\n");
-			reply = (u8 *)bus_to_virt(m);
+			continue;
 		}
 
 		if (readl(reply) & MSG_FAIL) {
@@ -2174,13 +1932,6 @@ static irqreturn_t adpt_isr(int irq, void *dev_id)
 			adpt_send_nop(pHba, old_m);
 		} 
 		context = readl(reply+8);
-		if(context & 0x40000000){ // IOCTL
-			void *p = adpt_ioctl_from_context(pHba, readl(reply+12));
-			if( p != NULL) {
-				memcpy_fromio(p, reply, REPLY_FRAME_SIZE * 4);
-			}
-			// All IOCTLs will also be post wait
-		}
 		if(context & 0x80000000){ // Post wait message
 			status = readl(reply+16);
 			if(status  >> 24){
@@ -2188,12 +1939,9 @@ static irqreturn_t adpt_isr(int irq, void *dev_id)
 			} else {
 				status = I2O_POST_WAIT_OK;
 			}
-			if(!(context & 0x40000000)) {
-				cmd = adpt_cmd_from_context(pHba,
-							readl(reply+12));
-				if(cmd != NULL) {
-					printk(KERN_WARNING"%s: Apparent SCSI cmd in Post Wait Context - cmd=%p context=%x\n", pHba->name, cmd, context);
-				}
+			cmd = adpt_cmd_from_context(pHba, readl(reply+12));
+			if(cmd != NULL) {
+				printk(KERN_WARNING"%s: Apparent SCSI cmd in Post Wait Context - cmd=%p context=%x\n", pHba->name, cmd, context);
 			}
 			adpt_i2o_post_wait_complete(context, status);
 		} else { // SCSI message
diff --git a/drivers/scsi/dpti.h b/drivers/scsi/dpti.h
index 1fa345ab8ecb..62a57324bb00 100644
--- a/drivers/scsi/dpti.h
+++ b/drivers/scsi/dpti.h
@@ -252,7 +252,6 @@ typedef struct _adpt_hba {
 	void __iomem *FwDebugBLEDflag_P;// Virtual Addr Of FW Debug BLED
 	void __iomem *FwDebugBLEDvalue_P;// Virtual Addr Of FW Debug BLED
 	u32 FwDebugFlags;
-	u32 *ioctl_reply_context[4];
 } adpt_hba;
 
 struct sg_simple_element {
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index fccda61e768c..a2c13e437114 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1717,6 +1717,7 @@ static int scsi_dispatch_cmd(struct scsi_cmnd *cmd)
 		 */
 		SCSI_LOG_MLQUEUE(3, scmd_printk(KERN_INFO, cmd,
 			"queuecommand : device blocked\n"));
+		atomic_dec(&cmd->device->iorequest_cnt);
 		return SCSI_MLQUEUE_DEVICE_BUSY;
 	}
 
@@ -1749,6 +1750,7 @@ static int scsi_dispatch_cmd(struct scsi_cmnd *cmd)
 	trace_scsi_dispatch_cmd_start(cmd);
 	rtn = host->hostt->queuecommand(host, cmd);
 	if (rtn) {
+		atomic_dec(&cmd->device->iorequest_cnt);
 		trace_scsi_dispatch_cmd_error(cmd, rtn);
 		if (rtn != SCSI_MLQUEUE_DEVICE_BUSY &&
 		    rtn != SCSI_MLQUEUE_TARGET_BUSY)
diff --git a/drivers/scsi/stex.c b/drivers/scsi/stex.c
index 124a5d0ec05c..b02f254ce40b 100644
--- a/drivers/scsi/stex.c
+++ b/drivers/scsi/stex.c
@@ -114,7 +114,9 @@ enum {
 	TASK_ATTRIBUTE_HEADOFQUEUE		= 0x1,
 	TASK_ATTRIBUTE_ORDERED			= 0x2,
 	TASK_ATTRIBUTE_ACA			= 0x4,
+};
 
+enum {
 	SS_STS_NORMAL				= 0x80000000,
 	SS_STS_DONE				= 0x40000000,
 	SS_STS_HANDSHAKE			= 0x20000000,
@@ -126,7 +128,9 @@ enum {
 	SS_I2H_REQUEST_RESET			= 0x2000,
 
 	SS_MU_OPERATIONAL			= 0x80000000,
+};
 
+enum {
 	STEX_CDB_LENGTH				= 16,
 	STATUS_VAR_LEN				= 128,
 
diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index e7ab8ec032cf..06367c8cef0d 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1199,34 +1199,36 @@ static void lpuart_break_ctl(struct uart_port *port, int break_state)
 
 static void lpuart32_break_ctl(struct uart_port *port, int break_state)
 {
-	unsigned long temp, modem;
-	struct tty_struct *tty;
-	unsigned int cflag = 0;
-
-	tty = tty_port_tty_get(&port->state->port);
-	if (tty) {
-		cflag = tty->termios.c_cflag;
-		tty_kref_put(tty);
-	}
+	unsigned long temp;
 
-	temp = lpuart32_read(port, UARTCTRL) & ~UARTCTRL_SBK;
-	modem = lpuart32_read(port, UARTMODIR);
+	temp = lpuart32_read(port, UARTCTRL);
 
+	/*
+	 * LPUART IP now has two known bugs, one is CTS has higher priority than the
+	 * break signal, which causes the break signal sending through UARTCTRL_SBK
+	 * may impacted by the CTS input if the HW flow control is enabled. It
+	 * exists on all platforms we support in this driver.
+	 * Another bug is i.MX8QM LPUART may have an additional break character
+	 * being sent after SBK was cleared.
+	 * To avoid above two bugs, we use Transmit Data Inversion function to send
+	 * the break signal instead of UARTCTRL_SBK.
+	 */
 	if (break_state != 0) {
-		temp |= UARTCTRL_SBK;
 		/*
-		 * LPUART CTS has higher priority than SBK, need to disable CTS before
-		 * asserting SBK to avoid any interference if flow control is enabled.
+		 * Disable the transmitter to prevent any data from being sent out
+		 * during break, then invert the TX line to send break.
 		 */
-		if (cflag & CRTSCTS && modem & UARTMODIR_TXCTSE)
-			lpuart32_write(port, modem & ~UARTMODIR_TXCTSE, UARTMODIR);
+		temp &= ~UARTCTRL_TE;
+		lpuart32_write(port, temp, UARTCTRL);
+		temp |= UARTCTRL_TXINV;
+		lpuart32_write(port, temp, UARTCTRL);
 	} else {
-		/* Re-enable the CTS when break off. */
-		if (cflag & CRTSCTS && !(modem & UARTMODIR_TXCTSE))
-			lpuart32_write(port, modem | UARTMODIR_TXCTSE, UARTMODIR);
+		/* Disable the TXINV to turn off break and re-enable transmitter. */
+		temp &= ~UARTCTRL_TXINV;
+		lpuart32_write(port, temp, UARTCTRL);
+		temp |= UARTCTRL_TE;
+		lpuart32_write(port, temp, UARTCTRL);
 	}
-
-	lpuart32_write(port, temp, UARTCTRL);
 }
 
 static void lpuart_setup_watermark(struct lpuart_port *sport)
diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index ba9af04ad37a..b66b70812554 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -3500,6 +3500,7 @@ static void ffs_func_unbind(struct usb_configuration *c,
 	/* Drain any pending AIO completions */
 	drain_workqueue(ffs->io_completion_wq);
 
+	ffs_event_add(ffs, FUNCTIONFS_UNBIND);
 	if (!--opts->refcnt)
 		functionfs_unbind(ffs);
 
@@ -3524,7 +3525,6 @@ static void ffs_func_unbind(struct usb_configuration *c,
 	func->function.ssp_descriptors = NULL;
 	func->interfaces_nums = NULL;
 
-	ffs_event_add(ffs, FUNCTIONFS_UNBIND);
 }
 
 static struct usb_function *ffs_alloc(struct usb_function_instance *fi)
diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 66212ba07cbc..c41197402d81 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -1047,13 +1047,9 @@ static struct socket *get_raw_socket(int fd)
 	return ERR_PTR(r);
 }
 
-static struct skb_array *get_tap_skb_array(int fd)
+static struct skb_array *get_tap_skb_array(struct file *file)
 {
 	struct skb_array *array;
-	struct file *file = fget(fd);
-
-	if (!file)
-		return NULL;
 	array = tun_get_skb_array(file);
 	if (!IS_ERR(array))
 		goto out;
@@ -1062,7 +1058,6 @@ static struct skb_array *get_tap_skb_array(int fd)
 		goto out;
 	array = NULL;
 out:
-	fput(file);
 	return array;
 }
 
@@ -1143,8 +1138,12 @@ static long vhost_net_set_backend(struct vhost_net *n, unsigned index, int fd)
 		vhost_net_disable_vq(n, vq);
 		vq->private_data = sock;
 		vhost_net_buf_unproduce(nvq);
-		if (index == VHOST_NET_VQ_RX)
-			nvq->rx_array = get_tap_skb_array(fd);
+		if (index == VHOST_NET_VQ_RX) {
+			if (sock)
+				nvq->rx_array = get_tap_skb_array(sock->file);
+			else
+				nvq->rx_array = NULL;
+		}
 		r = vhost_vq_init_access(vq);
 		if (r)
 			goto err_used;
diff --git a/drivers/video/fbdev/core/bitblit.c b/drivers/video/fbdev/core/bitblit.c
index 33408c1994a6..78f34ba499e3 100644
--- a/drivers/video/fbdev/core/bitblit.c
+++ b/drivers/video/fbdev/core/bitblit.c
@@ -247,6 +247,9 @@ static void bit_cursor(struct vc_data *vc, struct fb_info *info, int mode,
 
 	cursor.set = 0;
 
+	if (!vc->vc_font.data)
+		return;
+
  	c = scr_readw((u16 *) vc->vc_pos);
 	attribute = get_attribute(info, c);
 	src = vc->vc_font.data + ((c & charmask) * (w * vc->vc_font.height));
diff --git a/drivers/video/fbdev/core/modedb.c b/drivers/video/fbdev/core/modedb.c
index a9d76e1b4378..d02712548a3e 100644
--- a/drivers/video/fbdev/core/modedb.c
+++ b/drivers/video/fbdev/core/modedb.c
@@ -257,6 +257,11 @@ static const struct fb_videomode modedb[] = {
 	{ NULL, 72, 480, 300, 33386, 40, 24, 11, 19, 80, 3, 0,
 		FB_VMODE_DOUBLE },
 
+	/* 1920x1080 @ 60 Hz, 67.3 kHz hsync */
+	{ NULL, 60, 1920, 1080, 6734, 148, 88, 36, 4, 44, 5, 0,
+		FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+		FB_VMODE_NONINTERLACED },
+
 	/* 1920x1200 @ 60 Hz, 74.5 Khz hsync */
 	{ NULL, 60, 1920, 1200, 5177, 128, 336, 1, 38, 208, 3,
 		FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
diff --git a/drivers/video/fbdev/stifb.c b/drivers/video/fbdev/stifb.c
index 9313562e739e..16eed250fd8f 100644
--- a/drivers/video/fbdev/stifb.c
+++ b/drivers/video/fbdev/stifb.c
@@ -1373,6 +1373,7 @@ static int __init stifb_init_fb(struct sti_struct *sti, int bpp_pref)
 	iounmap(info->screen_base);
 out_err0:
 	kfree(fb);
+	sti->info = NULL;
 	return -ENXIO;
 }
 
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 624b34b04837..b43f28736cfc 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -947,11 +947,13 @@ do {									       \
  *			  where the second inode has larger inode number
  *			  than the first
  *  I_DATA_SEM_QUOTA  - Used for quota inodes only
+ *  I_DATA_SEM_EA     - Used for ea_inodes only
  */
 enum {
 	I_DATA_SEM_NORMAL = 0,
 	I_DATA_SEM_OTHER,
 	I_DATA_SEM_QUOTA,
+	I_DATA_SEM_EA
 };
 
 
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 4d55cb2cb7bd..e6c3bf7ad9b9 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -120,7 +120,11 @@ ext4_expand_inode_array(struct ext4_xattr_inode_array **ea_inode_array,
 #ifdef CONFIG_LOCKDEP
 void ext4_xattr_inode_set_class(struct inode *ea_inode)
 {
+	struct ext4_inode_info *ei = EXT4_I(ea_inode);
+
 	lockdep_set_subclass(&ea_inode->i_rwsem, 1);
+	(void) ei;	/* shut up clang warning if !CONFIG_LOCKDEP */
+	lockdep_set_subclass(&ei->i_data_sem, I_DATA_SEM_EA);
 }
 #endif
 
diff --git a/include/linux/usb/cdc_ncm.h b/include/linux/usb/cdc_ncm.h
index 1a59699cf82a..a400cab12f05 100644
--- a/include/linux/usb/cdc_ncm.h
+++ b/include/linux/usb/cdc_ncm.h
@@ -45,9 +45,12 @@
 #define CDC_NCM_DATA_ALTSETTING_NCM		1
 #define CDC_NCM_DATA_ALTSETTING_MBIM		2
 
-/* CDC NCM subclass 3.2.1 */
+/* CDC NCM subclass 3.3.1 */
 #define USB_CDC_NCM_NDP16_LENGTH_MIN		0x10
 
+/* CDC NCM subclass 3.3.2 */
+#define USB_CDC_NCM_NDP32_LENGTH_MIN		0x20
+
 /* Maximum NTB length */
 #define	CDC_NCM_NTB_MAX_SIZE_TX			32768	/* bytes */
 #define	CDC_NCM_NTB_MAX_SIZE_RX			32768	/* bytes */
@@ -83,7 +86,7 @@
 /* Driver flags */
 #define CDC_NCM_FLAG_NDP_TO_END			0x02	/* NDP is placed at end of frame */
 #define CDC_MBIM_FLAG_AVOID_ALTSETTING_TOGGLE	0x04	/* Avoid altsetting toggle during init */
-#define CDC_NCM_FLAG_RESET_NTB16 0x08	/* set NDP16 one more time after altsetting switch */
+#define CDC_NCM_FLAG_PREFER_NTB32 0x08	/* prefer NDP32 over NDP16 */
 
 #define cdc_ncm_comm_intf_is_mbim(x)  ((x)->desc.bInterfaceSubClass == USB_CDC_SUBCLASS_MBIM && \
 				       (x)->desc.bInterfaceProtocol == USB_CDC_PROTO_NONE)
@@ -112,7 +115,11 @@ struct cdc_ncm_ctx {
 
 	u32 timer_interval;
 	u32 max_ndp_size;
-	struct usb_cdc_ncm_ndp16 *delayed_ndp16;
+	u8 is_ndp16;
+	union {
+		struct usb_cdc_ncm_ndp16 *delayed_ndp16;
+		struct usb_cdc_ncm_ndp32 *delayed_ndp32;
+	};
 
 	u32 tx_timer_pending;
 	u32 tx_curr_frame_num;
@@ -149,6 +156,8 @@ void cdc_ncm_unbind(struct usbnet *dev, struct usb_interface *intf);
 struct sk_buff *cdc_ncm_fill_tx_frame(struct usbnet *dev, struct sk_buff *skb, __le32 sign);
 int cdc_ncm_rx_verify_nth16(struct cdc_ncm_ctx *ctx, struct sk_buff *skb_in);
 int cdc_ncm_rx_verify_ndp16(struct sk_buff *skb_in, int ndpoffset);
+int cdc_ncm_rx_verify_nth32(struct cdc_ncm_ctx *ctx, struct sk_buff *skb_in);
+int cdc_ncm_rx_verify_ndp32(struct sk_buff *skb_in, int ndpoffset);
 struct sk_buff *
 cdc_ncm_tx_fixup(struct usbnet *dev, struct sk_buff *skb, gfp_t flags);
 int cdc_ncm_rx_fixup(struct usbnet *dev, struct sk_buff *skb_in);
diff --git a/kernel/extable.c b/kernel/extable.c
index 9aa1cc41ecf7..59650ce26b2e 100644
--- a/kernel/extable.c
+++ b/kernel/extable.c
@@ -44,7 +44,8 @@ u32 __initdata __visible main_extable_sort_needed = 1;
 /* Sort the kernel's built-in exception table */
 void __init sort_main_extable(void)
 {
-	if (main_extable_sort_needed && __stop___ex_table > __start___ex_table) {
+	if (main_extable_sort_needed &&
+	    &__stop___ex_table > &__start___ex_table) {
 		pr_notice("Sorting __ex_table...\n");
 		sort_extable(__start___ex_table, __stop___ex_table);
 	}
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 01591a7b151f..4d61fa3c6ec9 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -984,7 +984,7 @@ static int __init dynamic_debug_init(void)
 	int n = 0, entries = 0, modct = 0;
 	int verbose_bytes = 0;
 
-	if (__start___verbose == __stop___verbose) {
+	if (&__start___verbose == &__stop___verbose) {
 		pr_warn("_ddebug table is empty in a CONFIG_DYNAMIC_DEBUG build\n");
 		return 1;
 	}
diff --git a/net/atm/resources.c b/net/atm/resources.c
index bada395ecdb1..9389080224f8 100644
--- a/net/atm/resources.c
+++ b/net/atm/resources.c
@@ -447,6 +447,7 @@ int atm_dev_ioctl(unsigned int cmd, void __user *arg, int compat)
 	return error;
 }
 
+#ifdef CONFIG_PROC_FS
 void *atm_dev_seq_start(struct seq_file *seq, loff_t *pos)
 {
 	mutex_lock(&atm_dev_mutex);
@@ -462,3 +463,4 @@ void *atm_dev_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 {
 	return seq_list_next(v, &atm_devs, pos);
 }
+#endif
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 837b0767892e..9b1658346396 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -968,6 +968,34 @@ static int hci_sock_ioctl(struct socket *sock, unsigned int cmd,
 
 	BT_DBG("cmd %x arg %lx", cmd, arg);
 
+	/* Make sure the cmd is valid before doing anything */
+	switch (cmd) {
+	case HCIGETDEVLIST:
+	case HCIGETDEVINFO:
+	case HCIGETCONNLIST:
+	case HCIDEVUP:
+	case HCIDEVDOWN:
+	case HCIDEVRESET:
+	case HCIDEVRESTAT:
+	case HCISETSCAN:
+	case HCISETAUTH:
+	case HCISETENCRYPT:
+	case HCISETPTYPE:
+	case HCISETLINKPOL:
+	case HCISETLINKMODE:
+	case HCISETACLMTU:
+	case HCISETSCOMTU:
+	case HCIINQUIRY:
+	case HCISETRAW:
+	case HCIGETCONNINFO:
+	case HCIGETAUTHINFO:
+	case HCIBLOCKADDR:
+	case HCIUNBLOCKADDR:
+		break;
+	default:
+		return -ENOIOCTLCMD;
+	}
+
 	lock_sock(sk);
 
 	if (hci_pi(sk)->channel != HCI_CHANNEL_RAW) {
diff --git a/net/core/sock.c b/net/core/sock.c
index 002c91dd7191..b05296d79f62 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1788,7 +1788,6 @@ void sk_setup_caps(struct sock *sk, struct dst_entry *dst)
 {
 	u32 max_segs = 1;
 
-	sk_dst_set(sk, dst);
 	sk->sk_route_caps = dst->dev->features;
 	if (sk->sk_route_caps & NETIF_F_GSO)
 		sk->sk_route_caps |= NETIF_F_GSO_SOFTWARE;
@@ -1803,6 +1802,7 @@ void sk_setup_caps(struct sock *sk, struct dst_entry *dst)
 		}
 	}
 	sk->sk_gso_max_segs = max_segs;
+	sk_dst_set(sk, dst);
 }
 EXPORT_SYMBOL_GPL(sk_setup_caps);
 
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 160ed3e7c24d..c93aa6542d43 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3037,7 +3037,8 @@ static int do_tcp_getsockopt(struct sock *sk, int level,
 	switch (optname) {
 	case TCP_MAXSEG:
 		val = tp->mss_cache;
-		if (!val && ((1 << sk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN)))
+		if (tp->rx_opt.user_mss &&
+		    ((1 << sk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN)))
 			val = tp->rx_opt.user_mss;
 		if (tp->repair)
 			val = tp->rx_opt.mss_clamp;
diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index 733e61fc5043..1d0abd8529e6 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -2531,7 +2531,9 @@ static int ctnetlink_exp_dump_mask(struct sk_buff *skb,
 	return -1;
 }
 
+#if IS_ENABLED(CONFIG_NF_NAT)
 static const union nf_inet_addr any_addr;
+#endif
 
 static __be32 nf_expect_get_id(const struct nf_conntrack_expect *exp)
 {
@@ -3031,10 +3033,12 @@ ctnetlink_change_expect(struct nf_conntrack_expect *x,
 	return 0;
 }
 
+#if IS_ENABLED(CONFIG_NF_NAT)
 static const struct nla_policy exp_nat_nla_policy[CTA_EXPECT_NAT_MAX+1] = {
 	[CTA_EXPECT_NAT_DIR]	= { .type = NLA_U32 },
 	[CTA_EXPECT_NAT_TUPLE]	= { .type = NLA_NESTED },
 };
+#endif
 
 static int
 ctnetlink_parse_expect_nat(const struct nlattr *attr,
diff --git a/net/netrom/nr_subr.c b/net/netrom/nr_subr.c
index 029c8bb90f4c..a7d3a265befb 100644
--- a/net/netrom/nr_subr.c
+++ b/net/netrom/nr_subr.c
@@ -126,7 +126,7 @@ void nr_write_internal(struct sock *sk, int frametype)
 	unsigned char  *dptr;
 	int len, timeout;
 
-	len = NR_NETWORK_LEN + NR_TRANSPORT_LEN;
+	len = NR_TRANSPORT_LEN;
 
 	switch (frametype & 0x0F) {
 	case NR_CONNREQ:
@@ -144,7 +144,8 @@ void nr_write_internal(struct sock *sk, int frametype)
 		return;
 	}
 
-	if ((skb = alloc_skb(len, GFP_ATOMIC)) == NULL)
+	skb = alloc_skb(NR_NETWORK_LEN + len, GFP_ATOMIC);
+	if (!skb)
 		return;
 
 	/*
@@ -152,7 +153,7 @@ void nr_write_internal(struct sock *sk, int frametype)
 	 */
 	skb_reserve(skb, NR_NETWORK_LEN);
 
-	dptr = skb_put(skb, skb_tailroom(skb));
+	dptr = skb_put(skb, len);
 
 	switch (frametype & 0x0F) {
 	case NR_CONNREQ:
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 2089da69da10..228a409eb92d 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -3153,6 +3153,9 @@ static int packet_do_bind(struct sock *sk, const char *name, int ifindex,
 
 	lock_sock(sk);
 	spin_lock(&po->bind_lock);
+	if (!proto)
+		proto = po->num;
+
 	rcu_read_lock();
 
 	if (po->fanout) {
@@ -3255,7 +3258,7 @@ static int packet_bind_spkt(struct socket *sock, struct sockaddr *uaddr,
 	memcpy(name, uaddr->sa_data, sizeof(uaddr->sa_data));
 	name[sizeof(uaddr->sa_data)] = 0;
 
-	return packet_do_bind(sk, name, 0, pkt_sk(sk)->num);
+	return packet_do_bind(sk, name, 0, 0);
 }
 
 static int packet_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
@@ -3272,8 +3275,7 @@ static int packet_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len
 	if (sll->sll_family != AF_PACKET)
 		return -EINVAL;
 
-	return packet_do_bind(sk, NULL, sll->sll_ifindex,
-			      sll->sll_protocol ? : pkt_sk(sk)->num);
+	return packet_do_bind(sk, NULL, sll->sll_ifindex, sll->sll_protocol);
 }
 
 static struct proto packet_proto = {
diff --git a/net/packet/diag.c b/net/packet/diag.c
index d9f912ad23df..ecabf78d29b8 100644
--- a/net/packet/diag.c
+++ b/net/packet/diag.c
@@ -142,7 +142,7 @@ static int sk_diag_fill(struct sock *sk, struct sk_buff *skb,
 	rp = nlmsg_data(nlh);
 	rp->pdiag_family = AF_PACKET;
 	rp->pdiag_type = sk->sk_type;
-	rp->pdiag_num = ntohs(po->num);
+	rp->pdiag_num = ntohs(READ_ONCE(po->num));
 	rp->pdiag_ino = sk_ino;
 	sock_diag_save_cookie(sk, rp->pdiag_cookie);
 
diff --git a/security/selinux/Makefile b/security/selinux/Makefile
index 08ba8ca81d40..89c67a814566 100644
--- a/security/selinux/Makefile
+++ b/security/selinux/Makefile
@@ -22,5 +22,9 @@ quiet_cmd_flask = GEN     $(obj)/flask.h $(obj)/av_permissions.h
       cmd_flask = $< $(obj)/flask.h $(obj)/av_permissions.h
 
 targets += flask.h av_permissions.h
-$(obj)/flask.h $(obj)/av_permissions.h &: scripts/selinux/genheaders/genheaders FORCE
+# once make >= 4.3 is required, we can use grouped targets in the rule below,
+# which basically involves adding both headers and a '&' before the colon, see
+# the example below:
+#   $(obj)/flask.h $(obj)/av_permissions.h &: scripts/selinux/...
+$(obj)/flask.h: scripts/selinux/genheaders/genheaders FORCE
 	$(call if_changed,flask)
diff --git a/sound/core/oss/pcm_plugin.h b/sound/core/oss/pcm_plugin.h
index c9cd29d86efd..64a2057aa061 100644
--- a/sound/core/oss/pcm_plugin.h
+++ b/sound/core/oss/pcm_plugin.h
@@ -156,6 +156,14 @@ int snd_pcm_area_copy(const struct snd_pcm_channel_area *src_channel,
 
 void *snd_pcm_plug_buf_alloc(struct snd_pcm_substream *plug, snd_pcm_uframes_t size);
 void snd_pcm_plug_buf_unlock(struct snd_pcm_substream *plug, void *ptr);
+#else
+
+static inline snd_pcm_sframes_t snd_pcm_plug_client_size(struct snd_pcm_substream *handle, snd_pcm_uframes_t drv_size) { return drv_size; }
+static inline snd_pcm_sframes_t snd_pcm_plug_slave_size(struct snd_pcm_substream *handle, snd_pcm_uframes_t clt_size) { return clt_size; }
+static inline int snd_pcm_plug_slave_format(int format, const struct snd_mask *format_mask) { return format; }
+
+#endif
+
 snd_pcm_sframes_t snd_pcm_oss_write3(struct snd_pcm_substream *substream,
 				     const char *ptr, snd_pcm_uframes_t size,
 				     int in_kernel);
@@ -166,14 +174,6 @@ snd_pcm_sframes_t snd_pcm_oss_writev3(struct snd_pcm_substream *substream,
 snd_pcm_sframes_t snd_pcm_oss_readv3(struct snd_pcm_substream *substream,
 				     void **bufs, snd_pcm_uframes_t frames);
 
-#else
-
-static inline snd_pcm_sframes_t snd_pcm_plug_client_size(struct snd_pcm_substream *handle, snd_pcm_uframes_t drv_size) { return drv_size; }
-static inline snd_pcm_sframes_t snd_pcm_plug_slave_size(struct snd_pcm_substream *handle, snd_pcm_uframes_t clt_size) { return clt_size; }
-static inline int snd_pcm_plug_slave_format(int format, const struct snd_mask *format_mask) { return format; }
-
-#endif
-
 #ifdef PLUGIN_DEBUG
 #define pdprintf(fmt, args...) printk(KERN_DEBUG "plugin: " fmt, ##args)
 #else
diff --git a/sound/soc/codecs/ssm2602.c b/sound/soc/codecs/ssm2602.c
index 5e80867d09ef..256e5af6690b 100644
--- a/sound/soc/codecs/ssm2602.c
+++ b/sound/soc/codecs/ssm2602.c
@@ -67,6 +67,18 @@ static const struct reg_default ssm2602_reg[SSM2602_CACHEREGNUM] = {
 	{ .reg = 0x09, .def = 0x0000 }
 };
 
+/*
+ * ssm2602 register patch
+ * Workaround for playback distortions after power up: activates digital
+ * core, and then powers on output, DAC, and whole chip at the same time
+ */
+
+static const struct reg_sequence ssm2602_patch[] = {
+	{ SSM2602_ACTIVE, 0x01 },
+	{ SSM2602_PWR,    0x07 },
+	{ SSM2602_RESET,  0x00 },
+};
+
 
 /*Appending several "None"s just for OSS mixer use*/
 static const char *ssm2602_input_select[] = {
@@ -577,6 +589,9 @@ static int ssm260x_codec_probe(struct snd_soc_codec *codec)
 		return ret;
 	}
 
+	regmap_register_patch(ssm2602->regmap, ssm2602_patch,
+			      ARRAY_SIZE(ssm2602_patch));
+
 	/* set the update bits */
 	regmap_update_bits(ssm2602->regmap, SSM2602_LINVOL,
 			    LINVOL_LRIN_BOTH, LINVOL_LRIN_BOTH);
diff --git a/sound/soc/dwc/dwc-i2s.c b/sound/soc/dwc/dwc-i2s.c
index e27e21f8569a..e6a0ec3c0e76 100644
--- a/sound/soc/dwc/dwc-i2s.c
+++ b/sound/soc/dwc/dwc-i2s.c
@@ -132,13 +132,13 @@ static irqreturn_t i2s_irq_handler(int irq, void *dev_id)
 
 		/* Error Handling: TX */
 		if (isr[i] & ISR_TXFO) {
-			dev_err(dev->dev, "TX overrun (ch_id=%d)\n", i);
+			dev_err_ratelimited(dev->dev, "TX overrun (ch_id=%d)\n", i);
 			irq_valid = true;
 		}
 
 		/* Error Handling: TX */
 		if (isr[i] & ISR_RXFO) {
-			dev_err(dev->dev, "RX overrun (ch_id=%d)\n", i);
+			dev_err_ratelimited(dev->dev, "RX overrun (ch_id=%d)\n", i);
 			irq_valid = true;
 		}
 	}
diff --git a/sound/soc/intel/skylake/skl-tplg-interface.h b/sound/soc/intel/skylake/skl-tplg-interface.h
index f8d1749a2e0c..2fab55e6537c 100644
--- a/sound/soc/intel/skylake/skl-tplg-interface.h
+++ b/sound/soc/intel/skylake/skl-tplg-interface.h
@@ -71,7 +71,8 @@ enum skl_ch_cfg {
 	SKL_CH_CFG_DUAL_MONO = 9,
 	SKL_CH_CFG_I2S_DUAL_STEREO_0 = 10,
 	SKL_CH_CFG_I2S_DUAL_STEREO_1 = 11,
-	SKL_CH_CFG_4_CHANNEL = 12,
+	SKL_CH_CFG_7_1 = 12,
+	SKL_CH_CFG_4_CHANNEL = SKL_CH_CFG_7_1,
 	SKL_CH_CFG_INVALID
 };
 
