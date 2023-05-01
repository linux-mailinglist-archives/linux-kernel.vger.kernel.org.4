Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9AF66F2E18
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 05:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233382AbjEADTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 23:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233963AbjEADQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 23:16:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8EA10FF;
        Sun, 30 Apr 2023 20:07:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 541DA61007;
        Mon,  1 May 2023 03:06:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 122FDC4339B;
        Mon,  1 May 2023 03:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682910382;
        bh=m6IicWYJbA8WZ0Ph0v90Z/lZ89/fuwHRQZAHU11yivA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fnD73xajW90jgDMtg5TVJb1LD6iI7y1MrWn83e8MX/Ul6QSpIui4x/fRiemS4i229
         //YEbUs248Vxhd8PbsRZh8nOzEsSkKAC24lTDAeI23h8XS+XJ3jwpzhvRwnhcEPkVB
         BGxHJxsjvZ/N1+3gP1CpGwLA71gb9YzIQK9hu5+hqPGGnx/sE8ctWcqubSMzuZiD7q
         bT256Izgc2o/lwsZL1pv90zh3O/ZdgS0a+XQ4XjYLzPheM3f/ZHk/hLspO3eFf+cY/
         tmkqIR6T7wfAqknP8HLa8NaqoQrk16vZF1ed1i/nSOHcvd2PuJT8+0FkW0hbpCNthB
         +0eLSR0bs1Y+w==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Armin Wolf <W_Armin@gmx.de>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, rafael@kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 5/9] ACPI: EC: Fix oops when removing custom query handlers
Date:   Sun, 30 Apr 2023 23:06:05 -0400
Message-Id: <20230501030611.3255082-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501030611.3255082-1-sashal@kernel.org>
References: <20230501030611.3255082-1-sashal@kernel.org>
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

From: Armin Wolf <W_Armin@gmx.de>

[ Upstream commit e5b492c6bb900fcf9722e05f4a10924410e170c1 ]

When removing custom query handlers, the handler might still
be used inside the EC query workqueue, causing a kernel oops
if the module holding the callback function was already unloaded.

Fix this by flushing the EC query workqueue when removing
custom query handlers.

Tested on a Acer Travelmate 4002WLMi

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/ec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index defc5796b5084..c7baccd47b89f 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1118,6 +1118,7 @@ static void acpi_ec_remove_query_handlers(struct acpi_ec *ec,
 void acpi_ec_remove_query_handler(struct acpi_ec *ec, u8 query_bit)
 {
 	acpi_ec_remove_query_handlers(ec, false, query_bit);
+	flush_workqueue(ec_query_wq);
 }
 EXPORT_SYMBOL_GPL(acpi_ec_remove_query_handler);
 
-- 
2.39.2

