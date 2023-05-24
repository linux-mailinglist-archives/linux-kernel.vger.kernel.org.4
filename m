Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4494670F225
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 11:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240672AbjEXJVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 05:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240644AbjEXJU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 05:20:58 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B768E;
        Wed, 24 May 2023 02:20:54 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-96f588bc322so96110566b.1;
        Wed, 24 May 2023 02:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684920052; x=1687512052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RZI6N7rpTTulbByVXfKdZOIC7A9MiWqLIoC8OTG2ppM=;
        b=Dxc3ZW9z/Ys+/4mWm314kdDq9GMYYvyhgztHGsNKUjlrTHXldppbzal4TlSdjZaSen
         +LbaFjbIbQAMC63Q0UowKHnLJ264+8iKyID49hkbBS1edkI/CVKjopYy3flbXGu2jvpu
         CA4c51l0G8JGxV47HEV9nlYnikwZaovuCFhv2wgk0mZxq3OJb4LC/tt+oPN0Mq+AI9au
         tw8mP35h9Nbs2RwSPdeLGEwehBQvrm+VDckyL73xR7A/lpVmjQAHgSONigTGwIfcon7U
         UussDbwyLFyMPFR1NPCB4NxFivTNmMZ8AlNHe8MzRXcRWTe6P+a+Us5RQqEikXAkn/tw
         OGBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684920052; x=1687512052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RZI6N7rpTTulbByVXfKdZOIC7A9MiWqLIoC8OTG2ppM=;
        b=RSShDCKsai/b7aosl0C9EmGl47hryUVSIr3fwEtaGIuI8Vb8emZfByj6RMedqekTJS
         71Npk9lD1FLEh9Qo/lqY/wIva5rSS5J6AYAU1zSsKDOTul5aWgXY/ST1pTea1CfSWz3O
         fbSGy4pkPBpCT2MRB7o/ufqlaWpdMUlblI3yiygK+hvlw9xnGUsUgLENcwhgiEeJWhRu
         /5OjYtsqu4rldFnQBSKGLvXMvl499VPsYt68eCij74KeM7nZojpvnmKIhxT7gKm6TCJa
         JNmPCFd9s6P2gDPdb3zlJh/dRN14eb0MQo3AkAClK7rzvgTADWXibCcLCO74ixUAZH99
         DuUg==
X-Gm-Message-State: AC+VfDyIR1wIfufou5tU4piraX+X1nRasQGt7G49rpQHC1/LdaDUvGD1
        nebJVt/N6yxkqDlzgGTB2V8=
X-Google-Smtp-Source: ACHHUZ5mduA17zD2smOHb4wfIDa1rKzPe3tFsTTOvBk3Uel45R1amPI12lMOFupYDV1yLDxltzX40w==
X-Received: by 2002:a17:907:96a3:b0:96f:e45f:92e9 with SMTP id hd35-20020a17090796a300b0096fe45f92e9mr9902305ejc.16.1684920052104;
        Wed, 24 May 2023 02:20:52 -0700 (PDT)
Received: from wslxew193.ultratronik.de (p200300c78700c900fd67df8b3b199594.dip0.t-ipconnect.de. [2003:c7:8700:c900:fd67:df8b:3b19:9594])
        by smtp.gmail.com with ESMTPSA id jy22-20020a170907763600b0096fbc516a93sm4579527ejc.211.2023.05.24.02.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 02:20:51 -0700 (PDT)
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
Subject: [PATCH v6 3/5] spi: spidev: add two new spi mode bits
Date:   Wed, 24 May 2023 11:19:46 +0200
Message-Id: <20230524091948.41779-4-boerge.struempfel@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230524091948.41779-1-boerge.struempfel@gmail.com>
References: <20230524091948.41779-1-boerge.struempfel@gmail.com>
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

Allow userspace to set SPI_MOSI_IDLE_LOW and the SPI_3WIRE_HIZ mode bit
using the SPI_IOC_WR_MODE32 ioctl.

Signed-off-by: Boerge Struempfel <boerge.struempfel@gmail.com>
---
 drivers/spi/spidev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 39d94c850839..c8b938e0f342 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -64,7 +64,8 @@ static_assert(N_SPI_MINORS > 0 && N_SPI_MINORS <= 256);
 				| SPI_NO_CS | SPI_READY | SPI_TX_DUAL \
 				| SPI_TX_QUAD | SPI_TX_OCTAL | SPI_RX_DUAL \
 				| SPI_RX_QUAD | SPI_RX_OCTAL \
-				| SPI_RX_CPHA_FLIP)
+				| SPI_RX_CPHA_FLIP | SPI_3WIRE_HIZ \
+				| SPI_MOSI_IDLE_LOW)
 
 struct spidev_data {
 	dev_t			devt;
-- 
2.40.1

