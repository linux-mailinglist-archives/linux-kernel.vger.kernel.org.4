Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC407182DD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 15:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236779AbjEaNpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 09:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236657AbjEaNoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 09:44:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E74E53;
        Wed, 31 May 2023 06:42:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 527EE63436;
        Wed, 31 May 2023 13:42:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF90BC433A0;
        Wed, 31 May 2023 13:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685540544;
        bh=FMWsSiYerd3VpLtJ0RL80ScgmPJ4SpAcn+LdzIeVyV4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Of3TjQoUJiWfvVk3HlVcNzMbOPlVkQahUPGD3+Ik4v+TMQUD0YYQ6OdHnJZ1d9YtT
         F7ny8tFShk8w6M3hIQ5uN3Jrv8VXRSEErtM1VvJQde50u+LF3KtJLh9eo/qSWtmLn3
         E5HYj9TwFuulDaYmqH87At33IFqvBEQB81OdUsp47TePaLBjpvLh7pwgRlvupRFLvX
         ufr370yL3+Vc6WlBF/mVdE17n098bB9ry61U9/1zVRXznwhXdZyv0tbr7R/33ktfMs
         S4GsBP9zye5nZ7IzmS5TC8rBTXJIDVN39G+V5VILnZmwOmGwAdSWE7kdd0/eNoimaw
         h8dbu6v/bTY8w==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Evan Quan <Evan.Quan@amd.com>, Lijo Lazar <Lijo.Lazar@amd.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sasha Levin <sashal@kernel.org>, sre@kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 13/33] power: supply: Fix logic checking if system is running from battery
Date:   Wed, 31 May 2023 09:41:39 -0400
Message-Id: <20230531134159.3383703-13-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531134159.3383703-1-sashal@kernel.org>
References: <20230531134159.3383703-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mario Limonciello <mario.limonciello@amd.com>

[ Upstream commit 95339f40a8b652b5b1773def31e63fc53c26378a ]

The logic used for power_supply_is_system_supplied() counts all power
supplies and assumes that the system is running from AC if there is
either a non-battery power-supply reporting to be online or if no
power-supplies exist at all.

The second rule is for desktop systems, that don't have any
battery/charger devices. These systems will incorrectly report to be
powered from battery once a device scope power-supply is registered
(e.g. a HID device), since these power-supplies increase the counter.

Apart from HID devices, recent dGPUs provide UCSI power supplies on a
desktop systems. The dGPU by default doesn't have anything plugged in so
it's 'offline'. This makes power_supply_is_system_supplied() return 0
with a count of 1 meaning all drivers that use this get a wrong judgement.

To fix this case adjust the logic to also examine the scope of the power
supply. If the power supply is deemed a device power supply, then don't
count it.

Cc: Evan Quan <Evan.Quan@amd.com>
Suggested-by: Lijo Lazar <Lijo.Lazar@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/power_supply_core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 8382be867d274..7871ab5e979c0 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -348,6 +348,10 @@ static int __power_supply_is_system_supplied(struct device *dev, void *data)
 	struct power_supply *psy = dev_get_drvdata(dev);
 	unsigned int *count = data;
 
+	if (!psy->desc->get_property(psy, POWER_SUPPLY_PROP_SCOPE, &ret))
+		if (ret.intval == POWER_SUPPLY_SCOPE_DEVICE)
+			return 0;
+
 	(*count)++;
 	if (psy->desc->type != POWER_SUPPLY_TYPE_BATTERY)
 		if (!psy->desc->get_property(psy, POWER_SUPPLY_PROP_ONLINE,
@@ -366,8 +370,8 @@ int power_supply_is_system_supplied(void)
 				      __power_supply_is_system_supplied);
 
 	/*
-	 * If no power class device was found at all, most probably we are
-	 * running on a desktop system, so assume we are on mains power.
+	 * If no system scope power class device was found at all, most probably we
+	 * are running on a desktop system, so assume we are on mains power.
 	 */
 	if (count == 0)
 		return 1;
-- 
2.39.2

