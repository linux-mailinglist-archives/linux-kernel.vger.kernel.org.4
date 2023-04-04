Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05E006D6A80
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 19:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236277AbjDDRYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 13:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236073AbjDDRXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:23:54 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3355D1989
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 10:23:11 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id w9so133614422edc.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 10:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680628987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mFsfV7hsM6XKzUvXvJ4Lm+4Z62w55R1k2YUgVy5mdyg=;
        b=EKmGUwG1k8r9F3oL6NMW2rFa5NIEDu14lDh1zopBRj7aBtdPn6ev4Du9Y+y+cMmVtq
         R2oyw0/9YQ5WWaGLfkuJF+Xps4LhWz9E9+cuAmANFtnPsb4AJ/c1+2B5g2O54C9S/tMZ
         xLgKw3y1EQSS8z4xiqDZkHtrOyYYi7fCItjLHaq1Q+XwFJna28S1P0i3YNCXhA+vr4VK
         tCOAZNIJTAEd0eh3FEBo/+tAG1eikGoAjKyMKqr+gCUy33SB0auNm4xqYjfZBfbC+JdX
         OnHjMz6xtwSOI5X73YkQfMYg3rhS8DKhLcSuL8L7Ie7jDSz9qEbQm5vvzeBfkUXtQYIe
         jmmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680628987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mFsfV7hsM6XKzUvXvJ4Lm+4Z62w55R1k2YUgVy5mdyg=;
        b=2oxQT2VEQK4v4/Bd4twXcPFrMFWTbMHAhdV4VxGSqHYjSrTWBnEC1zCUsilTTuTw2+
         1Jk4spG90NV67xstYjLLm8J8Ryzz5REVJPqBMMhhG03qFQSdQy5H1FkACey7/y9d8sf9
         5Jiagv/y3pnhSYgO+IrMAyi8KqY3zL+n4XGc9wQaSqKn+L6qEVct9fPnA6hW1XCuyjIZ
         6dBb50Fy/oWjtFDLwMiZ7rkvDMYWYqYdNzajvXespIk1mmbe9DUW1dQLEKtHck7T+wr8
         4j1HyeDntXy7aAvur3hwtf27HsF0491nv2sRqkXxg0Bn+5AZT/BC5Sch0LEJaN3t0Dvt
         QOGg==
X-Gm-Message-State: AAQBX9cBJnMDk5Lpm4bvuh3hpexjNNuMAfOHnrEiOO260nAO6XmADCEx
        RUh++hqs13uE8VaYSOdO3Kjpxw==
X-Google-Smtp-Source: AKy350Zoqr6ggb/KrGaz12ITlEnFnQ3RxoLuz2e3aXAWAbAfFQyjPuI5+OAfcOwzs/ADx5ocuTLqug==
X-Received: by 2002:a17:906:13c9:b0:932:5f7d:db33 with SMTP id g9-20020a17090613c900b009325f7ddb33mr317322ejc.34.1680628987496;
        Tue, 04 Apr 2023 10:23:07 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id bv20-20020a170906b1d400b009447277c2aasm6208333ejb.39.2023.04.04.10.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 10:23:06 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 32/40] nvmem: vf610-ocotp: Use devm_platform_get_and_ioremap_resource()
Date:   Tue,  4 Apr 2023 18:21:40 +0100
Message-Id: <20230404172148.82422-33-srinivas.kandagatla@linaro.org>
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

According to commit 890cc39a8799 ("drivers: provide
devm_platform_get_and_ioremap_resource()"), convert
platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/vf610-ocotp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvmem/vf610-ocotp.c b/drivers/nvmem/vf610-ocotp.c
index 5b6cad16892f..ee9c61ae727d 100644
--- a/drivers/nvmem/vf610-ocotp.c
+++ b/drivers/nvmem/vf610-ocotp.c
@@ -219,8 +219,7 @@ static int vf610_ocotp_probe(struct platform_device *pdev)
 	if (!ocotp_dev)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	ocotp_dev->base = devm_ioremap_resource(dev, res);
+	ocotp_dev->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(ocotp_dev->base))
 		return PTR_ERR(ocotp_dev->base);
 
-- 
2.25.1

