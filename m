Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF187463F0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 22:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjGCUTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 16:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjGCUTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 16:19:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236BBE47;
        Mon,  3 Jul 2023 13:19:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB4A360F1D;
        Mon,  3 Jul 2023 20:19:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78C3BC433C8;
        Mon,  3 Jul 2023 20:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688415543;
        bh=Bho0HWTGqswebYZftJzWBw9tCtS4GbuUl26UGY4111o=;
        h=From:To:Cc:Subject:Date:From;
        b=EaDV6colSSZJy2r0pAUsx/HkfOAC9iNVGAjWUQ+NcHJotEHb4Dt7xm2sZNUtTZ5O1
         Cnqv93NYqRASXTUGHtl4eX48mhKGWzEaeqh6Cz8xlWfV77D3ssdGOY2CDGyjbIqfZ9
         Wa1n7PT17REJTkUsOhNf4KvBIGF0RctiqvuT7hMmBvhorppJyg3CS/2Vdn4iHatPrv
         2XcOn1ybTkRA4y7WMULaa90YFKbI6zj6vdtotb7XblYXqp654pplVE9MBwuTxNzNwM
         DwF1Xwp1nzeOGPVD1QMLYBFI0W4UgRiGmhcudhsXhqoVSF3URniRcfV+ryXfHqNqL5
         NTrTp54zDpccQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [GIT PULL] remoteproc updates for v6.5
Date:   Mon,  3 Jul 2023 13:22:46 -0700
Message-ID: <20230703202248.3083122-1-andersson@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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


The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/rproc-v6.5

for you to fetch changes up to 181da4bcc3d4bb4b58e3df481e72353925b36edd:

  remoteproc: qcom_q6v5_pas: staticize adsp_segment_dump() (2023-06-14 08:16:04 -0700)

----------------------------------------------------------------
remoteproc updates for v6.5

The bulk of these patches relates to the moving to a void-returning
remove callback.

The i.MX HiFi remoteproc driver gets its pm_ops helpers updated to
resolve build warnings about "defined but not used" variables in certain
configurations.

The ST STM32 remoteproc driver is extended to allow using a SCMI reset
controller to hold boot, and has an error message corrected.

The Qualcomm Q6V5 PAS driver gains a missing "static" qualifier on
adsp_segment_dump().

----------------------------------------------------------------
Arnaud Pouliquen (2):
      dt-bindings: remoteproc: st,stm32-rproc: Rework reset declarations
      remoteproc: stm32: Allow hold boot management by the SCMI reset controller

Arnd Bergmann (1):
      remoteproc: imx_dsp_rproc: use modern pm_ops

Dan Carpenter (1):
      remoteproc: stm32: Fix error code in stm32_rproc_parse_dt()

Krzysztof Kozlowski (1):
      remoteproc: qcom_q6v5_pas: staticize adsp_segment_dump()

Uwe Kleine-König (18):
      remoteproc: da8xx: Convert to platform remove callback returning void
      remoteproc: imx_dsp: Convert to platform remove callback returning void
      remoteproc: imx: Convert to platform remove callback returning void
      remoteproc: keystone: Convert to platform remove callback returning void
      remoteproc: meson_mx_ao_arc: Convert to platform remove callback returning void
      remoteproc: mtk_scp: Convert to platform remove callback returning void
      remoteproc: omap: Convert to platform remove callback returning void
      remoteproc: pru: Convert to platform remove callback returning void
      remoteproc: qcom_q6v5_adsp: Convert to platform remove callback returning void
      remoteproc: qcom_q6v5_mss: Convert to platform remove callback returning void
      remoteproc: qcom_q6v5_pas: Convert to platform remove callback returning void
      remoteproc: qcom_q6v5_wcss: Convert to platform remove callback returning void
      remoteproc: qcom_wcnss: Convert to platform remove callback returning void
      remoteproc: rcar: Convert to platform remove callback returning void
      remoteproc: virtio: Convert to platform remove callback returning void
      remoteproc: st: Convert to platform remove callback returning void
      remoteproc: stm32: Convert to platform remove callback returning void
      remoteproc: wkup_m3: Convert to platform remove callback returning void

 .../bindings/remoteproc/st,stm32-rproc.yaml        | 44 ++++++++++--
 drivers/remoteproc/da8xx_remoteproc.c              |  6 +-
 drivers/remoteproc/imx_dsp_rproc.c                 | 17 ++---
 drivers/remoteproc/imx_rproc.c                     |  6 +-
 drivers/remoteproc/keystone_remoteproc.c           |  6 +-
 drivers/remoteproc/meson_mx_ao_arc.c               |  6 +-
 drivers/remoteproc/mtk_scp.c                       |  6 +-
 drivers/remoteproc/omap_remoteproc.c               |  6 +-
 drivers/remoteproc/pru_rproc.c                     |  6 +-
 drivers/remoteproc/qcom_q6v5_adsp.c                |  6 +-
 drivers/remoteproc/qcom_q6v5_mss.c                 |  6 +-
 drivers/remoteproc/qcom_q6v5_pas.c                 |  8 +--
 drivers/remoteproc/qcom_q6v5_wcss.c                |  6 +-
 drivers/remoteproc/qcom_wcnss.c                    |  6 +-
 drivers/remoteproc/rcar_rproc.c                    |  6 +-
 drivers/remoteproc/remoteproc_virtio.c             |  6 +-
 drivers/remoteproc/st_remoteproc.c                 |  6 +-
 drivers/remoteproc/stm32_rproc.c                   | 82 +++++++++++++++-------
 drivers/remoteproc/wkup_m3_rproc.c                 |  6 +-
 19 files changed, 136 insertions(+), 105 deletions(-)
