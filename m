Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6C96C8F0D
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 16:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjCYPpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 11:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjCYPpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 11:45:41 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 360816194
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 08:45:39 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 32PFjQ7c008045;
        Sat, 25 Mar 2023 16:45:26 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux@weissschuh.net, linux-kernel@vger.kernel.org,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 0/8] tools/nolibc: add support for stack protector
Date:   Sat, 25 Mar 2023 16:45:08 +0100
Message-Id: <20230325154516.7995-1-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.0 required=5.0 tests=SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Paul,

This is essentially Thomas' work so instead of paraphrasing his work,
I'm pasting his description below. I've tested his changes on all
supported archs, applied a tiny modification with his permission
to continue to support passing CFLAGS, and for me this is all fine.
In a short summary this adds support for stack protector to i386 and
x86_64 in nolibc, and the accompanying test to the selftest program.

A new test category was added, "protection", which currently has a
single test. Archs that support it will report "OK" there and those
that do not will report "SKIPPED", as is already the case for tests
that cannot be run.

This was applied on top of your dev.2023.03.20a branch. I'm reasonably
confident with the nature of the changes, so if your queue for 6.4 is
not closed yet, it can be a good target, otherwise 6.5 will be fine as
well.

Thanks in advance!
Willy

Thomas' description below:

This is useful when using nolibc for security-critical tools.
Using nolibc has the advantage that the code is easily auditable and
sandboxable with seccomp as no unexpected syscalls are used.
Using compiler-assistent stack protection provides another security
mechanism.

For this to work the compiler and libc have to collaborate.

This patch adds the following parts to nolibc that are required by the
compiler:

* __stack_chk_guard: random sentinel value
* __stack_chk_fail: handler for detected stack smashes

In addition an initialization function is added that randomizes the
sentinel value.

Only support for global guards is implemented.
Register guards are useful in multi-threaded context which nolibc does
not provide support for.

Link: https://lwn.net/Articles/584225/


Thomas Weißschuh (8):
  tools/nolibc: add definitions for standard fds
  tools/nolibc: add helpers for wait() signal exits
  tools/nolibc: tests: constify test_names
  tools/nolibc: add support for stack protector
  tools/nolibc: tests: fold in no-stack-protector cflags
  tools/nolibc: tests: add test for -fstack-protector
  tools/nolibc: i386: add stackprotector support
  tools/nolibc: x86_64: add stackprotector support

 tools/include/nolibc/Makefile                |  4 +-
 tools/include/nolibc/arch-i386.h             |  7 ++-
 tools/include/nolibc/arch-x86_64.h           |  5 ++
 tools/include/nolibc/nolibc.h                |  1 +
 tools/include/nolibc/stackprotector.h        | 53 ++++++++++++++++
 tools/include/nolibc/types.h                 |  2 +
 tools/include/nolibc/unistd.h                |  5 ++
 tools/testing/selftests/nolibc/Makefile      | 11 +++-
 tools/testing/selftests/nolibc/nolibc-test.c | 64 +++++++++++++++++++-
 9 files changed, 144 insertions(+), 8 deletions(-)
 create mode 100644 tools/include/nolibc/stackprotector.h

-- 
2.17.5

