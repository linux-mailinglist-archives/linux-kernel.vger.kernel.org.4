Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D29656AAA63
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 15:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjCDO0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 09:26:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCDO0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 09:26:31 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6EE9F166E4
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 06:26:29 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 324EQGCY006041;
        Sat, 4 Mar 2023 15:26:16 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     paulmck@kernel.org
Cc:     linux@weissschuh.net, linux-kernel@vger.kernel.org,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 0/4] tools/nolibc: add stdint and more integer types
Date:   Sat,  4 Mar 2023 15:26:02 +0100
Message-Id: <20230304142606.5995-1-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Paul,

This first series of patches against nolibc is Vincent Dagonneau's final
work with the kind help from Thomas Weiﬂschuh who reviewed it.

It adds stdint, the accompanying types (uint64_t etc) and their limits.
Vincent wrote extensive tests for these limits that were added at the
end of the stdlib test series. What's nice is that the definitions are
mostly based on calculations from the compiler's provided limits while
the tests are made against hard-coded hex values, so this may possibly
help spot unexpected surprises with some uncommon compiler settings (or
even bugs in the printf implementation). And given that it required
several round trips to get to work on all archs, I tend to think that
it's quite sensitive to misconfigurations, which is a nice feature.

Running it on x86_64 gives me this:
  19 limit_int8_max = 127                                          [OK]
  20 limit_int8_min = -128                                         [OK]
  21 limit_uint8_max = 255                                         [OK]
  22 limit_int16_max = 32767                                       [OK]
  23 limit_int16_min = -32768                                      [OK]
  24 limit_uint16_max = 65535                                      [OK]
  25 limit_int32_max = 2147483647                                  [OK]
  26 limit_int32_min = -2147483648                                 [OK]
  27 limit_uint32_max = 4294967295                                 [OK]
  28 limit_int64_max = 9223372036854775807                         [OK]
  29 limit_int64_min = -9223372036854775808                        [OK]
  30 limit_uint64_max = -1                                         [OK]
  31 limit_int_least8_max = 127                                    [OK]
  32 limit_int_least8_min = -128                                   [OK]
  33 limit_uint_least8_max = 255                                   [OK]
  34 limit_int_least16_max = 32767                                 [OK]
  35 limit_int_least16_min = -32768                                [OK]
  36 limit_uint_least16_max = 65535                                [OK]
  37 limit_int_least32_max = 2147483647                            [OK]
  38 limit_int_least32_min = -2147483648                           [OK]
  39 limit_uint_least32_max = 4294967295                           [OK]
  40 limit_int_least64_min = -9223372036854775808                  [OK]
  41 limit_int_least64_max = 9223372036854775807                   [OK]
  42 limit_uint_least64_max = -1                                   [OK]
  43 limit_int_fast8_max = 127                                     [OK]
  44 limit_int_fast8_min = -128                                    [OK]
  45 limit_uint_fast8_max = 255                                    [OK]
  46 limit_int_fast16_min = -9223372036854775808                   [OK]
  47 limit_int_fast16_max = 9223372036854775807                    [OK]
  48 limit_uint_fast16_max = -1                                    [OK]
  49 limit_int_fast32_min = -9223372036854775808                   [OK]
  50 limit_int_fast32_max = 9223372036854775807                    [OK]
  51 limit_uint_fast32_max = -1                                    [OK]
  52 limit_int_fast64_min = -9223372036854775808                   [OK]
  53 limit_int_fast64_max = 9223372036854775807                    [OK]
  54 limit_uint_fast64_max = -1                                    [OK]
  56 limit_intptr_min = -9223372036854775808                       [OK]
  57 limit_intptr_max = 9223372036854775807                        [OK]
  58 limit_uintptr_max = -1                                        [OK]
  59 limit_ptrdiff_min = -9223372036854775808                      [OK]
  60 limit_ptrdiff_max = 9223372036854775807                       [OK]
  61 limit_size_max = -1                                           [OK]

This series was rebased on top of your dev.2023.02.22a branch that was
recently merged into rcu/next. If you want me to rebase it on any other
branch, just let me know. If it could make it for 6.4, it would be great.

Thank you!
Willy

Vincent Dagonneau (4):
  tools/nolibc: add stdint.h
  tools/nolibc: add integer types and integer limit macros
  tools/nolibc: enlarge column width of tests
  tools/nolibc: add tests for the integer limits in stdint.h

 tools/include/nolibc/Makefile                |   4 +-
 tools/include/nolibc/std.h                   |  15 +-
 tools/include/nolibc/stdint.h                |  99 ++++++++++++
 tools/testing/selftests/nolibc/nolibc-test.c | 149 +++++++++++++------
 4 files changed, 203 insertions(+), 64 deletions(-)
 create mode 100644 tools/include/nolibc/stdint.h

-- 
2.17.5

