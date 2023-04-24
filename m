Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA216ED7C5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 00:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjDXWXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 18:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233288AbjDXWWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 18:22:50 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A488A56;
        Mon, 24 Apr 2023 15:22:44 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-94f7a7a3351so926807466b.2;
        Mon, 24 Apr 2023 15:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682374963; x=1684966963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F7UnLspN79oTl8aJsv0wYQL9xuvLZmb8AWbAng86EQc=;
        b=HoIPa5hy+R6fqIEnlncAi0AGqvCdrnpL6OBQaiSVZ18WqIf2edgVY9LYl+bMikSrkN
         r/8O+qCt32enMVnTKLp3hj1OOX9qY73qNPEhRQNoZdfNuQwJ/dwZKN70nTjWxruWLbXM
         jD1AOLEReaCCc3xeewbrJSKyQSLc8rBAmPSD3h63nfd136hbumENUKcRZS4L/N8emKrI
         7dZXSnLiuqRyjO+GW+Ft5iEfs8FXC7iEkG/RqzoWaz5inzeP47XDhbCt7K2BaOHHyG0b
         WjDuVGcYm252W7fodoUFGFErSF2a345DBs0rabNNW0K/Yr2hWq6JHjpY8NRM0Ztleb3S
         DUVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682374963; x=1684966963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F7UnLspN79oTl8aJsv0wYQL9xuvLZmb8AWbAng86EQc=;
        b=HLOp95BIB40SCRi4kIKFnzqGy/BXKM4DLqiKEvCehOSMmoUjJ0I4Sw1DD0apHcKpEK
         NvgqTN8xOqyY7Cm6n9EDcFxmTHl5ND13CA5wZfs78cxiO+dNqgcdG615pEbNObN/6MW8
         fG1NUj5KzgRO3iKjAKLkkBLHLW2aOUZxgImk2ZTlzPsJ/HJO8dofuqsF47KS46MoqH4Y
         KmhmZxQYnbZ7JLb3FrLvUjgbwUO918qkVNgy5pmIrn8EQMDjCkkIAjpbOYE41hQPc1rU
         oZYmyzOfRomWlG8HHdoMdYcdS9g7eHPsvrV5zswouYYnV2Hklp3gLd8wpm8kJOjBBaDp
         +60Q==
X-Gm-Message-State: AAQBX9cKrgYPVdnrAujJqEnS/jXAte2vVP+Ids3Dgmtuc165kjJf5gIZ
        yHRKnTY1Mt52VFt2WTdLQvQ=
X-Google-Smtp-Source: AKy350ZN1hMdvp9tzFz+8mgpgCkpWPOVRokeavOl6D8Yqrxa8ZFlVFtCtC5yhZMAvGgK1dNYAPHz2A==
X-Received: by 2002:a17:907:765a:b0:94f:39b4:e32c with SMTP id kj26-20020a170907765a00b0094f39b4e32cmr11873280ejc.43.1682374963034;
        Mon, 24 Apr 2023 15:22:43 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8109:aa3f:ead8::2fd0])
        by smtp.gmail.com with ESMTPSA id g21-20020a170906539500b0094efdfe60dcsm5870886ejo.206.2023.04.24.15.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 15:22:42 -0700 (PDT)
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     jic23@kernel.org, mazziesaccount@gmail.com
Cc:     krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mehdi Djait <mehdi.djait.k@gmail.com>
Subject: [PATCH v3 4/7] iio: accel: kionix-kx022a: Add an i2c_device_id table
Date:   Tue, 25 Apr 2023 00:22:24 +0200
Message-Id: <a232fe7a8104f8d1cddfc5950aa48748ea90bffa.1682373451.git.mehdi.djait.k@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1682373451.git.mehdi.djait.k@gmail.com>
References: <cover.1682373451.git.mehdi.djait.k@gmail.com>
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

Add the missing i2c device id 

Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
---
v3:                                                                             
- no changes, this patch is introduced in the v2 

 drivers/iio/accel/kionix-kx022a-i2c.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/accel/kionix-kx022a-i2c.c b/drivers/iio/accel/kionix-kx022a-i2c.c
index e6fd02d931b6..8f23631a1fd3 100644
--- a/drivers/iio/accel/kionix-kx022a-i2c.c
+++ b/drivers/iio/accel/kionix-kx022a-i2c.c
@@ -30,6 +30,12 @@ static int kx022a_i2c_probe(struct i2c_client *i2c)
 	return kx022a_probe_internal(dev);
 }
 
+static const struct i2c_device_id kx022a_i2c_id[] = {
+	{ .name = "kx022a", 0 },
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

