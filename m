Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4DC5B50FC
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 22:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiIKUCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 16:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiIKUCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 16:02:07 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A1521E1B;
        Sun, 11 Sep 2022 13:02:05 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id z25so11667079lfr.2;
        Sun, 11 Sep 2022 13:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=ODiSAz5GoDVvEflUs4cY+E/qyFEeIR8p4OfDGwfDUCY=;
        b=HNby4CKdwe0H6mSOnSLSeDGZhbyv4b733JpQnS/jeUcEgeGf6FAY0m9Pv67i43ZPKZ
         QfVegvJ5+cfa5AdittxB/W/WDD/CAK0zDgJdLvkSHD8QswJOMeoLqor7DOB2WddhoocE
         j12sBZo8RT6idgKLBIS7UOunFeVp7ae/9FCZRc/sTz4ippP3uKhwOjVG1oxjlmAI2/Pf
         ekl+z75k4Lr3GCeMg/7OaDo0cZNTKPG948xszXwTu8lOt3DaNI/OhuiElrSwdwjJAYEB
         sJqCdRK+Ue6Cj69SKZaKJGnL//YJSySn0m1i5gay492FCHm5O5zOw3qjp9jfYcBjGwkf
         UtYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=ODiSAz5GoDVvEflUs4cY+E/qyFEeIR8p4OfDGwfDUCY=;
        b=gTclPz+B06ENFHY9zelAM9kh/7AUkfZCvEpORUIJM3Xg18FOE1V+P79S979L5WSepv
         2lUyVJHxfbCn/+dgG3Gv21OIWkZgW4z5V4cYZt9zpEHIHLJUBCUjCXTdvTkP1fhkw9q7
         aTBKMnDJopdmxzy18T4M0dk6PsMqkTZxDYyFyAbJpgKXhVRzTe5RihGW9QDHkfIEqw27
         Y4LVt+mX9bPa12ix8EYK4lAry7nQkh4cVNG0oInUB9CYDCgT2BqFW9B4TZ+IWbjmu2+T
         vPlmloKgAazV5OJpK7anpmr7E8HTr7A7nVhufNpCBOfB2vuKgP6ebphiTPFXcohoQbVv
         BAMA==
X-Gm-Message-State: ACgBeo0fSpAOsrLYnD4aUMkJE+izQLTGLmSHvXldWROIu2XgIsPkTbCB
        TXx3JiABqmeKo4/iOb95k14=
X-Google-Smtp-Source: AA6agR5o9w3jHgH6jOAnjSEtmM4+wdhzyt/LnlRCsUhmnRFqJ4jcSPNhm/kvjFpDN6+xvtJAzEHEcQ==
X-Received: by 2002:a05:6512:260d:b0:492:df5a:e4f9 with SMTP id bt13-20020a056512260d00b00492df5ae4f9mr7349293lfb.90.1662926523904;
        Sun, 11 Sep 2022 13:02:03 -0700 (PDT)
Received: from localhost (95-31-185-216.broadband.corbina.ru. [95.31.185.216])
        by smtp.gmail.com with ESMTPSA id u8-20020a056512094800b00497a0ea92dcsm707896lft.180.2022.09.11.13.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 13:02:03 -0700 (PDT)
From:   Mikhail Rudenko <mike.rudenko@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Shawn Tu <shawnx.tu@intel.com>, Jimmy Su <jimmy.su@intel.com>,
        Arnd Bergmann <arnd@arndb.de>, Arec Kao <arec.kao@intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Marek Vasut <marex@denx.de>
Cc:     Mikhail Rudenko <mike.rudenko@gmail.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Add Omnivision OV4689 image sensor driver
Date:   Sun, 11 Sep 2022 23:01:33 +0300
Message-Id: <20220911200147.375198-1-mike.rudenko@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this series implements support for Omnivision OV4689 image
sensor. The Omnivision OV4689 is a high performance, 1/3-inch, 4
megapixel image sensor. Ihis chip supports high frame rate speeds up
to 90 fps at 2688x1520 resolution. It is programmable through an I2C
interface, and sensor output is sent via 1/2/4 lane MIPI CSI-2
connection.

The driver is based on Rockchip BSP kernel [1]. It implements 4-lane CSI-2
and single 2688x1520 @ 30 fps mode. The driver was tested on Rockchip
3399-based FriendlyElec NanoPi M4 board with MCAM400 camera module.

While porting the driver, I stumbled upon two issues:

(1) In the original driver, horizontal total size (HTS) was set to a
value (2584) lower then the frame width (2688), resulting in negative
hblank. In this driver, I increased HTS to 2688, but fps dropped from
29.88 to 28.73. What is the preferred way to handle this?

(2) The original driver exposes analog gain range 0x0 - 0x7ff, but the
gain is not linear across that range. Instead, it is piecewise linear
(and discontinuous). 0x0-0xff register values result in 0x-2x gain,
0x100-0x1ff to 0x-4x, 0x300-0x3ff to 0x-8x, and 0x700-0x7ff to 0x-16x,
with more linear segments in between. Rockchip's camera engine code
chooses one of the above segments depenging on the desired gain
value. The question is, how should we proceed keeping in mind
libcamera use case? Should the whole 0x0-0x7ff be exposed as-is and
libcamera will do the mapping, or the driver will do the mapping
itself and expose some logical gain units not tied to the actual gain
register value? Meanwhile, this driver conservatively exposes only
0x0-0xf8 gain register range.

[1] https://github.com/rockchip-linux/kernel/blob/develop-4.19/drivers/media/i2c/ov4689.c

changes in v2:
- bindings: reword descriptions
- bindings: move clock description to clocks property
- bindings: add data-lanes and link-frequencies properties to port
- driver: validate media bus configuration when probing

Mikhail Rudenko (2):
  media: dt-bindings: media: i2c: document OV4689 DT bindings
  media: i2c: add support for ov4689

 .../bindings/media/i2c/ovti,ov4689.yaml       | 141 +++
 MAINTAINERS                                   |   8 +
 drivers/media/i2c/Kconfig                     |  14 +
 drivers/media/i2c/Makefile                    |   1 +
 drivers/media/i2c/ov4689.c                    | 951 ++++++++++++++++++
 5 files changed, 1115 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/ovti,ov4689.yaml
 create mode 100644 drivers/media/i2c/ov4689.c

--
2.37.3
