Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A92162F599
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 14:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241099AbiKRNL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 08:11:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235233AbiKRNL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 08:11:26 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CBF13CE1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 05:11:25 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id d20so6669400ljc.12
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 05:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nIM9IJHvjSzw+04HWZDmFjpgziYaBBenK0g63oaaMjk=;
        b=Yz5TWVMdPelgFeIJEe0H3DNPz7fP46OEIDsAPBnhpv3CDel+1moOrQxzgD9JDtVTSB
         /Wh39v2++pMS+pwgjQXHh2d2HNlgp9eHPIoXQnoq/KIJhqDesDRX2gaYnYH5IQcAELBH
         lYYzxUIgiXYP4kHQfwd97qfEHSyrKljvBx+93BUxLhCfrZ03Oua4FFUb+Y9jqtT6+j6w
         27mZYsS3Z+3HQOvmeQa8gEE3Eq70MrtwxptaIyrTfGhMQnkjr2xDV73qY7qG1R753xy9
         iu/PRPIGrHGh9ArW3aBkXRU2v+fv5R8+1nS2swJnCk3GgeYk0gUyYUUcCEXh3jYWwVQ3
         m5mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nIM9IJHvjSzw+04HWZDmFjpgziYaBBenK0g63oaaMjk=;
        b=vAh914DPXOe/QJakRxctcFbtZJkc+2uRHWLRo3+XMUBWu6oTg0G+JhLZeztXZTOVWw
         t13Vk9LXKUMmP2L5BYbzIrm5RvxdDFfF3mrxXAFLkzbhJta/MSYo0mbBz3RJ2cJjRypU
         Obn2UYTIgjmURXXh7qOoypZGgSldeoFIN1eZibJPjytkEf+kwK8RUtsxahhyvbNOUFs4
         iiiapaZZSSIge5mY3CMmQDyAzV1P1EqJfUEhTbEJ+SberDYBWSVKKD+VO6J2wHQ1aDaB
         tWv2v0G59Ia+wP78ykD6PRzDxKuyuE13SeZBmqAUgaA2S5dBVBU2kLWHgq0sZYrkREaZ
         MWAQ==
X-Gm-Message-State: ANoB5pk2zecP4ET+VarnWGBVfEVXOQx+vctRTtl0Yq2mwH5T9W08kuz/
        jta4jiUBbIKyf+d+MUiJmR+ogw==
X-Google-Smtp-Source: AA0mqf5yn+KOf6EtmwlmS1kgrDG//w4YfEFuU9xQ7FATebFe9+RAJ5oq3MHP9BT4zpHfmwNXVY+DRA==
X-Received: by 2002:a05:651c:1074:b0:279:d60:ee7c with SMTP id y20-20020a05651c107400b002790d60ee7cmr2288379ljm.305.1668777083597;
        Fri, 18 Nov 2022 05:11:23 -0800 (PST)
Received: from localhost.localdomain ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id f13-20020a056512360d00b0049a4862966fsm653425lfs.146.2022.11.18.05.11.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 18 Nov 2022 05:11:22 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     patches@linaro.org, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Support Opensource <support.opensource@diasemi.com>
Subject: [PATCH] regulator: slg51000: Wait after asserting CS pin
Date:   Fri, 18 Nov 2022 14:10:35 +0100
Message-Id: <20221118131035.54874-1-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sony's downstream driver [1], among some other changes, adds a
seemingly random 10ms usleep_range, which turned out to be necessary
for the hardware to function properly on at least Sony Xperia 1 IV.
Without this, I2C transactions with the SLG51000 straight up fail.

Relax (10-10ms -> 10-11ms) and add the aforementioned sleep to make
sure the hardware has some time to wake up.

(nagara-2.0.0-mlc/vendor/semc/hardware/camera-kernel-module/)
[1] https://developer.sony.com/file/download/open-source-archive-for-64-0-m-4-29/

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/regulator/slg51000-regulator.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/regulator/slg51000-regulator.c b/drivers/regulator/slg51000-regulator.c
index 75a941fb3c2b..1b2eee95ad3f 100644
--- a/drivers/regulator/slg51000-regulator.c
+++ b/drivers/regulator/slg51000-regulator.c
@@ -457,6 +457,8 @@ static int slg51000_i2c_probe(struct i2c_client *client)
 		chip->cs_gpiod = cs_gpiod;
 	}
 
+	usleep_range(10000, 11000);
+
 	i2c_set_clientdata(client, chip);
 	chip->chip_irq = client->irq;
 	chip->dev = dev;
-- 
2.38.1

