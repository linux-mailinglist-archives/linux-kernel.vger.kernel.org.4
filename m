Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3504653044
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 12:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234448AbiLUL3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 06:29:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiLUL3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 06:29:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F377C10AF;
        Wed, 21 Dec 2022 03:29:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A7EB5B81B60;
        Wed, 21 Dec 2022 11:29:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B94F1C433D2;
        Wed, 21 Dec 2022 11:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671622174;
        bh=443F1rXQ30ch6Cy/GlKbcogz3u7FhMGEWGxIcKOK4t4=;
        h=From:To:Cc:Subject:Date:From;
        b=RMQAbseOtZa8WnF7g64duHVqiPvpaz4vk/HCxQcnoF99qtJFZqXyXpMtBDogLXsEU
         A5vrCM2HHH1xjU8p5tLDtA5Yx9Yuuf93425ODKcveJ7OcnVykYZKSJ4bgvbj/5mUGj
         f3DUUSl4byj9snhlTAQON39F6d4/3Y4ONkYzvl2PuPz9YJHa0xBIlCoXJpc1MKMHhd
         6fZIsO41hp/swRnbefRDICf9m390vn0a5QZcC5IBg/7ahN3/jSjCYL17W+uFMhdunD
         NVW4+T7mzsbk1DTLXMeRHCYYDiX72OszCzzzYgXAqwiJTIVuOs3UlRWPzbsj1GX2W6
         FfYlksOyDMgqA==
From:   Conor Dooley <conor@kernel.org>
To:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     Daire McNamara <daire.mcnamara@microchip.com>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v13 0/2] Microchip Soft IP corePWM driver
Date:   Wed, 21 Dec 2022 11:29:11 +0000
Message-Id: <20221221112912.147210-1-conor@kernel.org>
X-Mailer: git-send-email 2.38.1
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

From: Conor Dooley <conor.dooley@microchip.com>

Hey,

v13 is rebased on top of Uwe's series converting get_state() to return
int instead of void. Given other changes here, it turns out that I do
not need it at all unfortunately!

I was wrong about the behaviour of the sync-update bit:
It /does not/ get cleared at the start of a new period. I did actually
modify the driver to do a read_poll_timeout() on that bit which seemed
to work [0], but it turns out that that bit holds it's value until the
IP block is reset. I'm really not sure how it worked when I tested the
other week...

I initially implemented a wait with timers and a timeout - but Uwe
suggested dropping the timeouts entirely & instead going back to
waiting. The driver now waits in apply() & get_state() for a update to
have been applied to the waveform before allowing further modification.
Doing so is required as the applied state doesn't appear in the
registers until it has appeared at the output.
I yoinked the msleep/udelay stuff from the sun4i that you mentioned &
modified it a little as the cost of waiting has been placed on
subsequent calls.

Other than that, v13 has some minor bits of cleanup that Uwe suggested
in mchp_core_pwm_apply_locked().

Thanks,
Conor.

0 - https://lore.kernel.org/linux-riscv/Y3uZY5mt%2FZIWk3sS@wendy/

Changes since v13:
- couple bits of cleanup to apply_locked(), suggested by Uwe: getting
  rid of a variable & using unsigned long for another.
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
 drivers/pwm/pwm-microchip-core.c | 436 +++++++++++++++++++++++++++++++
 4 files changed, 448 insertions(+)
 create mode 100644 drivers/pwm/pwm-microchip-core.c

-- 
2.38.1

