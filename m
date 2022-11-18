Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2A7162EDC8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 07:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241303AbiKRGks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 01:40:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241189AbiKRGkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 01:40:15 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6F770A3C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 22:39:59 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id ja4-20020a05600c556400b003cf6e77f89cso5909527wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 22:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fORBBx5Dalv3728TA4FNRd9u4cERD5YyG75le3/Wv1I=;
        b=HCDr7sQh9WS0lIuVvehEbuZaf1rCN7IpqN+6bDlFiw+bfPApwxHFDlG0BakBgsZNeM
         WFtv/cbGhp4GLapTsBuAnysYJwEhovrozwQorzxAubC8hA1Ca9YiDeTUbhOIddadb/YK
         AU+F8iTn4XKA/wc4MouxJ8wv2FQqs4oe+HJ6Jl+1Daa0u5xZk44SOtZkXvXuX/bRkZ/a
         RvxrpekA2L2An10oo9ucfgtrHVi5a/DbXyPCcmaAsV9oDClmEQ+9v1bC9X8HXSV5O9Vt
         gyBLox7m65KWr1sy45hpbB8Axicd4Qp5DR+UL5dgC1NaX2aAlDPuR/HQlnc+qMSOXQtM
         ZYJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fORBBx5Dalv3728TA4FNRd9u4cERD5YyG75le3/Wv1I=;
        b=x/eLazZugre+2u0jIOdI8F8YEAYH/UNMsa+e9lpRu1pXhvSXPa+8HGwoa89pukPHrF
         DONqwN0d5M2XtA7Bu7z3vu2/kWzBLG1G0TEySK7u5z9BFzNOwibmax2Jvw+PvXQTo2nj
         WYMFPrNzMkRSc8XWy3HXV9UHYQ20FoZbdn9SAZE6F+ScghLBVdd+xBBadbkID4Y2wO7K
         o/0pCYiVluO767kWSkkUv4DkD0ea9DHsHESz1sQB/PSEKQYvf/TfkMCo/dxyj/rBVHPK
         oMA9tpuhwXT+ZOeUpYMZdkjOW95ztAWt+XvkMTjO39kTUXlR4tjlSlkacvrlyJzEPwT1
         lO+w==
X-Gm-Message-State: ANoB5pmG7D95ETiW7i7LAqD3NgoM32Zjtynan+jPQJReP7N/Rxg4rh70
        SnDjrAX1vAmEIFJFcxM6Po06JOwhk4pclg==
X-Google-Smtp-Source: AA0mqf7rSAwIvopn0dtCMD42r7e7DNpKbIzOMzGHnjk4MsucI6tDo4TI6vWycXkbJ74ZO7bQzfHFIA==
X-Received: by 2002:a05:600c:6885:b0:3cf:a80d:59cd with SMTP id fn5-20020a05600c688500b003cfa80d59cdmr3934885wmb.5.1668753598336;
        Thu, 17 Nov 2022 22:39:58 -0800 (PST)
Received: from localhost.localdomain ([167.98.215.174])
        by smtp.gmail.com with ESMTPSA id j13-20020adff54d000000b0023655e51c33sm2785902wrp.4.2022.11.17.22.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 22:39:57 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Jiangshan Yi <yijiangshan@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 05/13] nvmem: stm32: fix spelling typo in comment
Date:   Fri, 18 Nov 2022 06:39:24 +0000
Message-Id: <20221118063932.6418-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221118063932.6418-1-srinivas.kandagatla@linaro.org>
References: <20221118063932.6418-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiangshan Yi <yijiangshan@kylinos.cn>

Fix spelling typo in comment.

Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/stm32-romem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/stm32-romem.c b/drivers/nvmem/stm32-romem.c
index 6de565639d5f..d1d03c2ad081 100644
--- a/drivers/nvmem/stm32-romem.c
+++ b/drivers/nvmem/stm32-romem.c
@@ -19,7 +19,7 @@
 #define STM32_SMC_WRITE_SHADOW		0x03
 #define STM32_SMC_READ_OTP		0x04
 
-/* shadow registers offest */
+/* shadow registers offset */
 #define STM32MP15_BSEC_DATA0		0x200
 
 struct stm32_romem_cfg {
-- 
2.25.1

