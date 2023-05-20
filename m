Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF21F70AAA2
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 21:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjETTJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 15:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjETTJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 15:09:21 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83589FB;
        Sat, 20 May 2023 12:09:20 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-96fb1642b09so40517066b.0;
        Sat, 20 May 2023 12:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684609759; x=1687201759;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jKuXCZPFMEBDebIQLJpjRhE7JkvlO/aMRb5FBAxjGyA=;
        b=Zw+K/xCtWCunRe+eSGI3u5G/rv6tPu2EbvBLwXgee3VpXVh3Pxwzgyn7aXNkVe/X3Q
         Dc+BAvhh3ocoW721CjT5nrg1BeK1UtAo1kVomqxv4uxexPd9GY3HxX25XC2xhnmd2V1y
         ZRSr8mM/xhzp9wPpaXLQX4JSrFgQ35vFCjZ3yCcl5L7zDMfIC+9LxRGwA7t0m6USeP3r
         QAl3hdyXq4vvY1z6xFI7wuCKwidPjHmqPrV73ZJ2JTrs6WelWCG9eQTrSBDVY6I/ehSl
         lmGBHAvGOvl5kufejGvIKUbeU37sz/f8A8YzAH+auzMIVC7hQ3IE4K9otw41C2SC8Nfx
         M+Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684609759; x=1687201759;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jKuXCZPFMEBDebIQLJpjRhE7JkvlO/aMRb5FBAxjGyA=;
        b=fiZsn2/SNIA+GyFVuB7Lgjm1s2WT+j6tOuspAQLLWZfEM0muRrrhPOWLtDE/A+DpoI
         ruCWff9XTppzxGevI9Ua8+cEos8XT7XMpFbOfszAKupHp9drBsXMl//WYu7dZchz7Xww
         7uWzaphBlH3DyzCeng2EGLp6WOnpv3tOO7bySrtfT6Es4XVmjlkz5v+04YYN9hhyagU7
         Uu8W2dO4OTTb+jo97AHK8f/4KD9L87TRx3f3pDZIX7u+bAa04+Ufx2yb38hCjxJMmsAz
         /ck0Pb/nAU1rgvXTCkYZ3zadqXOHsspeF73HVc9Vyn59VcHXpvCOUC81LOVQN6cQ1+Be
         7b9A==
X-Gm-Message-State: AC+VfDwxYJYKviJZUBsuAOpKGczmSyLtMfqedHObKrf+USTUKP3gcWJS
        7mtzdfn0NNQQHXP/FHsxj3I=
X-Google-Smtp-Source: ACHHUZ4e+33Q2h8grDUbU55vyeCIsXGyZww+jq2IFjIjAoD5T7Zd3lqC/ZohUUbwKzApAGe04YiBlg==
X-Received: by 2002:a17:907:96aa:b0:96f:5747:a0d7 with SMTP id hd42-20020a17090796aa00b0096f5747a0d7mr5289127ejc.59.1684609758632;
        Sat, 20 May 2023 12:09:18 -0700 (PDT)
Received: from wslxew193.fritz.box (p200300c78700c900cb504b662390cd6b.dip0.t-ipconnect.de. [2003:c7:8700:c900:cb50:4b66:2390:cd6b])
        by smtp.gmail.com with ESMTPSA id ba7-20020a0564021ac700b0050daa883545sm1065889edb.64.2023.05.20.12.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 May 2023 12:09:18 -0700 (PDT)
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
Subject: [PATCH v5 0/4] spi: add SPI_MOSI_IDLE_LOW mode bit
Date:   Sat, 20 May 2023 21:08:51 +0200
Message-Id: <20230520190856.34720-1-boerge.struempfel@gmail.com>
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

---

Link for versions:
  v1 and v2: https://lore.kernel.org/linux-spi/20230511135632.78344-1-bstruempfel@ultratronik.de/
  v3: https://lore.kernel.org/linux-spi/20230517103007.26287-1-boerge.struempfel@gmail.com/T/#t
  v4: https://lore.kernel.org/linux-spi/CAEktqctboF3=ykVNtPsifcmHzF6dWwoEcVh+O4H1u-R=TT6gHg@mail.gmail.com/T/#t

Changes from V4:
  - Added the SPI_3WIRE_HIZ mode bit to spidev
  - Added the SPI_MOSI_IDLE_LOW mode bit to the spidev_test
    userspace tool and added the two other missing spi mode
    bits (SPI_3WIRE_HIZ and SPI_RX_CPHA_FLIP) to it as well.

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

Boerge Struempfel (4):
  spi: add SPI_MOSI_IDLE_LOW mode bit
  spi: spi-imx: add support for SPI_MOSI_IDLE_LOW mode bit
  spi: spidev: add two new spi mode bits
  spi: spidev_test Add three missing spi mode bits

 drivers/spi/spi-imx.c        |   9 +++-
 drivers/spi/spidev.c         |   3 +-
 include/uapi/linux/spi/spi.h |   3 +-
 tools/spi/spidev_test.c      | 101 ++++++++++++++++++++---------------
 4 files changed, 70 insertions(+), 46 deletions(-)

-- 
2.25.1

