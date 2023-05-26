Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD8F7124C4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 12:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242989AbjEZKef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 06:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjEZKec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 06:34:32 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F01410A;
        Fri, 26 May 2023 03:34:31 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-96f53c06babso100060766b.3;
        Fri, 26 May 2023 03:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685097270; x=1687689270;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pc/xijzYvFrrG8pDhhqIjVLLUDxG8WHPs4mXbRnCNFw=;
        b=KuXaEvBHLCYZbPU8fEqT6U4czkmoTNkAWO01foV80tJsqHkP84fSzCf2biC3rSHNtk
         /fc2BBM4agRWhUlt0EeDBaRaLXF2vpxhc2XdNqCDTGSbzhuw+9NMVh7rmmr9j4kpKN/9
         mnmzrC+eBbFcUz9BKNktizxq6XFYX15fx1vyYIEQLDBuEKc2lX5d+fUXV7WbOn+a1wI7
         rrsYurKWs2eXjKFwEP6vg+zJGVxoAHl7OReNNxybGRK8mstqhDp50EExjQ4PV/txo066
         XZGwLaH3HWyxE3blKgp46cq4fzuk5l5MzRlb84UFDrfzjtbFopAouKYVHKDJRMZmsq4W
         5PlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685097270; x=1687689270;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pc/xijzYvFrrG8pDhhqIjVLLUDxG8WHPs4mXbRnCNFw=;
        b=BFAfBrp0zBotoLm3FgCMoOn35mKXNBdyBQ6jb2zNNpc85vLGDD2jDfRrNmnprV9jAo
         wWmL/953Mx2xa/Ww2DjJT8rIuyA9whXxc+aBLd1x7sG+PMq+WPTi2w6jS+xXyz08cD86
         x/i8LN8abfbvLGR8DlGv0BmEP2fUu7gDQOQ9yHVyc2BEo/qChUsznBDy0ZHHudUB8F7X
         5h+LfBQgS839JlczwGGGPxqei9HoIgkZt2hBB1/S4hKgBH2eyniXhv/FGn1SrXXtTBZr
         OSTiRIHBwracyM9oy3wfykTVvM7/OCGYu85xWqHz2P1v9DuudY13AO1903cgJUgH5yjz
         F81w==
X-Gm-Message-State: AC+VfDxfkFN8HR4YaT8Jhg5a9/bbD5gNPRCcTRKSfuCnMtFJ4k/Bg3XR
        bgZa3CDmiOFgn24N88OgkE8=
X-Google-Smtp-Source: ACHHUZ4e455Ljo7KOTGT99o7XC8miLk+PvND+AzyvC4xOyeArsLMIwyc6VZpm3zq4rrwrslUtnvlUQ==
X-Received: by 2002:a17:906:7310:b0:966:1fef:22d8 with SMTP id di16-20020a170906731000b009661fef22d8mr1759377ejc.7.1685097269435;
        Fri, 26 May 2023 03:34:29 -0700 (PDT)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation.station (net-188-217-50-121.cust.vodafonedsl.it. [188.217.50.121])
        by smtp.gmail.com with ESMTPSA id fi13-20020a170906da0d00b0096fbc516a93sm1984243ejb.211.2023.05.26.03.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 03:34:29 -0700 (PDT)
From:   Tommaso Merciai <tomm.merciai@gmail.com>
To:     tomm.merciai@gmail.com
Cc:     jacopo.mondi@ideasonboard.com, laurent.pinchart@ideasonboard.com,
        martin.hecht@avnet.eu, linuxfancy@googlegroups.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Shawn Tu <shawnx.tu@intel.com>,
        =?UTF-8?q?Krzysztof=20Ha=C5=82asa?= <khalasa@piap.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jason Chen <jason.z.chen@intel.com>,
        Mikhail Rudenko <mike.rudenko@gmail.com>,
        Nicholas Roth <nicholas@rothemail.net>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH 0/2] media: i2c: Add support for alvium camera
Date:   Fri, 26 May 2023 12:34:14 +0200
Message-Id: <20230526103427.774226-1-tomm.merciai@gmail.com>
X-Mailer: git-send-email 2.34.1
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

 .../media/i2c/alliedvision,alvium.yaml        |  117 +
 drivers/media/i2c/Kconfig                     |    9 +
 drivers/media/i2c/Makefile                    |    1 +
 drivers/media/i2c/alvium.c                    | 3547 +++++++++++++++++
 drivers/media/i2c/alvium.h                    |  500 +++
 5 files changed, 4174 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/alliedvision,alvium.yaml
 create mode 100644 drivers/media/i2c/alvium.c
 create mode 100644 drivers/media/i2c/alvium.h

-- 
2.34.1

