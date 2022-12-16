Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779A864EC0B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 14:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbiLPNYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 08:24:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbiLPNYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 08:24:12 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00C82E6BD
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 05:24:11 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id fa4-20020a17090af0c400b002198d1328a0so8711828pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 05:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z3c/01zbRXmXJ3Ns12aVUql+2qMAvVplYeam5dHAPwQ=;
        b=Qmvns9E/WsdgoZHXrhiD2zkq46lfY7kbiY5GVvG5rz1HJE/eQJnzUYllOL014aNOme
         d8K1Lx5sKwSmlwabu4De2hsKAoHvOneE12pPU6bRdQ2g6mr20hvzZ5UxEKxiAoam02Bc
         yB5pZ1P+Hw3H0GJpshKq1wt2x/m8VSedYT854=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z3c/01zbRXmXJ3Ns12aVUql+2qMAvVplYeam5dHAPwQ=;
        b=cOZ4kTzakAfHQawSzPPC6pDH4Fuo+Cw+hcYmpw1G5WVO4r91rNVohmKhNj/zAJLoKv
         Cyk7ia6I3xiaQQNwStPMVTzoeTdxhqEDKVo0TNXm78U/KPNK/JVhMWtSE7KcYprFSuvi
         3EptWna3qT9i4aoiUTopk21uGpwGhqJeZJ2eul0ZnE0GYMJ1dHXgz07Kul+zg67TxR0W
         KiRM4YJPSIqDnguv8iHG4pXzFjrR5iZnEXX383T5pyJpzXlQ/hBQoqsnWlTv9XpYXJ5E
         DLGgfKKi7XoQz7R7RriyFAh7VAV1HQ9Wg27eVdlKz7mdnPflTYFEluX4P7KN7ftP0oUJ
         HuKg==
X-Gm-Message-State: ANoB5pkKzbk4U05XM6CFnzBzgSBo9beWGdyz97YCLTC1poIWl0i19FZZ
        uk719bjDAAINWcONaZYl0eT//Q==
X-Google-Smtp-Source: AA0mqf6VjK3LTR68NXjMELrPiMDHsqonu6gGq1N+lcTkMWKK7WGOTT1qfpRmG7LdZYyT/nQqY+pXOQ==
X-Received: by 2002:a17:902:b611:b0:188:f354:d927 with SMTP id b17-20020a170902b61100b00188f354d927mr31414615pls.8.1671197051083;
        Fri, 16 Dec 2022 05:24:11 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:1837:9294:e702:48a6])
        by smtp.gmail.com with ESMTPSA id l7-20020a170903244700b001894198d0ebsm1624278pls.24.2022.12.16.05.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 05:24:10 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: hantro: Use core-generated bus_info value
Date:   Fri, 16 Dec 2022 21:24:04 +0800
Message-Id: <20221216132404.1173254-1-wenst@chromium.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Hantro driver uses a hardcoded value for the bus_info field in the
media device and |struct v4l2_capability|. This worked well when there
was just one device. However with the iMX.8 series we are now seeing
two Hantro blocks on the same chip. The static bus_info is no longer
sufficient for differentiating devices.

Since commit f2d8b6917f3b ("media: v4l: ioctl: Set bus_info in
v4l_querycap()"), the V4L2 core provides a default value for the
bus_info field for platform and PCI devices. This value will match
the default value for media devices added by commit cef699749f37
("media: mc: Set bus_info in media_device_init()"). These defaults
are stable and device-specific.

Drop the static bus_info values from the hantro driver and use the
defaults.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 arch/arm64/boot/dts/freescale/Makefile           | 1 +
 drivers/media/platform/verisilicon/hantro_drv.c  | 2 --
 drivers/media/platform/verisilicon/hantro_v4l2.c | 2 --
 3 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index ef6f364eaa18..ef815442c78b 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -55,6 +55,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mm-data-modul-edm-sbc.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-ddr4-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-emcon-avari.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-evk.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mm-hummingboard-pulse.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-icore-mx8mm-ctouch2.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-icore-mx8mm-edimm2.2.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-innocomm-wb15-evk.dtb
diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/media/platform/verisilicon/hantro_drv.c
index 8cb4a68c9119..b0aeedae7b65 100644
--- a/drivers/media/platform/verisilicon/hantro_drv.c
+++ b/drivers/media/platform/verisilicon/hantro_drv.c
@@ -1050,8 +1050,6 @@ static int hantro_probe(struct platform_device *pdev)
 
 	vpu->mdev.dev = vpu->dev;
 	strscpy(vpu->mdev.model, DRIVER_NAME, sizeof(vpu->mdev.model));
-	strscpy(vpu->mdev.bus_info, "platform: " DRIVER_NAME,
-		sizeof(vpu->mdev.bus_info));
 	media_device_init(&vpu->mdev);
 	vpu->mdev.ops = &hantro_m2m_media_ops;
 	vpu->v4l2_dev.mdev = &vpu->mdev;
diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c b/drivers/media/platform/verisilicon/hantro_v4l2.c
index 2c7a805289e7..c1a116031013 100644
--- a/drivers/media/platform/verisilicon/hantro_v4l2.c
+++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
@@ -142,8 +142,6 @@ static int vidioc_querycap(struct file *file, void *priv,
 
 	strscpy(cap->driver, vpu->dev->driver->name, sizeof(cap->driver));
 	strscpy(cap->card, vdev->name, sizeof(cap->card));
-	snprintf(cap->bus_info, sizeof(cap->bus_info), "platform: %s",
-		 vpu->dev->driver->name);
 	return 0;
 }
 
-- 
2.39.0.314.g84b9a713c41-goog

