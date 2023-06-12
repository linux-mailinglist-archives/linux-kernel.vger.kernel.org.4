Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E3D72C848
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 16:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237228AbjFLOYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 10:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238063AbjFLOYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 10:24:08 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CBD171D;
        Mon, 12 Jun 2023 07:22:36 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9745ba45cd1so670337466b.1;
        Mon, 12 Jun 2023 07:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686579754; x=1689171754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DWD8Em9iQLnTUuLRZcCjJmC8x71w7WKYWHctnvqWjcM=;
        b=UrjR4Sm21Jig2kw9TLJadnR48cNe7svhsKDHhX19FI35fyLw1hb+CGduSgC8GinNv8
         tGH7yfjy4hzA5M9ejqYDUzIB4F2y8e84Ijcmsq4ddBki6uSPOCa3s+SG9uBNAHUlQxy0
         yn7PtGQBJ97GSlmuCVPJdhYAd21+RyINYRBLzA93CpqMoi8LR915VUFshd7tSfbhhGMc
         sffXLFaBvH02/bzC5FtHhiN7t4C6CwzPdyfFD2KyZklURt7X995MRjBEHB+NzTWS3wZ1
         3n0VyED9tIW+mDhjp7M0hOfNkQH5QorhvW0HZfUpneqrHbIjdErtOzE/XUPZC4R0D0Zw
         B9UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686579754; x=1689171754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DWD8Em9iQLnTUuLRZcCjJmC8x71w7WKYWHctnvqWjcM=;
        b=Jmkt6EXBNFKXaHNS+utau1LgwOGQCJZ1xOh3Gpy0uLhfn0jleFYZ0Qa7zpGpnUhmwn
         PRZn3cNO2RI8gMLK4lEnuzhPLgORXMPc6EvBUoGPnzfPtWAj5Iqnc5yI1WsgyQFHJioB
         LG4HlW7gkCff5FV01UMCX6MqK3urJpwR8u8PnV68gHRRJThGhBpz96o+J26h1e6p9PD2
         r2DRrjpLD0VrPGCRQzvRzbCuHEXxW35GMNO7eHIa0noNPtvR/m78quiIJS5Rg1avp+N7
         xFgu94lVo5MGh+2KSNVAUPLlAfpoWAzf7zpriGSlkSC/U4FPVdszzmYmOooeGPC9BF7J
         Iw1Q==
X-Gm-Message-State: AC+VfDwZRPjSK7qy4oU32Rkw1JOcEmvGQ5j+dkc9Hmp7kAa6LLp4JT8K
        LQmAAg+Yo+CDJkgDn9k0Bd0=
X-Google-Smtp-Source: ACHHUZ6tgKdHjSYCwyURWnR8dHPA3/4aG1G6fKY2vnTGEJqtQWIHQJk8ctx1dWDeyhV4mpyzT0n5Vw==
X-Received: by 2002:a17:906:ef07:b0:96a:1c2a:5a38 with SMTP id f7-20020a170906ef0700b0096a1c2a5a38mr8317754ejs.11.1686579754219;
        Mon, 12 Jun 2023 07:22:34 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8109:aa3f:ead8::d8a0])
        by smtp.gmail.com with ESMTPSA id i8-20020a17090671c800b009659fa6eeddsm5262528ejk.196.2023.06.12.07.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 07:22:33 -0700 (PDT)
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     jic23@kernel.org, mazziesaccount@gmail.com
Cc:     krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mehdi Djait <mehdi.djait.k@gmail.com>
Subject: [PATCH v5 4/7] iio: accel: kionix-kx022a: Add an i2c_device_id table
Date:   Mon, 12 Jun 2023 16:22:07 +0200
Message-Id: <9950e3963600465e1177a20ad8a93a3927c026ef.1686578554.git.mehdi.djait.k@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1686578553.git.mehdi.djait.k@gmail.com>
References: <cover.1686578553.git.mehdi.djait.k@gmail.com>
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

