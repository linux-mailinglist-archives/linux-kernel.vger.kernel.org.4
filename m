Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 379EB609D5B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 11:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbiJXJCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 05:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbiJXJBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 05:01:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683112ED63;
        Mon, 24 Oct 2022 02:01:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 12FE0B80FD3;
        Mon, 24 Oct 2022 09:01:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A98DBC433D7;
        Mon, 24 Oct 2022 09:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666602097;
        bh=/QOd/A9j2LYjcIHbC2MjcBtERDD4VyR/2Wsyxi0u9T4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=irTWdS5LhaCd53En9T6AMWsM8Zp+9Ohltok3bZc4rw5BQfb20vZHbb5kOGtzt2sMg
         N6vSRbrPZEqdJzkJhB6Yw5J8I0iMUDBCr0PXqy+eSQ4KB6XJ+3QkTar1hUYtsHzdcs
         Kywpas+NHSc4SzfGCSIMgipfNIuXSxhT1AqAZj2f5zR0yY9QIJ7gdZgoE7DirVXLZG
         gbe+zyj+H+aG4+2ELglXdVEYX3n1c7K8cJFQ5uFiqQk5oumWmQWFApxnI6A/ULQ1/u
         4t+nmIY3h9bPwTDwCs2rUmMgLHmeRFJnQBwfCL11NXRGR51tJWeWykgzbWorpYI5JU
         IDfNd/sr67ITg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1omtKj-00056N-0h; Mon, 24 Oct 2022 11:01:21 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 01/10] phy: qcom-qmp-ufs: move device-id table
Date:   Mon, 24 Oct 2022 11:00:32 +0200
Message-Id: <20221024090041.19574-2-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221024090041.19574-1-johan+linaro@kernel.org>
References: <20221024090041.19574-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the device-id table below probe() and next to the driver structure
to keep the driver callback functions grouped together.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 78 ++++++++++++-------------
 1 file changed, 39 insertions(+), 39 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
index 9b58d742af3b..acb8efa1d758 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
@@ -1081,45 +1081,6 @@ static int qmp_ufs_create(struct device *dev, struct device_node *np, int id,
 	return 0;
 }
 
-static const struct of_device_id qmp_ufs_of_match_table[] = {
-	{
-		.compatible = "qcom,msm8996-qmp-ufs-phy",
-		.data = &msm8996_ufs_cfg,
-	}, {
-		.compatible = "qcom,msm8998-qmp-ufs-phy",
-		.data = &sdm845_ufsphy_cfg,
-	}, {
-		.compatible = "qcom,sc8180x-qmp-ufs-phy",
-		.data = &sm8150_ufsphy_cfg,
-	}, {
-		.compatible = "qcom,sc8280xp-qmp-ufs-phy",
-		.data = &sm8350_ufsphy_cfg,
-	}, {
-		.compatible = "qcom,sdm845-qmp-ufs-phy",
-		.data = &sdm845_ufsphy_cfg,
-	}, {
-		.compatible = "qcom,sm6115-qmp-ufs-phy",
-		.data = &sm6115_ufsphy_cfg,
-	}, {
-		.compatible = "qcom,sm6350-qmp-ufs-phy",
-		.data = &sdm845_ufsphy_cfg,
-	}, {
-		.compatible = "qcom,sm8150-qmp-ufs-phy",
-		.data = &sm8150_ufsphy_cfg,
-	}, {
-		.compatible = "qcom,sm8250-qmp-ufs-phy",
-		.data = &sm8150_ufsphy_cfg,
-	}, {
-		.compatible = "qcom,sm8350-qmp-ufs-phy",
-		.data = &sm8350_ufsphy_cfg,
-	}, {
-		.compatible = "qcom,sm8450-qmp-ufs-phy",
-		.data = &sm8450_ufsphy_cfg,
-	},
-	{ },
-};
-MODULE_DEVICE_TABLE(of, qmp_ufs_of_match_table);
-
 static int qmp_ufs_probe(struct platform_device *pdev)
 {
 	struct qcom_qmp *qmp;
@@ -1185,6 +1146,45 @@ static int qmp_ufs_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static const struct of_device_id qmp_ufs_of_match_table[] = {
+	{
+		.compatible = "qcom,msm8996-qmp-ufs-phy",
+		.data = &msm8996_ufs_cfg,
+	}, {
+		.compatible = "qcom,msm8998-qmp-ufs-phy",
+		.data = &sdm845_ufsphy_cfg,
+	}, {
+		.compatible = "qcom,sc8180x-qmp-ufs-phy",
+		.data = &sm8150_ufsphy_cfg,
+	}, {
+		.compatible = "qcom,sc8280xp-qmp-ufs-phy",
+		.data = &sm8350_ufsphy_cfg,
+	}, {
+		.compatible = "qcom,sdm845-qmp-ufs-phy",
+		.data = &sdm845_ufsphy_cfg,
+	}, {
+		.compatible = "qcom,sm6115-qmp-ufs-phy",
+		.data = &sm6115_ufsphy_cfg,
+	}, {
+		.compatible = "qcom,sm6350-qmp-ufs-phy",
+		.data = &sdm845_ufsphy_cfg,
+	}, {
+		.compatible = "qcom,sm8150-qmp-ufs-phy",
+		.data = &sm8150_ufsphy_cfg,
+	}, {
+		.compatible = "qcom,sm8250-qmp-ufs-phy",
+		.data = &sm8150_ufsphy_cfg,
+	}, {
+		.compatible = "qcom,sm8350-qmp-ufs-phy",
+		.data = &sm8350_ufsphy_cfg,
+	}, {
+		.compatible = "qcom,sm8450-qmp-ufs-phy",
+		.data = &sm8450_ufsphy_cfg,
+	},
+	{ },
+};
+MODULE_DEVICE_TABLE(of, qmp_ufs_of_match_table);
+
 static struct platform_driver qmp_ufs_driver = {
 	.probe		= qmp_ufs_probe,
 	.driver = {
-- 
2.37.3

