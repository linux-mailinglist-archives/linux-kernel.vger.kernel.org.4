Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC586946F1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 14:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbjBMNZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 08:25:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjBMNZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 08:25:15 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5E51A675
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 05:25:14 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id v23so13494076plo.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 05:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EkafyOrLt3RUyfltnAglG8wKJ6fpVLZAxlJPnJYqfYE=;
        b=ksPZ69KIE9G6Ie3vicEFlCwpIljmI5EYoddc2LJ3eUVJvvrGeklJrN7qSNCYV1dRGm
         zZYKdWQrZjaXs2g1qmcNZ35Ub2YfjSVUEgLVb9hD85rZx1zlt/A4tE1IMiUnK2mX1pS/
         Hz0Xas28Mr45MHb5P+CQrV+/YzDY8qkk3GLRZpJFbgGD1SnPhuR3b5/+shi3A/Vam5Dn
         z9iW3tf6tC2eEpoURNJz/oPeX35VXC+RhhM/mncwFmSkN/H5PXgY+lSc9furxpQ2m1OI
         ykfkuGs+WRiwGSAsPYcYztKHlKAW4PTnVXY10c/tqaTl+ufOYkpLqRsH8hQvRTNjYHgF
         uTYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EkafyOrLt3RUyfltnAglG8wKJ6fpVLZAxlJPnJYqfYE=;
        b=ojm9G/ZP/4YBI8B7QkXsaRqugb9jfQoUZLUucdIiB6eXewkf7JTNqh5szCsL5pQYmw
         Oha+keY0OILqtCvUM8h9apwF+MkXNPSSfuLdugob8fQPJoui/KkF0FJQSi8vj2o1u4g/
         xseTmKg0+qTwvZOLI1xEPkEKzjeVugSb4QWlGXPbIbUCIpVk/B22DQNzt1Nx2wkgQFth
         GBWafjeooaRojYt8wSnuV/dlWjJDbfOD3HCUxhKaZBVCcD/BKm6kh2rVn/QIFrl674JY
         zjHcJFpBqno1gGbClpafQDGRLQDZ9RosrJnNtZINuDx1XtUaMNPr5dhtTzsBHL9eTup1
         PZkA==
X-Gm-Message-State: AO0yUKVUJVQdWUExD7SVVSgfBhRb/VBM2my7P6dj/hpvvGwIjmQbPuFH
        vkTh6WAIZVH/3604WkCMT8KRyGu1xkk=
X-Google-Smtp-Source: AK7set/orqzuLRok7BgjDMtrLAUkGgYac29VjUXYvyNES5xR4nGLEWUfU/8QqKzBkoTPNEXVLrJ/cw==
X-Received: by 2002:a17:903:1245:b0:196:780a:ada8 with SMTP id u5-20020a170903124500b00196780aada8mr28923668plh.6.1676294714333;
        Mon, 13 Feb 2023 05:25:14 -0800 (PST)
Received: from localhost.localdomain ([240b:12:500:6500:d0ee:8447:4572:1f1d])
        by smtp.gmail.com with ESMTPSA id x24-20020a1709027c1800b0019a74afe97dsm5970807pll.187.2023.02.13.05.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 05:25:13 -0800 (PST)
From:   INAGAKI Hiroshi <musashino.open@gmail.com>
To:     rafal@milecki.pl, srinivas.kandagatla@linaro.org
Cc:     chunkeey@gmail.com, linux-kernel@vger.kernel.org,
        INAGAKI Hiroshi <musashino.open@gmail.com>
Subject: [PATCH v3] nvmem: u-boot-env: align endianness of crc32 values
Date:   Mon, 13 Feb 2023 22:23:51 +0900
Message-Id: <20230213132351.837-1-musashino.open@gmail.com>
X-Mailer: git-send-email 2.39.0.windows.2
MIME-Version: 1.0
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

This patch fixes crc32 error on Big-Endianness system by conversion of
calculated crc32 value.

Little-Endianness system:

  obtained crc32: Little
calculated crc32: Little

Big-Endianness system:

  obtained crc32: Little
calculated crc32: Big

log (APRESIA ApresiaLightGS120GT-SS, RTL8382M, Big-Endianness):

[    8.570000] u_boot_env 18001200.spi:flash@0:partitions:partition@c0000: Invalid calculated CRC32: 0x88cd6f09 (expected: 0x096fcd88)
[    8.580000] u_boot_env: probe of 18001200.spi:flash@0:partitions:partition@c0000 failed with error -22

Fixes: f955dc144506 ("nvmem: add driver handling U-Boot environment variables")

Signed-off-by: INAGAKI Hiroshi <musashino.open@gmail.com>
---
v2 -> v3

- fix sparse warning by using __le32 type and cpu_to_le32
- fix character length of the short commit hash in "Fixes:" tag

v1 -> v2

- wrong fix for sparse warning due to misunderstanding
- add missing "Fixes:" tag

 drivers/nvmem/u-boot-env.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvmem/u-boot-env.c b/drivers/nvmem/u-boot-env.c
index 29b1d87a3c51..164bb04dfc3b 100644
--- a/drivers/nvmem/u-boot-env.c
+++ b/drivers/nvmem/u-boot-env.c
@@ -117,8 +117,8 @@ static int u_boot_env_parse(struct u_boot_env *priv)
 	size_t crc32_offset;
 	size_t data_offset;
 	size_t data_len;
-	uint32_t crc32;
-	uint32_t calc;
+	__le32 crc32;
+	__le32 calc;
 	size_t bytes;
 	uint8_t *buf;
 	int err;
@@ -152,11 +152,11 @@ static int u_boot_env_parse(struct u_boot_env *priv)
 		data_offset = offsetof(struct u_boot_env_image_broadcom, data);
 		break;
 	}
-	crc32 = le32_to_cpu(*(__le32 *)(buf + crc32_offset));
+	crc32 = cpu_to_le32(*(uint32_t *)(buf + crc32_offset));
 	crc32_data_len = priv->mtd->size - crc32_data_offset;
 	data_len = priv->mtd->size - data_offset;
 
-	calc = crc32(~0, buf + crc32_data_offset, crc32_data_len) ^ ~0L;
+	calc = cpu_to_le32(crc32(~0, buf + crc32_data_offset, crc32_data_len) ^ ~0L);
 	if (calc != crc32) {
 		dev_err(dev, "Invalid calculated CRC32: 0x%08x (expected: 0x%08x)\n", calc, crc32);
 		err = -EINVAL;
-- 
2.25.1

