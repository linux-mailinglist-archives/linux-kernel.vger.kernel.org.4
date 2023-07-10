Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E21674D80A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 15:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbjGJNpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 09:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbjGJNpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 09:45:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BF0E9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 06:45:29 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1688996727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=MqQQHifjCL0c2OnScyIKu+7EiHoYi5j4PKb/MmJ4YBA=;
        b=OYec+o0KCOOMwsAfbtONOyof+75wVZgRLD2p5Ragkko/rI9iROmI++kcRgw7NcXsMP/aUy
        OqMhd7M3j/l7Cr3qrlv2+W/kWjJGUqAfy1B0iHJgxl3aLDpLRsBwFW95jd9H7nhm0cTZ43
        cRXClf2IZBBu6sy2gU1RRDCcNlopiMeEciXXgGVOIQAF/RGrqUhiJGvLopfyYucZeq8qxj
        bvmTXG7Hy000m7nmS7gInhx8/py1oQ4HQFVTsp7w+NojIq/DWGV/DuIjwSSTyv5YLD3ys5
        CE7tklijPZdN75G21yNM+UidRBLiwv2cLujHgDWnBaHxwGUYooY74A4lUO1fHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1688996727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=MqQQHifjCL0c2OnScyIKu+7EiHoYi5j4PKb/MmJ4YBA=;
        b=NzZe8c77yHkyAWz/iVBJWdIWGLOw5m7u9FzXMD/Sc+4z5UzWEm8Ns0yDB8rDS9YZbksRrR
        SS/pWGdMjQa29bBg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Aaron Tomlin <atomlin@atomlin.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v2 0/5] various cleanups
Date:   Mon, 10 Jul 2023 15:51:19 +0206
Message-Id: <20230710134524.25232-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is v2 of a series working towards threaded/atomic console
printing. This series is only a subset of the original
v1 [0]. That series began with various cleanups before adding
the threaded/atomic code. Since none of those cleanups made it
into the recent 6.5 merge window, I have decided to post them
as their own series. I hope this helps to get them accepted
without being attached to any threaded/atomic discussions.

Changes since v1:

- drop patches 5-18 (they will return in a follow-up series)

- console_unblank() aborts if called from NMI context

- console_flush_on_panic() directly flushes rather than using
console_lock/_unlock dance (because console_lock/_unlock is not
NMI-safe)

- remove @console_suspended and rely only on CON_SUSPENDED flag

- rename abandon_console_lock_in_panic() to
other_cpu_in_panic()

- console_trylock() and console_lock() will fail and block,
respectively, while another CPU is in panic

- adjust various comments and whitespace as suggested

John Ogness

[0] https://lore.kernel.org/lkml/20230302195618.156940-1-john.ogness@linutronix.de

John Ogness (5):
  kdb: do not assume write() callback available
  printk: Add NMI safety to console_flush_on_panic() and
    console_unblank()
  printk: Consolidate console deferred printing
  printk: Add per-console suspended state
  printk: Rename abandon_console_lock_in_panic() to other_cpu_in_panic()

 include/linux/console.h     |   3 +
 kernel/debug/kdb/kdb_io.c   |   2 +
 kernel/printk/internal.h    |   2 +
 kernel/printk/printk.c      | 189 +++++++++++++++++++++++-------------
 kernel/printk/printk_safe.c |   9 +-
 5 files changed, 132 insertions(+), 73 deletions(-)


base-commit: 7ec85f3e089aa423a69559bf4555b6218b5a2ef7
-- 
2.30.2

