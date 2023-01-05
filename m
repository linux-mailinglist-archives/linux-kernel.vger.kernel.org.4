Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7E1765E91F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 11:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbjAEKin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 05:38:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233052AbjAEKiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 05:38:17 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A33395DF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 02:38:16 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1672915095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=MdjBBReZIfmoiufuLij38tBr00juxvxCP4KNiop85+Q=;
        b=lranmi2OrApPXfpJ5WnnZ/2MIDjwCOJ6mZ5/h9LsvNkvISYyHiL5vBJd+kTh5MLNVkvHsC
        fObg2bS8ligwD2ER0fGnCWzd2xE7ir3gqSoqXGQObU3HZtPdFu3iTykj8RQ1J5GPN+r+KX
        q2Wg/pu9JOjLef7+dexBL2wZKvS6wIE1pkwDVelepjAB180w9S9vvUph7X0SqWBO7XjQuw
        0pJQdqkdItv0rreJVdSj4Ut9Utt9Sy5mOw64EOCzrjKOGsQ8dMbMlks+tCRitIvqifc2zy
        ldxMQuvN9G0DlqMseIBZjZAr23Ohr3c5yO3ulwjLlKikarFx+0oXMOUt9hPOXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1672915095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=MdjBBReZIfmoiufuLij38tBr00juxvxCP4KNiop85+Q=;
        b=8F4zIxJ1e6LpR6bzNMw8AlxZgBK2vc32t6oVcOEwyH7SsByOnZLXOQTq1xVGaZEr1wqmRe
        4vxjqVfPtS8zpoBw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v4 0/8] printk: cleanup buffer handling
Date:   Thu,  5 Jan 2023 11:43:27 +0106
Message-Id: <20230105103735.880956-1-john.ogness@linutronix.de>
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

This is v4 of a series to cleanup console buffer handling and
prepare for code sharing with the upcoming threaded/atomic
consoles. v3 is here [0].

The main purpose of the series is to introduce two new lockless
functions to handle reading and formatting of printk messages. These
functions can then be used from any context, which is important for
the upcoming threaded/atomic consoles. The series also helps to
cleanup some of the internal printk interfaces and cleanly separate
formatting code from outputting code.

Some changes in this version were not part of the feedback. However,
from the discussions and examples I decided that some of the names
I had previously chosen were not appropriate. Particularly, structs,
variables, and functions should only use the "console_" prefix if it
is console-specific. Things that are used for general printk
processing should use a "printk_" prefix. This makes the diff to v3
rather large, even though the "real code" has only minor changes.

@Petr: Like with v3, this version uses a wrapper struct for the
message metadata to avoid clobbering. Making the message formatting
code robust enough to handle metadata clobbering was too complex
(particularly with the dropped tracking).

Changes since v3:

- Provide a detailed explanation in the commit message about why
  message metadata is put into a wrapper struct instead of the
  buffer struct.

- Reorder stack variable definitions so that static variables are at
  the top and separated from non-static variables. IMHO it is
  important to clearly see which of the variables are static.

- Drop a previous coding-style change from a line not related to
  this series.

- In console_prepend_dropped() make sure the buffer is large enough
  for the dropped message and at least PREFIX_MAX of the current
  message.

- Define the PREFIX_MAX macro for !CONFIG_PRINTK in internal.h
  because console_prepend_dropped() now needs it.

- Rename various functions, structs, fields, and macros:

    console_get_next_message()  ->  printk_get_next_message()

    struct console_buffers      ->  struct printk_buffers

    struct console_message      ->  struct printk_message

    console_message.cbufs       ->  printk_message.pbufs

    console_message.outbuf_seq  ->  printk_message.seq

    LOG_LINE_MAX                ->  PRINTKRB_RECORD_MAX

    PREFIX_MAX                  ->  PRINTK_PREFIX_MAX

    CONSOLE_LOG_MAX and
    CONSOLE_EXT_LOG_MAX         ->  PRINTK_MESSAGE_MAX

- Adjust the values of string limit macros. This is explained in
  detail in the commit message.

- Replace @buf and @text_buf in struct devkmsg_user with struct
  printk_buffers.

- Replace message formatting code in devkmsg_read() with
  printk_get_next_message().

- Define all printk_message structs on the stack.

John Ogness

[0] https://lore.kernel.org/lkml/20221221202704.857925-1-john.ogness@linutronix.de

John Ogness (6):
  printk: move size limit macros into internal.h
  printk: introduce struct printk_buffers
  printk: introduce printk_get_next_message() and printk_message
  printk: introduce console_prepend_dropped() for dropped messages
  printk: use printk_buffers for devkmsg
  printk: adjust string limit macros

Thomas Gleixner (2):
  console: Use BIT() macros for @flags values
  console: Document struct console

 include/linux/console.h  | 100 +++++++++----
 include/linux/printk.h   |   2 -
 kernel/printk/internal.h |  45 ++++++
 kernel/printk/printk.c   | 293 +++++++++++++++++++++++----------------
 4 files changed, 288 insertions(+), 152 deletions(-)


base-commit: 6b2b0d839acaa84f05a77184370f793752e786e9
-- 
2.30.2

