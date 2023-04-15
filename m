Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 946476E30BF
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 12:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjDOKoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 06:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjDOKoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 06:44:03 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33859004
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 03:43:19 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-94ed301bba0so125715466b.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 03:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681555397; x=1684147397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PW9iSx5IP2gUGmfeEvoHgXw1NIUTLCMqNNP3AylUxdA=;
        b=u97N5aYGxUM2vtu5i8b70KpwA6ql/hlHHL8q/LpGxBX0WpaGP45Xix9afoFsymFy+v
         BlY66ql6Bo+C8ojSi5FHvaZaZ+lF75hKh47W7UCAJvNWrPMrscOS1BJ0//qYJVqw2j4T
         NV6CNwfajlTeJddXW7RhRtSyLrtzXS8mkDDm+XsPiXnd4CeaQ9l4jFm3FzhI6kcPzpAw
         BFsRHR7BEXviQriGJs2ofbV5magubWSi7V5kxpjqI+MOhoTCPSof/XZXAj/CPw4lujfC
         iTa8dOnCQ1SBqjdOiLBjCQWGTIYy0oqSSMv1NKLtSQCVoBrh5E2LFGk+AWYCNYFhFbhx
         VqiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681555397; x=1684147397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PW9iSx5IP2gUGmfeEvoHgXw1NIUTLCMqNNP3AylUxdA=;
        b=gDkJsky1CUenTKDmoeC5hnW0cG7kLmzZnvkUNekId2prp3hmuiMf4DDibS1HJbrq0c
         rxwJFTmiWJIo0NRX2HzIdccOXn7apvLpMBMh45BL1xD4zdHAEeLT7qJ9HCCz41lUFOfv
         GkhqvAr+mArgbQdKe1zb1AdLi0A0+g7jzojTPs8Cn44yxXAT8Tpps7bA0G9EfSZsk33c
         celHjI3xcsKbijZlsKWLBUc0IDl8IOjc3b33GFP8Ok62xLHYHYmQMnOFO87efb/g1DRY
         TW88RR5hM5tQS4kaZJlbDpykbGAaAwZKk/0jlyYPZev+hX+BzoyB9FC3yhIrjflMxrXe
         Bs6Q==
X-Gm-Message-State: AAQBX9cHtJBj3mNKwvdPLkkWw6rUZ+gwWj148XCM5NafAysTNMScNkWB
        xN65WgItTEryU8Xe3LFRFxXrUA==
X-Google-Smtp-Source: AKy350bjVhUQTb5JJQ7z/tqW66lylAGSuqRM4Coc7UVcca4c8McioxFauSi36KBt89MymEg2zw/R4w==
X-Received: by 2002:aa7:c2d4:0:b0:506:bdc:49c6 with SMTP id m20-20020aa7c2d4000000b005060bdc49c6mr9123965edp.23.1681555397563;
        Sat, 15 Apr 2023 03:43:17 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:a3bf:4ed:6c53:2a36])
        by smtp.gmail.com with ESMTPSA id b10-20020aa7d48a000000b004fd1ee3f723sm3157481edr.67.2023.04.15.03.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 03:43:17 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     Evgeniy Polyakov <zbr@ioremap.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 02/15] w1: ds2433: correct kerneldoc annotation
Date:   Sat, 15 Apr 2023 12:42:50 +0200
Message-Id: <20230415104304.104134-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230415104304.104134-1-krzysztof.kozlowski@linaro.org>
References: <20230415104304.104134-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct kerneldoc comments (or drop annotation) to fix:

  w1_ds2433.c:46: warning: This comment starts with '/**', but isn't a kernel-doc comment.
  w1_ds2433.c:141: warning: This comment starts with '/**', but isn't a kernel-doc comment.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/w1/slaves/w1_ds2433.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/w1/slaves/w1_ds2433.c b/drivers/w1/slaves/w1_ds2433.c
index 0f72df15a024..6134ca2f37fe 100644
--- a/drivers/w1/slaves/w1_ds2433.c
+++ b/drivers/w1/slaves/w1_ds2433.c
@@ -42,7 +42,7 @@ struct w1_f23_data {
 	u32	validcrc;
 };
 
-/**
+/*
  * Check the file size bounds and adjusts count as needed.
  * This would not be needed if the file size didn't reset to 0 after a write.
  */
@@ -138,16 +138,17 @@ static ssize_t eeprom_read(struct file *filp, struct kobject *kobj,
 }
 
 /**
- * Writes to the scratchpad and reads it back for verification.
+ * w1_f23_write() - Writes to the scratchpad and reads it back for verification.
+ * @sl:		The slave structure
+ * @addr:	Address for the write
+ * @len:	length must be <= (W1_PAGE_SIZE - (addr & W1_PAGE_MASK))
+ * @data:	The data to write
+ *
  * Then copies the scratchpad to EEPROM.
  * The data must be on one page.
  * The master must be locked.
  *
- * @param sl	The slave structure
- * @param addr	Address for the write
- * @param len   length must be <= (W1_PAGE_SIZE - (addr & W1_PAGE_MASK))
- * @param data	The data to write
- * @return	0=Success -1=failure
+ * Return:	0=Success, -1=failure
  */
 static int w1_f23_write(struct w1_slave *sl, int addr, int len, const u8 *data)
 {
-- 
2.34.1

