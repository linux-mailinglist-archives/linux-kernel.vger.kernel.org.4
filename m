Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E11E27420CF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 09:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbjF2HPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 03:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbjF2HPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 03:15:07 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31322117;
        Thu, 29 Jun 2023 00:15:06 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-51dd0205b2cso618504a12.1;
        Thu, 29 Jun 2023 00:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688022905; x=1690614905;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=thvMoW85YpoDD9DqAHD+r7lZvI1+3RLNdnIDoKSwMvo=;
        b=KUMUe3OAXpTmLkBxd7SKIOXEXv8B6k9/Ue/bVVu4DVT5n7R01OhAgnFsikqf9o3jGa
         je/YYsQI2qptIRLB9fd6SrxQwvmh/L1Lb8cyF15dZge1aV/wxn7L70EncETjCOywrdkl
         804uMSpUqHM1tHWHxsDTgZ9o3haSJVo8b8hKwL8yAxMRrrXqVuCNKpG/NKSrqgfwSZd6
         0wtMs5nrXaxr4HsIhyH37U44+oy1ZqLbYkALag9u2lmW46KrKCUFlJsb3gacMmAAv7Fw
         1IFGbXzzdc9CT7zg8sL3SZB0FeuXxCtWnH4rQqlXjG+PpOq7fRN3qPxu/TZwdmHejvvh
         lbMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688022905; x=1690614905;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=thvMoW85YpoDD9DqAHD+r7lZvI1+3RLNdnIDoKSwMvo=;
        b=IPLxqH/sxHUSToKypw6oAc4aU62zGtcy2hPrA4JRE52fbpbb1mUUAX9IuxHAowo7up
         etTs0PEuW3aJX0wteb8XxVeGxDWwT6TigVx2+M0WYgJqGy/yhTaN+ipxLKz+WvBALdyw
         NTwDTTZFwBVwhvn/gPE92WyAA9fIvhcSvuI29jnoQKIUhbCWXPGsHiNZAVQZcwdPx3tY
         uiYpny8R+PjNVJ1gxHfYqcOpxVRqdVFA41+XcwoIRNL0s9VXXV3gDodsTAdhPyFTQtOd
         EkU9KS5VeBIsCPI2BMimevuP96ykG0cgUtqXgPzGfPSPghyMVSalnexAU0xSK6XzLqT/
         azzA==
X-Gm-Message-State: AC+VfDyidMSLkv6dgxxb24tm4umf7LCP9r20xojshUnSbIEl94AOCvvV
        k5IUOvTdVN7S9P9QwFxl0w0=
X-Google-Smtp-Source: ACHHUZ667/WX4TLVu0v9Y52VPKGHmH9wZYDu+t1Z1fZv3Lf2UV5U2MGDaqmHtKG6rTxSJTJTUhKXgw==
X-Received: by 2002:a17:907:2d8f:b0:96a:2dd7:2ee0 with SMTP id gt15-20020a1709072d8f00b0096a2dd72ee0mr3256724ejc.5.1688022905033;
        Thu, 29 Jun 2023 00:15:05 -0700 (PDT)
Received: from localhost (dslb-094-220-187-252.094.220.pools.vodafone-ip.de. [94.220.187.252])
        by smtp.gmail.com with ESMTPSA id jo10-20020a170906f6ca00b0099290e2c161sm1183823ejb.89.2023.06.29.00.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 00:15:04 -0700 (PDT)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     Mark Brown <broonie@kernel.org>,
        Grant Likely <grant.likely@secretlab.ca>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] spi: bcm63xx: fix max prepend length
Date:   Thu, 29 Jun 2023 09:14:52 +0200
Message-Id: <20230629071453.62024-1-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.34.1
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

The command word is defined as following:

    /* Command */
    #define SPI_CMD_COMMAND_SHIFT           0
    #define SPI_CMD_DEVICE_ID_SHIFT         4
    #define SPI_CMD_PREPEND_BYTE_CNT_SHIFT  8
    #define SPI_CMD_ONE_BYTE_SHIFT          11
    #define SPI_CMD_ONE_WIRE_SHIFT          12

If the prepend byte count field starts at bit 8, and the next defined
bit is SPI_CMD_ONE_BYTE at bit 11, it can be at most 3 bits wide, and
thus the max value is 7, not 15.

Fixes: b17de076062a ("spi/bcm63xx: work around inability to keep CS up")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/spi/spi-bcm63xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index 9aecb77c3d89..07b5b71b2352 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -126,7 +126,7 @@ enum bcm63xx_regs_spi {
 	SPI_MSG_DATA_SIZE,
 };
 
-#define BCM63XX_SPI_MAX_PREPEND		15
+#define BCM63XX_SPI_MAX_PREPEND		7
 
 #define BCM63XX_SPI_MAX_CS		8
 #define BCM63XX_SPI_BUS_NUM		0
-- 
2.34.1

