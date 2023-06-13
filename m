Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418EB72DF50
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 12:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242001AbjFMKXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 06:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240592AbjFMKW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 06:22:59 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B096A1BC;
        Tue, 13 Jun 2023 03:22:58 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-97454836448so760746366b.2;
        Tue, 13 Jun 2023 03:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686651778; x=1689243778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gPk/R7dD6Ly8fW1Tyy1o3x176+lvXb3bFfGB8njVTZY=;
        b=qkCL8dwrb3Da+yUjN8ufICa7kUbNkrif0iILiMUpHxsNHo21ZnOud4ISpv/qFGAC1v
         DWWUWDXDqlSyaQF+dHhbCfu6qtFHlhd5JYtSGrKub4ac1p1r4TqjjbsreJ/J5moTRLxh
         E9ttABEdgZ8Qxe0hRUeXFxN14L+w/DHlBRUE/e2CBOMpLuofzBxSZBMu2c2bE4T+mot6
         r8D2TuJ5Ui2OOYEyVad/LD9iv8I1sA78deBz1QS++2NmTk+PfkbepyLP1m3rTIUhnMMg
         eJ0+NL/ajW3sLuTYNCLy/V0NA7OCoDz5zYI8M+vpdhmETTQE8aqQHWjoq+aoa/wA0+4m
         Gd0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686651778; x=1689243778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gPk/R7dD6Ly8fW1Tyy1o3x176+lvXb3bFfGB8njVTZY=;
        b=PZyxido82GgnamXJgAyUiY517g7UIs2cYF7n9+3whsc68hWkeAC3WFFiVqfJDXiW1p
         zJzeH8Kk7rO27WwSJ+TVrPPzcK4NACVksnSweZ9+29YZQIFRqMS7rdLuh4Aap0FwHH35
         0TieZyQq6r3tmSPkzwUW6jVas/wyxiTBJ8JthlLoYHEh3m6EZH8t2zZkbBCYG/UygYcE
         6hPFJTR4FUjm1Ol7kO95QOZC4RN66h5hSYNxdGiugGPfopVaKofiEygVS0PCcLgjJJDH
         cMpMwBa0wv6Y/atnnvEO+4ULwtKDVrhDCS2H/v7x/InYn1Uosz6ycXTnoHdsD3+4V5up
         SBfQ==
X-Gm-Message-State: AC+VfDwSlKgFtsZNQ+BQRRnwj5n7Vl9MYVXjIY0Pi9PSG/Rk8POF+nxk
        nPnFizw17JIEOUkHoaGYNkk=
X-Google-Smtp-Source: ACHHUZ44lSeo9gLJGpBwaYZlSaZ92gRw26y2H2aLCnNfP3Db4KbjyrJMCiCOupPWiIEblwRpQTCetg==
X-Received: by 2002:a17:907:6e1a:b0:974:5d6e:7941 with SMTP id sd26-20020a1709076e1a00b009745d6e7941mr11470308ejc.6.1686651778100;
        Tue, 13 Jun 2023 03:22:58 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8109:aa3f:ead8::298a])
        by smtp.gmail.com with ESMTPSA id b7-20020a170906038700b009787b18c253sm6492493eja.181.2023.06.13.03.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 03:22:57 -0700 (PDT)
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     jic23@kernel.org, mazziesaccount@gmail.com
Cc:     krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mehdi Djait <mehdi.djait.k@gmail.com>
Subject: [PATCH v6 4/7] iio: accel: kionix-kx022a: Add an i2c_device_id table
Date:   Tue, 13 Jun 2023 12:22:37 +0200
Message-Id: <9950e3963600465e1177a20ad8a93a3927c026ef.1686651032.git.mehdi.djait.k@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1686651032.git.mehdi.djait.k@gmail.com>
References: <cover.1686651032.git.mehdi.djait.k@gmail.com>
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

Add the missing i2c device id.

Acked-by: Matti Vaittinen <mazziesaccount@gmail.com>
Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
---
v6:
v5:
v4:
- no changes

v3:                                                                             
- no changes, this patch is introduced in the v2 

 drivers/iio/accel/kionix-kx022a-i2c.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/accel/kionix-kx022a-i2c.c b/drivers/iio/accel/kionix-kx022a-i2c.c
index e6fd02d931b6..b5a85ce3a891 100644
--- a/drivers/iio/accel/kionix-kx022a-i2c.c
+++ b/drivers/iio/accel/kionix-kx022a-i2c.c
@@ -30,6 +30,12 @@ static int kx022a_i2c_probe(struct i2c_client *i2c)
 	return kx022a_probe_internal(dev);
 }
 
+static const struct i2c_device_id kx022a_i2c_id[] = {
+	{ .name = "kx022a" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, kx022a_i2c_id);
+
 static const struct of_device_id kx022a_of_match[] = {
 	{ .compatible = "kionix,kx022a", },
 	{ }
@@ -42,6 +48,7 @@ static struct i2c_driver kx022a_i2c_driver = {
 		.of_match_table = kx022a_of_match,
 	  },
 	.probe_new    = kx022a_i2c_probe,
+	.id_table     = kx022a_i2c_id,
 };
 module_i2c_driver(kx022a_i2c_driver);
 
-- 
2.30.2

