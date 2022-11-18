Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD3062EDCF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 07:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241316AbiKRGlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 01:41:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241200AbiKRGkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 01:40:18 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25DE89BA32
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 22:40:04 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id a11-20020a05600c2d4b00b003cf6f5fd9f1so3355164wmg.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 22:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o279ukS+Bt+egaLl8HbA3GsePbyggxWAGDfR0crVk/g=;
        b=scpFT3bAfFVSXpANih4rRWsfBMayxXOuI34OcIwoLK5lfPyADxCisXojdNSL6FeEf+
         CfWjzhr7rkoDGvcsC6Jv8+p+1nDOJlzYeH0pY5lUzii41gWrLEvrecplxfuKe09XugPT
         0OQgZF0zvCADXbnPKXTd28GAah+eaFABzAM3rHiT9eYBemEPAvNZxKcXLNs+n8cgwlLo
         2rbgweMqOkGmhSDZ6Ze8wztS3JuTyGYNnrAMaGHJvfM0A2uKKTd80CTmfQxdiE2kcUVx
         rrBGwgAZsKpCdm3YWS0UesgsJH2tOzpVBozgN+WeOghJUe3bOujoe1fpO7Zi3cf9RUUk
         FlHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o279ukS+Bt+egaLl8HbA3GsePbyggxWAGDfR0crVk/g=;
        b=40xhiFNV2mD5mjSqY+Y6pZrf/NHZ4Ojz9b+yS/j3KkKH7+F+1ROtayG2HFQrD2KkoF
         yiNDoRKMqVZOjj1UHp/dklgkFIgo7b2g+NBojfznpfnEGppS1DVUjUxnH0d1dLo0AhZI
         ETAOCCL4pka0wVkDQbVP+xXg0MqBKbo510R/wOAthGWbQierU41mcYsd0WIkO9Km4STj
         G2FlVbdrgqb4oQeAiBWklhvUVE/UayooLCTJA6WgpdQcyuu3Kjg6O3cI2XCxgLP1GIRS
         Tupqr6Y/NZMg4mVCQDkDMADzXMDNRQa+K1KCUv949C/e/7BApvchVf/HP//7qxBfU6nW
         vRvQ==
X-Gm-Message-State: ANoB5pnJvkZvQGCarOqqPwRiIfczzyqq6g0pj41g7tnlh+rILT20R8JN
        39Un5axDxM7DsJCBXLMVaG2U8lLiyvUkdg==
X-Google-Smtp-Source: AA0mqf4SLGZ5Cl5jYqMspBuNhQ0bux4QDk2RDDTgzzQ2XeOzYTxYbkcsF+NXIyv0Z/zNpzBdKPbM+Q==
X-Received: by 2002:a05:600c:5012:b0:3cf:486f:2700 with SMTP id n18-20020a05600c501200b003cf486f2700mr3971891wmr.83.1668753602660;
        Thu, 17 Nov 2022 22:40:02 -0800 (PST)
Received: from localhost.localdomain ([167.98.215.174])
        by smtp.gmail.com with ESMTPSA id j13-20020adff54d000000b0023655e51c33sm2785902wrp.4.2022.11.17.22.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 22:40:02 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 08/13] nvmem: u-boot-env: add Broadcom format support
Date:   Fri, 18 Nov 2022 06:39:27 +0000
Message-Id: <20221118063932.6418-9-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221118063932.6418-1-srinivas.kandagatla@linaro.org>
References: <20221118063932.6418-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

Broadcom uses U-Boot for a lot of their bcmbca familiy chipsets. They
decided to store U-Boot environment data inside U-Boot partition and to
use a custom header (with "uEnv" magic and env data length).

Add support for Broadcom's specific binding and their custom format.

Ref: 6b0584c19d87 ("dt-bindings: nvmem: u-boot,env: add Broadcom's variant binding")
Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/u-boot-env.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/nvmem/u-boot-env.c b/drivers/nvmem/u-boot-env.c
index 4fdbdccebda1..29b1d87a3c51 100644
--- a/drivers/nvmem/u-boot-env.c
+++ b/drivers/nvmem/u-boot-env.c
@@ -16,6 +16,7 @@
 enum u_boot_env_format {
 	U_BOOT_FORMAT_SINGLE,
 	U_BOOT_FORMAT_REDUNDANT,
+	U_BOOT_FORMAT_BROADCOM,
 };
 
 struct u_boot_env {
@@ -40,6 +41,13 @@ struct u_boot_env_image_redundant {
 	uint8_t data[];
 } __packed;
 
+struct u_boot_env_image_broadcom {
+	__le32 magic;
+	__le32 len;
+	__le32 crc32;
+	uint8_t data[0];
+} __packed;
+
 static int u_boot_env_read(void *context, unsigned int offset, void *val,
 			   size_t bytes)
 {
@@ -138,6 +146,11 @@ static int u_boot_env_parse(struct u_boot_env *priv)
 		crc32_data_offset = offsetof(struct u_boot_env_image_redundant, data);
 		data_offset = offsetof(struct u_boot_env_image_redundant, data);
 		break;
+	case U_BOOT_FORMAT_BROADCOM:
+		crc32_offset = offsetof(struct u_boot_env_image_broadcom, crc32);
+		crc32_data_offset = offsetof(struct u_boot_env_image_broadcom, data);
+		data_offset = offsetof(struct u_boot_env_image_broadcom, data);
+		break;
 	}
 	crc32 = le32_to_cpu(*(__le32 *)(buf + crc32_offset));
 	crc32_data_len = priv->mtd->size - crc32_data_offset;
@@ -202,6 +215,7 @@ static const struct of_device_id u_boot_env_of_match_table[] = {
 	{ .compatible = "u-boot,env", .data = (void *)U_BOOT_FORMAT_SINGLE, },
 	{ .compatible = "u-boot,env-redundant-bool", .data = (void *)U_BOOT_FORMAT_REDUNDANT, },
 	{ .compatible = "u-boot,env-redundant-count", .data = (void *)U_BOOT_FORMAT_REDUNDANT, },
+	{ .compatible = "brcm,env", .data = (void *)U_BOOT_FORMAT_BROADCOM, },
 	{},
 };
 
-- 
2.25.1

