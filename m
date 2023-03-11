Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1BF6B5B09
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 12:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjCKLSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 06:18:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjCKLR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 06:17:26 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B1E13F1B6
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 03:16:27 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id j11so30743787edq.4
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 03:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678533375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uuRNRUnU93a6QzL7hyyUbX01xfBSkCWeMzRh8r6dY6k=;
        b=OSKNFKBLStoHH04AWadAgOuCZnv36fo5IzfOIaNuZCGMjyhiwtHx57flpyIyXImOBS
         AOnoAUo6X5LMLLSwhZ2USn/BQoWF1uIQmH3DGbNO45NTGzmlG9donYuGvVNBVzZrSlDy
         Q4C91YI2sUpUFkVRk/L6i6bdPtOqL9Tfol3cc4V7LyPW3XQNqFD6cY3DQOoqfEtXFUoA
         eEPzPQPjj5JKIU/VM/1pjdiRG/oomPIwVw+ookvcS7wafKMTkGx/mjX4pOty/+dvCo0J
         wVBAnx1WIS5rpA8ybJk/gZ1Xdxr+jxWVh7YyQ+SiQfi52U2Fjzpx5fq9Sry/I4Df/smn
         zHtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678533375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uuRNRUnU93a6QzL7hyyUbX01xfBSkCWeMzRh8r6dY6k=;
        b=IVnG9F2I4Ewo3iqp3iSkKCaxS8jXKMiAC2EwqAHjk7y/250qJFpkXB2YEPtSd7ficG
         hbT1vdWZBQKxXqjd8zzZVzGV0eUEhF7IJn2mMoPG5MYFEzZEEqgBTANk0XP9pZz1SGxf
         Ns23Wy626P951Fd5Q01u9Mz/y4Z04wTVds8yYHA90DRNNQCtd3ZcsMgy6z1sT1qDbli9
         zGGYBr7hf4PRla1Eh3+Lvbn3NDAyqrfff+ixoMCpRjgVqEDOqC0JaehkV0nNdXilrSW/
         utGDdfORf9r/sr9w7pYUFkKN0lv1Lvov8TGpRESUuG2UiGtLx55cNBMdChEmX8nTO8Rg
         6f8w==
X-Gm-Message-State: AO0yUKW7BjtrwrDuGKK6HPN/lpStrHvYg833ccORkgDvc1VEfHC6ZWdb
        0Re6WFtshwJvuFFnS3pq1HD2/A==
X-Google-Smtp-Source: AK7set8Kdjni9+cAZV2vgir64mpALVb0+pcthopD9oyvGSB++vYCQDP/qesE4NY2LEPaRbJnpUf28w==
X-Received: by 2002:a17:907:7d8d:b0:8b1:387b:c0c8 with SMTP id oz13-20020a1709077d8d00b008b1387bc0c8mr33049728ejc.15.1678533374794;
        Sat, 11 Mar 2023 03:16:14 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:fa97:2d7c:bdd7:e1b])
        by smtp.gmail.com with ESMTPSA id a20-20020a1709065f9400b008be0b7242d5sm994267eju.90.2023.03.11.03.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 03:16:14 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Eric Tremblay <etremblay@distech-controls.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] hwmon: tmp512: mark OF related data as maybe unused
Date:   Sat, 11 Mar 2023 12:16:10 +0100
Message-Id: <20230311111610.251774-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230311111610.251774-1-krzysztof.kozlowski@linaro.org>
References: <20230311111610.251774-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver can be compile tested with !CONFIG_OF making certain data
unused:

  drivers/hwmon/tmp513.c:610:34: error: ‘tmp51x_of_match’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/hwmon/tmp513.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/tmp513.c b/drivers/hwmon/tmp513.c
index 47bbe47e062f..78cdd2d2d875 100644
--- a/drivers/hwmon/tmp513.c
+++ b/drivers/hwmon/tmp513.c
@@ -607,7 +607,7 @@ static const struct i2c_device_id tmp51x_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, tmp51x_id);
 
-static const struct of_device_id tmp51x_of_match[] = {
+static const struct of_device_id tmp51x_of_match[] __maybe_unused = {
 	{
 		.compatible = "ti,tmp512",
 		.data = (void *)tmp512
-- 
2.34.1

