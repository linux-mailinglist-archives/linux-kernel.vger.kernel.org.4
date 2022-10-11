Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35FE05FAABF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 04:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbiJKCuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 22:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiJKCuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 22:50:07 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D401903D
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 19:50:06 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d24so11980764pls.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 19:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hPNh+7zozCZCQIGjHwjwUzLGoqVgU+at5h43wvXVXJg=;
        b=LdvgWfakX4LVzBbs0EK5AeJl3Rx8WJWNKr824RWSKz4homFuJgfYJy0/Grn3JJUy2s
         pk7pynpodcWBB9ccAcSY4YvkfHJpiE1kWHxWF4jF2CxanMnTjL4W3pwxWVFK7rUZw69l
         S2HdgajLjQ8gWGhGLLIls7uCRmeZVqmgf412pJ7nlfv9ZuLDS/pBQtveWSjaF720u9HE
         Ed0/Glb7/wWFuBsljIa5rUR79Iv87FiiR64w96liK8YyXGG9MKoSm59GQEAqym47pGMW
         Kjldj1ctlGIOwp065O/0+EvwUENpLkENS8/Wo/KOi1EDxn9U8xAOJhW+xToRh+VjR4mz
         Zhlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hPNh+7zozCZCQIGjHwjwUzLGoqVgU+at5h43wvXVXJg=;
        b=PBAZV/J3oCb4cB4DD54FrbR1gwyL+bNXGtirsSvXQAjjcBVIJRMsO5o3CU9iZS8Ynf
         Gwvb6fxdcOdwnw8pBVYl9OrkYURR5K6zn2lGf9MW997saazfWsQkRq7uNCz3p2teDDG2
         NV3OHxBPCQzWtgD1PnEFQzF4CncaEy6qXE+1pOUm1obeDSwQZwkBUXgPhVjySWx4LH4Z
         pMaMpOrzidJRfaU9CFhS+vsN9pBpPqaOT1WBYwO77vTm1G7ngUS0KX2QRc7fIuHjwpqY
         iPOx9nb13wvSGR+dea/p64t2Z/IA4NzY4OI7F3cj1NUwmepGtBOEGxpDFP138xrUcIrJ
         aImQ==
X-Gm-Message-State: ACrzQf2/dTxfLVEZK32XFoHLLNF2gE9e34abr4DdfMrG/EHOMoy1cA2E
        E74nEp+WZYv9zJU6l5QHjNwf7YAb9PY=
X-Google-Smtp-Source: AMsMyM6/op0yuVsqVf9RZW238v11oJyCYNmsh7+PIhscKlY9GbhXnFrdmcjaD0xfFEQcicvDuGMqRg==
X-Received: by 2002:a17:902:ead1:b0:181:991f:2d25 with SMTP id p17-20020a170902ead100b00181991f2d25mr12703153pld.107.1665456605586;
        Mon, 10 Oct 2022 19:50:05 -0700 (PDT)
Received: from localhost.localdomain ([240b:12:500:6500:74f7:9801:c5fa:632])
        by smtp.gmail.com with ESMTPSA id d4-20020a170902e14400b00183ba0fd54dsm185342pla.262.2022.10.10.19.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 19:50:05 -0700 (PDT)
From:   INAGAKI Hiroshi <musashino.open@gmail.com>
To:     rafal@milecki.pl, srinivas.kandagatla@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        INAGAKI Hiroshi <musashino.open@gmail.com>
Subject: [PATCH] nvmem: u-boot-env: align endianness of crc32 values
Date:   Tue, 11 Oct 2022 11:49:28 +0900
Message-Id: <20221011024928.1807-1-musashino.open@gmail.com>
X-Mailer: git-send-email 2.35.2.windows.1
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

Signed-off-by: INAGAKI Hiroshi <musashino.open@gmail.com>
---
 drivers/nvmem/u-boot-env.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/u-boot-env.c b/drivers/nvmem/u-boot-env.c
index 8e72d1bbd649..983dc2312af2 100644
--- a/drivers/nvmem/u-boot-env.c
+++ b/drivers/nvmem/u-boot-env.c
@@ -143,7 +143,7 @@ static int u_boot_env_parse(struct u_boot_env *priv)
 	crc32_data_len = priv->mtd->size - crc32_data_offset;
 	data_len = priv->mtd->size - data_offset;
 
-	calc = crc32(~0, buf + crc32_data_offset, crc32_data_len) ^ ~0L;
+	calc = le32_to_cpu(crc32(~0, buf + crc32_data_offset, crc32_data_len) ^ ~0L);
 	if (calc != crc32) {
 		dev_err(dev, "Invalid calculated CRC32: 0x%08x (expected: 0x%08x)\n", calc, crc32);
 		err = -EINVAL;
-- 
2.25.1

