Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9455767E1F5
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 11:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbjA0Kk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 05:40:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbjA0Kkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 05:40:40 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 731977DB8
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 02:40:31 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id c10-20020a05600c0a4a00b003db0636ff84so3143377wmq.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 02:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GdVhqoNMJZ7VRQato0f6F3FYR5fTivzxS5e1+eryPnY=;
        b=HDW24eJJdhwhV+CVT0ICQs/7fTg5iROOF/oAT2IWNdOit9oQq+6DY/kJ9JcNAjZqxD
         AwrE5rtjUnFMYYNQZBYYBEZfDnPmWEvAF2bLGLLEcgwWNlY1Iht+TSQJdZsR6xmy/L8J
         BNfZyv7af9V+7kov+7ZUCpbAxlQNVTQHzS/HgHvU2Xgove76KNh7I4FjHTttuqV2YGwx
         Ezwh+fSWe01rL50JV3EPYJRFPIGn10emy4OuO4Lmnn/Pyg1Yz06lDh4X4bhnAQ51kixG
         6STeQ1nZqsLChC7rSPxbInFPWfcGQA2x2BCEZCZCCA5nxkj+xT8h6rqFzt8uBsBUUdis
         CmTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GdVhqoNMJZ7VRQato0f6F3FYR5fTivzxS5e1+eryPnY=;
        b=BBLRroVdFnZujjyB2O8ylxGdJOxtLOuAg0yEtIW4pdj6Cv9HCuvEPm5zySQaIVhDr0
         SDhDFAv+6LJ88QAsQhbbU3Qpo3peK01WYc8KZH2WzkICeeNslv0uVryXOSpVHaBe1ebi
         OZPyzYtHxN6aHCHeTopf9P+YboQfI9cTjyuL11SevdwJfIOHKdpvKRnD6ryrBkxAFzcF
         RUFnfl43VvhN2eNX1Z5s5Yu5j7fyXJ6Bs6Bw0ugsPml4XJa2xIVbf2Z8AGXJKP1jpbJN
         ahDp89rCGEtHvqJ4U1ifpJGMWTTPr+5YFs/mcZSkJQ9amn1NVeVeJ9CymIbNX0rIVWZ4
         Y4Ng==
X-Gm-Message-State: AO0yUKV5GexQhe1/ErB7h5t1ZFEGMqpmBxKQLsFRpJ7dUeSaKGheAxNq
        zpYSuDsdJSjZ/nBUVxMO/n2TXw==
X-Google-Smtp-Source: AK7set8JcMnvCSESnDwQu+Bq1VhE1q+tL0dAaWd0SJrFPXPsgc7tN+PE/VIwcc+c06H8/oscScf1Zw==
X-Received: by 2002:a05:600c:707:b0:3dc:3577:fdb2 with SMTP id i7-20020a05600c070700b003dc3577fdb2mr1963492wmn.5.1674816030030;
        Fri, 27 Jan 2023 02:40:30 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id q9-20020a1ce909000000b003dc34edacf8sm1619787wmc.31.2023.01.27.02.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 02:40:29 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        stable@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 06/10] nvmem: core: fix registration vs use race
Date:   Fri, 27 Jan 2023 10:40:11 +0000
Message-Id: <20230127104015.23839-7-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230127104015.23839-1-srinivas.kandagatla@linaro.org>
References: <20230127104015.23839-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
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

From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>

The i.MX6 CPU frequency driver sometimes fails to register at boot time
due to nvmem_cell_read_u32() sporadically returning -ENOENT.

This happens because there is a window where __nvmem_device_get() in
of_nvmem_cell_get() is able to return the nvmem device, but as cells
have been setup, nvmem_find_cell_entry_by_node() returns NULL.

The occurs because the nvmem core registration code violates one of the
fundamental principles of kernel programming: do not publish data
structures before their setup is complete.

Fix this by making nvmem core code conform with this principle.

Cc: stable@vger.kernel.org
Fixes: eace75cfdcf7 ("nvmem: Add a simple NVMEM framework for nvmem providers")
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index ac77a019aed7..e92c6f1aadbb 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -832,22 +832,16 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	nvmem->dev.groups = nvmem_dev_groups;
 #endif
 
-	dev_dbg(&nvmem->dev, "Registering nvmem device %s\n", config->name);
-
-	rval = device_add(&nvmem->dev);
-	if (rval)
-		goto err_put_device;
-
 	if (nvmem->nkeepout) {
 		rval = nvmem_validate_keepouts(nvmem);
 		if (rval)
-			goto err_device_del;
+			goto err_put_device;
 	}
 
 	if (config->compat) {
 		rval = nvmem_sysfs_setup_compat(nvmem, config);
 		if (rval)
-			goto err_device_del;
+			goto err_put_device;
 	}
 
 	if (config->cells) {
@@ -864,6 +858,12 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	if (rval)
 		goto err_remove_cells;
 
+	dev_dbg(&nvmem->dev, "Registering nvmem device %s\n", config->name);
+
+	rval = device_add(&nvmem->dev);
+	if (rval)
+		goto err_remove_cells;
+
 	blocking_notifier_call_chain(&nvmem_notifier, NVMEM_ADD, nvmem);
 
 	return nvmem;
@@ -873,8 +873,6 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 err_teardown_compat:
 	if (config->compat)
 		nvmem_sysfs_remove_compat(nvmem, config);
-err_device_del:
-	device_del(&nvmem->dev);
 err_put_device:
 	put_device(&nvmem->dev);
 
-- 
2.25.1

