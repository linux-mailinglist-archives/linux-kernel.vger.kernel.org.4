Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66BD25BAB79
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 12:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbiIPKn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 06:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbiIPKmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 06:42:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D42512743;
        Fri, 16 Sep 2022 03:24:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7C3762A87;
        Fri, 16 Sep 2022 10:23:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17CDCC433D6;
        Fri, 16 Sep 2022 10:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663323825;
        bh=wHuXE3fdczCWj5LpXAeiEbdmEi4v580F7vtElZE9XhA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PN9WSIgjdRVyExpTLH2SmiVu22qRWdsqGOGOys9lQzIX/E5wNDWgopEpig7FLPVh4
         a3XD0dSw7EweVLBQ6TFpGcPbxkWUWNL1AvP5uWz94GTeMjfjfo9nw4b6eBVtFpqO7h
         vbfjyqsGFpcqY+a9QDzAal3D3roVN3UCND+EvT7QCeuNmp1crNZ3E2Y8XDmtNdzp8G
         FrhVgUnzyxqnyFoJ9TmdfJAtGnuFMRU4EBzoP91Zs/1dJkGfW46vXjooJ1AHitmAz8
         n8ZP7dNjeYM+y28FBLkdfFgSMy1KlQQPm9Z66s7SyhGChqG3l+nwOqM8uLLVqXlrQS
         OXDX4iXCtyA1Q==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oZ8Vi-00030N-8F; Fri, 16 Sep 2022 12:23:50 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2 01/11] phy: qcom-qmp-pcie: add pcs_misc sanity check
Date:   Fri, 16 Sep 2022 12:23:30 +0200
Message-Id: <20220916102340.11520-2-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220916102340.11520-1-johan+linaro@kernel.org>
References: <20220916102340.11520-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure that the (otherwise) optional pcs_misc IO region has been
provided in case the configuration specifies a corresponding
initialisation table to avoid crashing with malformed device trees.

Note that the related debug message is now superfluous as the region is
only used when the configuration has a pcs_misc table.

Fixes: 421c9a0e9731 ("phy: qcom: qmp: Add SDM845 PCIe QMP PHY support")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index e6bffb0e2da3..05e73625a619 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -2300,8 +2300,10 @@ static int qmp_pcie_create(struct device *dev, struct device_node *np, int id,
 	    of_device_is_compatible(dev->of_node, "qcom,ipq6018-qmp-pcie-phy"))
 		qphy->pcs_misc = qphy->pcs + 0x400;
 
-	if (!qphy->pcs_misc)
-		dev_vdbg(dev, "PHY pcs_misc-reg not used\n");
+	if (!qphy->pcs_misc) {
+		if (cfg->pcs_misc_tbl || cfg->pcs_misc_tbl_sec)
+			return -EINVAL;
+	}
 
 	qphy->pipe_clk = devm_get_clk_from_child(dev, np, NULL);
 	if (IS_ERR(qphy->pipe_clk)) {
-- 
2.35.1

