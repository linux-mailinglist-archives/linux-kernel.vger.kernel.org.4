Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1716600A26
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 11:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbiJQJOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 05:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiJQJNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 05:13:36 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B14E4CA03;
        Mon, 17 Oct 2022 02:13:19 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id n7so10231874plp.1;
        Mon, 17 Oct 2022 02:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UdG4MmSrSVXj2AOOOO/+ILrQ0BjQgwzE0+PHc9VPkME=;
        b=BEHvzNKBUyft5EriIOyv6W1U26wOr6eVAQ0iL9O8shFGcA+a4lj4jZG4PIxOPSSkNw
         2NbgfP0U36hjK3PFH+iJaaqWdGBqZD/xdHzv8fnwyfKJAe2OlvRDuJB+0j51jf18h48u
         XxKvN41FENtGjFRL6+SJsAzRL+PyK1ETkOkJIILZ9Kg5j+TQg094HsYMG7l+yQ5vElZj
         B7SnOalmKRemFOshItN+JNAA8FlEQfiy1HT5Jio1M9aRmn6aN9duqvU8IHA3jr4NXm1n
         /KJ18D9bivZblrBhG/ZGV+MDqxYv5RAxivLQ5i5x+bqW3HxKZIDJfRs8951IS5JpExGO
         Go2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UdG4MmSrSVXj2AOOOO/+ILrQ0BjQgwzE0+PHc9VPkME=;
        b=NtT/TbEPHEBnUnhw7yK0uO0xZs2t/ijm5mOM34c4MCO9JKXVCURSdbUCn+ZEvJ9wb7
         rKnxcA196ewai0o77rK8Mrt6dHXVQBHcc0jytJJrX1RtPyqds0Ha/zCox9kidBmeAluL
         RsRoYP+gEXZOY21ipD5zYj1BhJU4OYEJ5hi7y0/ZvDZGGjgMdW8ZiJNSW5DlxHYoO4kW
         ZDzKsLahS0iBGTKwYBohnzUphU5UQuYUnumXfCv+xMwwMhFWNPDbtFodbhVd5thuomly
         8lAW82PzDdp9nZ6uAt5lrlF/lAemWQpKy1IsEcpiSzXKORM2M8aSaIQ0+JhbbYY+bZQx
         zb3A==
X-Gm-Message-State: ACrzQf0RYMmT7DApnkkfg0JeLollRHYEbwkqi7KSkNDl8tjs2PF4B8zs
        0S24keCvT/TMGC6iYuzB5tU=
X-Google-Smtp-Source: AMsMyM5C2CyWryMpjNNfrYTC6IfTT7lJh0OEMRjws5RNSUGLB4iqjVLoj09lKd/yPbavqpN9Oy2e0A==
X-Received: by 2002:a17:902:b717:b0:184:4a5c:c74a with SMTP id d23-20020a170902b71700b001844a5cc74amr11287446pls.0.1665997990382;
        Mon, 17 Oct 2022 02:13:10 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e258-8c34-4ca3-4989-34c1-7890.emome-ip6.hinet.net. [2001:b400:e258:8c34:4ca3:4989:34c1:7890])
        by smtp.gmail.com with ESMTPSA id t22-20020a170902b21600b0017f75bc7a61sm6091996plr.166.2022.10.17.02.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 02:13:09 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
X-Google-Original-From: Victor Shih <victor.shih@genesyslogic.com.tw>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Subject: [PATCH V5 20/26] mmc: sdhci-uhs2: add irq() and others
Date:   Mon, 17 Oct 2022 17:11:47 +0800
Message-Id: <20221017091153.454873-21-victor.shih@genesyslogic.com.tw>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221017091153.454873-1-victor.shih@genesyslogic.com.tw>
References: <20221017091153.454873-1-victor.shih@genesyslogic.com.tw>
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

This is a UHS-II version of sdhci's request() operation.
It handles UHS-II related command interrupts and errors.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---
 drivers/mmc/host/sdhci-uhs2.c | 246 ++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-uhs2.h |   3 +
 drivers/mmc/host/sdhci.c      | 106 ++++++++-------
 drivers/mmc/host/sdhci.h      |   5 +
 4 files changed, 313 insertions(+), 47 deletions(-)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index b269593e9b08..452cd9165cdf 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/delay.h>
+#include <linux/dmaengine.h>
 #include <linux/ktime.h>
 #include <linux/module.h>
 #include <linux/mmc/mmc.h>
@@ -594,6 +595,12 @@ static inline void sdhci_external_dma_pre_transfer(struct sdhci_host *host,
 						   struct mmc_command *cmd)
 {
 }
+
+static inline struct dma_chan *sdhci_external_dma_channel(struct sdhci_host *host,
+							  struct mmc_data *data)
+{
+	return NULL;
+}
 #endif /* CONFIG_MMC_SDHCI_EXTERNAL_DMA */
 
 static void sdhci_uhs2_finish_data(struct sdhci_host *host)
@@ -952,6 +959,245 @@ static void sdhci_uhs2_finish_command(struct sdhci_host *host)
 		__sdhci_finish_mrq(host, cmd->mrq);
 }
 
+/*****************************************************************************\
+ *                                                                           *
+ * Request done                                                              *
+ *                                                                           *
+\*****************************************************************************/
+
+static bool sdhci_uhs2_request_done(struct sdhci_host *host)
+{
+	unsigned long flags;
+	struct mmc_request *mrq;
+	int i;
+
+	/* FIXME: UHS2_INITIALIZED, instead? */
+	if (!(host->mmc->flags & MMC_UHS2_SUPPORT))
+		return sdhci_request_done(host);
+
+	spin_lock_irqsave(&host->lock, flags);
+
+	for (i = 0; i < SDHCI_MAX_MRQS; i++) {
+		mrq = host->mrqs_done[i];
+		if (mrq)
+			break;
+	}
+
+	if (!mrq) {
+		spin_unlock_irqrestore(&host->lock, flags);
+		return true;
+	}
+
+	/*
+	 * Always unmap the data buffers if they were mapped by
+	 * sdhci_prepare_data() whenever we finish with a request.
+	 * This avoids leaking DMA mappings on error.
+	 */
+	if (host->flags & SDHCI_REQ_USE_DMA) {
+		struct mmc_data *data = mrq->data;
+
+		if (host->use_external_dma && data &&
+		    (mrq->cmd->error || data->error)) {
+			struct dma_chan *chan = sdhci_external_dma_channel(host, data);
+
+			host->mrqs_done[i] = NULL;
+			spin_unlock_irqrestore(&host->lock, flags);
+			dmaengine_terminate_sync(chan);
+			spin_lock_irqsave(&host->lock, flags);
+			sdhci_set_mrq_done(host, mrq);
+		}
+
+		sdhci_request_done_dma(host, mrq);
+	}
+
+	/*
+	 * The controller needs a reset of internal state machines
+	 * upon error conditions.
+	 */
+	if (sdhci_needs_reset(host, mrq)) {
+		/*
+		 * Do not finish until command and data lines are available for
+		 * reset. Note there can only be one other mrq, so it cannot
+		 * also be in mrqs_done, otherwise host->cmd and host->data_cmd
+		 * would both be null.
+		 */
+		if (host->cmd || host->data_cmd) {
+			spin_unlock_irqrestore(&host->lock, flags);
+			return true;
+		}
+
+		/* Some controllers need this kick or reset won't work here */
+		if (host->quirks & SDHCI_QUIRK_CLOCK_BEFORE_RESET)
+			/* This is to force an update */
+			host->ops->set_clock(host, host->clock);
+
+		host->ops->uhs2_reset(host, SDHCI_UHS2_SW_RESET_SD);
+		host->pending_reset = false;
+	}
+
+	host->mrqs_done[i] = NULL;
+
+	spin_unlock_irqrestore(&host->lock, flags);
+
+	if (host->ops->request_done)
+		host->ops->request_done(host, mrq);
+	else
+		mmc_request_done(host->mmc, mrq);
+
+	return false;
+}
+
+static void sdhci_uhs2_complete_work(struct work_struct *work)
+{
+	struct sdhci_host *host = container_of(work, struct sdhci_host,
+					       complete_work);
+
+	while (!sdhci_uhs2_request_done(host))
+		;
+}
+
+/*****************************************************************************\
+ *                                                                           *
+ * Interrupt handling                                                        *
+ *                                                                           *
+\*****************************************************************************/
+
+static void __sdhci_uhs2_irq(struct sdhci_host *host, u32 uhs2mask)
+{
+	struct mmc_command *cmd = host->cmd;
+
+	DBG("*** %s got UHS2 error interrupt: 0x%08x\n",
+	    mmc_hostname(host->mmc), uhs2mask);
+
+	if (uhs2mask & SDHCI_UHS2_ERR_INT_STATUS_CMD_MASK) {
+		if (!host->cmd) {
+			pr_err("%s: Got cmd interrupt 0x%08x but no cmd.\n",
+			       mmc_hostname(host->mmc),
+			       (unsigned int)uhs2mask);
+			sdhci_dumpregs(host);
+			return;
+		}
+		host->cmd->error = -EILSEQ;
+		if (uhs2mask & SDHCI_UHS2_ERR_INT_STATUS_RES_TIMEOUT)
+			host->cmd->error = -ETIMEDOUT;
+	}
+
+	if (uhs2mask & SDHCI_UHS2_ERR_INT_STATUS_DATA_MASK) {
+		if (!host->data) {
+			pr_err("%s: Got data interrupt 0x%08x but no data.\n",
+			       mmc_hostname(host->mmc),
+			       (unsigned int)uhs2mask);
+			sdhci_dumpregs(host);
+			return;
+		}
+
+		if (uhs2mask & SDHCI_UHS2_ERR_INT_STATUS_DEADLOCK_TIMEOUT) {
+			pr_err("%s: Got deadlock timeout interrupt 0x%08x\n",
+			       mmc_hostname(host->mmc),
+			       (unsigned int)uhs2mask);
+			host->data->error = -ETIMEDOUT;
+		} else if (uhs2mask & SDHCI_UHS2_ERR_INT_STATUS_ADMA) {
+			pr_err("%s: ADMA error = 0x %x\n",
+			       mmc_hostname(host->mmc),
+			       sdhci_readb(host, SDHCI_ADMA_ERROR));
+			host->data->error = -EIO;
+		} else {
+			host->data->error = -EILSEQ;
+		}
+	}
+
+	if (host->data && host->data->error)
+		sdhci_uhs2_finish_data(host);
+	else
+		sdhci_finish_mrq(host, cmd->mrq);
+}
+
+u32 sdhci_uhs2_irq(struct sdhci_host *host, u32 intmask)
+{
+	u32 mask = intmask, uhs2mask;
+
+	if (!(host->mmc->flags & MMC_UHS2_SUPPORT))
+		goto out;
+
+	/*
+	 * TODO: We should mask Normal Error Interrupt Status Register
+	 * in UHS-2 mode so that we don't have to care SD mode errors.
+	 */
+	if (intmask & SDHCI_INT_ERROR) {
+		uhs2mask = sdhci_readl(host, SDHCI_UHS2_ERR_INT_STATUS);
+		if (!(uhs2mask & SDHCI_UHS2_ERR_INT_STATUS_MASK))
+			goto cmd_irq;
+
+		/* Clear error interrupts */
+		sdhci_writel(host, uhs2mask & SDHCI_UHS2_ERR_INT_STATUS_MASK,
+			     SDHCI_UHS2_ERR_INT_STATUS);
+
+		/* Handle error interrupts */
+		__sdhci_uhs2_irq(host, uhs2mask);
+
+		/* Caller, shdci_irq(), doesn't have to care UHS-2 errors */
+		intmask &= ~SDHCI_INT_ERROR;
+		mask &= SDHCI_INT_ERROR;
+	}
+
+cmd_irq:
+	/*
+	 * TODO: Cleanup
+	 * INT_RESPONSE is enough instead of INT_CMD_MASK, assuming that
+	 * INT_ERROR and INT_CMD_MASK won't happen at the same time.
+	 */
+	if (intmask & SDHCI_INT_CMD_MASK) {
+		/* Clear command interrupt */
+		sdhci_writel(host, intmask & SDHCI_INT_CMD_MASK, SDHCI_INT_STATUS);
+
+		/* Handle command interrupt */
+		if (intmask & SDHCI_INT_RESPONSE)
+			sdhci_uhs2_finish_command(host);
+
+		/* Caller, shdci_irq(), doesn't have to care UHS-2 command */
+		intmask &= ~SDHCI_INT_CMD_MASK;
+		mask &= SDHCI_INT_CMD_MASK;
+	}
+
+	/* Clear already-handled interrupts. */
+	sdhci_writel(host, mask, SDHCI_INT_STATUS);
+
+out:
+	return intmask;
+}
+EXPORT_SYMBOL_GPL(sdhci_uhs2_irq);
+
+static irqreturn_t sdhci_uhs2_thread_irq(int irq, void *dev_id)
+{
+	struct sdhci_host *host = dev_id;
+	struct mmc_command *cmd;
+	unsigned long flags;
+	u32 isr;
+
+	while (!sdhci_uhs2_request_done(host))
+		;
+
+	spin_lock_irqsave(&host->lock, flags);
+
+	isr = host->thread_isr;
+	host->thread_isr = 0;
+
+	cmd = host->deferred_cmd;
+	if (cmd && !sdhci_uhs2_send_command_retry(host, cmd, flags))
+		sdhci_finish_mrq(host, cmd->mrq);
+
+	spin_unlock_irqrestore(&host->lock, flags);
+
+	if (isr & (SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE)) {
+		struct mmc_host *mmc = host->mmc;
+
+		mmc->ops->card_event(mmc);
+		mmc_detect_change(mmc, msecs_to_jiffies(200));
+	}
+
+	return IRQ_HANDLED;
+}
+
 void sdhci_uhs2_request(struct mmc_host *mmc, struct mmc_request *mrq)
 {
 	struct sdhci_host *host = mmc_priv(mmc);
diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs2.h
index 23368448ccd4..d32a8602d045 100644
--- a/drivers/mmc/host/sdhci-uhs2.h
+++ b/drivers/mmc/host/sdhci-uhs2.h
@@ -217,5 +217,8 @@ void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode,
 			  unsigned short vdd);
 void sdhci_uhs2_set_timeout(struct sdhci_host *host, struct mmc_command *cmd);
 void sdhci_uhs2_clear_set_irqs(struct sdhci_host *host, u32 clear, u32 set);
+void sdhci_uhs2_request(struct mmc_host *mmc, struct mmc_request *mrq);
+int sdhci_uhs2_request_atomic(struct mmc_host *mmc, struct mmc_request *mrq);
+u32 sdhci_uhs2_irq(struct sdhci_host *host, u32 intmask);
 
 #endif /* __SDHCI_UHS2_H */
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index a8458b1f3899..e1288c9b6a93 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1224,11 +1224,12 @@ static int sdhci_external_dma_init(struct sdhci_host *host)
 	return ret;
 }
 
-static struct dma_chan *sdhci_external_dma_channel(struct sdhci_host *host,
-						   struct mmc_data *data)
+struct dma_chan *sdhci_external_dma_channel(struct sdhci_host *host,
+					    struct mmc_data *data)
 {
 	return data->flags & MMC_DATA_WRITE ? host->tx_chan : host->rx_chan;
 }
+EXPORT_SYMBOL_GPL(sdhci_external_dma_channel);
 
 int sdhci_external_dma_setup(struct sdhci_host *host, struct mmc_command *cmd)
 {
@@ -1478,7 +1479,7 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
 	sdhci_writew(host, mode, SDHCI_TRANSFER_MODE);
 }
 
-static bool sdhci_needs_reset(struct sdhci_host *host, struct mmc_request *mrq)
+bool sdhci_needs_reset(struct sdhci_host *host, struct mmc_request *mrq)
 {
 	return (!(host->flags & SDHCI_DEVICE_DEAD) &&
 		((mrq->cmd && mrq->cmd->error) ||
@@ -1486,8 +1487,9 @@ static bool sdhci_needs_reset(struct sdhci_host *host, struct mmc_request *mrq)
 		 (mrq->data && mrq->data->stop && mrq->data->stop->error) ||
 		 (host->quirks & SDHCI_QUIRK_RESET_AFTER_REQUEST)));
 }
+EXPORT_SYMBOL_GPL(sdhci_needs_reset);
 
-static void sdhci_set_mrq_done(struct sdhci_host *host, struct mmc_request *mrq)
+void sdhci_set_mrq_done(struct sdhci_host *host, struct mmc_request *mrq)
 {
 	int i;
 
@@ -1507,6 +1509,7 @@ static void sdhci_set_mrq_done(struct sdhci_host *host, struct mmc_request *mrq)
 
 	WARN_ON(i >= SDHCI_MAX_MRQS);
 }
+EXPORT_SYMBOL_GPL(sdhci_set_mrq_done);
 
 void __sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq)
 {
@@ -3068,7 +3071,56 @@ static const struct mmc_host_ops sdhci_ops = {
  *                                                                           *
 \*****************************************************************************/
 
-static bool sdhci_request_done(struct sdhci_host *host)
+void sdhci_request_done_dma(struct sdhci_host *host, struct mmc_request *mrq)
+{
+	struct mmc_data *data = mrq->data;
+
+	if (data && data->host_cookie == COOKIE_MAPPED) {
+		if (host->bounce_buffer) {
+			/*
+			 * On reads, copy the bounced data into the
+			 * sglist
+			 */
+			if (mmc_get_dma_dir(data) == DMA_FROM_DEVICE) {
+				unsigned int length = data->bytes_xfered;
+
+				if (length > host->bounce_buffer_size) {
+					pr_err("%s: bounce buffer is %u bytes but DMA claims to have transferred %u bytes\n",
+					       mmc_hostname(host->mmc),
+					       host->bounce_buffer_size,
+					       data->bytes_xfered);
+					/* Cap it down and continue */
+					length = host->bounce_buffer_size;
+				}
+				dma_sync_single_for_cpu(
+					host->mmc->parent,
+					host->bounce_addr,
+					host->bounce_buffer_size,
+					DMA_FROM_DEVICE);
+				sg_copy_from_buffer(data->sg,
+					data->sg_len,
+					host->bounce_buffer,
+					length);
+			} else {
+				/* No copying, just switch ownership */
+				dma_sync_single_for_cpu(
+					host->mmc->parent,
+					host->bounce_addr,
+					host->bounce_buffer_size,
+					mmc_get_dma_dir(data));
+			}
+		} else {
+			/* Unmap the raw data */
+			dma_unmap_sg(mmc_dev(host->mmc), data->sg,
+				     data->sg_len,
+				     mmc_get_dma_dir(data));
+		}
+		data->host_cookie = COOKIE_UNMAPPED;
+	}
+}
+EXPORT_SYMBOL_GPL(sdhci_request_done_dma);
+
+bool sdhci_request_done(struct sdhci_host *host)
 {
 	unsigned long flags;
 	struct mmc_request *mrq;
@@ -3137,48 +3189,7 @@ static bool sdhci_request_done(struct sdhci_host *host)
 			sdhci_set_mrq_done(host, mrq);
 		}
 
-		if (data && data->host_cookie == COOKIE_MAPPED) {
-			if (host->bounce_buffer) {
-				/*
-				 * On reads, copy the bounced data into the
-				 * sglist
-				 */
-				if (mmc_get_dma_dir(data) == DMA_FROM_DEVICE) {
-					unsigned int length = data->bytes_xfered;
-
-					if (length > host->bounce_buffer_size) {
-						pr_err("%s: bounce buffer is %u bytes but DMA claims to have transferred %u bytes\n",
-						       mmc_hostname(host->mmc),
-						       host->bounce_buffer_size,
-						       data->bytes_xfered);
-						/* Cap it down and continue */
-						length = host->bounce_buffer_size;
-					}
-					dma_sync_single_for_cpu(
-						mmc_dev(host->mmc),
-						host->bounce_addr,
-						host->bounce_buffer_size,
-						DMA_FROM_DEVICE);
-					sg_copy_from_buffer(data->sg,
-						data->sg_len,
-						host->bounce_buffer,
-						length);
-				} else {
-					/* No copying, just switch ownership */
-					dma_sync_single_for_cpu(
-						mmc_dev(host->mmc),
-						host->bounce_addr,
-						host->bounce_buffer_size,
-						mmc_get_dma_dir(data));
-				}
-			} else {
-				/* Unmap the raw data */
-				dma_unmap_sg(mmc_dev(host->mmc), data->sg,
-					     data->sg_len,
-					     mmc_get_dma_dir(data));
-			}
-			data->host_cookie = COOKIE_UNMAPPED;
-		}
+		sdhci_request_done_dma(host, mrq);
 	}
 
 	host->mrqs_done[i] = NULL;
@@ -3192,6 +3203,7 @@ static bool sdhci_request_done(struct sdhci_host *host)
 
 	return false;
 }
+EXPORT_SYMBOL_GPL(sdhci_request_done);
 
 static void sdhci_complete_work(struct work_struct *work)
 {
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 99f88b0ff4f4..4a7d31a54e2e 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -863,8 +863,11 @@ int sdhci_external_dma_setup(struct sdhci_host *host, struct mmc_command *cmd);
 void sdhci_external_dma_release(struct sdhci_host *host);
 void __sdhci_external_dma_prepare_data(struct sdhci_host *host, struct mmc_command *cmd);
 void sdhci_external_dma_pre_transfer(struct sdhci_host *host, struct mmc_command *cmd);
+struct dma_chan *sdhci_external_dma_channel(struct sdhci_host *host, struct mmc_data *data);
 #endif
 bool sdhci_manual_cmd23(struct sdhci_host *host, struct mmc_request *mrq);
+bool sdhci_needs_reset(struct sdhci_host *host, struct mmc_request *mrq);
+void sdhci_set_mrq_done(struct sdhci_host *host, struct mmc_request *mrq);
 void __sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq);
 void sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq);
 void __sdhci_finish_data_common(struct sdhci_host *host);
@@ -896,6 +899,8 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios);
 int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
 				      struct mmc_ios *ios);
 void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable);
+void sdhci_request_done_dma(struct sdhci_host *host, struct mmc_request *mrq);
+bool sdhci_request_done(struct sdhci_host *host);
 void sdhci_adma_write_desc(struct sdhci_host *host, void **desc,
 			   dma_addr_t addr, int len, unsigned int cmd);
 
-- 
2.25.1

