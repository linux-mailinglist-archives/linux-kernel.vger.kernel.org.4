Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED4687503CC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 11:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232421AbjGLJtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 05:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjGLJtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 05:49:07 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5F2B0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 02:49:04 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fbc656873eso81343045e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 02:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shruggie-ro.20221208.gappssmtp.com; s=20221208; t=1689155343; x=1691747343;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0GHv2Ft2S3kZ2O5gSuwY1F0w/gwmM+yHKS1s0Tu9JBg=;
        b=EiY5dgwuevH0xcmwb/QV67fO+EBxdcf1gYvwsRZw+Gye7G7A0qaI+1b1VxlcnGa8cG
         FoS7uFMN9BdJATK23qF8XksOIgUpdvmOxAXzE1i+r8o68/bOkrUAkg+/fvhb+UvZqWV6
         U1Q5+CJ/qiA1I05kWR6L3wkqFi/4NLfGYpCbFKiTAWHXT2GknMfgSeJaM8Gi0fadI1X3
         VgmWi0Ll5/gVUJf/1/LgH6I9Bpg838jcjkqO/fE5kf90pj4sWA9cN4U/Zihd0vf3ameP
         3fFnNzY39lEugt8F1FdC/tJ/GIo8JdpV+YkDJ98dOLrHDqtKvGfJrjDBkPRnKrOwiEpL
         QH/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689155343; x=1691747343;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0GHv2Ft2S3kZ2O5gSuwY1F0w/gwmM+yHKS1s0Tu9JBg=;
        b=edkZOrxXQkpsU+TDSwUOP18LnVD9jV6DkVJ603Xo3sqg31m5H0d4yZeBl/RagGTd94
         cuAlgtX3ukKwhqJiRCtMof6SqWeKbK578y5oGb8Okfn6JKVZK6q+WMi+RO/sulPdSduN
         5Ts5PROmLFAdvuwCmJHdTEnlxfSIGHAITpZ6/Yfho4gK1KHHQMqDuITWagApwd+v+x5W
         0y7nsM+s95drFgJB34aBDd9GXTgNrTk2/n8a+ZCjdVWIYgu15DqWCATgFs53mbo6ffhf
         gEFzAn4RrqEmyiFB5A4qRnSYQn/0IaD8X7LxwtpA4Cc8OC8kdIMa2VEIsAni2fx3QtSq
         6iYw==
X-Gm-Message-State: ABy/qLb1zeMBrjk8NJU/0U808/tTq6cEpG1fSwzQlms6meTrDLixcWex
        VWC8GhYXafUczh4qHphRVbXujQ==
X-Google-Smtp-Source: APBJJlF1g3G4yZ+xXhSACC1ATsRZbDX+nWFG6yn1Wg0hxlL1S5urfARH3YE4W4J3B/TRnr+x5HyVMA==
X-Received: by 2002:a5d:4909:0:b0:314:545b:4f3 with SMTP id x9-20020a5d4909000000b00314545b04f3mr18407939wrq.36.1689155343165;
        Wed, 12 Jul 2023 02:49:03 -0700 (PDT)
Received: from localhost.localdomain ([82.79.69.144])
        by smtp.gmail.com with ESMTPSA id y18-20020adffa52000000b00313f031876esm4604608wrr.43.2023.07.12.02.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 02:49:02 -0700 (PDT)
From:   Alexandru Ardelean <alex@shruggie.ro>
To:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl, andy@kernel.org,
        Alexandru Ardelean <alex@shruggie.ro>
Subject: [PATCH] gpio: 74xx-mmio: remove unneeded platform_set_drvdata() call
Date:   Wed, 12 Jul 2023 12:48:57 +0300
Message-Id: <20230712094857.218105-1-alex@shruggie.ro>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The platform_set_drvdata() was needed when the driver had an explicit
remove function.
That function got removed a while back, so we don't need to keep a pointer
(on 'dev->driver_data') for the private data of the driver anymore.

Signed-off-by: Alexandru Ardelean <alex@shruggie.ro>
---
 drivers/gpio/gpio-74xx-mmio.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpio/gpio-74xx-mmio.c b/drivers/gpio/gpio-74xx-mmio.c
index 0464f1ecd20d..c7ac5a9ffb1f 100644
--- a/drivers/gpio/gpio-74xx-mmio.c
+++ b/drivers/gpio/gpio-74xx-mmio.c
@@ -135,8 +135,6 @@ static int mmio_74xx_gpio_probe(struct platform_device *pdev)
 	priv->gc.ngpio = MMIO_74XX_BIT_CNT(priv->flags);
 	priv->gc.owner = THIS_MODULE;
 
-	platform_set_drvdata(pdev, priv);
-
 	return devm_gpiochip_add_data(&pdev->dev, &priv->gc, priv);
 }
 
-- 
2.40.1

