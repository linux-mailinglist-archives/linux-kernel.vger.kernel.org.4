Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8372E653793
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 21:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234858AbiLUU1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 15:27:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbiLUU1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 15:27:46 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ECFB24F31
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 12:27:44 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1671654455;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=VIqdJ0YTNSmSRedQRnl+BhCMl6FnNTn3wMBtYEOHs9w=;
        b=0oYhLWVUfAGU60u+j8GATEKZqaW0U2CsxPobpMAQf8X7T5ipkQHXTkXKKEy8yWfEsafCGS
        GIaFoQKynhqwS/WV7aoD6SWaLAb0ZdtByZvVJ2VIHTxGS1W755aWEB35uVxsDLHIQX63uP
        SmZdWxVgnIQu6kSrZoPzBkF7LvAHLNqF8MSK1fi0Sl6QFnfGPNOJB0HPcD0IXRRmjCLt/M
        ANgTMrbHirD3L4lT2zf+kZSBNEq5HUoQ3p+zp/zaxD+1CqfMMceN11wDrWu+02LkkcpNec
        PDwwKQgbz+KGf7bLTYzzux9SFN0tYxQNXZCKhmeSlhntsLf5PqYzQyH6x2Ns8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1671654455;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=VIqdJ0YTNSmSRedQRnl+BhCMl6FnNTn3wMBtYEOHs9w=;
        b=aXrPl5RW/V5PLGBcEKAgL9P+W4JmMWJR5xw4Kxn1vG9NlAXeb3/igNXUI7GaYgne58qEzc
        qo4uW4PjjQfd9eAg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v3 0/6] printk: cleanup buffer handling
Date:   Wed, 21 Dec 2022 21:32:58 +0106
Message-Id: <20221221202704.857925-1-john.ogness@linutronix.de>
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

This is v3 of a series to cleanup console buffer handling and
prepare for code sharing with the upcoming threaded/atomic
consoles. v2 is here [0].

The main purpose of the series is to introduce 2 new lockless
functions to handle all console formatting of printk messages. These
functions can then be used from any context, which is important for
the upcoming threaded/atomic consoles. The series also helps to
cleanup some of the internal printk interfaces and cleanly separate
formatting code from outputting code.

Changes since v2:

- Put size limit macros and definitions of structs console_buffers
  and console_message in printk/internal.h instead of
  linux/console.h.

- Provide a better description for @dropped field of struct console.
  (Only a small change in patch 3/6. I kept Petr's Reviewed-by tag.)

- Move the static struct console_buffers inside
  console_emit_next_record() since this function will not be used by
  the threaded/atomic consoles.

- Rename various functions and struct fields:

    msg_print_dropped()       ->  console_prepend_dropped()

    console_buffers.ext_text  ->  console_buffers.outbuf

    console_buffers.text      ->  console_buffers.scratchbuf

- console_buffers.outbuf is always the output buffer.

- Change struct console_message fields:

    removed: char *outbuf

    removed: bool is_extmsg

    added:   u64 outbuf_seq

    added:   unsigned long dropped

- All struct console_message fields are now output fields. No input
  fields.

- Implement console_prepend_dropped() as suggested by pmladek: shift
  existing message and insert dropped message.

- For console_get_next_message():

    add all input variables as arguments

    do not rely on locking (no @console argument)

    do not prepend "dropped messages", let the caller deal with that

    implement as suggested by pmladek: use different buffers for
    ringbuffer reading so that @outbuf is always the output buffer
    in the end

- Do not use struct console_buffers for devkmsg. (It is not a
  console).

John Ogness

[0] https://lore.kernel.org/lkml/20221123231400.614679-1-john.ogness@linutronix.de

John Ogness (4):
  printk: move size limit macros into internal.h
  printk: introduce struct console_buffers
  printk: introduce console_get_next_message() and console_message
  printk: introduce console_prepend_dropped() for dropped messages

Thomas Gleixner (2):
  console: Use BIT() macros for @flags values
  console: Document struct console

 include/linux/console.h  | 100 ++++++++++++-----
 include/linux/printk.h   |   2 -
 kernel/printk/internal.h |  45 ++++++++
 kernel/printk/printk.c   | 237 +++++++++++++++++++++++----------------
 4 files changed, 260 insertions(+), 124 deletions(-)


base-commit: 6b2b0d839acaa84f05a77184370f793752e786e9
-- 
2.30.2

