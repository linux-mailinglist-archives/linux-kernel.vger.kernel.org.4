Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6D887316CF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 13:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343891AbjFOLhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 07:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343839AbjFOLhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 07:37:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274E2212C;
        Thu, 15 Jun 2023 04:37:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFB1760FBB;
        Thu, 15 Jun 2023 11:37:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D8DBC433CA;
        Thu, 15 Jun 2023 11:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686829020;
        bh=TSMZG/xuzOy0gtSH82t4A/sO7mRB9P1pq+TZ65ZAxbE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K4J3Cl8jdpWTTsZPLZhJiTF13tjKwwnhWJxQ/ygPimWEnLtxXNPjak3s6Q8W1BrSs
         rSV8ZFeTbx4+zNp8Fd/k5DjsAJSDvf9GaitNNLGWW402+Nol8ryC4OWAh+FWojn6EH
         X7xtUDbGC2rbwuoZ3V0MxiYSjvNphkSTae0xIPpGOhX8I1GjCxVm8ahFdWlMVkwuFS
         8WwCyQmSg+IzMeCcgiPdtQreWwu1VVFfO8rUd/sP+yo16fn8GyKw4FU4khb9TIus7f
         3Ywd1VdxRhELFWu9Ij9sB7QlQpCypBAnMRY7oss6Xc6Eyeok8t24rFT4fGtQe4AbSb
         KdlcahqoBrlxg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sasha Levin <sashal@kernel.org>, sre@kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.3 03/37] power: supply: bq27xxx: Use mod_delayed_work() instead of cancel() + schedule()
Date:   Thu, 15 Jun 2023 07:36:20 -0400
Message-Id: <20230615113654.648702-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230615113654.648702-1-sashal@kernel.org>
References: <20230615113654.648702-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.3.8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

