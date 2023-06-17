Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68A12733F73
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 10:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346276AbjFQIJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 04:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346299AbjFQIJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 04:09:54 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210CF1BDF
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 01:09:53 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5704ddda6dfso19139517b3.1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 01:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686989392; x=1689581392;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iO7yYZHdApPLayvlEq96oV4J2Y5un4PdapCLJrNW4Uo=;
        b=NoD8C8BVIiciXMn2EjslqtsdVtrK3ecA1gC8tOPLR/c0iJOSaaAilbSxUznSxPVnry
         Hf1nLe4Wno8ZjBYPTtiptNdAjBt48QyjXi18yYVqNvNSSgF1fqLCuKWfj9sHlFKv0VsL
         +7VvP6uqMk5IVXslMyiQXzmVXR6b2aSIKoM0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686989392; x=1689581392;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iO7yYZHdApPLayvlEq96oV4J2Y5un4PdapCLJrNW4Uo=;
        b=kHWjSiO6A1VhkDV+ULIP9pkDa3+NIvPJNxhYRN/PshZxSe6J4tZStv9Cx8TivChdNK
         MJkpOF/lkILm82w/CMPNSkHRYhf6TktzEvbR1hNJyX4Hx5tscn7hQ9/ck3A3eQZnDatN
         kkE7Anez2EX5He3ZmwXQBaGT8N3KOWl1+5k1nF5rewTPcTYKS8eGPI6mb/2E8F2lEuYC
         0/M4IWiLclHySKkIarSP7WlgGYnm+FROWD+rD95U21A7X/dtM+bhQ3XU125K6wYTcZ0J
         BeBN9xtyI2hy2zrGsXUwG+MZKuQBV3KpfpcME4WEhoBadpL30kdpiBHsPEVNZo6Yn60K
         Owog==
X-Gm-Message-State: AC+VfDzH5HT+weXFtcUTEi0ZWCGssdrVGDWdmDaNEpnpAgQFDiGLDWCS
        JumUEPrC0sgxNyQngj0wT0px9w==
X-Google-Smtp-Source: ACHHUZ45EzJEURRjW9tyst7zDQWL4xDWtCn2NjObo0iROo22obHy5cJ5ETkNX32sCKD4Uqofs7aAqw==
X-Received: by 2002:a0d:d8c2:0:b0:565:8c16:a0e1 with SMTP id a185-20020a0dd8c2000000b005658c16a0e1mr5223821ywe.13.1686989392392;
        Sat, 17 Jun 2023 01:09:52 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:f83b:769f:1443:112])
        by smtp.gmail.com with ESMTPSA id c4-20020a170902c2c400b001aaf536b1e3sm8476488pla.123.2023.06.17.01.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jun 2023 01:09:51 -0700 (PDT)
From:   Fei Shao <fshao@chromium.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Fei Shao <fshao@chromium.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: Fix memory leak in devm_clk_notifier_register()
Date:   Sat, 17 Jun 2023 16:09:01 +0800
Message-ID: <20230617160901.1.I2b151cdf7a72d9e3ecc7ab2ff38409ebe6d65d6b@changeid>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_clk_notifier_register() allocates a devres resource for clk
notifier but didn't register that to the device, so the notifier didn't
get unregistered on device detach and the allocated resource was leaked.

This fixes the issue.

Fixes: 6d30d50d037d ("clk: add devm variant of clk_notifier_register")
Signed-off-by: Fei Shao <fshao@chromium.org>
---

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

