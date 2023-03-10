Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8DC6B4B6C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 16:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234381AbjCJPob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 10:44:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234425AbjCJPoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 10:44:05 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40071386AE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 07:31:56 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id m1-20020a05621402a100b004bb706b3a27so3091157qvv.20
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 07:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678462315;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=A8Duh/Zsh4S+kv1rlFybyzg/cDPlN6w2nn2zcQL7LhA=;
        b=G1QvjVFDpfEKlgx9BrRxDddKTWpfqafZE7uilFyCLO1b2UuA7kZgD1VKKaIPFEMOxr
         bYJZM9Gc+gJ09wk6ZQJUbj29V4t3zAI4qoFJFNlaBu426Zt77Qj+gk5Gf81W6p+7ph99
         bwR9SyfABhYXTv+5rsem6w7sCKrhOBinQEUHaXHcghAptwRklXC5sepjLBQ3l+xlsjnr
         YnWLOIBCEFE3pU6ghlWxZd6VDgGsMVnAMx6dQHEe9eVontMiBXXUuWnIJuPV41jDw7+d
         0RpNP8WMexmz6a4T87OqRRAyw+3bFctM4fqc9Py4w4YMrGREZ/cjdkvv0cpSmvp8v+gW
         fs0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678462315;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A8Duh/Zsh4S+kv1rlFybyzg/cDPlN6w2nn2zcQL7LhA=;
        b=zv5TRDR0QgXCd+ViuqNgIeD2LyVfqu5xCEY3/srUnLwhE1vg+CTLJqIbBBLbdtu/mL
         8fA6496If/Wd5n8JFeuCZdf23/xMrHl8TcCsUbQCnsmEW+ozPQYLMlm718vtwkmdEMvQ
         9/GPN4FadlR+vY8u4xPfdKwpivs024md0O3n3KK9J8gOWvAmCUmK4PrHgZeA51FtT92N
         ujI7Z6+7E2Ob8Jo0ieAWVdq0XyUwmS3ut4Ut0qC9qygB6ANiKW7KH0IcCoS5Rr3YTJYf
         VSDU5ruf8baTtB3oUXJOlwWpxk10pEqHwdautg3jTCbhJHG7tNBxk0Phc7XCjn+Uj2yT
         ooxA==
X-Gm-Message-State: AO0yUKWU9CJsNXYDxQF47IcLJUrtNC4xaqbUW/t+jg4kjRBCFWAga9Dc
        KjAn5rbQXfLExkxbmbBRWruG45+SzO9cRlWL
X-Google-Smtp-Source: AK7set8AiueNxyV99oSxmG1FTXMqdtmTpERMv8GkqMOmr0TQNPSQjxAMeLKsp5o3ijmei0/m1Lyaav4tX55S3Xet
X-Received: from zenghuchen.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:2448])
 (user=zenghuchen job=sendgmr) by 2002:a37:9a45:0:b0:742:76a6:8e90 with SMTP
 id c66-20020a379a45000000b0074276a68e90mr892400qke.14.1678462315733; Fri, 10
 Mar 2023 07:31:55 -0800 (PST)
Date:   Fri, 10 Mar 2023 10:31:51 -0500
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230310153151.293608-1-zenghuchen@google.com>
Subject: [PATCH] spi: dw: remove delay between write and read
From:   Jack Chen <zenghuchen@google.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jesus Sanchez-Palencia <jesussanp@google.com>,
        Mark Slevinsky <markslevinsky@google.com>,
        Jack Chen <zenghuchen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delay between write and read in polling mode is not necessary in dw spi
driver. It was added assuming that dw spi controller need the delay to
send data from tx fifo to spi devices. But it is not needed because
following reasons:
1) dw spi datasheet claims transfer begins when first data word is
   present in the transmit FIFO and a slave is enabled. So at least we
   do not need the full fifo-size-transfer time delay.
2) in practice, due to spi devices implementation, spi full-duplex
   (write and read real data) is always split into two transfers.
Delay between spi transfers may be needed. But this can be introduced by
using a more formal helper function "spi_transfer_delay_exec", in which
the delay time is passed by users through spi_ioc_transfer.

Signed-off-by: Jack Chen <zenghuchen@google.com>
---
 drivers/spi/spi-dw-core.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index c3bfb6c84cab..7c10fb353567 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -379,9 +379,12 @@ static void dw_spi_irq_setup(struct dw_spi *dws)
 
 /*
  * The iterative procedure of the poll-based transfer is simple: write as much
- * as possible to the Tx FIFO, wait until the pending to receive data is ready
- * to be read, read it from the Rx FIFO and check whether the performed
- * procedure has been successful.
+ * as possible to the Tx FIFO, then read from the Rx FIFO and check whether the
+ * performed procedure has been successful.
+ *
+ * Delay is introduced in the end of each transfer before (optionally) changing
+ * the chipselect status, then starting the next transfer or completing the
+ * list of @spi_message.
  *
  * Note this method the same way as the IRQ-based transfer won't work well for
  * the SPI devices connected to the controller with native CS due to the
@@ -390,21 +393,12 @@ static void dw_spi_irq_setup(struct dw_spi *dws)
 static int dw_spi_poll_transfer(struct dw_spi *dws,
 				struct spi_transfer *transfer)
 {
-	struct spi_delay delay;
-	u16 nbits;
 	int ret;
 
-	delay.unit = SPI_DELAY_UNIT_SCK;
-	nbits = dws->n_bytes * BITS_PER_BYTE;
-
 	do {
 		dw_writer(dws);
-
-		delay.value = nbits * (dws->rx_len - dws->tx_len);
-		spi_delay_exec(&delay, transfer);
-
 		dw_reader(dws);
-
+		spi_transfer_delay_exec(transfer);
 		ret = dw_spi_check_status(dws, true);
 		if (ret)
 			return ret;
-- 
2.40.0.rc1.284.g88254d51c5-goog

