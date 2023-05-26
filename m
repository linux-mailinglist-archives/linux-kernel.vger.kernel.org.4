Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBF4712BE9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 19:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242393AbjEZRkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 13:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242838AbjEZRkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 13:40:00 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6695099;
        Fri, 26 May 2023 10:39:59 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-96f850b32caso187795866b.3;
        Fri, 26 May 2023 10:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685122798; x=1687714798;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Eyf6Eq/aNoFVwCOxjckBgFezJU5ay2h2ghz3C2J6GFY=;
        b=B/jmAKeHnw9i1zfdp5yDoT73uT2yja3v8YloC4KDlpfPQn+DJ+W1OVkdW7Z7CAqIwz
         dToWuziXRpuMug6ycwHS5HEQo8XSH3weIpwOh+HIqfBJKIRHdZz8a5TxkSLglbq5SXmv
         YMmK60o7ty7CLju/tz0vKxNpTj4/JyzOeYkobJBF5zzeA2OeYfu+pJ3hABEsKZDVuOqS
         brn9PvX1GGFN5HSp/JXeOAyYdOEOZkdDyyffay7npKOStlVzMAKJ1OE3Vuno3saJUAMs
         9SjZasJBGVtEttCa3QA/7FFqlZvNsY8HBbz2UYb1ZBAo+lij1YnUXqqigJ77O5lmC80U
         0dWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685122798; x=1687714798;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Eyf6Eq/aNoFVwCOxjckBgFezJU5ay2h2ghz3C2J6GFY=;
        b=EHdA9DEgTmm3XnYOmMLDCnT9s3ABCEyQ3p6t/wTlnvG7y955bu2XAONraevj2lH9Vn
         8BETUZxXmrHb03X6U3C6inrnFL0qxRNxzkCpbP1I0cvMrW/68Zra68H/Vhf/SsR6jazl
         BOD9XIcrgKDlOv7qQPBOaM49oiJwZCInxFU3km5aNyXdFlTqdAMDbpJ6/8OZERYFQ0Q/
         PAVKa8IOtpIW/XzNw28trL8vPV8QmfXoNy3hgG1RtpKxDY7mYIr0KVbUfo9MI4VKZ2F2
         AmZrMmIc4Ci8Z+xRUvwKbfuxOsuZxWCF/G5QXmjWXxvvGevqWFwg/6f9Ss0jEwG0a4U7
         7rDQ==
X-Gm-Message-State: AC+VfDwnQlOSgeiIZNn4d+4d7/FVa5XTqcPD9sAjpibZjw2XsAaZG7Lp
        bY0iu86L9Wldz+mKkmttHzo=
X-Google-Smtp-Source: ACHHUZ4DPSrh19KqZa9mSyODlN1kQOAl4C8YMR1HR1Y9A50fMX7c3bTuJ3QIpdXkA7zxPPhagLufLQ==
X-Received: by 2002:a17:907:9345:b0:956:fbd7:bc5e with SMTP id bv5-20020a170907934500b00956fbd7bc5emr2857719ejc.64.1685122797541;
        Fri, 26 May 2023 10:39:57 -0700 (PDT)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation.station (net-188-217-50-121.cust.vodafonedsl.it. [188.217.50.121])
        by smtp.gmail.com with ESMTPSA id dk5-20020a170906f0c500b00965b2d3968csm2367723ejb.84.2023.05.26.10.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 10:39:57 -0700 (PDT)
From:   Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     jacopo.mondi@ideasonboard.com, laurent.pinchart@ideasonboard.com,
        martin.hecht@avnet.eu, linuxfancy@googlegroups.com,
        Tommaso Merciai <tomm.merciai@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        =?UTF-8?q?Krzysztof=20Ha=C5=82asa?= <khalasa@piap.pl>,
        Mikhail Rudenko <mike.rudenko@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicholas Roth <nicholas@rothemail.net>,
        Shawn Tu <shawnx.tu@intel.com>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH v2 0/2] media: i2c: Add support for alvium camera
Date:   Fri, 26 May 2023 19:39:42 +0200
Message-Id: <20230526173955.797226-1-tomm.merciai@gmail.com>
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

Tommaso Merciai (2):
  media: dt-bindings: alvium: add document YAML binding
  media: i2c: Add support for alvium camera

 .../media/i2c/alliedvision,alvium.yaml        |  115 +
 drivers/media/i2c/Kconfig                     |    9 +
 drivers/media/i2c/Makefile                    |    1 +
 drivers/media/i2c/alvium.c                    | 3547 +++++++++++++++++
 drivers/media/i2c/alvium.h                    |  500 +++
 5 files changed, 4172 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/alliedvision,alvium.yaml
 create mode 100644 drivers/media/i2c/alvium.c
 create mode 100644 drivers/media/i2c/alvium.h

-- 
2.34.1

