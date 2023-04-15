Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0855D6E30C0
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 12:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjDOKoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 06:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjDOKoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 06:44:03 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D702D9760
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 03:43:21 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id fy21so8887754ejb.9
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 03:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681555398; x=1684147398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oSLSErlIH/a5nW5Ta5oh6CbddfCcyu4mj1K7g4WIjAI=;
        b=HhTnbJQEImdGA4e+HXumaOJ6UMXiuni5QBZrUxtJ1Sug7SWnr1jkjOnSwg28LhxJU9
         xl78Bea62KjaIvGHIT8yrbvsAH0mPjKzR+J0pZN4zVam2IVLIBnJk/6pYrWtjBgeBFo9
         QiVdcQr7+X21OyvhCBa/G32aFyEvYF03A7oF+2hM42/k5bH3WBtb1TevhedL8muQSiHv
         WcdQNNLrMFUMq6L/AOUPsTi3fE3OKtkttB47mDIMXLn6iBpFh2mb2Jra1P/vhMOXdKwG
         7EcJnbAAPquWrfqYVCL3Ehu/E48EvM8hiMFluOBLYAwrq/Rdo3GIP+RtLfZvpEakgNxk
         3ebA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681555398; x=1684147398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oSLSErlIH/a5nW5Ta5oh6CbddfCcyu4mj1K7g4WIjAI=;
        b=jnI8ShW3qVgQbwFu1Pg9nqAyxBwptppksnfb0OzEJInuzUWr0aTULNg8QJxzu97Dvq
         MBplgjpJ0Tl+tQgH+8/4ySHBgU/Ff4yeLd35RbbZOiwyUVL5QwhLcqj82j5ewgUMxzyg
         gFqhUBy3BKSYYZuMzNiXlohkyI5/CaItKXBueoGhFlz/ulmfLb5GOa7KDAkXPgg0yC74
         LBVr9M18OhguSn/ij585yv+dA/BRDpKyuAiPEMEXOhYa5PwTKoKJENSJkVsqEwiXhFd8
         8AdEGAs0A5D7L/5fySLOc060FrcLeuYAmGhvCxXZYiX/juDnLAveGscckKRdJ/wBISjh
         xGFg==
X-Gm-Message-State: AAQBX9fQ15rAKCpjREbuBRewszacujsQAfYh/s+eGCuZ24x1Q0PmZZrn
        K7HTXvu/RWqQgTfhvS5he1OqaA==
X-Google-Smtp-Source: AKy350bVdWLpfybIr/5BIXy/EYZJTe3HRjjltyZoeJ6ALCY3Bkd7hTW/mmp3WSLZhqFffOHW7eauoA==
X-Received: by 2002:a17:906:b190:b0:94a:785e:6a46 with SMTP id w16-20020a170906b19000b0094a785e6a46mr1969337ejy.24.1681555398671;
        Sat, 15 Apr 2023 03:43:18 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:a3bf:4ed:6c53:2a36])
        by smtp.gmail.com with ESMTPSA id b10-20020aa7d48a000000b004fd1ee3f723sm3157481edr.67.2023.04.15.03.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 03:43:18 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     Evgeniy Polyakov <zbr@ioremap.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 03/15] w1: ds28e04: correct kerneldoc annotation
Date:   Sat, 15 Apr 2023 12:42:51 +0200
Message-Id: <20230415104304.104134-3-krzysztof.kozlowski@linaro.org>
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

  w1_ds28e04.c:57: warning: This comment starts with '/**', but isn't a kernel-doc comment.
  w1_ds28e04.c:149: warning: This comment starts with '/**', but isn't a kernel-doc comment.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/w1/slaves/w1_ds28e04.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/w1/slaves/w1_ds28e04.c b/drivers/w1/slaves/w1_ds28e04.c
index 6cef6e2edb89..f54d6afd79c3 100644
--- a/drivers/w1/slaves/w1_ds28e04.c
+++ b/drivers/w1/slaves/w1_ds28e04.c
@@ -53,7 +53,7 @@ struct w1_f1C_data {
 	u32	validcrc;
 };
 
-/**
+/*
  * Check the file size bounds and adjusts count as needed.
  * This would not be needed if the file size didn't reset to 0 after a write.
  */
@@ -146,16 +146,17 @@ static ssize_t eeprom_read(struct file *filp, struct kobject *kobj,
 }
 
 /**
- * Writes to the scratchpad and reads it back for verification.
+ * w1_f1C_write() - Writes to the scratchpad and reads it back for verification.
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
 static int w1_f1C_write(struct w1_slave *sl, int addr, int len, const u8 *data)
 {
-- 
2.34.1

