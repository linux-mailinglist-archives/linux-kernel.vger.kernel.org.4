Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA12D707578
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 00:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjEQWbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 18:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjEQWav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 18:30:51 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E101259EE;
        Wed, 17 May 2023 15:30:46 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-965f7bdab6bso254687166b.3;
        Wed, 17 May 2023 15:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684362645; x=1686954645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wwJ2jZY3dnjuT0EUFOXSV7VbKcctKtPzov6U1NhPAW4=;
        b=RbGlBFWRA3xf6AobWogZ/o62Go80hrmxmKteFSu4DIYEpr5gmlsdQwulT80Y4ly1c7
         bJrbVGnkXLqeWIfdiqkKsQbuVEKFx5z6t3orih7R8AvI/NU1NvZwm0/cnGSgOXdT1Ka1
         CzyvWwrJTzs0nInvcjfrI3yWfr1DP9VvOnxn2WW+KAz/JTV+D5C6o6wmrNXayqkSyC74
         MHPgKgGLtL6mBh4NDdpxjhJ86IJpOMM4zyw7J/O81pL9dvooWwQJh+oD/oHf1EMqPu25
         ldw5jQoxMJpErAynLkV1xoWyUUgNAbtWdh7+JNueStrPbqB2ZV/WIYkf1+w9IiZeTkdw
         YOGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684362645; x=1686954645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wwJ2jZY3dnjuT0EUFOXSV7VbKcctKtPzov6U1NhPAW4=;
        b=dsOTRib2PirQP/+Y5VIOwwV6VpykGHjaii9CZFIWMhsLFaWCza8gBuTkO0uycFeJtw
         twrdTN9TbBgv4CGhJTI0gyKb8mpUENIbDktQwgZozFa5aJ9KgU0RuFO0XPRmqoeRLYQD
         STX6mV2IB/ENLZJrcI71OO8nVT59/nI+iFBAhDCH+ziQtJDE4RcnS4NwAws1uwu2sGsA
         0kxwYy1fDGkQT5CoeCN4MqM3CkqKouGziZxEI60W3Phi/IS9toTQ3bOty086t9r7Pw+x
         kCVSKwFQLT37ZmMGjnDJKr3aXr1PZ25AMFJYCqWmv16+IUDiUw0lsGWW8W1qanaq/WVy
         FNFA==
X-Gm-Message-State: AC+VfDwccRfuW86O+H119W4/Q1TCDN879ZVq1MFWdiC+yNuuYC2ZsDDZ
        vicacVlWw/zstNnqLt47aBg=
X-Google-Smtp-Source: ACHHUZ5gQ9+esOzZAXGxhnfjprvTP/lv23I4k0RHwccRhvuqGQGV0LNYQUFXARjh7qch2FWKIbCixw==
X-Received: by 2002:a17:906:ee84:b0:959:a9a1:589e with SMTP id wt4-20020a170906ee8400b00959a9a1589emr35427005ejb.76.1684362645340;
        Wed, 17 May 2023 15:30:45 -0700 (PDT)
Received: from wslxew193.fritz.box (p200300c78700c900633510ddc4028dcd.dip0.t-ipconnect.de. [2003:c7:8700:c900:6335:10dd:c402:8dcd])
        by smtp.gmail.com with ESMTPSA id y14-20020a1709064b0e00b0095807ab4b57sm109327eju.178.2023.05.17.15.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 15:30:44 -0700 (PDT)
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
Subject: [PATCH v4 3/3] spi: spidev: add SPI_MOSI_IDLE_LOW mode bit
Date:   Thu, 18 May 2023 00:30:07 +0200
Message-Id: <20230517223007.178432-3-boerge.struempfel@gmail.com>
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

