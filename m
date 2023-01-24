Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5766794B4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 11:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbjAXKEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 05:04:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233705AbjAXKEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 05:04:20 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D2B3EC7B;
        Tue, 24 Jan 2023 02:04:16 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id r9so13320837wrw.4;
        Tue, 24 Jan 2023 02:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C07Sdj5SgC+4bTQhxr8yF2K18bhfSCxMpf1Br4u8+/M=;
        b=a7qtoobVIxAwjxdMt/BthyU3ccigYZFLZ2xxeSed3jIo0aDVlo8EDF+jDw5EFpWnOB
         HXYEjd4cAv9BxL4XKx64iZ1Gz8Rk4u9VMRzKe+ZV8RIFK61sVY16i3R7N/ntK4E86y47
         T74j4E3TkRO7CffrSlzH5aUPpX76mcotpaLwnNX0aRiEtmwakyX2G0ApPTv16w/54fsQ
         11/gr/v7Wbj8tGYlwFsxaHg0lFSK43CfBwnFKw75zy+dHX493b4lbu1dIzX3HCDwok6R
         iEo8oj7pM9bKWDlkn6rEHsgDMb7JAYGZhyDvDPZW38vj3bj7L1LQD5/aYNb/J3WLmU4M
         LK/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C07Sdj5SgC+4bTQhxr8yF2K18bhfSCxMpf1Br4u8+/M=;
        b=U/NWhawNEGQSe5Uwq5LsymM5c/7YsNGG2hVZAwVZ2ua8cua4tiZ4v6EH9pRBphox5l
         arF3CNWlyv4S3DQhPlGTDrcfYhHgNAJxZH4PUSl/v68Z6gcW9wJgl7BTdqcz9A3Aj9tS
         Dq/+UncxmzmoUTaxc/z0xOYBfk3o3pC4JRX9r7c1xNHVcTFsyYW1JyXLCvXkc2ga7gcy
         agJhV6b7W3ceUZ7awT7QXm5gIUpU9qemvaCwhlJ8Yf9wFQmBG/bEXeAFhd3GNO7WAE0v
         889FnG/mwqo3zT3citxzgquKg9r+FyFvfOqSE3newmDHaHEuJbK13raeFIVd3WHA/K+6
         faTQ==
X-Gm-Message-State: AFqh2kqlbieV6uxE3zFu2KhptYzEsB/7eKyHU0b1fPRKpn9NzldPu7H5
        i06tF0rmwXcfmovm0r83wQw=
X-Google-Smtp-Source: AMrXdXtSX600y9yX9q1xMcVZ9eQp8dKJQEZC+hSjWrcMzjUx4Frpc2/Tl6sFwQF1sJipV65ZrjQD+Q==
X-Received: by 2002:adf:ec4f:0:b0:2bd:ffc1:3f16 with SMTP id w15-20020adfec4f000000b002bdffc13f16mr24414099wrn.8.1674554654776;
        Tue, 24 Jan 2023 02:04:14 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id t20-20020adfa2d4000000b002bdcce37d31sm1758731wra.99.2023.01.24.02.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 02:04:14 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Haibo Chen <haibo.chen@nxp.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] iio: adc: imx93: Fix spelling mistake "geting" -> "getting"
Date:   Tue, 24 Jan 2023 10:04:13 +0000
Message-Id: <20230124100413.684416-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

Thrre is a spelling mistake in a dev_err_probe message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/iio/adc/imx93_adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/imx93_adc.c b/drivers/iio/adc/imx93_adc.c
index d8de8284e13d..a775d2e40567 100644
--- a/drivers/iio/adc/imx93_adc.c
+++ b/drivers/iio/adc/imx93_adc.c
@@ -315,7 +315,7 @@ static int imx93_adc_probe(struct platform_device *pdev)
 	adc->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(adc->regs))
 		return dev_err_probe(dev, PTR_ERR(adc->regs),
-				     "Failed geting ioremap resource\n");
+				     "Failed getting ioremap resource\n");
 
 	/* The third irq is for ADC conversion usage */
 	adc->irq = platform_get_irq(pdev, 2);
-- 
2.30.2

