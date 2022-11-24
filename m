Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBCC6372FB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 08:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiKXHkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 02:40:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiKXHkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 02:40:23 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB98A92B4F;
        Wed, 23 Nov 2022 23:40:22 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id g5so738131pjd.4;
        Wed, 23 Nov 2022 23:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ntQsNf8zm4lWqRn9BkJdl7bMzEje8hk+raBCmuyyoyU=;
        b=EvZ6sxVvHZ9FNiVlfhZ/0/wKev71SxwmYh95TK9nvnWUG+OMIoROivIDj8dVWhDa+x
         VGpsJq2hDbmkutZzF6jkmMhH/klb4eTsTr9Rq5jb1Y8dFKJ1Zf6IJA7rUVwZGcpjCr9+
         Mjd6J3ScIudfUXNm1YokAmG5qEmA/g3DNIwRIoICX7QUuhdA/FBz1XzotcWmUo3rCuu+
         sMAugdQQv0jmujoGkCA8KHRRgs91f1Lia0SIotMECvMsUv3a1UBmXkPvqPd2y6mWvbCE
         G6hz0E7wIrD/N+Pny8p+0BwMQo38q/ID41PUaHwCCJd9CTQWObRo8aPmWEfbvQLHAYfB
         Q4eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ntQsNf8zm4lWqRn9BkJdl7bMzEje8hk+raBCmuyyoyU=;
        b=sDmnQ23YB6tR7KH5Euk8tEmDRIB149wntgnlO+c9kbR8AU0VAlg9wMbMt4A+pYv45u
         RItyul1qucVC+91YICEWr6CMHCPT5IL+Wjoz4sH+DAWTUqgepqiHqiNa5+Q+oFH7qc/i
         6TF66hRlbEu07GxLERYA3XuZAmyfG9hX20Z0t9QaIWezgmbYpCOZFS04KEfY+4OOBnGD
         jH91XQ2pcP0jWt70QP2S+SYVdGztqpmzs0m3tsBQznGZxmiOALhFyrwwmR4j7iviuQER
         WNM16cEfg4w1eJejkcqJgdrA0MuDvz/POdiNXrrDKiWcaCDy79TneoMWjaYejxBHM/tU
         i/bg==
X-Gm-Message-State: ANoB5pnb7nrIDl2VvD07eE8+Ta7ELRS8sQnO36UHCaKFkq1+lsKDo3db
        bHqEKLRyNET692UkFd1W2s0=
X-Google-Smtp-Source: AA0mqf6txd8G8TMjLTc+inFFt3+nKiIE+X5oYL0KbcUpFbeHVw3oBinDWQkBU52BYlt6vJOKmAMOIQ==
X-Received: by 2002:a17:902:ab8b:b0:176:7852:dae3 with SMTP id f11-20020a170902ab8b00b001767852dae3mr12403977plr.25.1669275622506;
        Wed, 23 Nov 2022 23:40:22 -0800 (PST)
Received: from localhost.localdomain ([123.51.145.88])
        by smtp.gmail.com with ESMTPSA id s5-20020a632c05000000b0047781f8ac17sm503143pgs.77.2022.11.23.23.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 23:40:22 -0800 (PST)
From:   JaimeLiao <jaimeliao.tw@gmail.com>
To:     broonie@kernel.org, krzysztof.kozlowski@linaro.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jaimeliao@mxic.com.tw, JaimeLiao <jaimeliao.tw@gmail.com>
Subject: [PATCH v1 1/2] spi: spi-rpc-if: Add support for Octal DTR mode
Date:   Thu, 24 Nov 2022 15:39:56 +0800
Message-Id: <20221124073957.22471-2-jaimeliao.tw@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221124073957.22471-1-jaimeliao.tw@gmail.com>
References: <20221124073957.22471-1-jaimeliao.tw@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Octal DTR mode support

Signed-off-by: JaimeLiao <jaimeliao.tw@gmail.com>
---
 drivers/spi/spi-rpc-if.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-rpc-if.c b/drivers/spi/spi-rpc-if.c
index 24ec1c83f379..f2c365c10610 100644
--- a/drivers/spi/spi-rpc-if.c
+++ b/drivers/spi/spi-rpc-if.c
@@ -26,10 +26,20 @@ static void rpcif_spi_mem_prepare(struct spi_device *spi_dev,
 	rpc_op.cmd.opcode = spi_op->cmd.opcode;
 	rpc_op.cmd.buswidth = spi_op->cmd.buswidth;
 
+	if (spi_op->cmd.dtr) {
+		rpc_op.cmd.opcode = spi_op->cmd.opcode >> 8;
+		rpc_op.ocmd.opcode = spi_op->cmd.opcode;
+		rpc_op.ocmd.buswidth = spi_op->cmd.buswidth;
+		rpc_op.cmd.ddr = spi_op->cmd.dtr;
+		rpc_op.ocmd.ddr = spi_op->cmd.dtr;
+	}
+
 	if (spi_op->addr.nbytes) {
 		rpc_op.addr.buswidth = spi_op->addr.buswidth;
 		rpc_op.addr.nbytes = spi_op->addr.nbytes;
 		rpc_op.addr.val = spi_op->addr.val;
+		if (spi_op->addr.dtr)
+			rpc_op.addr.ddr = spi_op->addr.dtr;
 	}
 
 	if (spi_op->dummy.nbytes) {
@@ -41,6 +51,8 @@ static void rpcif_spi_mem_prepare(struct spi_device *spi_dev,
 	if (spi_op->data.nbytes || (offs && len)) {
 		rpc_op.data.buswidth = spi_op->data.buswidth;
 		rpc_op.data.nbytes = spi_op->data.nbytes;
+		if (spi_op->data.dtr)
+			rpc_op.data.ddr = spi_op->data.dtr;
 		switch (spi_op->data.dir) {
 		case SPI_MEM_DATA_IN:
 			rpc_op.data.dir = RPCIF_DATA_IN;
@@ -67,8 +79,8 @@ static bool rpcif_spi_mem_supports_op(struct spi_mem *mem,
 	if (!spi_mem_default_supports_op(mem, op))
 		return false;
 
-	if (op->data.buswidth > 4 || op->addr.buswidth > 4 ||
-	    op->dummy.buswidth > 4 || op->cmd.buswidth > 4 ||
+	if (op->data.buswidth > 8 || op->addr.buswidth > 8 ||
+	    op->dummy.buswidth > 8 || op->cmd.buswidth > 8 ||
 	    op->addr.nbytes > 4)
 		return false;
 
@@ -153,7 +165,8 @@ static int rpcif_spi_probe(struct platform_device *pdev)
 	ctlr->mem_ops = &rpcif_spi_mem_ops;
 
 	ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
-	ctlr->mode_bits = SPI_CPOL | SPI_CPHA | SPI_TX_QUAD | SPI_RX_QUAD;
+	ctlr->mode_bits = SPI_CPOL | SPI_CPHA | SPI_TX_QUAD | SPI_RX_QUAD |
+			  SPI_TX_OCTAL | SPI_RX_OCTAL;
 	ctlr->flags = SPI_CONTROLLER_HALF_DUPLEX;
 
 	error = rpcif_hw_init(rpc, false);
-- 
2.17.1

