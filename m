Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9128A6E588D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 07:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjDRF3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 01:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjDRF3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 01:29:14 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B0E5245
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 22:29:13 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-552f169d85eso27237227b3.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 22:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681795752; x=1684387752;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nKDaeGp5EKkZDqIsokus1OmDmfvkWgZNrRNY08uRrUc=;
        b=FYeN9SBMek5PY0NUGiKB4PDLSCJlT+j7HehxrNt6HMPnXxkb2hDFelKYyUgKjiziLJ
         tVL1u6x5vxXSoC1takibB3sIH8S5a4H/zcAlUkmwd/KdiZUbajfB7BLtA9HeauREN51e
         nXpSIgJ6Rhyfs8s9UE+1sdCU+RjVrt24eppqDajoloeN9DjHFI1gZzPGdoKCX21oevkM
         7BV4SlPWznZ6RPNiZJQNSzTfqp5FCxtuyrMusF6mbwi3CATBxDGXZAtz2m1Bj2gtnO1D
         rn6UAwLmvLFoSrIo1NjxrVFRxc7oNUiE8XEtQ3ICRudfANtgmGOv/eB+zA6LPING2H7J
         jDGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681795752; x=1684387752;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nKDaeGp5EKkZDqIsokus1OmDmfvkWgZNrRNY08uRrUc=;
        b=dALqd+OYa5KhdCJ4l9bO8MFBfL4Rf2Huoh7cbITabWYfnWc46hsGTWpNlLZnGCZXai
         bh46ajGmebyD6tJNUwFdzwZfhxH7gyTPZP60czBs3zyjL6Ggcp5Okw0lCZ4GHRweA4Rw
         QvwmMQlJyig5QfWXgloU5lC2thU29DXNqQmSqHbRYx2Oub9NmIh0iuJwc04DbAKw8fI0
         dlb2v0CixSHjcDjz5qxb5KfetRF9XEhtVQqw6PqGonLcW74PU/eZ8whjqu4Iq399k0fM
         iqqQ1jp/bonBjj3fSu8UOXMICVrUHS/Mh9O6rrPpDpq9+0HuxQTi4dM3ABpO7iMpBOrA
         yNxw==
X-Gm-Message-State: AAQBX9ezczfHePAA/98mZ0nOwtMuE72y5ooqaJhU+uhQRuMOy5eHhni4
        RzLME+OQv3te4hCiqWtm2MkT0iTU7/L26g==
X-Google-Smtp-Source: AKy350bdIBV7qoBsvNLSgcYeJ9hwtBweLbKLDpYB3err3fbJEZWBFuD+8dThBnEI018wEnGEF+V/2UF5MBTiIQ==
X-Received: from joychakr.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:6ea])
 (user=joychakr job=sendgmr) by 2002:a81:ac57:0:b0:54d:3afc:d503 with SMTP id
 z23-20020a81ac57000000b0054d3afcd503mr11607964ywj.8.1681795752753; Mon, 17
 Apr 2023 22:29:12 -0700 (PDT)
Date:   Tue, 18 Apr 2023 05:28:58 +0000
In-Reply-To: <20230418052902.1336866-1-joychakr@google.com>
Mime-Version: 1.0
References: <20230418052902.1336866-1-joychakr@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230418052902.1336866-2-joychakr@google.com>
Subject: [PATCH v7 1/5] spi: dw: Add 32 bpw support to SPI DW DMA driver
From:   Joy Chakraborty <joychakr@google.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        manugautam@google.com, rohitner@google.com,
        Joy Chakraborty <joychakr@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Support for AxSize = 4 bytes configuration from dw dma driver if
n_bytes i.e. number of bytes per write to fifo is 4.

Number of bytes written to fifo per write is depended on the bits/word
configuration being used which the DW core driver translates to n_bytes.
Hence, for bits per word values between 17 and 32 n_bytes should be
equal to 4.

Signed-off-by: Joy Chakraborty <joychakr@google.com>
---
 drivers/spi/spi-dw-dma.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
index ababb910b391..c1b42cb59965 100644
--- a/drivers/spi/spi-dw-dma.c
+++ b/drivers/spi/spi-dw-dma.c
@@ -208,12 +208,16 @@ static bool dw_spi_can_dma(struct spi_controller *master,
 
 static enum dma_slave_buswidth dw_spi_dma_convert_width(u8 n_bytes)
 {
-	if (n_bytes == 1)
+	switch (n_bytes) {
+	case 1:
 		return DMA_SLAVE_BUSWIDTH_1_BYTE;
-	else if (n_bytes == 2)
+	case 2:
 		return DMA_SLAVE_BUSWIDTH_2_BYTES;
-
-	return DMA_SLAVE_BUSWIDTH_UNDEFINED;
+	case 4:
+		return DMA_SLAVE_BUSWIDTH_4_BYTES;
+	default:
+		return DMA_SLAVE_BUSWIDTH_UNDEFINED;
+	}
 }
 
 static int dw_spi_dma_wait(struct dw_spi *dws, unsigned int len, u32 speed)
-- 
2.40.0.634.g4ca3ef3211-goog

