Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19724732C8D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 11:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244032AbjFPJ5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 05:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242492AbjFPJ50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 05:57:26 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFEEE194;
        Fri, 16 Jun 2023 02:57:24 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9786fc23505so67000566b.2;
        Fri, 16 Jun 2023 02:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686909443; x=1689501443;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HHKi+C6Xmm6kghgu1V+wkpNpwNFPfp57Mi+RE1PFdr4=;
        b=WZEJP2DgepngVFkH3kxp5QC7qX/d1SkRhp23Kp03X6HI9YyIgc0Zy8IiPQygVr+Baa
         5z6sTpwczpWMtuIHXlB6vucMevN5TOy26ysxMJwziGsGtmaWTQDnfwyXCFlTaIH53kVq
         OKlqsJbNKpyUB7uSyn8hd+jL9NlNH+QttSPlxgcf1NN4538JBlCUZEhzxUsckuI3L/ZZ
         gKoK8rsoE2P7Sx/eiInbEax8q0SlcC9QSl7OC++OwOX9BTkAzVAUcf856u40qCt5TgZ9
         fnUuI7qyzBTh2s40Ha+Fy2vsuTP1znKa2DDS7hidMN1VyLn2Un1q9cIUiHVW848t/+sx
         KS9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686909443; x=1689501443;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HHKi+C6Xmm6kghgu1V+wkpNpwNFPfp57Mi+RE1PFdr4=;
        b=OIzArkS2qDwa3X69FguQ9Y9T+YjJ8m2Vhy3E0CKdbGk0gFML0/NXK4TCeFbzQnP5EW
         JitV8POfULOun+xvFD//DpvbWR81N4bLyz98+suxBNP32/Oulg07A1G/ef3f27aMEsNK
         5WoPTL3kgOnxJ5N+rjt3oDDB6CpAMZpWs357pVACdx8erHEbcAKky9Ro6u4HxIOAPBX7
         0XyVm/aH+BOUmnKlUs9+W5M/5Ap9QPIky+410n1eYNO2t4i/voTZ7zKbO3lHQZn5QMv/
         +Kju08hdrOQoL9TxE2Rr2Wh+hbxo2mGx6suOTLgjIHJ55D4QsIbbnHro11ZewBSqI0h0
         Z80g==
X-Gm-Message-State: AC+VfDztMJm0hcmY1tqu41PRWLdx5dL94lGnrsSPwTammsMN6PA0A86s
        vn5zNUPgm/G56kwwkskcoW0=
X-Google-Smtp-Source: ACHHUZ4mCeeN3wIQ0AMXpA0qYnOMmCrkSJfP8NbdFwLramC2cKCERWK2hj9xYzOrhv6waeu+ugBEDw==
X-Received: by 2002:a17:907:2da6:b0:974:1c91:a752 with SMTP id gt38-20020a1709072da600b009741c91a752mr1628908ejc.5.1686909442716;
        Fri, 16 Jun 2023 02:57:22 -0700 (PDT)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation.station (net-2-39-142-242.cust.vodafonedsl.it. [2.39.142.242])
        by smtp.gmail.com with ESMTPSA id v22-20020a1709063bd600b0098314c30e8fsm1110083ejf.46.2023.06.16.02.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 02:57:22 -0700 (PDT)
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
        Shawn Tu <shawnx.tu@intel.com>,
        Mikhail Rudenko <mike.rudenko@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        =?UTF-8?q?Krzysztof=20Ha=C5=82asa?= <khalasa@piap.pl>,
        Nicholas Roth <nicholas@rothemail.net>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH v6 0/3] media: i2c: Add support for alvium camera
Date:   Fri, 16 Jun 2023 11:56:58 +0200
Message-Id: <20230616095713.187544-1-tomm.merciai@gmail.com>
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
 drivers/media/i2c/Kconfig                     |   11 +
 drivers/media/i2c/Makefile                    |    1 +
 drivers/media/i2c/alvium-csi2.c               | 3159 +++++++++++++++++
 drivers/media/i2c/alvium-csi2.h               |  475 +++
 6 files changed, 3745 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/alliedvision,alvium-csi2.yaml
 create mode 100644 drivers/media/i2c/alvium-csi2.c
 create mode 100644 drivers/media/i2c/alvium-csi2.h

-- 
2.34.1

