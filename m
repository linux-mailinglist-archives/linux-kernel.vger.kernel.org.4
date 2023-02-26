Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABC86A331A
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 18:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjBZRLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 12:11:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjBZRLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 12:11:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F033FF0A;
        Sun, 26 Feb 2023 09:11:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9534160C16;
        Sun, 26 Feb 2023 17:11:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BDE8C433EF;
        Sun, 26 Feb 2023 17:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677431503;
        bh=1rBK7hQlrc3fLdxpLo+oE8p6m/aUbee754KW6xGHOG4=;
        h=From:To:Cc:Subject:Date:From;
        b=aHfW7IyMp2vVwKmBB+KsLWtoDrmYWm2FuHe96rdgr7vbnXNc2bq9Qc9Oe2r44zIJj
         dHYFfylSR1S3V2xJKU9Fmw5XGsxhySIlmWcUcTQZ2wVMqHBMWSQB6DsTjRdUo2h+Ff
         D3aYVSMvwK7oa+erxCrDQBVzCPk3ywyc3vN6Wo5GjUs0j5MDyAfpPeWd/4NAh+ipOb
         zxYjrvNT4cV2QCOAgTE6NVn4G5zAqgnWXBFSIw8df0nLj+/x/H2tJLYjjIxRWoeMPW
         UdlU+24OVfAJwt4dU+yuGWdJqsc2wDAMEh7+oUrsgkRUPv2L7N1Z2Wye+wwaw/k2xs
         CijGSpJYzIq6Q==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Deepak Kumar Singh <quic_deesin@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [GIT PULL] rpmsg updates for v6.3
Date:   Sun, 26 Feb 2023 09:15:05 -0800
Message-Id: <20230226171505.298995-1-andersson@kernel.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:

  Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/rpmsg-v6.3

for you to fetch changes up to fb80ef67e8ff6a00d3faad4cb348dafdb8eccfd8:

  rpmsg: glink: Release driver_override (2023-02-15 07:46:02 -0800)

----------------------------------------------------------------
rpmsg updates for v6.3

rpmsg ctrl and char driver locking is ensure ordering in cases where the
communication link is being torn down in parallel with calls to open(2)
or poll(2).

The glink driver is refactored, to move rpm/smem-specifics out of the
common logic and better suite further improvements, such as transports
without a mailbox controller. The handling of remoteproc shutdown is
improved, to fail clients immediately instead of having them to wait for
timeouts. A driver_override memory leak is corrected and a few spelling
improvements are introduced.

glink_ssr is transitioned off strlcpy() and "gpr" is added as a valid
child node of the glink-edge DT binding.

----------------------------------------------------------------
Bjorn Andersson (11):
      rpmsg: glink: Include types in qcom_glink_native.h
      rpmsg: glink: Extract tx kick operation
      rpmsg: glink: smem: Wrap driver context
      rpmsg: glink: rpm: Wrap driver context
      rpmsg: glink: Move irq and mbox handling to transports
      rpmsg: glink: Fail qcom_glink_tx() once remove has been initiated
      rpmsg: glink: Cancel pending intent requests at removal
      rpmsg: glink: Fix spelling of peek
      rpmsg: glink: Fix GLINK command prefix
      rpmsg: glink: Avoid infinite loop on intent for missing channel
      rpmsg: glink: Release driver_override

Deepak Kumar Singh (2):
      rpmsg: char: Add lock to avoid race when rpmsg device is released
      rpmsg: ctrl: Add lock to rpmsg_ctrldev_remove

Krzysztof Kozlowski (1):
      dt-bindings: remoteproc: qcom,glink-edge: add GPR node

Wolfram Sang (1):
      rpmsg: move from strlcpy with unused retval to strscpy

 .../bindings/remoteproc/qcom,glink-edge.yaml       |  24 ++-
 drivers/remoteproc/qcom_common.h                   |   3 +-
 drivers/rpmsg/qcom_glink_native.c                  | 208 ++++++++++-----------
 drivers/rpmsg/qcom_glink_native.h                  |   8 +-
 drivers/rpmsg/qcom_glink_rpm.c                     |  96 ++++++++--
 drivers/rpmsg/qcom_glink_smem.c                    | 102 ++++++++--
 drivers/rpmsg/qcom_glink_ssr.c                     |   2 +-
 drivers/rpmsg/rpmsg_char.c                         |   8 +
 drivers/rpmsg/rpmsg_ctrl.c                         |   2 +
 include/linux/rpmsg/qcom_glink.h                   |  12 +-
 10 files changed, 312 insertions(+), 153 deletions(-)
