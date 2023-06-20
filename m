Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099C7736BD3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 14:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbjFTMWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 08:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231962AbjFTMWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 08:22:32 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733D510F8;
        Tue, 20 Jun 2023 05:22:30 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-986d871a9beso601104766b.1;
        Tue, 20 Jun 2023 05:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687263749; x=1689855749;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fcq5N60nfQxL2AkC4k0hnO6HDG5qwiL6ahvDhw8nL84=;
        b=f4iwAfeupafLiAk53S671K/Us/NF85GSm9sArN7JrWgnD09WojbNv9zgSjQ3xGRQTk
         yyKLLM5mJm9ZVmBwCcCch3+le4uZBZEmQQ8vUsYrFTQLCVgwMlegXefkCTJIGCjRe8H3
         wGnjzOjV1P0MB13j6KAZFTWkJLYj0gCZQTpLoJccu9zDXzshgqwuu33TIc+Z1tmGnlsZ
         /Vj08U059PG+HQgE9QbzQaJnljPIrkqdgaz8adwXLqsDqG6539GZnNeIirnxsRojFU6P
         Z8GnMQectYtnoZZHwbcwDhiUamQPtE0laAqmfFXnpVUyYiKimRwbyQi3QXfrNciU6ITC
         9s+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687263749; x=1689855749;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fcq5N60nfQxL2AkC4k0hnO6HDG5qwiL6ahvDhw8nL84=;
        b=AfZ9zXzfKcErOuxN3LWKMptgOQUrJVZr8FLXTPF7+Gj+6bdY1KfTYhjeMrEUmzMjBK
         dQJRdAkgsKY6UUNULv0EMExDdRMLbn3Slul76tuS+K6vClzNq5Aa20VcbAj34DRtTW7a
         FeL/jwC0xApUtmMAB1WMC1dLpTGUMznuEiZbFhIg9SpTg/9P0MndS0SLd5sfVJkjx1gd
         pCQekVCG9b6rWwvzNnDTymhSgDhP0hWS4fs0gJICQ+oTORzBRYvmpn650SaWSviEzexK
         O/r/IehEnGIeroRkBSGN+fNG9L0L8Z7XWkcnDTdlXnCkoQczwj5MHtziYCD+0tOP2VX7
         64iw==
X-Gm-Message-State: AC+VfDzeDb53fTBYEZk8+P2H/ot13b5aPLMeZTA0Q62ZsynVuoZDmq/U
        AO79d+8lwNbE8n0IJqUiS/0=
X-Google-Smtp-Source: ACHHUZ7knw1bOSFq09Yrnd43GlWmbxcwd1QNNfpraauZ1FAM4WxwAZIkpoDomsGKK0r87gg1Qgi5Bg==
X-Received: by 2002:a17:907:e8b:b0:988:9b29:5647 with SMTP id ho11-20020a1709070e8b00b009889b295647mr4844928ejc.77.1687263748615;
        Tue, 20 Jun 2023 05:22:28 -0700 (PDT)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation.station (net-2-39-142-242.cust.vodafonedsl.it. [2.39.142.242])
        by smtp.gmail.com with ESMTPSA id me16-20020a170906aed000b0098669cc16b2sm1305200ejb.83.2023.06.20.05.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 05:22:28 -0700 (PDT)
From:   Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     jacopo.mondi@ideasonboard.com, laurent.pinchart@ideasonboard.com,
        martin.hecht@avnet.eu, michael.roeder@avnet.eu,
        linuxfancy@googlegroups.com, hdegoede@redhat.com,
        Tommaso Merciai <tomm.merciai@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Mikhail Rudenko <mike.rudenko@gmail.com>,
        Shawn Tu <shawnx.tu@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicholas Roth <nicholas@rothemail.net>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH v7 0/3] media: i2c: Add support for alvium camera
Date:   Tue, 20 Jun 2023 14:22:17 +0200
Message-Id: <20230620122225.58862-1-tomm.merciai@gmail.com>
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

 .../media/i2c/alliedvision,alvium-csi2.yaml   |   97 +
 .../devicetree/bindings/vendor-prefixes.yaml  |    2 +
 MAINTAINERS                                   |    9 +
 drivers/media/i2c/Kconfig                     |   11 +
 drivers/media/i2c/Makefile                    |    1 +
 drivers/media/i2c/alvium-csi2.c               | 2767 +++++++++++++++++
 drivers/media/i2c/alvium-csi2.h               |  474 +++
 7 files changed, 3361 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/alliedvision,alvium-csi2.yaml
 create mode 100644 drivers/media/i2c/alvium-csi2.c
 create mode 100644 drivers/media/i2c/alvium-csi2.h

-- 
2.34.1

