Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D13E623C06
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 07:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbiKJGll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 01:41:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232713AbiKJGl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 01:41:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7F32F640
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 22:41:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CE53EB820D8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 06:41:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52745C433D7;
        Thu, 10 Nov 2022 06:41:11 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1ot1Fy-009EdE-2X;
        Thu, 10 Nov 2022 01:41:46 -0500
Message-ID: <20221110064101.429013735@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 10 Nov 2022 01:41:01 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Julia Lawall <Julia.Lawall@inria.fr>
Subject: [PATCH v6 0/6] timers: Use timer_shutdown*() before freeing timers
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This is just the patches to implement the infrastructure of the
timer_shutdown_sync() and timer_shutdown(). I'll leave the scripting for the
second stage if this is approved.

Changes since the v5a: https://lore.kernel.org/all/20221106054535.709068702@goodmis.org/

- Broke up the implementation patch into three patches:

  1. The code taken from Thomas and tweaked to compile and added comments,
     as well as changing the name to timer_shutdown_sync():
     https://lore.kernel.org/all/20221106054535.709068702@goodmis.org/

  2. Addition of timer_shutdown() that is like del_timer() but uses the same
     logic as timer_shutdown_sync() to disable the timer after it is called.

  3. Update the documentation to reflect the new APIs.

Steven Rostedt (Google) (6):
      ARM: spear: Do not use timer namespace for timer_shutdown() function
      clocksource/drivers/arm_arch_timer: Do not use timer namespace for timer_shutdown() function
      clocksource/drivers/sp804: Do not use timer namespace for timer_shutdown() function
      timers: Add timer_shutdown_sync() to be called before freeing timers
      timers: Add timer_shutdown() to be called before freeing timers
      timers: Update the documentation to reflect on the new timer_shutdown() API

----
 .../RCU/Design/Requirements/Requirements.rst       |  2 +-
 Documentation/core-api/local_ops.rst               |  2 +-
 Documentation/kernel-hacking/locking.rst           |  5 ++
 arch/arm/mach-spear/time.c                         |  8 +--
 drivers/clocksource/arm_arch_timer.c               | 12 ++--
 drivers/clocksource/timer-sp804.c                  |  6 +-
 include/linux/timer.h                              | 62 +++++++++++++++++++--
 kernel/time/timer.c                                | 64 ++++++++++++----------
 8 files changed, 110 insertions(+), 51 deletions(-)
