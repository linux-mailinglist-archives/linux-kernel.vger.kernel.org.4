Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F115F521D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 11:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiJEJ51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 05:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiJEJ5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 05:57:24 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215376EF27
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 02:57:23 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id AF9DB21883;
        Wed,  5 Oct 2022 09:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664963841; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=JyaUs6Ihn2IfkCIQoue5hYfEQUT2/L42VSB0bx6xlEU=;
        b=i8/zalVyBjv93naMEJuoFIjUCbnNHzCwd9JLnnhUwtyHiU0uOKCVITqM3A6zmGVOkQf7HI
        DsbDUmtLNQOjExGz4ZPXWKvg3QzzOynG8cs7d3/19PfKVmlT1AmN68XqQWSMIQP/rzPU6O
        ok8VzzN9JqCncUra9AggOpZ16G3RN8s=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 044A32C15D;
        Wed,  5 Oct 2022 09:57:20 +0000 (UTC)
Date:   Wed, 5 Oct 2022 11:57:20 +0200
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
Subject: [GIT PULL] printk for 6.1
Message-ID: <Yz1VANOUjskMbdxY@alley>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-6.1

==============================================

- Initialize pointer hashing using the system workqueue. It avoids
  taking locks in printk()/vsprintf() code path.

- Misc code clean up.

----------------------------------------------------------------
Jian Shen (1):
      lib/vnsprintf: add const modifier for param 'bitmap'

Petr Mladek (2):
      Merge branch 'for-6.1-hash-pointer-init' into for-linus
      Merge branch 'rework/kthreads' into for-linus

Sebastian Andrzej Siewior (2):
      lib/vsprintf: Remove static_branch_likely() from __ptr_to_hashval().
      lib/vsprintf: Initialize vsprintf's pointer hash once the random core is ready.

Thomas Gleixner (5):
      printk: Make pr_flush() static
      printk: Declare log_wait properly
      printk: Remove write only variable nr_ext_console_drivers
      printk: Remove bogus comment vs. boot consoles
      printk: Mark __printk percpu data ready __ro_after_init

 fs/proc/kmsg.c         |  2 --
 include/linux/printk.h |  7 -------
 include/linux/syslog.h |  3 +++
 kernel/printk/printk.c | 19 ++++---------------
 lib/vsprintf.c         | 51 +++++++++++++++++++++++++++-----------------------
 5 files changed, 35 insertions(+), 47 deletions(-)
