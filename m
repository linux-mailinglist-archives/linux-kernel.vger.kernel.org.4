Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEA136F2E26
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 05:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234188AbjEADVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 23:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233158AbjEADRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 23:17:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CE01BFE;
        Sun, 30 Apr 2023 20:07:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6EF9261735;
        Mon,  1 May 2023 03:06:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EEEFC433EF;
        Mon,  1 May 2023 03:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682910417;
        bh=DcjXekO6d7vfiiA44MWWCEOPfLjA8/jcAX3MbvESGyc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tv68HYR0WRx1mbAsgZfkQLVzPxNSn8bhz1+kDubU/fBLzSUsguecd+yUnAlIl0vXx
         wlFls98h7W4BDmrgbEZIz8SRHqT5UC38xtPZARXLx//hdyxm0iydmQrHy8kzJelnFn
         zhMFnX3eEQMwc3tSpig4St2z7xyPWDs0SCv0ZrehoCUHpDhPf5ukKusMTSFLoWih2h
         Ihx1Y+OlOuvyMEB3lhbHNdsZTEPwNhmcXI0ZCUsID+okhBN6pIkFbeWni9a0yjJQZK
         u5gSMvumF1NXQZmvKB9UJrk90Ror5XpBHyTOvjFzA/q2Rv72KC+GKNVTAexRucE/89
         2PoLkRnc0TvyA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Armin Wolf <W_Armin@gmx.de>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, rafael@kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 3/6] ACPI: EC: Fix oops when removing custom query handlers
Date:   Sun, 30 Apr 2023 23:06:49 -0400
Message-Id: <20230501030653.3255321-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501030653.3255321-1-sashal@kernel.org>
References: <20230501030653.3255321-1-sashal@kernel.org>
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
index f8fc30be68711..1dedab328c464 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1135,6 +1135,7 @@ static void acpi_ec_remove_query_handlers(struct acpi_ec *ec,
 void acpi_ec_remove_query_handler(struct acpi_ec *ec, u8 query_bit)
 {
 	acpi_ec_remove_query_handlers(ec, false, query_bit);
+	flush_workqueue(ec_query_wq);
 }
 EXPORT_SYMBOL_GPL(acpi_ec_remove_query_handler);
 
-- 
2.39.2

