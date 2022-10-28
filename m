Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D91611D75
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 00:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiJ1WlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 18:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiJ1WlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 18:41:16 -0400
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C11DBBD2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 15:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
        t=1666996863; bh=9d6DFM/pqmRLeIc4cMgiNgVS1Vl84NV0vez6YtnLyiE=;
        h=From:To:Cc:Subject:Date:From;
        b=VTvQGgAfRWqUs+Btn43EM6g7Yo+S/b8Q0eBsjl3FEoDRNIdM2lNzPegowq/mKD7Ao
         vFNmfipTSDFS7ZGzsKQ4hE1Qe6nmGpiQ6d8QP2cVYn2cKNAqSTeFrlpbdgg74kcz3f
         XirwgNtITZGvMC9FvEx8WVwZpIUkG6l1T8jErpFc=
From:   Ondrej Jirman <megi@xff.cz>
To:     linux-rockchip@lists.infradead.org
Cc:     Ondrej Jirman <megi@xff.cz>, Samuel Holland <samuel@sholland.org>,
        Sebastian Reichel <sre@kernel.org>,
        linux-pm@vger.kernel.org (open list:POWER SUPPLY CLASS/SUBSYSTEM and
        DRIVERS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] power: supply: ip5xxx: Fix integer overflow in current_now calculation
Date:   Sat, 29 Oct 2022 00:40:52 +0200
Message-Id: <20221028224052.293693-1-megi@xff.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_PASS,T_SPF_HELO_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When current is larger than ~2A, the multiplication in current_now
property overflows and the kernel reports invalid negative current
value. Change the numerator and denominator while preserving their
ratio to allow up to +-6A before the overflow.

Fixes: 75853406fa27 ("power: supply: Add a driver for Injoinic power bank ICs")
Signed-off-by: Ondrej Jirman <megi@xff.cz>
---
 drivers/power/supply/ip5xxx_power.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/ip5xxx_power.c b/drivers/power/supply/ip5xxx_power.c
index 02ee4d252a3e..f39cb2f7aa11 100644
--- a/drivers/power/supply/ip5xxx_power.c
+++ b/drivers/power/supply/ip5xxx_power.c
@@ -398,7 +398,7 @@ static int ip5xxx_battery_get_property(struct power_supply *psy,
 		ret = ip5xxx_battery_read_adc(ip5xxx, IP5XXX_BATIADC_DAT0,
 					      IP5XXX_BATIADC_DAT1, &raw);
 
-		val->intval = DIV_ROUND_CLOSEST(raw * 745985, 1000);
+		val->intval = DIV_ROUND_CLOSEST(raw * 261095, 350);
 		return 0;
 
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
-- 
2.38.1

