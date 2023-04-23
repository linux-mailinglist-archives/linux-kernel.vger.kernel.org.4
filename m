Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D23EC6EC277
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 23:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjDWV1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 17:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbjDWV1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 17:27:10 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F803E48;
        Sun, 23 Apr 2023 14:27:08 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-763c3429abaso50884239f.1;
        Sun, 23 Apr 2023 14:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682285227; x=1684877227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RwtrvNdrZ4vfVSuyxPzOu7AvsLJyx+3KZ2XDlNlyNjU=;
        b=PsDLJ5oXlioc5siNLkJtGr1cgaCY6lIOP9fsFmQsyolaf9nxZJ96PlhbuvZ5oXAdZY
         qZO6nmLwo1Gi8VxHHS889EgYntDuHSSDVICKba+rpWTHV3lNIVMEAbQR7DI3vMd1wEAu
         kHyglmQ+CudE2CdneZdfIS3rLUDi4yL35e1le/LClh+k4Sj7e/hCoeqjMnUy8r4vS17a
         eZB9jtPwf8XsKFFwKxsbgXsfx/9shuZ2EqHepZKk6RW5wUMklntq2VrhniqyXisOk7EA
         spA/gvLUZ0+F/9Jr1b2FMv7xGYPCEowc/a8gq7lINGMpfEFrkaGzceta+/7sBfySyxlK
         H86Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682285227; x=1684877227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RwtrvNdrZ4vfVSuyxPzOu7AvsLJyx+3KZ2XDlNlyNjU=;
        b=O04Jrm0ViBdgF4YzCdvhHhAHHHp7dFxG48shy8C8EJsk/qSw2+6x6HdNVBwLR/4tB8
         RL2LEhinEcES5hbeTFOcybPI8M7nZqS+YyZ0hJWzneT9a+sAj2BdNSy+Cbs/9Db1cAhE
         sXkd2ZbCBnaXvRSZpg8xLDhIe6uDvhfTUvYZd0SR+Hje/Pjq+xVa++SUTTJqpvMTgT1g
         XTa/ihaukGPpnjyStY5jYAFgsgkGCbZjMNdYGahTvcqbhJEB9FApnFip0kCNWgx6QK1w
         JqcsorC2tvXdx0k0Dx7ATNMefDPLd2svW/8JK3jfU31IZWmjmfwXgUx+xEgsSy/vAzs6
         Wj4Q==
X-Gm-Message-State: AAQBX9f0LaR1rhg8UbMtWBIANlpw6Y0A8iq/XKUMofbVjPpR0VzegHD/
        VNGsIm8P7nx3OyT7euF8Bp4=
X-Google-Smtp-Source: AKy350afgA8iGftiANAovOQTuIUaZ1zVajWHrvD3enekMBaOZvc771PTtshJczvn72lCOvbzX9e5vw==
X-Received: by 2002:a6b:f704:0:b0:761:22af:1e3b with SMTP id k4-20020a6bf704000000b0076122af1e3bmr4772455iog.2.1682285227602;
        Sun, 23 Apr 2023 14:27:07 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:83d3:c200:cd2e:6159])
        by smtp.gmail.com with ESMTPSA id d1-20020a028581000000b004050767f779sm2897403jai.164.2023.04.23.14.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Apr 2023 14:27:07 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     laurent.pinchart@ideasonboard.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: defconfig: Enable video capture drivers on imx8mm/imx8mn
Date:   Sun, 23 Apr 2023 16:26:56 -0500
Message-Id: <20230423212656.1381002-2-aford173@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230423212656.1381002-1-aford173@gmail.com>
References: <20230423212656.1381002-1-aford173@gmail.com>
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

