Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F074565FAF6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 06:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbjAFFki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 00:40:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjAFFkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 00:40:36 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C425AC71
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 21:40:31 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id h192so541373pgc.7
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 21:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cAq/ViZLPRG+IbYXxjYoUcfudX/jAXQF/9Rus0IPRi8=;
        b=Lq8FEDrl7w73AawfkdR0gzucxPyYA88LoMQ9IKo5nwc1q0IFPeO+RrV7QfVr2J7PcU
         nKPGFig5ECCU1f7rLNN+fcLqS234b87jLmkLs7nMYwBVPm7z/AJzuKs/npew4GxdNkJH
         qoMHeDNLB5WX0XsejLBe1jTC7YLeVuodNQS4yqBNeTR5NN9htWbH5vpfu43FpPsCunum
         UhCQIfy+LGU7ZDkh5ZGTYMMKMi3xfVLrpc/AVEaKjSfaUvx7lpXxYScw7cgo30H5b5ty
         4u484EW1raeq8/iY0uaB68T1JTP8a7Jl3IEcxQJVbA8kL5+fPDJ4ixlG0Af8xKEYhLXL
         qJlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cAq/ViZLPRG+IbYXxjYoUcfudX/jAXQF/9Rus0IPRi8=;
        b=8KWck/MMPEBjGs7qG+ZNcULgb9JuF9aioqJQ26Qdaob3TmKW18ZmTWm1xMP3FE5P1M
         ZDisU5aWx3zWjUoKUeKZGaJw2l9K6BbyIamNxGkAwjZh02579ALyOYo4lP+dwzAlO2G7
         AjzvCUvF5BHgYHD6BiPC/oYQdFkPhqwOEoTv/vMSzymfXWrOHa75gc1U1d7+Eb34zOYw
         vzZWNp00uUQRjhk9eddVTpDuJfMSoDRmyVItGmLwI9xxFf8zG1kzexIKCo1gpnjaFr+q
         UGFmbUougYYRSl0cWe0IP6mmIN7d/sZyK0/lin9uGK4hoLMIVCccuCGMGgif6sXzr3Za
         5WmA==
X-Gm-Message-State: AFqh2kqgtzT6QBcojyG42xdxf3KksZTOHppImizfrRKfa8qFi5o7OdPR
        iBWfrrTWouNPf/aUFInGWoM=
X-Google-Smtp-Source: AMrXdXu+iN/YbjZPjvZY+uZn4uVMnBgw88vBSWEuWRrgyI83KjmTV/uP9eefedbo4Dum7xGtV0Qd4g==
X-Received: by 2002:aa7:99cb:0:b0:580:d188:f516 with SMTP id v11-20020aa799cb000000b00580d188f516mr52824129pfi.19.1672983631353;
        Thu, 05 Jan 2023 21:40:31 -0800 (PST)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id y11-20020aa79e0b000000b0057ef155103asm209763pfq.155.2023.01.05.21.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 21:40:30 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Keerthy <j-keerthy@ti.com>, Dave Gerlach <d-gerlach@ti.com>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     linmq006@gmail.com
Subject: [PATCH] soc: ti: pm33xx: Fix refcount leak in am33xx_pm_probe
Date:   Fri,  6 Jan 2023 09:40:22 +0400
Message-Id: <20230106054022.947529-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wkup_m3_ipc_get() takes refcount, which should be freed by
wkup_m3_ipc_put(). Add missing refcount release in the error paths.

Fixes: 5a99ae0092fe ("soc: ti: pm33xx: AM437X: Add rtc_only with ddr in self-refresh support")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/soc/ti/pm33xx.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/ti/pm33xx.c b/drivers/soc/ti/pm33xx.c
index ce09c42eaed2..f04c21157904 100644
--- a/drivers/soc/ti/pm33xx.c
+++ b/drivers/soc/ti/pm33xx.c
@@ -527,7 +527,7 @@ static int am33xx_pm_probe(struct platform_device *pdev)
 
 	ret = am33xx_pm_alloc_sram();
 	if (ret)
-		return ret;
+		goto err_wkup_m3_ipc_put;
 
 	ret = am33xx_pm_rtc_setup();
 	if (ret)
@@ -572,13 +572,14 @@ static int am33xx_pm_probe(struct platform_device *pdev)
 	pm_runtime_put_sync(dev);
 err_pm_runtime_disable:
 	pm_runtime_disable(dev);
-	wkup_m3_ipc_put(m3_ipc);
 err_unsetup_rtc:
 	iounmap(rtc_base_virt);
 	clk_put(rtc_fck);
 err_free_sram:
 	am33xx_pm_free_sram();
 	pm33xx_dev = NULL;
+err_wkup_m3_ipc_put:
+	wkup_m3_ipc_put(m3_ipc);
 	return ret;
 }
 
-- 
2.25.1

