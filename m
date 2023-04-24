Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B746ED0BF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 16:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbjDXOzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 10:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbjDXOzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 10:55:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6425FC3;
        Mon, 24 Apr 2023 07:55:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6A71625A8;
        Mon, 24 Apr 2023 14:55:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B72A1C433EF;
        Mon, 24 Apr 2023 14:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682348118;
        bh=kq6nOcOuO7R9OpBL/tyrVnyvhQ5iiOfvSzD82e2+HIc=;
        h=From:To:Cc:Subject:Date:From;
        b=lMDANu5xIcX9XZaxb3bBBpbKpiuCy3RFwY7vJ2AzPrZGj+jUF2B5Kxju72EN9LNAZ
         g7iCLADW/SHG8EcNsKoKR7BjEPkx2iy1ANVJP7cLS6FrleY3uC3ZvzpvGFCLvWUB5S
         92Nt2x2GZ0Zvpa3VEcyjvoF4hV4KgweEMCO3kEI/ZozqPhPSc5zhG0/fRgtTdADkZT
         YyF+PS6twgNM5nrQXDOBozaURP60kN9WprI0w9T5hrzViyZo7SGRcdcL4/5En7MrHh
         m+l2cjSv/6b/9gThQtTFr6bRUG2HIxiccnDp6GY945P6miWhoQPwTamABLshAU65YK
         BRq/X+Fn9aQ/w==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [GIT PULL] rpmsg updates for v6.4
Date:   Mon, 24 Apr 2023 07:59:02 -0700
Message-Id: <20230424145902.277800-1-andersson@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/rpmsg-v6.4

for you to fetch changes up to ba7a4754da1092decbeea3b29bf7d5946f1be400:

  rpmsg: glink: Consolidate TX_DATA and TX_DATA_CONT (2023-04-19 12:43:19 -0700)

----------------------------------------------------------------
rpmsg updates for v6.4

The remove functions of the Qualcomm SMD and GLINK RPM platform drivers
are transitioned to the new void returning prototype. Likewise is
qcom_smd_unregister_edge() transitioned to void, as it unconditionally
returned 0.

An assumption about the ordering of the intent request acknowledgement
and advertisement of a new intent in the GLINK implementation is
corrected. Faulty error handling is corrected is improved in the TX
path, and duplicated code, in the same path, is cleaned up.

----------------------------------------------------------------
Bjorn Andersson (4):
      rpmsg: glink: Transition intent request signaling to wait queue
      rpmsg: glink: Wait for intent, not just request ack
      rpmsg: glink: Propagate TX failures in intentless mode as well
      rpmsg: glink: Consolidate TX_DATA and TX_DATA_CONT

Uwe Kleine-König (3):
      rpmsg: qcom_smd: Make qcom_smd_unregister_edge() return void
      rpmsg: qcom_glink_rpm: Convert to platform remove callback returning void
      rpmsg: qcom_smd: Convert to platform remove callback returning void

 drivers/rpmsg/qcom_glink_native.c | 87 +++++++++++++++++++--------------------
 drivers/rpmsg/qcom_glink_rpm.c    |  6 +--
 drivers/rpmsg/qcom_smd.c          | 24 +++++------
 include/linux/rpmsg/qcom_smd.h    |  5 +--
 4 files changed, 57 insertions(+), 65 deletions(-)
