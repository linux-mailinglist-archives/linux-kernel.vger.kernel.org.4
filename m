Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32BA3626A2F
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 16:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234922AbiKLPYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 10:24:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbiKLPYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 10:24:52 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E283B2BD
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 07:24:51 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id i82-20020a1c3b55000000b003cfd36eff5fso750640wma.3
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 07:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eEp+mAQXzPvNaa6LuhLI007Oidb2yp7pHuVhPsDBpfs=;
        b=pSUfGh6nJR1nnoqgSBkWvYv4Bm14yDL7kNHxbkG57jMcj9VC6q98UJaqDGBxNxqEOH
         siisnEVzwzPNvnYWX37h1pNLtXhsIWOO6YIuz/2Z5ozOMwpqccS+NZiGlm6KLPUiwkVU
         xI8yv6t0m/OchctrbUkBB34Com13xgFsx/UHsB0tAXy6AZGvsL9c4CYz5U7aWgxoZEDR
         eUDdycIoLxFlhJVqNl9/TIEXnR+1U8PLw9KNg4GxdCOQPkuY71NjZYm/Qu/+W6+KFycj
         SEoUL9ENuXiG2/UmzTNXtduT1ttoKE3V3OvBetPPD9jIleqOiPj0L+y6CRpRNq6aePCb
         B4yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eEp+mAQXzPvNaa6LuhLI007Oidb2yp7pHuVhPsDBpfs=;
        b=0Ig1t5w5CNsfzJO8qh1knsp+3Y/dbfxk1/6XpbNqI4hhY5mf7BAYIt6D+Jisuf+qIm
         5sc1eBoBSmKJUGKUBXhyYNzcOzcqLW0+IdiOOqS3r0saL/XMJG04Hj8vxpyx5fdhDCPd
         ce8lLPYuLC53W4sezQ2WS13GcbAw3ytUANHaJJIjeZHungDjMb3KlbCdmt+1vS1poAif
         8rDWCKG9ZiTpBwNQ6lnW+wWjCs3vteEhBma7bkqhQv9sDM3WM30Cg/DDqhTlnZSkaE+p
         LmhZjVf9Ob680irCIU9s5iyG9CpKICvRT5uwrxiRFdVQFhvCUA6iD84muJOESnkwmrSW
         faLQ==
X-Gm-Message-State: ANoB5pnxAYz932gZKtkDHT837GLQ0uEk0VhCFo/K87ZGyw5VcNqrPeVx
        IYgJPyNxkrpXog04S6rEETqR7PrdmSI=
X-Google-Smtp-Source: AA0mqf4sqZClh94khQM0Tzuv7Mor88pGg5ycfd6pkUXYkm5ttAlAmJKy+EmzwNWm9QwmObuj6YVTdw==
X-Received: by 2002:a05:600c:3ac7:b0:3cf:774b:ce5a with SMTP id d7-20020a05600c3ac700b003cf774bce5amr4253181wms.0.1668266690474;
        Sat, 12 Nov 2022 07:24:50 -0800 (PST)
Received: from localhost (94.197.38.186.threembb.co.uk. [94.197.38.186])
        by smtp.gmail.com with ESMTPSA id l22-20020a05600c16d600b003cf4eac8e80sm7686085wmn.23.2022.11.12.07.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 07:24:50 -0800 (PST)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     cw00.choi@samsung.com, krzysztof.kozlowski@linaro.org,
        myungjoo.ham@samsung.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] extcon: max77843: Replace irqchip mask_invert with unmask_base
Date:   Sat, 12 Nov 2022 15:24:46 +0000
Message-Id: <20221112152446.41690-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove use of the deprecated mask_invert flag. Inverted mask
registers (where a '1' bit enables an IRQ) can be described more
directly as an unmask register.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/extcon/extcon-max77843.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/extcon/extcon-max77843.c b/drivers/extcon/extcon-max77843.c
index 8e6e97ec65a8..1bc0426ce3f1 100644
--- a/drivers/extcon/extcon-max77843.c
+++ b/drivers/extcon/extcon-max77843.c
@@ -189,8 +189,7 @@ static const struct regmap_irq max77843_muic_irq[] = {
 static const struct regmap_irq_chip max77843_muic_irq_chip = {
 	.name           = "max77843-muic",
 	.status_base    = MAX77843_MUIC_REG_INT1,
-	.mask_base      = MAX77843_MUIC_REG_INTMASK1,
-	.mask_invert    = true,
+	.unmask_base    = MAX77843_MUIC_REG_INTMASK1,
 	.num_regs       = 3,
 	.irqs           = max77843_muic_irq,
 	.num_irqs       = ARRAY_SIZE(max77843_muic_irq),
-- 
2.38.1

