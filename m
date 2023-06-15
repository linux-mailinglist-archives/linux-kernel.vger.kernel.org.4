Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C527316CD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 13:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343884AbjFOLhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 07:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237737AbjFOLhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 07:37:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05433213B;
        Thu, 15 Jun 2023 04:37:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E1D462679;
        Thu, 15 Jun 2023 11:36:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ADDEC433CB;
        Thu, 15 Jun 2023 11:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686829019;
        bh=PsRJJ5ZxMa7cs8GT5ohChX59MmmNPMIucMA3Mt/cmNs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b+dFyxZFki1qcqGCC/x/ffevhvmqiWYCY5WLWxCOwMPvpKhF5u4xFjHE2bar81a0k
         W6lHy3CaVdo2bZ65Dg4hsJ1mUw26q9VNahSuIJ4NjK7OA78gY+JHAXvVisBB6EkNRm
         ZXmVd5KNLMG0MRSnwFuVQPtN8tVO1w+YtK2gsgv7jUv5oawB3sqSfSr7pEBlmRjJVA
         6THa5kbhQ/Ky5ecUOP5X61Hi/d89Krus9/iHRNfOeCaNKjVpfavrKBWVHv1zdRceKv
         SlLSrJz9Hx2yJwPiPO1BtE0UuX0wAi38sNqvxWhT7kwbvjkqZsDoix3Xy0vd9Wrk/B
         Plah/IwhYI8gA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sasha Levin <sashal@kernel.org>, sre@kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.3 02/37] power: supply: sc27xx: Fix external_power_changed race
Date:   Thu, 15 Jun 2023 07:36:19 -0400
Message-Id: <20230615113654.648702-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230615113654.648702-1-sashal@kernel.org>
References: <20230615113654.648702-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.3.8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 4d5c129d6c8993fe96e9ae712141eedcb9ca68c2 ]

sc27xx_fgu_external_power_changed() dereferences data->battery,
which gets sets in ab8500_btemp_probe() like this:

	data->battery = devm_power_supply_register(dev, &sc27xx_fgu_desc,
                                                   &fgu_cfg);

As soon as devm_power_supply_register() has called device_add()
the external_power_changed callback can get called. So there is a window
where sc27xx_fgu_external_power_changed() may get called while
data->battery has not been set yet leading to a NULL pointer dereference.

Fixing this is easy. The external_power_changed callback gets passed
the power_supply which will eventually get stored in data->battery,
so sc27xx_fgu_external_power_changed() can simply directly use
the passed in psy argument which is always valid.

After this change sc27xx_fgu_external_power_changed() is reduced to just
"power_supply_changed(psy);" and it has the same prototype. While at it
simply replace it with making the external_power_changed callback
directly point to power_supply_changed.

Cc: Orson Zhai <orsonzhai@gmail.com>
Cc: Chunyan Zhang <zhang.lyra@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/sc27xx_fuel_gauge.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/power/supply/sc27xx_fuel_gauge.c b/drivers/power/supply/sc27xx_fuel_gauge.c
index 632977f84b954..bd23c4d9fed43 100644
--- a/drivers/power/supply/sc27xx_fuel_gauge.c
+++ b/drivers/power/supply/sc27xx_fuel_gauge.c
@@ -733,13 +733,6 @@ static int sc27xx_fgu_set_property(struct power_supply *psy,
 	return ret;
 }
 
-static void sc27xx_fgu_external_power_changed(struct power_supply *psy)
-{
-	struct sc27xx_fgu_data *data = power_supply_get_drvdata(psy);
-
-	power_supply_changed(data->battery);
-}
-
 static int sc27xx_fgu_property_is_writeable(struct power_supply *psy,
 					    enum power_supply_property psp)
 {
@@ -774,7 +767,7 @@ static const struct power_supply_desc sc27xx_fgu_desc = {
 	.num_properties		= ARRAY_SIZE(sc27xx_fgu_props),
 	.get_property		= sc27xx_fgu_get_property,
 	.set_property		= sc27xx_fgu_set_property,
-	.external_power_changed	= sc27xx_fgu_external_power_changed,
+	.external_power_changed	= power_supply_changed,
 	.property_is_writeable	= sc27xx_fgu_property_is_writeable,
 	.no_thermal		= true,
 };
-- 
2.39.2

