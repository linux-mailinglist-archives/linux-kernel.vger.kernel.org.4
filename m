Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F33DF707577
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 00:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjEQWa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 18:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjEQWav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 18:30:51 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612915B90;
        Wed, 17 May 2023 15:30:45 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-50bcb00a4c2so2051931a12.1;
        Wed, 17 May 2023 15:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684362644; x=1686954644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/FsOd9MgDJMeorWa734Iw1cUVj+gA3xOrUBWqtCM238=;
        b=WXWxpAqBqkNlEFcfyF2Ee70k3+pxEhMzzuphULcqCPUNbH3ndOPuPFndR6cpporZj9
         iADBSwww9yeXUIPNa6sSE37RZOQca9iZLfXmLZ9YmXn5TCpEmbKBBwfPyG9tSHUDhlRR
         Y5zbSzo3BtraV4d2UA4VPfrTholfMSaso+P4Y/PhVT4P/ccvmn8GDg39cEe290YxK3FD
         by/bMBKqfGEkd3soVH38aiWeCYsT2tXW7XwB/2+zvHtnvoSE3hovkbow+OmSXRysIhEq
         mgbXTpOoVgvCat0mlnstOc6B29pvP1F50roIQ1NtF5BY0E2ruHiCor1uxrsSMILfE7Jy
         jUPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684362644; x=1686954644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/FsOd9MgDJMeorWa734Iw1cUVj+gA3xOrUBWqtCM238=;
        b=eTwzY5sPY4E579HLb/XSgtbDkfQzxypXm4+S5X6Ue3v11RCHdLmdxCylQm+bPhs1ue
         GP3rpBx/2rJpKeqEHhV4Qh82M0fXl6ykE2VBkHhURIkhfNFgZi2BaoHW6u07OStS+rmg
         AqREhXp8h+g27Znpc0P3ZhooWbjXe1VRZyHZsIpNWaT5H9OWKhwOXWLEMJjt+SRsGf4v
         vk4fsvojWXfUQdF+9Y3bC+3F5zBBGjk0TOJ5HJ5V6yvZ5yAvNkZH/cX120FYE904Y0O1
         +xSCXXvOYrNhAKt8ELQJdVqJKKkk0bDamlRNU+xN28pwMa/cyEwE3lGItA5we5cQIzG5
         8IoQ==
X-Gm-Message-State: AC+VfDww0R0RDFdIIRAEJtWTY5kX/1lNCjedHcLHqlFBJ9BboqprOsnz
        TYW2V4GG6Sngx/5MFQLY/rM=
X-Google-Smtp-Source: ACHHUZ46OihSG/weHkolyoeQYmK0Y48BG6k3h3k5KmA9VqqYe04BC1s8KpET4pkwKZ8MOQHjZv3nXA==
X-Received: by 2002:a17:907:2d1f:b0:968:db2f:383 with SMTP id gs31-20020a1709072d1f00b00968db2f0383mr31445004ejc.53.1684362643725;
        Wed, 17 May 2023 15:30:43 -0700 (PDT)
Received: from wslxew193.fritz.box (p200300c78700c900633510ddc4028dcd.dip0.t-ipconnect.de. [2003:c7:8700:c900:6335:10dd:c402:8dcd])
        by smtp.gmail.com with ESMTPSA id y14-20020a1709064b0e00b0095807ab4b57sm109327eju.178.2023.05.17.15.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 15:30:43 -0700 (PDT)
From:   Boerge Struempfel <boerge.struempfel@gmail.com>
Cc:     boerge.struempfel@gmail.com, bstruempfel@ultratronik.de,
        andy.shevchenko@gmail.com, festevam@gmail.com,
        amit.kumar-mahapatra@amd.com, broonie@kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/3] spi: spi-imx: add support for SPI_MOSI_IDLE_LOW mode bit
Date:   Thu, 18 May 2023 00:30:06 +0200
Message-Id: <20230517223007.178432-2-boerge.struempfel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230517223007.178432-1-boerge.struempfel@gmail.com>
References: <20230517223007.178432-1-boerge.struempfel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default, the spi-imx controller pulls the mosi line high, whenever it
is idle. This behaviour can be inverted per CS by setting the
corresponding DATA_CTL bit in the config register of the controller.

Also, since the controller mode-bits have to be touched anyways, the
SPI_CPOL and SPI_CPHA are replaced by the combined SPI_MODE_X_MASK flag.

Signed-off-by: Boerge Struempfel <boerge.struempfel@gmail.com>
---
 drivers/spi/spi-imx.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 34e5f81ec431..1c4172fcba2d 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -281,6 +281,7 @@ static bool spi_imx_can_dma(struct spi_controller *controller, struct spi_device
 #define MX51_ECSPI_CONFIG_SCLKPOL(cs)	(1 << ((cs & 3) +  4))
 #define MX51_ECSPI_CONFIG_SBBCTRL(cs)	(1 << ((cs & 3) +  8))
 #define MX51_ECSPI_CONFIG_SSBPOL(cs)	(1 << ((cs & 3) + 12))
+#define MX51_ECSPI_CONFIG_DATACTL(cs)	(1 << ((cs & 3) + 16))
 #define MX51_ECSPI_CONFIG_SCLKCTL(cs)	(1 << ((cs & 3) + 20))
 
 #define MX51_ECSPI_INT		0x10
@@ -573,6 +574,11 @@ static int mx51_ecspi_prepare_message(struct spi_imx_data *spi_imx,
 		cfg &= ~MX51_ECSPI_CONFIG_SCLKCTL(spi_get_chipselect(spi, 0));
 	}
 
+	if (spi->mode & SPI_MOSI_IDLE_LOW)
+		cfg |= MX51_ECSPI_CONFIG_DATACTL(spi_get_chipselect(spi, 0));
+	else
+		cfg &= ~MX51_ECSPI_CONFIG_DATACTL(spi_get_chipselect(spi, 0));
+
 	if (spi->mode & SPI_CS_HIGH)
 		cfg |= MX51_ECSPI_CONFIG_SSBPOL(spi_get_chipselect(spi, 0));
 	else
@@ -1743,7 +1749,8 @@ static int spi_imx_probe(struct platform_device *pdev)
 	spi_imx->controller->prepare_message = spi_imx_prepare_message;
 	spi_imx->controller->unprepare_message = spi_imx_unprepare_message;
 	spi_imx->controller->slave_abort = spi_imx_slave_abort;
-	spi_imx->controller->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_NO_CS;
+	spi_imx->controller->mode_bits = SPI_MODE_X_MASK | SPI_CS_HIGH | SPI_NO_CS |
+					 SPI_MOSI_IDLE_LOW;
 
 	if (is_imx35_cspi(spi_imx) || is_imx51_ecspi(spi_imx) ||
 	    is_imx53_ecspi(spi_imx))
-- 
2.25.1

