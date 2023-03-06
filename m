Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C12066AB77D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 08:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjCFH5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 02:57:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjCFH5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 02:57:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A281B54F;
        Sun,  5 Mar 2023 23:57:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9124960C27;
        Mon,  6 Mar 2023 07:57:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53437C433AA;
        Mon,  6 Mar 2023 07:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678089456;
        bh=K26aMBWxlHn/kqrsAOXmsd/Ax8lLFUacKHubBz29pvM=;
        h=From:To:Cc:Subject:Date:From;
        b=Efw6f3Kh0QPT+wsdf45HNRQCHIpsbD+hBozYkazPWAwjdiGi57Eqyf2PlKmDY4pWd
         8XYxmeMHJLIjYpjJ6VijeWe2kAGeq6TRazi2S9OqAnR85Pi9odMMBlzxEnFaHVhpHp
         Lwm7IL49t06WcfqK5O32KhdpcKjNHdAYrHeJnZaxA8VV73xHfQgI9RRJLINNhURMHR
         e0PvAO4HWvgN4UNgszNaitLEqbXfZrQQflD5xdV+X0nKsS5I40yqO12MURfZxSB5q3
         P8WdS6SKYHHs8BIFgkSbcEnTuSA5EAgPPEPlULkEDa+SdV9z9cpYAgNN/Tsl80wEq7
         LWpJT6uYRRauw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pZ5ja-0000hr-WB; Mon, 06 Mar 2023 08:58:15 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     "Shawn Guo" <shawnguo@kernel.org>,
        "Sascha Hauer" <s.hauer@pengutronix.de>,
        "Pengutronix Kernel Team" <kernel@pengutronix.de>,
        "Fabio Estevam" <festevam@gmail.com>,
        "NXP Linux Team" <linux-imx@nxp.com>,
        "Andy Gross" <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        "Sylwester Nawrocki" <s.nawrocki@samsung.com>,
        =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        "Alim Akhtar" <alim.akhtar@samsung.com>,
        "Thierry Reding" <thierry.reding@gmail.com>,
        "Jonathan Hunter" <jonathanh@nvidia.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Dan Carpenter <error27@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2 00/23] interconnect: fix racy provider registration
Date:   Mon,  6 Mar 2023 08:56:28 +0100
Message-Id: <20230306075651.2449-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.2
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

The current interconnect provider interface is inherently racy as
providers are expected to be registered before being fully initialised.

This can specifically cause racing DT lookups to fail as I recently
noticed when the Qualcomm cpufreq driver failed to probe:

	of_icc_xlate_onecell: invalid index 0
        cpu cpu0: error -EINVAL: error finding src node
        cpu cpu0: dev_pm_opp_of_find_icc_paths: Unable to get path0: -22
        qcom-cpufreq-hw: probe of 18591000.cpufreq failed with error -22

This only happens very rarely, but the bug is easily reproduced by
increasing the race window by adding an msleep() after registering
osm-l3 interconnect provider.

Note that the Qualcomm cpufreq driver is especially susceptible to this
race as the interconnect path is looked up from the CPU nodes so that
driver core does not guarantee the probe order even when device links
are enabled (which they not always are).

This series adds a new interconnect provider registration API which is
used to fix up the interconnect drivers before removing the old racy
API.

Included are also a number of fixes for other bugs found while preparing
the series.

Johan


Changes in v2
 - icc_node_destroy() can be called with an arbitrary node id so add the
   missing sanity check to handle potential attempts to destroy a
   non-existing node (patch 01/23). Reported by Dan Carpenter and the
   kernel test robot:

   https://lore.kernel.org/oe-kbuild/202302222118.nGz1F0oJ-lkp@intel.com/


Johan Hovold (23):
  interconnect: fix mem leak when freeing nodes
  interconnect: fix icc_provider_del() error handling
  interconnect: fix provider registration API
  interconnect: imx: fix registration race
  interconnect: qcom: osm-l3: fix registration race
  interconnect: qcom: rpm: fix probe child-node error handling
  interconnect: qcom: rpm: fix probe PM domain error handling
  interconnect: qcom: rpm: fix registration race
  interconnect: qcom: rpmh: fix probe child-node error handling
  interconnect: qcom: rpmh: fix registration race
  interconnect: qcom: msm8974: fix registration race
  interconnect: qcom: sm8450: fix registration race
  interconnect: qcom: sm8550: fix registration race
  interconnect: exynos: fix node leak in probe PM QoS error path
  interconnect: exynos: fix registration race
  interconnect: exynos: drop redundant link destroy
  memory: tegra: fix interconnect registration race
  memory: tegra124-emc: fix interconnect registration race
  memory: tegra20-emc: fix interconnect registration race
  memory: tegra30-emc: fix interconnect registration race
  interconnect: drop racy registration API
  interconnect: drop unused icc_get() interface
  interconnect: drop unused icc_link_destroy() interface

 drivers/interconnect/core.c           | 152 +++++---------------------
 drivers/interconnect/imx/imx.c        |  20 ++--
 drivers/interconnect/qcom/icc-rpm.c   |  33 +++---
 drivers/interconnect/qcom/icc-rpmh.c  |  30 +++--
 drivers/interconnect/qcom/msm8974.c   |  20 ++--
 drivers/interconnect/qcom/osm-l3.c    |  14 +--
 drivers/interconnect/qcom/sm8450.c    |  22 ++--
 drivers/interconnect/qcom/sm8550.c    |  22 ++--
 drivers/interconnect/samsung/exynos.c |  30 ++---
 drivers/memory/tegra/mc.c             |  16 ++-
 drivers/memory/tegra/tegra124-emc.c   |  12 +-
 drivers/memory/tegra/tegra20-emc.c    |  12 +-
 drivers/memory/tegra/tegra30-emc.c    |  12 +-
 include/linux/interconnect-provider.h |  19 ++--
 include/linux/interconnect.h          |   8 --
 15 files changed, 157 insertions(+), 265 deletions(-)

-- 
2.39.2

