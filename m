Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 447926CFC6D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 09:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjC3HNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 03:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbjC3HNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 03:13:32 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0959326A4;
        Thu, 30 Mar 2023 00:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1680160386; x=1711696386;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Yhc7Flvtw7DygHF2DgeNSHPYJ8ZzS+g4efc4mrx+3WI=;
  b=w5bqRV/I1ETRn1oJyo7iBcjYV0f60FTFuVKYtlSJTwcNWISnhTfkFaXQ
   R6uKFq/rHbVNkt5IKxHAqoxsD9YjtirLhoJHKzKJfHZn+SePFxSjpz/j+
   aV6WVqBCbFvnJMPCI0GFw5m0MKe1TgTDijhJL//RKuJJjQfomiUV0Q0lw
   5KFd0UcILSa7jSM5U1Aw4XUMDkuK8t3a3YFiIymHmePk60uXoUVcFY78M
   LTZMxH0uZ1Jc086VxrNIKyYP+rH8LtK5hlxmYfmjSnujQ199J5oG4n8wz
   q9YOpcFvKv0zfDto33j7cr86FrfvM1FfNBQ9HPEXS8ydWD7BSvUdGCe7V
   w==;
X-IronPort-AV: E=Sophos;i="5.98,303,1673938800"; 
   d="scan'208";a="144635864"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Mar 2023 00:12:37 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 30 Mar 2023 00:12:35 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Thu, 30 Mar 2023 00:12:34 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Daire McNamara <daire.mcnamara@microchip.com>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v15 0/2] Microchip Soft IP corePWM driver
Date:   Thu, 30 Mar 2023 08:12:02 +0100
Message-ID: <20230330071203.286972-1-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5109; i=conor.dooley@microchip.com; h=from:subject; bh=Yhc7Flvtw7DygHF2DgeNSHPYJ8ZzS+g4efc4mrx+3WI=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDCmqZs7M+sffl+YqNccp2R9ZWMzUv3TuQmXmXzJzchwy3EO5 rrJ1lLIwiHEwyIopsiTe7muRWv/HZYdzz1uYOaxMIEMYuDgFYCI9Zxn+Cofu3t5W8nyKp8Lytj9XAg 8qNYatvmn7PH3F8WXzXoUXVTAyXKo8NTnDNym99USnUvubO73bHQ3P3Qh1/nA9ov2E5KF6PgA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Uwe, all,

Uwe & I had a long back and forth about period calculations on v13,
my ultimate conclusion being that, after some testing of the "corrected"
calculation in hardware, the original calculation was correct.
I think we had gotten sucked into discussion the calculation of the
period itself, when we were in fact trying to calculate a bound on the
period instead. That discussion is here:
https://lore.kernel.org/linux-pwm/Y+ow8tfAHo1yv1XL@wendy/

There was, of course, another chat about the niche bits of this
calculation on v14 too:
https://lore.kernel.org/linux-pwm/20230322105536.kgt3ffowefqlg6eu@pengutronix.de/

Thanks,
Conor.

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

