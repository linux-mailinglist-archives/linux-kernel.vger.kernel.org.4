Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59136649E8C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 13:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbiLLMTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 07:19:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiLLMTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 07:19:43 -0500
Received: from smtp-42ae.mail.infomaniak.ch (smtp-42ae.mail.infomaniak.ch [IPv6:2001:1600:4:17::42ae])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7855FCE
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 04:19:41 -0800 (PST)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4NW10947WVzMpvRQ;
        Mon, 12 Dec 2022 13:19:37 +0100 (CET)
Received: from localhost (unknown [23.97.221.149])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4NW1090nXrzMptmf;
        Mon, 12 Dec 2022 13:19:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1670847577;
        bh=+8HUJm/3k6xDNGEdfLjboNwcxufcrgs95IkLGAAQ9tk=;
        h=From:To:Cc:Subject:Date:From;
        b=XK3Fjhx7apuP7njgW4dejqn1MfR71/tIm+/tTpwCvjpcmeUQ0hzY+Cv4gXJdSStQ7
         sKwPm80lhTBqduWFRlkQ3X6JVJFBwQ1vhxMvpM4aceeMeCSdzYquWjsZNYJJlCQsCN
         ph3NHtvWlIz911FOlumYSZf6L3Do/eh12AZyKurs=
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Alejandro Colomar <alx.manpages@gmail.com>,
        =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [GIT PULL] Landlock updates for v6.2
Date:   Mon, 12 Dec 2022 13:19:18 +0100
Message-Id: <20221212121918.1315195-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This PR adds file truncation support to Landlock, contributed by
Günther Noack:
https://lore.kernel.org/r/20221018182216.301684-1-gnoack3000@gmail.com
Please pull this Landlock changes for v6.2-rc1 .  These 12 commits
merged cleanly with your tree, and have been successfully tested in the
latest linux-next releases for more than a month.

As described by Günther, the goal of these patches is to work towards a
more complete coverage of file system operations that are restrictable
with Landlock.  The known set of currently unsupported file system
operations in Landlock is described here:
https://www.kernel.org/doc/html/v6.1/userspace-api/landlock.html#filesystem-flags
Out of the operations listed there, truncate is the only one that
modifies file contents, so these patches should make it possible to
prevent the direct modification of file contents with Landlock.

The new LANDLOCK_ACCESS_FS_TRUNCATE access right covers both the
truncate(2) and ftruncate(2) families of syscalls, as well as open(2)
with the O_TRUNC flag.  This includes usages of creat() in the case
where existing regular files are overwritten.

Additionally, this patch set introduces a new Landlock security blob
associated with opened files, to track the available Landlock access
rights at the time of opening the file. This is in line with Unix's
general approach of checking the read and write permissions during
open(), and associating this previously checked authorization with the
opened file.  An ongoing patch documents this use case:
https://lore.kernel.org/r/20221209193813.972012-1-mic@digikod.net

In order to treat truncate(2) and ftruncate(2) calls differently in an
LSM hook, we split apart the existing security_path_truncate hook into
security_path_truncate (for truncation by path) and
security_file_truncate (for truncation of previously opened files).

Test coverage for security/landlock is 94.7% of 835 lines according to
gcc/gcov-12, and it was 94.6% of 809 lines before this series.

syzkaller has been updated accordingly:
https://github.com/google/syzkaller/pull/3423
Such patched instance (tailored to Landlock) has been running for
months, covering all the new truncate-related code.

Regards,
 Mickaël

--
The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.2-rc1

for you to fetch changes up to f6e53fb2d7bd70547ba53232415976cb70ad6d97:

  samples/landlock: Document best-effort approach for LANDLOCK_ACCESS_FS_REFER (2022-11-07 20:49:50 +0100)

----------------------------------------------------------------
Landlock updates for v6.2-rc1

----------------------------------------------------------------
Günther Noack (12):
      security: Create file_truncate hook from path_truncate hook
      landlock: Refactor check_access_path_dual() into is_access_to_paths_allowed()
      landlock: Document init_layer_masks() helper
      landlock: Support file truncation
      selftests/landlock: Test file truncation support
      selftests/landlock: Test open() and ftruncate() in multiple scenarios
      selftests/landlock: Locally define __maybe_unused
      selftests/landlock: Test FD passing from restricted to unrestricted processes
      selftests/landlock: Test ftruncate on FDs created by memfd_create(2)
      samples/landlock: Extend sample tool to support LANDLOCK_ACCESS_FS_TRUNCATE
      landlock: Document Landlock's file truncation support
      samples/landlock: Document best-effort approach for LANDLOCK_ACCESS_FS_REFER

 Documentation/userspace-api/landlock.rst     |  67 +++-
 fs/namei.c                                   |   2 +-
 fs/open.c                                    |   2 +-
 include/linux/lsm_hook_defs.h                |   1 +
 include/linux/lsm_hooks.h                    |  10 +-
 include/linux/security.h                     |   6 +
 include/uapi/linux/landlock.h                |  21 +-
 samples/landlock/sandboxer.c                 |  29 +-
 security/apparmor/lsm.c                      |   6 +
 security/landlock/fs.c                       | 206 +++++++++---
 security/landlock/fs.h                       |  24 ++
 security/landlock/limits.h                   |   2 +-
 security/landlock/setup.c                    |   1 +
 security/landlock/syscalls.c                 |   2 +-
 security/security.c                          |  16 +-
 security/tomoyo/tomoyo.c                     |  13 +
 tools/testing/selftests/landlock/base_test.c |  38 +--
 tools/testing/selftests/landlock/common.h    |  85 ++++-
 tools/testing/selftests/landlock/fs_test.c   | 468 ++++++++++++++++++++++++++-
 19 files changed, 878 insertions(+), 121 deletions(-)
