Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33AA1601221
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbiJQO7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbiJQO6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:58:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B84F6AA2A;
        Mon, 17 Oct 2022 07:55:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0809611AD;
        Mon, 17 Oct 2022 14:54:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9988C43149;
        Mon, 17 Oct 2022 14:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666018478;
        bh=VKMDTbHv0AiIQSESofuPs9ChGtLIC51Zy4gJKPAy3+E=;
        h=From:To:Cc:Subject:Date:From;
        b=Spgh03yrPMbxZJgxUXwKprKaMZDHAt6ArVFbdkU6dOCbafhhl14ESe9o5rhss5PNc
         dLIiHqpXDz4x4KYLNigdm5JfZm33eJthOyUZ2lKlJHowg+xiBdKcifQZds0TuFXRpB
         0W8IlP+ZZLC0rmhDx7lIEIkOxj9dZq2PX+2z2OcYzV0cG+IwtilPyhOB3TkwE88+8C
         HgWwnJa7M38y0jSnzIQD5Pz5Fe1eP2/xajayrf0mH7Z0cCIkkDmqKrhRfz9cY81Uk7
         Xuo3BcgXQh63NiQBf+81Hf1EstuMEctQM8inV5d3XPlMeBVo9wIJkEkWTGy400VFqS
         WY8BpfXxD7xPA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1okRVb-0005lv-Lm; Mon, 17 Oct 2022 16:54:28 +0200
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
Subject: [PATCH 00/15] phy: qcom-qmp-pcie: add support for sc8280xp
Date:   Mon, 17 Oct 2022 16:53:13 +0200
Message-Id: <20221017145328.22090-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for the PCIe PHYs on SC8280XP including its
four-lane PHYs.

The first half of the series clean up the driver in preparation for
supporting SC8280XP and its new devicetree bindings that drops the
legacy child node and the (incomplete) description of register
subregions.

The other QMP bindings suffer from similar problems and follow-on series
will do corresponding changes to the UFS, USB and combo QMP bindings and
drivers.

Note that these patches depend on the linux-phy next branch of today and
the following two series:

 1. [PATCH v2 00/14] phy: qcom-qmp: further prep cleanups

    https://lore.kernel.org/lkml/20221012081241.18273-1-johan+linaro@kernel.org

 2. [PATCH 00/20] phy: qcom-qmp: further prep fixes and cleanups (set 3)

    https://lore.kernel.org/lkml/20221012084846.24003-1-johan+linaro@kernel.org

Johan


Johan Hovold (15):
  phy: qcom-qmp-pcie: sort device-id table
  phy: qcom-qmp-pcie: move device-id table
  phy: qcom-qmp-pcie: merge driver data
  phy: qcom-qmp-pcie: clean up device-tree parsing
  phy: qcom-qmp-pcie: clean up probe initialisation
  phy: qcom-qmp-pcie: rename PHY ops structure
  phy: qcom-qmp-pcie: clean up PHY lane init
  phy: qcom-qmp-pcie: add register init helper
  dt-bindings: phy: qcom,qmp-pcie: mark current bindings as legacy
  dt-bindings: phy: qcom,qmp-pcie: add sc8280xp bindings
  phy: qcom-qmp-pcie: restructure PHY creation
  phy: qcom-qmp-pcie: fix initialisation reset
  phy: qcom-qmp-pcie: add support for pipediv2 clock
  phy: qcom-qmp-pcie: add support for sc8280xp
  phy: qcom-qmp-pcie: add support for sc8280xp 4-lane PHYs

 .../phy/qcom,qmp-pcie-phy-legacy.yaml         | 296 ++++++
 .../bindings/phy/qcom,qmp-pcie-phy.yaml       | 331 ++-----
 drivers/phy/qualcomm/Kconfig                  |   1 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c      | 853 ++++++++++++------
 .../phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5.h   |   2 +
 5 files changed, 999 insertions(+), 484 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,qmp-pcie-phy-legacy.yaml

-- 
2.37.3

