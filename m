Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A46D636E33
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 00:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiKWXOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 18:14:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKWXON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 18:14:13 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0398F6BDEE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 15:14:11 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669245249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=otGSdvebbiUS4OgzfTAUBgwc0OiYKvwDmMVYgIzL0BA=;
        b=rquhVYTNPTKQiPyllGm5f6jOvJlrNNxmWcvlITagDymRBgo9zpxKsDyfv4/qGN1EaIjmy5
        P6irPKpPMq5FtXmu+VvyWF6TgZoa4lSwt7iKP3J7JcYU6R0Obao1QMNTRp+MRlsk+lChOh
        Q9ppGi7NalhKpgV//dmHa4TJCTQroFNw+U/tAqqn2ynwP6+Pje8XrBf3WwkpM3fUDrHN9O
        KJuq3DILsV/Wi4BrW4RMcb6nA/rpLZL9z6PGyWYT/muPizJVKGvURxvj54yLeBB+tatMkF
        CgBM12cBsCIjBJqygKPZp6v48j+ZN3IrY/cw+WegLHC6F4rLfgwfvB7uxgasDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669245249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=otGSdvebbiUS4OgzfTAUBgwc0OiYKvwDmMVYgIzL0BA=;
        b=jlE+CN9ICkgjgjOFNsrlDg7OYEKZYTBEqieQrtG4FN+b98rLsIOvuXzB2X9NUiHce/0R9k
        gFqt629lcVdp/wCQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v2 0/7] printk: cleanup buffer handling
Date:   Thu, 24 Nov 2022 00:19:53 +0106
Message-Id: <20221123231400.614679-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is v2 of a series to cleanup buffer handling and prepare for
code sharing with the upcoming threaded/atomic consoles. v1 is
patches 13-18 of [0].

Changes since v1:

- Explain why console.h was chosen for buffer size defines.

- Keep DROPPED_TEXT_MAX define in printk.c.

- Put new BIT()-macro usage for console flags into its own commit.

- Modify descriptions for console flags as suggested.

- Add argument names and types to console callback definitions to
  satisfy checkpatch.pl complaints.

- Avoid temporary usage of an ext_text/dropped_text union mid-series.

- Rename various structures, fields, and functions:

    struct cons_text_buf    -> struct console_buffers

    struct cons_outbuf_desc -> struct console_message

    cons_outbuf_desc.txtbuf -> console_message.cbufs

    cons_outbuf_desc.len    -> console_message.outbuf_len

    cons_outbuf_desc.extmsg -> console_message.is_extmsg

    cons_fill_outbuf()      -> console_get_next_message()

    cons_print_dropped()    -> msg_print_dropped()

- Remove cons_outbuf_desc->dropped and make @dropped an argument of
  msg_print_dropped() instead.

- Use "ext_text" and "ext_text_size" names for stack variables when
  they refer to console_buffers->ext_text.

- Add a compile-time verification that DROPPED_TEXT_MAX is less than
  CONSOLE_EXT_LOG_MAX - CONSOLE_LOG_MAX since the code expects that
  a dropped+regular message will fit in console_buffers->ext_text.

- Replace hard-coded CONSOLE_LOG_MAX and CONSOLE_EXT_LOG_MAX usage
  with sizeof() usage.

- For dropped messages, copy the regular message to append the
  dropped message, instead of copying the dropped message to prepend
  the regular message. Now it is not a hack and there is no need for
  the __no_randomize_layout annotation.

- Reset console->dropped explicitly instead of relying on
  msg_print_dropped() side-effects.

- Rework and expand comments and commit messages as requested.

John Ogness

[0] https://lore.kernel.org/lkml/20220924000454.3319186-1-john.ogness@linutronix.de

Thomas Gleixner (7):
  printk: Move buffer size defines
  console: Use BIT() macros for @flags values
  console: Document struct console
  printk: Add struct console_buffers
  printk: Use struct console_buffers
  printk: Use an output buffer descriptor struct for emit
  printk: Handle dropped message smarter

 include/linux/console.h | 139 ++++++++++++++++++-----
 include/linux/printk.h  |   2 -
 kernel/printk/printk.c  | 240 ++++++++++++++++++++++++++--------------
 3 files changed, 269 insertions(+), 112 deletions(-)


base-commit: 11f1e536902b38bffab9913f8908309daf7e53e1
-- 
2.30.2

