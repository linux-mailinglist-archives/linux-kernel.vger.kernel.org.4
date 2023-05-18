Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE5C170864B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 19:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjERRAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 13:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjERRAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 13:00:51 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D7019A
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 10:00:49 -0700 (PDT)
X-QQ-mid: bizesmtp74t1684429236tgelvkjl
Received: from linux-lab-host.localdomain ( [119.123.131.162])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 19 May 2023 01:00:35 +0800 (CST)
X-QQ-SSF: 01200000000000C0V000000A0000000
X-QQ-FEAT: pauNAy/IFzO0FaQLOne96cFwWdA59Rv4ZuUqOLkZM5vji7bwoCZfS5oHPCMNR
        48M0RE4xcp7ioGHPUTFDmgZNOj8L11HPDeSMZPI0b90K7Jv+Nh32m0kmQ/2eJDuBvjU0nqD
        rxRFk0z2JlwsVGj4O80PV9hisxKncI9YGz+2lJz8YJD6bD5Y9UciT6oVEee6jfpaq2bfKEA
        HrD0t1VI81q3uNLbr20tgc4tHuur1dy5sG9LiLuwTGWsdB+Ran0iTH52kg5yFFbiLmaHExg
        827Tca72h1Yfy+ko7CRNn0mNtrcWNhrkvV0LKlT9CQZGKoU3nBQ6UtJRYrfJm5RWfHgD2cs
        y77EH3kjkfWGDxkRos=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4878818344533688938
From:   Zhangjin Wu <falcon@tinylab.org>
To:     Willy Tarreau <w@1wt.eu>, Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zhangjin Wu <falcon@tinylab.org>
Subject: [PATCH 0/2] tools/nolibc: riscv: Fix up compile error for rv32
Date:   Fri, 19 May 2023 01:00:18 +0800
Message-Id: <cover.1684425792.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Willy

nolibc for riscv is only tested for rv64 currently (see
tools/testing/selftests/nolibc/Makefile), this patchset tries to let it
compile for rv32, but still not pass the nolibc selftest:

* The first patch uses lw/sw instead of ld/sd for rv32 and verse-vice for rv64
    * This patch may conflict with the stackprotector patch [1], because
      both of them changed the _start assembly in arch-riscv.h

* The second patch adds __NR_llseek based sys_lseek implementation for rv32
    * There is no __NR_lseek for rv32, see include/uapi/asm-generic/unistd.h
    * This code is based on the version from glibc, sysdeps/unix/sysv/linux/lseek.c
    * It passed the two lseek tests in nolibc selftest (write a test case manually)

* To let it compile for rv32, we still need to apply one of such actions:
    * Revert the kernel commit d4c08b9776b3 ("riscv: Use latest system call ABI"),
      but it is not the right direction, that commit has removed all of the time32 syscalls,
      and let C lib (e.g. glibc) provide the same C APIs based on the other time64 syscalls

    * If not really use any of the time32 syscalls, defining __ARCH_WANT_TIME32_SYSCALLS
      macro will let it compile, but this is buggy for the current implmentations are based
      on time32 syscalls!

    * Really implement the C APIs for rv32, based on the time64 syscalls, just like glibc.
      This commit c8ce48f06503 ("asm-generic: Make time32 syscall numbers optional") shows
      us which functions should be re-implemented.

So, the work todo for rv32 is:

* Rebasing all of the old time32 syscalls based C APIs on the new time64 syscalls,
  but they are not simply mapped one by one, glibc is a good reference.

* Add standalone rv32 test support in tools/testing/selftests/nolibc/

Best Regards,
Zhangjin Wu

[1]: https://lore.kernel.org/linux-riscv/mhng-1ec176a9-ec5d-470b-a278-a4e9cec728a8@palmer-ri-x1c9a/

Zhangjin Wu (2):
  tools/nolibc: riscv: Fix up load/store instructions for rv32
  tools/nolibc: riscv: Support __NR_llseek for rv32

 tools/include/nolibc/arch-riscv.h | 14 +++++++++-----
 tools/include/nolibc/std.h        |  1 +
 tools/include/nolibc/sys.h        | 19 +++++++++++++++++++
 3 files changed, 29 insertions(+), 5 deletions(-)

-- 
2.25.1


