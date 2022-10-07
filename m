Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3CE5F72AE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 04:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbiJGCK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 22:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbiJGCKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 22:10:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F18A4BAE;
        Thu,  6 Oct 2022 19:10:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A5E37B821FA;
        Fri,  7 Oct 2022 02:10:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69602C433C1;
        Fri,  7 Oct 2022 02:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665108648;
        bh=/2L93yu9h4AM1NVI3+iOZO/MK68ZsD8Z/BzSgx4lnvo=;
        h=From:To:Cc:Subject:Date:From;
        b=edRQ1UqbsgxfquW31+Nhl/w4FAqE3jI2HFgYSxyz1H8liiYlf5IAW0EdpW9qh6hf1
         N5r8Ya9MDH50lJBVOJs5sdJP3Yic6dS1KF+6e72M2qY771LxMGADU93HBLyD7inMFA
         +njuXLjuAjxlYjgyWyDHDt9iQBWmjALIfVMREWQec/bcvwA2daf/dn44l6N11d/164
         dUBbK+2+vTWbTJ2O5bH9mcZMr0806BMCuECuVGZUH+zD/wmFZgnzQFHzWTfBmzs5Qt
         4K1yhWy8xKEPerbNdm0G7CrFj5LqOU89VOqupdTu1Kg6cm2HAumB+YEAXlUbgDPKMF
         GgyLMVYg2bt7A==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Peng Fan <peng.fan@nxp.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [GIT PULL] remoteproc updates for v6.1
Date:   Thu,  6 Oct 2022 21:10:46 -0500
Message-Id: <20221007021046.2585078-1-andersson@kernel.org>
X-Mailer: git-send-email 2.37.1
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

The following changes since commit 1c23f9e627a7b412978b4e852793c5e3c3efc555:

  Linux 6.0-rc2 (2022-08-21 17:32:54 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/rproc-v6.1

for you to fetch changes up to ccf22a48cc8789a35befea783448c259463a5eef:

  remoteproc: virtio: Fix warning on bindings by removing the of_match_table (2022-10-05 09:20:44 -0600)

----------------------------------------------------------------
remoteproc updates for v6.1

Support for remoteprocs that will perform recovery without help from
Linux is introduced.

The virtio integration is transitioned towards remoteproc_virtio.c and
represented by a platform_device, in preparation for instantiating
virtio instances from DeviceTree.

The iMX remoteproc driver has a couple of sparse warnings corrected and
a couple of error message printouts are cleaned up. The keystone driver
is transitioned to use the gpiod API.

----------------------------------------------------------------
Arnaud Pouliquen (5):
      remoteproc: core: Introduce rproc_rvdev_add_device function
      remoteproc: core: Introduce rproc_add_rvdev function
      remoteproc: Move rproc_vdev management to remoteproc_virtio.c
      remoteproc: virtio: Create platform device for the remoteproc_virtio
      remoteproc: virtio: Fix warning on bindings by removing the of_match_table

Christophe JAILLET (1):
      remoteproc: imx_rproc: Simplify some error message

Dan Carpenter (1):
      remoteproc: Harden rproc_handle_vdev() against integer overflow

Dmitry Torokhov (1):
      remoteproc/keystone: Switch to using gpiod API

Peng Fan (2):
      remoteproc: Introduce rproc features
      remoteproc: Support attach recovery after rproc crash

Shengjiu Wang (1):
      remoteproc: imx_dsp_rproc: fix argument 2 of rproc_mem_entry_init

wangjianli (1):
      drivers/remoteproc: Fix repeated words in comments

 drivers/remoteproc/imx_dsp_rproc.c       |   4 +-
 drivers/remoteproc/imx_rproc.c           |  14 +-
 drivers/remoteproc/keystone_remoteproc.c |  16 ++-
 drivers/remoteproc/remoteproc_core.c     | 223 +++++++++----------------------
 drivers/remoteproc/remoteproc_internal.h |  38 +++++-
 drivers/remoteproc/remoteproc_virtio.c   | 183 ++++++++++++++++++++++---
 include/linux/remoteproc.h               |  22 ++-
 7 files changed, 298 insertions(+), 202 deletions(-)
