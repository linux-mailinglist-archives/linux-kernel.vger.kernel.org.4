Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF322612684
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 01:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiJ2Xtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 19:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiJ2Xtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 19:49:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E601928A
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 16:49:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D18D60C87
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 23:49:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E04DC433C1;
        Sat, 29 Oct 2022 23:49:36 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Ni9mVazE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1667087374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=UeNvwFArWNXtT6op0V+HUH5Vogj5Qt1t30euI5Z/RfM=;
        b=Ni9mVazEyYqL/aHTcmSN2EOL4cGEmqyJWufVmXseDm6dmOfTymCfRd/an3PXBlBrw1LMoc
        YTeP1lqysbG0Aq2y2p0Ek5kHdl1pMfpDtdVC0k0E1wCfcTdzxdqOvMLFqP7CseY3TuGlRV
        KpRn32pseFhbs3g5DJ6qAqzcAehgrxA=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 410c553d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Sat, 29 Oct 2022 23:49:33 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] random number generator fixes for 6.1-rc3
Date:   Sun, 30 Oct 2022 01:49:29 +0200
Message-Id: <20221029234929.834356-1-Jason@zx2c4.com>
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

This pull contains one fix from Jean-Philippe Brucker, addressing a regression
in which early boot code on ARM64 would use the non-_early variant of the
arch_get_random family of functions, resulting in the architectural random
number generator appearing unavailable during that early phase of boot. The
fix simply changes arch_get_random*() to arch_get_random*_early().

This distinction between these two functions is a bit of an old wart I'm not a
fan of, and for 6.2 I'll see if I can make obsolete the _early variant, so
that one function does the right thing in all contexts without overhead.

Regards,
Jason

The following changes since commit 23758867219c8d84c8363316e6dd2f9fd7ae3049:

  Merge tag 'net-6.1-rc3-2' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2022-10-27 13:36:59 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git tags/random-6.1-rc3-for-linus

for you to fetch changes up to f5e4ec155d145002fd9840868453d785fab86d42:

  random: use arch_get_random*_early() in random_init() (2022-10-29 00:24:03 +0200)

----------------------------------------------------------------
Random number generator fixes for Linux 6.1-rc3.
----------------------------------------------------------------
Jean-Philippe Brucker (1):
      random: use arch_get_random*_early() in random_init()

 drivers/char/random.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
