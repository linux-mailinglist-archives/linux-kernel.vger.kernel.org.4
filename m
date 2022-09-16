Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 155335BAD4D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 14:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbiIPMVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 08:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbiIPMVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 08:21:19 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D9CB029E
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 05:21:11 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id ay7-20020a05600c1e0700b003b49861bf48so969082wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 05:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=a3ltSV10gjE+B1vHCJrys5NABOlxdayq5iZ4NHV92/Q=;
        b=slESl/j88QOOc87v/2bAejq41J/Y/cCR6TJPJVKaLq6RgQSJk+kXudHtWADPyzc8VZ
         EUsKR3SUURy/mr/nqL01GHhy9UCOEhPwRMlpywY6KQL4LfRh6ye97sxxDYBkbkPI5NqI
         SOvPbgpg7om0f43POKh8/cWUbIa4FteaTnVcjwaf8/1pNYU8ETGD5DLsYSB5RadQ0q9q
         xCE8amHEhrqJ9ahaqJEl6l7KNxQKHTTvouYfq2FbAtQm6N17dAT8ioItygG6P270Xlk7
         HZ6SHbykvPukAU/a1LvVIyQW0MD92yPIRy1oDcszNWHgyj7hoPjkgFaMyE1YmJBS8ns0
         yELg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=a3ltSV10gjE+B1vHCJrys5NABOlxdayq5iZ4NHV92/Q=;
        b=1U3i/tMPAHUKAUuZYvLUdXFvuTHR/0qT7IvzpRdGh6+XN8HuzC6WTVXe89Zu5YC0Wp
         JjaMwfdbt0j807SIp5kplnp5kBVJcaeRT4UDqHskcB2Mv4JJFhQtxpGUlhHfg0YnAPGq
         D2snoeF+klTPnDr2dTlC9fjBMp3mZr093mgtOrbfrj/2Ds4HajqVkRAXtxBQ2/YK+Xly
         Y/ZEi/V54EgIexMDZ/bZDJ9J4iQDyn93EX73SmN0oiBXh8AllPGodEJ1btzietXRceGr
         Iu3gfenAJ8GRpFEjmEQEFWnQqnqvsgL1MXmdBcYN+h4sGqX2JK3pJ3rUVk/nwoDFr0cY
         Izxg==
X-Gm-Message-State: ACrzQf2LPj8W2fTIAvY0t0bD1+hU7JgryY9KUaZaUEbjCNrAE6+Fmg3J
        vJ1lUi85IYB9kzRBfERG8jFlbA==
X-Google-Smtp-Source: AMsMyM6cTMY01i1R+dUcenZcRHXGQTwP87HTQm/LRqse38Zc25FHj56pGL7Ck7e53wGnQvRWmcKwig==
X-Received: by 2002:a05:600c:3b8c:b0:3b4:8ad1:d894 with SMTP id n12-20020a05600c3b8c00b003b48ad1d894mr3163089wms.113.1663330869457;
        Fri, 16 Sep 2022 05:21:09 -0700 (PDT)
Received: from srini-hackbase.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id u11-20020adfdb8b000000b0022add371ed2sm1540015wri.55.2022.09.16.05.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 05:21:08 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 03/13] nvmem: core: add error handling for dev_set_name
Date:   Fri, 16 Sep 2022 13:20:50 +0100
Message-Id: <20220916122100.170016-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220916122100.170016-1-srinivas.kandagatla@linaro.org>
References: <20220916122100.170016-1-srinivas.kandagatla@linaro.org>
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

From: Gaosheng Cui <cuigaosheng1@huawei.com>

The type of return value of dev_set_name is int, which may return
wrong result, so we add error handling for it to reclaim memory
of nvmem resource, and return early when an error occurs.

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 2164efd12ba9..321d7d63e068 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -810,18 +810,24 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 
 	switch (config->id) {
 	case NVMEM_DEVID_NONE:
-		dev_set_name(&nvmem->dev, "%s", config->name);
+		rval = dev_set_name(&nvmem->dev, "%s", config->name);
 		break;
 	case NVMEM_DEVID_AUTO:
-		dev_set_name(&nvmem->dev, "%s%d", config->name, nvmem->id);
+		rval = dev_set_name(&nvmem->dev, "%s%d", config->name, nvmem->id);
 		break;
 	default:
-		dev_set_name(&nvmem->dev, "%s%d",
+		rval = dev_set_name(&nvmem->dev, "%s%d",
 			     config->name ? : "nvmem",
 			     config->name ? config->id : nvmem->id);
 		break;
 	}
 
+	if (rval) {
+		ida_free(&nvmem_ida, nvmem->id);
+		kfree(nvmem);
+		return ERR_PTR(rval);
+	}
+
 	nvmem->read_only = device_property_present(config->dev, "read-only") ||
 			   config->read_only || !nvmem->reg_write;
 
-- 
2.25.1

