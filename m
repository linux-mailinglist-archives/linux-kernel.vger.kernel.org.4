Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C6B6BCA8F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 10:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjCPJRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 05:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbjCPJRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 05:17:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8D9A0F3F;
        Thu, 16 Mar 2023 02:17:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 45CD0B81EBA;
        Thu, 16 Mar 2023 09:17:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD2EBC433A7;
        Thu, 16 Mar 2023 09:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678958257;
        bh=zyT8xkfWDFX+ZVDBAje6rf/gFx+GN8afenbi9RxVCJg=;
        h=From:To:Cc:Subject:Date:From;
        b=hN0jOpum8PpGRyHdTUdc+1+87Vx5xvVICCz7Uio/1zS3c6/q/RdCKfFV5l7N1aB7y
         c3FqHIjEGwclFeqqOK9wpLznfhVZ4DHBzYdKdrcHWr8AMRb9avXYJdJXhPjyoYa2hR
         Bizqyjojb56/LKF6fJNOS+fgQIqoDJDd1Kaj3Ah7k+v6NMDzLH5itVERB8gvXBqaoN
         hTt7CQDXfXmbTsOEKRc5aP3ueE3vgbuK1/TnEeVsCByc1kcOwuL4arj6kMigx/ihhU
         r5hltqiiT7LaX/cSKsrNWqxmXsMhQbRRWsbwWo7DZW/cM/ajqdDPg9H5K0KwQLTFTf
         86+De5IY5yvRw==
From:   Georgi Djakov <djakov@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        djakov@kernel.org
Subject: [GIT PULL] interconnect fixes for 6.3-rc
Date:   Thu, 16 Mar 2023 11:16:55 +0200
Message-Id: <20230316091655.865358-1-djakov@kernel.org>
X-Mailer: git-send-email 2.34.1
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

Hello Greg,

This pull request contains fixes for the current cycle. These are fixing
a race condition and other reported issues. The details are in the signed
tag. All patches has been in linux-next during the last few days (but in
practice even for more than a week - i dropped one patch and some hashes
changed). Please pull into char-misc-linus when possible.

Thanks,
Georgi


The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-6.3-rc3

for you to fetch changes up to 9db481c909dd6312ccfbdc7e343b50e41c727483:

  memory: tegra30-emc: fix interconnect registration race (2023-03-13 21:13:49 +0200)

----------------------------------------------------------------
interconnect fixes for v6.3-rc

This contains a bunch of fixes with the highlight being fixes for a race
condition that could sometimes occur during the interconnect provider
driver registration. There are also fixes for memory overallocation and
a memory leak.

- interconnect: qcom: osm-l3: fix icc_onecell_data allocation
- interconnect: qcom: sm8450: switch to qcom_icc_rpmh_* function
- interconnect: qcom: sm8550: switch to qcom_icc_rpmh_* function
- interconnect: qcom: qcm2290: Fix MASTER_SNOC_BIMC_NRT
- interconnect: fix mem leak when freeing nodes
- interconnect: fix icc_provider_del() error handling
- interconnect: fix provider registration API
- interconnect: imx: fix registration race
- interconnect: qcom: osm-l3: fix registration race
- interconnect: qcom: rpm: fix probe child-node error handling
- interconnect: qcom: rpm: fix registration race
- interconnect: qcom: rpmh: fix probe child-node error handling
- interconnect: qcom: rpmh: fix registration race
- interconnect: qcom: msm8974: fix registration race
- interconnect: exynos: fix node leak in probe PM QoS error path
- interconnect: exynos: fix registration race
- interconnect: exynos: drop redundant link destroy
- memory: tegra: fix interconnect registration race
- memory: tegra124-emc: fix interconnect registration race
- memory: tegra20-emc: fix interconnect registration race
- memory: tegra30-emc: fix interconnect registration race

Signed-off-by: Georgi Djakov <djakov@kernel.org>

----------------------------------------------------------------
Dmitry Baryshkov (3):
      interconnect: qcom: osm-l3: fix icc_onecell_data allocation
      interconnect: qcom: sm8450: switch to qcom_icc_rpmh_* function
      interconnect: qcom: sm8550: switch to qcom_icc_rpmh_* function

Johan Hovold (17):
      interconnect: fix mem leak when freeing nodes
      interconnect: fix icc_provider_del() error handling
      interconnect: fix provider registration API
      interconnect: imx: fix registration race
      interconnect: qcom: osm-l3: fix registration race
      interconnect: qcom: rpm: fix probe child-node error handling
      interconnect: qcom: rpm: fix registration race
      interconnect: qcom: rpmh: fix probe child-node error handling
      interconnect: qcom: rpmh: fix registration race
      interconnect: qcom: msm8974: fix registration race
      interconnect: exynos: fix node leak in probe PM QoS error path
      interconnect: exynos: fix registration race
      interconnect: exynos: drop redundant link destroy
      memory: tegra: fix interconnect registration race
      memory: tegra124-emc: fix interconnect registration race
      memory: tegra20-emc: fix interconnect registration race
      memory: tegra30-emc: fix interconnect registration race

Konrad Dybcio (1):
      interconnect: qcom: qcm2290: Fix MASTER_SNOC_BIMC_NRT

 drivers/interconnect/core.c           | 68 +++--
 drivers/interconnect/imx/imx.c        | 20 +-
 drivers/interconnect/qcom/icc-rpm.c   | 29 ++-
 drivers/interconnect/qcom/icc-rpmh.c  | 30 ++-
 drivers/interconnect/qcom/msm8974.c   | 20 +-
 drivers/interconnect/qcom/osm-l3.c    | 16 +-
 drivers/interconnect/qcom/qcm2290.c   |  4 +-
 drivers/interconnect/qcom/sm8450.c    | 98 +------
 drivers/interconnect/qcom/sm8550.c    | 99 +-------
 drivers/interconnect/samsung/exynos.c | 30 +--
 drivers/memory/tegra/mc.c             | 16 +-
 drivers/memory/tegra/tegra124-emc.c   | 12 +-
 drivers/memory/tegra/tegra20-emc.c    | 12 +-
 drivers/memory/tegra/tegra30-emc.c    | 12 +-
 include/linux/interconnect-provider.h | 12 +
 15 files changed, 158 insertions(+), 320 deletions(-)
