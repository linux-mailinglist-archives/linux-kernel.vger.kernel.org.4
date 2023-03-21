Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6A16C3B4C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 21:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbjCUUKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 16:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjCUUKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 16:10:30 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9477C4AFEB;
        Tue, 21 Mar 2023 13:10:28 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id j24so6055488wrd.0;
        Tue, 21 Mar 2023 13:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679429427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X3sRWBr+PliF3t3S61RydwIdOA8C6EcsmNWOgzG3D1M=;
        b=YZi7QU63GbqzzdmN+/5pEG2d+O/DspA7US1wESAmfyrOoMqqGlO9IFykpzzU83YbnC
         5rOlttgbLYPcC75tqj3B34I38Kez/DSpv/GdcqPu1Pj8NAYoDpLHxY6jQnTmLcoZ2jm6
         /g60F4cHYK426XmhWYIoMxS56ahx0H1a2CksCBeKGKsjD/3sZqVx8r/Ejuig09c2zMDv
         xgsg3/E/JGrsRLX+Lr8bw7LW+xFseIgbWmdCHsG27U4Qbxunxtr+546/WRfrqZHwvhjr
         JYZNTLtRvWFpFix1FWJzTJISbBA4Sdgkx4vcveaHZJ+NSU+3Ndtr/i+L86bwq3pAf63B
         5TVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679429427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X3sRWBr+PliF3t3S61RydwIdOA8C6EcsmNWOgzG3D1M=;
        b=bOh21GORC9k1AYZAFvoHWUUUiGXclXRaxn0a2khfwa5p5TCAo3TPEt/P/L189caRBt
         EBj7b4V1ZiUCjJ+jlzC+soK3Gye8Si5XzMpZvYxZ20TYf6R3dGtSnKdAUr4nmPow1Xgs
         nXte3u4gX9bAvxNSswYVGtA56El3WQ5MnBDTdWuOqDFz4HY4Yb/3GrxJ90KAG9rd5XJ+
         vunH+XEsNratrJXrMf3phFnIkLzgI2cAMW3uXqfZUdT7TM1AmLiLx41r3jgllwZBqQJr
         iMvwu0vmaIBG//Ri+PuxdM4ShJNGOYRMVCmOxRmqLTcOXYgooN8XGKacYYv1JCCP5bbm
         Zoiw==
X-Gm-Message-State: AO0yUKXaGg3tQB8u4J17JH2Issovd+eUVvPm1UFmn8EMHuk6IX6uKoYo
        6O5KXn93qVs/y9IEVP4v+QU=
X-Google-Smtp-Source: AK7set9VmXXb/FYvDhU9QUhQjMuq2dmyrZ/XRSDIMbbIWzUqlHdZ8sveucK12D1WWSZQ5cDsvdXGAw==
X-Received: by 2002:a05:6000:12c9:b0:2cf:f01f:ed89 with SMTP id l9-20020a05600012c900b002cff01fed89mr3041905wrx.24.1679429426793;
        Tue, 21 Mar 2023 13:10:26 -0700 (PDT)
Received: from atlantis.lan (255.red-79-146-124.dynamicip.rima-tde.net. [79.146.124.255])
        by smtp.gmail.com with ESMTPSA id b13-20020adff90d000000b002c54c92e125sm12107693wrr.46.2023.03.21.13.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 13:10:26 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, p.zabel@pengutronix.de,
        f.fainelli@gmail.com, jonas.gorski@gmail.com,
        william.zhang@broadcom.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH v3 1/4] dt-bindings: clk: add BCM63268 timer clock definitions
Date:   Tue, 21 Mar 2023 21:10:19 +0100
Message-Id: <20230321201022.1052743-2-noltari@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230321201022.1052743-1-noltari@gmail.com>
References: <20210315122605.28437-1-noltari@gmail.com>
 <20230321201022.1052743-1-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Add missing timer clock definitions for BCM63268.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 v3: no changes
 v2: change commit title, as suggested by Stephen Boyd

 include/dt-bindings/clock/bcm63268-clock.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/dt-bindings/clock/bcm63268-clock.h b/include/dt-bindings/clock/bcm63268-clock.h
index da23e691d359..dea8adc8510e 100644
--- a/include/dt-bindings/clock/bcm63268-clock.h
+++ b/include/dt-bindings/clock/bcm63268-clock.h
@@ -27,4 +27,17 @@
 #define BCM63268_CLK_TBUS	27
 #define BCM63268_CLK_ROBOSW250	31
 
+#define BCM63268_TCLK_EPHY1		0
+#define BCM63268_TCLK_EPHY2		1
+#define BCM63268_TCLK_EPHY3		2
+#define BCM63268_TCLK_GPHY1		3
+#define BCM63268_TCLK_DSL		4
+#define BCM63268_TCLK_WAKEON_EPHY	6
+#define BCM63268_TCLK_WAKEON_DSL	7
+#define BCM63268_TCLK_FAP1		11
+#define BCM63268_TCLK_FAP2		15
+#define BCM63268_TCLK_UTO_50		16
+#define BCM63268_TCLK_UTO_EXTIN		17
+#define BCM63268_TCLK_USB_REF		18
+
 #endif /* __DT_BINDINGS_CLOCK_BCM63268_H */
-- 
2.30.2

