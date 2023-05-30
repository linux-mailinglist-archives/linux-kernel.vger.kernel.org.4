Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C932715E52
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 14:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbjE3MDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 08:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbjE3MDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 08:03:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1821B90
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 05:03:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0F92618CA
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 12:03:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A60C0C433D2;
        Tue, 30 May 2023 12:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685448210;
        bh=UECY/hnJSADC5VZOEzQM/ZORHs49xzHx0KxZggsN5bQ=;
        h=From:To:Cc:Subject:Date:From;
        b=oNBpB/hYPgbieR3LAb8RyTn0hMOvaNjt3wA20v7QuNyoCEDxE/Tg95LDzCctAeetO
         irViKVtHpMwNN4yDfeJyfv5NCRvQ6Uu/uJCFgDMdz/Ht/9Ui54rCUBQlsGgrZT+0rA
         x/gcEFuL0E15o4bv2mKiQEZUVKW11ni0l3leuzmX3oOJbtaXxPpbypeSJOhrqluDwx
         Z5+ZWJLG6ZEeSYpzZgSShOxJMRWg2mGoFOgDpLfs9vuwuxusnxdWjyvjOH9wXE4Jv6
         /FtNR5FtKoFN038s4IWR+fbn0DTq906YvU0Hp+7/Le23IG1htHku4CHBs76Yp5xsBn
         qAAouJHKJ/SDQ==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regmap fixes for v6.4-rc4
Date:   Tue, 30 May 2023 13:03:15 +0100
Message-Id: <20230530120329.A60C0C433D2@smtp.kernel.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-fix-v6.4-rc4

for you to fetch changes up to 0cc6578048e0980d254aee345130cced4912f723:

  regmap: maple: Drop the RCU read lock while syncing registers (2023-05-24 11:21:52 +0100)

----------------------------------------------------------------
regmap: Fixes for v6.4

The most important fix here is for missing dropping of the RCU read lock
when syncing maple tree register caches, the physical devices I have
that use the code don't do any syncing so I'd only ever tested this with
virtual devices and missed the fact that we need to drop the lock in
order to write to buses that need to sleep.  Otherwise there's a fix for
an edge case when splitting up large batch writes which has been lurking
for a long time, a check to make sure nobody writes new drivers with a
bug that was found in several SoundWire drivers and a tweak to the way
the new kunit tests are enabled to ensure they don't cause regmap to be
enabled when it wouldn't otherwise be.

----------------------------------------------------------------
Geert Uytterhoeven (1):
      regmap: REGMAP_KUNIT should not select REGMAP

Jim Wylder (1):
      regmap: Account for register length when chunking

Mark Brown (1):
      regmap: maple: Drop the RCU read lock while syncing registers

Srinivas Kandagatla (1):
      regmap: sdw: check for invalid multi-register writes config

 drivers/base/regmap/Kconfig          | 13 ++++++++++---
 drivers/base/regmap/regcache-maple.c |  5 ++++-
 drivers/base/regmap/regmap-sdw.c     |  4 ++++
 drivers/base/regmap/regmap.c         |  6 ++++--
 4 files changed, 22 insertions(+), 6 deletions(-)
