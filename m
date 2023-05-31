Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E9771823A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 15:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236502AbjEaNkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 09:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236302AbjEaNkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 09:40:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B6C128;
        Wed, 31 May 2023 06:40:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 57BEA63B06;
        Wed, 31 May 2023 13:40:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFA59C433EF;
        Wed, 31 May 2023 13:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685540432;
        bh=6gpORcAxPIswk5rt3904T6pVzx2l7Ca1K3vmcaIsjyc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mib0L5oRdsPpaz33Lto4kToqQ7LVtUuivCpnc6H0Luiw6AjOAZjHdSG4AnLnwdWNJ
         t+Wkg2hUNNywJhBwT9TzY1yWKwE7xE4DZX/iYSj1u52l5khIC21lmexDb/3dv2qZGk
         x2Wg9zKb3NRb1VSUW8olII/cPTF6DxLDgXGyRkOlRCRvne2QVM/iSYImdkyUHieAcG
         YXqcDwSI9TV9HPQh8pzcWgCipfSlM9xUsUeVC3TrP9C0WpiyixGhQ4vkyOvQqvtap4
         oTUvVvrlb5lSHyJzUICAh58SkwUnmtExV+9chK1CPdZ0Q/2sqbnoi97s6fshP2ZQEL
         Qi212fzUiLtRA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>, Hans de Goede <hdegoede@redhat.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sasha Levin <sashal@kernel.org>, sre@kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.3 08/37] power: supply: Ratelimit no data debug output
Date:   Wed, 31 May 2023 09:39:50 -0400
Message-Id: <20230531134020.3383253-8-sashal@kernel.org>
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
index c228205e09538..4bbb3053eef44 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -285,7 +285,8 @@ static ssize_t power_supply_show_property(struct device *dev,
 
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

