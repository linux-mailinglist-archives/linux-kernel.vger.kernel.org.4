Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2F965461F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 19:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbiLVSvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 13:51:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiLVSvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 13:51:07 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BCF3122B0A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 10:51:05 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6EE691FB;
        Thu, 22 Dec 2022 10:51:46 -0800 (PST)
Received: from e120937-lin.. (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 130843FA32;
        Thu, 22 Dec 2022 10:51:03 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, Ludvig.Parsson@axis.com,
        cristian.marussi@arm.com
Subject: [PATCH 0/9] Rework SCMI initialization and probing sequence
Date:   Thu, 22 Dec 2022 18:50:40 +0000
Message-Id: <20221222185049.737625-1-cristian.marussi@arm.com>
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

under some configurations the SCMI core stack, which is now initialized
as a whole at the subsys_initcall level, can be dependent on some other
Kernel subsystems (like TEE) when some SCMI transport backend like optee
is used.

This has been reported to lead to some awkward probe loop which, even
though successful at the end, leaves a track of errors in the logs coming
directly from the core Linux driver model facilities.

In order to solve this issue and cleaning up a bit the SCMI stack startup
sequence, this small series reviews and reworks the SCMI core stack
initialization and probe logic.

Basically the SCMI Bus is split into its own module (scmi-core.ko) which is
initialized at subsys_initcall, while the SCMI core stack, including its
various transport backends (like optee, mailbox, virtio, smc), is kept into
a distinct module (scmi-module.ko) which get initialized at module_init.

The SCMI driver users initlevel, instead, remains unchanged at module_init.

No change is made to the Kconfig: the main ARM_SCMI_PROTOCOL option will
now cause both modules to be built.

This allows the other possibly needed subsystems to be up and running
well before the core SCMI stack and its dependent transport backends, so
solving the reported issue.

Tested with SCMI transports mailbox/virtio and, in a previous draft, optee,
in a number of different load/unload/bind/unbind combinations both as
builtin and as LKMs.

Applies on v6.1.

Any feedback, testing welcome.

Thanks,
Cristian

Cristian Marussi (9):
  firmware: arm_scmi: Simplify chan_available transport operation
  firmware: arm_scmi: Use dedicated devices to initialize channels
  firmware: arm_scmi: Move protocol registration helpers
  firmware: arm_scmi: Add common notifier helpers
  firmware: arm_scmi: Refactor protocol device creation
  firmware: arm_scmi: Move handle get/set helpers
  firmware: arm_scmi: Refactor device create/destroy helpers
  firmware: arm_scmi: Introduce a new lifecycle for protocol devices
  firmware: arm_scmi: Split bus and driver into distinct modules

 drivers/firmware/arm_scmi/Makefile  |   8 +-
 drivers/firmware/arm_scmi/bus.c     | 388 ++++++++++++-----
 drivers/firmware/arm_scmi/common.h  |  25 +-
 drivers/firmware/arm_scmi/driver.c  | 623 ++++++++++++++--------------
 drivers/firmware/arm_scmi/mailbox.c |   6 +-
 drivers/firmware/arm_scmi/optee.c   |   6 +-
 drivers/firmware/arm_scmi/smc.c     |   6 +-
 drivers/firmware/arm_scmi/virtio.c  |   4 +-
 include/linux/scmi_protocol.h       |   5 -
 9 files changed, 622 insertions(+), 449 deletions(-)

-- 
2.34.1

