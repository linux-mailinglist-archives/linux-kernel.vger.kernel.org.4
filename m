Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBAD660B26E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 18:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233254AbiJXQqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 12:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234916AbiJXQpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 12:45:35 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715EC1960A1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 08:31:05 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id 13so5899064ejn.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 08:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KcmwET9ycGmnRj9dlzSF/IaZ72SsXSbPQdLAIqBeDMc=;
        b=TkypTwkRyC+IEQfLJkO+AxzeecYSVuVzd/ZFrRP1xRW9uJVu0btsXMNfEeMzHNkxfh
         C3FwJivHL9WupWbeclBsjHhoNC8xUJosd8kt4bC+V7VKkcCUfyVrhCX79auUCag9VbK6
         Xz75zLELtpW5109YZu6x4ahA6HUB9OFrV4jUPJvVHR4Hscyf0AjekuDrimBKPhcfIoqT
         OmNJcBX9i+Qjy7r0IZDwpqvLc3AvSUOeeEKByNbaqNgbQxnrphRAsux+uMBaj9YwTBfd
         yumx3/s1w6l6kA8uZ/hZI9kyZGAkYN9nz78niScaMKdRZGYMPjuua1vyQP9fkKQvyski
         WjKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KcmwET9ycGmnRj9dlzSF/IaZ72SsXSbPQdLAIqBeDMc=;
        b=RkoJ8Z4wYKOa5jks205YSLNbLVqry3pbLvqH7k8izRpJAGnDod7znl+HBuT8tbsFbO
         md9Ijel3XuaYqu7UScPAcuaY8AaopQZvSsBcnlqriay2BY46kE8PagAtMY1Dw3N/wN7n
         Jwr4cUM0gg1I50ClTL3FHKoUSQCi1IX4noO7qte0DSEWN9/ssfUu5uiaXs8H/2XDdl2U
         Yb+OvgaZbSY3cZJI+q8S2HFiyJOj3eYhn5JNeJjNeeUr2SlxnIBoxRRvAA8l7OoTLe6Y
         KL+fXOiNUSiyVfAphL7BvE0lhS5/YFKxhJKp+XM/BDKD5vPYdZoCssVl7MaT4kNfNuBB
         nmGw==
X-Gm-Message-State: ACrzQf2vT4bzmh6NNe9VTwsFowVTqQg8/IPrfrRtWpe+Mn4Jl85IVHhv
        7vwFx0B20cSy8mg8fw274ufrN0X54weDcQ==
X-Google-Smtp-Source: AMsMyM45EyK5jQDu4AOnll/E1IFdddpVGBZ0J1eUwpG9UPsnJI5LceNM6pArAYOPOedaJZetWg2orA==
X-Received: by 2002:a19:8c5e:0:b0:4a2:2d7b:eef with SMTP id i30-20020a198c5e000000b004a22d7b0eefmr11249584lfj.206.1666613769564;
        Mon, 24 Oct 2022 05:16:09 -0700 (PDT)
Received: from uffe-XPS13.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id i22-20020a0565123e1600b004acb2adfa21sm165285lfv.297.2022.10.24.05.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 05:16:08 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Russell King <linux@arm.linux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Cc:     Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] amba: Drop redundant assignments of the system PM callbacks
Date:   Mon, 24 Oct 2022 14:16:01 +0200
Message-Id: <20221024121601.156514-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
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

If the system PM callbacks haven't been assigned, the PM core falls back to
invoke the corresponding the pm_generic_* helpers for the device. Let's
rely on this behaviour and drop the redundant assignments.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/amba/bus.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 110a535648d2..ff7454a38058 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -421,12 +421,6 @@ static int amba_pm_runtime_resume(struct device *dev)
 #endif /* CONFIG_PM */
 
 static const struct dev_pm_ops amba_pm = {
-	.suspend	= pm_generic_suspend,
-	.resume		= pm_generic_resume,
-	.freeze		= pm_generic_freeze,
-	.thaw		= pm_generic_thaw,
-	.poweroff	= pm_generic_poweroff,
-	.restore	= pm_generic_restore,
 	SET_RUNTIME_PM_OPS(
 		amba_pm_runtime_suspend,
 		amba_pm_runtime_resume,
-- 
2.34.1

