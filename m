Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71A6E6803B6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 03:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235343AbjA3CFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 21:05:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235407AbjA3CFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 21:05:13 -0500
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4019E4226
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 18:05:11 -0800 (PST)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1pMJXg-0007Ev-0U;
        Mon, 30 Jan 2023 03:05:08 +0100
Date:   Mon, 30 Jan 2023 02:04:57 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     Colin Foster <colin.foster@in-advantage.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [RFC PATCH v2] regmap: apply reg_base and reg_downshift for single
 register ops
Message-ID: <Y9clyVS3tQEHlUhA@makrotopia.org>
References: <Y9WAPBYaLMsCbQN6@euler>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9WAPBYaLMsCbQN6@euler>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

reg_base and reg_downshift currently don't have any effect if used with
a regmap_bus or regmap_config which only offers single register
operations (ie. reg_read, reg_write and optionally reg_update_bits).

Fix that and take them into account also for regmap_bus with only
reg_read and read_write operations by applying reg_base and
reg_downshift in _regmap_bus_reg_write, _regmap_bus_reg_read.

Also apply reg_base and reg_downshift in _regmap_update_bits, but only
in case the operation is carried out with a reg_update_bits call
defined in either regmap_bus or regmap_config.

Fixes: 0074f3f2b1e43d ("regmap: allow a defined reg_base to be added to every address")
Fixes: 86fc59ef818beb ("regmap: add configurable downshift for addresses")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
I hope that I didn't miss anything there...

@Colin Please let me know if this breaks anything with your ocelot_spi
use-case.

 drivers/base/regmap/regmap.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index d12d669157f24..d2a54eb0efd9b 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1942,6 +1942,8 @@ static int _regmap_bus_reg_write(void *context, unsigned int reg,
 {
 	struct regmap *map = context;
 
+	reg += map->reg_base;
+	reg >>= map->format.reg_downshift;
 	return map->bus->reg_write(map->bus_context, reg, val);
 }
 
@@ -2840,6 +2842,8 @@ static int _regmap_bus_reg_read(void *context, unsigned int reg,
 {
 	struct regmap *map = context;
 
+	reg += map->reg_base;
+	reg >>= map->format.reg_downshift;
 	return map->bus->reg_read(map->bus_context, reg, val);
 }
 
@@ -3231,6 +3235,8 @@ static int _regmap_update_bits(struct regmap *map, unsigned int reg,
 		*change = false;
 
 	if (regmap_volatile(map, reg) && map->reg_update_bits) {
+		reg += map->reg_base;
+		reg >>= map->format.reg_downshift;
 		ret = map->reg_update_bits(map->bus_context, reg, mask, val);
 		if (ret == 0 && change)
 			*change = true;
-- 
2.39.1

