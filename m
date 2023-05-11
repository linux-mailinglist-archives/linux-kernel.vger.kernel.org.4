Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA106FFD00
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 01:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239421AbjEKXON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 19:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239198AbjEKXOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 19:14:10 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842F81701;
        Thu, 11 May 2023 16:14:09 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-96598a7c5e0so1485982666b.3;
        Thu, 11 May 2023 16:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683846848; x=1686438848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4chri+9NDBileuiNOtrqtunzQXZVRGXLU7j96g86rzY=;
        b=d8UpxTzzydldBvOZamYpsRdriAdw5/BCFjSqSOTX0kBpXOuIeIKQ+VQvROeWCJBCJT
         7FtmNk59AMgusqzp4ot0al8Oi9N42W0y+9j8NFAt7iDHmsQaoiQplkUWFk3CiDGY513B
         31BL8ytP7CozzqHNUlE83+e4U4SlBci50JPf3EtMWorfkv6i6DQz4Rz+eQfQO8iSc4le
         CcukH97S7jt0L7/R/AVL0ieEeZpgvnN8KcOfGAHhuDtis9oSmTLDSDxnp30EU/LtBzcm
         3F1yh3s00blFs6cpMQPMrVNc5vYty2bfuljWNLNaePmY3C4R4inZymUbHMmL0dXVjJ09
         7dhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683846848; x=1686438848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4chri+9NDBileuiNOtrqtunzQXZVRGXLU7j96g86rzY=;
        b=Eq4EXfCn2fZvLaGInRzIcFb2UTenGuSc4m0jxXVQHJrUPYQWjCuQ5991Wzu/lIe6iO
         0TT7doOC3xF1BjWb7lvWNDKImAR+xyOj2Sc0EC+CWn26Gb5oR1CTkRbBTQYDTOgs015x
         kZM8OTvAIkIZK127sG7n2Y0/Nv3Orbk5eJTuFZav1b3RyZAujG4tQXQy7CDFfOMzE8u9
         mUSus5dZqIHu5n/LbeLsFOGyyyH/2SIrxo7AtYhSHcaD4oFwV9NsYZimvQ2reOKJ93WR
         Ayl1iwWaz5tv24E/IxjkoIt8mGGEpekJFW55O5ytHTQXoOVvkjjdR0AdGISyoLx5vDiV
         c8ZA==
X-Gm-Message-State: AC+VfDyRWekLxr4CJmBQPOIrS15cM1SWDYXaboADVLF3xbBVIHMz8mN2
        /L7P9ZM/uG9C3bqLhBbkkk0=
X-Google-Smtp-Source: ACHHUZ54KfPnWz3TIklWlv4IMSPr2ZsEbaMoy1ootcOWpZmc+OscglQy9bsR2m/MJ5fmBdzBhUdsXg==
X-Received: by 2002:a17:906:4fd1:b0:959:8575:2635 with SMTP id i17-20020a1709064fd100b0095985752635mr23744556ejw.17.1683846847771;
        Thu, 11 May 2023 16:14:07 -0700 (PDT)
Received: from wslxew193.fritz.box (p200300c7874f2f0049cdad3080524d03.dip0.t-ipconnect.de. [2003:c7:874f:2f00:49cd:ad30:8052:4d03])
        by smtp.gmail.com with ESMTPSA id hx8-20020a170906846800b00965e839f56bsm4543023ejc.182.2023.05.11.16.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 16:14:07 -0700 (PDT)
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
Subject: [PATCH v2 0/4] spi: Add option to keep the MOSI line low, when it is idle
Date:   Fri, 12 May 2023 01:13:13 +0200
Message-Id: <20230511231317.158214-1-bstruempfel@ultratronik.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230511135632.78344-1-bstruempfel@ultratronik.de>
References: <20230511135632.78344-1-bstruempfel@ultratronik.de>
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

Some spi controller like the imx spi controller switch the mosi line to
high, whenever they are idle. This may not be desired in all use cases.
For example neopixel leds can get confused and flicker due to
misinterpreting the idle state. Therefore, we introduce a new spi-mode
bit, with which the idle behaviour can be overwritten on a per device
basis.

Changes from V1:
  - Added patch, introducing the new devicetree binding flag
  - Split the generic spi part of the patch from the imx-spi specific
    part
  - Replaced SPI_CPOL and SPI_CPHA by the combined SPI_MODE_X_MASK bit
    in the imx-spi.c modebits.
  - Added the SPI_MOSI_IDLE_LOW bit to spidev

Boerge Struempfel (4):
  spi: dt-bindings: Introduce spi-mosi-idle-low flag
  spi: add SPI_MOSI_IDLE_LOW mode bit
  spi: spi-imx: add support for SPI_MOSI_IDLE_LOW mode bit
  spi: spidev: add SPI_MOSI_IDLE_LOW mode bit

 .../devicetree/bindings/spi/spi-peripheral-props.yaml    | 6 ++++++
 drivers/spi/spi-imx.c                                    | 9 ++++++++-
 drivers/spi/spi.c                                        | 2 ++
 drivers/spi/spidev.c                                     | 2 +-
 include/uapi/linux/spi/spi.h                             | 3 ++-
 5 files changed, 19 insertions(+), 3 deletions(-)

-- 
2.25.1

