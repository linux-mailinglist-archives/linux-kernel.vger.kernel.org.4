Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F9B6F993D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 17:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbjEGPQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 11:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbjEGPQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 11:16:02 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0BD124A7;
        Sun,  7 May 2023 08:16:01 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-3318961b385so37018355ab.1;
        Sun, 07 May 2023 08:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683472560; x=1686064560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u0FAgyG30bpRJlMKwIJbN0GIC3aFiZtnxD9A8v5yUOA=;
        b=NzbuuiADyxfEW4tgaL5ZCfPYXAsWkiiDPHrzHx2tXYFbCI0ptFdflohcGIseqd53eF
         /hhHTb9Z9bgcgrZc5w6PsDuBYCeHPN2m3esjwFYsCKAMKx5SS5FE/scwh9pKxRJyYyKz
         pTDZpSGg/iChJXlySgUxi0J/Cy7fUvpRQTcNERwqp79MwMyVMkeeYJjNDE+CGHoChJrR
         2ZS6bHMwysZ2wNu9dA2j+/DVimlBsarWUouFvrSXasPVpktgedCNOx4cbabJ0VeWa6uw
         V+TeTBy9Ji26wBowjyMnrSBLh5o11FHFjXgl8jyZdKImpJq94ISFlJ2MaxvIY/UxHd2h
         pMNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683472560; x=1686064560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u0FAgyG30bpRJlMKwIJbN0GIC3aFiZtnxD9A8v5yUOA=;
        b=j05ZokRbodYlQM7DvU64BSmL2evAWZr/GNjuhh7JQ1tT/0n6s5a04M4Mw23gmmdRkz
         jFo0x3dra6kX91dsv+jKDXZudjKfTDwcOBcJRyJ7VpDO0sVRaIC0MQYJq92a3a8zIWdT
         9yBkvMH5TWcuxNEV1hQ5D0oK+ESKk7pqu6dM/SpnUd27X1jPloekh4XeHwp80JAB8Hjm
         PVahf2Bp6P/BK4fxSN0PuK4yW4FEpq4/r+J4V+KFRAH+a9uNioT5Px5OnHmave7Y+pIN
         voq3KCyw3gYa6veMq5GeTZ36Q+ZqxoBSTaxAmeUScnCeMPY2bmqC7q5jMR/xK4zkWWHS
         ueww==
X-Gm-Message-State: AC+VfDzQRtFcEyjUn+qbbw5MZdllLNxz4Jq3CexKXoyvDnrkoAweSp3o
        A9qsxEaQtIRGeXb8PjcjaTo=
X-Google-Smtp-Source: ACHHUZ5q0v2IunwyqAKmaN1qV37LnSpg9RgjnsCmnSh3jdI+g84iBlSWNKV9Pk/+RQXMwbhWSKhaVQ==
X-Received: by 2002:a92:9514:0:b0:335:7f1:6939 with SMTP id y20-20020a929514000000b0033507f16939mr2342936ilh.11.1683472560451;
        Sun, 07 May 2023 08:16:00 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:32f2:3dc9:fe53:5220])
        by smtp.gmail.com with ESMTPSA id s1-20020a02b141000000b0040faf05071asm1293566jah.156.2023.05.07.08.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 08:15:59 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V2 2/3] arm64: defconfig: Enable video capture drivers on imx8mm/imx8mn
Date:   Sun,  7 May 2023 10:15:47 -0500
Message-Id: <20230507151549.1216019-2-aford173@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230507151549.1216019-1-aford173@gmail.com>
References: <20230507151549.1216019-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The imx8m Mini and imx8m Nano both use the same CSIS driver for
interfacing with sensors and cameras.  The Mini routes the CSIS
output to the imx7-CSI driver, and the Nano routes the CSIS
through the imx8-isi driver like the one used on the imx8mp.

Enable the drivers necessary to facilitate capture on both of
these two platforms.

Signed-off-by: Adam Ford <aford173@gmail.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
V2:   No Change

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index a24609e14d50..7005640fbb8e 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -743,6 +743,10 @@ CONFIG_SDR_PLATFORM_DRIVERS=y
 CONFIG_V4L_MEM2MEM_DRIVERS=y
 CONFIG_VIDEO_MEDIATEK_JPEG=m
 CONFIG_VIDEO_MEDIATEK_VCODEC=m
+CONFIG_VIDEO_IMX7_CSI=m
+CONFIG_VIDEO_IMX_MIPI_CSIS=m
+CONFIG_VIDEO_IMX8_ISI=m
+CONFIG_VIDEO_IMX8_ISI_M2M=y
 CONFIG_VIDEO_QCOM_CAMSS=m
 CONFIG_VIDEO_QCOM_VENUS=m
 CONFIG_VIDEO_RCAR_ISP=m
-- 
2.39.2

