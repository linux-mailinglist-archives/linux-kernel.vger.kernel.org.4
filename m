Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2BDA5EC12B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 13:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbiI0LYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 07:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbiI0LXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 07:23:12 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8EF412DEEC;
        Tue, 27 Sep 2022 04:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1664277718;
  x=1695813718;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hzApWBA3xTSZ1v8riDwMfzZx6pC2MkanA6btQmoyo+8=;
  b=dOMu+tMOOmvqqaVKoHdkBirhl/BpFE/xTb0qx9wJ3kItP7ZiHMMDZ7uN
   C5d9Aqv/BGne+2rvmUTLNRLWPANDWah/YxDRUCsKg6vDzDFKyqA6tyNyp
   pQzubNezNmCE9GD5hjEPyeb83LZP4+KoGDGHkORoeequpO/5jegPSyNZX
   l8NwT3szcVAUYQS4wY1SRT62dycXSTMTXXwilfmxtvpFyOgLtz5suKJtk
   r7XLEKuPxMZQf+436+UjLqxpcP/79o2leQnhOa+cOpnFbnnNScObypfrg
   AHgUw72RwVTSDrQFvLxlrTbyrL+UpBeTnMvso+O8k37LREDsA2Tug7+FZ
   A==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <broonie@kernel.org>, <krzysztof.kozlowski@linaro.org>,
        <andi@etezian.org>
CC:     <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <alim.akhtar@samsung.com>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 3/4] spi: Split transfers larger than max size
Date:   Tue, 27 Sep 2022 13:21:16 +0200
Message-ID: <20220927112117.77599-4-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220927112117.77599-1-vincent.whitchurch@axis.com>
References: <20220927112117.77599-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A couple of drivers call spi_split_transfers_maxsize() from their
->prepare_message() callbacks to split transfers which are too big for
them to handle.  Add support in the core to do this based on
->max_transfer_size() to avoid code duplication.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/spi/spi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index f41a8c2752b8..44e4352d948b 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1649,6 +1649,15 @@ static int __spi_pump_transfer_message(struct spi_controller *ctlr,
 
 	trace_spi_message_start(msg);
 
+	ret = spi_split_transfers_maxsize(ctlr, msg,
+					  spi_max_transfer_size(msg->spi),
+					  GFP_KERNEL | GFP_DMA);
+	if (ret) {
+		msg->status = ret;
+		spi_finalize_current_message(ctlr);
+		return ret;
+	}
+
 	if (ctlr->prepare_message) {
 		ret = ctlr->prepare_message(ctlr, msg);
 		if (ret) {
-- 
2.34.1

