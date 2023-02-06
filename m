Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44FD568BA16
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 11:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbjBFK2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 05:28:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbjBFK2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 05:28:23 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B311E285
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 02:28:22 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id f47-20020a05600c492f00b003dc584a7b7eso10380486wmp.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 02:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kmitWArQk6CIBydogs7WRFxwX5Xsu7yBBRQ1KBB+uN0=;
        b=Lop3uCo6vgck04Qh0CqM4OqKuptWGUYqFRM88SUFDwlOH+cFRwSH6JysgQPOPe5lgp
         TGmVUWKDupamweBmW+4moUeCDdUVZP2adIoNR/9yVFKT3zUUuzzDUDA7k/nf+hJ3dTR0
         F8S5PgPXARRqezFkJ3q8GBWiKiqPohkmzMpyEHbMW34oHRJw8DrIp75YClxSs6Fo+p9c
         9d/XL6lS6pvK1fksDw1Q3Rvhu3kI/K3XHgsc30OhJyk1JmAgfS1G5rT1oIjhRnr56cFC
         SeZPPFl6cd1clHDSiILHFCo/Wvc4kIbk8ODzSeC1sPC3A2sQfkoccmmb6tI9ECBCz/dK
         hiWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kmitWArQk6CIBydogs7WRFxwX5Xsu7yBBRQ1KBB+uN0=;
        b=N5KY3jrsl1L0i15UDzjndDOCPmaQ2gqHIvbHXlv3wibNIEsLn6ksyW/tb+XwowrDUj
         ybxt7l0gXs/Ooxn75IDrG6aL26GSh+V5IHPKjdTKARytV39u5bmjv6vMVytlOMq4m9tx
         p6z5DI5+hrXI3AO5G3IaokgzA/7J0bnSAn3m2A/rCkF9pQPSjjlmXeptCAsInf2HN3ZP
         JwpOyhDCRBlzsKoxlEtH+YCVsXEq3cz0MyIvQi7yS1fArKnlXTPXy6Q4NaydaEBHKSj6
         s050o0wWAsWLHOlQUhaIQaUx7t0DU8Bv+GKddN/DtsOs+y7hP7rXRO/HfONnw/ol5ltn
         +ilQ==
X-Gm-Message-State: AO0yUKV8XbNhnsaVCTp45mvpWI9x92nxbvi7raeDA1uPeJtN5IZHywqP
        9DsoXZFlp3YI5xykggW+T/MJQA7XH/pFYS5T
X-Google-Smtp-Source: AK7set9YbmJdd54lG37QXhApdZSkNPcp7GqvzI+PT2R6cXx7X2H0nQLQRdA/IcBVsIqmgRqH5ypf/Q==
X-Received: by 2002:a05:600c:1e1f:b0:3dc:40a0:3853 with SMTP id ay31-20020a05600c1e1f00b003dc40a03853mr10632304wmb.11.1675679302155;
        Mon, 06 Feb 2023 02:28:22 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id g10-20020a05600c310a00b003de77597f16sm11002446wmo.21.2023.02.06.02.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 02:28:21 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RESEND PATCH 07/37] nvmem: core: remove spurious white space
Date:   Mon,  6 Feb 2023 10:27:29 +0000
Message-Id: <20230206102759.669838-8-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230206102759.669838-1-srinivas.kandagatla@linaro.org>
References: <20230206102759.669838-1-srinivas.kandagatla@linaro.org>
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

From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>

Remove a spurious white space in for the ida_alloc() call.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 34ee9d36ee7b..233c6c275031 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -764,7 +764,7 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	if (!nvmem)
 		return ERR_PTR(-ENOMEM);
 
-	rval  = ida_alloc(&nvmem_ida, GFP_KERNEL);
+	rval = ida_alloc(&nvmem_ida, GFP_KERNEL);
 	if (rval < 0) {
 		kfree(nvmem);
 		return ERR_PTR(rval);
-- 
2.25.1

