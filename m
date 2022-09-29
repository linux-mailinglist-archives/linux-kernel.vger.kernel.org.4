Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A0B5EF9E6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 18:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235705AbiI2QMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 12:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234934AbiI2QMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 12:12:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80DC1D66DB;
        Thu, 29 Sep 2022 09:12:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 58625B824FA;
        Thu, 29 Sep 2022 16:12:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C2FFC433C1;
        Thu, 29 Sep 2022 16:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664467920;
        bh=Qb6H1MTM1LXEg8sMPvRyCuIO5X98/kvPIu0bqQ8zjw4=;
        h=From:To:Cc:Subject:Date:From;
        b=JavQV1Egnc8IhrvvsS8nMYbDTT6HGrmnOMmZ6td2f7mM36YZa9LCLFxwZc7UkJ/fF
         NHXhlK+91sd2qpHiu4Ra7w9bH3ySS7wnP4XWFvseTyFyaB2M9i09H49539Nw7AuJgL
         AvbfNZ8dIDewQY8otd3c4HHqHQGGqE4aH1Lx/C5tFpcRmhedBZLSdVAjQWtscWRd4E
         5rhq8/D/iQTlcM2MKTrS+x9HTNlRyl6CPaptsYuZh1B77WzRw0R5B8T10HRQKluuax
         egwBy3WT4d5PbEKuyAdsaH89ivb8NCFWLUu293nkaAjnpYKbLjJwLz+sf+J81XRxYF
         MC/RKOOeaQ+uw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1odw8s-0004j3-2g; Thu, 29 Sep 2022 18:12:06 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH] clk: gcc-sc8280xp: use retention for USB power domains
Date:   Thu, 29 Sep 2022 18:11:24 +0200
Message-Id: <20220929161124.18138-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit d399723950c4 ("clk: qcom: gdsc: Fix the handling of
PWRSTS_RET support) retention mode can be used on sc8280xp to maintain
state during suspend instead of leaving the domain always on.

This is needed to eventually allow the parent CX domain to be powered
down during suspend.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/clk/qcom/gcc-sc8280xp.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

While we're not yet able to fully test this (since we're not hitting CX
power down) this can still go in as we'll need it in some form
eventually.

Note that the PCIe domains should remain always-on until we have driver
support for suspend in place.

Johan


diff --git a/drivers/clk/qcom/gcc-sc8280xp.c b/drivers/clk/qcom/gcc-sc8280xp.c
index 7768e6901dcc..a18ed88f3b82 100644
--- a/drivers/clk/qcom/gcc-sc8280xp.c
+++ b/drivers/clk/qcom/gcc-sc8280xp.c
@@ -6843,17 +6843,12 @@ static struct gdsc ufs_phy_gdsc = {
 	.pwrsts = PWRSTS_OFF_ON,
 };
 
-/*
- * The Qualcomm DWC3 driver suspend implementation appears to be incomplete
- * for sc8280xp so keep the USB power domains always-on for now.
- */
 static struct gdsc usb30_mp_gdsc = {
 	.gdscr = 0xab004,
 	.pd = {
 		.name = "usb30_mp_gdsc",
 	},
-	.pwrsts = PWRSTS_OFF_ON,
-	.flags = ALWAYS_ON,
+	.pwrsts = PWRSTS_RET_ON,
 };
 
 static struct gdsc usb30_prim_gdsc = {
@@ -6861,8 +6856,7 @@ static struct gdsc usb30_prim_gdsc = {
 	.pd = {
 		.name = "usb30_prim_gdsc",
 	},
-	.pwrsts = PWRSTS_OFF_ON,
-	.flags = ALWAYS_ON,
+	.pwrsts = PWRSTS_RET_ON,
 };
 
 static struct gdsc usb30_sec_gdsc = {
@@ -6870,8 +6864,7 @@ static struct gdsc usb30_sec_gdsc = {
 	.pd = {
 		.name = "usb30_sec_gdsc",
 	},
-	.pwrsts = PWRSTS_OFF_ON,
-	.flags = ALWAYS_ON,
+	.pwrsts = PWRSTS_RET_ON,
 };
 
 static struct clk_regmap *gcc_sc8280xp_clocks[] = {
-- 
2.35.1

