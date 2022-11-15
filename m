Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0610D629C72
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 15:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238339AbiKOOmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 09:42:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbiKOOk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 09:40:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E4527FC9;
        Tue, 15 Nov 2022 06:40:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AC5B4B81989;
        Tue, 15 Nov 2022 14:40:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43D3CC433C1;
        Tue, 15 Nov 2022 14:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668523252;
        bh=ncm5BsLW3+lbd654UB/Mjbo5qmWwRlyF4LDPoLF7jaw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CpNCMInND/d1+dR+NK5Ga6waAFmP3H2rprzE8w7mRqH7MTc2g1/8iEOllgGdbg3gP
         4S2PJ0LGOOrP+NRZsv7SqniqWWvt9rzSQvaJ4PFhW8MUNAbAVih/G2p1i7TvllTl5F
         adg+2RidvVof4oy07oDMZgTUSpHDF3knzZJvEclMQX5gO/Fm/zJIPx8EMB7bnXA3Dv
         BzT06CT9zouOlQw7FuN0pKFxeDcpzHESV/O55LTIjOGwpX+PCJy8DS3kq9c5Ij5xAJ
         uAmpY5dyDm/74md69T6A32YK/2t5J0EDZ1PuLwk76VLlB91Ljku8ezhU1Zh5J8nAhy
         NxOlAqgSU24pg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oux6s-0000fN-OJ; Tue, 15 Nov 2022 15:40:22 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2 03/15] phy: qcom-qmp-combo: drop v4 reference-clock source
Date:   Tue, 15 Nov 2022 15:39:53 +0100
Message-Id: <20221115144005.2478-4-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221115144005.2478-1-johan+linaro@kernel.org>
References: <20221115144005.2478-1-johan+linaro@kernel.org>
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
index c5d8f8bfaaaa..5da42a4e5bf6 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -945,7 +945,7 @@ static const char * const qmp_v3_phy_clk_l[] = {
 };
 
 static const char * const qmp_v4_phy_clk_l[] = {
-	"aux", "ref_clk_src", "ref", "com_aux",
+	"aux", "ref", "com_aux",
 };
 
 /* the primary usb3 phy on sm8250 doesn't have a ref clock */
-- 
2.37.4

