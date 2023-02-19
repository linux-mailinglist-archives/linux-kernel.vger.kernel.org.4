Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D9269C1FC
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 19:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbjBSSvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 13:51:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjBSSvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 13:51:51 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8BD5914491
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 10:51:49 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 31JIpi5t014621;
        Sun, 19 Feb 2023 19:51:44 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Vincent Dagonneau <v@vda.io>
Cc:     linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/4] tools/nolibc: add stdint and more integer types
Date:   Sun, 19 Feb 2023 19:51:29 +0100
Message-Id: <20230219185133.14576-1-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

I could finally work out the various issues. In short, all of the
problems came from the dependency on __WORDSIZE and the fact that
when not defined, the tests would default to the 32-bit ones. The
reason why it seldom worked was that some cross-compilers configured
to build for the same build and target arch do still mistakenly
include files from /usr/include and inadvertently get some glibc
entries. I changed these locations to rely on __SIZEOF_LONG__ instead
that's provided by the compiler and which I've tested to work fine
since pretty old compilers. For the values I've switched to __LONG_MAX__
that is also defined by the compiler, and this allows us to get rid
of the ifdef and hard-coded values in stdint.h.

Now everything works fine on all supported architectures.

I'd like you to have a look at this patch set, it's yours with
these small changes that I've commented before my s-o-b when
relevant. I would appreciate it if you could recheck everything,
possibly change some stuff if you think it's needed, and also
adjust your commit messages where relevant to match the final
state, dropping my own temporary comments and s-o-b that are
not needed.

One important note, I've based the patch on Paul's latest branch
named "dev.2023.02.06a" here:

  https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/

It contains the pending patches that will soon be submitted to Linus,
and support for the s390x platform that I wanted to confirm does work
fine as well. If you need to change some code, please rebase on this
branch before testing.

Thanks!
Willy

--
Vincent Dagonneau (4):
  tools/nolibc: add stdint.h
  tools/nolibc: add integer types and integer limit macros
  tools/nolibc: enlarge column width of tests
  tools/nolibc: add tests for the integer limits in stdint.h

 tools/include/nolibc/Makefile                |   4 +-
 tools/include/nolibc/std.h                   |  15 +-
 tools/include/nolibc/stdint.h                |  75 ++++++++++
 tools/testing/selftests/nolibc/nolibc-test.c | 141 ++++++++++++-------
 4 files changed, 170 insertions(+), 65 deletions(-)
 create mode 100644 tools/include/nolibc/stdint.h

-- 
2.35.3

