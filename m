Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCDA774C46A
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 15:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232810AbjGINnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 09:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbjGINnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 09:43:04 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27E7103;
        Sun,  9 Jul 2023 06:43:02 -0700 (PDT)
Received: from dslb-188-097-041-180.188.097.pools.vodafone-ip.de ([188.97.41.180] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1qIUgk-0007Yd-JX; Sun, 09 Jul 2023 15:42:58 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Martin Kaiser <martin@kaiser.cx>, linux-input@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Input: tegra-kbc - use devm_platform_ioremap_resource
Date:   Sun,  9 Jul 2023 15:41:08 +0200
Message-Id: <20230709134109.182418-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_platform_get_and_ioremap_resource maps a resource and returns its
physical address. If we don't need the physical address, we should call
devm_platform_ioremap_resource instead.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/input/keyboard/tegra-kbc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/tegra-kbc.c b/drivers/input/keyboard/tegra-kbc.c
index d5a6c7d8eb25..c9a823ea45d0 100644
--- a/drivers/input/keyboard/tegra-kbc.c
+++ b/drivers/input/keyboard/tegra-kbc.c
@@ -640,7 +640,7 @@ static int tegra_kbc_probe(struct platform_device *pdev)
 
 	timer_setup(&kbc->timer, tegra_kbc_keypress_timer, 0);
 
-	kbc->mmio = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
+	kbc->mmio = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(kbc->mmio))
 		return PTR_ERR(kbc->mmio);
 
-- 
2.30.2

