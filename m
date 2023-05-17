Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6DE707574
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 00:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbjEQWat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 18:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjEQWar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 18:30:47 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064C659FD;
        Wed, 17 May 2023 15:30:44 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-965fc25f009so235898466b.3;
        Wed, 17 May 2023 15:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684362642; x=1686954642;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1xvZgYgSWGaYso+rMNPq2umuAV7PxMbwVAnAP9WIPXc=;
        b=OZ9CGRQV1SeQ2kcD8yaOaISaKguhXnwPewhpm95OxfALiQ+94wbvi7qyuoi0EhMcLy
         o+NI1Sn59jiDT886nlK4v7x1q4a77uIZi+ov/J2+TjnGYFqn1zrCxMLAcHkOu3zz7DUL
         s5ihngf9Q/WBNpaqAkzRljMTUJqM4tb1vRBIudf4y7C/HK6xsN8KnpZsa0rKVWC+XlZa
         tZCwzhQB26iGoLJtIjxyUY/XFp07GqQPFncDfZU00Yq+MMWrwT3w+C6w5BJV5GHDm4Sj
         NUgosoE5MoADYEa4yRUGEe8ayujrc8enXF/10AnEFZWFU7ChbRhI+O5YQ6RLcacAfzqE
         Wnnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684362642; x=1686954642;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1xvZgYgSWGaYso+rMNPq2umuAV7PxMbwVAnAP9WIPXc=;
        b=ftC1c/Fhx6P9Rs6d3kiDsFOtgOvFhT3wM/7wSZYLsfqQKW5ZekbHTSwNQt8aapyECl
         5691XPHpvcqEX0VInzD3ehmvgSqizSa9fKPT41lCEe8qfER9KwIc6blbuHNE+42GeAIV
         W44NKYURnnVFJkJB4T5TPFUEhXET7JaPMNErm3II1si81Q5h+s4H2OFYHp44ijU4armX
         FTpqB5a+ckifK99GZzSrggRtawfFvQS2L/KQdSLDFxvyjQG5FbR0w9KKjwjE09nPbhMM
         u0muUzXCGJZdYLSpRvDGn8kPlK/oWHPwCUhV7w4QXTWN+YL9QxVOb3+3z2QJwZGmq5cA
         eLOw==
X-Gm-Message-State: AC+VfDy/BhUodNcq/b2oUQv7MmzyYdRIVCEUDCwSO3NJWlyAUDO9Zo2w
        Fonjo36TCjX7BoGNlFAcv6w=
X-Google-Smtp-Source: ACHHUZ6nai5aV4t2xJk7IyN+8Ad3ycGG5nCY8zPmux1AvlcXXVCpMuuuutAsIVKWGprRkefr8VzF4Q==
X-Received: by 2002:a17:907:3e9c:b0:966:471c:2565 with SMTP id hs28-20020a1709073e9c00b00966471c2565mr37357809ejc.48.1684362642211;
        Wed, 17 May 2023 15:30:42 -0700 (PDT)
Received: from wslxew193.fritz.box (p200300c78700c900633510ddc4028dcd.dip0.t-ipconnect.de. [2003:c7:8700:c900:6335:10dd:c402:8dcd])
        by smtp.gmail.com with ESMTPSA id y14-20020a1709064b0e00b0095807ab4b57sm109327eju.178.2023.05.17.15.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 15:30:41 -0700 (PDT)
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
Subject: [PATCH v4 1/3] spi: add SPI_MOSI_IDLE_LOW mode bit
Date:   Thu, 18 May 2023 00:30:05 +0200
Message-Id: <20230517223007.178432-1-boerge.struempfel@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Some spi controller switch the mosi line to high, whenever they are
idle. This may not be desired in all use cases. For example neopixel
leds can get confused and flicker due to misinterpreting the idle state.
Therefore, we introduce a new spi-mode bit, with which the idle behaviour
can be overwritten on a per device basis.

Signed-off-by: Boerge Struempfel <boerge.struempfel@gmail.com>


Link for versions:
  v1 and v2: https://lore.kernel.org/linux-spi/20230511135632.78344-1-bstruempfel@ultratronik.de/
  v3: https://lore.kernel.org/linux-spi/20230517103007.26287-1-boerge.struempfel@gmail.com/T/#t

Changes from V3:
  - Added missing paranthesis which caused builderrors

Changes from V2:
  - Removed the device-tree binding since this should not be managed by
    the DT but by the device itself.
  - Replaced all occurences of spi->chip_select with the corresponding 
    macro spi_get_chipselect(spi,0)

Changes from V1:
  - Added patch, introducing the new devicetree binding flag
  - Split the generic spi part of the patch from the imx-spi specific
    part
  - Replaced SPI_CPOL and SPI_CPHA by the combined SPI_MODE_X_MASK bit
    in the imx-spi.c modebits.
  - Added the SPI_MOSI_IDLE_LOW bit to spidev

---
 include/uapi/linux/spi/spi.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/spi/spi.h b/include/uapi/linux/spi/spi.h
index 9d5f58059703..ca56e477d161 100644
--- a/include/uapi/linux/spi/spi.h
+++ b/include/uapi/linux/spi/spi.h
@@ -28,6 +28,7 @@
 #define	SPI_RX_OCTAL		_BITUL(14)	/* receive with 8 wires */
 #define	SPI_3WIRE_HIZ		_BITUL(15)	/* high impedance turnaround */
 #define	SPI_RX_CPHA_FLIP	_BITUL(16)	/* flip CPHA on Rx only xfer */
+#define SPI_MOSI_IDLE_LOW	_BITUL(17)	/* leave mosi line low when idle */
 
 /*
  * All the bits defined above should be covered by SPI_MODE_USER_MASK.
@@ -37,6 +38,6 @@
  * These bits must not overlap. A static assert check should make sure of that.
  * If adding extra bits, make sure to increase the bit index below as well.
  */
-#define SPI_MODE_USER_MASK	(_BITUL(17) - 1)
+#define SPI_MODE_USER_MASK	(_BITUL(18) - 1)
 
 #endif /* _UAPI_SPI_H */
-- 
2.25.1

