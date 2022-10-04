Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11F5E5F4C1A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 00:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbiJDWpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 18:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiJDWp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 18:45:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05DD3740F
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 15:45:28 -0700 (PDT)
Date:   Tue, 04 Oct 2022 22:45:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664923525;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IzWIUcB/ec1t1znH9iekpaeRW0CuVuWZtb0ZABwxZ7E=;
        b=dBaYhdX8Z76MNyq5SLRZQNpiCXFqUxmkXkePKLA/NXBbUJDsfCQbQ3sAmGPktC4CpViHCH
        HGwL9IvydKwlHdr22ck0CAuaV60MrHWrhldgXTvM6tc/R82NUCbxbwW3Ng3E+frPNxww3f
        74OdCdnM6x3JtMzAB5jWgYfTxTHTqbZ91lx+yZzAwh4pKOHmQUY050CwD6/RS0djdc53n/
        5WSCRZEB5uXAOIhtQAPOxgkctpqVI2/jmhx+8dfyp0D4eEM/9bZW2suk+VNnid+0j39Moz
        hJGLrio6l4rwKtbdHgQlvYvf/4etfU2q9F7tJNx+P3pD/Ej5q+r/UEOemDZ9Kg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664923525;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IzWIUcB/ec1t1znH9iekpaeRW0CuVuWZtb0ZABwxZ7E=;
        b=Q+tc2ApkbWwRA99ou7eidv0pu38jduvJCQZMZX8n2YwXzkksj9TWIHRyO9oGq+Kug8T+lY
        UzIjGGcqLiRwgUAQ==
From:   "irqchip-bot for Frank Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-fixes] irqchip/imx-mu-msi: Fix wrong register
 offset for 8ulp
Cc:     Colin King <colin.i.king@gmail.com>, Frank Li <Frank.Li@nxp.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20221004202414.216577-1-Frank.Li@nxp.com>
References: <20221004202414.216577-1-Frank.Li@nxp.com>
MIME-Version: 1.0
Message-ID: <166492352354.401.14610078569378494148.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-fixes branch of irqchip:

Commit-ID:     e4a7e67a08ac409f1485c82a2190636d5c81b932
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/e4a7e67a08ac409f1485c82a2190636d5c81b932
Author:        Frank Li <Frank.Li@nxp.com>
AuthorDate:    Tue, 04 Oct 2022 15:24:14 -05:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 04 Oct 2022 23:35:36 +01:00

irqchip/imx-mu-msi: Fix wrong register offset for 8ulp

Offset 0x124 should be for IMX_MU_TSR, not IMX_MU_GSR.

Fixes: 70afdab904d2 ("irqchip: Add IMX MU MSI controller driver")
Reported-by: Colin King <colin.i.king@gmail.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
[maz: updated commit message, tags]
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221004202414.216577-1-Frank.Li@nxp.com
---
 drivers/irqchip/irq-imx-mu-msi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-imx-mu-msi.c b/drivers/irqchip/irq-imx-mu-msi.c
index b62139d..229039e 100644
--- a/drivers/irqchip/irq-imx-mu-msi.c
+++ b/drivers/irqchip/irq-imx-mu-msi.c
@@ -292,7 +292,7 @@ static const struct imx_mu_dcfg imx_mu_cfg_imx8ulp = {
 	.xSR    = {
 			[IMX_MU_SR]  = 0xC,
 			[IMX_MU_GSR] = 0x118,
-			[IMX_MU_GSR] = 0x124,
+			[IMX_MU_TSR] = 0x124,
 			[IMX_MU_RSR] = 0x12C,
 		  },
 	.xCR    = {
