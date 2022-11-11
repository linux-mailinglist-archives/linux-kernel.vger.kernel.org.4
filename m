Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F006256C6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 10:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233803AbiKKJ0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 04:26:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233704AbiKKJ0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 04:26:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E876EB49;
        Fri, 11 Nov 2022 01:26:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 973AC61F0C;
        Fri, 11 Nov 2022 09:26:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAA72C433B5;
        Fri, 11 Nov 2022 09:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668158764;
        bh=WEY2NyK7kGYSFZQ1MVYoHe3uZ9puPVnYkW8PQVcfqcw=;
        h=From:To:Cc:Subject:Date:From;
        b=VY1jZEd7SGw28EB7kPDbF3wRCNldktRQayjUTL47oIR4d3Xod0RdEaAqy56N8MwaT
         lVXsHZFNlvslLGu4qNFn3Cy9e4X7z3SZpnlgenVHycnyJ4A4A7r1M2nxDo84SeinMk
         DcmUb4Ftyf8kk3O8cVWcMqpX6xJJE9amaZErjraZtX1gKk2FEVlTy8jxiVVMkjE67A
         PiU8qgesJaIxxK9jIcOpqF3tDNaU9XMcvtG0/2NNaLO7lICrAdDt397UuIuZaWmuK7
         6fIYwBbxSbqf1mp4pX3Joe3SC5N9bBhtKC1lX0Z3zoCiifo36ATH+VymDJzJC5qi2D
         cDGV+oEYU7w2w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1otQI3-0002kn-Oy; Fri, 11 Nov 2022 10:25:36 +0100
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
Subject: [PATCH 00/14] phy: qcom-qmp-combo: fix sc8280xp binding (set 3/3)
Date:   Fri, 11 Nov 2022 10:24:43 +0100
Message-Id: <20221111092457.10546-1-johan+linaro@kernel.org>
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

This series fixes the USB-DP PHY devicetree binding for SC8280XP and
adds support for the new updated binding to the driver.

As the full series including the preparatory parts is over forty patches
and I've been posting this in three parts of which this is the last one.
In an effort to get all of these into 6.2, I've also submitted all three
series before waiting for the previous ones to be applied. Parts one and
two can be found here:

	https://lore.kernel.org/lkml/20221111084255.8963-1-johan+linaro@kernel.org/
	https://lore.kernel.org/lkml/20221111085643.9478-1-johan+linaro@kernel.org/

This last series adds a new binding for SC8280XP that drops the legacy
child node and the (incomplete) description of register subregions.

As the current bindings are both incomplete and incorrect it may be
a good idea to update also the other platforms currently supported by
this driver to the new binding scheme. The driver can support both
schemes during a transitions period before removing the corresponding
code (dt parsing and clock-provider registration).

Johan


Johan Hovold (14):
  dt-bindings: phy: qcom,qmp-usb3-dp: rename current bindings
  dt-bindings: phy: qcom,qmp-usb3-dp: fix sc8280xp bindings
  phy: qcom-qmp-combo: drop v4 reference-clock source
  phy: qcom-qmp-combo: restructure PHY creation
  phy: qcom-qmp-combo: register clocks sooner
  phy: qcom-qmp-combo: generate pipe clock name
  phy: qcom-qmp-combo: drop redundant clock structure
  phy: qcom-qmp-combo: drop redundant clock allocation
  phy: qcom-qmp-combo: add clock registration helper
  phy: qcom-qmp-combo: separate clock and provider registration
  phy: qcom-qmp-combo: clean up DP clock callbacks
  phy: qcom-qmp-combo: rename common-register pointers
  phy: qcom-qmp-combo: rename DP_PHY register pointer
  phy: qcom-qmp-combo: add support for updated sc8280xp binding

 ....yaml => qcom,sc7180-qmp-usb3-dp-phy.yaml} |  23 +-
 .../phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml    | 111 ++++
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c     | 532 +++++++++++-------
 3 files changed, 441 insertions(+), 225 deletions(-)
 rename Documentation/devicetree/bindings/phy/{qcom,qmp-usb3-dp-phy.yaml => qcom,sc7180-qmp-usb3-dp-phy.yaml} (92%)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml

-- 
2.37.4

