Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE05D718349
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 15:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237037AbjEaNtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 09:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236949AbjEaNsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 09:48:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D9426A9;
        Wed, 31 May 2023 06:44:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A88F63B60;
        Wed, 31 May 2023 13:44:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8392C433D2;
        Wed, 31 May 2023 13:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685540664;
        bh=+cMElBBJhY9KNkK/KmzLM6xQtVeUTAK2C+IsTD/53KM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aD62urD339QFX2YkdndVWnvBxB2kSuisZQfl1ClSGEKaDsfFi54ulObLsoSb52uge
         QaefpdcZIYroARIKqh7t8icacAVz8Dt39HTcZt+ofC9a2Y2m+TFoDdH21Ydw7d/jBj
         AxfmJofdINXZIclDZC3ZqILa4Eej/YwbFE2k7KVx3v8uMWs9Os2oYwLAatGC2ERere
         qNeuBj+F7CAWHt6O3i2+VMFFGK+KM3VK7AUJRE1dKEETVxzXVhOu8oRsrIAV+ioqjO
         lX7oXIY0/+idBvnfY8UGSL+sVd0Li6RU5EiskXfPN+Q6dXQku7QBdCDWcwWQ/CKiTS
         f0epAWzhX/lMg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>, Hans de Goede <hdegoede@redhat.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sasha Levin <sashal@kernel.org>, sre@kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 06/21] power: supply: Ratelimit no data debug output
Date:   Wed, 31 May 2023 09:43:59 -0400
Message-Id: <20230531134415.3384458-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531134415.3384458-1-sashal@kernel.org>
References: <20230531134415.3384458-1-sashal@kernel.org>
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

From: Marek Vasut <marex@denx.de>

[ Upstream commit 155c45a25679f571c2ae57d10db843a9dfc63430 ]

Reduce the amount of output this dev_dbg() statement emits into logs,
otherwise if system software polls the sysfs entry for data and keeps
getting -ENODATA, it could end up filling the logs up.

This does in fact make systemd journald choke, since during boot the
sysfs power supply entries are polled and if journald starts at the
same time, the journal is just being repeatedly filled up, and the
system stops on trying to start journald without booting any further.

Signed-off-by: Marek Vasut <marex@denx.de>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/power_supply_sysfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index a616b9d8f43c5..2b1df9c339699 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -276,7 +276,8 @@ static ssize_t power_supply_show_property(struct device *dev,
 
 		if (ret < 0) {
 			if (ret == -ENODATA)
-				dev_dbg(dev, "driver has no data for `%s' property\n",
+				dev_dbg_ratelimited(dev,
+					"driver has no data for `%s' property\n",
 					attr->attr.name);
 			else if (ret != -ENODEV && ret != -EAGAIN)
 				dev_err_ratelimited(dev,
-- 
2.39.2

