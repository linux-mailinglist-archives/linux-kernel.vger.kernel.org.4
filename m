Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B7F71829E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 15:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbjEaNoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 09:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236575AbjEaNns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 09:43:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B26A10F4;
        Wed, 31 May 2023 06:42:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20F4263B24;
        Wed, 31 May 2023 13:42:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8F29C433A0;
        Wed, 31 May 2023 13:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685540530;
        bh=rhL9wusiKVqFlbY6juTI16751bGI08QytQEtJ0AEcLU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mhRXfP2oW1W3E+GcTlzVJwcpgf4+FA/9Tqd2nqsWOmun02x1JY1F6ltbT8flwdvG/
         Fdrcuh3qDiT1HbaAvkwfqj83oSsf+LcEz0EalugPnuWGsAGfzjhnURMlHC07kM8iUd
         EYykkJuoBfPQmMHY1OjsBoAOthNgQsLGtBlmAP5XxRBIdmJXmZLeovhbX0QRvsjzwY
         bF/aqO5zaK4X9CK1IktmazucBeAdbOYVlhKr5GRKlyo5toXet507FFSuRD5gSq7Mgm
         +KGqURu0f3vfOcZGW6GXR2wxxF7WkPLq7AUkf6PhJy3zQtsb1su2SRu9BNxEhMjk45
         kNEW4RDqyFX0Q==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sasha Levin <sashal@kernel.org>, sre@kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 03/33] power: supply: bq27xxx: Use mod_delayed_work() instead of cancel() + schedule()
Date:   Wed, 31 May 2023 09:41:29 -0400
Message-Id: <20230531134159.3383703-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531134159.3383703-1-sashal@kernel.org>
References: <20230531134159.3383703-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 59dddea9879713423c7b2ade43c423bb71e0d216 ]

Use mod_delayed_work() instead of separate cancel_delayed_work_sync() +
schedule_delayed_work() calls.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/bq27xxx_battery.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 8bf048fbd36a2..d4239eace432e 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -1083,10 +1083,8 @@ static int poll_interval_param_set(const char *val, const struct kernel_param *k
 		return ret;
 
 	mutex_lock(&bq27xxx_list_lock);
-	list_for_each_entry(di, &bq27xxx_battery_devices, list) {
-		cancel_delayed_work_sync(&di->work);
-		schedule_delayed_work(&di->work, 0);
-	}
+	list_for_each_entry(di, &bq27xxx_battery_devices, list)
+		mod_delayed_work(system_wq, &di->work, 0);
 	mutex_unlock(&bq27xxx_list_lock);
 
 	return ret;
-- 
2.39.2

