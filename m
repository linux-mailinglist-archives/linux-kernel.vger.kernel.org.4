Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01E6B6B6687
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 14:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjCLNR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 09:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbjCLNRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 09:17:07 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E2D5506A
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 06:16:04 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id cn21so8324100edb.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 06:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678626919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KE5rFRSNY3Q/YkZ38W0hdg7THXNsJMp1iUB9or3sg9g=;
        b=uUKBua1FfJkWXrYCGBn5TQiQSMB3DGJXyGyAz7zuNZOkY9LPh/tUN9SULhrWlRPb4X
         VqQ5fMiFELPYl67wSoLgUo2gBVsQRfOJQhdYbcEVkrYoHKwWwO9ypIyV1EINLPT+ZZgs
         d/osUrE+wYrRJ6on3dVbN04LbfFoXC2osnX9qFd1NMjWse8ZVkMHmyHWVCIMQ5ZhSOk+
         RfiYNRdla+dxqMIprKAwfvXMCRMbv5xiKuQZrvZ6z6HRLdJS1zDd+ulbHx4rJ1UnQsbp
         1yb/M2VUIOL0oPrPA8szP+F84ipPUHvYimYg/OuHSzQMrWHzRLUWDV6uLfDf+tUbZNCm
         7NPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678626919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KE5rFRSNY3Q/YkZ38W0hdg7THXNsJMp1iUB9or3sg9g=;
        b=sSsIzwG97qkzh4vWv+HxQpAX2rWNZnVCNDSC/q4a/r3RMET8EjAqNO3SCBWsUEt69v
         tE9Z5JA7HUI7BjN7XpcnWIOOszL+Mn06RLFx7YhJ+uMD48VzEZds7ERHizzCT5wtS5Jb
         7lWquW6ORwAWumhR4lzjJsvA7Sziev7OviCaHDAYGm+ResqdanQj9qHF1tUeFZudllSE
         /30YyLrCs/Jamz3mQzz8HQdMXywNbqvVhgLicpAXUzDRH+B69UPDylHY5gO21B8gaW1Y
         wqbyDszPwMG4V06toIPULivMQ85NkkO5JSez6QpNPxmNtUDl+0K74eBvSiESGwTxeg4/
         hzJQ==
X-Gm-Message-State: AO0yUKXSxxTieQAdfgu0d/NGakxlM9NJC31y4Gf5Cqyx8shtaKbi9Ool
        4bWLfonof00HYwzQoTTUFMcAYw==
X-Google-Smtp-Source: AK7set/jV+v2kqf8cIoZt/4tfBIC1+vmA4XuGDkG4lv/eNEAbKvFfkd5TYXPAaqHyNG91m76npWHUQ==
X-Received: by 2002:a17:906:4fd5:b0:8b1:78b8:4208 with SMTP id i21-20020a1709064fd500b008b178b84208mr35553479ejw.1.1678626918819;
        Sun, 12 Mar 2023 06:15:18 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id h26-20020a170906399a00b00915d58e56f0sm2223493eje.77.2023.03.12.06.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 06:15:18 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/4] Input: sun4i-ts: drop of_match_ptr for ID table
Date:   Sun, 12 Mar 2023 14:15:13 +0100
Message-Id: <20230312131514.351603-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230312131514.351603-1-krzysztof.kozlowski@linaro.org>
References: <20230312131514.351603-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver can match only via the DT table so the table should be always
used and the of_match_ptr does not have any sense (this also allows ACPI
matching via PRP0001, even though it might not be relevant here).  This
also fixes !CONFIG_OF error:

  drivers/input/touchscreen/sun4i-ts.c:392:34: error: ‘sun4i_ts_of_match’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/input/touchscreen/sun4i-ts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/sun4i-ts.c b/drivers/input/touchscreen/sun4i-ts.c
index 1117fba30020..577c75c83e25 100644
--- a/drivers/input/touchscreen/sun4i-ts.c
+++ b/drivers/input/touchscreen/sun4i-ts.c
@@ -400,7 +400,7 @@ MODULE_DEVICE_TABLE(of, sun4i_ts_of_match);
 static struct platform_driver sun4i_ts_driver = {
 	.driver = {
 		.name	= "sun4i-ts",
-		.of_match_table = of_match_ptr(sun4i_ts_of_match),
+		.of_match_table = sun4i_ts_of_match,
 	},
 	.probe	= sun4i_ts_probe,
 	.remove	= sun4i_ts_remove,
-- 
2.34.1

