Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F2F609D51
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 11:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiJXJBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 05:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiJXJBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 05:01:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89A54D4FD;
        Mon, 24 Oct 2022 02:01:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E35E6108C;
        Mon, 24 Oct 2022 09:01:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCF56C43470;
        Mon, 24 Oct 2022 09:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666602097;
        bh=SLoNuE0wOlAn/sJQ6E07BFsAXMng8qt1Wiq6RyuB1MM=;
        h=From:To:Cc:Subject:Date:From;
        b=FMawn2Mi0AT5p/8QuvcGgd/YzYtdDQZPjTLr6yGd8153qHmn343LfNOTLwJPZxe5L
         qF3+Eo0CITPjdi3k9xfW2T6I3k26x2EBA7BKjZqvdwo6GCHVNlsXgJl95yKzOgMaoc
         TVWpo9BjLq4k8alB8Kp+Ydrz5kQtLO/lUamJpIaD8aMR6mPOAD1IiWVwpIlwOBrwiw
         iTRrLzPyO6OoulmERZX54MH8cvFbD7MqR6NwU+HNkptR+gBH3Qc2NALal5pWHh3qfZ
         vU/xWGz7ayQ/CHlQ6ANoftG/qHsaYmCvuJhAK7eZ7X+zIfVDrV+5Rr2qpC5llyae5g
         jr/43JdXKel7A==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1omtKi-00056L-TD; Mon, 24 Oct 2022 11:01:20 +0200
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
Subject: [PATCH 00/10] phy: qcom-qmp-ufs: fix sc8280xp binding
Date:   Mon, 24 Oct 2022 11:00:31 +0200
Message-Id: <20221024090041.19574-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.3
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

This series fixes the UFS PHY devicetree binding for SC8280XP and adds
support for the new updated binding to the driver.

The first half of the series clean up the driver in preparation for
supporting SC8280XP and its new binding that drops the legacy child node
and the (incomplete) description of register subregions.

The other QMP bindings suffer from similar problems and the PCIe driver
is being fixed here:

	https://lore.kernel.org/lkml/20221021110947.28103-1-johan+linaro@kernel.org/

and follow-on series will do corresponding changes to the USB and combo
QMP bindings and drivers.

Note that these patches depend on the linux-phy next branch of today and
the following two series:

 1. [PATCH v2 00/14] phy: qcom-qmp: further prep cleanups

    https://lore.kernel.org/lkml/20221012081241.18273-1-johan+linaro@kernel.org

 2. [PATCH 00/20] phy: qcom-qmp: further prep fixes and cleanups (set 3)

    https://lore.kernel.org/lkml/20221012084846.24003-1-johan+linaro@kernel.org

Johan


Johan Hovold (10):
  phy: qcom-qmp-ufs: move device-id table
  phy: qcom-qmp-ufs: merge driver data
  phy: qcom-qmp-ufs: clean up device-tree parsing
  phy: qcom-qmp-ufs: clean up probe initialisation
  phy: qcom-qmp-ufs: rename PHY ops structure
  phy: qcom-qmp-ufs: clean up PHY init
  dt-bindings: phy: qcom,qmp-ufs: rename current bindings
  dt-bindings: phy: qcom,qmp-ufs: fix sc8280xp binding
  phy: qcom-qmp-ufs: restructure PHY creation
  phy: qcom-qmp-ufs: add support for updated sc8280xp binding

 ...phy.yaml => qcom,msm8996-qmp-ufs-phy.yaml} |  17 +-
 .../phy/qcom,sc8280xp-qmp-ufs-phy.yaml        |  83 ++++
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c       | 381 +++++++++---------
 3 files changed, 287 insertions(+), 194 deletions(-)
 rename Documentation/devicetree/bindings/phy/{qcom,qmp-ufs-phy.yaml => qcom,msm8996-qmp-ufs-phy.yaml} (93%)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml

-- 
2.37.3

