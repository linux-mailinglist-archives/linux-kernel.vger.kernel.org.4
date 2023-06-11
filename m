Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384AC72B239
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 16:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234302AbjFKOFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 10:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234017AbjFKOFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 10:05:07 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2EA13AA1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 07:04:24 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f6dfc4dffaso25123445e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 07:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686492249; x=1689084249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I5LVSJ/KpblThuSqW4J6VDfKcrwlokKdeIZWgfyq/b0=;
        b=RJrAhqCdqRHolP00LCNOq01kVuff/+cQ3EhwewECoFWzTs8PLubBLK1+caVevjdgxk
         kOBOoypd4M9CHzExtdbQlgVLyfpf/MJyMAQrHSF2TM79nPSuxu/D/Izn6Igoyv8tzexc
         GZ6munVLFNHXZZCMQSAc1NBrE9JZaHMALAgFF4/xsrQcuEQF3IOjVHIX6D0RDLAGsUt2
         gSGMHOXfJOY6j+Fdt2w2cXHLpSh4Y56YhI9/CPNJvTB/qA/KiZAAW2KCKwLKsMBdH0ak
         fqTgVdOViIgaG7/4iAhQCLKm2Mke7VMSttAFO5HnE87BWvo7mYhpI/OXNilYQeM3ihYT
         m2LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686492249; x=1689084249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I5LVSJ/KpblThuSqW4J6VDfKcrwlokKdeIZWgfyq/b0=;
        b=BKbP/qgO6GItTCLCyXR6izEUoYJvISUWQPeU44y7RPV7i/2Z9i366f/CXPiowLGliu
         dY1GMm0EfMe1EB9i8BYL3VxPXXO2UAakFvEUUhRLWmFX7//HBBGvckgT7Qz6W4OUkstI
         L1idS+UFW4ck/l0pR82d7sjbr18vC7oCXWIMyTWK32VINPtb2IEVJGjl/Oh3Zvu/1IfR
         vQqo6zp0Xmqft2O0narh/7YbLnb6+z78Xd9Za30Ag6ZcaQ7u7/ZwWd83u0rkY834HbEJ
         iTojM/XhWFGk7mkLeT+rK0MnH48/2Mbe5tZuHsSxiMr98InLGrb3WQ5g1Rrmeno2VP1q
         2i9w==
X-Gm-Message-State: AC+VfDy5v/wQWl/9muonZRMgT2XE96s4tltwMCQn069WBNKyz783S/pu
        orMYe6HPOHLBBA4SpujKlDVggw==
X-Google-Smtp-Source: ACHHUZ5MdBURUf1ZqwNnQr011Y7FD6T5Y+zW9fCOIZI4b/MP+yDmOFyhqUMCkDrYGvKhUa3g4GVw5w==
X-Received: by 2002:a1c:4c0a:0:b0:3f1:bb10:c865 with SMTP id z10-20020a1c4c0a000000b003f1bb10c865mr4819427wmf.38.1686492249620;
        Sun, 11 Jun 2023 07:04:09 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id h17-20020a05600c28d100b003f080b2f9f4sm8567222wmd.27.2023.06.11.07.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 07:04:08 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Michal Simek <michal.simek@amd.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 19/26] nvmem: zynqmp: Switch @xilinx.com emails to @amd.com
Date:   Sun, 11 Jun 2023 15:03:23 +0100
Message-Id: <20230611140330.154222-20-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230611140330.154222-1-srinivas.kandagatla@linaro.org>
References: <20230611140330.154222-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Simek <michal.simek@amd.com>

@xilinx.com is still working but better to switch to new amd.com after
AMD/Xilinx acquisition.

Signed-off-by: Michal Simek <michal.simek@amd.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/zynqmp_nvmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/zynqmp_nvmem.c b/drivers/nvmem/zynqmp_nvmem.c
index e28d7b133e11..f49bb9a26d05 100644
--- a/drivers/nvmem/zynqmp_nvmem.c
+++ b/drivers/nvmem/zynqmp_nvmem.c
@@ -76,6 +76,6 @@ static struct platform_driver zynqmp_nvmem_driver = {
 
 module_platform_driver(zynqmp_nvmem_driver);
 
-MODULE_AUTHOR("Michal Simek <michal.simek@xilinx.com>, Nava kishore Manne <navam@xilinx.com>");
+MODULE_AUTHOR("Michal Simek <michal.simek@amd.com>, Nava kishore Manne <nava.kishore.manne@amd.com>");
 MODULE_DESCRIPTION("ZynqMP NVMEM driver");
 MODULE_LICENSE("GPL");
-- 
2.25.1

