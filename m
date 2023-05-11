Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3F816FFD0D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 01:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239562AbjEKXOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 19:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239506AbjEKXOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 19:14:30 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458285B8B;
        Thu, 11 May 2023 16:14:23 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-969f90d71d4so643798266b.3;
        Thu, 11 May 2023 16:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683846861; x=1686438861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yVrYFiNzfnwEDWJqbz4i6UUhL6F/Njhh8b514wrHy84=;
        b=bPFE9oQ/v0Bi8HM083WisiVBY7+f0/sS0Zk/5LDwGQhWm99N/KSo36J6pQk4I3pWfZ
         C7UXARg6DwSbNVlEYfz183Xv9EyR2OHGQCkFLVkq3xuTEdmAKakB7BT+x8JwtiPDLoGG
         TBPk9msq2VwvsqhIitvVy8F7LXO54gWHwZsTECWiWDq88Cf028vseSVN839GbRxlUcJX
         SszHwJefkuACQxXotuP1gAl07KPyyXfOqjtbxLirP+95UYpsMAi/0ZWYREWhUJMDpyuY
         5eLNRzI2cKcEjtFZFqhu545t9u/DwxawjCzagxBCCs1Zv9FCnE+8qTK48t1MfObGPCbP
         PkSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683846861; x=1686438861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yVrYFiNzfnwEDWJqbz4i6UUhL6F/Njhh8b514wrHy84=;
        b=S2RCa+1srdZR8EXVr0rjJqWQSQoMmxzll3IHJm7b4vFe1pZF2b3lzW2V3OpG2vrEH8
         eOuMcXrvgdbgKS5rdcCKuSoa1E4RFFpUzWGJISsRr6+W6tYu7XwyozvGqsX26WnwXH5u
         p3VwtWk7zzt4Nw80bFW7goBwh+8U+gbMTNNvSlgseybV/bemN2spemaH3D7FGtTXIdd+
         R08tPtJv0z4a6I4M0M5Lbg+Oeezo42FV5aSAE5roj4u17azzInohpKHHkNIe8ZA4q5HB
         kVnZ/1foud8RhJbkR3+IaAY0JEnskL8c8HVGg5X9IpVvcUzcSslmURKfDO9YrzRN+Bve
         8obw==
X-Gm-Message-State: AC+VfDxvC60KgKyicvyyp9lpgKcMWeuW33p0uzdvvt5kQsih1SCUFdKg
        hdePqIoUaReTfhtgp0Ifqfs=
X-Google-Smtp-Source: ACHHUZ7Xiv4uI35j1SY9WriiO/V2ApkipDWS3Xqc4RSksozkyAf90JPpXCmfsp01aS4F1JO3r9CObA==
X-Received: by 2002:a17:907:2d1f:b0:968:db2f:383 with SMTP id gs31-20020a1709072d1f00b00968db2f0383mr14109865ejc.53.1683846861470;
        Thu, 11 May 2023 16:14:21 -0700 (PDT)
Received: from wslxew193.fritz.box (p200300c7874f2f0049cdad3080524d03.dip0.t-ipconnect.de. [2003:c7:874f:2f00:49cd:ad30:8052:4d03])
        by smtp.gmail.com with ESMTPSA id hx8-20020a170906846800b00965e839f56bsm4543023ejc.182.2023.05.11.16.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 16:14:21 -0700 (PDT)
From:   Boerge Struempfel <boerge.struempfel@gmail.com>
X-Google-Original-From: Boerge Struempfel <bstruempfel@ultratronik.de>
Cc:     boerge.struempfel@gmail.com, bstruempfel@ultratronik.de,
        andy.shevchenko@gmail.com, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 4/4] spi: spidev: add SPI_MOSI_IDLE_LOW mode bit
Date:   Fri, 12 May 2023 01:13:17 +0200
Message-Id: <20230511231317.158214-5-bstruempfel@ultratronik.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230511231317.158214-1-bstruempfel@ultratronik.de>
References: <20230511135632.78344-1-bstruempfel@ultratronik.de>
 <20230511231317.158214-1-bstruempfel@ultratronik.de>
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

Signed-off-by: Boerge Struempfel <bstruempfel@ultratronik.de>
---
 drivers/spi/spidev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 39d94c8508390..e50da54468ec6 100644
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

