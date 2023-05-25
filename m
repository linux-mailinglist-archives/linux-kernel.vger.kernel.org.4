Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A2A71094F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 11:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240728AbjEYJ4Q convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 25 May 2023 05:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240696AbjEYJ4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 05:56:13 -0400
Received: from mail5.swissbit.com (mail5.swissbit.com [148.251.244.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C2941A1;
        Thu, 25 May 2023 02:56:07 -0700 (PDT)
Received: from mail5.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 39D033A1F6E;
        Thu, 25 May 2023 11:56:06 +0200 (CEST)
Received: from mail5.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 2581F3A1F1A;
        Thu, 25 May 2023 11:56:06 +0200 (CEST)
X-TM-AS-ERS: 10.181.10.102-127.5.254.253
X-TM-AS-SMTP: 1.0 bXgyLmRtei5zd2lzc2JpdC5jb20= Y2xvZWhsZUBoeXBlcnN0b25lLmNvb
        Q==
X-DDEI-TLS-USAGE: Used
Received: from mx2.dmz.swissbit.com (mx2.dmz.swissbit.com [10.181.10.102])
        by mail5.swissbit.com (Postfix) with ESMTPS;
        Thu, 25 May 2023 11:56:06 +0200 (CEST)
From:   Christian Loehle <CLoehle@hyperstone.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
CC:     Avri Altman <avri.altman@wdc.com>
Subject: [PATCHv2 1/2] mmc: block: ioctl: do write error check for spi
Thread-Topic: [PATCHv2 1/2] mmc: block: ioctl: do write error check for spi
Thread-Index: AdmO7rHviS91U1oAQZuuTphsBGwqww==
Date:   Thu, 25 May 2023 09:56:04 +0000
Message-ID: <55920f880c9742f486f64aa44e25508e@hyperstone.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-9.0.1002-27648.006
X-TMASE-Result: 10--4.065800-10.000000
X-TMASE-MatchedRID: ktgZsDp28T8DFgoHQs6fmr3+Qwz7LRxRIQTCbSdwtuLAuQ0xDMaXkH4q
        tYI9sRE/7wJL2+8U4LGdvqdyyw/iEE5gqNn1dvU1zr16YOzjZ100YL9SJPufXyxMw0FMkBlZ1Oc
        bCqcD38mHDkT9mJ2wf7U4DFGRfvg/lwV2iaAfSWf+xOhjarOnHmVV1G+Ck2l7+gtHj7OwNO0UQC
        QtpNwWeprn8sNK/mnnWzV3P5Z+pOyDhg8vyIWpG6Qdb7n0u0KZ
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: f78f32c9-a9c6-45b6-a790-0f36f2e56b7b-0-0-200-0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SPI doesn't have the usual PROG path we can check for error bits
after moving back to TRAN. Instead it holds the line LOW until
completion. We can then check if the card shows any errors or
is in IDLE state, indicating the line is no longer LOW because
the card was reset.

Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
---
 drivers/mmc/core/block.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index d920c4178389..e46330815484 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -178,6 +178,7 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
 			       int recovery_mode,
 			       struct mmc_queue *mq);
 static void mmc_blk_hsq_req_done(struct mmc_request *mrq);
+static int mmc_spi_err_check(struct mmc_card *card);
 
 static struct mmc_blk_data *mmc_blk_get(struct gendisk *disk)
 {
@@ -608,6 +609,11 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 	if ((card->host->caps & MMC_CAP_WAIT_WHILE_BUSY) && use_r1b_resp)
 		return 0;
 
+	if (mmc_host_is_spi(card->host)) {
+		if (idata->ic.write_flag || r1b_resp || cmd.flags & MMC_RSP_SPI_BUSY)
+			return mmc_spi_err_check(card);
+		return err;
+	}
 	/* Ensure RPMB/R1B command has completed by polling with CMD13. */
 	if (idata->rpmb || r1b_resp)
 		err = mmc_poll_for_busy(card, busy_timeout_ms, false,
-- 
2.37.3


Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
Managing Director: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

