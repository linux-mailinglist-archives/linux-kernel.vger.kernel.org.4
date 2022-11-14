Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB7D62773A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 09:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236269AbiKNIOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 03:14:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236241AbiKNIOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 03:14:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275A7193C1;
        Mon, 14 Nov 2022 00:14:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B820F60F01;
        Mon, 14 Nov 2022 08:14:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1223BC43470;
        Mon, 14 Nov 2022 08:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668413669;
        bh=qDF+eKEgYeIWIuYOTHuW90RHV71R/0BtAdQ8fI4yF7k=;
        h=From:To:Cc:Subject:Date:From;
        b=OebRd7n24E+f0cy2n0mYUSYAguNjvlYU1hYbzoXL6i9XXtvDzw509o/nAsrmn5kn+
         /CRNubYGwxeKLwUr9HjTk6suUQrBmiy0DAL3jrj/s1wIXI3beC24bSa6haar2oqTah
         pHV5974jL8i1dDbKiDQVH3+1RFezAlPMkVf6yhjGg7MRqpBkTpccAWo9lIffTjQV7o
         r0g44/kqc3BQ9U8jFrKIizSExY8xakB6AXYtxmunIjoWujFtn9gE9W4zvi7iVP0NJZ
         DanXWs6hIe9KxXDfNwLop315iJjh1vfqul890QreKrC0t7Vld+wDfmj4yI9gshPabR
         1y3i2KF4pduNw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1ouUbM-0001Kw-Hf; Mon, 14 Nov 2022 09:13:56 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2 0/6] phy: qcom-qmp-combo: preparatory fixes (set 1/3)
Date:   Mon, 14 Nov 2022 09:13:40 +0100
Message-Id: <20221114081346.5116-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.4
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

Here's a set of fixes for bugs founds while fixing the devicetree
binding and adding (proper) support for SC8280XP to the combo driver.

The full series is over forty patches and I'll be posting these in three
parts of which this is the first. In an effort to get all of these into
6.2, I'll also be submitting all three series before waiting for the
previous ones to be applied.

The first fix below could possibly be considered 6.1-rc material, but I
believe it's be fine to take all of these for 6.2.

Note that the next part of the series will do away with some of problems
with this driver that led to the issues being fixed here (e.g. the split
driver data and configuration).

Johan


Changes in v2
 - fix SW_PWRDN typo in commit message (Dmitry)
 - use the right commit for the runtime PM Fixes tag (Dmitry)


Johan Hovold (6):
  phy: qcom-qmp-combo: fix out-of-bounds clock access
  phy: qcom-qmp-combo: fix sdm845 reset
  phy: qcom-qmp-combo: fix sc8180x reset
  phy: qcom-qmp-combo: fix broken power on
  phy: qcom-qmp-combo: fix runtime suspend
  phy: qcom-qmp-combo: clean up common initialisation

 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 91 +++++++++++------------
 1 file changed, 44 insertions(+), 47 deletions(-)

-- 
2.37.4

