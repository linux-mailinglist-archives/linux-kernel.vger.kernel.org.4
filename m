Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B97F675780
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 15:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjATOkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 09:40:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjATOkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 09:40:04 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3128CFD2D
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 06:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1674225567; x=1705761567;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tzlAUmOT7JvkxNZu7rMwCeceSX0aTfOKIK/6l3oMHyI=;
  b=Ejd5rBFT9fC+eCDm0u83Ahg0crsZ8SDs7ZTPVdlQpuIm35pthzWBvVkm
   iLhrhQRKPfGWcf5riRHH8G4W57diA46XKQNx87IfVaT+DYTM4LdaLFaju
   7YPTseC4H8dMOuyS95oV05Q2tf1PlpwKFsXbtOSITzSSWW3t0SiQYayv8
   I4uHrqA6cYnXvTr22Eblht0J2TkEPTMJHhzwLVMjBm6VhyiqG75EQQBwV
   4LQbKPnwmyOLS6UQeoYC6k2d9i4F6TEdMMwfqLGbue8exrh9gYGXA46lG
   GMIXiBFZpmAxLrxTVgCbt8OhgPGDEJvk/IptqQIv5/zGEvZwGVA46VuVk
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,232,1669100400"; 
   d="scan'208";a="196713293"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jan 2023 07:38:10 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 20 Jan 2023 07:38:10 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.16 via Frontend
 Transport; Fri, 20 Jan 2023 07:38:09 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
CC:     Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/7] MPFS system controller/mailbox fixes
Date:   Fri, 20 Jan 2023 14:37:28 +0000
Message-ID: <20230120143734.3438755-1-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Jassi, all,

Here are some fixes for the system controller on PolarFire SoC that I
ran into while implementing support for using the system controller to
re-program the FPGA. A few are just minor bits that I fixed in passing,
but the bulk of the patchset is changes to how the mailbox figures out
if a "service" has completed.

Prior to implementing this particular functionality, the services
requested from the system controller, via its mailbox interface, always
triggered an interrupt when the system controller was finished with
the service.

Unfortunately some of the services used to validate the FPGA images
before programming them do not trigger an interrupt if they fail.
For example, the service that checks whether an FPGA image is actually
a newer version than what is already programmed, does not trigger an
interrupt, unless the image is actually newer than the one currently
programmed. If it has an earlier version, no interrupt is triggered
and a status is set in the system controller's status register to
signify the reason for the failure.

In order to differentiate between the service succeeding & the system
controller being inoperative or otherwise unable to function, I had to
switch the controller to poll a busy bit in the system controller's
registers to see if it has completed a service.
This makes sense anyway, as the interrupt corresponds to "data ready"
rather than "tx done", so I have changed the mailbox controller driver
to do that & left the interrupt solely for signalling data ready.
It just so happened that all of the services that I had worked with and
tested up to this point were "infallible" & did not set a status, so the
particular code paths were never tested.

Jassi, the mailbox and soc patches depend on each other, as the change
in what the interrupt is used for requires changing the client driver's
behaviour too, as mbox_send_message() will now return when the system
controller is no longer busy rather than when the data is ready.
I'm happy to send the lot via the soc tree with your Ack and/or reivew,
if that also works you?

Secondly, I have a question about what to do if a service does fail, but
not due to a timeout - eg the above example where the "new" image for
the FPGA is actually older than the one that currently exists.
Ideally, if a service fails due to something other than the transaction
timing out, I would go and read the status registers to see what the
cause of failure was.
I could not find a function in the mailbox framework that allows the
client to request that sort of information from the client. Trying to
do something with the auxiliary bus, or exporting some function to a
device specific header seemed like a circumvention of the mailbox
framework.
Do you think it would be a good idea to implement something like
mbox_client_peek_status(struct mbox_chan *chan, void *data) to allow
clients to request this type of information?

It'd certainly allow me to report the actual errors to the drivers
implementing the service & make better decisions there about how to
proceed.
Perhaps I have missed some way of doing this kind of thing that (should
have been) staring me in the face!

Thanks,
Conor.

Changes in v2:
- up the timeout to 30 seconds, as required for services like image
  validation, which may vary significantly in execution time
- fixed a typo!

CC: Conor Dooley <conor.dooley@microchip.com>
CC: Daire McNamara <daire.mcnamara@microchip.com>
CC: Jassi Brar <jassisinghbrar@gmail.com>
CC: linux-riscv@lists.infradead.org
CC: linux-kernel@vger.kernel.org

Conor Dooley (7):
  mailbox: mpfs: fix an incorrect mask width
  mailbox: mpfs: switch to txdone_poll
  mailbox: mpfs: ditch a useless busy check
  soc: microchip: mpfs: fix some horrible alignment
  soc: microchip: mpfs: use a consistent completion timeout
  soc: microchip: mpfs: simplify error handling in
    mpfs_blocking_transaction()
  soc: microchip: mpfs: handle timeouts and failed services differently

 drivers/mailbox/mailbox-mpfs.c              | 25 ++++++----
 drivers/soc/microchip/mpfs-sys-controller.c | 52 ++++++++++++++-------
 2 files changed, 51 insertions(+), 26 deletions(-)


base-commit: 88603b6dc419445847923fcb7fe5080067a30f98
-- 
2.39.0

