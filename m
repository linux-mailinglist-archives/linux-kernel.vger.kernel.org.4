Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E50C654644
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 20:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235687AbiLVTBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 14:01:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235525AbiLVTAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 14:00:55 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0EC364DE;
        Thu, 22 Dec 2022 11:00:46 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id z8-20020a17090abd8800b00219ed30ce47so6629062pjr.3;
        Thu, 22 Dec 2022 11:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RVqigMWOOhx36CCkCP8/KBD90bL5sER2oOFAmCzFEeE=;
        b=FRygHL+cPw8OGupsBr7K/DozZ0tmjvS/clcEaDMamESLC99eAydcECSn+SXqUjo+yY
         Jly78fl2oPqMTj4zUgxMwE805vzZ0Xi5tvdDerK9DiLF68Z5K3wtJ8Zf0N2agreHERYT
         qXxY0F23sQ5fhq1Th9cl/ujorvh2dX4cRCArZkU2UEvJKXAknj5A1UwwwAmCGofNbgCX
         EqD5dteABB05XPcJJmmLSxuHKICeagY/NPOpi6x0Om8M1QH4kpHQAWV96d+bnOFbGVDI
         tBWgdlx8nKxnneg1dBY9PbAuLhJblIYV3ZLoXBpQD3sElMcjQ2ItlGYYFDe7xDCJdHji
         K80w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RVqigMWOOhx36CCkCP8/KBD90bL5sER2oOFAmCzFEeE=;
        b=t+P5WlG+L77s1I+t78T0LTNHYHUZQ+VIFzepIAk/55o1YOxjke/5OPZfjc/UevhE1X
         c9L5r795NDK2At82k9y5QOvgyjdRnnCmsUVWF4ZYSh+TWlcWBBbX9XIm2+HUp8kIw2K6
         SG5cJ6C+6KTq5rd6fXFlVIVdqrkguOrh527sEev6JeoLu1nT2jTBpaG1HGJrKaGzsA5+
         nFc//NzlJ2619pUef+cRAli0aNVaTmjkfcQSBM48h85Jon9wgdN0OLn5dzNtiiUXwOgy
         U2SIiOrmZx2ZESMJ0uIu9yF4TlVTqX02egl/W1rf+a/px3hzesj7urP3zlSv2XudYI/Y
         qvnQ==
X-Gm-Message-State: AFqh2kp7QhW5UwZnicSolqth2Am8Oikd3f5qum7vWFxjnwSRULH4YKPZ
        rLVefL084eBhld5dkMugVmXD+Z0EsOE=
X-Google-Smtp-Source: AMrXdXuBkEEuvNw15O43orkszBRrQ05yxM5YFNep6qQ7U0oy+z8dRTxmaO160xohX0dJJcBdiFsqsA==
X-Received: by 2002:a17:902:c252:b0:189:e81b:d254 with SMTP id 18-20020a170902c25200b00189e81bd254mr6982003plg.60.1671735646224;
        Thu, 22 Dec 2022 11:00:46 -0800 (PST)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id z6-20020a170902d54600b001925169e9f4sm61468plf.98.2022.12.22.11.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 11:00:45 -0800 (PST)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     keescook@chromium.org, linux-kernel@vger.kernel.org,
        gmpy.liaowx@gmail.com, linux-mmc@vger.kernel.org,
        CLoehle@hyperstone.com
Cc:     f.fainelli@gmail.com, tony.luck@intel.com, anton@enomsg.org,
        Kamal Dasu <kdasu.kdev@gmail.com>
Subject: [RFC v2 1/1] mmc: Add mmc pstore backend support
Date:   Thu, 22 Dec 2022 13:59:48 -0500
Message-Id: <20221222185948.12717-2-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221222185948.12717-1-kdasu.kdev@gmail.com>
References: <20221222185948.12717-1-kdasu.kdev@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding mmc pstore backend support to be able to write to pstore
device. Code is  based on mtdpstore.

Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
---
 drivers/mmc/core/Kconfig     |  13 +
 drivers/mmc/core/Makefile    |   1 +
 drivers/mmc/core/block.c     |   4 +
 drivers/mmc/core/block.h     |   9 +
 drivers/mmc/core/mmcpstore.c | 592 +++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci.c     |  20 ++
 include/linux/mmc/host.h     |   3 +
 7 files changed, 642 insertions(+)
 create mode 100644 drivers/mmc/core/mmcpstore.c

diff --git a/drivers/mmc/core/Kconfig b/drivers/mmc/core/Kconfig
index 6f25c34e4fec..fd46753ed746 100644
--- a/drivers/mmc/core/Kconfig
+++ b/drivers/mmc/core/Kconfig
@@ -34,9 +34,22 @@ config PWRSEQ_SIMPLE
 	  This driver can also be built as a module. If so, the module
 	  will be called pwrseq_simple.
 
+config MMC_PSTORE_BACKEND
+	bool "Log panic/oops to a MMC buffer"
+	depends on MMC_BLOCK
+	help
+	  This option will let you create platform backend to store kmsg
+	  crash dumps to a user specified MMC device. This is primarily
+	  based on pstore/blk.
+
+config MMC_PSTORE
+	tristate
+	select PSTORE_BLK
+
 config MMC_BLOCK
 	tristate "MMC block device driver"
 	depends on BLOCK
+	select MMC_PSTORE if MMC_PSTORE_BACKEND=y
 	default y
 	help
 	  Say Y here to enable the MMC block device driver support.
diff --git a/drivers/mmc/core/Makefile b/drivers/mmc/core/Makefile
index 6a907736cd7a..c3f1199deb71 100644
--- a/drivers/mmc/core/Makefile
+++ b/drivers/mmc/core/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_PWRSEQ_EMMC)	+= pwrseq_emmc.o
 mmc_core-$(CONFIG_DEBUG_FS)	+= debugfs.o
 obj-$(CONFIG_MMC_BLOCK)		+= mmc_block.o
 mmc_block-objs			:= block.o queue.o
+mmc_block-$(CONFIG_MMC_PSTORE)	+= mmcpstore.o
 obj-$(CONFIG_MMC_TEST)		+= mmc_test.o
 obj-$(CONFIG_SDIO_UART)		+= sdio_uart.o
 mmc_core-$(CONFIG_MMC_CRYPTO)	+= crypto.o
diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 20da7ed43e6d..c0feef7adbff 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2977,6 +2977,9 @@ static int mmc_blk_probe(struct mmc_card *card)
 	if (ret)
 		goto out;
 
+	if (mmc_card_mmc(card) || mmc_card_sd(card))
+		mmcpstore_register(card, md->disk->disk_name);
+
 	/* Add two debugfs entries */
 	mmc_blk_add_debugfs(card, md);
 
@@ -3126,6 +3129,7 @@ static void __exit mmc_blk_exit(void)
 	unregister_blkdev(MMC_BLOCK_MAJOR, "mmc");
 	unregister_chrdev_region(mmc_rpmb_devt, MAX_DEVICES);
 	bus_unregister(&mmc_rpmb_bus_type);
+	unregister_mmcpstore();
 }
 
 module_init(mmc_blk_init);
diff --git a/drivers/mmc/core/block.h b/drivers/mmc/core/block.h
index 31153f656f41..974081d0ab4e 100644
--- a/drivers/mmc/core/block.h
+++ b/drivers/mmc/core/block.h
@@ -16,5 +16,14 @@ void mmc_blk_mq_recovery(struct mmc_queue *mq);
 struct work_struct;
 
 void mmc_blk_mq_complete_work(struct work_struct *work);
+#if IS_ENABLED(CONFIG_MMC_PSTORE)
+sector_t mmc_blk_get_part(struct mmc_card *card, int part_num, sector_t *size);
+void mmcpstore_register(struct mmc_card *card, const char *disk_name);
+void unregister_mmcpstore(void);
+#else
+static inline void mmcpstore_register(struct mmc_card *card,
+				      const char *disk_name) {}
+static inline void unregister_mmcpstore(void) {}
+#endif
 
 #endif
diff --git a/drivers/mmc/core/mmcpstore.c b/drivers/mmc/core/mmcpstore.c
new file mode 100644
index 000000000000..3d4d5b984102
--- /dev/null
+++ b/drivers/mmc/core/mmcpstore.c
@@ -0,0 +1,592 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * MMC pstore support based on mtdpstore, pstore/blk
+ *
+ */
+
+#define pr_fmt(fmt) "mmcpstore: " fmt
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pstore_blk.h>
+#include <linux/blkdev.h>
+#include <linux/mount.h>
+#include <linux/slab.h>
+#include <linux/mmc/mmc.h>
+#include <linux/mmc/host.h>
+#include <linux/mmc/card.h>
+#include <linux/scatterlist.h>
+#include "block.h"
+#include "card.h"
+#include "core.h"
+
+#define MMC_READ_REQ		0
+#define MMC_WRITE_REQ		1
+#define MMC_PANIC_WRITE_REQ	2
+
+static struct mmcpstore_context {
+	struct pstore_blk_config conf;
+	struct pstore_device_info dev;
+	struct mmc_card	*card;
+	struct mmc_request *mrq;
+	sector_t start_sect;
+	sector_t size;
+	unsigned long *rmmap;    /* removed bit map */
+	unsigned long *usedmap;	 /* used bit map */
+
+} oops_cxt;
+
+static void mmc_wait_for_pstore_req(struct mmc_host *host,
+				    struct mmc_request *mrq,
+				    int poll)
+{
+	unsigned int timeout;
+
+	mmc_start_request(host, mrq);
+
+	if (poll && mrq->data) {
+		timeout = mrq->data->timeout_ns / NSEC_PER_MSEC;
+		host->ops->req_completion_poll(host, timeout);
+	}
+}
+
+static void mmc_prep_req(struct mmc_request *mrq,
+		unsigned int sect_offset, unsigned int nsects,
+		struct scatterlist *sg, u32 opcode, unsigned int flags)
+{
+	mrq->cmd->opcode = opcode;
+	mrq->cmd->arg = sect_offset;
+	mrq->cmd->flags = MMC_RSP_R1 | MMC_CMD_ADTC;
+
+	if (nsects == 1) {
+		mrq->stop = NULL;
+	} else {
+		mrq->stop->opcode = MMC_STOP_TRANSMISSION;
+		mrq->stop->arg = 0;
+		mrq->stop->flags = MMC_RSP_R1B | MMC_CMD_AC;
+	}
+
+	mrq->data->blksz = SECTOR_SIZE;
+	mrq->data->blocks = nsects;
+	mrq->data->flags = flags;
+	mrq->data->sg = sg;
+	mrq->data->sg_len = 1;
+}
+
+static int mmcpstore_req(const char *buf,
+			 size_t size, loff_t sect_offset, int write)
+{
+	struct mmcpstore_context *cxt = &oops_cxt;
+	struct mmc_request *mrq = cxt->mrq;
+	struct mmc_card *card = cxt->card;
+	struct mmc_host *host = card->host;
+	struct scatterlist sg;
+	u32 opcode;
+	u32 nsects = size >> SECTOR_SHIFT;
+
+	if (write == MMC_READ_REQ)
+		opcode = (nsects > 1) ? MMC_READ_MULTIPLE_BLOCK :
+			MMC_READ_SINGLE_BLOCK;
+	else
+		opcode = (nsects > 1) ? MMC_WRITE_MULTIPLE_BLOCK :
+			MMC_WRITE_BLOCK;
+
+	sg_init_one(&sg, buf, size);
+	mmc_prep_req(mrq, sect_offset, nsects, &sg, opcode,
+		     write ? MMC_DATA_WRITE : MMC_DATA_READ);
+	mmc_set_data_timeout(mrq->data, cxt->card);
+
+	mmc_claim_host(host);
+	mmc_wait_for_pstore_req(host, mrq,
+				(write == MMC_PANIC_WRITE_REQ)  ? 1 : 0);
+	mmc_release_host(host);
+
+	return 0;
+}
+
+static inline void mmcpstore_mark_used(struct mmcpstore_context *cxt,
+		loff_t off)
+{
+	u64 zonenum = div_u64(off, cxt->conf.kmsg_size);
+
+	dev_dbg(&cxt->card->dev, "mark zone %llu used\n", zonenum);
+	set_bit(zonenum, cxt->usedmap);
+}
+
+static inline void mmcpstore_mark_unused(struct mmcpstore_context *cxt,
+		loff_t off)
+{
+	u64 zonenum = div_u64(off, cxt->conf.kmsg_size);
+
+	dev_dbg(&cxt->card->dev, "mark zone %llu unused\n", zonenum);
+	clear_bit(zonenum, cxt->usedmap);
+}
+
+static inline void mmcpstore_block_mark_unused(struct mmcpstore_context *cxt,
+		loff_t off)
+{
+	u32 zonecnt = cxt->card->erase_size / cxt->conf.kmsg_size;
+	u64 zonenum;
+
+	off = ALIGN_DOWN(off, cxt->card->erase_size);
+	zonenum = div_u64(off, cxt->conf.kmsg_size);
+	while (zonecnt > 0) {
+		dev_dbg(&cxt->card->dev, "mark zone %llu unused\n", zonenum);
+		clear_bit(zonenum, cxt->usedmap);
+		zonenum++;
+		zonecnt--;
+	}
+}
+
+static inline int mmcpstore_is_used(struct mmcpstore_context *cxt, loff_t off)
+{
+	u64 zonenum = div_u64(off, cxt->conf.kmsg_size);
+
+	return test_bit(zonenum, cxt->usedmap);
+}
+
+static int mmcpstore_block_is_used(struct mmcpstore_context *cxt,
+		loff_t off)
+{
+	u32 zonecnt = cxt->card->erase_size / cxt->conf.kmsg_size;
+	u64 zonenum;
+
+	off = ALIGN_DOWN(off, cxt->card->erase_size);
+	zonenum = div_u64(off, cxt->conf.kmsg_size);
+	while (zonecnt > 0) {
+		if (test_bit(zonenum, cxt->usedmap))
+			return true;
+		zonenum++;
+		zonecnt--;
+	}
+	return false;
+}
+
+static int mmcpstore_is_empty(struct mmcpstore_context *cxt, char *buf,
+		size_t size)
+{
+	size_t sz;
+	int i;
+
+	sz = min_t(uint32_t, size, SECTOR_SIZE / 4);
+	for (i = 0; i < sz; i++) {
+		if (buf[i] != (char)0x00)
+			return false;
+	}
+
+	return true;
+}
+
+static void mmcpstore_mark_removed(struct mmcpstore_context *cxt, loff_t off)
+{
+	u64 zonenum = div_u64(off, cxt->conf.kmsg_size);
+
+	dev_dbg(&cxt->card->dev, "mark zone %llu removed\n", zonenum);
+	set_bit(zonenum, cxt->rmmap);
+}
+
+static void mmcpstore_block_clear_removed(struct mmcpstore_context *cxt,
+		loff_t off)
+{
+	u32 zonecnt = cxt->card->erase_size / cxt->conf.kmsg_size;
+	u64 zonenum;
+
+	off = ALIGN_DOWN(off, cxt->card->erase_size);
+	zonenum = div_u64(off, cxt->conf.kmsg_size);
+	while (zonecnt > 0) {
+		clear_bit(zonenum, cxt->rmmap);
+		zonenum++;
+		zonecnt--;
+	}
+}
+
+static int mmcpstore_block_is_removed(struct mmcpstore_context *cxt,
+		loff_t off)
+{
+	u32 zonecnt = cxt->card->erase_size / cxt->conf.kmsg_size;
+	u64 zonenum;
+
+	off = ALIGN_DOWN(off, cxt->card->erase_size);
+	zonenum = div_u64(off, cxt->conf.kmsg_size);
+	while (zonecnt > 0) {
+		if (test_bit(zonenum, cxt->rmmap))
+			return true;
+		zonenum++;
+		zonecnt--;
+	}
+	return false;
+}
+
+static int mmcpstore_erase_do(struct mmcpstore_context *cxt, size_t size, loff_t off)
+{
+	int ret;
+
+	off = ALIGN_DOWN(off, cxt->card->erase_size);
+	dev_dbg(&cxt->card->dev, "try to erase off 0x%llx\n", off);
+
+	ret = mmc_erase(cxt->card, cxt->start_sect, size >> 9,
+			MMC_ERASE_ARG);
+	if (!ret)
+		mmcpstore_block_clear_removed(cxt, off);
+	else
+		dev_err(&cxt->card->dev,
+			"erase of region [0x%llx, 0x%llx] on \"%s\" failed\n",
+			off, (unsigned long long) cxt->card->erase_size,
+			cxt->conf.device);
+
+	return ret;
+}
+
+/*
+ * called while removing file
+ *
+ * Avoiding over erasing, do erase block only when the whole block is unused.
+ * If the block contains valid log, do erase lazily on flush_removed() when
+ * unregister.
+ */
+static ssize_t mmcpstore_erase(size_t size, loff_t off)
+{
+	struct mmcpstore_context *cxt = &oops_cxt;
+
+	mmcpstore_mark_unused(cxt, off);
+
+	/* If the block still has valid data, mmcpstore do erase lazily */
+	if (likely(mmcpstore_block_is_used(cxt, off))) {
+		mmcpstore_mark_removed(cxt, off);
+		return 0;
+	}
+
+	/* all zones are unused, erase it */
+	return mmcpstore_erase_do(cxt, size, off);
+}
+
+/*
+ * What is security for mmcpstore?
+ * As there is no erase for panic case, we should ensure at least one zone
+ * is writable. Otherwise, panic write will fail.
+ * If zone is used, write operation will return -ENOMSG, which means that
+ * pstore/blk will try one by one until gets an empty zone. So, it is not
+ * needed to ensure the next zone is empty, but at least one.
+ */
+static int mmcpstore_security(struct mmcpstore_context *cxt, loff_t off)
+{
+	int ret = 0, i;
+	u32 zonenum = (u32)div_u64(off, cxt->conf.kmsg_size);
+	u32 zonecnt = (u32)div_u64(cxt->size, cxt->conf.kmsg_size);
+	u32 blkcnt = (u32)div_u64(cxt->size, cxt->card->erase_size);
+	u32 erasesize = cxt->card->erase_size;
+
+	for (i = 0; i < zonecnt; i++) {
+		u32 num = (zonenum + i) % zonecnt;
+
+		/* found empty zone */
+		if (!test_bit(num, cxt->usedmap))
+			return 0;
+	}
+
+	/* If there is no any empty zone, we have no way but to do erase */
+	while (blkcnt--) {
+		div64_u64_rem(off + erasesize, cxt->size, (u64 *)&off);
+
+		ret = mmcpstore_erase_do(cxt, cxt->size, off);
+		if (!ret) {
+			mmcpstore_block_mark_unused(cxt, off);
+			break;
+		}
+	}
+
+	if (ret)
+		dev_err(&cxt->card->dev, "all blocks bad!\n");
+
+	dev_dbg(&cxt->card->dev, "end security\n");
+
+	return ret;
+}
+
+static ssize_t mmcpstore_panic_write(const char *buf, size_t size, loff_t off)
+{
+	struct mmcpstore_context *cxt = &oops_cxt;
+	int ret;
+
+	/* zone is used, please try next one */
+	if (mmcpstore_is_used(cxt, off))
+		return -ENOMSG;
+
+	ret = mmcpstore_req(buf, size, cxt->start_sect + off,
+			    MMC_PANIC_WRITE_REQ);
+	if (ret)
+		return 0;
+
+	mmcpstore_mark_used(cxt, off);
+	dev_dbg(&cxt->card->dev, "mmcpstore panic write %lu\n", size);
+
+	return size;
+}
+
+static ssize_t mmcpstore_write(const char *buf, size_t size, loff_t off)
+{
+	struct mmcpstore_context *cxt = &oops_cxt;
+	int ret;
+
+	/* zone is used, please try next one */
+	if (mmcpstore_is_used(cxt, off))
+		return -ENOMSG;
+
+	ret = mmcpstore_req(buf, size, cxt->start_sect + off, MMC_WRITE_REQ);
+	if (ret)
+		return 0;
+
+	mmcpstore_mark_used(cxt, off);
+
+	mmcpstore_security(cxt, off);
+
+	return size;
+}
+
+static ssize_t mmcpstore_read(char *buf, size_t size, loff_t off)
+{
+	struct mmcpstore_context *cxt = &oops_cxt;
+	int ret;
+
+	ret = mmcpstore_req(buf, size, cxt->start_sect + off, MMC_READ_REQ);
+	if (ret)
+		return 0;
+
+	if (mmcpstore_is_empty(cxt, buf, size))
+		mmcpstore_mark_unused(cxt, off);
+	else
+		mmcpstore_mark_used(cxt, off);
+
+	mmcpstore_security(cxt, off);
+
+	return size;
+}
+
+static struct block_device *mmcpstore_open_backend(const char *device)
+{
+	struct block_device *bdev;
+	dev_t devt;
+
+	bdev = blkdev_get_by_path(device, FMODE_READ, NULL);
+
+	if (IS_ERR(bdev)) {
+		devt = name_to_dev_t(device);
+
+		if (devt == 0)
+			return ERR_PTR(-ENODEV);
+
+		bdev = blkdev_get_by_dev(devt, FMODE_READ, NULL);
+		if (IS_ERR(bdev))
+			return bdev;
+	}
+
+	return bdev;
+}
+
+static void mmcpstore_close_backend(struct block_device *bdev)
+{
+	if (!bdev)
+		return;
+	blkdev_put(bdev, FMODE_READ);
+}
+
+void mmcpstore_register(struct mmc_card *card, const char *disk_name)
+{
+	struct mmcpstore_context *cxt = &oops_cxt;
+	struct pstore_blk_config *conf = &cxt->conf;
+	struct block_device *bdev;
+	struct mmc_command *stop;
+	struct mmc_command *cmd;
+	struct mmc_request *mrq;
+	struct mmc_data *data;
+	int ret;
+	unsigned long longcnt;
+
+	ret = pstore_blk_get_config(conf);
+	if (!conf->device[0]) {
+		pr_debug("psblk backend is empty\n");
+		return;
+	}
+
+	bdev =  mmcpstore_open_backend(conf->device);
+	if (IS_ERR(bdev)) {
+		pr_err("%s failed to open with %ld\n",
+		conf->device, PTR_ERR(bdev));
+		return;
+	}
+
+	mmcpstore_close_backend(bdev);
+
+	dev_info(&card->dev, "found pstore mmc device %s\n", disk_name);
+
+	cxt->start_sect = get_start_sect(bdev);
+	cxt->size = bdev_nr_bytes(bdev);
+	cxt->card = card;
+
+	if (cxt->size < conf->kmsg_size * 2) {
+		dev_err(&card->dev, "pstore partition %s not big enough\n",
+			disk_name);
+		return;
+	}
+
+	mrq = kzalloc(sizeof(struct mmc_request), GFP_KERNEL);
+	if (!mrq)
+		goto out;
+
+	cmd = kzalloc(sizeof(struct mmc_command), GFP_KERNEL);
+	if (!cmd)
+		goto free_mrq;
+
+	stop = kzalloc(sizeof(struct mmc_command), GFP_KERNEL);
+	if (!stop)
+		goto free_cmd;
+
+	data = kzalloc(sizeof(struct mmc_data), GFP_KERNEL);
+	if (!data)
+		goto free_stop;
+
+
+	if (unlikely(conf->kmsg_size % SECTOR_SIZE)) {
+		dev_err(&cxt->card->dev,
+			"record size %lu KB must align to %d Bytes\n",
+			conf->kmsg_size / 1024,
+			SECTOR_SIZE);
+		goto free_data;
+	}
+
+	longcnt = BITS_TO_LONGS(div_u64(cxt->size, conf->kmsg_size));
+	cxt->rmmap = kcalloc(longcnt, sizeof(long), GFP_KERNEL);
+	if (!cxt->rmmap)
+		goto free_data;
+
+	cxt->usedmap = kcalloc(longcnt, sizeof(long), GFP_KERNEL);
+	if (!cxt->usedmap) {
+		kfree(cxt->rmmap);
+		goto free_data;
+	}
+
+
+	mrq->cmd = cmd;
+	mrq->data = data;
+	mrq->stop = stop;
+	cxt->mrq = mrq;
+
+	cxt->dev.flags = PSTORE_FLAGS_DMESG | PSTORE_FLAGS_CONSOLE |
+			 PSTORE_FLAGS_PMSG;
+	cxt->dev.zone.read = mmcpstore_read;
+	cxt->dev.zone.write = mmcpstore_write;
+	cxt->dev.zone.erase = mmcpstore_erase;
+	cxt->dev.zone.panic_write = mmcpstore_panic_write;
+	cxt->dev.zone.total_size = cxt->size;
+
+	ret = register_pstore_device(&cxt->dev);
+	if (ret) {
+		pr_err("%s registering with psblk failed (%d)\n",
+		       conf->device, ret);
+		goto free_data;
+	}
+
+	pr_info("%s start sector %lld size %lld registered as psblk backend\n",
+		conf->device, cxt->start_sect, cxt->size);
+	pr_info("%s erase_size %d sector size %d kmesg size %lu\n", conf->device,
+		cxt->card->erase_size, SECTOR_SIZE, conf->kmsg_size);
+
+	return;
+
+free_data:
+	kfree(data);
+free_stop:
+	kfree(stop);
+free_cmd:
+	kfree(cmd);
+free_mrq:
+	kfree(mrq);
+out:
+	pr_info("%s register pstoreblk backend device failed\n", conf->device);
+}
+
+static int mmcpstore_flush_removed_do(struct mmcpstore_context *cxt,
+				      loff_t off, size_t size)
+{
+	u_char *buf;
+	int ret;
+
+	buf = kmalloc(cxt->card->erase_size, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	/* 1st. read to cache */
+	ret = mmcpstore_read(buf, cxt->card->erase_size, off);
+	if (ret < 0)
+		goto free;
+
+	/* 2nd. erase block */
+	ret = mmcpstore_erase_do(cxt, cxt->size, off);
+	if (ret)
+		goto free;
+
+	/* 3rd. write back */
+	while (size) {
+		unsigned int zonesize = cxt->conf.kmsg_size;
+
+		/* there is valid data on block, write back */
+		if (mmcpstore_is_used(cxt, off)) {
+			ret = mmcpstore_req(buf, zonesize, cxt->start_sect + off,
+					    MMC_WRITE_REQ);
+
+			if (ret)
+				dev_err(&cxt->card->dev,
+					"write failure at %lld (%u bytes), err %d\n",
+					off, zonesize, ret);
+		}
+
+		off += zonesize;
+		size -= min_t(unsigned int, zonesize, size);
+	}
+
+free:
+	kfree(buf);
+	return ret;
+}
+
+
+/*
+ * What does mmcpstore_flush_removed() do?
+ * When user remove any log file on pstore filesystem, mmcpstore should do
+ * something to ensure log file removed. If the whole block is no longer used,
+ * it's nice to erase the block. However if the block still contains valid log,
+ * what mmcpstore can do is to erase and write the valid log back.
+ */
+static int mmcpstore_flush_removed(struct mmcpstore_context *cxt)
+{
+	int ret;
+	loff_t off;
+	u32 blkcnt = (u32)div_u64(cxt->size, cxt->card->erase_size);
+
+	for (off = 0; blkcnt > 0; blkcnt--, off += cxt->card->erase_size) {
+
+		ret = mmcpstore_block_is_removed(cxt, off);
+		if (!ret)
+			continue;
+
+		ret = mmcpstore_flush_removed_do(cxt, off, cxt->card->erase_size);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
+void unregister_mmcpstore(void)
+{
+	struct mmcpstore_context *cxt = &oops_cxt;
+
+	mmcpstore_flush_removed(cxt);
+	unregister_pstore_device(&cxt->dev);
+	kfree(cxt->mrq->data);
+	kfree(cxt->mrq->stop);
+	kfree(cxt->mrq->cmd);
+	kfree(cxt->mrq);
+	kfree(cxt->usedmap);
+	kfree(cxt->rmmap);
+	cxt->card = NULL;
+}
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index f3af1bd0f7b9..b4d21366cbd7 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3653,6 +3653,24 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 	return result;
 }
 
+static int sdhci_completion_poll(struct mmc_host *mmc, unsigned long msecs)
+{
+	int result;
+	struct sdhci_host *host = mmc_priv(mmc);
+
+	DBG("IRQ Poll\n");
+	while (1) {
+		result = sdhci_irq(host->irq, host);
+		mdelay(1);
+		msecs--;
+
+		if (!msecs)
+			break;
+	}
+
+	return result;
+}
+
 static irqreturn_t sdhci_thread_irq(int irq, void *dev_id)
 {
 	struct sdhci_host *host = dev_id;
@@ -4055,6 +4073,8 @@ struct sdhci_host *sdhci_alloc_host(struct device *dev,
 
 	host->max_timeout_count = 0xE;
 
+	host->mmc_host_ops.req_completion_poll = sdhci_completion_poll;
+
 	return host;
 }
 
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 8fdd3cf971a3..bb908d778843 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -212,6 +212,9 @@ struct mmc_host_ops {
 
 	/* Initialize an SD express card, mandatory for MMC_CAP2_SD_EXP. */
 	int	(*init_sd_express)(struct mmc_host *host, struct mmc_ios *ios);
+
+	int	(*req_completion_poll)(struct mmc_host *host,
+				       unsigned long timeout);
 };
 
 struct mmc_cqe_ops {
-- 
2.17.1

