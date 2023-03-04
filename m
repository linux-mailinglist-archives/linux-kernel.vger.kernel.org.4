Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9A16AAA69
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 15:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjCDO3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 09:29:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjCDO3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 09:29:04 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 78E4D3C04
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 06:29:03 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 324ESsCj006569;
        Sat, 4 Mar 2023 15:28:54 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     paulmck@kernel.org
Cc:     chenhuacai@loongson.cn, chenfeiyang@loongson.cn,
        linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 0/5] tools/nolibc: cleanups, statx(), getuid()
Date:   Sat,  4 Mar 2023 15:28:39 +0100
Message-Id: <20230304142844.6522-1-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Paul,

this is the second series of updates for nolibc. The work was
started by Feiyang Chen who got rid of some local definitions in
favor of inclusion of linux/fcntl.h. Consecutive to this I noticed
new issues related to redefinitions of S_IFDIR and friends and
figured that it can happen with some compilers that /usr/include is
inconditionally checked and causes annoyance around these flags that
are defined both in glibc and the kernel. The UAPI includes already
have a specific check for this, so the issue was fixed by always
including linux/stat.h in types.h and conditionally defining our own
flags like UAPI does.

Feiyang also added statx() because loongarch needs it for stat().

Finally I added getuid() and geteuid() so that we can finally skip
the two tests that require privileges in "run-user" native tests. Now
they appear as "SKIPPED" in the output, and the test is reported as
successful since there's no error anymore. I was finding it really
annoying to always have to carefully check errors that were expected
on success, now that's just bad old memories.

This series applies on top of Vincent's stdint series that was rebased
on top of your dev.2023.02.22a branch. Likewise, if it could make it
for 2.4 that would be great, especially since the next loongarch series
depends on it.

Thanks!
Willy

Feiyang Chen (2):
  tools/nolibc: Include linux/fcntl.h and remove duplicate code
  tools/nolibc: Add statx() and make stat() rely on statx() if necessary

Willy Tarreau (3):
  tools/nolibc: add getuid() and geteuid()
  selftests/nolibc: skip the chroot_root and link_dir tests when not
    privileged
  tools/nolibc: check for S_I* macros before defining them

 tools/include/nolibc/sys.h                   | 100 ++++++++++++++++++-
 tools/include/nolibc/types.h                 |  28 ++++--
 tools/testing/selftests/nolibc/nolibc-test.c |   8 +-
 3 files changed, 127 insertions(+), 9 deletions(-)

-- 
2.17.5

