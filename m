Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB65663143C
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 14:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbiKTNB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 08:01:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiKTNBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 08:01:50 -0500
Received: from smtp.smtpout.orange.fr (smtp-18.smtpout.orange.fr [80.12.242.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE8B20BF0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 05:01:49 -0800 (PST)
Received: from pop-os.home ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id wjxAo2gcMCoWhwjxDotLEw; Sun, 20 Nov 2022 14:01:48 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 20 Nov 2022 14:01:48 +0100
X-ME-IP: 86.243.100.34
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 2/2] mfd: qcom_rpm: Use devm_of_platform_populate() to simplify code
Date:   Sun, 20 Nov 2022 14:01:43 +0100
Message-Id: <fd997dc92b9cee219e9c55e22959a94f4bbf570b.1668949256.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <e39752476d02605b2be46cab7115f71255ce13a8.1668949256.git.christophe.jaillet@wanadoo.fr>
References: <e39752476d02605b2be46cab7115f71255ce13a8.1668949256.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_of_platform_populate() instead of hand-writing it.
This simplifies the code.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This changes the order of the clean-ups if the .remove() function is called
but it looks fine to me.
---
 drivers/mfd/qcom_rpm.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/mfd/qcom_rpm.c b/drivers/mfd/qcom_rpm.c
index ea5eb94427c4..8fea0e511550 100644
--- a/drivers/mfd/qcom_rpm.c
+++ b/drivers/mfd/qcom_rpm.c
@@ -672,21 +672,11 @@ static int qcom_rpm_probe(struct platform_device *pdev)
 	if (ret)
 		dev_warn(&pdev->dev, "failed to mark wakeup irq as wakeup\n");
 
-	return of_platform_populate(pdev->dev.of_node, NULL, NULL, &pdev->dev);
-}
-
-static int qcom_rpm_remove(struct platform_device *pdev)
-{
-	struct qcom_rpm *rpm = dev_get_drvdata(&pdev->dev);
-
-	of_platform_depopulate(&pdev->dev);
-
-	return 0;
+	return devm_of_platform_populate(&pdev->dev);
 }
 
 static struct platform_driver qcom_rpm_driver = {
 	.probe = qcom_rpm_probe,
-	.remove = qcom_rpm_remove,
 	.driver  = {
 		.name  = "qcom_rpm",
 		.of_match_table = qcom_rpm_of_match,
-- 
2.34.1

