Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D30A718227
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 15:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236182AbjEaNkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 09:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236054AbjEaNk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 09:40:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D69C5;
        Wed, 31 May 2023 06:40:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 010C863AF6;
        Wed, 31 May 2023 13:40:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5767C433D2;
        Wed, 31 May 2023 13:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685540425;
        bh=TSMZG/xuzOy0gtSH82t4A/sO7mRB9P1pq+TZ65ZAxbE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WSuvPs57NxlJ8/oiAZXlAwzLCTnINak50pJBI1EQlDbAYVxNiZUGaV0Yrh6xUgaHN
         yhsz0xVggQKvpVMSHrR9XLFe5Pf32B9RpHfqwgQF0/mrZgLaOIlfTJ12gm8wUhpJ1I
         iPD1rRGW1mqreW9WZCDz6fs9E2WeFwYFS04mUbkF2Jn/Mb7TvNq9B5YEstzMEt+3/M
         JXvp7jR4zuQGEdZBcQPcptbdBPOjNTYe12dcGD0pQEobNifzUK2rq7yTaD5XBOUqfN
         kH34RJSJzRZEgJrtN9f6Vb5Op61Q1tdjFG95OoZqhWXgSTB1UhARHcThGoEhyijqbS
         vnOnSyRC15D4w==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sasha Levin <sashal@kernel.org>, sre@kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.3 03/37] power: supply: bq27xxx: Use mod_delayed_work() instead of cancel() + schedule()
Date:   Wed, 31 May 2023 09:39:45 -0400
Message-Id: <20230531134020.3383253-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531134020.3383253-1-sashal@kernel.org>
References: <20230531134020.3383253-1-sashal@kernel.org>
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
index 5ff6f44fd47b2..1cc3c4cff8ca4 100644
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

