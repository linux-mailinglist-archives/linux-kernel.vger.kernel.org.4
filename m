Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA2864F389
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 22:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbiLPVyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 16:54:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiLPVya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 16:54:30 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8D65F411;
        Fri, 16 Dec 2022 13:54:17 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id bw27so1700906qtb.3;
        Fri, 16 Dec 2022 13:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8Hb9MHxin/7lGhNZBN/hZR7ahMDbRDkBczSL8utvH1U=;
        b=SheswvBnYdtICyVN1yZXYXdL/QsNhbPTzTzDmraNrMhWF13g4eLUUKCreOwagjvvvO
         thgecGCD5ecPhF6Nx3LbzuucDyVS92h97UyQpXsnnnxCZEnmsENW5VhuiyW0BXjNjhuX
         IgfP9+wfI2RfEte8VolVcjhCILO1+g0yji+s8NbQVkIebQbS51Dh3MeqxcgHCa2td7vJ
         Xa9uEBEJFhQKJcYOHPLS7P4oE/Y/xypv6OpMgxjtgSfsk+TBb7auxHoNoUGTwdtuEFeM
         W+ViNf9xo6bgE1D4SYS4aYSiGFu0vGSWVMo5El1FoJVFCmYeyaFhDmz8AWxotuSpWxj/
         qjeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Hb9MHxin/7lGhNZBN/hZR7ahMDbRDkBczSL8utvH1U=;
        b=EHZv0HUtT5eOCZX2q4LxRnPWRSRvhE704oGQPbLrClgKjzPuv7j9v9BXHkcEx5OhFF
         8nIieq3CNTbrPWlPPg9R9b0LTqykasqq6yKWkZgXH+kDbymkvCL8zCt1rS4KN+iUyv+2
         2hyC0YtRgLVtU3QwC9aIQl9z8vRiE44J4qCSqI7Z8Y968V0odwv9snQpLHofNd402Ohq
         Fp/VHq+A9eHGo+A3wwfBVroHHSRa8WPE80H3dBh+Ggeb0nFUWZKjuE05dtARuJl7fj+K
         KhWk0Le5fLQ0wPwS3bHKDkOpqA4lTNPBJsIzE1abw2pwjupExpln5FflBBc8QfpNSPL8
         JwwQ==
X-Gm-Message-State: ANoB5pl6TPLq203XHG/3ICWa3zp6ZxrKqBJRI7cL7kiHo1BNeM1y6nDF
        98ihFvV6RAwyq0NWDDDu2Qc=
X-Google-Smtp-Source: AA0mqf7f1GFUlGU0cR70I+rGK4syowMwCwfxfB9VjjGuzEFV/mkBzTMsxJe0yg6bGCkRYn6L35YDDA==
X-Received: by 2002:ac8:1014:0:b0:3a4:3137:79b3 with SMTP id z20-20020ac81014000000b003a4313779b3mr41351331qti.64.1671227655819;
        Fri, 16 Dec 2022 13:54:15 -0800 (PST)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id o12-20020ac8554c000000b003972790deb9sm1947605qtr.84.2022.12.16.13.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 13:54:15 -0800 (PST)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     keescook@chromium.org, linux-kernel@vger.kernel.org,
        gmpy.liaowx@gmail.com, linux-mmc@vger.kernel.org
Cc:     f.fainelli@gmail.com, tony.luck@intel.com, anton@enomsg.org,
        Kamal Dasu <kdasu.kdev@gmail.com>
Subject: [RFC 1/1] mmc: Add mmc pstore backend support
Date:   Fri, 16 Dec 2022 16:54:10 -0500
Message-Id: <20221216215410.26960-2-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221216215410.26960-1-kdasu.kdev@gmail.com>
References: <20221216215410.26960-1-kdasu.kdev@gmail.com>
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
 drivers/mmc/core/block.c     |  61 ++--
 drivers/mmc/core/block.h     |   9 +
 drivers/mmc/core/core.c      |  28 +-
 drivers/mmc/core/mmcpstore.c | 594 +++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci.c     | 166 +++++-----
 include/linux/mmc/host.h     |   3 +
 8 files changed, 746 insertions(+), 129 deletions(-)
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
index 20da7ed43e6d..95da015c65b8 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -134,7 +134,6 @@ struct mmc_blk_data {
 	 * track of the current selected device partition.
 	 */
 	unsigned int	part_curr;
-#define MMC_BLK_PART_INVALID	UINT_MAX	/* Unknown partition active */
 	int	area_type;
 
 	/* debugfs files (only in main mmc_blk_data) */
@@ -514,6 +513,19 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 		if (idata->ic.data_timeout_ns)
 			data.timeout_ns = idata->ic.data_timeout_ns;
 
+		if ((cmd.flags & MMC_RSP_R1B) == MMC_RSP_R1B) {
+			/*
+			 * Pretend this is a data transfer and rely on the
+			 * host driver to compute timeout.  When all host
+			 * drivers support cmd.cmd_timeout for R1B, this
+			 * can be changed to:
+			 *
+			 *     mrq.data = NULL;
+			 *     cmd.cmd_timeout = idata->ic.cmd_timeout_ms;
+			 */
+			data.timeout_ns = idata->ic.cmd_timeout_ms * 1000000;
+		}
+
 		mrq.data = &data;
 	}
 
@@ -975,39 +987,33 @@ static unsigned int mmc_blk_data_timeout_ms(struct mmc_host *host,
 	return ms;
 }
 
-/*
- * Attempts to reset the card and get back to the requested partition.
- * Therefore any error here must result in cancelling the block layer
- * request, it must not be reattempted without going through the mmc_blk
- * partition sanity checks.
- */
 static int mmc_blk_reset(struct mmc_blk_data *md, struct mmc_host *host,
 			 int type)
 {
 	int err;
-	struct mmc_blk_data *main_md = dev_get_drvdata(&host->card->dev);
 
 	if (md->reset_done & type)
 		return -EEXIST;
 
 	md->reset_done |= type;
 	err = mmc_hw_reset(host->card);
-	/*
-	 * A successful reset will leave the card in the main partition, but
-	 * upon failure it might not be, so set it to MMC_BLK_PART_INVALID
-	 * in that case.
-	 */
-	main_md->part_curr = err ? MMC_BLK_PART_INVALID : main_md->part_type;
-	if (err)
-		return err;
 	/* Ensure we switch back to the correct partition */
-	if (mmc_blk_part_switch(host->card, md->part_type))
-		/*
-		 * We have failed to get back into the correct
-		 * partition, so we need to abort the whole request.
-		 */
-		return -ENODEV;
-	return 0;
+	if (err) {
+		struct mmc_blk_data *main_md =
+			dev_get_drvdata(&host->card->dev);
+		int part_err;
+
+		main_md->part_curr = main_md->part_type;
+		part_err = mmc_blk_part_switch(host->card, md->part_type);
+		if (part_err) {
+			/*
+			 * We have failed to get back into the correct
+			 * partition, so we need to abort the whole request.
+			 */
+			return -ENODEV;
+		}
+	}
+	return err;
 }
 
 static inline void mmc_blk_reset_success(struct mmc_blk_data *md, int type)
@@ -1865,9 +1871,8 @@ static void mmc_blk_mq_rw_recovery(struct mmc_queue *mq, struct request *req)
 		return;
 
 	/* Reset before last retry */
-	if (mqrq->retries + 1 == MMC_MAX_RETRIES &&
-	    mmc_blk_reset(md, card->host, type))
-		return;
+	if (mqrq->retries + 1 == MMC_MAX_RETRIES)
+		mmc_blk_reset(md, card->host, type);
 
 	/* Command errors fail fast, so use all MMC_MAX_RETRIES */
 	if (brq->sbc.error || brq->cmd.error)
@@ -2977,6 +2982,9 @@ static int mmc_blk_probe(struct mmc_card *card)
 	if (ret)
 		goto out;
 
+	if (mmc_card_mmc(card) || mmc_card_sd(card))
+		mmcpstore_register(card, md->disk->disk_name);
+
 	/* Add two debugfs entries */
 	mmc_blk_add_debugfs(card, md);
 
@@ -3126,6 +3134,7 @@ static void __exit mmc_blk_exit(void)
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
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 426c7f66b349..ef53a2578824 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -56,7 +56,7 @@ static const unsigned freqs[] = { 400000, 300000, 200000, 100000 };
 /*
  * Enabling software CRCs on the data blocks can be a significant (30%)
  * performance cost, and for other reasons may not always be desired.
- * So we allow it to be disabled.
+ * So we allow it it to be disabled.
  */
 bool use_spi_crc = 1;
 module_param(use_spi_crc, bool, 0);
@@ -97,8 +97,8 @@ static void mmc_should_fail_request(struct mmc_host *host,
 	    !should_fail(&host->fail_mmc_request, data->blksz * data->blocks))
 		return;
 
-	data->error = data_errors[get_random_u32_below(ARRAY_SIZE(data_errors))];
-	data->bytes_xfered = get_random_u32_below(data->bytes_xfered >> 9) << 9;
+	data->error = data_errors[prandom_u32() % ARRAY_SIZE(data_errors)];
+	data->bytes_xfered = (prandom_u32() % (data->bytes_xfered >> 9)) << 9;
 }
 
 #else /* CONFIG_FAIL_MMC_REQUEST */
@@ -142,7 +142,8 @@ void mmc_request_done(struct mmc_host *host, struct mmc_request *mrq)
 	int err = cmd->error;
 
 	/* Flag re-tuning needed on CRC errors */
-	if (!mmc_op_tuning(cmd->opcode) &&
+	if (cmd->opcode != MMC_SEND_TUNING_BLOCK &&
+	    cmd->opcode != MMC_SEND_TUNING_BLOCK_HS200 &&
 	    !host->retune_crc_disable &&
 	    (err == -EILSEQ || (mrq->sbc && mrq->sbc->error == -EILSEQ) ||
 	    (mrq->data && mrq->data->error == -EILSEQ) ||
@@ -526,7 +527,7 @@ EXPORT_SYMBOL(mmc_cqe_post_req);
  * mmc_cqe_recovery - Recover from CQE errors.
  * @host: MMC host to recover
  *
- * Recovery consists of stopping CQE, stopping eMMC, discarding the queue
+ * Recovery consists of stopping CQE, stopping eMMC, discarding the queue in
  * in eMMC, and discarding the queue in CQE. CQE must call
  * mmc_cqe_request_done() on all requests. An error is returned if the eMMC
  * fails to discard its queue.
@@ -1133,13 +1134,7 @@ u32 mmc_select_voltage(struct mmc_host *host, u32 ocr)
 		mmc_power_cycle(host, ocr);
 	} else {
 		bit = fls(ocr) - 1;
-		/*
-		 * The bit variable represents the highest voltage bit set in
-		 * the OCR register.
-		 * To keep a range of 2 values (e.g. 3.2V/3.3V and 3.3V/3.4V),
-		 * we must shift the mask '3' with (bit - 1).
-		 */
-		ocr &= 3 << (bit - 1);
+		ocr &= 3 << bit;
 		if (bit != host->ios.vdd)
 			dev_warn(mmc_dev(host), "exceeding card's volts\n");
 	}
@@ -1483,11 +1478,6 @@ void mmc_init_erase(struct mmc_card *card)
 		card->pref_erase = 0;
 }
 
-static bool is_trim_arg(unsigned int arg)
-{
-	return (arg & MMC_TRIM_OR_DISCARD_ARGS) && arg != MMC_DISCARD_ARG;
-}
-
 static unsigned int mmc_mmc_erase_timeout(struct mmc_card *card,
 				          unsigned int arg, unsigned int qty)
 {
@@ -1770,7 +1760,7 @@ int mmc_erase(struct mmc_card *card, unsigned int from, unsigned int nr,
 	    !(card->ext_csd.sec_feature_support & EXT_CSD_SEC_ER_EN))
 		return -EOPNOTSUPP;
 
-	if (mmc_card_mmc(card) && is_trim_arg(arg) &&
+	if (mmc_card_mmc(card) && (arg & MMC_TRIM_ARGS) &&
 	    !(card->ext_csd.sec_feature_support & EXT_CSD_SEC_GB_CL_EN))
 		return -EOPNOTSUPP;
 
@@ -1800,7 +1790,7 @@ int mmc_erase(struct mmc_card *card, unsigned int from, unsigned int nr,
 	 * identified by the card->eg_boundary flag.
 	 */
 	rem = card->erase_size - (from % card->erase_size);
-	if ((arg & MMC_TRIM_OR_DISCARD_ARGS) && card->eg_boundary && nr > rem) {
+	if ((arg & MMC_TRIM_ARGS) && (card->eg_boundary) && (nr > rem)) {
 		err = mmc_do_erase(card, from, from + rem - 1, arg);
 		from += rem;
 		if ((err) || (to <= from))
diff --git a/drivers/mmc/core/mmcpstore.c b/drivers/mmc/core/mmcpstore.c
new file mode 100644
index 000000000000..f881be42aa41
--- /dev/null
+++ b/drivers/mmc/core/mmcpstore.c
@@ -0,0 +1,594 @@
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
+
+	if (MMC_READ_REQ)
+		opcode = (nsects > 1) ? MMC_READ_MULTIPLE_BLOCK :
+			MMC_READ_SINGLE_BLOCK;
+	else
+		opcode = (nsects > 1) ? MMC_WRITE_MULTIPLE_BLOCK :
+			MMC_WRITE_BLOCK;
+
+
+	sg_init_one(&sg, buf, size);
+	mmc_prep_req(mrq, sect_offset, nsects, &sg, opcode, MMC_DATA_WRITE);
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
+			off, (long long unsigned) cxt->card->erase_size,
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
+	dev_dbg(&cxt->card->dev, "mmcpstore panic write %llu \n", size);
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
+	devt = name_to_dev_t(device);
+	if (devt == 0)
+			return ERR_PTR(-ENODEV);
+
+		bdev = blkdev_get_by_dev(devt, FMODE_READ, NULL);
+		if (IS_ERR(bdev))
+			return bdev;
+}
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
+	cxt->dev.flags = PSTORE_FLAGS_DMESG;
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
+	pr_info("%s erase_size %d sector size %d kmesg size %lu \n", conf->device,
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
+
+	return;
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
+		if (mmcpstore_is_used(cxt, off))
+		{
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
index f3af1bd0f7b9..08e4ecd13693 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -270,11 +270,6 @@ enum sdhci_reset_reason {
 
 static void sdhci_reset_for_reason(struct sdhci_host *host, enum sdhci_reset_reason reason)
 {
-	if (host->quirks2 & SDHCI_QUIRK2_ISSUE_CMD_DAT_RESET_TOGETHER) {
-		sdhci_do_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
-		return;
-	}
-
 	switch (reason) {
 	case SDHCI_RESET_FOR_INIT:
 		sdhci_do_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
@@ -378,7 +373,6 @@ static void sdhci_init(struct sdhci_host *host, int soft)
 	if (soft) {
 		/* force clock reconfiguration */
 		host->clock = 0;
-		host->reinit_uhs = true;
 		mmc->ops->set_ios(mmc, &mmc->ios);
 	}
 }
@@ -531,6 +525,7 @@ static inline bool sdhci_has_requests(struct sdhci_host *host)
 
 static void sdhci_read_block_pio(struct sdhci_host *host)
 {
+	unsigned long flags;
 	size_t blksize, len, chunk;
 	u32 scratch;
 	u8 *buf;
@@ -540,6 +535,8 @@ static void sdhci_read_block_pio(struct sdhci_host *host)
 	blksize = host->data->blksz;
 	chunk = 0;
 
+	local_irq_save(flags);
+
 	while (blksize) {
 		BUG_ON(!sg_miter_next(&host->sg_miter));
 
@@ -566,10 +563,13 @@ static void sdhci_read_block_pio(struct sdhci_host *host)
 	}
 
 	sg_miter_stop(&host->sg_miter);
+
+	local_irq_restore(flags);
 }
 
 static void sdhci_write_block_pio(struct sdhci_host *host)
 {
+	unsigned long flags;
 	size_t blksize, len, chunk;
 	u32 scratch;
 	u8 *buf;
@@ -580,6 +580,8 @@ static void sdhci_write_block_pio(struct sdhci_host *host)
 	chunk = 0;
 	scratch = 0;
 
+	local_irq_save(flags);
+
 	while (blksize) {
 		BUG_ON(!sg_miter_next(&host->sg_miter));
 
@@ -606,6 +608,8 @@ static void sdhci_write_block_pio(struct sdhci_host *host)
 	}
 
 	sg_miter_stop(&host->sg_miter);
+
+	local_irq_restore(flags);
 }
 
 static void sdhci_transfer_pio(struct sdhci_host *host)
@@ -701,14 +705,16 @@ static int sdhci_pre_dma_transfer(struct sdhci_host *host,
 	return sg_count;
 }
 
-static char *sdhci_kmap_atomic(struct scatterlist *sg)
+static char *sdhci_kmap_atomic(struct scatterlist *sg, unsigned long *flags)
 {
-	return kmap_local_page(sg_page(sg)) + sg->offset;
+	local_irq_save(*flags);
+	return kmap_atomic(sg_page(sg)) + sg->offset;
 }
 
-static void sdhci_kunmap_atomic(void *buffer)
+static void sdhci_kunmap_atomic(void *buffer, unsigned long *flags)
 {
-	kunmap_local(buffer);
+	kunmap_atomic(buffer);
+	local_irq_restore(*flags);
 }
 
 void sdhci_adma_write_desc(struct sdhci_host *host, void **desc,
@@ -750,6 +756,7 @@ static void sdhci_adma_table_pre(struct sdhci_host *host,
 	struct mmc_data *data, int sg_count)
 {
 	struct scatterlist *sg;
+	unsigned long flags;
 	dma_addr_t addr, align_addr;
 	void *desc, *align;
 	char *buffer;
@@ -781,9 +788,9 @@ static void sdhci_adma_table_pre(struct sdhci_host *host,
 			 SDHCI_ADMA2_MASK;
 		if (offset) {
 			if (data->flags & MMC_DATA_WRITE) {
-				buffer = sdhci_kmap_atomic(sg);
+				buffer = sdhci_kmap_atomic(sg, &flags);
 				memcpy(align, buffer, offset);
-				sdhci_kunmap_atomic(buffer);
+				sdhci_kunmap_atomic(buffer, &flags);
 			}
 
 			/* tran, valid */
@@ -844,6 +851,7 @@ static void sdhci_adma_table_post(struct sdhci_host *host,
 	int i, size;
 	void *align;
 	char *buffer;
+	unsigned long flags;
 
 	if (data->flags & MMC_DATA_READ) {
 		bool has_unaligned = false;
@@ -866,9 +874,9 @@ static void sdhci_adma_table_post(struct sdhci_host *host,
 					size = SDHCI_ADMA2_ALIGN -
 					       (sg_dma_address(sg) & SDHCI_ADMA2_MASK);
 
-					buffer = sdhci_kmap_atomic(sg);
+					buffer = sdhci_kmap_atomic(sg, &flags);
 					memcpy(buffer, align, size);
-					sdhci_kunmap_atomic(buffer);
+					sdhci_kunmap_atomic(buffer, &flags);
 
 					align += SDHCI_ADMA2_ALIGN;
 				}
@@ -1457,7 +1465,7 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
 		if (host->quirks2 &
 			SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_CMD) {
 			/* must not clear SDHCI_TRANSFER_MODE when tuning */
-			if (!mmc_op_tuning(cmd->opcode))
+			if (cmd->opcode != MMC_SEND_TUNING_BLOCK_HS200)
 				sdhci_writew(host, 0x0, SDHCI_TRANSFER_MODE);
 		} else {
 		/* clear Auto CMD settings for no data CMDs */
@@ -1698,7 +1706,8 @@ static bool sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 		flags |= SDHCI_CMD_INDEX;
 
 	/* CMD19 is special in that the Data Present Select should be set */
-	if (cmd->data || mmc_op_tuning(cmd->opcode))
+	if (cmd->data || cmd->opcode == MMC_SEND_TUNING_BLOCK ||
+	    cmd->opcode == MMC_SEND_TUNING_BLOCK_HS200)
 		flags |= SDHCI_CMD_DATA;
 
 	timeout = jiffies;
@@ -2284,46 +2293,11 @@ void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing)
 }
 EXPORT_SYMBOL_GPL(sdhci_set_uhs_signaling);
 
-static bool sdhci_timing_has_preset(unsigned char timing)
-{
-	switch (timing) {
-	case MMC_TIMING_UHS_SDR12:
-	case MMC_TIMING_UHS_SDR25:
-	case MMC_TIMING_UHS_SDR50:
-	case MMC_TIMING_UHS_SDR104:
-	case MMC_TIMING_UHS_DDR50:
-	case MMC_TIMING_MMC_DDR52:
-		return true;
-	}
-	return false;
-}
-
-static bool sdhci_preset_needed(struct sdhci_host *host, unsigned char timing)
-{
-	return !(host->quirks2 & SDHCI_QUIRK2_PRESET_VALUE_BROKEN) &&
-	       sdhci_timing_has_preset(timing);
-}
-
-static bool sdhci_presetable_values_change(struct sdhci_host *host, struct mmc_ios *ios)
-{
-	/*
-	 * Preset Values are: Driver Strength, Clock Generator and SDCLK/RCLK
-	 * Frequency. Check if preset values need to be enabled, or the Driver
-	 * Strength needs updating. Note, clock changes are handled separately.
-	 */
-	return !host->preset_enabled &&
-	       (sdhci_preset_needed(host, ios->timing) || host->drv_type != ios->drv_type);
-}
-
 void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct sdhci_host *host = mmc_priv(mmc);
-	bool reinit_uhs = host->reinit_uhs;
-	bool turning_on_clk = false;
 	u8 ctrl;
 
-	host->reinit_uhs = false;
-
 	if (ios->power_mode == MMC_POWER_UNDEFINED)
 		return;
 
@@ -2349,8 +2323,6 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		sdhci_enable_preset_value(host, false);
 
 	if (!ios->clock || ios->clock != host->clock) {
-		turning_on_clk = ios->clock && !host->clock;
-
 		host->ops->set_clock(host, ios->clock);
 		host->clock = ios->clock;
 
@@ -2377,17 +2349,6 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 	host->ops->set_bus_width(host, ios->bus_width);
 
-	/*
-	 * Special case to avoid multiple clock changes during voltage
-	 * switching.
-	 */
-	if (!reinit_uhs &&
-	    turning_on_clk &&
-	    host->timing == ios->timing &&
-	    host->version >= SDHCI_SPEC_300 &&
-	    !sdhci_presetable_values_change(host, ios))
-		return;
-
 	ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
 
 	if (!(host->quirks & SDHCI_QUIRK_NO_HISPD_BIT)) {
@@ -2408,21 +2369,8 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	if (host->version >= SDHCI_SPEC_300) {
 		u16 clk, ctrl_2;
 
-		/*
-		 * According to SDHCI Spec v3.00, if the Preset Value
-		 * Enable in the Host Control 2 register is set, we
-		 * need to reset SD Clock Enable before changing High
-		 * Speed Enable to avoid generating clock glitches.
-		 */
-		clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
-		if (clk & SDHCI_CLOCK_CARD_EN) {
-			clk &= ~SDHCI_CLOCK_CARD_EN;
-			sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
-		}
-
-		sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
-
 		if (!host->preset_enabled) {
+			sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
 			/*
 			 * We only need to set Driver Strength if the
 			 * preset value enable is not set.
@@ -2444,20 +2392,46 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 			}
 
 			sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
-			host->drv_type = ios->drv_type;
+		} else {
+			/*
+			 * According to SDHC Spec v3.00, if the Preset Value
+			 * Enable in the Host Control 2 register is set, we
+			 * need to reset SD Clock Enable before changing High
+			 * Speed Enable to avoid generating clock gliches.
+			 */
+
+			/* Reset SD Clock Enable */
+			clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+			clk &= ~SDHCI_CLOCK_CARD_EN;
+			sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+
+			sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
+
+			/* Re-enable SD Clock */
+			host->ops->set_clock(host, host->clock);
 		}
 
+		/* Reset SD Clock Enable */
+		clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+		clk &= ~SDHCI_CLOCK_CARD_EN;
+		sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+
 		host->ops->set_uhs_signaling(host, ios->timing);
 		host->timing = ios->timing;
 
-		if (sdhci_preset_needed(host, ios->timing)) {
+		if (!(host->quirks2 & SDHCI_QUIRK2_PRESET_VALUE_BROKEN) &&
+				((ios->timing == MMC_TIMING_UHS_SDR12) ||
+				 (ios->timing == MMC_TIMING_UHS_SDR25) ||
+				 (ios->timing == MMC_TIMING_UHS_SDR50) ||
+				 (ios->timing == MMC_TIMING_UHS_SDR104) ||
+				 (ios->timing == MMC_TIMING_UHS_DDR50) ||
+				 (ios->timing == MMC_TIMING_MMC_DDR52))) {
 			u16 preset;
 
 			sdhci_enable_preset_value(host, true);
 			preset = sdhci_get_preset_value(host);
 			ios->drv_type = FIELD_GET(SDHCI_PRESET_DRV_MASK,
 						  preset);
-			host->drv_type = ios->drv_type;
 		}
 
 		/* Re-enable SD Clock */
@@ -3369,6 +3343,8 @@ static void sdhci_adma_show_error(struct sdhci_host *host)
 
 static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
 {
+	u32 command;
+
 	/*
 	 * CMD19 generates _only_ Buffer Read Ready interrupt if
 	 * use sdhci_send_tuning.
@@ -3377,7 +3353,9 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
 	 * SDHCI_INT_DATA_AVAIL always there, stuck in irq storm.
 	 */
 	if (intmask & SDHCI_INT_DATA_AVAIL && !host->data) {
-		if (mmc_op_tuning(SDHCI_GET_CMD(sdhci_readw(host, SDHCI_COMMAND)))) {
+		command = SDHCI_GET_CMD(sdhci_readw(host, SDHCI_COMMAND));
+		if (command == MMC_SEND_TUNING_BLOCK ||
+		    command == MMC_SEND_TUNING_BLOCK_HS200) {
 			host->tuning_done = 1;
 			wake_up(&host->buf_ready_int);
 			return;
@@ -3653,6 +3631,24 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 	return result;
 }
 
+static int sdhci_completion_poll(struct mmc_host *mmc, unsigned long msecs)
+{
+	int result;
+	struct sdhci_host *host = mmc_priv(mmc);
+
+	DBG("IRQ Poll\n");
+	while(1) {
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
@@ -3790,7 +3786,6 @@ int sdhci_resume_host(struct sdhci_host *host)
 		sdhci_init(host, 0);
 		host->pwr = 0;
 		host->clock = 0;
-		host->reinit_uhs = true;
 		mmc->ops->set_ios(mmc, &mmc->ios);
 	} else {
 		sdhci_init(host, (mmc->pm_flags & MMC_PM_KEEP_POWER));
@@ -3853,7 +3848,6 @@ int sdhci_runtime_resume_host(struct sdhci_host *host, int soft_reset)
 		/* Force clock and power re-program */
 		host->pwr = 0;
 		host->clock = 0;
-		host->reinit_uhs = true;
 		mmc->ops->start_signal_voltage_switch(mmc, &mmc->ios);
 		mmc->ops->set_ios(mmc, &mmc->ios);
 
@@ -4055,6 +4049,8 @@ struct sdhci_host *sdhci_alloc_host(struct device *dev,
 
 	host->max_timeout_count = 0xE;
 
+	host->mmc_host_ops.req_completion_poll = sdhci_completion_poll;
+	
 	return host;
 }
 
@@ -4754,6 +4750,8 @@ int sdhci_setup_host(struct sdhci_host *host)
 		/* This may alter mmc->*_blk_* parameters */
 		sdhci_allocate_bounce_buffer(host);
 
+	pr_info("block size, assuming max_blk_sz %u bytes max_req_sz %u \n", mmc->max_blk_size, mmc->max_req_size);
+	
 	return 0;
 
 unreg:
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

