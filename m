Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84793673DFB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 16:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbjASPwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 10:52:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbjASPwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 10:52:16 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256D887280
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 07:52:14 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id AF6B9353CF;
        Thu, 19 Jan 2023 15:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1674143533; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=O3dl1mYK/MmaCtkwBoNcAdojyZZv2CylTbxWWGSopzI=;
        b=YyAgIcBzuljHkaf3iAhY/1FZ19MPWy2YwRJFX8A+TfFUneExxoP9S8XPnbf1Z9NKIbPcne
        9cytUACuGn1MZEtXJikA3ZFsvvmMMWhGG7ANeBOU8GSRcKiGw7OzD/v7KgYy7qGNabfeqJ
        CXbBNQN8aP7u2Q+dVIMU+w71jy8cKSo=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 53D922C141;
        Thu, 19 Jan 2023 15:52:12 +0000 (UTC)
Date:   Thu, 19 Jan 2023 16:52:11 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] printk fixes for 6.2-rc5
Message-ID: <Y8lnK3WdqVM3bxBX@alley>
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

please merge the following printk fixes for 6.2-rc5:

  git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-6.2-rc5

============================================

+ Prevent a potential deadlock when configuring kgdb console.

+ Fix a kernel doc warning.

============================================

Both are fixing regressions caused by printk changes in 6.2-rc1.

----------------------------------------------------------------
Anuradha Weeraman (1):
      kernel/printk/printk.c: Fix W=1 kernel-doc warning

John Ogness (1):
      tty: serial: kgdboc: fix mutex locking order for configure_kgdboc()

Petr Mladek (1):
      Merge branch 'rework/console-list-lock' into for-linus

 drivers/tty/serial/kgdboc.c      | 20 +++++---------------
 drivers/tty/serial/serial_core.c |  5 +++++
 kernel/printk/printk.c           |  2 ++
 3 files changed, 12 insertions(+), 15 deletions(-)
