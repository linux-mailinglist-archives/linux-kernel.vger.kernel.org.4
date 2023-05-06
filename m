Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE606F9427
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 23:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjEFVWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 17:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjEFVWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 17:22:37 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4531491A;
        Sat,  6 May 2023 14:22:35 -0700 (PDT)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 3DE85CECA7;
        Sat,  6 May 2023 21:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1683408123; bh=Mgla0FqG6s0rTpF9FbXF74aYR+zs9h7SWW7n4ppNO+c=;
        h=From:Date:Subject:To:Cc;
        b=vu5rWWRHgQolokSXPm5u5BG9PWOMJ2H/w8f6f4HnEH/M1GxK2YdFW1zveaYeHU0t0
         mH1bhpJY2qpaTDVo6jQ91RSU4igUFbwEVeNhyXlCjqnQJ03SEU9ERsS/QtVH+rVsap
         2nNGJue4nE3IDMRIn683Wejv9px/gdF3dzKoHpso=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Sat, 06 May 2023 23:20:05 +0200
Subject: [PATCH] clk: qcom: mmcc-msm8974: Add OXILICX_GDSC for msm8226
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230506-msm8226-oxilicx-v1-1-52e34b94ff22@z3ntu.xyz>
X-B4-Tracking: v=1; b=H4sIAITEVmQC/x2NywqDMBAAf0X23IUYrY/+Sukhxo0uxChZWgLiv
 7v0OAPDnCCUmQRe1QmZfiy8J4X6UYFfXVoIeVYGa2xjnqbDTbbB2g73wpF9wT40wYSB2rGeQav
 JCeGUXfKrdukbo8ojU+Dy37w/13UDLVTSVXYAAAA=
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Bartosz Dudziak <bartosz.dudziak@snejp.pl>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1373; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=Mgla0FqG6s0rTpF9FbXF74aYR+zs9h7SWW7n4ppNO+c=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkVsT6XiIg7hNY3hv51IzCTbp3r+ZwiSqhd8idr
 45PSjANRtiJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZFbE+gAKCRBy2EO4nU3X
 VsjID/9SIt93I9xubBMFtSW5Bq3kj2RM/bh2bBsUrE9Z63S0oK2mvT0B6wUo02A9Xij0S5PNu/J
 5gc6T78kuuM0EtkVz1HiBDfHRvB6TnNAuPu+u7orS/BZeTJdyS+1H8cxXJIdSTRLfxXL0w5gSzw
 2e9y8glSGaeUTmWjZ2wnpBYDT+mdu2CQ+WbMJbx9eSWnYU/ZRiYHN64zs9QgZyjz+D2S8pOQT3E
 PH2mFgoZGmUmgNgDW8wMNl9r8t3DwpiBqIKQ/5BoJJZa2gHloW/pBOyXipGh52HmyY1jCnVGDFg
 R4u0xhzIP/yEZET0xDT1OCaV+NzZRyEho9Qkqx7INZBRrsv5clkuVD08lYtF/FBfZRZKQnnceYZ
 ynlLd+aYFYcD9z5/5kLyM507UPlBbs4oF5TLoTRT0uIdFoBgX651ViTqaQCijKmR2dK797gVxdv
 3a1EZKzjuSbsOLQy83g/8DPvbIyLGk8GquSi1MiQZOt/WXWIlPLUQ5nMGHXOwwevYxs0noXZga5
 cc3nDFKM7U3LTuNCvRz49BCe/mGszfEDOL+OZZpn3ur6wKZImr5x4GiladYO/WZ6QOAiOUH+Fwc
 9uNLWuLH1VUDcl1Bra1c+nw8eBqTJY6WWEUJy7WZ7gGnvX5CLVcn7GI7sgC7vz/Ett40ygbBiYF
 1M4tyWkA+w8C1gQ==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On msm8226 we also have OXILICX_GDSC but we need a slighly different
config, with a .cxcs defined for clock but with no parent.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 drivers/clk/qcom/mmcc-msm8974.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/clk/qcom/mmcc-msm8974.c b/drivers/clk/qcom/mmcc-msm8974.c
index 4273fce9a4a4..39ee3953567c 100644
--- a/drivers/clk/qcom/mmcc-msm8974.c
+++ b/drivers/clk/qcom/mmcc-msm8974.c
@@ -2443,6 +2443,16 @@ static struct gdsc oxilicx_gdsc = {
 	.pwrsts = PWRSTS_OFF_ON,
 };
 
+static struct gdsc oxilicx_gdsc_msm8226 = {
+	.gdscr = 0x4034,
+	.cxcs = (unsigned int []){ 0x4028 },
+	.cxc_count = 1,
+	.pd = {
+		.name = "oxilicx",
+	},
+	.pwrsts = PWRSTS_OFF_ON,
+};
+
 static struct clk_regmap *mmcc_msm8226_clocks[] = {
 	[MMSS_AHB_CLK_SRC] = &mmss_ahb_clk_src.clkr,
 	[MMSS_AXI_CLK_SRC] = &mmss_axi_clk_src.clkr,
@@ -2533,6 +2543,7 @@ static struct gdsc *mmcc_msm8226_gdscs[] = {
 	[MDSS_GDSC] = &mdss_gdsc,
 	[CAMSS_JPEG_GDSC] = &camss_jpeg_gdsc,
 	[CAMSS_VFE_GDSC] = &camss_vfe_gdsc,
+	[OXILICX_GDSC] = &oxilicx_gdsc_msm8226,
 };
 
 static const struct regmap_config mmcc_msm8226_regmap_config = {

---
base-commit: dd9e11d6477a52ede9ebe575c83285e79e823889
change-id: 20230506-msm8226-oxilicx-7f3f0f8e491d

Best regards,
-- 
Luca Weiss <luca@z3ntu.xyz>

