Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD5F6A756B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 21:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjCAUfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 15:35:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjCAUfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 15:35:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B8728D1D
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 12:34:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2A98614B3
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 20:34:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E411FC4339B;
        Wed,  1 Mar 2023 20:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677702894;
        bh=2fJzHQXfttSmm0wQ8IPyk/27UJUBeWylfrhetW6pElQ=;
        h=From:To:Cc:Subject:Date:From;
        b=r08PMf/akfsvh8T6z1fGnAnJEFUP6mMUx/Hc5l0l8p9srEwrNS8eJl3gp9HJiI09n
         YnSfSXtEsYML3jp8uydSvB5jrT1fVsmmSZTylSDxOvZmQCNJBw4n/z6YxeEDmKwn76
         xXdW4q9U755GoT/+1gPxvWfmVw2HxujitGj7hXq6mv3sfqYgV2zOtINKmF0vWOwRAv
         pwxKaPMr4Etln7wKnM7H3BQ23KuZX0HpWEAXfe1CSJpdAe+QszyxyZtiapoNcmMPSU
         ED1mTiOcIZiznNn0jSR8dsTVa7O0RuNb3udpNd/bdkWwbDWnBEYwEA7YqN3RW9Q8sX
         2GvovThcbdyUQ==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator fixes for v6.3
Date:   Wed, 01 Mar 2023 20:34:41 +0000
Message-Id: <20230301203453.E411FC4339B@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 7f62cb8861190e7cc1018ff37597fc49b2eaafa8:

  regulator: max597x: Align for simple_mfd_i2c driver (2023-02-16 15:54:02 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.3

for you to fetch changes up to 80d2c29e09e663761c2778167a625b25ffe01b6f:

  regulator: core: Use ktime_get_boottime() to determine how long a regulator was off (2023-02-23 11:40:14 +0000)

----------------------------------------------------------------
regulator: Fixes for v6.3

Two fixes here, one driver fix for incorrect error codes and a fix in
the core to use ktime_get_boottime() in order to fix accounting of the
time regulators have been powered down over suspend, ktime_get()
pauses over suspend which is not what we want.

----------------------------------------------------------------
Axel Lin (1):
      regulator: max597x: Fix error return code in max597x_get_status

Matthias Kaehlcke (1):
      regulator: core: Use ktime_get_boottime() to determine how long a regulator was off

 drivers/regulator/core.c              | 6 +++---
 drivers/regulator/max597x-regulator.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)
