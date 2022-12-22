Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59AF65460E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 19:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235181AbiLVSip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 13:38:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiLVSin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 13:38:43 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C45C21D332
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 10:38:42 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9FE9D1570;
        Thu, 22 Dec 2022 10:39:23 -0800 (PST)
Received: from e120937-lin.. (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D793F3FAFB;
        Thu, 22 Dec 2022 10:38:41 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, cristian.marussi@arm.com
Subject: [PATCH 0/5] Miscellaneous SCMI fixes for v6.2
Date:   Thu, 22 Dec 2022 18:38:18 +0000
Message-Id: <20221222183823.518856-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

a small series with a round of SCMI fixes, mostly trivial.

Notably, though:

- patch 4/5 adds a missing binding definition for SCMI SystemPower
  protocol (merged a while ago and probably lost in translation txt->yaml) 

- patch 5/5 addresses a possible deadlock, spotted by LOCKDEP, at SCMI
  stack unload time, when using a virtio transport backend.

Applies on v6.1

Thanks,
Cristian

Cristian Marussi (5):
  firmware: arm_scmi: Clear stale xfer->hdr.status
  firmware: arm_scmi: Harden shared memory access in fetch_response
  firmware: arm_scmi: Harden shared memory access in fetch_notification
  dt-bindings: firmware: arm,scmi: Add support for syspower protocol
  firmware: arm_scmi: Fix virtio channels cleanup on shutdown

 .../devicetree/bindings/firmware/arm,scmi.yaml         | 10 ++++++++++
 drivers/firmware/arm_scmi/driver.c                     |  2 ++
 drivers/firmware/arm_scmi/shmem.c                      |  9 ++++++---
 drivers/firmware/arm_scmi/virtio.c                     |  7 ++++++-
 4 files changed, 24 insertions(+), 4 deletions(-)

-- 
2.34.1

