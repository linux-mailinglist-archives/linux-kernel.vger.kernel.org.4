Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBEA6CFBB2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 08:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjC3GfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 02:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjC3GfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 02:35:06 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6033265A9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 23:35:05 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5461fe3163eso47452037b3.17
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 23:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680158104;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=H4XJD2H+uA3ZKVf/qBdJwtkZFmjUhMkPOEUkmWMqpBE=;
        b=Fn5nnpbCOqBGSCpvePohnp/LYXOjlaWyo7dClBiDjwYsGEcWQ/l24kYPZjE1EA8ngm
         RkYCCh4kL4ZEMCizgZQ/voC6sL0VmFhq2HhEl6N+gWOBN/Ok/DgHzco/sRSHyoNA+VcX
         9C6aCIfP/r8LNxtZzhZuhu5dy8hME1X3ZAsGgThTduXqQlSnbtoswTCT5E7d55XMgndU
         l5MG8vSAYejEWCYqFcCiVHTc0LQgV0wQmj5Bn0WBmzciR9Og9Qowznh3hxidgUutMU+K
         LHC85PCMzqdTCz3ZYtvV9NYVT6GMkk542OpQqvQtz37DwEnSgoaF3uB/t5siQpw8/T+/
         G68A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680158104;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H4XJD2H+uA3ZKVf/qBdJwtkZFmjUhMkPOEUkmWMqpBE=;
        b=RYEPIk7b25mUAYE1sEIZJ+aZ4ommqDcSQjssrA6lCC86OSjzieTKwWCtCbPRlsfz37
         ad3iYedhMc4Mg9gmgbEKANsSXrFA++HStT7UpO7dk8ISpJynuApkfepVq/mYu0stsS41
         hTEjZSTOupqMZgTERGo5pRdTpNt4L6opVMH73vrxgDQJGJ5kzlFYVzofwmYJN3crkW/P
         lm9jgEtQhM1l8xG7/uc7zB1zzrDlGRiS5HNiOQSCHX19+nJiYBmH8+B8u+pDkBebbmj6
         cHYN592eJgwIJlovU/7KYkF8aC5GCX7tXuxyPyTQZtJg/uHaUWYTgW99+p+mapx/d/fH
         q/LQ==
X-Gm-Message-State: AAQBX9e/O2pYhCyzX4upL/mIHhAtckoa1NE/KfmdRwVJxnHgPyLM5H9z
        lTJ5XFzoHr+DJVddQAvGJ6FdYhyxViTyCw==
X-Google-Smtp-Source: AKy350bRT0Ms2Z3jxE4kPUj+uZn7qs77IKyFYsz+wI65LRZonct3i2E36PW1+Mfv5NciFXEAZDYfOOGdC11ZOQ==
X-Received: from joychakr.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:6ea])
 (user=joychakr job=sendgmr) by 2002:a81:4410:0:b0:545:a7d8:f278 with SMTP id
 r16-20020a814410000000b00545a7d8f278mr10413624ywa.5.1680158104432; Wed, 29
 Mar 2023 23:35:04 -0700 (PDT)
Date:   Thu, 30 Mar 2023 06:34:49 +0000
In-Reply-To: <20230330063450.2289058-1-joychakr@google.com>
Mime-Version: 1.0
References: <20230330063450.2289058-1-joychakr@google.com>
X-Mailer: git-send-email 2.40.0.423.gd6c402a77b-goog
Message-ID: <20230330063450.2289058-2-joychakr@google.com>
Subject: [PATCH v5 1/2] spi: dw: Add 32 bpw support to DW DMA Controller
From:   Joy Chakraborty <joychakr@google.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        manugautam@google.com, rohitner@google.com,
        Joy Chakraborty <joychakr@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Support for AxSize = 4 bytes configuration from dw dma driver if
n_bytes i.e. number of bytes per write to fifo is 3 or 4.

Number of bytes written to fifo per write is depended on the bits/word
configuration being used which the DW core driver translates to n_bytes.

Signed-off-by: Joy Chakraborty <joychakr@google.com>
---
 drivers/spi/spi-dw-dma.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
index ababb910b391..b3a88bb75907 100644
--- a/drivers/spi/spi-dw-dma.c
+++ b/drivers/spi/spi-dw-dma.c
@@ -208,12 +208,17 @@ static bool dw_spi_can_dma(struct spi_controller *master,
 
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
+	case 3:
+	case 4:
+		return DMA_SLAVE_BUSWIDTH_4_BYTES;
+	default:
+		return DMA_SLAVE_BUSWIDTH_UNDEFINED;
+	}
 }
 
 static int dw_spi_dma_wait(struct dw_spi *dws, unsigned int len, u32 speed)
-- 
2.40.0.423.gd6c402a77b-goog

