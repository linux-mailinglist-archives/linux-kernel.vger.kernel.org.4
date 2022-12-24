Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD1C1655857
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 05:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbiLXESt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 23:18:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbiLXESk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 23:18:40 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2281C934
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 20:18:34 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id a16so5081494qtw.10
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 20:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vtremblay.dev; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k4vdG/0iY/nb14Dy6MULZKjjLy7LIhTxYUj/A1NLJF0=;
        b=XygGNbk6DiMvx9nSgEoerAkWmIYg2gt6vDmy4BJCTcHTf4tDGBfxpWLyqlHPGpQ43l
         qi2TDjgY0w/LoMXnHUr8gvDVTn/tcifFhduLdrvmHRnq3Y3aAbMqqJ8BM9bSmVoTd1mI
         O9AkypxLBC6SOta+0IOGmt4CzOlNfjGLwmiURNj10TWhHQQPqEUjeeO+A86vE6cBpWX9
         waTm83KYcO7/ocrGMa/79sH6i7iRzNEfXxMkhThcfd4I6aTuj7hyCE/24FbJg8oVxIxy
         srnDOzBAlRJLIQ0jNaRkDHnbiS2G68rqvAieu4cyi/GazZmXnkg855cQ4LgNGBDEr83C
         rGfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k4vdG/0iY/nb14Dy6MULZKjjLy7LIhTxYUj/A1NLJF0=;
        b=DoGgYCrtWZZeCsuUVfJd25oVULRdJsjL50MXCaD9bVgcPXJPpD/Qb9hr9X0fZN7nGe
         Bbu4ys49HfYqP5swEShpY3747fyqKSz7zvmxtX8vXfgf8VSIvTmIDLxFNLeunhHTr6+f
         pFiyxjwQUZcRbvSaTYtL+BXNKbfCamtkaBs4XfrZqE11WFZvmgqC3/Y/7kbG5nWnCMWU
         x+UPNuPnQQYCTr1W8JuYMz6oeGX2B/Syf3y0jo+l2mIj5tXQRhzd39xxBlM+YWjDc+6s
         CQ0JicGYs9Zl/DUqibKllXXf4HhG0SrHqRsIt9I78A5laqhrJ1pEYyOOj3iOn4BMuzcA
         ztyg==
X-Gm-Message-State: AFqh2krSFFRteQW9FuMbv/hZDx/f6gbxzZgYYuRGGVmiOUtd+vn7e1Du
        fSriuDwPPdUZ80UVTJer/cAK6SKZudbZialKo2FreL6d
X-Google-Smtp-Source: AMrXdXv/CfYBa9UlTcgOyKQB3tKZdlGUfNGw1ZGsyHWELieQ539dm8Y7UNcauHg7NdeEKIkh/MRlTw==
X-Received: by 2002:ac8:51d4:0:b0:3a8:1677:bc46 with SMTP id d20-20020ac851d4000000b003a81677bc46mr15081310qtn.49.1671855513376;
        Fri, 23 Dec 2022 20:18:33 -0800 (PST)
Received: from vtremblay.. (modemcable190.194-177-173.mc.videotron.ca. [173.177.194.190])
        by smtp.gmail.com with ESMTPSA id bm31-20020a05620a199f00b006fc94f65417sm3563630qkb.40.2022.12.23.20.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 20:18:32 -0800 (PST)
From:   Vincent Tremblay <vincent@vtremblay.dev>
Cc:     vincent@vtremblay.dev, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] spidev: Add Silicon Labs EM3581 device compatible 
Date:   Fri, 23 Dec 2022 23:18:25 -0500
Message-Id: <20221224041825.171345-1-vincent@vtremblay.dev>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible string for Silicon Labs EM3581 device.

Signed-off-by: Vincent Tremblay <vincent@vtremblay.dev>
---
 drivers/spi/spidev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 6313e7d0cdf8..319f8cc1cda8 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -702,6 +702,7 @@ static const struct spi_device_id spidev_spi_ids[] = {
 	{ .name = "m53cpld" },
 	{ .name = "spi-petra" },
 	{ .name = "spi-authenta" },
+	{ .name = "em3581" },
 	{},
 };
 MODULE_DEVICE_TABLE(spi, spidev_spi_ids);
@@ -728,6 +729,7 @@ static const struct of_device_id spidev_dt_ids[] = {
 	{ .compatible = "menlo,m53cpld", .data = &spidev_of_check },
 	{ .compatible = "cisco,spi-petra", .data = &spidev_of_check },
 	{ .compatible = "micron,spi-authenta", .data = &spidev_of_check },
+	{ .compatible = "siliconlabs,em3581", .data = &spidev_of_check },
 	{},
 };
 MODULE_DEVICE_TABLE(of, spidev_dt_ids);
-- 
2.37.2

