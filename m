Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6488B714657
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 10:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjE2Ifb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 04:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbjE2If1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 04:35:27 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE411A7;
        Mon, 29 May 2023 01:35:25 -0700 (PDT)
Received: from [192.168.122.1] (217-149-172-244.nat.highway.telekom.at [217.149.172.244])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 9EFA3C6A55;
        Mon, 29 May 2023 08:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1685349324; bh=pRZ6AHRKQHHZmbPpd+nFn/VwicGcOul2r6Hztykw67M=;
        h=From:Date:Subject:To:Cc;
        b=qM0mA/JQ7ZP/BUB88GX6aRcgYqx7gnSPix/bnYQSKGCaJtstJ0ww0U1yrNam5jPjl
         NOCFUZ0VjfEhKMXTQ9EUA2SSfjROJ2X4pvXpYnnlTP2pxH8lHsFCmnFciZqdTOn+7T
         QoBj5l3jSCDxdMh/tUTZvAEnU5gcY7lDQGjoG1rc=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Mon, 29 May 2023 10:34:40 +0200
Subject: [PATCH v2] clk: qcom: mmcc-msm8974: Add OXILICX_GDSC for msm8226
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230506-msm8226-oxilicx-v2-1-f7e4ebff3d61@z3ntu.xyz>
X-B4-Tracking: v=1; b=H4sIAJ9jdGQC/3WNyw6CMBAAf4Xs2Zp2Cwie/A/DgcdWNoFiWiAFw
 r9bvXucSSZzgCfH5OGeHOBoZc+TjYCXBNq+ti8S3EUGlKhlJnMx+rFAzMUUeOA2iJvRRpqC0lJ
 1EKum9iQaV9u2j51dhiHKtyPD4bd5VpF79vPktt91VV/7f7AqoUSGpNOmTI1BfOzazss1bDtU5
 3l+AJf3M+bDAAAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1618; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=pRZ6AHRKQHHZmbPpd+nFn/VwicGcOul2r6Hztykw67M=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkdGPG8aHQT1XHMemI7VxuRpi3tHbKQMOP++yoI
 /sYjvNBsWaJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZHRjxgAKCRBy2EO4nU3X
 VutjD/9VbZpFUfSOrWaLmRwRJ5W8sUG9Y+ZuEBundE4vJXfbdoLcqkNvFuewmL6E0Thxh5Sa4wm
 NR5TQsQWeN+++LyLS5ByZcMvWm6DILCoH2Nwkwvt9hTO6LRR83mBOarhwEC9sOFw9ZxPoV5gnJg
 J6z1IayW3dl9FljI5aHoEV73hUU1ezIsGDJlx3sQ/vY9uN3IbXfOmBZvPqlZLyanWyWznOUinB2
 R20qv3UwUdQ0p9Wus3ljGt594LCd998k8HUZ7iuXYaUSXees5ljqSdyoZzHdNpiWhrNlmINX+Ca
 mqIWcTVDJp5QG6Q6naqPMC78LrPlivqSIe1QM/l5YsWkKF/QXMzczfQLIdWvrQ5zy1rxufCEz3R
 gzE8VgH79Dw2XB0Ca1OScM5WpDm8pzayyrljE28inUwdOAtlE3ocUNqME+ZTxdganPCWlaqSX71
 CldQ9XqJE6FnwVe+tTmEBjXWDUa/2H2XPKCHgXfHTBC2fauXRCOeNmkqKAIEthPHXP1Smy4JQoz
 DpoMvdGZBJkkNSeVBtWdidw0oMOTEMJFhYPPrEKDwWjuA9erQWg4IdzbYpnbBw7cOi1H5QdNcfr
 VhBL405KNb1NvFUAC9np7iw1qz6rzGZ//VKQTBV9/QJvWjaSCrYaMsWHPGydAGkaGmfmjpqIty2
 AImKWJu8/7nXhzA==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On msm8226 we also have OXILICX_GDSC but we need a slighly different
config, with a .cxcs defined for clock but with no parent.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
Changes in v2:
- oxilicx -> oxili_cx in variable name and .name field
- Pick up tags
- Link to v1: https://lore.kernel.org/r/20230506-msm8226-oxilicx-v1-1-52e34b94ff22@z3ntu.xyz
---
 drivers/clk/qcom/mmcc-msm8974.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/clk/qcom/mmcc-msm8974.c b/drivers/clk/qcom/mmcc-msm8974.c
index 4273fce9a4a4..61f1925d2817 100644
--- a/drivers/clk/qcom/mmcc-msm8974.c
+++ b/drivers/clk/qcom/mmcc-msm8974.c
@@ -2443,6 +2443,16 @@ static struct gdsc oxilicx_gdsc = {
 	.pwrsts = PWRSTS_OFF_ON,
 };
 
+static struct gdsc oxili_cx_gdsc_msm8226 = {
+	.gdscr = 0x4034,
+	.cxcs = (unsigned int []){ 0x4028 },
+	.cxc_count = 1,
+	.pd = {
+		.name = "oxili_cx",
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
+	[OXILICX_GDSC] = &oxili_cx_gdsc_msm8226,
 };
 
 static const struct regmap_config mmcc_msm8226_regmap_config = {

---
base-commit: dd9e11d6477a52ede9ebe575c83285e79e823889
change-id: 20230506-msm8226-oxilicx-7f3f0f8e491d

Best regards,
-- 
Luca Weiss <luca@z3ntu.xyz>

