Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDBCB6F7128
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 19:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjEDRhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 13:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjEDRge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 13:36:34 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF225FEC;
        Thu,  4 May 2023 10:36:29 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-211-176.ewe-ip-backbone.de [91.248.211.176])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 48F26660570D;
        Thu,  4 May 2023 18:36:25 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1683221785;
        bh=167nUJPaQ51u5ho/2UstluOaEMM5LZNNdaUekQZ3nm0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hE7MELyWsFw50ZH/pbcqiRhR9nqa0PzAzepuew6iOnT1wTluYjjpMPH/s30DLORDL
         +kdy6ZHgjjzO7EYRWUI6tPeQTtvloWCqc2m4nzQQ7F2fKxram61eQn/I0Bz9PznF0c
         UFYD69HFsnD3PZFQLOHVNqHBpFozTiQDdsqUMCwy74PYfDB+JoJXrdCUuuQTBU5yUI
         XmdFBDI+vnH8PTF0SrqgWttS1xFWihZ8iA5ALDmrQNrUVBxoV3uWW6M1IF1xPElkct
         HrrCeNzP18LuI6UEYaSushXULi8L25aQHfjTXRdguq74wae3BAoxxahUkYrRC/3n7y
         sSeJEpF8SbQ0A==
Received: by jupiter.universe (Postfix, from userid 1000)
        id E89194807F8; Thu,  4 May 2023 19:36:20 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v8 13/14] regulator: rk808: revert to synchronous probing
Date:   Thu,  4 May 2023 19:36:17 +0200
Message-Id: <20230504173618.142075-14-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230504173618.142075-1-sebastian.reichel@collabora.com>
References: <20230504173618.142075-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rk808 driver registers a bunch of regulator devices in a loop.
If one of the later regulators fails to register (usually because
its input supply is not yet available) everything will be unrolled
(i.e. previously registered regulators will be unregistered). With
asynchronous registration there might already be consumers, though.
We do not have the necessary infrastructure to properly unregister
the consumer device, so this scenario should be avoided.

First checking all input supplies or disallowing usage of the regulators
until all are registered does not work, since there can be
self-references (e.g. DCDC channels providing the supply of LDOs).

The only sensible solution I found is registering the regulator devices
asynchronously, so that we do not have to unroll. Since this is a major
rework let's revert back to synchronous probing for now to fix the issue
at hand.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/regulator/rk808-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/rk808-regulator.c b/drivers/regulator/rk808-regulator.c
index 71a1ca8b917e..5f14d6dd4593 100644
--- a/drivers/regulator/rk808-regulator.c
+++ b/drivers/regulator/rk808-regulator.c
@@ -1355,7 +1355,7 @@ static struct platform_driver rk808_regulator_driver = {
 	.probe = rk808_regulator_probe,
 	.driver = {
 		.name = "rk808-regulator",
-		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+		.probe_type = PROBE_FORCE_SYNCHRONOUS,
 	},
 };
 
-- 
2.39.2

