Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D08710954
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 11:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240791AbjEYJ4u convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 25 May 2023 05:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240750AbjEYJ4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 05:56:39 -0400
Received: from mail6.swissbit.com (mail5.swissbit.com [148.251.244.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA5E198;
        Thu, 25 May 2023 02:56:33 -0700 (PDT)
Received: from mail6.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 4CF2A2229B1;
        Thu, 25 May 2023 11:56:29 +0200 (CEST)
Received: from mail6.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 365D32229AD;
        Thu, 25 May 2023 11:56:29 +0200 (CEST)
X-TM-AS-ERS: 10.181.10.102-127.5.254.253
X-TM-AS-SMTP: 1.0 bXgyLmRtei5zd2lzc2JpdC5jb20= Y2xvZWhsZUBoeXBlcnN0b25lLmNvb
        Q==
X-DDEI-TLS-USAGE: Used
Received: from mx2.dmz.swissbit.com (mx2.dmz.swissbit.com [10.181.10.102])
        by mail6.swissbit.com (Postfix) with ESMTPS;
        Thu, 25 May 2023 11:56:29 +0200 (CEST)
From:   Christian Loehle <CLoehle@hyperstone.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
CC:     Avri Altman <avri.altman@wdc.com>
Subject: [PATCHv2 2/2] mmc: block: ioctl: Add PROG-error aggregation
Thread-Topic: [PATCHv2 2/2] mmc: block: ioctl: Add PROG-error aggregation
Thread-Index: AdmO7sTHynhJBfr0QaiYbMnasjMjBA==
Date:   Thu, 25 May 2023 09:56:27 +0000
Message-ID: <461dba105f644867a6687858d51324e8@hyperstone.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-9.0.1002-27648.006
X-TMASE-Result: 10--14.647500-10.000000
X-TMASE-MatchedRID: ViBM8e+kg1tvBOh2s92TSM2CuVPkCNzu2FA7wK9mP9fG5dXdQTj2OIGz
        z42T0DP5p3HiycuTwqB22LX9ExaXqivLSgqaAVoR9k0tWBWiOf/5UnqVnIHSz40nZyQtGDZRcQn
        7AixVvVx72aKohPmGR8+cZr5skxwlUIGCvH0MbYudx4sU8R+eYNUEOicf335Wyuet65/g7pDwbY
        qNisklFI8eV9xXSOFA5p98cjyQCaIdj9vNGYhpkfZOZ2c2VQUgrzD8YrC59vwQRik6+J7XSekgE
        vppMdRRihBIRRThmIoXIQarK0WBEPTxGqS5mxwxSHCU59h5KrHjGl5yCARaLSow3ZvJGhxdo8WM
        kQWv6iXGlDvsLUDW2o6HM5rqDwqtt/M5vLBr1IEgtSmzLrssL2uxZN6twIvAMpethoiaJsES0SE
        YHUAztQ==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: c8eaafc1-628c-4b60-8317-7b7097e3f147-0-0-200-0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Userspace currently has no way of checking for error bits of
detection mode X. These are error bits that are only detected by
the card when executing the command. For e.g. a sanitize operation
this may be minutes after the RSP was seen by the host.

Currently userspace programs cannot see these error bits reliably.
They could issue a multi ioctl cmd with a CMD13 immediately following
it, but since errors of detection mode X are automatically cleared
(they are all clear condition B).
mmc_poll_for_busy of the first ioctl may have already hidden such an
error flag.

In case of the security operations: sanitize, secure erases and
RPMB writes, this could lead to the operation not being performed
successfully by the card with the user not knowing.
If the user trusts that this operation is completed
(e.g. their data is sanitized), this could be a security issue.
An attacker could e.g. provoke a eMMC (VCC) flash fail, where a
successful sanitize of a card is not possible. A card may move out
of PROG state but issue a bit 19 R1 error.

This patch therefore will also have the consequence of a mmc-utils
patch, which enables the bit for the security-sensitive operations.

Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
---
 drivers/mmc/core/block.c   | 17 ++++++-----------
 drivers/mmc/core/mmc_ops.c | 25 ++++++++++++++++++++++++-
 drivers/mmc/core/mmc_ops.h |  3 +++
 3 files changed, 33 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index e46330815484..44c1b2825032 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -470,7 +470,7 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 	struct mmc_data data = {};
 	struct mmc_request mrq = {};
 	struct scatterlist sg;
-	bool r1b_resp, use_r1b_resp = false;
+	bool r1b_resp;
 	unsigned int busy_timeout_ms;
 	int err;
 	unsigned int target_part;
@@ -551,8 +551,7 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 	busy_timeout_ms = idata->ic.cmd_timeout_ms ? : MMC_BLK_TIMEOUT_MS;
 	r1b_resp = (cmd.flags & MMC_RSP_R1B) == MMC_RSP_R1B;
 	if (r1b_resp)
-		use_r1b_resp = mmc_prepare_busy_cmd(card->host, &cmd,
-						    busy_timeout_ms);
+		mmc_prepare_busy_cmd(card->host, &cmd, busy_timeout_ms);
 
 	mmc_wait_for_req(card->host, &mrq);
 	memcpy(&idata->ic.response, cmd.resp, sizeof(cmd.resp));
@@ -605,19 +604,15 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 	if (idata->ic.postsleep_min_us)
 		usleep_range(idata->ic.postsleep_min_us, idata->ic.postsleep_max_us);
 
-	/* No need to poll when using HW busy detection. */
-	if ((card->host->caps & MMC_CAP_WAIT_WHILE_BUSY) && use_r1b_resp)
-		return 0;
-
 	if (mmc_host_is_spi(card->host)) {
 		if (idata->ic.write_flag || r1b_resp || cmd.flags & MMC_RSP_SPI_BUSY)
 			return mmc_spi_err_check(card);
 		return err;
 	}
-	/* Ensure RPMB/R1B command has completed by polling with CMD13. */
-	if (idata->rpmb || r1b_resp)
-		err = mmc_poll_for_busy(card, busy_timeout_ms, false,
-					MMC_BUSY_IO);
+	/* Poll for write/R1B execution errors */
+	if (idata->ic.write_flag || r1b_resp)
+		err = mmc_poll_for_busy_err_flags(card, busy_timeout_ms, false,
+					MMC_BUSY_IO, &idata->ic.response[0]);
 
 	return err;
 }
diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 3b3adbddf664..11e566ab719c 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -57,7 +57,9 @@ static const u8 tuning_blk_pattern_8bit[] = {
 struct mmc_busy_data {
 	struct mmc_card *card;
 	bool retry_crc_err;
+	bool aggregate_err_flags;
 	enum mmc_busy_cmd busy_cmd;
+	u32 *status;
 };
 
 struct mmc_op_cond_busy_data {
@@ -464,7 +466,8 @@ static int mmc_busy_cb(void *cb_data, bool *busy)
 	u32 status = 0;
 	int err;
 
-	if (data->busy_cmd != MMC_BUSY_IO && host->ops->card_busy) {
+	if (data->busy_cmd != MMC_BUSY_IO && host->ops->card_busy &&
+			!data->aggregate_err_flags) {
 		*busy = host->ops->card_busy(host);
 		return 0;
 	}
@@ -477,6 +480,9 @@ static int mmc_busy_cb(void *cb_data, bool *busy)
 	if (err)
 		return err;
 
+	if (data->aggregate_err_flags)
+		*data->status = R1_STATUS(*data->status) | status;
+
 	switch (data->busy_cmd) {
 	case MMC_BUSY_CMD6:
 		err = mmc_switch_status_error(host, status);
@@ -549,12 +555,29 @@ int mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
 
 	cb_data.card = card;
 	cb_data.retry_crc_err = retry_crc_err;
+	cb_data.aggregate_err_flags = false;
 	cb_data.busy_cmd = busy_cmd;
 
 	return __mmc_poll_for_busy(host, 0, timeout_ms, &mmc_busy_cb, &cb_data);
 }
 EXPORT_SYMBOL_GPL(mmc_poll_for_busy);
 
+int mmc_poll_for_busy_err_flags(struct mmc_card *card, unsigned int timeout_ms,
+		      bool retry_crc_err, enum mmc_busy_cmd busy_cmd, u32 *status)
+{
+	struct mmc_host *host = card->host;
+	struct mmc_busy_data cb_data;
+
+	cb_data.card = card;
+	cb_data.retry_crc_err = retry_crc_err;
+	cb_data.aggregate_err_flags = true;
+	cb_data.busy_cmd = busy_cmd;
+	cb_data.status = status;
+
+	return __mmc_poll_for_busy(host, 0, timeout_ms, &mmc_busy_cb, &cb_data);
+}
+EXPORT_SYMBOL_GPL(mmc_poll_for_busy_err_flags);
+
 bool mmc_prepare_busy_cmd(struct mmc_host *host, struct mmc_command *cmd,
 			  unsigned int timeout_ms)
 {
diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
index 09ffbc00908b..fc7ec43a78dc 100644
--- a/drivers/mmc/core/mmc_ops.h
+++ b/drivers/mmc/core/mmc_ops.h
@@ -47,6 +47,9 @@ int __mmc_poll_for_busy(struct mmc_host *host, unsigned int period_us,
 			void *cb_data);
 int mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
 		      bool retry_crc_err, enum mmc_busy_cmd busy_cmd);
+int mmc_poll_for_busy_err_flags(struct mmc_card *card, unsigned int timeout_ms,
+		      bool retry_crc_err, enum mmc_busy_cmd busy_cmd,
+		      u32 *status);
 int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 		unsigned int timeout_ms, unsigned char timing,
 		bool send_status, bool retry_crc_err, unsigned int retries);
-- 
2.37.3


Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
Managing Director: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

