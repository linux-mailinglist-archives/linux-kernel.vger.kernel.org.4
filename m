Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A02815B8CEC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 18:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbiINQ1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 12:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiINQ0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 12:26:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF1761B28;
        Wed, 14 Sep 2022 09:26:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8A598B81716;
        Wed, 14 Sep 2022 16:26:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19A3CC433D7;
        Wed, 14 Sep 2022 16:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663172798;
        bh=vDveHZQ9xciJivnArL5NqFVvDcH1WaihkYv/yDHtspw=;
        h=From:To:Cc:Subject:Date:From;
        b=cxJtKKgZ7Tq91I9mGFjtvk0iCBB10AXUcdPEQ564g6z+g09SoIszh2AffDjroIjRh
         qoFk48Bl5Ie7l4i7roAASl7s92OAyZFgrhD/YY84YYKF40dN2/ai4f0ESkuUjGlVNa
         gjJXHDJn3KeRzPqwgg1J7Vu7S8Y7Spy0nHGgN6MOLUia7FmqNWROCtZhCSmgZKKfq+
         yE5m2mypgTFf5jm2wjD7RCPa4iJNjRycTxj0sANickGJLFBlIlE/t13vaYP/ASxsop
         Gtm0b9tYe0CYkjLc3ErqWCifL2kccgOSvP6YkdyyxHOoBYzuk5uPSXXmu6ZJpi7I7+
         lJzvLA+o9FONQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oYVDj-0001eX-Cs; Wed, 14 Sep 2022 18:26:39 +0200
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
Subject: [PATCH 00/11] phy: qcom-qmp: more fixes and cleanups
Date:   Wed, 14 Sep 2022 18:25:34 +0200
Message-Id: <20220914162545.6289-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's the next set of QMP PHY cleanups including some non-critical
fixes of tiny memory leaks on probe deferral (I didn't add a stable tag
for any of them on purpose).

Note that the UFS PHY driver does not use the pcs_misc region either
currently, but I decided to leave the register mapping code in as,
unlike for msm8996, the bindings do include this region.

These apply on top of the previous clean up series, which has been
reviewed by Dmitry and is ready to be merged (apart from possibly a tiny
fixup of the last patch):

	https://lore.kernel.org/all/20220907110728.19092-1-johan+linaro@kernel.org/

Johan


Johan Hovold (11):
  phy: qcom-qmp-pcie: add pcs_misc sanity check
  phy: qcom-qmp-pcie: fix memleak on probe deferral
  phy: qcom-qmp-pcie-msm8996: fix memleak on probe deferral
  phy: qcom-qmp-combo: fix memleak on probe deferral
  phy: qcom-qmp-ufs: fix memleak on probe deferral
  phy: qcom-qmp-usb: fix memleak on probe deferral
  phy: qcom-qmp-pcie-msm8996: drop unused pcs_misc handling
  phy: qcom-qmp-pcie: drop unused legacy DT workaround
  phy: qcom-qmp-combo: drop unused legacy DT workaround
  phy: qcom-qmp-ufs: drop legacy DT workaround
  phy: qcom-qmp-usb: drop legacy DT workaround

 drivers/phy/qualcomm/phy-qcom-qmp-combo.c     | 53 +++++++----------
 .../phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c  | 33 +++--------
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c      | 59 ++++++++-----------
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c       | 53 ++++++-----------
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c       | 55 +++++++----------
 5 files changed, 92 insertions(+), 161 deletions(-)

-- 
2.35.1

