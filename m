Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A356256C8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 10:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233830AbiKKJ05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 04:26:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233691AbiKKJ0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 04:26:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A16787B3;
        Fri, 11 Nov 2022 01:26:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4E277B824AC;
        Fri, 11 Nov 2022 09:26:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A855AC433D6;
        Fri, 11 Nov 2022 09:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668158764;
        bh=7Bn0peWH/hNf2LHrrVl+nLdZzch+rSC+IV1zbZGqVyE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RnxqHSLDge/pputrplShQtJ1am2b5islVQbmavRRh7YTzPLV12Qnm9Rlj2xx9zrD/
         eQzWxLO0yLddDQtF78t7M4LQ9YPtHpH2TUZg8Jmgg0GuxNk0r8tv5Gs/itKc5E+Rvz
         Gb7r/pjfbomlfjyzKdZEkspXgg/3klc8rQLFhv7uFdRyKiAJZpvf3bTaP5+ZmfVu3r
         vHLMuAbyP5avRzjgtb56xNI1T2G7EwYqOBF9FWMzctRr19DE+1uI792hZqA5ylF+FK
         lmM5rLiDGRDQRSxAx2hXrpiiLwzdj8xsuwtr+i3+yHL1YHZpneofaeJk8hGXpE+zqR
         OeOyxhAmA1vbw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1otQI4-0002kt-OX; Fri, 11 Nov 2022 10:25:36 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 03/14] phy: qcom-qmp-combo: drop v4 reference-clock source
Date:   Fri, 11 Nov 2022 10:24:46 +0100
Message-Id: <20221111092457.10546-4-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221111092457.10546-1-johan+linaro@kernel.org>
References: <20221111092457.10546-1-johan+linaro@kernel.org>
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

The source clock for the reference clock should not be described by the
devicetree and instead this relationship should be modelled in the clock
driver.

Drop the management of the source clock from the driver for SC8180X and
SC8280XP. Note that support for the former is not yet in mainline.

Also note that the binding has never been updated to describe the v4
clocks for SC8180X.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index 51a03ac05c91..e6c7cf723b19 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -947,7 +947,7 @@ static const char * const qmp_v3_phy_clk_l[] = {
 };
 
 static const char * const qmp_v4_phy_clk_l[] = {
-	"aux", "ref_clk_src", "ref", "com_aux",
+	"aux", "ref", "com_aux",
 };
 
 /* the primary usb3 phy on sm8250 doesn't have a ref clock */
-- 
2.37.4

