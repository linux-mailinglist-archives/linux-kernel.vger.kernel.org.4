Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81ED272610C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 15:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240488AbjFGNTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 09:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239345AbjFGNTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 09:19:42 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D61495;
        Wed,  7 Jun 2023 06:19:41 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-51493ec65d8so1571456a12.2;
        Wed, 07 Jun 2023 06:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686143980; x=1688735980;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AMXE6jWJn+QeFOvd1UA9ASVNCJFLi2P2zh4dEmu/B04=;
        b=I0vjn+XuudP9013hpQ/fW3D/0FStTLSLvU12J5HK7w66BQSqCy94C8w4Dlnwk9zQ52
         nbmu3GifDriWJ8Uu87RsnUKcsbOeZYV5WOlOXe26aAy7X5+/xFDIYpECGuFNUlfZHnjT
         ShFlilzd3ykwkZ3fktm9IYos/3cWXPb4v/3CJs5Gb6fMLYJhWF1xcV++nxwcB6C6TqOW
         zbFJOVZH15UfElyCRHmgQNGoUJpoGdHREpJVy7zACDL1UDS3ZCn9Of/hCpxOhv6agX9u
         GGJI1/Ja9WBNuDHsiI3XiAqJhGGA3PGYeDNjsFx9t4kfvuBSMs2eFTWcotB8q/XiXfJa
         rW7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686143980; x=1688735980;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AMXE6jWJn+QeFOvd1UA9ASVNCJFLi2P2zh4dEmu/B04=;
        b=L+ES1nIxpFwKU06kfWwwl2WuwZTnRmTIIVfl6WoQeTtpP0EMQZt3LpQmMuwhK3eO1u
         O3z0yB4NUS4OLWqYe1+bDqMkrE5wHA7qVK1oc8+snFMWv9Bch/KMVXHtMGA3WzO/AF7b
         FL5s3C4od6BhJq7Anh+ldQ3mXU43Or3Aw9ogsBCLNBPR+rgxeWm//VwFFCjE+DuzMP1q
         Mg/f4oFXqJD+ChSLaobDp5VqS3P0VpUoWlsSqhiQ0L3Nbj1OcXqE32YtsTZc1skIFKny
         HgPvA7ZzKKOz798xi1u1qRWNSmcCkS5rE9vo95HiWm7A9An0OEKxBoIi9dRM22mjkniu
         uoww==
X-Gm-Message-State: AC+VfDwAI9o8IAPZdgEa7A8caBZSmU+0qWGHNkp2oAPBigil/8NMMFTL
        DS+Ec474TDmGzL/H9fZSZDI=
X-Google-Smtp-Source: ACHHUZ7yImY5FzMNsmI74mYhcVHPhZH3B2tKlpE2fhhzA8sWOOChc3Z2KK5mz6mH7ec7hdv2GTSoDA==
X-Received: by 2002:aa7:dd05:0:b0:514:9e1b:d21c with SMTP id i5-20020aa7dd05000000b005149e1bd21cmr4191355edv.31.1686143979662;
        Wed, 07 Jun 2023 06:19:39 -0700 (PDT)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation.station (net-188-217-50-121.cust.vodafonedsl.it. [188.217.50.121])
        by smtp.gmail.com with ESMTPSA id k12-20020aa7d8cc000000b005169ffc81absm493353eds.51.2023.06.07.06.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 06:19:39 -0700 (PDT)
From:   Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     jacopo.mondi@ideasonboard.com, laurent.pinchart@ideasonboard.com,
        martin.hecht@avnet.eu, michael.roeder@avnet.eu,
        linuxfancy@googlegroups.com,
        Tommaso Merciai <tomm.merciai@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        =?UTF-8?q?Krzysztof=20Ha=C5=82asa?= <khalasa@piap.pl>,
        Shawn Tu <shawnx.tu@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH v4 0/3] media: i2c: Add support for alvium camera
Date:   Wed,  7 Jun 2023 15:19:22 +0200
Message-Id: <20230607131936.382406-1-tomm.merciai@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Hello All,

This series add support for Allied Vision Alvium camera.
The Alvium camera is shipped with sensor + isp in the same housing.
The camera can be equipped with one out of various sensor and abstract
the user from this. Camera is connected via MIPI CSI-2.

Working on top of Ideas on Board (branch: ideasonboard/v6.2/isi)
I'm able to test the driver on imx8mp-evk.
I collect also some patches to enable HDMI on imx8mp-evk from Pengutronix
(branch: pengutronix-imx8mp-hdmi)

I collect the patchset required to enable ISI + HDMI on imx8mp-evk into
the following branch from Avnet Silica Software & Services EMEA [1].

Some documentation on testing ISP and ISI of imx8mp-evk here [2].

Thanks all for the great work!

[1] - https://github.com/avs-sas/linux/tree/tm/ideasonboard/v6.4.0-rc2/isi/imx8mp_evk/alvium_drv_skel1e_v1
[2] - https://gist.github.com/Scott31393/077a10024a6058536d3f2fdde476265a

Tommaso Merciai (3):
  dt-bindings: vendor-prefixes: Add prefix alliedvision
  media: dt-bindings: alvium: add document YAML binding
  media: i2c: Add support for alvium camera

 .../media/i2c/alliedvision,alvium-csi2.yaml   |   96 +
 .../devicetree/bindings/vendor-prefixes.yaml  |    2 +
 drivers/media/i2c/Kconfig                     |   10 +
 drivers/media/i2c/Makefile                    |    1 +
 drivers/media/i2c/alvium-csi2.c               | 3481 +++++++++++++++++
 drivers/media/i2c/alvium-csi2.h               |  485 +++
 6 files changed, 4075 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/alliedvision,alvium-csi2.yaml
 create mode 100644 drivers/media/i2c/alvium-csi2.c
 create mode 100644 drivers/media/i2c/alvium-csi2.h

-- 
2.34.1

