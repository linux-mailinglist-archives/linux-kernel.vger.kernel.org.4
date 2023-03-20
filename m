Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0B396C0A4D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 06:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjCTF6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 01:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjCTF6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 01:58:23 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC001C590
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 22:58:22 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-544b71b3114so101682367b3.13
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 22:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679291901;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5UZlQUAmu7strlARsPQbQHPgHSDO20yOQ6kUECkItXc=;
        b=ZGoucMXzkK8RqTMy7kBVUHeV2x3N35UO0fn9jRYc+Wjus9NaoUiSWkJaajLEQfHP3M
         ju46UGN9iptwq1DJfcGaJnVRvdpuAANsUenZ5jhM+EzRz7v6kbz8UWrXS9vpB84gmRgn
         7Pt2oHhruERAujOw5jkT+D2jD124DQVdCFLb3VxaMGYeIXMlU3NKl4eXZbKoadiEhl1g
         840EERPWrEUBTmUt91m1oBAvMO1cpG15MZIV78pnQNzyMP0DEC7bKWgRTA+UIJ8Ypnn0
         sPn8vV5VJMLc5bR9vdaRFKs5soo4RWPR0TnxJ7OSmGFfKbrSfWPOObbHGmLs7UeXvxsm
         Bjow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679291901;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5UZlQUAmu7strlARsPQbQHPgHSDO20yOQ6kUECkItXc=;
        b=3R8UcEhRSbS2joKtMgffJsFl6Q5HKevdLnie0aQpvflnUqsM4gPDX65xJLjGWFTAVG
         nrZMFu9q28bW8xTDUYi0HyrcM2ER1XufLNmMjmiwC1OXuuVF0F7uYl3MaO14I4KXOvR9
         514b/z5o038IGj8GNhAbmS2OCN9lMrwom0u+jxT0wR5JT3QtSSP9GGwaXEZa9grQhNVQ
         8cO5YPnvkxw5Re59IJaXEfVxQOEDWjKqvKEN7HaWs51cJ+ffNW3ahWX3RfPeKI/LwULj
         1p9OaVd4NF7FZ11t3ytSmR8y1uFDitBgnzGCBDF+Xv15xXT5gHp/kJGqjMh+fBhf1H1x
         ROzA==
X-Gm-Message-State: AO0yUKUw8QQUTs2+ZBxBnqYhUtUILEtxLQj4BfvYKYk1X/YFBM6Jr+Yl
        95qnXlfrm/ZFo/H2be1mZaYH8o0Ubv/mBA==
X-Google-Smtp-Source: AK7set+nCDJUhjO0aH6klS1AcaaKBfdu8k/5XOJdgDGap93IxiuCeVGu10fygFL9aE8M5FdViwz9Q7T2gaqGjA==
X-Received: from joychakr.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:6ea])
 (user=joychakr job=sendgmr) by 2002:a5b:9d0:0:b0:b46:4a5e:365f with SMTP id
 y16-20020a5b09d0000000b00b464a5e365fmr4714335ybq.8.1679291901466; Sun, 19 Mar
 2023 22:58:21 -0700 (PDT)
Date:   Mon, 20 Mar 2023 05:57:46 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230320055746.2070049-1-joychakr@google.com>
Subject: [PATCH] spi: dw: Add 32 bpw support to DW DMA Controller
From:   Joy Chakraborty <joychakr@google.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        manugautam@google.com, rohitner@google.com,
        Joy Chakraborty <joychakr@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If DW Controller is capable of 32 bits per word support then SW or DMA
controller has to write 32bit or 4byte data to the FIFO at a time.

This Patch adds support for AxSize = 4 bytes configuration from dw dma
driver if n_bytes i.e. number of bytes per write to fifo is 4.

Signed-off-by: Joy Chakraborty <joychakr@google.com>
---
 drivers/spi/spi-dw-dma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
index ababb910b391..7d06ecfdebe1 100644
--- a/drivers/spi/spi-dw-dma.c
+++ b/drivers/spi/spi-dw-dma.c
@@ -212,6 +212,8 @@ static enum dma_slave_buswidth dw_spi_dma_convert_width(u8 n_bytes)
 		return DMA_SLAVE_BUSWIDTH_1_BYTE;
 	else if (n_bytes == 2)
 		return DMA_SLAVE_BUSWIDTH_2_BYTES;
+	else if (n_bytes == 4)
+		return DMA_SLAVE_BUSWIDTH_4_BYTES;
 
 	return DMA_SLAVE_BUSWIDTH_UNDEFINED;
 }
-- 
2.40.0.rc1.284.g88254d51c5-goog

