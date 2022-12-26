Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD1CA656250
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 12:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbiLZL6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 06:58:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiLZL6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 06:58:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09BB25FA;
        Mon, 26 Dec 2022 03:58:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33DE860DCA;
        Mon, 26 Dec 2022 11:58:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74F43C433D2;
        Mon, 26 Dec 2022 11:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672055883;
        bh=WsFP+jr/JWJOetQbqvy3jJUBEs3QY1vpJJXVmKgr98I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SPhgl4RU6jthJy/x7ww039oDqdqKN2VeORoJT+D/++dRBWv4P3w6x7wouwjnsKp6B
         OcfUt/rj9Hu8mibqX7r7P8dQmIcJkZ4i3wn5WbWkjIHM6chaqaE2CH1//Jbjm87v/G
         pm/P3p0dqKffg0opH6s1j1L/trMGJhdxz2t5D78UtMuC62EzK/dJbawzb8OOFY+H+y
         cgssy/zyOaevyXsnf9M/NrFqY6vYt5IQGCdMp8tUQjQOoO9mqW++jJL1hvw2PAxyg4
         yRjoN5mX50CIhTaTDGYOxQ/o6eQZBO2W+qBd05+I08G4/k1+YRv6dY8YLPn1e/Dm2v
         nW6WG29jFUuxw==
Received: by pali.im (Postfix)
        id AC3709D7; Mon, 26 Dec 2022 12:58:00 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/3] power: reset: syscon-reboot: Add support for specifying priority
Date:   Mon, 26 Dec 2022 12:45:12 +0100
Message-Id: <20221226114513.4569-2-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221226114513.4569-1-pali@kernel.org>
References: <20220820102925.29476-1-pali@kernel.org>
 <20221226114513.4569-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Read new optional device tree property priority for specifying priority
level of reset handler. Default value is 192 as before.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/power/reset/syscon-reboot.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/power/reset/syscon-reboot.c b/drivers/power/reset/syscon-reboot.c
index 510e363381ca..45e34e6885f7 100644
--- a/drivers/power/reset/syscon-reboot.c
+++ b/drivers/power/reset/syscon-reboot.c
@@ -44,6 +44,7 @@ static int syscon_reboot_probe(struct platform_device *pdev)
 	struct syscon_reboot_context *ctx;
 	struct device *dev = &pdev->dev;
 	int mask_err, value_err;
+	int priority;
 	int err;
 
 	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
@@ -57,6 +58,9 @@ static int syscon_reboot_probe(struct platform_device *pdev)
 			return PTR_ERR(ctx->map);
 	}
 
+	if (of_property_read_s32(pdev->dev.of_node, "priority", &priority))
+		priority = 192;
+
 	if (of_property_read_u32(pdev->dev.of_node, "offset", &ctx->offset))
 		return -EINVAL;
 
@@ -77,7 +81,7 @@ static int syscon_reboot_probe(struct platform_device *pdev)
 	}
 
 	ctx->restart_handler.notifier_call = syscon_restart_handle;
-	ctx->restart_handler.priority = 192;
+	ctx->restart_handler.priority = priority;
 	err = register_restart_handler(&ctx->restart_handler);
 	if (err)
 		dev_err(dev, "can't register restart notifier (err=%d)\n", err);
-- 
2.20.1

