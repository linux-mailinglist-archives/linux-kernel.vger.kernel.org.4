Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B94A6B66A1
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 14:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjCLN0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 09:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbjCLN0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 09:26:37 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D5C2130
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 06:26:18 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id y4so9118569edo.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 06:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678627577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XAl0hh7MzBDS1djmzZy8N/npw+zryqsJ+XNFJQjmF0w=;
        b=NbNR5LANsOffWh56sNJG+hwiy7VGzuNCABzva167Q0RbCyOOlSRkTigycaEPPMZQ+j
         yKxAEuMyavYA/FTZgJLusXKwTy8Q+1qEZGlPV1F/kfqymhHI0c4x2ha+ZVLVqGHuljmy
         k8Dw4RrYsz3kyUgEONOWMEsfUBGASlwhk9cm9/oa2lybveRyTZU+abzLQ/YcRplr8xKT
         ShIsHFoiK2KXYbi+XG9qtHZwhlZU+JaEvdGsp5i5cKF+ikwG8NFN1DbWfxRJQqc0BZUS
         i3UhWbreWeFsGJ15s9/TtrK7bn0gBCDnDZVMRO2oJ4gZo/TyAXshW7xX6YmT7CNjvZuh
         DNvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678627577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XAl0hh7MzBDS1djmzZy8N/npw+zryqsJ+XNFJQjmF0w=;
        b=w4QW7GXzYwMkehHA5K2jcU6DQ5d1UrAMtWEG2RZqbZpCzs4g2WT9VIWcuHKd56VRHW
         u6DLL2BG5B63BmwCh49GXIomZdXInwOQnENgj0cIRvX9FCPVJQA6QngcV+uuVCcH+xrk
         EPxZTsixbzzrJ87VxzDc/Eei46hayLBj6wGVVuIfXfwPGrPdRi0JJtXd9yo7KFtab2S8
         AnujUDeKEMBD+mWOO9JBZy/I0cHglcUlTDwZZF9oGhjIsfPvrJFOqtizhyz+IrjnyCzm
         c4B8DVRDgJ104yyhEzQdc9WLyYJE4QKFwGQOZfbhLom8WexCyxHk74rnJ/Ra1760BD7i
         gdOg==
X-Gm-Message-State: AO0yUKV7m0igFcJkAvSiPZHD0Fh5+Muayyg4zgtSsoxZukPdfRrmPiIt
        ZElQyTJQ2xv9Zc+1U5UeC93zDw==
X-Google-Smtp-Source: AK7set9b6H6pNkwZXz/fNyF5cFK7Sqnt4oNSojngkffOCxfXtJlfhWq5XovH4sELe1y6ak+kksGPhw==
X-Received: by 2002:aa7:dad1:0:b0:4fa:d2b1:9176 with SMTP id x17-20020aa7dad1000000b004fad2b19176mr3497860eds.22.1678627577275;
        Sun, 12 Mar 2023 06:26:17 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id bx18-20020a0564020b5200b004fb542dd8cdsm914001edb.29.2023.03.12.06.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 06:26:17 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] phy: st: spear: drop of_match_ptr for ID table
Date:   Sun, 12 Mar 2023 14:26:11 +0100
Message-Id: <20230312132611.352654-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230312132611.352654-1-krzysztof.kozlowski@linaro.org>
References: <20230312132611.352654-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver can match only via the DT table so the table should be always
used and the of_match_ptr does not have any sense (this also allows ACPI
matching via PRP0001, even though it might not be relevant here).  This
also fixes !CONFIG_OF error:

  drivers/phy/st/phy-spear1310-miphy.c:172:34: error: ‘spear1310_miphy_of_match’ defined but not used [-Werror=unused-const-variable=]
  drivers/phy/st/phy-spear1340-miphy.c:182:34: error: ‘spear1340_miphy_of_match’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/phy/st/phy-spear1310-miphy.c | 2 +-
 drivers/phy/st/phy-spear1340-miphy.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/st/phy-spear1310-miphy.c b/drivers/phy/st/phy-spear1310-miphy.c
index 8871cd186304..292413db7da4 100644
--- a/drivers/phy/st/phy-spear1310-miphy.c
+++ b/drivers/phy/st/phy-spear1310-miphy.c
@@ -246,7 +246,7 @@ static struct platform_driver spear1310_miphy_driver = {
 	.probe		= spear1310_miphy_probe,
 	.driver = {
 		.name = "spear1310-miphy",
-		.of_match_table = of_match_ptr(spear1310_miphy_of_match),
+		.of_match_table = spear1310_miphy_of_match,
 	},
 };
 
diff --git a/drivers/phy/st/phy-spear1340-miphy.c b/drivers/phy/st/phy-spear1340-miphy.c
index ed4d0e2df053..c1d9ffa5a311 100644
--- a/drivers/phy/st/phy-spear1340-miphy.c
+++ b/drivers/phy/st/phy-spear1340-miphy.c
@@ -279,7 +279,7 @@ static struct platform_driver spear1340_miphy_driver = {
 	.driver = {
 		.name = "spear1340-miphy",
 		.pm = &spear1340_miphy_pm_ops,
-		.of_match_table = of_match_ptr(spear1340_miphy_of_match),
+		.of_match_table = spear1340_miphy_of_match,
 	},
 };
 
-- 
2.34.1

