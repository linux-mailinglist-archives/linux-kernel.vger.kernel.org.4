Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10E1D70F218
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 11:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240632AbjEXJU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 05:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240307AbjEXJUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 05:20:54 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AECF198;
        Wed, 24 May 2023 02:20:49 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-96fe88cd2fcso119929866b.1;
        Wed, 24 May 2023 02:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684920047; x=1687512047;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2shygy+5ofzXJ/pEFBWa4IfYxYA2SshZRxJ/ZfDq4fI=;
        b=pgaeEgmCgQKJ5VEe5Vt33KkOgeG0ACByAB7nbgXYN2sAsk7fs7F1+vNgp5PpM7XFJZ
         IEwEDTKmnWfbLKg3IUprDuN6dhXPghWldHLbTrZdkiOpZuR50HKA4ewF42k9ll5ewi2L
         RCYgabIyKC/55/tyn9FWeEREbNbjP8M03N/80YEY7btshtN3MyGB1uilFTo6hWJJHrxd
         Z9ZJtXNwtgoEHzG0YfsBLw/vuELggqFWZTBTUAx1kTEdu759E0HpZLClbkiaOm8v+YV3
         sCpSRNgDLEbTtQdo996DYi7V7KtKHMRikYvzNUTOqMIn8/SLjoIgXKZAYpdNIKlGDABT
         TJaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684920048; x=1687512048;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2shygy+5ofzXJ/pEFBWa4IfYxYA2SshZRxJ/ZfDq4fI=;
        b=fAmIww2pLsZg3zPSBZScyQsN2zK3J1tJq6ct0Ol/is6T/2rsQxv70LFc2angqAH+Hp
         z1/KRdtgt8IOx7guQtkpOD9JyV0Ax+8lNonq7hkae8Gbz+waLPd+39kLhTxHBAlRgdDi
         TAZ2GX4aLthDleapcyBBdOUN3BUzwf5XDs2DrPUMbs6qKkKEglNoCLGOiQWH/QCo7xqk
         CRYwYRuLyfxtc+97HD5em4hdyJFGeSXdwXfC8YahT6tkNkOBPiq14pD1YEyZmRkebzJa
         YKcXEOVaZ/vPjaOQi8671cL6wAk2zS+Pg12PHEo+Ni+Se/RSBMYXwOYaF/DPPM9jHFY0
         xmCw==
X-Gm-Message-State: AC+VfDxzV4DO84FpAT4ej2A0JcLGAbIKuebTZjK+fdGpZ++SqAyGM2aq
        vHlSBAGVmVOfs6tAyChzDOo=
X-Google-Smtp-Source: ACHHUZ7dGcncY9GWyZcVBG8PqRsil8FRN/Attc2ihiuDKZpSuzjyouk5B8pq11/elF7YD4w0t8q6Mw==
X-Received: by 2002:a17:907:72d2:b0:973:8198:bbf6 with SMTP id du18-20020a17090772d200b009738198bbf6mr1468633ejc.3.1684920047403;
        Wed, 24 May 2023 02:20:47 -0700 (PDT)
Received: from wslxew193.ultratronik.de (p200300c78700c900fd67df8b3b199594.dip0.t-ipconnect.de. [2003:c7:8700:c900:fd67:df8b:3b19:9594])
        by smtp.gmail.com with ESMTPSA id jy22-20020a170907763600b0096fbc516a93sm4579527ejc.211.2023.05.24.02.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 02:20:47 -0700 (PDT)
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
Subject: [PATCH v6 0/5] spi: add SPI_MOSI_IDLE_LOW mode bit
Date:   Wed, 24 May 2023 11:19:43 +0200
Message-Id: <20230524091948.41779-1-boerge.struempfel@gmail.com>
X-Mailer: git-send-email 2.40.1
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
  v5: https://lore.kernel.org/linux-spi/20230520190856.34720-1-boerge.struempfel@gmail.com/T/#t

Changes from V5:
  - Added a patch to reorder the command line options for
    spidev_test in order to increase usability. The indentation
    fixes were also done in this patch.

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

Boerge Struempfel (5):
  spi: add SPI_MOSI_IDLE_LOW mode bit
  spi: spi-imx: add support for SPI_MOSI_IDLE_LOW mode bit
  spi: spidev: add two new spi mode bits
  spi: spidev_test: Sorted the options into logical groups
  spi: spidev_test Add three missing spi mode bits

 drivers/spi/spi-imx.c        |   9 ++-
 drivers/spi/spidev.c         |   3 +-
 include/uapi/linux/spi/spi.h |   3 +-
 tools/spi/spidev_test.c      | 107 +++++++++++++++++++++--------------
 4 files changed, 76 insertions(+), 46 deletions(-)

-- 
2.40.1

