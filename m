Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F2F6B53A9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 23:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbjCJWBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 17:01:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbjCJWBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 17:01:22 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7ED13DE3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 13:58:03 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id ec29so26209132edb.6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 13:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678485481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mUBJvPnvYIjkmn4O8oZhEpaIiBhxp2RHHJ3TqWmbT9w=;
        b=J+Tq6OtM2ajO1NaR/jxu5zDmCfSVtNjAnVcHz/HABr9CpaZY6AXEkMgBqfYwT84EX7
         4fqBbPlLJkL/0MH3bW5xl31CHs1w384PvsCfSGn6hKnG6M9baY3ywLvUboU85PCQfzHV
         UEOVEcvH98EZvfEbotsICjjOKVi39e5bBjN3nliWLPEjv/SV8G5fS8jTi4NH3HRIeSps
         2Nb2wvyUbuf5I1GvmboQsL4g63JQvttMkRoJ0auSDKF9wKO7yQiY5Qb/AnSHHzviXE/X
         XJW21hH0BlT6yvOcT6roEP1tpBuM0JdeS3sR4ZYqUSlQK37ZKAjd6YAjQB7o72WAnZ7d
         5GNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678485481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mUBJvPnvYIjkmn4O8oZhEpaIiBhxp2RHHJ3TqWmbT9w=;
        b=kK70Id73qb6bkn1faB3j8/8mB5p1TS2lx4mAxbHjEBc/eo/Qho2sUgnheFr+lPhZOA
         AHRwoLdvuh2Tpp2QqVQUeZEHxSP1+ktLoUo+O04Zx+UYF1DegPE7kqY5CmHrqSAurzw7
         FY+aZ6cq+QLWhqGl4W7IVA1cYLxTxggxoKgATeDn2+V4eBjs+steTLL/sFy+S6hkNQKf
         icnrlQOnnctHapLR0oGohHTEI1IT4WXB9IF1oP/C43L8W4f4wQLTxCA2r0+3POO7Adpp
         f24O4cgBKOS0ARby8n8Zqv6jkJzTECanoeIgal6KPgfnHk5kYGu0fNrgk8e7dLIKERBK
         fM0Q==
X-Gm-Message-State: AO0yUKURu7eN4mxWcwYLkB9diFbM4HqiYDps8xWvJYbetSD4ZoeJVJYW
        FjC3cpr0u70bfMw0QLqQfNBucXio9o5wRIMWvi8=
X-Google-Smtp-Source: AK7set9osGjpQrpxJegDF8sKXKCQx5GDmuDhzB67DU5cdXSBv9c2wl4JYEXcMCat4OxS1PxXgAHWcw==
X-Received: by 2002:a05:6402:1854:b0:4ac:b614:dd00 with SMTP id v20-20020a056402185400b004acb614dd00mr22252359edy.30.1678484804740;
        Fri, 10 Mar 2023 13:46:44 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:34:52e3:a77e:cac5])
        by smtp.gmail.com with ESMTPSA id t5-20020a50ab45000000b004bf7905559asm488088edc.44.2023.03.10.13.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 13:46:44 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Byungho An <bh74.an@samsung.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/5] net: stmmac: generic: drop of_match_ptr for ID table
Date:   Fri, 10 Mar 2023 22:46:29 +0100
Message-Id: <20230310214632.275648-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230310214632.275648-1-krzysztof.kozlowski@linaro.org>
References: <20230310214632.275648-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver can match only via the DT table so the table should be always
used and the of_match_ptr does not have any sense (this also allows ACPI
matching via PRP0001, even though it is not relevant here).

  drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c:72:34: error: ‘dwmac_generic_match’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c
index 5e731a72cce8..ef8f3a940938 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c
@@ -91,7 +91,7 @@ static struct platform_driver dwmac_generic_driver = {
 	.driver = {
 		.name           = STMMAC_RESOURCE_NAME,
 		.pm		= &stmmac_pltfr_pm_ops,
-		.of_match_table = of_match_ptr(dwmac_generic_match),
+		.of_match_table = dwmac_generic_match,
 	},
 };
 module_platform_driver(dwmac_generic_driver);
-- 
2.34.1

