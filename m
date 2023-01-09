Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7666662287
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 11:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233699AbjAIKJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 05:09:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236859AbjAIKIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 05:08:47 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662261054F
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 02:08:46 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673258924;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=72AG3JRI1xk+MbrVQlkAivsLz4+7Y+wE7DkvkbW3NJ0=;
        b=WBCGKDbZ4yoy50cnZXwyXsgLTAdMCARw5Ho+zt8bJKSWWdNJrbSM+vjnq3E+9CNeSLymhO
        6PIE7fe5XFBNv7QO7LRWGpwPFY9IW+jBBeToMHwUMjDS6byCwHsQgv1pUyYJgYP0u9HefK
        SbqkgOeqIY7QvUBWJKoHoveufAOGGU4WekVJTVgaqiJPAMbM7dgQ7Gx0Bw9ql792aG4ejh
        MUD0+sSelXJf/buifxzQlniwGHRtLtsIhoJnbfOpQYazd0ilElLsBq2YURZ9tG6lN4dIRj
        xcOZwCk4YGa8uFAkT/JJ9uyTTmG8wD/959aQW7ppArcwlxNMOMX2qnGeoZZrfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673258924;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=72AG3JRI1xk+MbrVQlkAivsLz4+7Y+wE7DkvkbW3NJ0=;
        b=bHSiILY/ryGpaX4ilQZkUvRbgnBnqyAaTFQ7CDp10BjhQazWgJZAz82Ut89++6djbzvEyE
        92lZyHf5QyWslYCg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v5 0/8] printk: cleanup buffer handling
Date:   Mon,  9 Jan 2023 11:13:52 +0106
Message-Id: <20230109100800.1085541-1-john.ogness@linutronix.de>
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

This is v5 of a series to cleanup console buffer handling and
prepare for code sharing with the upcoming threaded/atomic
consoles. v4 is here [0].

The main purpose of the series is to introduce two new lockless
functions to handle reading and formatting of printk messages. These
functions can then be used from any context, which is important for
the upcoming threaded/atomic consoles. The series also helps to
cleanup some of the internal printk interfaces and cleanly separate
formatting code from outputting code.

Changes since v4:

- Make console_prepend_dropped() a NOP for !CONFIG_PRINTK to
  workaround compiler warnings.

- In devkmsg_read() use printk_get_next_message() for the wait
  condition instead of looping to retry the actual read.

- Add an argument @may_suppress to printk_get_next_message() so
  devkmsg_read() can specify that records should not be skipped
  based on loglevel.

John Ogness

[0] https://lore.kernel.org/lkml/20230105103735.880956-1-john.ogness@linutronix.de

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
 kernel/printk/printk.c   | 308 +++++++++++++++++++++++----------------
 4 files changed, 297 insertions(+), 158 deletions(-)


base-commit: 6b2b0d839acaa84f05a77184370f793752e786e9
-- 
2.30.2

