Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A0F695D94
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 09:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbjBNIw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 03:52:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjBNIwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 03:52:23 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D4DEB7F;
        Tue, 14 Feb 2023 00:52:22 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id f10so6066333ilc.7;
        Tue, 14 Feb 2023 00:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DeN21rgaXa7jth1ruUfZyaRjSjjuitBa69a7QcGsdR8=;
        b=QfltS80X6QTysG/FHWGPG0YkLSzovZlDg49QHa5BQIgxg5pOC54JnsZDtOCZ931pdn
         Vn3tvQMnP6seCELng1k6oOqbMxllFcUfFSTBdgqmGYtn4Swr8w9bNU+xUU6kr94ApZVZ
         Y+bQmg5rCJPbEcUObXiRVodxMDEZcRj/dkHmI1VYIgMp4JiOOXZ0welUbrGHnc+tLRBR
         5JR96UtTqfnzwNmic3vSwGk78VOOdCVk/NGtP7oN0L+XVZURikmKpXSMaSovIRz8DhaX
         EZpN+Wc6lLTL/6EhPPLd1rO0tolgPKjpIlqnCTwKipS53r8kcoSYR8aiugBllJH5df02
         0Ipg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DeN21rgaXa7jth1ruUfZyaRjSjjuitBa69a7QcGsdR8=;
        b=XHwtkxN8cPFkRHULJmlz2z/RXeqxaL8nzLLsMxD5R7fr/66sNK1bcgdWO1hu3ZJsFw
         rqHOBt4FL718ZQerH0PVja23ZfSZSrpdjF8TFtyKrKz7gXEHVaClvmVsTg7eU4O/wWy8
         z49q88+yf3r+7LreyEEmemTbfGLF3vZdAlbXI0G8ttCTSquOQqGxP8pStThPVPzhZv7u
         KGwNTlRdJU7ygIKTbD+HpYf11JEwnniDTTsWPPbWeHmeHKsUV0XKdNfK5NbyG3EhT2Lr
         Y5bv7fRyoUvgnfefqKJOsAG7gDAjVJ0iwml2krUsZTjN5o3fCC8Dw23BmZ0cUZjWVMXN
         s5/g==
X-Gm-Message-State: AO0yUKWxdGy7CXff0Gecz3/q7lUlKhksDasUQgDvXn8qEqBSc2HtDl4z
        F4GPUR62saBya1Mnqn+6mAjKoZKXiGgyGXI=
X-Google-Smtp-Source: AK7set/5lhUANuge49Lf4Wut/RyTQz8x6zV/5awLWpwIcNtR6PY54WxGvvsDam7Cz19tKA9KcuPYSA==
X-Received: by 2002:a05:6e02:1d9e:b0:313:ce4b:a435 with SMTP id h30-20020a056e021d9e00b00313ce4ba435mr1514621ila.25.1676364741667;
        Tue, 14 Feb 2023 00:52:21 -0800 (PST)
Received: from fedora.mshome.net ([104.184.156.161])
        by smtp.gmail.com with ESMTPSA id j11-20020a056e02014b00b0031406a0e1c0sm903434ilr.57.2023.02.14.00.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 00:52:21 -0800 (PST)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, oleg@redhat.com, avagin@gmail.com,
        peterz@infradead.org, luto@kernel.org, krisman@collabora.com,
        tglx@linutronix.de, corbet@lwn.net, shuah@kernel.org,
        Gregory Price <gregory.price@memverge.com>
Subject: [PATCH 0/2] Checkpoint Support for Syscall User Dispatch
Date:   Tue, 14 Feb 2023 03:52:13 -0500
Message-Id: <20230214085215.106708-1-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v10: move refactor code into patch ahead of change
     add compat support
     documentation change

v9: tglx feedback
    whitespace
    documentation of ptrace struct
    shorten struct name
    helper function for set_syscall_user_dispatch
    use task variant of set/clear_syscall_work
    use task variant of test_syscall_work in getter
    selftest

v8: fix include issue   Reported-by: kernel test robot <lkp@intel.com>
    summary:
    +++ b/kernel/entry/syscall_user_dispatch.c
    + include <linux/ptrace.h>

v7: drop ptrace suspend flag, not required
    hanging unreferenced variable
                whitespace

v6: drop fs/proc/array update, it's not needed
    drop on_dispatch field exposure in config structure, it's not
    checkpoint relevant.
    (Thank you for the reviews Oleg and Andrei)

v5: automated test for !defined(GENERIC_ENTRY) failed, fix fs/proc
    use ifdef for GENERIC_ENTRY || TIF_SYSCALL_USER_DISPATCH
    note: syscall user dispatch is not presently supported for
          non-generic entry, but could be implemented. question is
          whether the TIF_ define should be carved out now or then

v4: Whitespace
    s/CHECKPOINT_RESTART/CHECKPOINT_RESUME
    check test_syscall_work(SYSCALL_USER_DISPATCH) to determine if it's
    turned on or not in fs/proc/array and getter interface

v3: Kernel test robot static function fix
    Whitespace nitpicks

v2: Implements the getter/setter interface in ptrace rather than prctl

Syscall user dispatch makes it possible to cleanly intercept system
calls from user-land.  However, most transparent checkpoint software
presently leverages some combination of ptrace and system call
injection to place software in a ready-to-checkpoint state.

If Syscall User Dispatch is enabled at the time of being quiesced,
injected system calls will subsequently be interposed upon and
dispatched to the task's signal handler.

Patch summary:
- Refactor configuration setting interface to operate on a task
  rather than current, so the set and error paths can be consolidated

- Implement a getter interface for Syscall User Dispatch config info.
  To resume successfully, the checkpoint/resume software has to
  save and restore this information.  Presently this configuration
  is write-only, with no way for C/R software to save it.

  This was done in ptrace because syscall user dispatch is not part of
  uapi. The syscall_user_dispatch_config structure was added to the
  ptrace exports.


Gregory Price (2):
  syscall_user_dispatch: helper function to operate on given task
  ptrace,syscall_user_dispatch: checkpoint/restore support for SUD

 .../admin-guide/syscall-user-dispatch.rst     |   4 +
 include/linux/compat.h                        |   7 ++
 include/linux/syscall_user_dispatch.h         |  18 +++
 include/uapi/linux/ptrace.h                   |  29 +++++
 kernel/entry/syscall_user_dispatch.c          | 106 ++++++++++++++++--
 kernel/ptrace.c                               |   9 ++
 tools/testing/selftests/ptrace/.gitignore     |   1 +
 tools/testing/selftests/ptrace/Makefile       |   2 +-
 tools/testing/selftests/ptrace/get_set_sud.c  |  77 +++++++++++++
 9 files changed, 244 insertions(+), 9 deletions(-)
 create mode 100644 tools/testing/selftests/ptrace/get_set_sud.c

-- 
2.39.1

