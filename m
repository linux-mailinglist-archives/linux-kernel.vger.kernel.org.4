Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7600664CAF9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 14:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238578AbiLNNTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 08:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238426AbiLNNS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 08:18:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63AAE205D8;
        Wed, 14 Dec 2022 05:18:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0085361A6D;
        Wed, 14 Dec 2022 13:18:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47131C43392;
        Wed, 14 Dec 2022 13:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671023934;
        bh=nnr17/76ojmrtu3Co48KLMzaUzbzMgFxhN+A+PvMGo0=;
        h=From:To:Cc:Subject:Date:From;
        b=NyOELBd+dxAFQUM7O4WYB2KKigLf2eAT/a8BJX4Tdh5YFIE9DYaLwK/Sp8M7AZOeH
         q4yfeUsevr3vxsCb2CHZcnMSUkbv2iVQKbH7LjRN32deVSK38gKnNetUQK0HrUHj/5
         L96KPkyfAP3IaElm6AdKXwXQN9PZxw1RNA3ipDxG/WoX9vXGMAnMhq2Fc00XuAyFBK
         CjS+nsV8qVkdsi3ecIpiU4vcvFO7UjVnfxi0OcV1qx5sBDU4oRXVbaInmiptqk34gV
         Ixony2FmcWvUQUVXipx/YaWTlBXDBrV2VXiVy/O0Bf23I30eQ/jc4QTyeVuBTBEs9+
         zKdT9GtSM/TPA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1p5RfN-0000gG-Kq; Wed, 14 Dec 2022 14:19:22 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 0/4] thermal: fix locking regressions in linux-next
Date:   Wed, 14 Dec 2022 14:16:13 +0100
Message-Id: <20221214131617.2447-1-johan+linaro@kernel.org>
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

This series fixes some of the fallout after the thermal changes that
just landed in linux-next.

Lockdep reported a lock inversion in one of the Qualcomm drivers and a
closer review revealed that the changes had also broken the sysfs
interface for at least three drivers.

Note that a simple revert of the offending patches was not an option as
some of the infrastructure that the old implementation relied on has
also been removed.

Johan


Johan Hovold (4):
  thermal/drivers/qcom: fix set_trip_temp() deadlock
  thermal/drivers/exynos: fix set_trip_temp() deadlock
  thermal/drivers/tegra: fix set_trip_temp() deadlock
  thermal/drivers/qcom: fix lock inversion

 drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 7 ++++++-
 drivers/thermal/samsung/exynos_tmu.c        | 2 +-
 drivers/thermal/tegra/soctherm.c            | 2 +-
 drivers/thermal/thermal_core.c              | 1 +
 include/linux/thermal.h                     | 2 ++
 5 files changed, 11 insertions(+), 3 deletions(-)

-- 
2.37.4

