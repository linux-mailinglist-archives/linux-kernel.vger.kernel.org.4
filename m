Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E6E738CF8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 19:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbjFURVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 13:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjFURVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 13:21:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909CF19AE;
        Wed, 21 Jun 2023 10:21:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D1B361631;
        Wed, 21 Jun 2023 17:21:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6411DC433C8;
        Wed, 21 Jun 2023 17:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687368088;
        bh=ImI/EoOrplWaRitID8FmoePKefv5hlzrqc5MOdwy1+c=;
        h=From:To:Cc:Subject:Date:From;
        b=db4bX4R2saYrT0t9pYQ2VPflY/P4nPrUt63Lg+XYCcbmQ3r0QOeFAh8McXU4q1+0a
         arOzARG0xkowTLPsVf1KMFJ+7zZDINKa64lKRJDdCzXw7zZGB4yGT/ITWmphdSBNr2
         tCFABQVDS7VpttHYK0yQOOhD9/iFBdrrCkTnUUb+x+peUUNcJ3YPojY3d9pHPnd+FA
         KMY3cb+ckH7LPHuoth3uZCJ1lCKPBDPvGe6NlnIKxKAqp/EwRqPzeyhSCAmFFNqVX4
         BinDAzQUDizS3fKukM0fVkBoTxNgloJgBznkHiZkf+8qEOV07U+ThzaJxh1gmycyzB
         BpukG98j7U6nQ==
From:   Georgi Djakov <djakov@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        djakov@kernel.org
Subject: [GIT PULL] interconnect changes for 6.5
Date:   Wed, 21 Jun 2023 20:21:21 +0300
Message-Id: <20230621172121.2049612-1-djakov@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

This is the pull request with interconnect changes for the 6.5-rc1 merge
window. In contains a mix of core and driver changes. The details are in
the signed tag.

All patches have been in linux-next during last 10+ days. Please pull into
char-misc-next when possible.

Thanks,
Georgi

The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-6.5-rc1

for you to fetch changes up to 1400725e45152a62fa43f8275e6bee99d584c967:

  Merge branch 'icc-qos' into icc-next (2023-06-10 10:43:50 +0300)

----------------------------------------------------------------
interconnect changes for 6.5

This pull request contains the interconnect changes for the 6.5-rc1 merge
window which is a mix of core and driver changes with the following highlights:

- Support for configuring QoS on the Qualcomm's RPM-based platforms, that
  required special handling of some interface (non-scaling) clocks.
- Support for clock-based interconnect providers for cases when clock
  corresponds to bus bandwidth. This is used to enable CPU cluster bandwidth
  scaling on MSM8996 platforms. One patch is touching a file in the clock
  subsystem that has been acked by the maintainer.

Core changes:
	interconnect: add clk-based icc provider support
	interconnect: icc-clk: fix modular build
	interconnect: drop unused icc_get() interface

Driver changes:
	interconnect: qcom: rpm: Rename icc desc clocks to bus_blocks
	interconnect: qcom: rpm: Rename icc provider num_clocks to num_bus_clocks
	interconnect: qcom: rpm: Drop unused parameters
	interconnect: qcom: rpm: Set QoS registers only once
	interconnect: qcom: rpm: Handle interface clocks
	interconnect: qcom: icc-rpm: Enforce 2 or 0 bus clocks
	interconnect: qcom: rpm: Don't use clk_get_optional for bus clocks anymore
	interconnect: qcom: msm8996: Promote to core_initcall
	interconnect: qcom: rpm: allocate enough data in probe()
	dt-bindings: interconnect/msm8996-cbf: add defines to be used by CBF
	clk: qcom: cbf-msm8996: scale CBF clock according to the CPUfreq
	dt-bindings: interconnect: fsl,imx8m-noc: drop unneeded quotes

Signed-off-by: Georgi Djakov <djakov@kernel.org>

----------------------------------------------------------------
Dan Carpenter (1):
      interconnect: qcom: rpm: allocate enough data in probe()

Dmitry Baryshkov (4):
      dt-bindings: interconnect/msm8996-cbf: add defines to be used by CBF
      interconnect: add clk-based icc provider support
      clk: qcom: cbf-msm8996: scale CBF clock according to the CPUfreq
      interconnect: icc-clk: fix modular build

Georgi Djakov (2):
      Merge branch 'icc-cbf' into icc-next
      Merge branch 'icc-qos' into icc-next

Johan Hovold (1):
      interconnect: drop unused icc_get() interface

Konrad Dybcio (8):
      interconnect: qcom: rpm: Rename icc desc clocks to bus_blocks
      interconnect: qcom: rpm: Rename icc provider num_clocks to num_bus_clocks
      interconnect: qcom: rpm: Drop unused parameters
      interconnect: qcom: rpm: Set QoS registers only once
      interconnect: qcom: rpm: Handle interface clocks
      interconnect: qcom: icc-rpm: Enforce 2 or 0 bus clocks
      interconnect: qcom: rpm: Don't use clk_get_optional for bus clocks anymore
      interconnect: qcom: msm8996: Promote to core_initcall

Krzysztof Kozlowski (1):
      dt-bindings: interconnect: fsl,imx8m-noc: drop unneeded quotes

 .../devicetree/bindings/interconnect/fsl,imx8m-noc.yaml         |   2 +-
 drivers/clk/qcom/Kconfig                                        |   1 +
 drivers/clk/qcom/clk-cbf-8996.c                                 |  60 ++-
 drivers/interconnect/Kconfig                                    |   6 +
 drivers/interconnect/Makefile                                   |   2 +
 drivers/interconnect/core.c                                     |  52 +--
 drivers/interconnect/icc-clk.c                                  | 174 ++++++++
 drivers/interconnect/qcom/icc-rpm.c                             | 112 ++---
 drivers/interconnect/qcom/icc-rpm.h                             |  22 +-
 drivers/interconnect/qcom/msm8996.c                             |  35 +-
 drivers/interconnect/qcom/sdm660.c                              |  17 +-
 include/dt-bindings/interconnect/qcom,msm8996-cbf.h             |  12 +
 include/linux/interconnect-clk.h                                |  22 +
 include/linux/interconnect.h                                    |   8 -
 14 files changed, 382 insertions(+), 143 deletions(-)
 create mode 100644 drivers/interconnect/icc-clk.c
 create mode 100644 include/dt-bindings/interconnect/qcom,msm8996-cbf.h
 create mode 100644 include/linux/interconnect-clk.h
