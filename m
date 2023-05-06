Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2B276F93ED
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 22:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjEFUMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 16:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjEFUMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 16:12:16 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3A2E43;
        Sat,  6 May 2023 13:12:14 -0700 (PDT)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id B7C81CECA7;
        Sat,  6 May 2023 20:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1683403902; bh=UxjuILMhubHneGZUmQeFeUolQx/NHIfVA3+XfK69Uj4=;
        h=From:Date:Subject:To:Cc;
        b=g0GKdvapFiwGdq90l8srl0399ddU6ZdU6WMHEC7H3jgSy4O3Cs9Jk0h/WE2WqaDK+
         L/yQsIScZJAdoEVcnbS5buH3TCHJSsH7jSpGfy8vJni6l0l79G4+5+AQu83ohC/c+g
         NJNXMd9Wd3SREsp66GjDZJq1MVR05NT0k1fKA6xk=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Sat, 06 May 2023 22:10:32 +0200
Subject: [PATCH] clk: qcom: smd-rpm: conditionally enable scaling before
 doing handover
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230506-rpmcc-scaling-handover-v1-1-374338a8dfd9@z3ntu.xyz>
X-B4-Tracking: v=1; b=H4sIADe0VmQC/x2NQQqDMBAAvyJ77kpMaKj9SvEQN1sNNNHugrSIf
 2/scWCG2UFZEivcmx2Et6RpKRW6SwM0hzIxplgZrLHOXI1HWTMRKoVXKhNWJS4bCwbvjO059rF
 zUOMxKOMoodB85m9aMmbNN2s9+ta131NahZ/p878/huP4AfixEwKNAAAA
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2241; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=UxjuILMhubHneGZUmQeFeUolQx/NHIfVA3+XfK69Uj4=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkVrRyLZWFssqnJHHtJ1HqB2nvu0fC09tj9rXe0
 X6Uj3EodpOJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZFa0cgAKCRBy2EO4nU3X
 VuxOD/9sFRP4HphYYzYvnlVI6K933cKINbjyWVqlYf7ACq8YJxKgA0kMmoRNYXoosl/9EoamYab
 BsXq98V4RA8/CUSjVbcBcM5ix8uIEB9Plbhy/rRrwJVAbag4aTm/rjtLViAkdU2IykeAXE+7rwV
 IBwvdg9YZp3hms1KZ3sFx5jE0YhkxakregjIaxJMKRvc0L9blD4X5Q1yAClO6mQ0FD3Iei1YI9T
 3yP42GBfoBEsx+1eiVEpNNCJOtqp4SLM1gIpiRsHjTRRgl3MVZD+vHNUWmZ1nBLaR9Trbv08Kzt
 XRfimTkuR5H0dGt8xCPLbEiil3wDCCIpnsBXyEzh7/NenyRnmGxDmWk+vAHMOfD1VaTVvJMmEj7
 +EufbtZe0+ylYhRyfZd7g0nErOe8NSNZGAqDSejBKtMSjrlM2/rXnxce3IhFxsjEbt0rq9VMeXG
 x2KkGphEdTFNMVcM4GDZatGyxpaNgsIJz5SewM4Mct1A4EfyORMe4+0YjlxQevQ9n2nHGzVFijh
 BqHuptbMp5txUaXhIaVSMM/serLP864F1PUULfkOZyTZ8b4upYM1FHFEKsCYjoxogPQIwc9HgdU
 k+lWvGmznkcY3CZZEcXZ9hVl2V+ABvBnMYfCqzDpUJbTW584SZQbCHDtdOtxXRViVpq1+b8DzQv
 x8iuHbRZXrT70hQ==
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

On older platforms like msm8226, msm8974 and msm8916 the driver in the
downstream kernel enables scaling first before doing the handover of the
clocks.

While this normally doesn't seem to cause noticeable problems, on
apq8026-asus-sparrow this causes the device to immediately reboot,
perhaps due to older rpm firmware that becomes unhappy.

On newer platforms the order has swapped and enabling scaling is done
after the handover, so let's introduce this behavior only conditionally
for msm8226 and msm8974 for now.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 drivers/clk/qcom/clk-smd-rpm.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rpm.c
index 887b945a6fb7..6d5476afc4d1 100644
--- a/drivers/clk/qcom/clk-smd-rpm.c
+++ b/drivers/clk/qcom/clk-smd-rpm.c
@@ -178,6 +178,7 @@ struct clk_smd_rpm_req {
 struct rpm_smd_clk_desc {
 	struct clk_smd_rpm **clks;
 	size_t num_clks;
+	bool scaling_before_handover;
 };
 
 static DEFINE_MUTEX(rpm_smd_clk_lock);
@@ -693,6 +694,7 @@ static struct clk_smd_rpm *msm8974_clks[] = {
 static const struct rpm_smd_clk_desc rpm_clk_msm8974 = {
 	.clks = msm8974_clks,
 	.num_clks = ARRAY_SIZE(msm8974_clks),
+	.scaling_before_handover = true,
 };
 
 static struct clk_smd_rpm *msm8976_clks[] = {
@@ -1318,6 +1320,12 @@ static int rpm_smd_clk_probe(struct platform_device *pdev)
 	rpm_smd_clks = desc->clks;
 	num_clks = desc->num_clks;
 
+	if (desc->scaling_before_handover) {
+		ret = clk_smd_rpm_enable_scaling(rpm);
+		if (ret)
+			goto err;
+	}
+
 	for (i = 0; i < num_clks; i++) {
 		if (!rpm_smd_clks[i])
 			continue;
@@ -1329,9 +1337,11 @@ static int rpm_smd_clk_probe(struct platform_device *pdev)
 			goto err;
 	}
 
-	ret = clk_smd_rpm_enable_scaling(rpm);
-	if (ret)
-		goto err;
+	if (!desc->scaling_before_handover) {
+		ret = clk_smd_rpm_enable_scaling(rpm);
+		if (ret)
+			goto err;
+	}
 
 	for (i = 0; i < num_clks; i++) {
 		if (!rpm_smd_clks[i])

---
base-commit: dd9e11d6477a52ede9ebe575c83285e79e823889
change-id: 20230506-rpmcc-scaling-handover-a63029ed9d13

Best regards,
-- 
Luca Weiss <luca@z3ntu.xyz>

