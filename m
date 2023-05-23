Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC83F70D11D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 04:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbjEWCVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 22:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjEWCVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 22:21:06 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3879C115;
        Mon, 22 May 2023 19:20:43 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-3311691ebd0so800665ab.1;
        Mon, 22 May 2023 19:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684808431; x=1687400431;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oYo4pMyUdPXoTIgJZPlxTi0wlXBCKivgPw4C35RfkhE=;
        b=mn3iqGGY8l5fJKxQExXBk5R7/B8z/k4w/kyn53w6x0qvFrxRDgs0mZVuVbDEjUA1xY
         +v98xGZ/ShB5GgbqyLcdZbdDjyAs+xYKZYoJxf9ThiRn27iTBsu2v65WoSvKb3p1HBeM
         FCJ6IAqXl7pssqGRKKTtVqpzoSFFOvIxZrdYF0iy5vczERT8uyF4bf07nBvJ9hNzmgwz
         ICfOtR2bs6+OCzXEbGhbc8tkqn4JZSAQLxjKznQ62WCQhC9HRkhKKqDbESP6BDzEghQQ
         VSFjtP7h1CJ8kejzjt2fBoc/kEIStBAcdKIDJpZeTmoDREjr4WjUcO6Q5cOBwzQ6ifGq
         NQTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684808431; x=1687400431;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oYo4pMyUdPXoTIgJZPlxTi0wlXBCKivgPw4C35RfkhE=;
        b=a2rdm5unTjVTubVhdo+l0d8s29E4CmA5xkQd0vbozdBs8lGvUC3vGI/1Tbumrtpe0u
         0x+Y8BoyUv7u/A7Bc5wgT9kx4BMMi0AY3gLLGLhyE6qIECg1X+7D1FksXkT94w8UtuGR
         /mJOWhMPflECeujcyq+JPffB6anR5ZAqyLUzcTG8uX1anVJ4KBKD+oePGsjisq+pWtDP
         f0Fd2YQd935T1yO90V/wzOEHCkcx1lJ++DPgoLSykVr42MCnpxmJl3jJK2C4mRNHtLkg
         gylhkQyTMcpsfMOnx/FItb4hh1P5UJmTtgEQfMYvaN+RAGzDW2hAjwngdwKRv0SlKMAD
         n/IQ==
X-Gm-Message-State: AC+VfDxCWfpDKBw9E5N5DxvgHcc4rrrM5c5oP2ZzhMw7Ybz+i2j2qeDO
        TZvEQE0dcvy73u0u9/BaeYY=
X-Google-Smtp-Source: ACHHUZ5Kd6TdxFRK6Z9xrvAwgxEGZNeFR9ha6BzgqUmsqqM0uV2dgyzRx8l2DxbFe8V8Ji5a7mCsaA==
X-Received: by 2002:a92:ce49:0:b0:331:40f0:69b2 with SMTP id a9-20020a92ce49000000b0033140f069b2mr7973831ilr.31.1684808431028;
        Mon, 22 May 2023 19:20:31 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id cl9-20020a0566383d0900b0040faf78330asm2198932jab.28.2023.05.22.19.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 19:20:30 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] w1: sgi_w1: Replace all non-returning strlcpy with strscpy
Date:   Tue, 23 May 2023 02:20:23 +0000
Message-ID: <20230523022023.2406955-1-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strlcpy() reads the entire source buffer first.
This read may exceed the destination size limit.
This is both inefficient and can lead to linear read
overflows if a source string is not NUL-terminated [1].
In an effort to remove strlcpy() completely [2], replace
strlcpy() here with strscpy().
No return values were used, so direct replacement is safe.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
[2] https://github.com/KSPP/linux/issues/89

Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
---
 drivers/w1/masters/sgi_w1.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/w1/masters/sgi_w1.c b/drivers/w1/masters/sgi_w1.c
index e8c7fa68d3cc..d7fbc3c146e1 100644
--- a/drivers/w1/masters/sgi_w1.c
+++ b/drivers/w1/masters/sgi_w1.c
@@ -93,7 +93,7 @@ static int sgi_w1_probe(struct platform_device *pdev)
 
 	pdata = dev_get_platdata(&pdev->dev);
 	if (pdata) {
-		strlcpy(sdev->dev_id, pdata->dev_id, sizeof(sdev->dev_id));
+		strscpy(sdev->dev_id, pdata->dev_id, sizeof(sdev->dev_id));
 		sdev->bus_master.dev_id = sdev->dev_id;
 	}
 

