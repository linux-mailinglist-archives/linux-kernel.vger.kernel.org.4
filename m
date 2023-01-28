Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC5DA67F433
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 04:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbjA1DKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 22:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjA1DKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 22:10:16 -0500
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15017E6B6
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 19:10:15 -0800 (PST)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1pLbbX-0006aV-1K;
        Sat, 28 Jan 2023 04:10:11 +0100
Date:   Sat, 28 Jan 2023 03:10:01 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Colin Foster <colin.foster@in-advantage.com>
Subject: [PATCH] regmap: apply reg_base and reg_downshift for single register
 ops
Message-ID: <5355a99496d764a7918f0eaf801fab7c9a3f5a98.1674875341.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

reg_base and reg_downshift currently don't have any effect if used with
simple single register operations.

Fix that by taking them into account also for _reg_read, _reg_write and
_reg_update_bits (they may still be missing also in other place, eg.
page selection code).

Fixes: 0074f3f2b1e43d ("regmap: allow a defined reg_base to be added to every address")
Fixes: 86fc59ef818beb ("regmap: add configurable downshift for addresses")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/base/regmap/regmap.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index d12d669157f24..7b8386ec21b8c 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1986,6 +1986,8 @@ int _regmap_write(struct regmap *map, unsigned int reg,
 		}
 	}
 
+	reg += map->reg_base;
+	reg >>= map->format.reg_downshift;
 	ret = map->reg_write(context, reg, val);
 	if (ret == 0) {
 		if (regmap_should_log(map))
@@ -2879,6 +2881,8 @@ static int _regmap_read(struct regmap *map, unsigned int reg,
 	if (!regmap_readable(map, reg))
 		return -EIO;
 
+	reg += map->reg_base;
+	reg >>= map->format.reg_downshift;
 	ret = map->reg_read(context, reg, val);
 	if (ret == 0) {
 		if (regmap_should_log(map))
@@ -3231,6 +3235,8 @@ static int _regmap_update_bits(struct regmap *map, unsigned int reg,
 		*change = false;
 
 	if (regmap_volatile(map, reg) && map->reg_update_bits) {
+		reg += map->reg_base;
+		reg >>= map->format.reg_downshift;
 		ret = map->reg_update_bits(map->bus_context, reg, mask, val);
 		if (ret == 0 && change)
 			*change = true;

base-commit: e2f86c02fdc96ca29ced53221a3cbf50aa6f8b49
-- 
2.39.1

