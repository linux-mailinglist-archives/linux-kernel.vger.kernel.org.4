Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4D4718319
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 15:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236623AbjEaNr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 09:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236809AbjEaNqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 09:46:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976381FD8;
        Wed, 31 May 2023 06:43:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7669963709;
        Wed, 31 May 2023 13:43:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24963C4339C;
        Wed, 31 May 2023 13:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685540609;
        bh=mLRlGAcTvXXi1UOBAXpF7kAvBTmM5Fpn8vy5W4FBDKA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fpD/UzOdgBmvA2FZnuL1+kjcfqJZtqzVh2yFZdyqgkGCAad5fqXWVxB12kPOX3rwP
         2cUe8ixUw8CuWZw/98tmTAumKPeyuvwda4ZxkXvKpY5hXFIrkJEVxTeUi2lsvo/uxM
         GAw/hv1HmvJrlfMmrAcZWHq5xCIgMRtDFkMZaQEge7NKPtHMkHw/XVXQXR45izyERj
         GPo4LLVvZxdY/xnuj33ZUFbBFdAP3+gc1MA4pjH8PWBVH6X3qes9dXkZxOpWvDh8en
         7CVyYvTuqiX10qZ/7Xc19Z/gE7eSbpsKcACXCZlNC2nH8VMybzzwVfKJ35cS5J045O
         w69yOO9xVnHUw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>, Hans de Goede <hdegoede@redhat.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sasha Levin <sashal@kernel.org>, sre@kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 06/24] power: supply: Ratelimit no data debug output
Date:   Wed, 31 May 2023 09:43:02 -0400
Message-Id: <20230531134320.3384102-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531134320.3384102-1-sashal@kernel.org>
References: <20230531134320.3384102-1-sashal@kernel.org>
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
index c3d7cbcd4fad5..7a0485c35ba9d 100644
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

