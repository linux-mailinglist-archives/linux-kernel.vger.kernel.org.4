Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96BFB6601B9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 15:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234872AbjAFOAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 09:00:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234844AbjAFOAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 09:00:47 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F04377D29;
        Fri,  6 Jan 2023 06:00:46 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id p1-20020a05600c1d8100b003d8c9b191e0so1119857wms.4;
        Fri, 06 Jan 2023 06:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kTaBsHHaxY4hxEZyw1070cz+vHDzIdLfWWrgADCbRU8=;
        b=kMVALwwUOsuXe2H9tiPvLnP6NJwlyxfFypCBmI0D/6IIZtFAulwtGv1gn7ileo9q2Y
         2IkdjoXJON8sBxMRlrRPDgAkYJjpXXDgsuPD2GBKrP1iaPq8hK9izxaa3ptkUUDWkg8p
         Yx190q4Cx6R3xYh0cbHYDGrm+SmaPex4zzWOGfJpEan3TqiEQy2X68zMlMuGv3zYhNO+
         bDxustxsaVG7DxLPPIiRXYU9nLcewdrOZA9LtnX/3c6M2FCpX0PXgYSlx0h6is32iEYq
         DxB5kIe8G2G3jkpDt9xlytnBpOhC25/ZkqeEDymmyT6+KKphiul0y3SyJsi/HjjWX1t3
         P7DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kTaBsHHaxY4hxEZyw1070cz+vHDzIdLfWWrgADCbRU8=;
        b=UxfkjeK+NDegaLYYOUB8CN+aXP1RL+ipiumVc/uNWhywyLRhl2caohgWO25R/f14kx
         IRXGsDPaekTnJAuSQ27G1iLgCV299dwzot67xD96fbXMr4AI1K+CRVbbbUAfP52QxlZM
         b2PbsNeH6xijLKvqTCy6uHjNCRj63zLU23qFJwDaBK+MVWBvhKzDIHTXpoF08VTZ0kTf
         79djPueMVWxytIn+jEWHb3h9N0xqulLoPyLtnU4tW8jd8UDum+78zmJ3iFk9D1tk+EhY
         h3HuTgpzo98/8Fe4EoN0zYwJ/DBgaQ/uFiBnMugLA0917LsjIrwhNNGaa+ADNxLHPHpe
         JUpg==
X-Gm-Message-State: AFqh2kqVSJKGFMoMKjnouDM3QqlXGjh2UicKx59MZ3F7XP0SqYLZdCCq
        a8GOvEzqSAutsWT/sYVa6/Q=
X-Google-Smtp-Source: AMrXdXtcxMb1sjh4Foy0c4Wo2XOB2rnnybH27bS0t4t2gZCoL++LW+Qf93N8JOewORmLz95/NAJuLw==
X-Received: by 2002:a05:600c:3ba4:b0:3cf:d428:21d6 with SMTP id n36-20020a05600c3ba400b003cfd42821d6mr38001751wms.3.1673013640025;
        Fri, 06 Jan 2023 06:00:40 -0800 (PST)
Received: from localhost ([212.253.112.114])
        by smtp.gmail.com with UTF8SMTPSA id f19-20020a05600c155300b003d98a7aa12csm7246306wmg.16.2023.01.06.06.00.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jan 2023 06:00:39 -0800 (PST)
From:   Sasha Finkelstein <fnkl.kernel@gmail.com>
To:     u.kleine-koenig@pengutronix.de, thierry.reding@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sasha Finkelstein <fnkl.kernel@gmail.com>
Subject: [PATCH v6 5/5] MAINTAINERS: Add entries for Apple PWM driver
Date:   Fri,  6 Jan 2023 16:58:45 +0300
Message-Id: <20230106135839.18676-6-fnkl.kernel@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20230106135839.18676-1-fnkl.kernel@gmail.com>
References: <20230106135839.18676-1-fnkl.kernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the MAINTAINERS entries for the driver

Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
Acked-by: Sven Peter <sven@svenpeter.dev>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7f86d02cb427..75bda5ab704d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1970,6 +1970,7 @@ F:	Documentation/devicetree/bindings/nvmem/apple,efuses.yaml
 F:	Documentation/devicetree/bindings/pci/apple,pcie.yaml
 F:	Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
 F:	Documentation/devicetree/bindings/power/apple*
+F:	Documentation/devicetree/bindings/pwm/pwm-apple.yaml
 F:	Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
 F:	arch/arm64/boot/dts/apple/
 F:	drivers/bluetooth/hci_bcm4377.c
@@ -1985,6 +1986,7 @@ F:	drivers/mailbox/apple-mailbox.c
 F:	drivers/nvme/host/apple.c
 F:	drivers/nvmem/apple-efuses.c
 F:	drivers/pinctrl/pinctrl-apple-gpio.c
+F:	drivers/pwm/pwm-apple.c
 F:	drivers/soc/apple/*
 F:	drivers/watchdog/apple_wdt.c
 F:	include/dt-bindings/interrupt-controller/apple-aic.h
-- 
2.37.1 (Apple Git-137.1)

