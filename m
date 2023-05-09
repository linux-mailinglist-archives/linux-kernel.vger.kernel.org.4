Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 156646FC19F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 10:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjEIIXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 04:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjEIIW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 04:22:57 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83285FD2
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 01:22:55 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-55a42c22300so91021157b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 01:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683620575; x=1686212575;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=P/eUVtluKbHYoh34+9oF2eiC1PMtH+2gVKFzulzf0Dc=;
        b=MOl/ueia/VczvDyjT3T7HYTqdbT3tGq7e/qZgsdHLgfTJc6xduTdB70L6CR+tIEKXC
         6EXTVk126gPItF25Of5O7fVF6UVJFXoeDtJSh85kNratW2ypIYLNIcEJhsWOoD3DwPIA
         73gEFnRt9TduebE6GB+/AE02x6hmYT/i305jrOYJ7/i8E2Ts0HH5E1K8nZgHMVItEzpm
         rWj/3GYLmUzCBiQi1vnGi9jxqMp/fjSVJvegrBlGq8b/qE3OUi6WL2s6MTPgOlrKkeu6
         rHrumiATgCHtZa5kExrL9Vu39ZtlDuG8EJJ4C58nMpDZBxy66RKeTFPDH7GkKELaTrDC
         9Qdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683620575; x=1686212575;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P/eUVtluKbHYoh34+9oF2eiC1PMtH+2gVKFzulzf0Dc=;
        b=c1yZD/rtJh50444cbmS/Yek/xto4kjPRlxR6FESnXk1Rkm/QXsSa+AYFEu7/A+lUHm
         L6DkBvONalLVpu7IJPet8s814waTdY32H0YZPdVJ2z5GgBJYfGShihqMVGTzKelxUO8Z
         KB5HvxijJO9K+7Rg+zHdXdy6IRXiVy5+jtK7PXqtfMseWHTvvfHPN8W3Npk3PR36ejsA
         M+IlqML0Gt8/5ZIBj+O8gRdpf1gH4eGhW8BNQFacZLj7TZ23ob37IIRi/MsjNHxR6Qne
         mMYgr4l9xUfh55Bikgm+u2/3BC9ZVlLiTP20vvRqxhVfkoONT5+e52uJxJJZ7E67h411
         PX6w==
X-Gm-Message-State: AC+VfDz3Tp227gCUzIuRWrbw3IkJ7hS+STDL1RQmHC5lRKtznozsEx3N
        h+2Nlg3Z+Dqurbnw7loyX265s/zvFOKBow==
X-Google-Smtp-Source: ACHHUZ72r07bzH9ZI2xUXLXjt1CeDUp9wNAwqxvMJdxU7UmmLTiT1J/9vdLM6ETrDRpdjDs98h/5u++Ew5M7jA==
X-Received: from joychakr.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:6ea])
 (user=joychakr job=sendgmr) by 2002:a81:b65a:0:b0:55a:8e39:57a7 with SMTP id
 h26-20020a81b65a000000b0055a8e3957a7mr7726750ywk.6.1683620575080; Tue, 09 May
 2023 01:22:55 -0700 (PDT)
Date:   Tue,  9 May 2023 08:22:40 +0000
In-Reply-To: <20230509082244.1069623-1-joychakr@google.com>
Mime-Version: 1.0
References: <20230509082244.1069623-1-joychakr@google.com>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
Message-ID: <20230509082244.1069623-2-joychakr@google.com>
Subject: [PATCH v10 1/5] spi: dw: Add 32 bpw support to SPI DW DMA driver
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
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Tested-by: Serge Semin <fancer.lancer@gmail.com>
* tested on Baikal-T1 based system with DW SPI-looped back interface
transferring a chunk of data with DFS:8,12,16.
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
2.40.1.521.gf1e218fcd8-goog

