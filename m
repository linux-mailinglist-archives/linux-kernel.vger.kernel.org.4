Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3B85EE079
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 17:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234742AbiI1P3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 11:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234634AbiI1P2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 11:28:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868F761D6F;
        Wed, 28 Sep 2022 08:28:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3076BB820FA;
        Wed, 28 Sep 2022 15:28:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC018C433C1;
        Wed, 28 Sep 2022 15:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664378918;
        bh=alOUuEhnRUZiQBgz0BxBl3gcJ5fFOe0ChoITh0h2imI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qqmCjb7bmm/MqBmSUeSNVyrUL9sThmkv1gFznet8qVrLgFSsrG8z9X5sgvpfIwbx/
         6IRArMJD+JHMBufiLSRnS8STfGjwnWzXCcN1yZ29jm2Q3FVFmMBVBHRS+6IpR8+QVU
         O0riOl/2nn3L4z+sAb7/1qoT90g+0g2IRCjLHGRIdwYNQJZpnWEQ9Kw5bELt0VdJIl
         gZPS1gfEy5wLFCVtL8xByR2eDtkYbxXoJnhTvcslKD7LhF+lBdaZ3VIiQEHOAteA6+
         WlqJVB6hDmB+ZtGAysLyC2ta8w5aPw2Ls7HxgHeZLKjmaXu2lfIutbihjuZl1Cchcq
         AX18UMGG2gYVw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1odYzL-000808-CB; Wed, 28 Sep 2022 17:28:43 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 13/13] phy: qcom-qmp-pcie: clean up clock lists
Date:   Wed, 28 Sep 2022 17:28:22 +0200
Message-Id: <20220928152822.30687-14-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220928152822.30687-1-johan+linaro@kernel.org>
References: <20220928152822.30687-1-johan+linaro@kernel.org>
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

Keep the clock lists together and sorted by symbol name.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index 150dc58147ce..0b048e32f39b 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -1409,6 +1409,10 @@ static inline void qphy_clrbits(void __iomem *base, u32 offset, u32 val)
 }
 
 /* list of clocks required by phy */
+static const char * const ipq8074_pciephy_clk_l[] = {
+	"aux", "cfg_ahb",
+};
+
 static const char * const msm8996_phy_clk_l[] = {
 	"aux", "cfg_ahb", "ref",
 };
@@ -1423,10 +1427,6 @@ static const char * const qmp_phy_vreg_l[] = {
 	"vdda-phy", "vdda-pll",
 };
 
-static const char * const ipq8074_pciephy_clk_l[] = {
-	"aux", "cfg_ahb",
-};
-
 /* list of resets */
 static const char * const ipq8074_pciephy_reset_l[] = {
 	"phy", "common",
-- 
2.35.1

