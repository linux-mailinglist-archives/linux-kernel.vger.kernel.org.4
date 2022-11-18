Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C58BB62EDC0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 07:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241166AbiKRGj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 01:39:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241138AbiKRGjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 01:39:22 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC089A5FA
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 22:39:22 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id a11-20020a05600c2d4b00b003cf6f5fd9f1so3354354wmg.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 22:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NvkbhUUcBpI7gC/Zj+MFkkPdqo/aK3ymU9Kh9e+bntw=;
        b=anmmqoxmz0SVJBXtIFrEeguFyI3gu/OJC04V53r221t2HS++GDCxWEZsfwk5yPayAv
         8GuEwOpv3Hy9sV5fpQ2Dx/bsa4GNk9jomiXmNvkxRK3AEYtlYD6CKKw86ON/8Ca3uUNL
         OV+P3EPvQABx11saP42eSdgr+34C/3NIzAMGHYvT1E1uBbbIdEf+U1oXbBa+3VbKf5Bd
         uMhg47KEU1t3yqOMyhzkr9+bgHYPag2vPseTxOZwwTRvlyBPDRC7OGUMYNdCTtExT734
         TCoj7ZkIirWCohxLbq2m0Maj+oZ0c6nfMXuaxEhKKd3jJB2E+JTYKqeV3Q8oZ3plBOH7
         S34g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NvkbhUUcBpI7gC/Zj+MFkkPdqo/aK3ymU9Kh9e+bntw=;
        b=mNwDxNe/8KOmosjkq3GqP+YjcGfA42eFHtfZAlYe4fOPANwYK5VXJt+SHaaBl+NfGK
         omNmbgujbf4pG4E/bqaPhtURJIaMvllAr3AOjO5iRu1pBWxgrIXvSqj2CIYDFJBPwbVr
         k9yzNffKWwT17PI54oJBAMiYWXT4YXN2vjCGAuqz8K7fmvMrdKCr4O4ZojZCXD7L+tBS
         Tev3fswxuViFErm8P9ffVFSwW/ZXloekgwRgvNZArpzIVBvaj0VXaQP/+eBP6bU9MjSF
         M9e4iVIxRVXt2OoEIcRMBSvNmKmwpSTvbWcrxi97iC0mkpZHV9FPCcuBvD/d2WfJLTus
         KzZg==
X-Gm-Message-State: ANoB5pnDb2JMHRqASZOiaA42v5IwEPqaMON18JZz1po9z5dgyEebDgmR
        ckxJUq5fhtAgM3iR42ByCKboxBqt6OraMA==
X-Google-Smtp-Source: AA0mqf4bWNnN3O0A79+XkGQgY/wBuu/xb5QMctDZpDWdKcxQPPPEfItV46UZ+T6YIQ4DcFW6XLLZ4w==
X-Received: by 2002:a1c:7214:0:b0:3cf:7b65:76c5 with SMTP id n20-20020a1c7214000000b003cf7b6576c5mr3819751wmc.166.1668753560678;
        Thu, 17 Nov 2022 22:39:20 -0800 (PST)
Received: from localhost.localdomain ([167.98.215.174])
        by smtp.gmail.com with ESMTPSA id n24-20020a7bcbd8000000b003b4fdbb6319sm7853861wmi.21.2022.11.17.22.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 22:39:19 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Wei Yongjun <weiyongjun1@huawei.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Yang Yingliang <yangyingliang@huawei.com>
Subject: [PATCH 2/4] nvmem: rmem: Fix return value check in rmem_read()
Date:   Fri, 18 Nov 2022 06:38:38 +0000
Message-Id: <20221118063840.6357-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221118063840.6357-1-srinivas.kandagatla@linaro.org>
References: <20221118063840.6357-1-srinivas.kandagatla@linaro.org>
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

From: Wei Yongjun <weiyongjun1@huawei.com>

In case of error, the function memremap() returns NULL pointer
not ERR_PTR(). The IS_ERR() test in the return value check
should be replaced with NULL test.

Fixes: 5a3fa75a4d9c ("nvmem: Add driver to expose reserved memory as nvmem")
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/rmem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvmem/rmem.c b/drivers/nvmem/rmem.c
index b11c3c974b3d..80cb187f1481 100644
--- a/drivers/nvmem/rmem.c
+++ b/drivers/nvmem/rmem.c
@@ -37,9 +37,9 @@ static int rmem_read(void *context, unsigned int offset,
 	 * but as of Dec 2020 this isn't possible on arm64.
 	 */
 	addr = memremap(priv->mem->base, available, MEMREMAP_WB);
-	if (IS_ERR(addr)) {
+	if (!addr) {
 		dev_err(priv->dev, "Failed to remap memory region\n");
-		return PTR_ERR(addr);
+		return -ENOMEM;
 	}
 
 	count = memory_read_from_buffer(val, bytes, &off, addr, available);
-- 
2.25.1

