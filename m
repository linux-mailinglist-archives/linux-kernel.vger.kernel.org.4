Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C04D674A826
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 02:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjGGAhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 20:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjGGAhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 20:37:17 -0400
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50BC619BD;
        Thu,  6 Jul 2023 17:37:16 -0700 (PDT)
Received: from droid01-cd.amlogic.com (10.98.11.200) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2507.13; Fri, 7 Jul 2023
 08:37:06 +0800
From:   Xianwei Zhao <xianwei.zhao@amlogic.com>
To:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Neil Armstrong" <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Xianwei Zhao <xianwei.zhao@amlogic.com>
Subject: [PATCH V2 1/4] soc: amlogic: use name instead of index as criterion
Date:   Fri, 7 Jul 2023 08:37:07 +0800
Message-ID: <20230707003710.2667989-2-xianwei.zhao@amlogic.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230707003710.2667989-1-xianwei.zhao@amlogic.com>
References: <20230707003710.2667989-1-xianwei.zhao@amlogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.98.11.200]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The  variate 'index' could be equal to zero in some SoCs. Such as C3 SoC,
PWRC_C3_NNA_ID be defined zero. Use 'name' instead of 'index' as criterion.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
V1 -> V2: add a new patch for change.
---
 drivers/soc/amlogic/meson-secure-pwrc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/amlogic/meson-secure-pwrc.c b/drivers/soc/amlogic/meson-secure-pwrc.c
index 25b4b71df9b8..c11d65a3e3d9 100644
--- a/drivers/soc/amlogic/meson-secure-pwrc.c
+++ b/drivers/soc/amlogic/meson-secure-pwrc.c
@@ -179,7 +179,7 @@ static int meson_secure_pwrc_probe(struct platform_device *pdev)
 	for (i = 0 ; i < match->count ; ++i) {
 		struct meson_secure_pwrc_domain *dom = &pwrc->domains[i];
 
-		if (!match->domains[i].index)
+		if (!match->domains[i].name)
 			continue;
 
 		dom->pwrc = pwrc;
-- 
2.37.1

