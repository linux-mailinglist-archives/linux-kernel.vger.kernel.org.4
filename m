Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B195B706544
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 12:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbjEQKbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 06:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjEQKaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 06:30:52 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29FD3C1E;
        Wed, 17 May 2023 03:30:50 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-96aae59bbd6so102983866b.3;
        Wed, 17 May 2023 03:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684319449; x=1686911449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wwJ2jZY3dnjuT0EUFOXSV7VbKcctKtPzov6U1NhPAW4=;
        b=HQhZP+Wp86x1Uus2oyWNXBtJ8lRewWxzTwOG8b2mWcBX7OOl8oOdFulpCWXQrc9LtN
         mmbAl6v2a0AoUqnJS8LlAc2EpYdKgEOauo0KzYIX1+FlsTEbFhPLVLjIshf1pa/UKF5h
         eSrEzfFvYNTobR3SeJZbr/+dPi61VG0mXTvdAvRfwzABPx45ktvI9D2ZuEUrqhxRbW0x
         7gsYkEjU/UTfWrQgIOn4FTwPXxf9XPz+7DGXtDPEURQ4RliWFeuLIJac1ePlzCKMfLys
         UXUm2vkyTKzjf/s+Qkh1/kURK07hytgRXq4OgWduc8BZumlatqJ780xhNAM4rb38Qg4J
         DonQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684319449; x=1686911449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wwJ2jZY3dnjuT0EUFOXSV7VbKcctKtPzov6U1NhPAW4=;
        b=CGslV2WmA7JBOhzfXGQKb4O+2PLzcd13SFUh8Fow0H6Y49hMK5+9hD9Ul8yIIL7ufD
         zsBjvG56WpZfmD05sZs1O3GwGQfH4JUjh9TMT7fkhDhsLYGYvCP38ZR1nM7osdHi9VU5
         IuzJmdcoWftZo+KwAyCMMYxYwGx8e9Cg2buNFbepKH2pErnMr9h74I1OJ9WE2twWQpzC
         YLihmxdbBDVUn9yA49/4nKEL3QYby9HIO0hbr6e+6ySsd1skYf2KeOsPORIBCvw+vEaJ
         cAgJsXmVhHNUMhfpAwMotJG3vJ3HdO+Sy3Zo8BAbK/wpmz8rbuowEQQQRRh8Iga03pRD
         7prA==
X-Gm-Message-State: AC+VfDxq9auYZ4VhjU/2O6PkZ/u7vgwnl5qyXp0A0ysvqVdVknzoCvs5
        YujaBwjw4/3sEzNF41FYvQqdHfUtpXb66D7+
X-Google-Smtp-Source: ACHHUZ5YhiHXMEbXtrEPTBW0NZ0azss5SdBr4P0QAtlTBJ2bVf1F4AAtT/ScsY8/Arw9N38vG/Rp3Q==
X-Received: by 2002:a17:907:31c9:b0:94f:6627:22b5 with SMTP id xf9-20020a17090731c900b0094f662722b5mr35712100ejb.47.1684319448765;
        Wed, 17 May 2023 03:30:48 -0700 (PDT)
Received: from wslxew193.fritz.box (p200300c78700c900d536eaeb32769819.dip0.t-ipconnect.de. [2003:c7:8700:c900:d536:eaeb:3276:9819])
        by smtp.gmail.com with ESMTPSA id bu2-20020a170906a14200b0096654fdbe34sm12235758ejb.142.2023.05.17.03.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 03:30:48 -0700 (PDT)
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
Subject: [PATCH 3/3] spi: spidev: add SPI_MOSI_IDLE_LOW mode bit
Date:   Wed, 17 May 2023 12:30:07 +0200
Message-Id: <20230517103007.26287-3-boerge.struempfel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230517103007.26287-1-boerge.struempfel@gmail.com>
References: <20230517103007.26287-1-boerge.struempfel@gmail.com>
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

Allow userspace to set SPI_MOSI_IDLE_LOW mode bit using the
SPI_IOC_WR_MODE32 ioctl.

Signed-off-by: Boerge Struempfel <boerge.struempfel@gmail.com>
---
 drivers/spi/spidev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 39d94c850839..e50da54468ec 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -64,7 +64,7 @@ static_assert(N_SPI_MINORS > 0 && N_SPI_MINORS <= 256);
 				| SPI_NO_CS | SPI_READY | SPI_TX_DUAL \
 				| SPI_TX_QUAD | SPI_TX_OCTAL | SPI_RX_DUAL \
 				| SPI_RX_QUAD | SPI_RX_OCTAL \
-				| SPI_RX_CPHA_FLIP)
+				| SPI_RX_CPHA_FLIP | SPI_MOSI_IDLE_LOW)
 
 struct spidev_data {
 	dev_t			devt;
-- 
2.25.1

