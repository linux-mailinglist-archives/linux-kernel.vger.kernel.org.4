Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D15226F91FA
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 14:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbjEFM1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 08:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbjEFM1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 08:27:18 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507FF14931;
        Sat,  6 May 2023 05:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1683376035;
        bh=+o4w1AuLrS4N5VM7PWJFd9iOpxhxZVgPAIefbw9mpF0=;
        h=Message-ID:Subject:From:To:Date:From;
        b=ZOfDO9RMY7cFrrvkmjnSdE4IACcJZO3edrsqcrDNNd9+RmoPk4tiUJK0X9H1RHOio
         T/8XCvknRzvmeZFegGUNGr/dbA9TXSB1UKh2l3yKkGnBLskiduVWT7IASTcmlM9xs5
         u5S/P/9yXxBt3Yi2PowVXFBFfFPm5xIqzXmcLhoI=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 47FBE1286A8E;
        Sat,  6 May 2023 08:27:15 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id tD3z3AIqJ9J5; Sat,  6 May 2023 08:27:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1683376035;
        bh=+o4w1AuLrS4N5VM7PWJFd9iOpxhxZVgPAIefbw9mpF0=;
        h=Message-ID:Subject:From:To:Date:From;
        b=ZOfDO9RMY7cFrrvkmjnSdE4IACcJZO3edrsqcrDNNd9+RmoPk4tiUJK0X9H1RHOio
         T/8XCvknRzvmeZFegGUNGr/dbA9TXSB1UKh2l3yKkGnBLskiduVWT7IASTcmlM9xs5
         u5S/P/9yXxBt3Yi2PowVXFBFfFPm5xIqzXmcLhoI=
Received: from [10.249.64.78] (c-65-50-164-218.hs.gigamonster.net [65.50.164.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 8A05B1280FD4;
        Sat,  6 May 2023 08:27:14 -0400 (EDT)
Message-ID: <8cee6d6bfe70066bcfdb5497ec2a468e8b2e5682.camel@HansenPartnership.com>
Subject: [GIT PULL] final round of SCSI updates for the 6.3+ merge window
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Sat, 06 May 2023 08:27:13 -0400
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Six late arriving patches for the merge window.  Five are minor
assorted fixes and updates.  The IPR driver change removes SATA
support, which will now allow a major cleanup in the ATA subsystem
because it was the only driver still using the old attachment
mechanism.  The driver is only used on power systems and SATA was used
to support a DVD device, which has long been moved to a different hba.
IBM chose this route instead of porting ipr to the newer SATA
interfaces.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc

The short changelog is:

Akshat Jain (1):
      scsi: pm80xx: Log device registration

Alice Chao (1):
      scsi: ufs: core: mcq: Fix &hwq->cq_lock deadlock issue

Brian King (1):
      scsi: ipr: Remove SATA support

John Garry (1):
      scsi: scsi_debug: Abort commands from scsi_debug_device_reset()

Tom Rix (1):
      scsi: ipr: Remove several unused variables

Zheng Wang (1):
      scsi: qedi: Fix use after free bug in qedi_remove()

and the diffstat:

 drivers/scsi/Kconfig             |   3 +-
 drivers/scsi/ipr.c               | 788 +--------------------------------------
 drivers/scsi/ipr.h               |  64 ----
 drivers/scsi/pm8001/pm8001_hwi.c |   7 +-
 drivers/scsi/qedi/qedi_main.c    |   3 +
 drivers/scsi/scsi_debug.c        |  22 ++
 drivers/ufs/core/ufs-mcq.c       |   6 +-
 7 files changed, 43 insertions(+), 850 deletions(-)

Regards,

James


