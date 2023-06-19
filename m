Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0591C734A9C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 05:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjFSDZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 23:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjFSDZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 23:25:10 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CEE110C0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 20:24:47 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-66869feb7d1so708916b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 20:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687145087; x=1689737087;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gqt51Wedx4m69k4BYNrm+CYeb0BA4dcpBkRvlKi17a4=;
        b=ittZM8GxPcQopWHNt7Ly2wAXQ4tNpBnKAkizLpPXp4OHioLjELl4DIwex/nk7L38wM
         4qqn2iA+OIiguh8n3cYxkILH6t+fd8ERPsG1Io/00BEboH7WgB8KQNw1THCSLa2U7yuE
         BSqX+Iu5uHc4hpfAPFXUXlJCi1WqZlXernAjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687145087; x=1689737087;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gqt51Wedx4m69k4BYNrm+CYeb0BA4dcpBkRvlKi17a4=;
        b=f93AIymgxrlwo6kjNQWg5kg2HFCLasgaihVo9txgBuTwOUTeR+lhh/wxQNY1MxO915
         jjQpSW+qh/g5/yNasEOPFk3P7NjNcGt985ybP1TOjW8tV8ZFBbr9BgPkqdaCMTIohaXm
         Ehlv1c02oK7maphtew7HgitWCkNaG2hpq9fnUweCMEEgc1leN2xdnhCbKOicPXUBe7aC
         HkXw6FONbkAcjUUfjtF19FWhT1FosFaNxi5SNlSmhTm3wFZowNYwmvYjRE3tdgNT1+DY
         TsnYuldvmTfDSceCUUnfbSh/Am5BImdUbVNXhTtUp0xpagbn/UzxYpjhwJkK2FWzjX61
         1M5Q==
X-Gm-Message-State: AC+VfDyPKtrbmiM+E1rHK5kylvGR7Hk/7IbRzxwjUtHqu3hNqhrJPlr2
        6gKHhIQ/0IQq+u8g7skh/l4tXD9QDSFXg4IwQY4=
X-Google-Smtp-Source: ACHHUZ6zHxQWxjI9HO9Dz92X+EFkmXYQE63SoTZI6bipEY1TB+wBRtlYnhYp2PP7Wg6x0itVpVR5HQ==
X-Received: by 2002:a05:6a00:3a10:b0:668:8596:7524 with SMTP id fj16-20020a056a003a1000b0066885967524mr83131pfb.20.1687145086953;
        Sun, 18 Jun 2023 20:24:46 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:59e8:aa0b:2092:f8fc])
        by smtp.gmail.com with ESMTPSA id j9-20020aa78d09000000b0064b0326494asm11464995pfe.150.2023.06.18.20.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jun 2023 20:24:46 -0700 (PDT)
From:   Fei Shao <fshao@chromium.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Fei Shao <fshao@chromium.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] clk: Fix memory leak in devm_clk_notifier_register()
Date:   Mon, 19 Jun 2023 11:22:53 +0800
Message-ID: <20230619112253.v2.1.I13f060c10549ef181603e921291bdea95f83033c@changeid>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_clk_notifier_register() allocates a devres resource for clk
notifier but didn't register that to the device, so the notifier didn't
get unregistered on device detach and the allocated resource was leaked.

Fix the issue by registering the resource through devres_add().

Fixes: 6d30d50d037d ("clk: add devm variant of clk_notifier_register")
Signed-off-by: Fei Shao <fshao@chromium.org>
---

Changes in v2:
- Revise commit message

 drivers/clk/clk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 7ac9f7a8cb84..c249f9791ae8 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -4741,6 +4741,7 @@ int devm_clk_notifier_register(struct device *dev, struct clk *clk,
 	if (!ret) {
 		devres->clk = clk;
 		devres->nb = nb;
+		devres_add(dev, devres);
 	} else {
 		devres_free(devres);
 	}
-- 
2.41.0.162.gfafddb0af9-goog

