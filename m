Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDDCE6AAF18
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 11:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjCEKdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 05:33:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjCEKdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 05:33:01 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B120165B7;
        Sun,  5 Mar 2023 02:32:58 -0800 (PST)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 10565D2456;
        Sun,  5 Mar 2023 10:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1678012377; bh=E4Nn6q29732yO0RGMOie+PoMN/NXb6oBg5btSiyJ2Ag=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=Enois8ElhoJBrqQVQGqJZpgzV7ZgZTpvo9rbhXoAc3faUVGXCkNj67AsG9H63kk2o
         7wz2BlpwwgBrwSrWjXp7LBEizq/I+KcDpJEoAbHuqXNmqIR78uzbAv5za4jslUDryv
         6L9AKeWE89Hr+1uXwaCnDHw5GEyQbdIrjosW/9/g=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Sun, 05 Mar 2023 11:32:34 +0100
Subject: [PATCH 2/2] soc: qcom: rmtfs: handle optional qcom,vmid correctly
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230305-rmtfs-vmid-fix-v1-2-6a7206081602@z3ntu.xyz>
References: <20230305-rmtfs-vmid-fix-v1-0-6a7206081602@z3ntu.xyz>
In-Reply-To: <20230305-rmtfs-vmid-fix-v1-0-6a7206081602@z3ntu.xyz>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1069; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=E4Nn6q29732yO0RGMOie+PoMN/NXb6oBg5btSiyJ2Ag=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkBG/X1uWFaEa8Dj5Bbd8Kqt4oQ4LKhymOWBT2Z
 GvoiDAxmBqJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZARv1wAKCRBy2EO4nU3X
 VmXmD/9DmeYCd/L3pNjS28ZhBUm7nfOF/3xuV5Xx8b/eQwM2J6U9ngDY1tdQd2Ao9tyB34hLCO2
 9YMBMVgJUY7Gd2/oQMLtpNAdGZuKd/S/hx2ZZsMvSw3Yaiigqg0MjyJujNyALgpfU3B8gHrDFiB
 5ovPbUPzKDhap1p1Rz7k/hhOTJ45I0C1w335pVZI68zFWQCViGiX3CM0vYWnkN+yio8OCgaPJAf
 G2ap9mQAjCcJp9dkekIbokDllzY6NL3Rd+wVuc4pHqw4zKhRpP+4mDXrvXTtQul3CXOvOLtls5S
 S4pS7iHGafvG2lZw8i5VarvwwYd5mO7l2z5hbwKD/IX6p9SHEbHmEAWki21nA74vd34qtSprlea
 BhprwUkfIJWmxrjQ8AOxJYNdZNnd68Z3DWIHhnu78xM5S+GINLvvcvlRozkUg8L3Ek2zpG9v+uE
 qLUDkbW31gEjz8z95iFzbIC3pMDSeT/ejPSeXZn2wGdKogyspF+QOtV13M7bqCB2c9ovzlxwSvu
 +MvdO+jEYOHuG0LH0gjpTJgkOLrmovUT8t5Vo3PUoQmVhK5OAXCbiofQylTj/hhaIRM0bJoPejH
 J2WipcQyywZSdpcaru28X6sJgQQIhdA8n0ks0m08QTSA4zz2iEbf3p51FcShURv8yqpLeUAtdw3
 k6Dl9nEzSwdxXNA==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Older platforms don't have qcom,vmid set, handle -EINVAL return value
correctly. And since num_vmids is passed to of_property_read_u32_array
later we should make sure it has a sane value before continuing.

Fixes: e656cd0bcf3d ("soc: qcom: rmtfs: Optionally map RMTFS to more VMs")
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 drivers/soc/qcom/rmtfs_mem.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/rmtfs_mem.c b/drivers/soc/qcom/rmtfs_mem.c
index 218397ab0c36f..fb6e4def8c78b 100644
--- a/drivers/soc/qcom/rmtfs_mem.c
+++ b/drivers/soc/qcom/rmtfs_mem.c
@@ -229,7 +229,10 @@ static int qcom_rmtfs_mem_probe(struct platform_device *pdev)
 	}
 
 	num_vmids = of_property_count_u32_elems(node, "qcom,vmid");
-	if (num_vmids < 0) {
+	if (num_vmids == -EINVAL) {
+		/* qcom,vmid is optional */
+		num_vmids = 0;
+	} else if (num_vmids < 0) {
 		dev_err(&pdev->dev, "failed to count qcom,vmid elements: %d\n", num_vmids);
 		goto remove_cdev;
 	} else if (num_vmids > NUM_MAX_VMIDS) {

-- 
2.39.2

