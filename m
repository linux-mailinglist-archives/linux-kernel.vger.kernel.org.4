Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF4C35B3F82
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 21:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbiIIT0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 15:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbiIIT0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 15:26:31 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 72695EE503;
        Fri,  9 Sep 2022 12:26:30 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 1F2E2DBB;
        Fri,  9 Sep 2022 22:30:17 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 1F2E2DBB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1662751817;
        bh=aaP8ebJCiO93DpQLgqhmqz2+KDMYhrf+vJu4E3iWKSk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=GVqiEAuOaM3IL418O+EflVPp39STfggPbs20nSaQ8y+kkCbfC56TpArHFqSFSx2qy
         jZclMmzO/9zlzlyh5YVh+ZanTUvsFr/TsTLX9DzeSkcu+wRmzoK2tsYHrPLA8Z3EJ+
         eLppLHYejoqcw2YPZ+6CkjFqfe2hogHeHD2pcBW8=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 9 Sep 2022 22:26:28 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        <linux-clk@vger.kernel.org>, <linux-mips@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND v11 2/8] clk: baikal-t1: Fix invalid xGMAC PTP clock divider
Date:   Fri, 9 Sep 2022 22:26:10 +0300
Message-ID: <20220909192616.16542-3-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220909192616.16542-1-Sergey.Semin@baikalelectronics.ru>
References: <20220909192616.16542-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most likely due to copy-paste mistake the divider has been set to 10 while
according to the SoC reference manual it's supposed to be 8 thus having
PTP clock frequency of 156.25 MHz.

Fixes: 353afa3a8d2e ("clk: Add Baikal-T1 CCU Dividers driver")
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/clk/baikal-t1/clk-ccu-div.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/baikal-t1/clk-ccu-div.c b/drivers/clk/baikal-t1/clk-ccu-div.c
index f141fda12b09..ea77eec40ddd 100644
--- a/drivers/clk/baikal-t1/clk-ccu-div.c
+++ b/drivers/clk/baikal-t1/clk-ccu-div.c
@@ -207,7 +207,7 @@ static const struct ccu_div_info sys_info[] = {
 	CCU_DIV_GATE_INFO(CCU_SYS_XGMAC_REF_CLK, "sys_xgmac_ref_clk",
 			  "eth_clk", CCU_SYS_XGMAC_BASE, 8),
 	CCU_DIV_FIXED_INFO(CCU_SYS_XGMAC_PTP_CLK, "sys_xgmac_ptp_clk",
-			   "eth_clk", 10),
+			   "eth_clk", 8),
 	CCU_DIV_GATE_INFO(CCU_SYS_USB_CLK, "sys_usb_clk",
 			  "eth_clk", CCU_SYS_USB_BASE, 10),
 	CCU_DIV_VAR_INFO(CCU_SYS_PVT_CLK, "sys_pvt_clk",
-- 
2.37.2

