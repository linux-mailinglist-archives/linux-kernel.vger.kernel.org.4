Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E057F6DDD5C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 16:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjDKOMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 10:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjDKOMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 10:12:01 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4244C15
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 07:11:56 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 6E0384000B;
        Tue, 11 Apr 2023 14:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1681222315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=XZe8xYC1xbEnhgYDBod/OpyA9Fw0CldqYg1lJS8s6AY=;
        b=Fl054psGHyMkXjkn4/ugFrMsQoBuW+Nt5sXCoxPtDZV8Xj/sohwf2DxZYvWbRT1gP3Roax
        /4xhfYf+sBgX3MjYuwr290tzJwlbxrxdoBk7Ej84KoUyoS3uvjhQRoPe7r+HXzOj+pInhH
        q/7SLwRIBWGVQFhSYWeUdH6pSQuSfTQvCaqAtyUr5HlUK6dUqXNuXoQFFBUDcSi0WxJgN/
        DqOQXcnIE6hJ12DYrbMaP2IMrsKKhJ8qKRGCNchQOwQ9+1SzktgEaS8SMEsfPu75cU2PVR
        m9ONUKaThe3XYjdPvJZqndcikTxb+TGyX1uwKfI4g+4yb8HRG9Rb+tRIF3X6ew==
Date:   Tue, 11 Apr 2023 16:11:53 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@linaro.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <pratyush@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] mtd: Fixes for 6.3-rc7
Message-ID: <20230411161153.60998465@xps-13>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

This is a second fixes MTD PR for the next release/release-candidate.

Thanks,
Miqu=C3=A8l

The following changes since commit 7e364e56293bb98cae1b55fd835f5991c4e96e7d:

  Linux 6.3-rc5 (2023-04-02 14:29:29 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/fixe=
s-for-6.3-rc7

for you to fetch changes up to 93942b70461574ca7fc3d91494ca89b16a4c64c7:

  mtd: rawnand: meson: fix bitmask for length in command word (2023-04-03 1=
7:58:01 +0200)

----------------------------------------------------------------
Core MTD fix:
* mtdblock: Tolerate corrected bit-flips

Raw NAND fixes:
* meson: Fix bitmask for length in command word
* stm32_fmc2:
  - Remove unsupported EDO mode
  - Use timings.mode instead of checking tRC_min
  The first patch is the real fix but nowadays we use timings.mode
  instead of bare timings, so in order to ease the backports, the fix
  was split into two steps, the first one easy to backport on older
  kernels, the second one just as a follow-up so recent stable kernels
  would look like the mainline.

----------------------------------------------------------------
Arseniy Krasnov (1):
      mtd: rawnand: meson: fix bitmask for length in command word

Bang Li (1):
      mtdblock: tolerate corrected bit-flips

Christophe Kerello (2):
      mtd: rawnand: stm32_fmc2: remove unsupported EDO mode
      mtd: rawnand: stm32_fmc2: use timings.mode instead of checking tRC_min

 drivers/mtd/mtdblock.c                 | 12 ++++++++----
 drivers/mtd/nand/raw/meson_nand.c      |  6 +++---
 drivers/mtd/nand/raw/stm32_fmc2_nand.c |  3 +++
 3 files changed, 14 insertions(+), 7 deletions(-)
