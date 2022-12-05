Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF77642AEA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 16:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbiLEPBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 10:01:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbiLEPBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 10:01:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2311D0FE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 07:01:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EFFBD6119A
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 15:01:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7B8CC433D6;
        Mon,  5 Dec 2022 15:01:43 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="plQ+h37j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1670252501;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=OQxIC/pA5v8LWcdCf8PNcaqz9WcJuyhTrmZzMdlvxGY=;
        b=plQ+h37jya5m6enDsITZtXKY06/pejo8MOvxzQcSkMkxXsnaKABhfNe7octXQkXsaa3WlI
        TArg1Yjm55TE77TJMEuaOTk1F8I+aAFo93zefqj8L5m/X320nvC0f+mYjdcQfez8Ksxhmf
        D8cQlgtDpOsWfh/SstZP3GI9Gs7Y1k0=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id f18c2b2a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 5 Dec 2022 15:01:40 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] -funsigned-char conversion for 6.2-rc1
Date:   Mon,  5 Dec 2022 16:01:16 +0100
Message-Id: <20221205150116.1064295-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the following tree, which contains the change to use
-funsigned-char, in addition to fixes to code that made different assumptions
about the signedness of chars.

During the 6.1 cycle, several patches already made it to your tree, which were
for code that was already broken on at least one architecture, where the naked
char had a different sign than the code author anticipated, or were part of
some bug fix for an existing bug that this initiative unearthed. These 6.1-era
fixes are:

- 648060902aa3 MIPS: pic32: treat port as signed integer
- 5c26159c97b3 ipvs: use explicitly signed chars
- e6cb8769452e wifi: airo: do not assign -1 to unsigned char
- 937ec9f7d5f2 staging: rtl8192e: remove bogus ssid character sign test
- 677047383296 misc: sgi-gru: use explicitly signed char
- 50895a55bcfd ALSA: rme9652: use explicitly signed char
- ee03c0f200eb ALSA: au88x0: use explicitly signed char
- 835bed1b8395 fbdev: sisfb: use explicitly signed char
- 50f19697dd76 parisc: Use signed char for hardware path in pdc.h
- 66063033f77e wifi: rt2x00: use explicitly signed or unsigned types

Regarding patches in this pull:

- There is one patch in this pull that should have made it to you during 6.1
  ("media: stv0288: use explicitly signed char"), but the maintainer was MIA
  during the cycle, so it's in here instead.

- Two patches fix single architecture code affected by -funsigned-char
  ("perf/x86: Make struct p4_event_bind::cntr signed array" and "sparc: sbus:
  treat CPU index as integer"), while one patch fixes an unused typedef, in
  case it's ever used in the future ("media: atomisp: make hive_int8 explictly
  signed").

- Finally, there's the change to actually enable -funsigned-char ("kbuild:
  treat char as always unsigned") and then the removal of some no longer
  useful !__CHAR_UNSIGNED__ selftest code ("lib: assume char is unsigned").

The various fixes were found with a combination of diffing objdump output, a
large variety of Coccinelle scripts, and plain old grep. In the end, things
didn't seem as bad as I feared they would. But of course, it's also possible I
missed things. However, this has been in linux-next for basically an entire
cycle now, so I'm not overly worried. I've also been daily driving this on my
laptop for all of 6.1. Still, this series, and the ones sent for 6.1 don't
total in quantity to what I thought it'd be, so I will be on the lookout for
breakage.

We could receive a few reports that are quickly fixable. Hopefully we won't
receive a barrage of reports that would result in a revert. And just maybe we
won't receive any reports at all and nobody will even notice. Knock on wood.

Please pull!

Thanks,
Jason


The following changes since commit 23a60a03d9a9980d1e91190491ceea0dc58fae62:

  Merge tag 'arm64-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux (2022-11-18 14:31:03 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/zx2c4/linux.git tags/unsigned-char-6.2-for-linus

for you to fetch changes up to 0445d1bae1cce00ae4e99c8cde33784a8199bad6:

  lib: assume char is unsigned (2022-11-19 00:56:15 +0100)

----------------------------------------------------------------
Enable -funsigned-char and fix code affected by that flag.
----------------------------------------------------------------

Alexey Dobriyan (1):
      perf/x86: Make struct p4_event_bind::cntr signed array

Jason A. Donenfeld (5):
      sparc: sbus: treat CPU index as integer
      media: stv0288: use explicitly signed char
      media: atomisp: make hive_int8 explictly signed
      kbuild: treat char as always unsigned
      lib: assume char is unsigned

 Makefile                                       |  2 +-
 arch/x86/events/intel/p4.c                     |  2 +-
 drivers/media/dvb-frontends/stv0288.c          |  5 ++---
 drivers/sbus/char/envctrl.c                    |  4 ++--
 drivers/staging/media/atomisp/pci/hive_types.h |  2 +-
 lib/is_signed_type_kunit.c                     |  4 ----
 lib/test_printf.c                              | 12 ------------
 7 files changed, 7 insertions(+), 24 deletions(-)
