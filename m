Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 585C5724847
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 17:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238223AbjFFPy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 11:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232415AbjFFPyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 11:54:25 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91AC110D1;
        Tue,  6 Jun 2023 08:54:24 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-977cf86aae5so447979066b.0;
        Tue, 06 Jun 2023 08:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686066863; x=1688658863;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AycpAEzM4UVxeNN1UkOzTKSrPahRGWW+rcSs3aKWXAY=;
        b=NivT3q9JwYgpsrPpz3UOriLewwMn0QTVzKJAoD5LtRTtdn4MhkXc6akwXftdLBVIeN
         lJv6/cpJy3RcgF6YwueCHzxteVZUar27qqK0/oQkS9i6c5KvszS23W4tIf20Z1GjJKK8
         AagFDVqU1XGguPGRkwMaY/doDXK1LHmcFH4y4DeIOPZjGzCaNGmxlKSZ80xxYvbmiTqj
         g9G60bMGQ0s8ubSy8WZxfFOCB68cpVln8O1naLeDCMONRDYQgScrsRUqblYv5vX7K7QL
         IZrnoDzBjUNMcUjeSEmg3WKF8L6tqGzHt+1E2sYZXUKwK/z4p/FogP011c7gpytx/7qJ
         HRKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686066863; x=1688658863;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AycpAEzM4UVxeNN1UkOzTKSrPahRGWW+rcSs3aKWXAY=;
        b=FwpMF68RaGWUIU9RNqt350zXBhVkKirgI+K3ttIJ55NxKX5o11K6mdwXuJQhQX7OmJ
         Mb9e7Hq4/9dTphjIhCS4r+UkfOTZwH0aNX5V5HAkm0a2o6l54h3hqmyuMA1S7C+TE7ML
         OUk9o4glq1R/RNyDVDBOj7Vp00A/bXL6285gsL3kX8s3dp4IXOJZ5qKe8P68VjWZfqEE
         2sHYfw1yb9NxFK4WANpEzhcTJSDPOSimmKGyh1AHTa2Ohuzg6eMipVxLYsB9TPiwyGLu
         f2Eev5YQPzAc8Hg4V0tpb++CoKWEIHA77G12H35HOj4O1T4AYLnHwj2mvR4iNshBqe92
         VL4w==
X-Gm-Message-State: AC+VfDyeooFXE5n7TbNsbRXo0oDBkNw73T9JcCsg25S22aLbn7V53aKV
        ZzRg4302rX/g+IYe3Jl7oRE=
X-Google-Smtp-Source: ACHHUZ4K6RgUZOqXEZJ8DpbPTIdtnV2tc5Sk/AZG5KUZGQvpHaxqQfNKq8CTVJcGMzSp0XiYQt+lvw==
X-Received: by 2002:a17:907:2d8f:b0:94d:69e0:6098 with SMTP id gt15-20020a1709072d8f00b0094d69e06098mr3206261ejc.45.1686066862792;
        Tue, 06 Jun 2023 08:54:22 -0700 (PDT)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation.station (net-188-217-50-121.cust.vodafonedsl.it. [188.217.50.121])
        by smtp.gmail.com with ESMTPSA id x13-20020a170906710d00b0096f694609f3sm5800412ejj.31.2023.06.06.08.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 08:54:22 -0700 (PDT)
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
        Mikhail Rudenko <mike.rudenko@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Shawn Tu <shawnx.tu@intel.com>,
        Nicholas Roth <nicholas@rothemail.net>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH v3 0/3] media: i2c: Add support for alvium camera
Date:   Tue,  6 Jun 2023 17:54:01 +0200
Message-Id: <20230606155416.260941-1-tomm.merciai@gmail.com>
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

 .../media/i2c/alliedvision,alvium-csi2.yaml   |   93 +
 .../devicetree/bindings/vendor-prefixes.yaml  |    2 +
 drivers/media/i2c/Kconfig                     |   10 +
 drivers/media/i2c/Makefile                    |    1 +
 drivers/media/i2c/alvium-csi2.c               | 3478 +++++++++++++++++
 drivers/media/i2c/alvium-csi2.h               |  485 +++
 6 files changed, 4069 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/alliedvision,alvium-csi2.yaml
 create mode 100644 drivers/media/i2c/alvium-csi2.c
 create mode 100644 drivers/media/i2c/alvium-csi2.h

-- 
2.34.1

