Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C52986B669F
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 14:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjCLN0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 09:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbjCLN0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 09:26:31 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50FE417CF3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 06:26:15 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id cn21so8387840edb.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 06:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678627574;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ITdNXxUWkF6uRaUdJ5IgYqC8UK9xSTmThRmPvwuIK4w=;
        b=VCrJ+qsSPBH5uKmgym7NlQb7cxZcgibysEmTXreMFCVhGpU1BW661nlYfvcE1QKoPe
         PTAbvMfrdsBBSoOmNA5IVOVYh3JqniNbmkVLZEq28AsSXeILemDcaIxgKnsazuwNb1HW
         k10IuwSnJ7MF+EM2wm6ArgyUTDITDabRjNvnd0M3aaZX3BM/zMUYA10GkdID+H3CkMba
         B4+pwXPddXRMUv6aJa/rQSTT+1odIcqR03u/6BRpqUG1aAhRWo7iMzIj/DuqPJylQ51G
         DcuaM3wp3a7yb8AugJnFUIWO3nrDq+W7gy80ZgO9Yh3qka8eraGzE89zdw8x7IvmAzOx
         lXOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678627574;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ITdNXxUWkF6uRaUdJ5IgYqC8UK9xSTmThRmPvwuIK4w=;
        b=Fg+oGBBZxUq+iyAcB6Cb+7K0K1PozsUVJwqWdVADEUJFYDezE2Hn0fFD/Uic52GLam
         +E6xo0Vc0sSQ2sslTtBRRp65YPEhGhA8HSEd4vh4P4tFbwQ4p4DQUImtMqABBLElHLuK
         X/C9pn2B6ykRxPMEt1SI5nBm69jBvQN5yfvVAxovgT96hB+pZGdJv7VFkkI0//8fyI/0
         RRIjfPVfb2W2Mu8LqICXkI7tTojpYtMs2c5SkO89emzGHa1jDKgxbp2p+nErwltOsgdX
         6nmSvnVHbDXwnmTseUTqIbeNIpki711FgBcKal/1us0phb5cOFCQofY6pyjatETU79AO
         Z0FA==
X-Gm-Message-State: AO0yUKWKjnX6qJrdlILP8oQJQCSnJdr4Q/JLwsyovorWZr70sFFZWWVR
        CpbnmWhzYwO64AoBnq5fem0a6Q==
X-Google-Smtp-Source: AK7set8bE2760pBILj5OUq4ILGA4e9br0TgbpRz+o+vtP+zh4KWxYSBNTi0m82wkO/0GbxdMjLQTOg==
X-Received: by 2002:aa7:ccd5:0:b0:4ac:b69a:2f06 with SMTP id y21-20020aa7ccd5000000b004acb69a2f06mr31618334edt.0.1678627573805;
        Sun, 12 Mar 2023 06:26:13 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id bx18-20020a0564020b5200b004fb542dd8cdsm914001edb.29.2023.03.12.06.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 06:26:13 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] phy: marvell: drop of_match_ptr for ID table
Date:   Sun, 12 Mar 2023 14:26:10 +0100
Message-Id: <20230312132611.352654-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

  drivers/phy/marvell/phy-pxa-28nm-hsic.c:192:34: error: ‘mv_hsic_phy_dt_match’ defined but not used [-Werror=unused-const-variable=]
  drivers/phy/marvell/phy-pxa-28nm-usb2.c:324:34: error: ‘mv_usbphy_dt_match’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/phy/marvell/phy-pxa-28nm-hsic.c | 2 +-
 drivers/phy/marvell/phy-pxa-28nm-usb2.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/marvell/phy-pxa-28nm-hsic.c b/drivers/phy/marvell/phy-pxa-28nm-hsic.c
index c5c100563f55..eff6dd6b2dd0 100644
--- a/drivers/phy/marvell/phy-pxa-28nm-hsic.c
+++ b/drivers/phy/marvell/phy-pxa-28nm-hsic.c
@@ -199,7 +199,7 @@ static struct platform_driver mv_hsic_phy_driver = {
 	.probe	= mv_hsic_phy_probe,
 	.driver = {
 		.name   = "mv-hsic-phy",
-		.of_match_table = of_match_ptr(mv_hsic_phy_dt_match),
+		.of_match_table = mv_hsic_phy_dt_match,
 	},
 };
 module_platform_driver(mv_hsic_phy_driver);
diff --git a/drivers/phy/marvell/phy-pxa-28nm-usb2.c b/drivers/phy/marvell/phy-pxa-28nm-usb2.c
index 0b390b9d2ae1..1b2107f80f3a 100644
--- a/drivers/phy/marvell/phy-pxa-28nm-usb2.c
+++ b/drivers/phy/marvell/phy-pxa-28nm-usb2.c
@@ -331,7 +331,7 @@ static struct platform_driver mv_usb2_phy_driver = {
 	.probe	= mv_usb2_phy_probe,
 	.driver = {
 		.name   = "mv-usb2-phy",
-		.of_match_table = of_match_ptr(mv_usbphy_dt_match),
+		.of_match_table = mv_usbphy_dt_match,
 	},
 };
 module_platform_driver(mv_usb2_phy_driver);
-- 
2.34.1

