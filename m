Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1DDC67B599
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 16:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236009AbjAYPLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 10:11:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236010AbjAYPLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 10:11:33 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF40358662;
        Wed, 25 Jan 2023 07:11:15 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id l8so14001255wms.3;
        Wed, 25 Jan 2023 07:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kTaBsHHaxY4hxEZyw1070cz+vHDzIdLfWWrgADCbRU8=;
        b=BRnb5DYVXtWCtvc3qdQxtfQDSxjmp+yfOM2pXEVaEXc37OixGwC1jFBPFhmKTx4PoM
         cphL1s7CofBvz5JRbnWE6RQqU6B4RL5Umhs+nBBVGb+ijp8jDNNvX5ik1SUFv9XCg1BF
         nuNwfWqorONjLl4u53U774sFsM/0aCGUxeRaILHFFBh5SbBGYExmc/Lk52S9RAgt7m4z
         5H8oQszL77/msmmj8xT9qURuXzeNvUYbdIqW4wgm4N3ci2pRXIOfanmDlu3loqIzIEzs
         wXoD8IBN/nCKqB1owFuvw267FFffKotZDSwEPcp1M49ubhfphBeY+axb5FSCnGPNSZyn
         eycg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kTaBsHHaxY4hxEZyw1070cz+vHDzIdLfWWrgADCbRU8=;
        b=N3kS5i/cI01Y1JxbRxAHJXbVLaE2YhqhMKFfK4kbML805KoFphCQ8LR9X0PldmgDDK
         aWwqmgqHa1YEavMKnHOfX+m7djqMLPd49KEWGaD/P2XTAKSJWEUsxg3Zlv1rjsTvtO/o
         XPACxHVP44Q4mEBM9lwmOhd/qq5gRS9QVrlOKFqALuyslaJpUDsVa2q8Kr2N/iTd2Uh3
         t2348T+ccdBC5rIJKhgOSR2GUSyp/G3Nr9aYmRZDFPNUzr/8ol/isKB6tAov4U+jfEYG
         E0rq9j/T0Qv2KyuGqtEJ67BdkxTR9FBYKLGaXiaJkSdgbnj/bQTxC//0V43SgwPX76IH
         Of4Q==
X-Gm-Message-State: AFqh2kpWFi1EZ/KqYUcX1GmLouVXd4vaV4WGiX+mC0ddsuC1sJOCKsI2
        Jlq/ohuRZurGSyIQDneKItM=
X-Google-Smtp-Source: AMrXdXsVMi89xiI+4LxZntiDgxj2YfyHgKghAGbA2sAo4gVujJ7zwlCxsirbMUpVHQC35a6Lk+uuNA==
X-Received: by 2002:a05:600c:1d22:b0:3d9:6bc3:b8b9 with SMTP id l34-20020a05600c1d2200b003d96bc3b8b9mr32542581wms.9.1674659474298;
        Wed, 25 Jan 2023 07:11:14 -0800 (PST)
Received: from localhost ([82.222.96.52])
        by smtp.gmail.com with UTF8SMTPSA id f39-20020a05600c492700b003dc0cb5e3f1sm2003392wmp.46.2023.01.25.07.11.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 07:11:13 -0800 (PST)
From:   Sasha Finkelstein <fnkl.kernel@gmail.com>
To:     u.kleine-koenig@pengutronix.de, thierry.reding@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sasha Finkelstein <fnkl.kernel@gmail.com>
Subject: [PATCH v7 5/5] MAINTAINERS: Add entries for Apple PWM driver
Date:   Wed, 25 Jan 2023 18:10:41 +0300
Message-Id: <20230125151041.55483-6-fnkl.kernel@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20230125151041.55483-1-fnkl.kernel@gmail.com>
References: <20230125151041.55483-1-fnkl.kernel@gmail.com>
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

