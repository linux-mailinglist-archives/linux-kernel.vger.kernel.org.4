Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B374C6D39E3
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 20:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjDBSsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 14:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjDBSsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 14:48:18 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CD10A61BF
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 11:48:17 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 332ImCG5012486;
        Sun, 2 Apr 2023 20:48:12 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux@weissschuh.net, linux-kernel@vger.kernel.org,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 0/4] tools/nolibc: add testcases for vfprintf
Date:   Sun,  2 Apr 2023 20:48:02 +0200
Message-Id: <20230402184806.12440-1-w@1wt.eu>
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

Thomas added new tests for vfprintf(), which is a good idea because it
was a new implementation, we use it a lot in the tests so we'd rather
make sure it works! This required to implement support for memfd_create()
that is used to collect the output into a buffer, as well as to complete
a little bit the minimalistic FILE emulation with fileno(), fdopen(),
fflush() and fclose(). The result is neat and works equally on glibc and
nolibc. We just had to cheat on the pointer test because for NULL nolibc
prints "0x0" while glibc prints "(nil)" so we check 0x1 instead to avoid
this special case.

Finally Thomas added a new target to the makefile to ease building the
test against the default libc. This should help detect incompatibilities
when new features are added.

I've tested it locally with my libc and against all supported architectures
(userland tests only), and all tests passed.

This can be added to your dev tree for 6.5 on top of the previous series.

Thanks!
Willy

Thomas Weißschuh (4):
  tools/nolibc: add libc-test binary
  tools/nolibc: add wrapper for memfd_create
  tools/nolibc: implement fd-based FILE streams
  tools/nolibc: add testcases for vfprintf

 tools/include/nolibc/stdio.h                 | 95 ++++++++++++++------
 tools/include/nolibc/sys.h                   | 23 +++++
 tools/testing/selftests/nolibc/.gitignore    |  1 +
 tools/testing/selftests/nolibc/Makefile      |  6 ++
 tools/testing/selftests/nolibc/nolibc-test.c | 86 ++++++++++++++++++
 5 files changed, 184 insertions(+), 27 deletions(-)

-- 
2.17.5

