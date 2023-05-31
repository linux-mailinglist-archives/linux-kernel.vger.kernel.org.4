Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8246A718312
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 15:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236920AbjEaNrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 09:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236720AbjEaNpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 09:45:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554331716;
        Wed, 31 May 2023 06:43:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62DA063B05;
        Wed, 31 May 2023 13:42:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E75D3C433D2;
        Wed, 31 May 2023 13:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685540527;
        bh=UOuf+ISkjVh8LEl8gJremwMY0utWFUL05SSdIZEVKks=;
        h=From:To:Cc:Subject:Date:From;
        b=ZfVFjfn+LAi/dVAAUvPKHZRN5eYcygEIYuXg0bXifIZ4Fb9+TlMQGSoll7iNo/P7A
         dAosm2FNUyKdvF8NI82QRt3r5tGoi23fdmQiXjIwzXrbHO18b2vUD9RvJTZIiQ2Th0
         N+2RohCUwKAeA0BjS7kizES+JSdVg3qghNpoGjqQt+g9UtEs56sFmu3chfCljRKfsR
         6YmrWl8ZOVSWerLO32Ph1M84fzirQ5D8mSiQkr8sniVlpaEZRW8qWDsWlTQYYgAJFY
         sv0nvYwxdsrA33zO5YJUDF8cUDSU0zuRk6C3qZU37NC70vzk0GpNLZcFoj5H2jKesm
         rFEFglythke1g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sasha Levin <sashal@kernel.org>, sre@kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 01/33] power: supply: ab8500: Fix external_power_changed race
Date:   Wed, 31 May 2023 09:41:27 -0400
Message-Id: <20230531134159.3383703-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
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

[ Upstream commit a5299ce4e96f3e8930e9c051b28d8093ada87b08 ]

ab8500_btemp_external_power_changed() dereferences di->btemp_psy,
which gets sets in ab8500_btemp_probe() like this:

        di->btemp_psy = devm_power_supply_register(dev, &ab8500_btemp_desc,
                                                   &psy_cfg);

As soon as devm_power_supply_register() has called device_add()
the external_power_changed callback can get called. So there is a window
where ab8500_btemp_external_power_changed() may get called while
di->btemp_psy has not been set yet leading to a NULL pointer dereference.

Fixing this is easy. The external_power_changed callback gets passed
the power_supply which will eventually get stored in di->btemp_psy,
so ab8500_btemp_external_power_changed() can simply directly use
the passed in psy argument which is always valid.

And the same applies to ab8500_fg_external_power_changed().

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/ab8500_btemp.c | 6 ++----
 drivers/power/supply/ab8500_fg.c    | 6 ++----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/power/supply/ab8500_btemp.c b/drivers/power/supply/ab8500_btemp.c
index 307ee6f71042e..6f83e99d2eb72 100644
--- a/drivers/power/supply/ab8500_btemp.c
+++ b/drivers/power/supply/ab8500_btemp.c
@@ -624,10 +624,8 @@ static int ab8500_btemp_get_ext_psy_data(struct device *dev, void *data)
  */
 static void ab8500_btemp_external_power_changed(struct power_supply *psy)
 {
-	struct ab8500_btemp *di = power_supply_get_drvdata(psy);
-
-	class_for_each_device(power_supply_class, NULL,
-		di->btemp_psy, ab8500_btemp_get_ext_psy_data);
+	class_for_each_device(power_supply_class, NULL, psy,
+			      ab8500_btemp_get_ext_psy_data);
 }
 
 /* ab8500 btemp driver interrupts and their respective isr */
diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index c6c9804280dbe..71ce28eed463f 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -2407,10 +2407,8 @@ static int ab8500_fg_init_hw_registers(struct ab8500_fg *di)
  */
 static void ab8500_fg_external_power_changed(struct power_supply *psy)
 {
-	struct ab8500_fg *di = power_supply_get_drvdata(psy);
-
-	class_for_each_device(power_supply_class, NULL,
-		di->fg_psy, ab8500_fg_get_ext_psy_data);
+	class_for_each_device(power_supply_class, NULL, psy,
+			      ab8500_fg_get_ext_psy_data);
 }
 
 /**
-- 
2.39.2

