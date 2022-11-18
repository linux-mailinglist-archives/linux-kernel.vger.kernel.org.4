Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06B362EDC1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 07:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241207AbiKRGje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 01:39:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241039AbiKRGjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 01:39:24 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C889B39B
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 22:39:23 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id ja4-20020a05600c556400b003cf6e77f89cso5908887wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 22:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Z2ww0YVduqN9H48bn9HG3zBTh+Dyi1ex1+txj8Fhzk=;
        b=KVTpBwOVLozFUlG6MJ1vQIRgPlZzj4g4kpHAxhFX38nkmw8yxnEKXX4WLw7XgTbSUN
         xJklu3r/kZkvbLfWt7h+k3GcJkVxGKKc9cDYIhoTneR0k4mANd5IGv2R3IsIKBA2i7Bv
         Mhi2RobfzrpFZ+3030kUehcCgNRt5pCzquCYNTyOGyCZD1EgVq8oucsB8rGEXG/3X02S
         RnlKwHMC4slH+64m9IFeUrsn0vE0B6Sb4pIaQOni1ngl+1wrwfMKNjYuipGDtRVihnyN
         324ILOtYe7MMImIHDOiEQVFPMk2we1weI3Rxl9NqBSTvcH2OwOI9J2JP6pEtbqPGkvT2
         0uvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Z2ww0YVduqN9H48bn9HG3zBTh+Dyi1ex1+txj8Fhzk=;
        b=WxXkGBfLUvzmHLA9EA4i4NJjpZMw91LoEvcpt7nP9dvwwZtib5XAs1U+taKgrPU6VC
         dFbTO4M4QIiG8HzP76SlnrvMoJr2zkYJ57bUJJzrAw+qfXsW8gRJU9t1oyXTDP0zrcuS
         VRkmvyjFHRvb3jhCY0nrOy0eVZBR824qOTH26V6WDOMRikzqpPEDZRsCY5JRPhnBtz8A
         0mtk+OEXXWJWJ5cog1d3tfRbXNx65w061kcVWWV4AguD4XxNlOLS+xxJP3WtzjgTH1Yn
         E+/eATJ1cOJHQ9d4p3EM1zj/CqeWMyagu04cMa5lwW5+r2A4he1FsibPbckTwLunZa/I
         hGgQ==
X-Gm-Message-State: ANoB5pn+ZdIF/Ki6q7P6ptZAq2Z+7iA3ZOr4S6QsbtIPaBG/7cPBZ7gY
        qUkfZ9c2pf2q1TT/cwJ6zkQsfA==
X-Google-Smtp-Source: AA0mqf7HoUJQ11Z37ggfdM73qnbyQFtNOLanfeYhtFWy2nCgRVFBJSP1RJyTzBj7f6sfZP0SJUfRqA==
X-Received: by 2002:a05:600c:5010:b0:3cf:b067:416c with SMTP id n16-20020a05600c501000b003cfb067416cmr7524156wmr.134.1668753562063;
        Thu, 17 Nov 2022 22:39:22 -0800 (PST)
Received: from localhost.localdomain ([167.98.215.174])
        by smtp.gmail.com with ESMTPSA id n24-20020a7bcbd8000000b003b4fdbb6319sm7853861wmi.21.2022.11.17.22.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 22:39:21 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Christian Lamparter <chunkeey@gmail.com>
Subject: [PATCH 3/4] nvmem: u-boot-env: fix crc32_data_offset on redundant u-boot-env
Date:   Fri, 18 Nov 2022 06:38:39 +0000
Message-Id: <20221118063840.6357-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221118063840.6357-1-srinivas.kandagatla@linaro.org>
References: <20221118063840.6357-1-srinivas.kandagatla@linaro.org>
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

From: Christian Lamparter <chunkeey@gmail.com>

The Western Digital MyBook Live (PowerPC 464/APM82181)
has a set of redundant u-boot-env. Loading up the driver
the following error:

| u_boot_env: Invalid calculated CRC32: 0x4f8f2c86 (expected: 0x98b14514)
| u_boot_env: probe of partition@1e000 failed with error -22

Looking up the userspace libubootenv utilities source [0],
it looks like the "mark" or "flag" is not part of the
crc32 sum... which is unfortunate :(

|static int libuboot_load(struct uboot_ctx *ctx)
|{
|[...]
|       if (ctx->redundant) {
|		[...]
|               offsetdata = offsetof(struct uboot_env_redund, data);
|		[...]					//-----^^
|       }
|       usable_envsize = ctx->size - offsetdata;
|       buf[0] = malloc(bufsize);
|[...]
|	for (i = 0; i < copies; i++) {
|		data = (uint8_t *)(buf[i] + offsetdata);
|               uint32_t crc;
|
|		ret = devread(ctx, i, buf[i]);
|		[...]
|		crc = *(uint32_t *)(buf[i] + offsetcrc);
|               dev->crc = crc32(0, (uint8_t *)data, usable_envsize);
|

[0] https://github.com/sbabic/libubootenv/blob/master/src/uboot_env.c#L951
Fixes: d5542923f200 ("nvmem: add driver handling U-Boot environment variables")
Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
---
 drivers/nvmem/u-boot-env.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/u-boot-env.c b/drivers/nvmem/u-boot-env.c
index 8e72d1bbd649..4fdbdccebda1 100644
--- a/drivers/nvmem/u-boot-env.c
+++ b/drivers/nvmem/u-boot-env.c
@@ -135,7 +135,7 @@ static int u_boot_env_parse(struct u_boot_env *priv)
 		break;
 	case U_BOOT_FORMAT_REDUNDANT:
 		crc32_offset = offsetof(struct u_boot_env_image_redundant, crc32);
-		crc32_data_offset = offsetof(struct u_boot_env_image_redundant, mark);
+		crc32_data_offset = offsetof(struct u_boot_env_image_redundant, data);
 		data_offset = offsetof(struct u_boot_env_image_redundant, data);
 		break;
 	}
-- 
2.25.1

