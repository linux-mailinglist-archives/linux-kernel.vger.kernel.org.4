Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F026D6A7F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 19:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236270AbjDDRYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 13:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236118AbjDDRXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:23:51 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB1D525D
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 10:23:07 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id cn12so133624026edb.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 10:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680628986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uvAzoe1b3cbHk9YpQHH8E4MaQt9Ov/zayig/gEAkSYY=;
        b=FejMfnLgJLRtcGzWR6AUIdcnn41XEKgD68h25XfjtAKnbiIwJV1bm5ynjnN/2rRfuW
         ipuIi+JZZqMRx35LuiihXedJpHzuELyijxgAFyy+SSWwnSm5GFH1R+g6Gwi7cBZTH+e1
         LwrGtZrlKgqZIHXqBD3ZJghrj3vtzkdQxSCmpCbPWQmXbFH+uTRyWioM53z5CbydYaXM
         zWbz7fWoO8Un2B7IG4tgSu+KxfvQ6+l/JFy+wTlqZKQE35vJYdzaSkchiKf5JcJpdwHx
         oUw1pMmPYaiwpT0MQ1tZBdNueJcg7J4rgNIkDpa3RcwhALp+rXKNI8NoyccXvcJrjx4T
         /UoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680628986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uvAzoe1b3cbHk9YpQHH8E4MaQt9Ov/zayig/gEAkSYY=;
        b=42B8w2qi1z4GpHcDkYQQuxHWeMYXr70VwqMV4rHsCRxQbp5MrCxKjc9ewLuxRMxUsM
         3DJdssdMHVbAii4INPiZJDSNUzrcAdW2WZDni5YznR5YDjbAhcAJv5gEOx4pZZ7eCEJU
         SFbp/lHBtqXkI4tTTXAVgcZOb012tW5bHB1SR+QO9ySeQFd3vPSeYfMicCWfXwLH8ReT
         xh2yqsJw4f3XMfsJl691XLIJWMqpNigIGSgouW09V6yuOFY+yu35mgHeaTutB9LxM9E0
         i7HgAP/I3AGws1VwsHPE3G3y5QW0VvLF4ISDVkMxgF/V/0HTFBi8tgdxzsAkxJot0hsA
         m6rw==
X-Gm-Message-State: AAQBX9c9ecZE9PCcgFgYWfor26RQ6kL4BIhl/INwcwyQO76YpD/j3dtO
        +VxFpI78nKS1YF4AW86qgrgBeA==
X-Google-Smtp-Source: AKy350a7ukTbSV4sHBKuqpeH7f3yaADFNC85upAJVD0nscoxc1trtoS1mW16cVomAIS5crwk+TsVig==
X-Received: by 2002:a17:906:c253:b0:88c:6345:d0e7 with SMTP id bl19-20020a170906c25300b0088c6345d0e7mr330912ejb.36.1680628985932;
        Tue, 04 Apr 2023 10:23:05 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id bv20-20020a170906b1d400b009447277c2aasm6208333ejb.39.2023.04.04.10.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 10:23:05 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 31/40] nvmem: nintendo-otp: Use devm_platform_ioremap_resource()
Date:   Tue,  4 Apr 2023 18:21:39 +0100
Message-Id: <20230404172148.82422-32-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230404172148.82422-1-srinivas.kandagatla@linaro.org>
References: <20230404172148.82422-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Li <yang.lee@linux.alibaba.com>

According to commit 7945f929f1a7 ("drivers: provide
devm_platform_ioremap_resource()"), convert platform_get_resource(),
devm_ioremap_resource() to a single call to use
devm_platform_ioremap_resource(), as this is exactly what this function
does.

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/nintendo-otp.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/nvmem/nintendo-otp.c b/drivers/nvmem/nintendo-otp.c
index 33961b17f9f1..355e7f1fc6d5 100644
--- a/drivers/nvmem/nintendo-otp.c
+++ b/drivers/nvmem/nintendo-otp.c
@@ -76,7 +76,6 @@ static int nintendo_otp_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	const struct of_device_id *of_id =
 		of_match_device(nintendo_otp_of_table, dev);
-	struct resource *res;
 	struct nvmem_device *nvmem;
 	struct nintendo_otp_priv *priv;
 
@@ -92,8 +91,7 @@ static int nintendo_otp_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->regs = devm_ioremap_resource(dev, res);
+	priv->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->regs))
 		return PTR_ERR(priv->regs);
 
-- 
2.25.1

