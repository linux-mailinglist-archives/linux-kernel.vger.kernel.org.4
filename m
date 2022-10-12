Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D12215FC8BB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 17:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbiJLPw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 11:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiJLPwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 11:52:55 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1394DF1933
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 08:52:54 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id f140so16917820pfa.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 08:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BYv7c4KUBd0xCpxwZbRbmcR6Qvn3Q+cGlU4HGudyN4w=;
        b=Dez1cKwdxQUqQzO8T3MX8+GtOr9h2ZfHfDmWqOcl0c++hn3ExmSCCvlZ2wCieXmMnj
         GlzVqRwE9D3t50+iqu65+4eVsaZlHr9HyG7foq0T7D83wx/IwWi9xunLA+xymJilOnEW
         u51AGJskRokJJvRRe6Tk6s20o3prR8g+INZouPTfHp3vBJVuGRR+Az0cEb89HdFAzG3C
         03cBVVhQjepgd1ldMJNeVxCHUoyYI5ktZpAuaL+L80lbm8u+nudQTAitgU2M1PcIQqgb
         T/qIfnKc8pJXzmBCSxOsP6cBsXLacqND2PQBKwDiP5AXd8HWo9nIPjIEnXaqvEa79lCi
         lkPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BYv7c4KUBd0xCpxwZbRbmcR6Qvn3Q+cGlU4HGudyN4w=;
        b=drylGF1kxtBcqqaqT1KDXlcHfeltnqNW+2z9S901/WBa9Z0ITO6JsdFQOWOU3eoxyl
         Um6nam/q1RKhXOH5Lv2H7lFMW0xC9p6k71Ob0P1UovNV8h4RyBj1Dg6mwJ0Dzp0Hl8WZ
         EOv0pYUkVJunBSSmDfJ2ggM/FhVptWAM4uSyRhJv53q3el2+wPL9WZH+Iu7VfEqH9ML3
         pb3QA5RJH87zXzc6VTJObBwyBzBij8NXnFrMetQ4p/UpmqF3MbWxYaRp1htSVinZGZBR
         9+sWjH60f+2IcG0yLf4tZ4Bja9XynOkk2Oa1qYTVBVOk0nUBYmrWdQ4iKJHwXtvk6f+Z
         8UxA==
X-Gm-Message-State: ACrzQf2kHDah6hdaF7uFUuDynLcgpwR1ZNS87TtYNg4y+A18A86Jjy2g
        aNAS6OrloP9OARfIRICBZaA=
X-Google-Smtp-Source: AMsMyM7DdNhfKLdSuMahDIwxMJ4UmV0ej/6t4xk+V83YSGbKBBSkiF+PRX1pSzS0Yc+v+iK2Kpy8Lw==
X-Received: by 2002:a62:2983:0:b0:54e:7cd5:adb3 with SMTP id p125-20020a622983000000b0054e7cd5adb3mr30876255pfp.38.1665589973380;
        Wed, 12 Oct 2022 08:52:53 -0700 (PDT)
Received: from localhost.localdomain ([240b:12:500:6500:1939:6268:50e5:7ad0])
        by smtp.gmail.com with ESMTPSA id m15-20020a17090a158f00b0020d9df9610bsm190695pja.19.2022.10.12.08.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 08:52:53 -0700 (PDT)
From:   INAGAKI Hiroshi <musashino.open@gmail.com>
To:     rafal@milecki.pl, srinivas.kandagatla@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        INAGAKI Hiroshi <musashino.open@gmail.com>
Subject: [PATCH v2] nvmem: u-boot-env: align endianness of crc32 values
Date:   Thu, 13 Oct 2022 00:51:33 +0900
Message-Id: <20221012155133.287-1-musashino.open@gmail.com>
X-Mailer: git-send-email 2.36.1.windows.1
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

Fixes: f955dc1445069 ("nvmem: add driver handling U-Boot environment variables")

Signed-off-by: INAGAKI Hiroshi <musashino.open@gmail.com>
---
v1 -> v2

- add missing cast to __le32 for calculated crc32
  (reported by kernel test robot <lkp@intel.com>)

- add missing "Fixes:" tag

 drivers/nvmem/u-boot-env.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/u-boot-env.c b/drivers/nvmem/u-boot-env.c
index 8e72d1bbd649..b5aacf805fc6 100644
--- a/drivers/nvmem/u-boot-env.c
+++ b/drivers/nvmem/u-boot-env.c
@@ -143,7 +143,7 @@ static int u_boot_env_parse(struct u_boot_env *priv)
 	crc32_data_len = priv->mtd->size - crc32_data_offset;
 	data_len = priv->mtd->size - data_offset;
 
-	calc = crc32(~0, buf + crc32_data_offset, crc32_data_len) ^ ~0L;
+	calc = le32_to_cpu((__le32)crc32(~0, buf + crc32_data_offset, crc32_data_len) ^ ~0L);
 	if (calc != crc32) {
 		dev_err(dev, "Invalid calculated CRC32: 0x%08x (expected: 0x%08x)\n", calc, crc32);
 		err = -EINVAL;

base-commit: 60bbaad38109684b156e21112322e0a922f92cde
-- 
2.25.1

