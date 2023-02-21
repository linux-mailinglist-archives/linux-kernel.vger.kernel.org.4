Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0BE69E23E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 15:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233765AbjBUOY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 09:24:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233340AbjBUOYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 09:24:51 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3A128859
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 06:24:50 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D76465C754;
        Tue, 21 Feb 2023 14:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1676989488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=IRGvBg4sT2XZjLD3W4d3/v2Een/gp6HPbAxpDUIztg4=;
        b=Nj2o/zBRGr4HW/pVTpjSHtv9xeS17eTb7JWGo7yks/x5ijAjMwWt8OLPzki3Fd5FaEjnQm
        wmON7KsV3L6OzRYMpCwY8rxPuf5HVX1YadB/YoWaj2UXoAAcJSR9T5Tu4go282bv3FZBOW
        mN/3llOSBscxwsAXJqvN7phZmjwOPM4=
Received: from suse.cz (pmladek.tcp.ovpn2.prg.suse.de [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 31AFD2C141;
        Tue, 21 Feb 2023 14:24:48 +0000 (UTC)
Date:   Tue, 21 Feb 2023 15:24:44 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>, Jan Kara <jack@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] printk for 6.3
Message-ID: <Y/TULJCcv0OlhIf1@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the latest printk changes from

  git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-6.3

=================================================

- Refactor printk code for formatting messages that are shown on consoles.
  It is a preparation step for introducing atomic consoles which could not
  share the global buffers.

- Prevent memory leak when removing printk index in debugfs.

- Dump also the newest printk message by the sample gdbmacro.

- Fix a compiler warning.

----------------------------------------------------------------
Arnd Bergmann (1):
      printf: fix errname.c list

Greg Kroah-Hartman (1):
      kernel/printk/index.c: fix memory leak with using debugfs_lookup()

John Ogness (7):
      docs: gdbmacros: print newest record
      printk: move size limit macros into internal.h
      printk: introduce struct printk_buffers
      printk: introduce printk_get_next_message() and printk_message
      printk: introduce console_prepend_dropped() for dropped messages
      printk: use printk_buffers for devkmsg
      printk: adjust string limit macros

Petr Mladek (2):
      printk: Use scnprintf() to print the message about the dropped messages on a console
      Merge branch 'rework/buffers-cleanup' into for-linus

Thomas Gleixner (2):
      console: Use BIT() macros for @flags values
      console: Document struct console

 Documentation/admin-guide/kdump/gdbmacros.txt |   2 +-
 include/linux/console.h                       | 100 ++++++---
 include/linux/printk.h                        |   2 -
 kernel/printk/index.c                         |   2 +-
 kernel/printk/internal.h                      |  45 ++++
 kernel/printk/printk.c                        | 308 +++++++++++++++-----------
 lib/errname.c                                 |  22 +-
 7 files changed, 313 insertions(+), 168 deletions(-)
