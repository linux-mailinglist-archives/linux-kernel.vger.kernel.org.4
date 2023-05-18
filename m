Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30787708167
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 14:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbjERMfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 08:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbjERMfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 08:35:41 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC749AA;
        Thu, 18 May 2023 05:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684413341; x=1715949341;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aDN3dR93yq//GguZPkCXE8Ess1OefD19h7a6IUQpigk=;
  b=IuYxB+/BlOa9FTsqFrppoEf5kHyaBTNjuPm0+2BxJRqW3oMlisXGu76X
   SdtoCK9ZEpVPZPUHTWAus7IrMjJ3hS3do5rsv47c/npbqSzfcAT1UjMkA
   ZDRuB3vMUYnDxUkAeM65sUgrau/62H14hMPWFrOn1/9YwJRckWEAttUhs
   eQ5PJAWcsLJLG1Qy/2GtDsiPrsTouAzinp53wy3BnQklWhwinFGcXq1Lr
   D+PlbXUEMhruVKDvXgnscdlBbvuF429PWwJf1r/uxtJtJKye4VE5yZrZa
   XxRYv0b/JhqfeFkfIUJjaiMX2zMxf47M0/L+clnlirpy8L3tNo6zHiYSU
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,285,1677567600"; 
   d="scan'208";a="214432107"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 May 2023 05:35:40 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 18 May 2023 05:35:39 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Thu, 18 May 2023 05:35:37 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Daire McNamara <daire.mcnamara@microchip.com>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v18 0/2] Microchip Soft IP corePWM driver
Date:   Thu, 18 May 2023 13:29:19 +0100
Message-ID: <20230518-reactive-nursing-23b7fe093048@wendy>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5114; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=aDN3dR93yq//GguZPkCXE8Ess1OefD19h7a6IUQpigk=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDClpUvKbVv23fTP/8AcJ1bK51dzRAZfC53ms4S+YLLOVk9OW 6d7pjlIWBjEOBlkxRZbE230tUuv/uOxw7nkLM4eVCWQIAxenAEwk5TDD/4DsOS/+dmrcPSYQKt35Om /Ls6Rai3ibRw/vJt6+OOv5DC1GhtvpE5jkN7tr6H/bq/rfNJHvFa8kx72PDFwL94T3SG+O4gcA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Another version, although a lot smaller of a range-diff than previously!
All you get this time is the one change requested by Uwe on v17, along
with a rebase on -rc1.

Thanks,
Conor.

Changes since v17:
- Explicitly cast around integer promotion on 32-bit archs
- rebase on v6.4-rc1

Changes since v16:
- only write out the period immediately before the duty cycle to avoid
  potentially racing against the period counter resetting
- update some comments that had bitrotted
- use Uwe's simple method for calculating period/duty & reject any
  period for which tmp < 255

Changes since v15:
- calculate prescale modulus without using %

Changes since v14:
- change period_steps calculation logic to correctly handle the cases
  where tmp % (254 + 1) == 0, by swapping implicit truncation for
  explicit rounding upwards and subtracting zero
- special case periods < 1/clk_rate & add a note in limitations about
  this, although I think this issue wasn't present prior to v15's
  changes
- check for smaller suitable values of prescale, which picks the "more
  correct" value in about half of all cases, particularly those where
  tmp is large.
- explain what I mean by the "optimal" values for prescale/period steps
  re-fix use of defines
- add a comment about how sync_upd mode works
- make the use of period_steps and prescale consistently refer to the
  register values rather than, in comments, using these to mean the
  resulting values after 1 has been added
- drop the PREG_TO_VAL() macro, as most of its users are now gone & it
  only added to the register value versus "real" value problem
- report pwmchip_add() failures

Changes since v13:
- couple bits of cleanup to apply_locked(), suggested by Uwe
- move the overhead waiting for a change to be applied, for channels
  with shadow registers, to subsequent calls to apply(). This has the
  benefit of only waiting when two calls to apply() are close in time
  rather than eating the delay in every call.

Changes since v11:
- swap a "bare" multiply & divide for the corresponding helper to
  prevent overflow
- factor out duplicate clk rate acquisition & period calculation
- make the period calculation return void by checking the validity of
  the clock rate in the caller
- drop the binding & dt patch, they're on-track for v6.2 via my tree

Changes since v10:
- reword some comments
- try to assign the period if a disable is requested
- drop a cast around a u8 -> u16 conversion
- fix a check on period_steps that should be on the hw_ variant
- split up the period calculation in get_state() to fix the result on
  32 bit
- add a rate variable in get_state() to only call get_rate() once
- redo the locking as suggested to make it more straightforward.
- stop checking for enablement in get_state() that was working around
 intended behaviour of the sysfs interface

Changes since v9:
- fixed the missing unlock that Dan reported

Changes since v8:
- fixed a(nother) raw 64 bit division (& built it for riscv32!)
- added a check to make sure we don't try to sleep for 0 us

Changes since v7:
- rebased on 6.0-rc1
- reworded comments you highlighted in v7
- fixed the overkill sleeping
- removed the unused variables in calc_duty
- added some extra comments to explain behaviours you questioned in v7
- make the mutexes un-interruptible
- fixed added the 1s you suggested for the if(period_locked) logic
- added setup of the channel_enabled shadowing
- fixed the period reporting for the negedge == posedge case in
  get_state() I had to add the enabled check, as otherwise it broke
  setting the period for the first time out of reset.
- added a test for invalid PERIOD_STEPS values, in which case we abort
  if we cannot fix the period

Changes from v6:
- Dropped an unused variable that I'd missed
- Actually check the return values of the mutex lock()s
- Re-rebased on -next for the MAINTAINERS patch (again...)

Changes from v5:
- switched to a mutex b/c we must sleep with the lock taken
- simplified the locking in apply() and added locking to get_state()
- reworked apply() as requested
- removed the loop in the period calculation (thanks Uwe!)
- add a copy of the enable registers in the driver to save on reads.
- remove the second (useless) write to sync_update
- added some missing rounding in get_state()
- couple other minor cleanups as requested in:
https://lore.kernel.org/linux-riscv/20220709160206.cw5luo7kxdshoiua@pengutronix.de/

Changes from v4:
- dropped some accidentally added files

Changes before v4:
https://lore.kernel.org/linux-pwm/20220721172109.941900-1-mail@conchuod.ie

Conor Dooley (2):
  pwm: add microchip soft ip corePWM driver
  MAINTAINERS: add pwm to PolarFire SoC entry

 MAINTAINERS                      |   1 +
 drivers/pwm/Kconfig              |  10 +
 drivers/pwm/Makefile             |   1 +
 drivers/pwm/pwm-microchip-core.c | 507 +++++++++++++++++++++++++++++++
 4 files changed, 519 insertions(+)
 create mode 100644 drivers/pwm/pwm-microchip-core.c

-- 
2.39.2

