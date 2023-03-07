Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32FF6AF69E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 21:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbjCGUXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 15:23:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbjCGUX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 15:23:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3178A6BC9
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 12:23:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81CC961535
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 20:23:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D7BCC433EF;
        Tue,  7 Mar 2023 20:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678220603;
        bh=aBBo7ND5PU6BMsXweP6p08wP+hF3qkanOx37NJDOja4=;
        h=From:To:Cc:Subject:Date:From;
        b=KSeZYvRchNHv7BSW0Mm9hcYhmc3FzuHKbfx+D28jey9I8MRgkVzvfOJgkGJwlYmqt
         wzg6SgCHSlNKLPS0yds2dqAGMrnPnZBdPlwBo2oHJ5E6D1L4fnYFLfMyixIZsxHjSN
         HVzpFE9mp6Npp3Rulv/le4qAvajfi+EFWB2zeKFNWaKLWriDocdUMJkn8dqrkppl0y
         DS8D+2L5Yl2x90mxikE2E5jxO5Zj894Ccorz9jJ7FFbLM23lO+31k6D9zK5hL3krbS
         03AfeqwKM8A+C5wlYyEZw7RZ308xdCozh6axITR89Um50Dn5mD9iAMjqrrdl6tWvxu
         EKZiiUAQuztlg==
From:   Conor Dooley <conor@kernel.org>
To:     linux-riscv@lists.infradead.org
Cc:     conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/8] Hey Jassi, all,
Date:   Tue,  7 Mar 2023 20:22:50 +0000
Message-Id: <20230307202257.1762151-1-conor@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3553; i=conor.dooley@microchip.com; h=from:subject; bh=objaY8Iic30N8AZK2EQh6NRbGiNWI0wnNHpQoF1qVRg=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDCnsc4U8MldyXExRan+ctiQjQmdj4fSe+UyL13kHPLxQc UxqZumvjlIWBjEOBlkxRZbE230tUuv/uOxw7nkLM4eVCWQIAxenAEzkFDMjw/YKaY3OPz8PfumQ WmTsmS23Z3fFvPzwpk9alVPVlhuc72b478DNm/L4xft8rYpOi8jlfNyp7rt3mpgoFadZdr6cV87 PDwA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

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
I've got some other bits that I'd like to change in the client driver,
so via the soc tree would suit me better.

Thanks,
Conor.

Changes in v3:
- check the service status in the .tx_done() callback rather than
  mpfs_mbox_rx_data()
- re-order the if/else bits in mpfs_blocking_transaction() to please my
  eyes a bit more
- expand on the comment in same

Changes in v2:
- up the timeout to 30 seconds, as required for services like image
  validation, which may vary significantly in execution time
- fixed a typo!

CC: Conor Dooley <conor.dooley@microchip.com>
CC: Daire McNamara <daire.mcnamara@microchip.com>
CC: Jassi Brar <jassisinghbrar@gmail.com>
CC: linux-riscv@lists.infradead.org
CC: linux-kernel@vger.kernel.org

Conor Dooley (8):
  mailbox: mpfs: fix an incorrect mask width
  mailbox: mpfs: switch to txdone_poll
  mailbox: mpfs: ditch a useless busy check
  mailbox: mpfs: check the service status in .tx_done()
  soc: microchip: mpfs: fix some horrible alignment
  soc: microchip: mpfs: use a consistent completion timeout
  soc: microchip: mpfs: simplify error handling in
    mpfs_blocking_transaction()
  soc: microchip: mpfs: handle timeouts and failed services differently

 drivers/mailbox/mailbox-mpfs.c              | 55 ++++++++++++---------
 drivers/soc/microchip/mpfs-sys-controller.c | 52 +++++++++++++------
 2 files changed, 67 insertions(+), 40 deletions(-)

-- 
2.39.2

