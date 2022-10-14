Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D535FED69
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 13:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiJNLrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 07:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiJNLrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 07:47:37 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C45B152C4B;
        Fri, 14 Oct 2022 04:47:29 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id f140so4691579pfa.1;
        Fri, 14 Oct 2022 04:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pwormjdya27DKJDK07ojuOIx3P+8Fj8s0/MwkorqyOU=;
        b=U7ceWj3MNQ58A4Y2458TsTJj2aNlHqlGuiQj7oAhBQljZrOjsWaHSqDKLJumrGBdt9
         N2A45mcH2Q6uYAXKE3fXy0oasoPpf+GKT+w3X/NvHsI6gwZywVaxn4A390ZHJDCIDmIF
         ZJceZOc4/IuwJ/7ImH4KzhDiWS1MCLfasxgty7b0jc5Z2/ExOEDOqc2L2yZJCy6Se+98
         SEn03XdUMP3zQZ1MYUeukWnP6btCvkuUWbSvBSrZ9Fn039VnMjpTHCAnzI6+aQHLSyDV
         dTijgMY7cVn1qMbzDmr8WRcGZI8XRf9ukRWRcLtzCEyLgD99h1NtWq1UQUNGnJwFYa7O
         0J1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pwormjdya27DKJDK07ojuOIx3P+8Fj8s0/MwkorqyOU=;
        b=izL5nKkG9UlJM3vooHJ6V3B2FOfhiLg6lOt6ef5PYqdVbjus0qywNwZ3alYnJVRDPu
         mkWXwDJkpWTQTyXypf45lU8PcC2/y8FsbLoI4j+gj8N5bhNktHxBKIP/fTFqazNa+n8v
         eA+dHwhFbq9bss3NANl5+uvlKseqh6DVndOcY5/5Zk8oqtDTA1133tRj0Q796r2yall5
         KN3mUh7IaqCB4mGhPVLp6o/8H4NKqu8zFdeve0WBiwaZUZku7b6MS6R20Kx8Bm8txhQ0
         6gG+VoGePaMC26NjSvF/ktlimQgBxFLcihlknj33JIi8mcONRHaip8ANof3K7jntnZJn
         qCXw==
X-Gm-Message-State: ACrzQf2wQ+8qkp7V+2O3c3iMgazcFTfVwjZz26B9UHV1hs0fPoILeJ2t
        b/fyycW0sT4JJmUUi+k3aYc=
X-Google-Smtp-Source: AMsMyM4SyqKSnMVVfBD8xrXGC6klABx8qi22UgexmNCLY4Te9H0qktCpMBoa26JBg/2jjShh/CCToQ==
X-Received: by 2002:a05:6a00:1ac8:b0:563:7d18:7a15 with SMTP id f8-20020a056a001ac800b005637d187a15mr4835812pfv.59.1665748047830;
        Fri, 14 Oct 2022 04:47:27 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e282-2aaa-c1aa-06c8-0e68-c5ee.emome-ip6.hinet.net. [2001:b400:e282:2aaa:c1aa:6c8:e68:c5ee])
        by smtp.gmail.com with ESMTPSA id x8-20020a170902ec8800b001746f66244asm1606678plg.18.2022.10.14.04.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 04:47:27 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
X-Google-Original-From: Victor Shih <victor.shih@genesyslogic.com.tw>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>,
        Jason Lai <jason.lai@genesyslogic.com.tw>
Subject: [PATCH V5 06/26] mmc: core: Support UHS-II card control and access
Date:   Fri, 14 Oct 2022 19:45:41 +0800
Message-Id: <20221014114601.15594-7-victor.shih@genesyslogic.com.tw>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221014114601.15594-1-victor.shih@genesyslogic.com.tw>
References: <20221014114601.15594-1-victor.shih@genesyslogic.com.tw>
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

Updates in V5:
 - Added uhs2_tmode0_flag in mmc_blk_rw_rq_prep: block.c
 - Added mechanism for confirming the completion of Card initialization
   in mmc_start_request: core.c
 - Added mechanism for confirming the completion of Card initialization
   in mmc_cqe_start_req: core.c
 - Added uhs2_tmode0_flag in mmc_send_adtc_data: mmc_ops.c
 - Added mechanism for confirming the completion of Card initialization
   in mmc_app_cmd: sd_ops.c
 - Added uhs2_tmode0_flag in mmc_app_send_scr: sd_ops.c
 - Added uhs2_tmode0_flag in mmc_app_sd_status: sd_ops.c
 - Added UHS2_PHY_INIT of uhs2_control for detect UHS2
   in sd_uhs2_go_dormant: sd_uhs2.c
 - Modified the ocr/rocr flow in sd_uhs2_legacy_init: sd_uhs2.c
 - Added mmc_decode_cid in sd_uhs2_legacy_init: sd_uhs2.c
 - Added remove MMC_UHS2_INITIALIZED of host->flags in sd_uhs2_remove: sd_uhs2.c
 - Added MMC_UHS2_INITIALIZED of host->flags and MMC_UHS2_INITIALIZED of
   host->card->uhs2_state in sd_uhs2_init_card: sd_uhs2.c
 - Added MMC_UHS2_SUPPORT of host->flags in sd_uhs2_attach: sd_uhs2.c

Update in V4:
  1. Rename sd_uhs2_prepare_cmd() into mmc_uhs2_prepare_cmd().
  2. Rename ->uhs2_host_operation() into ->uhs2_control().
  3. Declare ->uhs2_set_ios() which should be implemented in
     mmc/host/sdhci-uhs2.c.
  4. Implement call back functions in sd_uhs2_ops.
  5. Replace variables which are used as constant with constant
     definition.
  6. Change data type of uhs2_cmd->payload from u32 to __be32 because of
     the use of cpu_to_be32().
  7. Add comments to explain format of UHS-II CMD Header and Argument.
  8. Add comments to explain format of UHS-II CMD response.
  9. Remove unnecessary debug info.
  10. Use sd_uhs2_select_voltage() to replace mmc_select_voltage().
  11. Use __mmc_poll_for_busy() to replace while loop.
  12. Add processing of uhs2_cmd when starting request.
  13. Use macro 'mmc_card_can_poweroff_notify' to replace function
      "sd_can_poweroff_notify()" and put it to include/linux/mmc/card.h.
  14. Embed UHS-II access functionality into the MMC request processing
      flow.

Update in V3:
UHS-II card initialization flow is divided into 2 categories: PHY & Card.
Part 1 - PHY Initialization:
  Every host controller may need their own avtivation operation to
  establish LINK between controller and card. So we add a new member
  function(uhs2_detect_init) in struct mmc_host_ops for host controller
  use.
Part 2 - Card Initialization:
  This part can be divided into 6 substeps.
  1. Send UHS-II CCMD DEVICE_INIT to card.
  2. Send UHS-II CCMD ENUMERATE to card.
  3. Send UHS-II Native Read CCMD to obtain capabilities in CFG_REG of
     card.
  4. Host compares capabilities of host controller and card, then write
     the negotiated values to Setting field in CFG_REG of card through
     UHS-II Native Write CCMD.
  5. Switch host controller's clock to Range B if it is supported by both
     host controller and card.
  6. Execute legacy SD initialization flow.
Part 3 - Provide a function to tranaform legacy SD command packet into
 UHS-II SD-TRAN DCMD packet.

Most of the code added above came from Intel's original patch[5].

[5]
https://patchwork.kernel.org/project/linux-mmc/patch/1419672479-30852-2-
git-send-email-yi.y.sun@intel.com/

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Jason Lai <jason.lai@genesyslogic.com.tw>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---
 drivers/mmc/core/block.c   |    6 +-
 drivers/mmc/core/core.c    |   32 +
 drivers/mmc/core/mmc_ops.c |   25 +-
 drivers/mmc/core/mmc_ops.h |    1 +
 drivers/mmc/core/sd.c      |   11 +-
 drivers/mmc/core/sd.h      |    3 +
 drivers/mmc/core/sd_ops.c  |   18 +
 drivers/mmc/core/sd_ops.h  |    3 +
 drivers/mmc/core/sd_uhs2.c | 1165 +++++++++++++++++++++++++++++++++++-
 9 files changed, 1217 insertions(+), 47 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index ce89611a136e..ed38cf33f256 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1598,6 +1598,9 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
 	struct request *req = mmc_queue_req_to_req(mqrq);
 	struct mmc_blk_data *md = mq->blkdata;
 	bool do_rel_wr, do_data_tag;
+	bool do_multi;
+
+	do_multi = (card->uhs2_state & MMC_UHS2_INITIALIZED) ? true : false;
 
 	mmc_blk_data_prep(mq, mqrq, recovery_mode, &do_rel_wr, &do_data_tag);
 
@@ -1608,7 +1611,7 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
 		brq->cmd.arg <<= 9;
 	brq->cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
 
-	if (brq->data.blocks > 1 || do_rel_wr) {
+	if (brq->data.blocks > 1 || do_rel_wr || do_multi) {
 		/* SPI multiblock writes terminate using a special
 		 * token, not a STOP_TRANSMISSION request.
 		 */
@@ -1621,6 +1624,7 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
 		brq->mrq.stop = NULL;
 		readcmd = MMC_READ_SINGLE_BLOCK;
 		writecmd = MMC_WRITE_BLOCK;
+		brq->cmd.uhs2_tmode0_flag = 1;
 	}
 	brq->cmd.opcode = rq_data_dir(req) == READ ? readcmd : writecmd;
 
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index ab2a48e1e876..d3f8f6c78bb1 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -335,6 +335,8 @@ static int mmc_mrq_prep(struct mmc_host *host, struct mmc_request *mrq)
 
 int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
 {
+	struct uhs2_command uhs2_cmd;
+	__be32 payload[4]; /* for maximum size */
 	int err;
 
 	init_completion(&mrq->cmd_completion);
@@ -352,6 +354,20 @@ int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
 	if (err)
 		return err;
 
+	if (host->card) {
+		if (host->card->uhs2_state & MMC_UHS2_INITIALIZED) {
+			uhs2_cmd.payload = payload;
+			mrq->cmd->uhs2_cmd = &uhs2_cmd;
+			mmc_uhs2_prepare_cmd(host, mrq);
+		}
+	} else {
+		if (host->flags & MMC_UHS2_INITIALIZED) {
+			uhs2_cmd.payload = payload;
+			mrq->cmd->uhs2_cmd = &uhs2_cmd;
+			mmc_uhs2_prepare_cmd(host, mrq);
+		}
+	}
+
 	led_trigger_event(host->led, LED_FULL);
 	__mmc_start_request(host, mrq);
 
@@ -431,6 +447,8 @@ EXPORT_SYMBOL(mmc_wait_for_req_done);
  */
 int mmc_cqe_start_req(struct mmc_host *host, struct mmc_request *mrq)
 {
+	struct uhs2_command uhs2_cmd;
+	__be32 payload[4]; /* for maximum size */
 	int err;
 
 	/*
@@ -451,6 +469,20 @@ int mmc_cqe_start_req(struct mmc_host *host, struct mmc_request *mrq)
 	if (err)
 		goto out_err;
 
+	if (host->card) {
+		if (host->card->uhs2_state & MMC_UHS2_INITIALIZED) {
+			uhs2_cmd.payload = payload;
+			mrq->cmd->uhs2_cmd = &uhs2_cmd;
+			mmc_uhs2_prepare_cmd(host, mrq);
+		}
+	} else {
+		if (host->flags & MMC_UHS2_INITIALIZED) {
+			uhs2_cmd.payload = payload;
+			mrq->cmd->uhs2_cmd = &uhs2_cmd;
+			mmc_uhs2_prepare_cmd(host, mrq);
+		}
+	}
+
 	err = host->cqe_ops->cqe_request(host, mrq);
 	if (err)
 		goto out_err;
diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 81c55bfd6e0c..daa1f4ccd99a 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -144,10 +144,24 @@ int mmc_set_dsr(struct mmc_host *host)
 	return mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
 }
 
+int __mmc_go_idle(struct mmc_host *host)
+{
+	struct mmc_command cmd = {};
+	int err;
+
+	cmd.opcode = MMC_GO_IDLE_STATE;
+	cmd.arg = 0;
+	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_NONE | MMC_CMD_BC;
+
+	err = mmc_wait_for_cmd(host, &cmd, 0);
+	mmc_delay(1);
+
+	return err;
+}
+
 int mmc_go_idle(struct mmc_host *host)
 {
 	int err;
-	struct mmc_command cmd = {};
 
 	/*
 	 * Non-SPI hosts need to prevent chipselect going active during
@@ -163,13 +177,7 @@ int mmc_go_idle(struct mmc_host *host)
 		mmc_delay(1);
 	}
 
-	cmd.opcode = MMC_GO_IDLE_STATE;
-	cmd.arg = 0;
-	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_NONE | MMC_CMD_BC;
-
-	err = mmc_wait_for_cmd(host, &cmd, 0);
-
-	mmc_delay(1);
+	err = __mmc_go_idle(host);
 
 	if (!mmc_host_is_spi(host)) {
 		mmc_set_chip_select(host, MMC_CS_DONTCARE);
@@ -300,6 +308,7 @@ int mmc_send_adtc_data(struct mmc_card *card, struct mmc_host *host, u32 opcode,
 	 * not R1 plus a data block.
 	 */
 	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
+	cmd.uhs2_tmode0_flag = 1;
 
 	data.blksz = len;
 	data.blocks = 1;
diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
index 09ffbc00908b..abda7492d578 100644
--- a/drivers/mmc/core/mmc_ops.h
+++ b/drivers/mmc/core/mmc_ops.h
@@ -25,6 +25,7 @@ struct mmc_command;
 int mmc_select_card(struct mmc_card *card);
 int mmc_deselect_cards(struct mmc_host *host);
 int mmc_set_dsr(struct mmc_host *host);
+int __mmc_go_idle(struct mmc_host *host);
 int mmc_go_idle(struct mmc_host *host);
 int mmc_send_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr);
 int mmc_set_relative_addr(struct mmc_card *card);
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 3662bf5320ce..cab4725209c1 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -207,7 +207,7 @@ static int mmc_decode_csd(struct mmc_card *card)
 /*
  * Given a 64-bit response, decode to our card SCR structure.
  */
-static int mmc_decode_scr(struct mmc_card *card)
+int mmc_decode_scr(struct mmc_card *card)
 {
 	struct sd_scr *scr = &card->scr;
 	unsigned int scr_struct;
@@ -1611,11 +1611,6 @@ static void mmc_sd_detect(struct mmc_host *host)
 	}
 }
 
-static int sd_can_poweroff_notify(struct mmc_card *card)
-{
-	return card->ext_power.feature_support & SD_EXT_POWER_OFF_NOTIFY;
-}
-
 static int sd_busy_poweroff_notify_cb(void *cb_data, bool *busy)
 {
 	struct sd_busy_data *data = cb_data;
@@ -1639,7 +1634,7 @@ static int sd_busy_poweroff_notify_cb(void *cb_data, bool *busy)
 	return 0;
 }
 
-static int sd_poweroff_notify(struct mmc_card *card)
+int sd_poweroff_notify(struct mmc_card *card)
 {
 	struct sd_busy_data cb_data;
 	u8 *reg_buf;
@@ -1687,7 +1682,7 @@ static int _mmc_sd_suspend(struct mmc_host *host)
 	if (mmc_card_suspended(card))
 		goto out;
 
-	if (sd_can_poweroff_notify(card))
+	if (mmc_card_can_poweroff_notify(card))
 		err = sd_poweroff_notify(card);
 	else if (!mmc_host_is_spi(host))
 		err = mmc_deselect_cards(host);
diff --git a/drivers/mmc/core/sd.h b/drivers/mmc/core/sd.h
index 1af5a038bae9..b573a809a0f4 100644
--- a/drivers/mmc/core/sd.h
+++ b/drivers/mmc/core/sd.h
@@ -17,4 +17,7 @@ int mmc_sd_setup_card(struct mmc_host *host, struct mmc_card *card,
 unsigned mmc_sd_get_max_clock(struct mmc_card *card);
 int mmc_sd_switch_hs(struct mmc_card *card);
 
+/* These call back functions were also used by UHS2 sd card */
+int sd_poweroff_notify(struct mmc_card *card);
+
 #endif
diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
index ef8d1dce5af1..85af5a2ea8ff 100644
--- a/drivers/mmc/core/sd_ops.c
+++ b/drivers/mmc/core/sd_ops.c
@@ -27,6 +27,22 @@ int mmc_app_cmd(struct mmc_host *host, struct mmc_card *card)
 	if (WARN_ON(card && card->host != host))
 		return -EINVAL;
 
+	/*
+	 * UHS2 packet has APP bit so only set APP_CMD flag here.
+	 * Will set the APP bit when assembling UHS2 packet.
+	 */
+	if (card) {
+		if (card->uhs2_state & MMC_UHS2_INITIALIZED) {
+			host->uhs2_ios.is_APP_CMD = true;
+			return 0;
+		}
+	} else {
+		if (host->flags & MMC_UHS2_INITIALIZED) {
+			host->uhs2_ios.is_APP_CMD = true;
+			return 0;
+		}
+	}
+
 	cmd.opcode = MMC_APP_CMD;
 
 	if (card) {
@@ -281,6 +297,7 @@ int mmc_app_send_scr(struct mmc_card *card)
 	cmd.opcode = SD_APP_SEND_SCR;
 	cmd.arg = 0;
 	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
+	cmd.uhs2_tmode0_flag = 1;
 
 	data.blksz = 8;
 	data.blocks = 1;
@@ -344,6 +361,7 @@ int mmc_app_sd_status(struct mmc_card *card, void *ssr)
 	cmd.opcode = SD_APP_SD_STATUS;
 	cmd.arg = 0;
 	cmd.flags = MMC_RSP_SPI_R2 | MMC_RSP_R1 | MMC_CMD_ADTC;
+	cmd.uhs2_tmode0_flag = 1;
 
 	data.blksz = 64;
 	data.blocks = 1;
diff --git a/drivers/mmc/core/sd_ops.h b/drivers/mmc/core/sd_ops.h
index 3ba7b3cf4652..29c802dec988 100644
--- a/drivers/mmc/core/sd_ops.h
+++ b/drivers/mmc/core/sd_ops.h
@@ -11,6 +11,7 @@
 #include <linux/types.h>
 
 struct mmc_card;
+struct mmc_command;
 struct mmc_host;
 
 int mmc_app_set_bus_width(struct mmc_card *card, int width);
@@ -19,10 +20,12 @@ int mmc_send_if_cond(struct mmc_host *host, u32 ocr);
 int mmc_send_if_cond_pcie(struct mmc_host *host, u32 ocr);
 int mmc_send_relative_addr(struct mmc_host *host, unsigned int *rca);
 int mmc_app_send_scr(struct mmc_card *card);
+int mmc_decode_scr(struct mmc_card *card);
 int mmc_sd_switch(struct mmc_card *card, int mode, int group,
 	u8 value, u8 *resp);
 int mmc_app_sd_status(struct mmc_card *card, void *ssr);
 int mmc_app_cmd(struct mmc_host *host, struct mmc_card *card);
+void mmc_uhs2_prepare_cmd(struct mmc_host *host, struct mmc_request *mrq);
 
 #endif
 
diff --git a/drivers/mmc/core/sd_uhs2.c b/drivers/mmc/core/sd_uhs2.c
index 800957f74632..bccdd4283a67 100644
--- a/drivers/mmc/core/sd_uhs2.c
+++ b/drivers/mmc/core/sd_uhs2.c
@@ -1,48 +1,125 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (C) 2021 Linaro Ltd
- *
  * Author: Ulf Hansson <ulf.hansson@linaro.org>
  *
+ * Copyright (C) 2014 Intel Corp, All Rights Reserved.
+ * Author: Yi Sun <yi.y.sun@intel.com>
+ *
+ * Copyright (C) 2020 Genesys Logic, Inc.
+ * Authors: Ben Chuang <ben.chuang@genesyslogic.com.tw>
+ *
+ * Copyright (C) 2020 Linaro Limited
+ * Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
+ *
+ * Copyright (C) 2022 Genesys Logic, Inc.
+ * Authors: Jason Lai <jason.lai@genesyslogic.com.tw>
+ *
  * Support for SD UHS-II cards
  */
 #include <linux/err.h>
+#include <linux/pm_runtime.h>
 
 #include <linux/mmc/host.h>
 #include <linux/mmc/card.h>
+#include <linux/mmc/mmc.h>
+#include <linux/mmc/sd.h>
+#include <linux/mmc/sd_uhs2.h>
 
+#include "card.h"
 #include "core.h"
 #include "bus.h"
 #include "sd.h"
+#include "sd_ops.h"
 #include "mmc_ops.h"
 
+#define UHS2_WAIT_CFG_COMPLETE_PERIOD_US	(1 * 1000)	/* 1ms */
+#define UHS2_WAIT_CFG_COMPLETE_TIMEOUT_MS	100		/* 100ms */
+
 static const unsigned int sd_uhs2_freqs[] = { 52000000, 26000000 };
+int sd_uhs2_reinit(struct mmc_host *host);
 
-static int sd_uhs2_set_ios(struct mmc_host *host)
+/*
+ * Internal function that does the actual ios call to the host driver,
+ * optionally printing some debug output.
+ */
+static inline int sd_uhs2_set_ios(struct mmc_host *host)
 {
 	struct mmc_ios *ios = &host->ios;
 
+	pr_debug("%s: clock %uHz powermode %u Vdd %u timing %u\n",
+		 mmc_hostname(host), ios->clock, ios->power_mode, ios->vdd, ios->timing);
+
 	return host->ops->uhs2_set_ios(host, ios);
 }
 
 static int sd_uhs2_power_up(struct mmc_host *host)
 {
+	int err;
+
+	if (host->ios.power_mode == MMC_POWER_ON)
+		return 0;
+
 	host->ios.vdd = fls(host->ocr_avail) - 1;
 	host->ios.clock = host->f_init;
 	host->ios.timing = MMC_TIMING_SD_UHS2;
-	host->ios.power_mode = MMC_POWER_UP;
+	host->ios.power_mode = MMC_POWER_ON;
 
-	return sd_uhs2_set_ios(host);
+	err = sd_uhs2_set_ios(host);
+
+	mmc_delay(host->uhs2_ios.power_delay_ms);
+
+	return err;
 }
 
-static void sd_uhs2_power_off(struct mmc_host *host)
+static int sd_uhs2_power_off(struct mmc_host *host)
 {
+	if (host->ios.power_mode == MMC_POWER_OFF)
+		return 0;
+
 	host->ios.vdd = 0;
 	host->ios.clock = 0;
 	host->ios.timing = MMC_TIMING_LEGACY;
 	host->ios.power_mode = MMC_POWER_OFF;
 
-	sd_uhs2_set_ios(host);
+	return sd_uhs2_set_ios(host);
+}
+
+/**
+ * sd_uhs2_cmd_assemble() - build up UHS-II command packet which is embedded in
+ *                          mmc_command structure
+ * @cmd:	MMC command to executed
+ * @uhs2_cmd:	UHS2 command corresponded to MMC command
+ * @header:	Header field of UHS-II command cxpacket
+ * @arg:	Argument field of UHS-II command packet
+ * @payload:	Payload field of UHS-II command packet
+ * @plen:	Payload length
+ * @resp:	Response buffer is allocated by caller and it is used to keep
+ *              the response of CM-TRAN command. For SD-TRAN command, uhs2_resp
+ *              should be null and SD-TRAN command response should be stored in
+ *              resp of mmc_command.
+ * @resp_len:	Response buffer length
+ *
+ * The uhs2_command structure contains message packets which are transmited/
+ * received on UHS-II bus. This function fills in the contents of uhs2_command
+ * structure and embededs UHS2 command into mmc_command structure, which is used
+ * in legacy SD operation functions.
+ *
+ */
+static void sd_uhs2_cmd_assemble(struct mmc_command *cmd,
+				 struct uhs2_command *uhs2_cmd,
+				 u16 header, u16 arg, __be32 *payload,
+				 u8 plen, u8 *resp, u8 resp_len)
+{
+	uhs2_cmd->header = header;
+	uhs2_cmd->arg = arg;
+	uhs2_cmd->payload = payload;
+	uhs2_cmd->payload_len = plen * sizeof(u32);
+	uhs2_cmd->packet_len = uhs2_cmd->payload_len + 4;
+
+	cmd->uhs2_cmd = uhs2_cmd;
+	cmd->uhs2_resp = resp;
+	cmd->uhs2_resp_len = resp_len;
 }
 
 /*
@@ -52,7 +129,15 @@ static void sd_uhs2_power_off(struct mmc_host *host)
  */
 static int sd_uhs2_phy_init(struct mmc_host *host)
 {
-	return 0;
+	int err = 0;
+
+	err = host->ops->uhs2_control(host, UHS2_PHY_INIT);
+	if (err) {
+		pr_err("%s: failed to initial phy for UHS-II!\n",
+		       mmc_hostname(host));
+	}
+
+	return err;
 }
 
 /*
@@ -61,6 +146,88 @@ static int sd_uhs2_phy_init(struct mmc_host *host)
  */
 static int sd_uhs2_dev_init(struct mmc_host *host)
 {
+	struct mmc_command cmd = {0};
+	struct uhs2_command uhs2_cmd = {};
+	u32 cnt;
+	u32 dap, gap, resp_gap;
+	u16 header, arg;
+	__be32 payload[UHS2_DEV_INIT_PAYLOAD_LEN];
+	u8 gd = 0;
+	u8 resp[UHS2_DEV_ENUM_RESP_LEN] = {0};
+	int err;
+
+	dap = host->uhs2_caps.dap;
+	gap = host->uhs2_caps.gap;
+
+	/*
+	 * Refer to UHS-II Addendum Version 1.02 Figure 6-21 to see DEVICE_INIT CCMD format.
+	 * Head:
+	 *      - Control Write(R/W=1) with 4-Byte payload(PLEN=01b).
+	 *      - IOADR = CMD_BASE + 002h
+	 * Payload:
+	 *      - bit [3:0]  : GAP(Group Allocated Power)
+	 *      - bit [7:4]  : GD(Group Descriptor)
+	 *      - bit [11]   : Complete Flag
+	 *      - bit [15:12]: DAP(Device Allocated Power)
+	 */
+	header = UHS2_NATIVE_PACKET | UHS2_PACKET_TYPE_CCMD;
+	arg = ((UHS2_DEV_CMD_DEVICE_INIT & 0xFF) << 8) |
+	       UHS2_NATIVE_CMD_WRITE |
+	       UHS2_NATIVE_CMD_PLEN_4B |
+	       (UHS2_DEV_CMD_DEVICE_INIT >> 8);
+
+	/*
+	 * Refer to UHS-II Addendum Version 1.02 section 6.3.1.
+	 * Max. time from DEVICE_INIT CCMD EOP reception on Device
+	 * Rx to its SOP transmission on Device Tx(Tfwd_init_cmd) is
+	 * 1 second.
+	 */
+	cmd.busy_timeout = 1000;
+
+	/*
+	 * Refer to UHS-II Addendum Version 1.02 section 6.2.6.3.
+	 * When the number of the DEVICE_INIT commands is reach to
+	 * 30 tiems, Host shall stop issuing DEVICE_INIT command
+	 * and regard it as an error.
+	 */
+	for (cnt = 0; cnt < 30; cnt++) {
+		payload[0] = ((dap & 0xF) << 12) |
+			      UHS2_DEV_INIT_COMPLETE_FLAG |
+			      ((gd & 0xF) << 4) |
+			      (gap & 0xF);
+
+		sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg,
+				     payload, UHS2_DEV_INIT_PAYLOAD_LEN,
+				     resp, UHS2_DEV_INIT_RESP_LEN);
+
+		err = mmc_wait_for_cmd(host, &cmd, 0);
+
+		if (err) {
+			pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
+			       mmc_hostname(host), __func__, err);
+			return err;
+		}
+
+		if (resp[3] != (UHS2_DEV_CMD_DEVICE_INIT & 0xFF)) {
+			pr_err("%s: DEVICE_INIT response is wrong!\n",
+			       mmc_hostname(host));
+			return -EIO;
+		}
+
+		if (resp[5] & 0x8) {
+			host->uhs2_caps.group_desc = gd;
+			return 0;
+		}
+		resp_gap = resp[4] & 0x0F;
+		if (gap == resp_gap)
+			gd++;
+	}
+	if (cnt == 30) {
+		pr_err("%s: DEVICE_INIT fail, already 30 times!\n",
+		       mmc_hostname(host));
+		return -EIO;
+	}
+
 	return 0;
 }
 
@@ -71,6 +238,52 @@ static int sd_uhs2_dev_init(struct mmc_host *host)
  */
 static int sd_uhs2_enum(struct mmc_host *host, u32 *node_id)
 {
+	struct mmc_command cmd = {0};
+	struct uhs2_command uhs2_cmd = {};
+	u16 header, arg;
+	__be32 payload[UHS2_DEV_ENUM_PAYLOAD_LEN];
+	u8 id_f = 0xF, id_l = 0x0;
+	u8 resp[UHS2_DEV_ENUM_RESP_LEN] = {0};
+	int err;
+
+	/*
+	 * Refer to UHS-II Addendum Version 1.02 Figure 6-28 to see ENUMERATE CCMD format.
+	 * Header:
+	 *      - Control Write(R/W=1) with 4-Byte payload(PLEN=01b).
+	 *      - IOADR = CMD_BASE + 003h
+	 * Payload:
+	 *      - bit [3:0]: ID_L(Last Node ID)
+	 *      - bit [7:4]: ID_F(First Node ID)
+	 */
+	header = UHS2_NATIVE_PACKET | UHS2_PACKET_TYPE_CCMD;
+	arg = ((UHS2_DEV_CMD_ENUMERATE & 0xFF) << 8) |
+	       UHS2_NATIVE_CMD_WRITE |
+	       UHS2_NATIVE_CMD_PLEN_4B |
+	       (UHS2_DEV_CMD_ENUMERATE >> 8);
+
+	payload[0] = (id_f << 4) | id_l;
+	payload[0] = cpu_to_be32(payload[0]);
+
+	sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg, payload, UHS2_DEV_ENUM_PAYLOAD_LEN,
+			     resp, UHS2_DEV_ENUM_RESP_LEN);
+
+	err = mmc_wait_for_cmd(host, &cmd, 0);
+	if (err) {
+		pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
+		       mmc_hostname(host), __func__, err);
+		return err;
+	}
+
+	if (resp[3] != (UHS2_DEV_CMD_ENUMERATE & 0xFF)) {
+		pr_err("%s: ENUMERATE response is wrong!\n",
+		       mmc_hostname(host));
+		return -EIO;
+	}
+
+	id_f = (resp[4] >> 4) & 0xF;
+	id_l = resp[4] & 0xF;
+	*node_id = id_f;
+
 	return 0;
 }
 
@@ -81,6 +294,181 @@ static int sd_uhs2_enum(struct mmc_host *host, u32 *node_id)
  */
 static int sd_uhs2_config_read(struct mmc_host *host, struct mmc_card *card)
 {
+	struct mmc_command cmd = {0};
+	struct uhs2_command uhs2_cmd = {};
+	u16 header, arg;
+	u32 cap;
+	int err;
+
+	/*
+	 * Use Control Read CCMD to read Generic Capability from Configuration Register.
+	 * - Control Write(R/W=1) with 4-Byte payload(PLEN=01b).
+	 * - IOADR = Generic Capability Register(CFG_BASE + 000h)
+	 */
+	header = UHS2_NATIVE_PACKET | UHS2_PACKET_TYPE_CCMD | card->uhs2_config.node_id;
+	arg = ((UHS2_DEV_CONFIG_GEN_CAPS & 0xFF) << 8) |
+	       UHS2_NATIVE_CMD_READ |
+	       UHS2_NATIVE_CMD_PLEN_4B |
+	       (UHS2_DEV_CONFIG_GEN_CAPS >> 8);
+
+	/*
+	 * There is no payload because per spec, there should be
+	 * no payload field for read CCMD.
+	 * Plen is set in arg. Per spec, plen for read CCMD
+	 * represents the len of read data which is assigned in payload
+	 * of following RES (p136).
+	 */
+	sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg, NULL, 0, NULL, 0);
+
+	err = mmc_wait_for_cmd(host, &cmd, 0);
+	if (err) {
+		pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
+		       mmc_hostname(host), __func__, err);
+		return err;
+	}
+
+	/*
+	 * Generic Capability Register:
+	 * bit [7:0]  : Reserved
+	 * bit [13:8] : Device-Specific Number of Lanes and Functionality
+	 *              bit 8: 2L-HD
+	 *              bit 9: 2D-1U FD
+	 *              bit 10: 1D-2U FD
+	 *              bit 11: 2D-2U FD
+	 *              Others: Reserved
+	 * bit [14]   : DADR Length
+	 *              0: 4 bytes
+	 *              1: Reserved
+	 * bit [23:16]: Application Type
+	 *              bit 16: 0=Non-SD memory, 1=SD memory
+	 *              bit 17: 0=Non-SDIO, 1=SDIO
+	 *              bit 18: 0=Card, 1=Embedded
+	 * bit [63:24]: Reserved
+	 */
+	cap = cmd.resp[0];
+	card->uhs2_config.n_lanes =
+				(cap >> UHS2_DEV_CONFIG_N_LANES_POS) &
+				UHS2_DEV_CONFIG_N_LANES_MASK;
+	card->uhs2_config.dadr_len =
+				(cap >> UHS2_DEV_CONFIG_DADR_POS) &
+				UHS2_DEV_CONFIG_DADR_MASK;
+	card->uhs2_config.app_type =
+				(cap >> UHS2_DEV_CONFIG_APP_POS) &
+				UHS2_DEV_CONFIG_APP_MASK;
+
+	/*
+	 * Use Control Read CCMD to read PHY Capability from Configuration Register.
+	 * - Control Write(R/W=1) with 8-Byte payload(PLEN=10b).
+	 * - IOADR = PHY Capability Register(CFG_BASE + 002h)
+	 */
+	arg = ((UHS2_DEV_CONFIG_PHY_CAPS & 0xFF) << 8) |
+	       UHS2_NATIVE_CMD_READ |
+	       UHS2_NATIVE_CMD_PLEN_8B |
+	      (UHS2_DEV_CONFIG_PHY_CAPS >> 8);
+
+	sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg, NULL, 0, NULL, 0);
+
+	err = mmc_wait_for_cmd(host, &cmd, 0);
+	if (err) {
+		pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
+		       mmc_hostname(host), __func__, err);
+		return err;
+	}
+
+	/*
+	 * PHY Capability Register:
+	 * bit [3:0]  : PHY Minor Revision
+	 * bit [5:4]  : PHY Major Revision
+	 * bit [15]   : Support Hibernate Mode
+	 *              0: Not support Hibernate Mode
+	 *              1: Support Hibernate Mode
+	 * bit [31:16]: Reserved
+	 * bit [35:32]: Device-Specific N_LSS_SYN
+	 * bit [39:36]: Device-Specific N_LSS_DIR
+	 * bit [63:40]: Reserved
+	 */
+	cap = cmd.resp[0];
+	card->uhs2_config.phy_minor_rev =
+				cap & UHS2_DEV_CONFIG_PHY_MINOR_MASK;
+	card->uhs2_config.phy_major_rev =
+				(cap >> UHS2_DEV_CONFIG_PHY_MAJOR_POS) &
+				 UHS2_DEV_CONFIG_PHY_MAJOR_MASK;
+	card->uhs2_config.can_hibernate =
+				(cap >> UHS2_DEV_CONFIG_CAN_HIBER_POS) &
+				 UHS2_DEV_CONFIG_CAN_HIBER_MASK;
+
+	cap = cmd.resp[1];
+	card->uhs2_config.n_lss_sync =
+				cap & UHS2_DEV_CONFIG_N_LSS_SYN_MASK;
+	card->uhs2_config.n_lss_dir =
+				(cap >> UHS2_DEV_CONFIG_N_LSS_DIR_POS) &
+				UHS2_DEV_CONFIG_N_LSS_DIR_MASK;
+	if (card->uhs2_config.n_lss_sync == 0)
+		card->uhs2_config.n_lss_sync = 16 << 2;
+	else
+		card->uhs2_config.n_lss_sync <<= 2;
+
+	if (card->uhs2_config.n_lss_dir == 0)
+		card->uhs2_config.n_lss_dir = 16 << 3;
+	else
+		card->uhs2_config.n_lss_dir <<= 3;
+
+	/*
+	 * Use Control Read CCMD to read LINK/TRAN Capability from Configuration Register.
+	 * - Control Write(R/W=1) with 8-Byte payload(PLEN=10b).
+	 * - IOADR = LINK/TRAN Capability Register(CFG_BASE + 004h)
+	 */
+	arg = ((UHS2_DEV_CONFIG_LINK_TRAN_CAPS & 0xFF) << 8) |
+		UHS2_NATIVE_CMD_READ |
+		UHS2_NATIVE_CMD_PLEN_8B |
+		(UHS2_DEV_CONFIG_LINK_TRAN_CAPS >> 8);
+
+	sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg, NULL, 0, NULL, 0);
+
+	err = mmc_wait_for_cmd(host, &cmd, 0);
+	if (err) {
+		pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
+		       mmc_hostname(host), __func__, err);
+		return err;
+	}
+
+	/*
+	 * LINK/TRAN Capability Register:
+	 * bit [3:0]  : LINK_TRAN Minor Revision
+	 * bit [5:4]  : LINK/TRAN Major Revision
+	 * bit [7:6]  : Reserved
+	 * bit [15:8] : Device-Specific N_FCU
+	 * bit [18:16]: Device Type
+	 *              001b=Host
+	 *              010b=Device
+	 *              011b=Reserved for CMD issuable Device
+	 * bit [19]   : Reserved
+	 * bit [31:20]: Device-Specific MAX_BLKLEN
+	 * bit [39:32]: Device-Specific N_DATA_GAP
+	 * bit [63:40]: Reserved
+	 */
+	cap = cmd.resp[0];
+	card->uhs2_config.link_minor_rev =
+				cap & UHS2_DEV_CONFIG_LT_MINOR_MASK;
+	card->uhs2_config.link_major_rev =
+				(cap >> UHS2_DEV_CONFIG_LT_MAJOR_POS) &
+				UHS2_DEV_CONFIG_LT_MAJOR_MASK;
+	card->uhs2_config.n_fcu =
+				(cap >> UHS2_DEV_CONFIG_N_FCU_POS) &
+				UHS2_DEV_CONFIG_N_FCU_MASK;
+	card->uhs2_config.dev_type =
+				(cap >> UHS2_DEV_CONFIG_DEV_TYPE_POS) &
+				UHS2_DEV_CONFIG_DEV_TYPE_MASK;
+	card->uhs2_config.maxblk_len =
+				(cap >> UHS2_DEV_CONFIG_MAX_BLK_LEN_POS) &
+				UHS2_DEV_CONFIG_MAX_BLK_LEN_MASK;
+
+	cap = cmd.resp[1];
+	card->uhs2_config.n_data_gap =
+				cap & UHS2_DEV_CONFIG_N_DATA_GAP_MASK;
+	if (card->uhs2_config.n_fcu == 0)
+		card->uhs2_config.n_fcu = 256;
+
 	return 0;
 }
 
@@ -95,9 +483,407 @@ static int sd_uhs2_config_read(struct mmc_host *host, struct mmc_card *card)
  */
 static int sd_uhs2_config_write(struct mmc_host *host, struct mmc_card *card)
 {
+	struct mmc_command cmd = {0};
+	struct uhs2_command uhs2_cmd = {};
+	u16 header, arg;
+	__be32 payload[UHS2_CFG_WRITE_PAYLOAD_LEN];
+	u8 nMinDataGap;
+	int err;
+	u8 resp[5] = {0};
+
+	/*
+	 * Use Control Write CCMD to set Generic Setting in Configuration Register.
+	 * - Control Write(R/W=1) with 8-Byte payload(PLEN=10b).
+	 * - IOADR = Generic Setting Register(CFG_BASE + 008h)
+	 * - Payload = New contents to be written to Generic Setting Register
+	 */
+	header = UHS2_NATIVE_PACKET | UHS2_PACKET_TYPE_CCMD | card->uhs2_config.node_id;
+	arg = ((UHS2_DEV_CONFIG_GEN_SET & 0xFF) << 8) |
+	       UHS2_NATIVE_CMD_WRITE |
+	       UHS2_NATIVE_CMD_PLEN_8B |
+	       (UHS2_DEV_CONFIG_GEN_SET >> 8);
+
+	if (card->uhs2_config.n_lanes == UHS2_DEV_CONFIG_2L_HD_FD &&
+	    host->uhs2_caps.n_lanes == UHS2_DEV_CONFIG_2L_HD_FD) {
+		/* Support HD */
+		host->uhs2_ios.is_2L_HD_mode = true;
+		nMinDataGap = 1;
+	} else {
+		/* Only support 2L-FD so far */
+		host->uhs2_ios.is_2L_HD_mode = false;
+		nMinDataGap = 3;
+	}
+
+	/*
+	 * Most UHS-II cards only support FD and 2L-HD mode. Other lane numbers
+	 * defined in UHS-II addendem Ver1.01 are optional.
+	 */
+	host->uhs2_caps.n_lanes_set = UHS2_DEV_CONFIG_GEN_SET_2L_FD_HD;
+	card->uhs2_config.n_lanes_set = UHS2_DEV_CONFIG_GEN_SET_2L_FD_HD;
+
+	payload[0] = card->uhs2_config.n_lanes_set << UHS2_DEV_CONFIG_N_LANES_POS;
+	payload[1] = 0;
+	payload[0] = cpu_to_be32(payload[0]);
+	payload[1] = cpu_to_be32(payload[1]);
+
+	/*
+	 * There is no payload because per spec, there should be
+	 * no payload field for read CCMD.
+	 * Plen is set in arg. Per spec, plen for read CCMD
+	 * represents the len of read data which is assigned in payload
+	 * of following RES (p136).
+	 */
+	sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg, payload, UHS2_CFG_WRITE_PAYLOAD_LEN,
+			     NULL, 0);
+
+	err = mmc_wait_for_cmd(host, &cmd, 0);
+	if (err) {
+		pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
+		       mmc_hostname(host), __func__, err);
+		return err;
+	}
+
+	/*
+	 * Use Control Write CCMD to set PHY Setting in Configuration Register.
+	 * - Control Write(R/W=1) with 8-Byte payload(PLEN=10b).
+	 * - IOADR = PHY Setting Register(CFG_BASE + 00Ah)
+	 * - Payload = New contents to be written to PHY Setting Register
+	 */
+	arg = ((UHS2_DEV_CONFIG_PHY_SET & 0xFF) << 8) |
+	       UHS2_NATIVE_CMD_WRITE |
+	       UHS2_NATIVE_CMD_PLEN_8B |
+	       (UHS2_DEV_CONFIG_PHY_SET >> 8);
+
+	if (host->uhs2_caps.speed_range == UHS2_DEV_CONFIG_PHY_SET_SPEED_B) {
+		card->uhs2_state |= MMC_UHS2_SPEED_B;
+		card->uhs2_config.speed_range_set =
+					UHS2_DEV_CONFIG_PHY_SET_SPEED_B;
+	} else {
+		card->uhs2_config.speed_range_set = UHS2_DEV_CONFIG_PHY_SET_SPEED_A;
+		card->uhs2_state &= ~MMC_UHS2_SPEED_B;
+	}
+
+	payload[0] = card->uhs2_config.speed_range_set << UHS2_DEV_CONFIG_PHY_SET_SPEED_POS;
+
+	card->uhs2_config.n_lss_sync_set = (max(card->uhs2_config.n_lss_sync,
+						host->uhs2_caps.n_lss_sync) >> 2) &
+					   UHS2_DEV_CONFIG_N_LSS_SYN_MASK;
+	host->uhs2_caps.n_lss_sync_set = card->uhs2_config.n_lss_sync_set;
+
+	card->uhs2_config.n_lss_dir_set = (max(card->uhs2_config.n_lss_dir,
+					       host->uhs2_caps.n_lss_dir) >> 3) &
+					  UHS2_DEV_CONFIG_N_LSS_DIR_MASK;
+	host->uhs2_caps.n_lss_dir_set = card->uhs2_config.n_lss_dir_set;
+
+	payload[1] = (card->uhs2_config.n_lss_dir_set << UHS2_DEV_CONFIG_N_LSS_DIR_POS) |
+		     card->uhs2_config.n_lss_sync_set;
+	payload[0] = cpu_to_be32(payload[0]);
+	payload[1] = cpu_to_be32(payload[1]);
+
+	memset(resp, 0, sizeof(resp));
+
+	sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg, payload, UHS2_CFG_WRITE_PAYLOAD_LEN,
+			     resp, UHS2_CFG_WRITE_PHY_SET_RESP_LEN);
+
+	err = mmc_wait_for_cmd(host, &cmd, 0);
+	if (err) {
+		pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
+		       mmc_hostname(host), __func__, err);
+		return err;
+	}
+
+	if ((resp[2] & 0x80)) {
+		pr_err("%s: %s: UHS2 CMD not accepted, resp= 0x%x!\n",
+		       mmc_hostname(host), __func__, resp[2]);
+		return -EIO;
+	}
+
+	/*
+	 * Use Control Write CCMD to set LINK/TRAN Setting in Configuration Register.
+	 * - Control Write(R/W=1) with 8-Byte payload(PLEN=10b).
+	 * - IOADR = LINK/TRAN Setting Register(CFG_BASE + 00Ch)
+	 * - Payload = New contents to be written to LINK/TRAN Setting Register
+	 */
+	arg = ((UHS2_DEV_CONFIG_LINK_TRAN_SET & 0xFF) << 8) |
+		UHS2_NATIVE_CMD_WRITE |
+		UHS2_NATIVE_CMD_PLEN_8B |
+		(UHS2_DEV_CONFIG_LINK_TRAN_SET >> 8);
+
+	if (card->uhs2_config.app_type == UHS2_DEV_CONFIG_APP_SD_MEM)
+		card->uhs2_config.maxblk_len_set = UHS2_DEV_CONFIG_LT_SET_MAX_BLK_LEN;
+	else
+		card->uhs2_config.maxblk_len_set = min(card->uhs2_config.maxblk_len,
+						       host->uhs2_caps.maxblk_len);
+	host->uhs2_caps.maxblk_len_set = card->uhs2_config.maxblk_len_set;
+
+	card->uhs2_config.n_fcu_set = min(card->uhs2_config.n_fcu, host->uhs2_caps.n_fcu);
+	host->uhs2_caps.n_fcu_set = card->uhs2_config.n_fcu_set;
+
+	card->uhs2_config.n_data_gap_set = max(nMinDataGap, card->uhs2_config.n_data_gap);
+	host->uhs2_caps.n_data_gap_set = card->uhs2_config.n_data_gap_set;
+
+	host->uhs2_caps.max_retry_set = 3;
+	card->uhs2_config.max_retry_set = host->uhs2_caps.max_retry_set;
+
+	payload[0] = (card->uhs2_config.maxblk_len_set << UHS2_DEV_CONFIG_MAX_BLK_LEN_POS) |
+		     (card->uhs2_config.max_retry_set << UHS2_DEV_CONFIG_LT_SET_MAX_RETRY_POS) |
+		     (card->uhs2_config.n_fcu_set << UHS2_DEV_CONFIG_N_FCU_POS);
+	payload[1] = card->uhs2_config.n_data_gap_set;
+	payload[0] = cpu_to_be32(payload[0]);
+	payload[1] = cpu_to_be32(payload[1]);
+
+	sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg, payload, UHS2_CFG_WRITE_PAYLOAD_LEN,
+			     NULL, 0);
+
+	err = mmc_wait_for_cmd(host, &cmd, 0);
+	if (err) {
+		pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
+		       mmc_hostname(host), __func__, err);
+		return err;
+	}
+
+	/*
+	 * Use Control Write CCMD to set Config Completion(payload bit 63) in Generic Setting
+	 * Register.
+	 * Header:
+	 *      - Control Write(R/W=1) with 8-Byte payload(PLEN=10b).
+	 *      - IOADR = PGeneric Setting Register(CFG_BASE + 008h)
+	 * Payload:
+	 *      - bit [63]: Config Completion
+	 *
+	 * DLSM transits to Active state immediately when Config Completion is set to 1.
+	 */
+	arg = ((UHS2_DEV_CONFIG_GEN_SET & 0xFF) << 8) |
+	       UHS2_NATIVE_CMD_WRITE |
+	       UHS2_NATIVE_CMD_PLEN_8B |
+	       (UHS2_DEV_CONFIG_GEN_SET >> 8);
+
+	payload[0] = 0;
+	payload[1] = UHS2_DEV_CONFIG_GEN_SET_CFG_COMPLETE;
+	payload[0] = cpu_to_be32(payload[0]);
+	payload[1] = cpu_to_be32(payload[1]);
+
+	memset(resp, 0, sizeof(resp));
+	sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg, payload, UHS2_CFG_WRITE_PAYLOAD_LEN,
+			     resp, UHS2_CFG_WRITE_GENERIC_SET_RESP_LEN);
+
+	err = mmc_wait_for_cmd(host, &cmd, 0);
+	if (err) {
+		pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
+		       mmc_hostname(host), __func__, err);
+		return err;
+	}
+
+	/* Set host Config Setting registers */
+	err = host->ops->uhs2_control(host, UHS2_SET_CONFIG);
+	if (err) {
+		pr_err("%s: %s: UHS2 SET_CONFIG fail!\n", mmc_hostname(host), __func__);
+		return err;
+	}
+
 	return 0;
 }
 
+static int sd_uhs2_go_dormant(struct mmc_host *host, u32 node_id)
+{
+	struct mmc_command cmd = {0};
+	struct uhs2_command uhs2_cmd = {};
+	u16 header, arg;
+	__be32 payload[1];
+	int err;
+
+	/* Disable Normal INT */
+	err = host->ops->uhs2_control(host, UHS2_DISABLE_INT);
+	if (err) {
+		pr_err("%s: %s: UHS2 DISABLE_INT fail!\n",
+		       mmc_hostname(host), __func__);
+		return err;
+	}
+
+	/*
+	 * Refer to UHS-II Addendum Version 1.02 Figure 6-17 to see GO_DORMANT_STATE CCMD format.
+	 * Header:
+	 *      - Control Write(R/W=1) with 4-Byte payload(PLEN=01b).
+	 *      - IOADR = CMD_BASE + 001h
+	 * Payload:
+	 *      - bit [7]: HBR(Entry to Hibernate Mode)
+	 *                 1: Host intends to enter Hibernate mode during Dormant state.
+	 *                 The default setting is 0 because hibernate is currently not supported.
+	 */
+	header = UHS2_NATIVE_PACKET | UHS2_PACKET_TYPE_CCMD | node_id;
+	arg = ((UHS2_DEV_CMD_GO_DORMANT_STATE & 0xFF) << 8) |
+		UHS2_NATIVE_CMD_WRITE |
+		UHS2_NATIVE_CMD_PLEN_4B |
+		(UHS2_DEV_CMD_GO_DORMANT_STATE >> 8);
+
+	sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg, payload, UHS2_GO_DORMANT_PAYLOAD_LEN,
+			     NULL, 0);
+
+	err = mmc_wait_for_cmd(host, &cmd, 0);
+	if (err) {
+		pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
+		       mmc_hostname(host), __func__, err);
+		return err;
+	}
+
+	/* Check Dormant State in Present */
+	err = host->ops->uhs2_control(host, UHS2_CHECK_DORMANT);
+	if (err)
+		return err;
+
+	/* Disable UHS2 card clock */
+	err = host->ops->uhs2_control(host, UHS2_DISABLE_CLK);
+	if (err)
+		return err;
+
+	/* Restore sd clock */
+	mmc_delay(5);
+	err = host->ops->uhs2_control(host, UHS2_ENABLE_CLK);
+	if (err)
+		return err;
+
+	/* Enable Normal INT */
+	err = host->ops->uhs2_control(host, UHS2_ENABLE_INT);
+	if (err)
+		return err;
+
+	/* Detect UHS2 */
+	err = host->ops->uhs2_control(host, UHS2_PHY_INIT);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static int __sd_uhs2_wait_active_state_cb(void *cb_data, bool *busy)
+{
+	struct sd_uhs2_wait_active_state_data *data = cb_data;
+	struct mmc_host *host = data->host;
+	struct mmc_command *cmd = data->cmd;
+	int err;
+
+	err = mmc_wait_for_cmd(host, cmd, 0);
+	if (err)
+		return err;
+
+	if (cmd->resp[1] & UHS2_DEV_CONFIG_GEN_SET_CFG_COMPLETE)
+		*busy = false;
+	else
+		*busy = true;
+
+	return 0;
+}
+
+static int sd_uhs2_change_speed(struct mmc_host *host, u32 node_id)
+{
+	struct mmc_command cmd = {0};
+	struct uhs2_command uhs2_cmd = {};
+	u16 header, arg;
+	int err;
+	struct sd_uhs2_wait_active_state_data cb_data = {
+		.host = host,
+		.cmd = &cmd
+	};
+
+	/* Change Speed Range at controller side. */
+	err = host->ops->uhs2_control(host, UHS2_SET_SPEED_B);
+	if (err) {
+		pr_err("%s: %s: UHS2 SET_SPEED fail!\n", mmc_hostname(host), __func__);
+		return err;
+	}
+
+	err = sd_uhs2_go_dormant(host, node_id);
+	if (err) {
+		pr_err("%s: %s: UHS2 GO_DORMANT_STATE fail, err= 0x%x!\n",
+		       mmc_hostname(host), __func__, err);
+		return err;
+	}
+
+	/*
+	 * Use Control Read CCMD to check Config Completion(bit 63) in Generic Setting Register.
+	 * - Control Read(R/W=0) with 8-Byte payload(PLEN=10b).
+	 * - IOADR = Generic Setting Register(CFG_BASE + 008h)
+	 *
+	 * When UHS-II card been switched to new speed mode, it will set Config Completion to 1.
+	 */
+	header = UHS2_NATIVE_PACKET | UHS2_PACKET_TYPE_CCMD | node_id;
+	arg = ((UHS2_DEV_CONFIG_GEN_SET & 0xFF) << 8) |
+		UHS2_NATIVE_CMD_READ |
+		UHS2_NATIVE_CMD_PLEN_8B |
+		(UHS2_DEV_CONFIG_GEN_SET >> 8);
+
+	sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg, NULL, 0, NULL, 0);
+	err = __mmc_poll_for_busy(host, UHS2_WAIT_CFG_COMPLETE_PERIOD_US,
+				  UHS2_WAIT_CFG_COMPLETE_TIMEOUT_MS,
+				  &__sd_uhs2_wait_active_state_cb, &cb_data);
+	if (err) {
+		pr_err("%s: %s: Not switch to Active in 100 ms\n", mmc_hostname(host), __func__);
+		return err;
+	}
+
+	return 0;
+}
+
+static int sd_uhs2_get_ro(struct mmc_host *host)
+{
+	/*
+	 * Some systems don't feature a write-protect pin and don't need one.
+	 * E.g. because they only have micro-SD card slot. For those systems
+	 * assume that the SD card is always read-write.
+	 */
+	if (host->caps2 & MMC_CAP2_NO_WRITE_PROTECT)
+		return 0;
+
+	if (!host->ops->get_ro)
+		return -1;
+
+	return host->ops->get_ro(host);
+}
+
+/*
+ * Mask off any voltages we don't support and select
+ * the lowest voltage
+ */
+u32 sd_uhs2_select_voltage(struct mmc_host *host, u32 ocr)
+{
+	int bit;
+	int err;
+
+	/*
+	 * Sanity check the voltages that the card claims to
+	 * support.
+	 */
+	if (ocr & 0x7F) {
+		dev_warn(mmc_dev(host), "card claims to support voltages below defined range\n");
+		ocr &= ~0x7F;
+	}
+
+	ocr &= host->ocr_avail;
+	if (!ocr) {
+		dev_warn(mmc_dev(host), "no support for card's volts\n");
+		return 0;
+	}
+
+	if (host->caps2 & MMC_CAP2_FULL_PWR_CYCLE) {
+		bit = ffs(ocr) - 1;
+		ocr &= 3 << bit;
+		/* Power cycle */
+		err = sd_uhs2_power_off(host);
+		if (err)
+			return 0;
+		err = sd_uhs2_reinit(host);
+		if (err)
+			return 0;
+	} else {
+		bit = fls(ocr) - 1;
+		ocr &= 3 << bit;
+		if (bit != host->ios.vdd)
+			dev_warn(mmc_dev(host), "exceeding card's volts\n");
+	}
+
+	return ocr;
+}
+
 /*
  * Initialize the UHS-II card through the SD-TRAN transport layer. This enables
  * commands/requests to be backwards compatible through the legacy SD protocol.
@@ -107,14 +893,143 @@ static int sd_uhs2_config_write(struct mmc_host *host, struct mmc_card *card)
  */
 static int sd_uhs2_legacy_init(struct mmc_host *host, struct mmc_card *card)
 {
+	int err;
+	u32 cid[4];
+	u32 ocr;
+	u32 rocr;
+	u8  status[64];
+	int ro;
+
+	/* Send CMD0 to reset SD card */
+	err = __mmc_go_idle(host);
+	if (err)
+		return err;
+
+	mmc_delay(1);
+
+	/* Send CMD8 to communicate SD interface operation condition */
+	err = mmc_send_if_cond(host, host->ocr_avail);
+	if (err) {
+		dev_warn(mmc_dev(host), "CMD8 error\n");
+		return err;
+	}
+
+	/*
+	 * Probe SD card working voltage.
+	 */
+	err = mmc_send_app_op_cond(host, 0, &ocr);
+	if (err)
+		return err;
+
+	card->ocr = ocr;
+
+	/*
+	 * Some SD cards claims an out of spec VDD voltage range. Let's treat
+	 * these bits as being in-valid and especially also bit7.
+	 */
+	ocr &= ~0x7FFF;
+	rocr = sd_uhs2_select_voltage(host, ocr);
+	/*
+	 * Some cards have zero value of rocr in UHS-II mode. Assign host's
+	 * ocr value to rocr.
+	 */
+	if (!rocr)
+		rocr = host->ocr_avail;
+
+	rocr |= (SD_OCR_CCS | SD_OCR_XPC);
+
+	/* Wait SD power on ready */
+	ocr = rocr;
+
+	err = mmc_send_app_op_cond(host, ocr, &rocr);
+	if (err)
+		return err;
+
+	err = mmc_send_cid(host, cid);
+	if (err)
+		return err;
+
+	memcpy(card->raw_cid, cid, sizeof(card->raw_cid));
+	mmc_decode_cid(card);
+
+	/*
+	 * For native busses:  get card RCA and quit open drain mode.
+	 */
+	err = mmc_send_relative_addr(host, &card->rca);
+	if (err)
+		return err;
+
+	err = mmc_sd_get_csd(card);
+	if (err)
+		return err;
+
+	/*
+	 * Select card, as all following commands rely on that.
+	 */
+	err = mmc_select_card(card);
+	if (err)
+		return err;
+
+	/*
+	 * Fetch SCR from card.
+	 */
+	err = mmc_app_send_scr(card);
+	if (err)
+		return err;
+
+	err = mmc_decode_scr(card);
+	if (err)
+		return err;
+
+	/*
+	 * Switch to high power consumption mode.
+	 * Even switch failed, sd card can still work at lower power consumption mode, but
+	 * performance will be lower than high power consumption mode.
+	 */
+	if (!(card->csd.cmdclass & CCC_SWITCH)) {
+		pr_warn("%s: card lacks mandatory switch function, performance might suffer\n",
+			mmc_hostname(card->host));
+	} else {
+		/* send CMD6 to set Maximum Power Consumption to get better performance */
+		err = mmc_sd_switch(card, 0, 3, SD4_SET_POWER_LIMIT_1_80W, status);
+		if (!err)
+			err = mmc_sd_switch(card, 1, 3, SD4_SET_POWER_LIMIT_1_80W, status);
+
+		err = 0;
+	}
+
+	/*
+	 * Check if read-only switch is active.
+	 */
+	ro = sd_uhs2_get_ro(host);
+	if (ro < 0) {
+		pr_warn("%s: host does not support read-only switch, assuming write-enable\n",
+			mmc_hostname(host));
+	} else if (ro > 0) {
+		mmc_card_set_readonly(card);
+	}
+
+	/*
+	 * NOTE:
+	 * Should we read Externsion Register to check power notification feature here?
+	 */
+
 	return 0;
 }
 
+static void sd_uhs2_remove(struct mmc_host *host)
+{
+	mmc_remove_card(host->card);
+	host->card = NULL;
+	if (host->flags & MMC_UHS2_INITIALIZED)
+		host->flags &= ~MMC_UHS2_INITIALIZED;
+}
+
 /*
  * Allocate the data structure for the mmc_card and run the UHS-II specific
  * initialization sequence.
  */
-static int sd_uhs2_init_card(struct mmc_host *host)
+static int sd_uhs2_init_card(struct mmc_host *host, struct mmc_card *oldcard)
 {
 	struct mmc_card *card;
 	u32 node_id;
@@ -128,9 +1043,14 @@ static int sd_uhs2_init_card(struct mmc_host *host)
 	if (err)
 		return err;
 
-	card = mmc_alloc_card(host, &sd_type);
-	if (IS_ERR(card))
-		return PTR_ERR(card);
+	if (oldcard) {
+		card = oldcard;
+	} else {
+		card = mmc_alloc_card(host, &sd_type);
+		if (IS_ERR(card))
+			return PTR_ERR(card);
+	}
+	host->card = card;
 
 	card->uhs2_config.node_id = node_id;
 	card->type = MMC_TYPE_SD;
@@ -143,22 +1063,47 @@ static int sd_uhs2_init_card(struct mmc_host *host)
 	if (err)
 		goto err;
 
+	/* Change to Speed Range B if it is supported */
+	if (card->uhs2_state & MMC_UHS2_SPEED_B) {
+		err = sd_uhs2_change_speed(host, node_id);
+		if (err)
+			return err;
+	}
+
+	host->card->uhs2_state |= MMC_UHS2_INITIALIZED;
+	host->flags |= MMC_UHS2_INITIALIZED;
+
 	err = sd_uhs2_legacy_init(host, card);
 	if (err)
 		goto err;
 
-	host->card = card;
 	return 0;
 
 err:
-	mmc_remove_card(card);
+	if (host->card->uhs2_state & MMC_UHS2_INITIALIZED)
+		host->card->uhs2_state &= ~MMC_UHS2_INITIALIZED;
+	if (host->flags & MMC_UHS2_INITIALIZED)
+		host->flags &= ~MMC_UHS2_INITIALIZED;
+	sd_uhs2_remove(host);
 	return err;
 }
 
-static void sd_uhs2_remove(struct mmc_host *host)
+int sd_uhs2_reinit(struct mmc_host *host)
 {
-	mmc_remove_card(host->card);
-	host->card = NULL;
+	struct mmc_card *card = host->card;
+	int err;
+
+	sd_uhs2_power_up(host);
+	err = sd_uhs2_phy_init(host);
+	if (err)
+		return err;
+
+	err = sd_uhs2_init_card(host, card);
+	if (err)
+		return err;
+
+	mmc_card_set_present(card);
+	return err;
 }
 
 static int sd_uhs2_alive(struct mmc_host *host)
@@ -184,34 +1129,176 @@ static void sd_uhs2_detect(struct mmc_host *host)
 	}
 }
 
+static int _sd_uhs2_suspend(struct mmc_host *host)
+{
+	struct mmc_card *card = host->card;
+	int err = 0;
+
+	mmc_claim_host(host);
+
+	if (mmc_card_suspended(card))
+		goto out;
+
+	if (mmc_card_can_poweroff_notify(card))
+		err = sd_poweroff_notify(card);
+
+	if (!err) {
+		sd_uhs2_power_off(host);
+		mmc_card_set_suspended(card);
+	}
+
+out:
+	mmc_release_host(host);
+	return err;
+}
+
+/*
+ * Callback for suspend
+ */
 static int sd_uhs2_suspend(struct mmc_host *host)
 {
-	return 0;
+	int err;
+
+	err = _sd_uhs2_suspend(host);
+	if (!err) {
+		pm_runtime_disable(&host->card->dev);
+		pm_runtime_set_suspended(&host->card->dev);
+	}
+
+	return err;
+}
+
+/*
+ * This function tries to determine if the same card is still present
+ * and, if so, restore all state to it.
+ */
+static int _mmc_sd_uhs2_resume(struct mmc_host *host)
+{
+	int err = 0;
+
+	mmc_claim_host(host);
+
+	if (!mmc_card_suspended(host->card))
+		goto out;
+
+	/* Power up UHS2 SD card and re-initialize it. */
+	err = sd_uhs2_reinit(host);
+	mmc_card_clr_suspended(host->card);
+
+out:
+	mmc_release_host(host);
+	return err;
 }
 
+/*
+ * Callback for resume
+ */
 static int sd_uhs2_resume(struct mmc_host *host)
 {
+	pm_runtime_enable(&host->card->dev);
 	return 0;
 }
 
+/*
+ * Callback for runtime_suspend.
+ */
 static int sd_uhs2_runtime_suspend(struct mmc_host *host)
 {
-	return 0;
+	int err;
+
+	if (!(host->caps & MMC_CAP_AGGRESSIVE_PM))
+		return 0;
+
+	err = _sd_uhs2_suspend(host);
+	if (err)
+		pr_err("%s: error %d doing aggressive suspend\n", mmc_hostname(host), err);
+
+	return err;
 }
 
 static int sd_uhs2_runtime_resume(struct mmc_host *host)
 {
-	return 0;
+	int err;
+
+	err = _mmc_sd_uhs2_resume(host);
+	if (err && err != -ENOMEDIUM)
+		pr_err("%s: error %d doing runtime resume\n", mmc_hostname(host), err);
+
+	return err;
 }
 
-static int sd_uhs2_shutdown(struct mmc_host *host)
+static int sd_uhs2_hw_reset(struct mmc_host *host)
 {
-	return 0;
+	int err;
+
+	sd_uhs2_power_off(host);
+	/* Wait at least 1 ms according to SD spec */
+	mmc_delay(1);
+	sd_uhs2_power_up(host);
+
+	err = sd_uhs2_reinit(host);
+
+	return err;
 }
 
-static int sd_uhs2_hw_reset(struct mmc_host *host)
+/*
+ * mmc_uhs2_prepare_cmd - prepare for SD command packet
+ * @host:	MMC host
+ * @mrq:	MMC request
+ *
+ * Initialize and fill in a header and a payload of SD command packet.
+ * The caller should allocate uhs2_command in host->cmd->uhs2_cmd in
+ * advance.
+ *
+ * Return:	0 on success, non-zero error on failure
+ */
+void mmc_uhs2_prepare_cmd(struct mmc_host *host, struct mmc_request *mrq)
 {
-	return 0;
+	struct mmc_command *cmd;
+	struct uhs2_command *uhs2_cmd;
+	u16 header, arg;
+	__be32 *payload;
+	u8 plen;
+
+	cmd = mrq->cmd;
+	header = host->card->uhs2_config.node_id;
+	if ((cmd->flags & MMC_CMD_MASK) == MMC_CMD_ADTC)
+		header |= UHS2_PACKET_TYPE_DCMD;
+	else
+		header |= UHS2_PACKET_TYPE_CCMD;
+
+	arg = cmd->opcode << UHS2_SD_CMD_INDEX_POS;
+	if (host->uhs2_ios.is_APP_CMD) {
+		arg |= UHS2_SD_CMD_APP;
+		host->uhs2_ios.is_APP_CMD = false;
+	}
+
+	uhs2_cmd = cmd->uhs2_cmd;
+	payload = uhs2_cmd->payload;
+	plen = 2; /* at the maximum */
+
+	if ((cmd->flags & MMC_CMD_MASK) == MMC_CMD_ADTC &&
+	    !cmd->uhs2_tmode0_flag) {
+		if (host->uhs2_ios.is_2L_HD_mode)
+			arg |= UHS2_DCMD_2L_HD_MODE;
+
+		arg |= UHS2_DCMD_LM_TLEN_EXIST;
+
+		if (cmd->data->blocks == 1 &&
+		    cmd->data->blksz != 512 &&
+		    cmd->opcode != MMC_READ_SINGLE_BLOCK &&
+		    cmd->opcode != MMC_WRITE_BLOCK) {
+			arg |= UHS2_DCMD_TLUM_BYTE_MODE;
+			payload[1] = cpu_to_be32(cmd->data->blksz);
+		} else {
+			payload[1] = cpu_to_be32(cmd->data->blocks);
+		}
+	} else {
+		plen = 1;
+	}
+
+	payload[0] = cpu_to_be32(cmd->arg);
+	sd_uhs2_cmd_assemble(cmd, uhs2_cmd, header, arg, payload, plen, NULL, 0);
 }
 
 static const struct mmc_bus_ops sd_uhs2_ops = {
@@ -222,7 +1309,7 @@ static const struct mmc_bus_ops sd_uhs2_ops = {
 	.resume = sd_uhs2_resume,
 	.runtime_suspend = sd_uhs2_runtime_suspend,
 	.runtime_resume = sd_uhs2_runtime_resume,
-	.shutdown = sd_uhs2_shutdown,
+	.shutdown = sd_uhs2_suspend,
 	.hw_reset = sd_uhs2_hw_reset,
 };
 
@@ -230,6 +1317,8 @@ static int sd_uhs2_attach(struct mmc_host *host)
 {
 	int err;
 
+	host->flags |= MMC_UHS2_SUPPORT;
+
 	err = sd_uhs2_power_up(host);
 	if (err)
 		goto err;
@@ -238,7 +1327,7 @@ static int sd_uhs2_attach(struct mmc_host *host)
 	if (err)
 		goto err;
 
-	err = sd_uhs2_init_card(host);
+	err = sd_uhs2_init_card(host, NULL);
 	if (err)
 		goto err;
 
@@ -251,21 +1340,34 @@ static int sd_uhs2_attach(struct mmc_host *host)
 		goto remove_card;
 
 	mmc_claim_host(host);
+
+	host->ops->uhs2_control(host, UHS2_POST_ATTACH_SD);
+
 	return 0;
 
 remove_card:
-	mmc_remove_card(host->card);
-	host->card = NULL;
+	sd_uhs2_remove(host);
 	mmc_claim_host(host);
-	mmc_detach_bus(host);
+
 err:
+	mmc_detach_bus(host);
 	sd_uhs2_power_off(host);
-	return err;
+	host->flags &= ~MMC_UHS2_SUPPORT;
+	return 1;
 }
 
+/**
+ * mmc_attach_sd_uhs2 - select UHS2 interface
+ * @host: MMC host
+ *
+ * Try to select UHS2 interface and initialize the bus for a given
+ * frequency, @freq.
+ *
+ * Return:	0 on success, non-zero error on failure
+ */
 int mmc_attach_sd_uhs2(struct mmc_host *host)
 {
-	int i, err = 0;
+	int i, err;
 
 	if (!(host->caps2 & MMC_CAP2_SD_UHS2))
 		return -EOPNOTSUPP;
@@ -280,6 +1382,9 @@ int mmc_attach_sd_uhs2(struct mmc_host *host)
 	 */
 	for (i = 0; i < ARRAY_SIZE(sd_uhs2_freqs); i++) {
 		host->f_init = sd_uhs2_freqs[i];
+		pr_info("%s: %s: trying to init UHS-II card at %u Hz\n",
+			mmc_hostname(host), __func__, host->f_init);
+
 		err = sd_uhs2_attach(host);
 		if (!err)
 			break;
-- 
2.25.1

