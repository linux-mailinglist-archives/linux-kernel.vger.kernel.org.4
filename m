Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C20A718314
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 15:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236930AbjEaNrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 09:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236784AbjEaNpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 09:45:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848B9172D;
        Wed, 31 May 2023 06:43:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53394636E2;
        Wed, 31 May 2023 13:43:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 180A8C433D2;
        Wed, 31 May 2023 13:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685540605;
        bh=uDVktJNQePHb+AxR1/asQTsqxNXCoxsvWzOzfH5X40k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HpGeu7/4qWP+10f91HSDKw2auKOJVrRzKH1w8bkV9sMpe9mpfz4ZkvZodgP+f6BaB
         l8CwhZ4h3SoBHwfHiIZHtNjj3imRDeMGnIMx2IaNk+vQwNxDXHyByWRLCrzcAC5Ygk
         /LCDTKse2oQy67qbBRTzA+r4D95xU4I+O96Ahtplee7QsHw6E/Qyui+sJkYBCYZclJ
         /GwM1ENaWt8drs5NRGgauL3ArZZDeapXVB8OJOAHwuoFndRnXIAbb/K9OuVAdKRQzL
         +30ZnHhZmGUq5cvqBMlaD0wi7OR/emNtxS/dIdgshNDDfLEPaAG5vR2vPHg6p4Ot3h
         nK9vfjkSaSW5A==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sasha Levin <sashal@kernel.org>, sre@kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 03/24] power: supply: bq27xxx: Use mod_delayed_work() instead of cancel() + schedule()
Date:   Wed, 31 May 2023 09:42:59 -0400
Message-Id: <20230531134320.3384102-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531134320.3384102-1-sashal@kernel.org>
References: <20230531134320.3384102-1-sashal@kernel.org>
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
index 7e5e24b585d8a..2d6096b4aeb66 100644
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

