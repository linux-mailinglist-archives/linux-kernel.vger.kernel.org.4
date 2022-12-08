Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB32D646F2D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 12:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiLHL6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 06:58:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiLHL6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 06:58:51 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5684E6B0;
        Thu,  8 Dec 2022 03:58:50 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id o5so1359280wrm.1;
        Thu, 08 Dec 2022 03:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=abg1wOX7oBRj4w0zd4B/AxlUTtvdPy8iDRTZot4FPCc=;
        b=SUZ0TTuTHGr+pTmUrUq9U23zWNby3XOBjqiTuPsT+xUZPcXELpiS6pwoAClkMZ7DCd
         e3wSoGElTVajsuFoxO17KJi51pD8i+MxwR8J9MZmP2+iP1SnOSVG83ItNuogRN9ZHPxw
         dL0SNWtANLD2nVsqz3OJKBkZ1kJ6UZQXBTWu4alhVPgfOTe4wgUksQbW1H2oUYaZ267y
         mxrQ+B07WhfWQN06HK+pvVkzl45+qUksAOE156H9i+mJikBmZTKxJGxdFRqtDqgWUyrv
         UXYQUGr+0QiSpc7wBowRbjKWPKb0KOSeeV5ho3oFcjMrhnqOx9Vx1u5K3ABxHeFRA3TX
         ++8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=abg1wOX7oBRj4w0zd4B/AxlUTtvdPy8iDRTZot4FPCc=;
        b=cZhwtcYhm9uq6ZjaZV5Y31uJBryJyT4NwIgGTsWXz5UrhfBJPEnpkrdWf4AzFcUnZE
         gLYua8/uK3Y8KgV95Zjqj//Mt6eP/V2H7D3ZKbDEo0gbXmZaQeNjJCIOz+6BTh9kpabR
         iCRd7g/AvPvgP0ZG47MgxnDqLpBlKkQtPS5ALOvsNKFZ16K/YDcVGe80GcHBrrjW37Q5
         pGeJjwoKhlpgzhUnLzLzAKngtEI/ucgSC4pTcW7B6nUC7rUSI8AxCy/LFTOH4SEXW741
         2OVMQEJsGqNWSOtRPW25lfkVOs3Q9YJy+s/FJWgsPEQqD6TWWaVn8zrNfYIX0GahjvA/
         fgsA==
X-Gm-Message-State: ANoB5pnfEaUYLvqaw8IS4fGogAE/qNXlgs3v7Mg0JyVHnC4jU3j9Aw/C
        gLs0ATIR71WM7r6oWPuRJWs=
X-Google-Smtp-Source: AA0mqf7c7TjMRGd5RmRUsRQgw5unXjI4LvNEbX8A8YgJASFV9su4ij/6hgyLnIYQG97/vN1C9LG1NA==
X-Received: by 2002:a05:6000:60c:b0:242:10ac:6ab2 with SMTP id bn12-20020a056000060c00b0024210ac6ab2mr30602872wrb.552.1670500728699;
        Thu, 08 Dec 2022 03:58:48 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id q21-20020a7bce95000000b003d1de805de5sm4674699wmj.16.2022.12.08.03.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 03:58:48 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: platform: exynos4-is: Fix spelling mistake "palne" -> "plane"
Date:   Thu,  8 Dec 2022 11:58:47 +0000
Message-Id: <20221208115847.2433777-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

There are spelling mistakes in a literal string and a comment. Fix them.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/media/platform/samsung/exynos4-is/fimc-is-errno.c | 2 +-
 drivers/media/platform/samsung/exynos4-is/fimc-is-errno.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/samsung/exynos4-is/fimc-is-errno.c b/drivers/media/platform/samsung/exynos4-is/fimc-is-errno.c
index 5d9f4c1cdc5e..7a48fad1df16 100644
--- a/drivers/media/platform/samsung/exynos4-is/fimc-is-errno.c
+++ b/drivers/media/platform/samsung/exynos4-is/fimc-is-errno.c
@@ -54,7 +54,7 @@ const char *fimc_is_param_strerr(unsigned int error)
 	case ERROR_DMA_INPUT_ORDER:
 		return "ERROR_DMA_INPUT_ORDER: Invalid order(DRC: YYCbCr,YCbYCr,FD:NO,YYCbCr,YCbYCr,CbCr,CrCb)";
 	case ERROR_DMA_INPUT_PLANE:
-		return "ERROR_DMA_INPUT_PLANE: Invalid palne (DRC: 3, FD: 1, 2, 3)";
+		return "ERROR_DMA_INPUT_PLANE: Invalid plane (DRC: 3, FD: 1, 2, 3)";
 	case ERROR_OTF_OUTPUT_WIDTH:
 		return "ERROR_OTF_OUTPUT_WIDTH: Invalid width (DRC: 128~8192)";
 	case ERROR_OTF_OUTPUT_HEIGHT:
diff --git a/drivers/media/platform/samsung/exynos4-is/fimc-is-errno.h b/drivers/media/platform/samsung/exynos4-is/fimc-is-errno.h
index 9dcbb9853ac0..809e117331c0 100644
--- a/drivers/media/platform/samsung/exynos4-is/fimc-is-errno.h
+++ b/drivers/media/platform/samsung/exynos4-is/fimc-is-errno.h
@@ -156,7 +156,7 @@ enum fimc_is_error {
 	ERROR_DMA_INPUT_BIT_WIDTH	= 34,
 	/* invalid order(DRC: YYCbCrorYCbYCr, FD:NO,YYCbCr,YCbYCr,CbCr,CrCb) */
 	ERROR_DMA_INPUT_ORDER		= 35,
-	/* invalid palne (DRC: 3, FD: 1, 2, 3) */
+	/* invalid plane (DRC: 3, FD: 1, 2, 3) */
 	ERROR_DMA_INPUT_PLANE		= 36,
 
 	ERROR_OTF_OUTPUT_NONE		= ERROR_COMMON_NONE,
-- 
2.38.1

