Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69BB66A2514
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 00:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjBXXbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 18:31:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjBXXbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 18:31:41 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4784C6DD93;
        Fri, 24 Feb 2023 15:31:39 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id h14so1071667plf.10;
        Fri, 24 Feb 2023 15:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iLqpTAJ2zI/UpBIrfmjrHQ5czCGNvbt8KQT4ojOnXBw=;
        b=oMYJOYyd4hp3MTtQmnuUggOtO92lYNfXm1Fd+hJkfgQug+r1/I9QY3MXPeZzIn/E8V
         ghLOMkxT1S2yFSZzC98Z4KVUMKzjeLc2Tg1ZExLlsqLFXOdL+iTHjoQH7KDXi1K5L64b
         f9NUNCsMhPtXPsk6z5m9ftaOX8DmSoAieDmfj5Re+7JQVYtff53mVhWKuZZkgibS1lTt
         Ye7opJXaEDdZSxd05NFylVwsJw1sov2HdTfLlQl4fljy09GZDvwvqOEgo3M9sbu65o4g
         CB3ThMKbCDu56fTdO+mtBwR12lzQtKkR/Djt/Zfw+m1corStVGQN/MRSazTkIIAe6RTc
         fJrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iLqpTAJ2zI/UpBIrfmjrHQ5czCGNvbt8KQT4ojOnXBw=;
        b=u4NL2+JObeSat/FUVxY4dl0pslR0DHM2aPxzSUklOOIVHOpklP4MpHIuha2icLzszX
         ymSIjNaucfh3mYFhy98xlRb8K6PM4UOqsc5eXJzoF9ypMBU/STJyBiq8fkVT2EMwlxVC
         rJUb6DUkYx33659+azIUhsWzMuKdIf6MERrRlRFCMOFNfJhUaydZzXRa7FwRr/tpZqWy
         ViGpVlLw9geMX8Vj/xzAHPveoG3TzD8W776JgeHv3KtjzGcAa32fdJ+VBzhDjTS8cag+
         yVC/cgPdJRKioVxwvM7pUtpDSZmDJr+5ZQ5oGMl5aup3sDNTVD9r5Q8sDM8M8NgaYlca
         jwMQ==
X-Gm-Message-State: AO0yUKVfY2Irp/2+y3eUWsgoTULvPyI7M4/f3IljD1ngikmz5eDJnTi7
        5drjqOq6m48Gvy80Bd5Xd/leZlEGZJc7
X-Google-Smtp-Source: AK7set8jtgQGXwnbqt1UD/28ukFJjCzXH2LOfEgXleC84u6NCyNigWRoM8EvwBotz9tezA/y3fvnCA==
X-Received: by 2002:a17:902:6bc4:b0:19c:bd2c:b33b with SMTP id m4-20020a1709026bc400b0019cbd2cb33bmr5628851plt.11.1677281498514;
        Fri, 24 Feb 2023 15:31:38 -0800 (PST)
Received: from fedora.mshome.net ([104.184.156.161])
        by smtp.gmail.com with ESMTPSA id g2-20020a170902868200b0019a5aa7eab0sm59680plo.54.2023.02.24.15.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 15:31:38 -0800 (PST)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, oleg@redhat.com, avagin@gmail.com,
        peterz@infradead.org, luto@kernel.org, krisman@collabora.com,
        tglx@linutronix.de, corbet@lwn.net, shuah@kernel.org,
        Gregory Price <gregory.price@memverge.com>
Subject: [PATCH v12 0/3] Checkpoint Support for Syscall User Dispatch
Date:   Fri, 24 Feb 2023 18:31:23 -0500
Message-Id: <20230224233126.1936-1-gregory.price@memverge.com>
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

v12: split test into its own patch
     change from padding a u8 to using a u64
     casting issues
     checkpatch.pl

v11: backout complex compat code, change struct to more generic typing
     (padding to ensure struct size is the same in 32 compat)
     update selftest
     tested selftest on 64 machine and in 32-bit compat mode

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

[truncated version history]

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

- Selftest for the new feature

Gregory Price (3):
  syscall_user_dispatch: helper function to operate on given task
  ptrace,syscall_user_dispatch: checkpoint/restore support for SUD
  selftest,ptrace: Add selftest for syscall user dispatch config api

 .../admin-guide/syscall-user-dispatch.rst     |  4 ++
 include/linux/syscall_user_dispatch.h         | 18 +++++
 include/uapi/linux/ptrace.h                   | 29 ++++++++
 kernel/entry/syscall_user_dispatch.c          | 65 ++++++++++++++---
 kernel/ptrace.c                               |  9 +++
 tools/testing/selftests/ptrace/.gitignore     |  1 +
 tools/testing/selftests/ptrace/Makefile       |  2 +-
 tools/testing/selftests/ptrace/get_set_sud.c  | 72 +++++++++++++++++++
 8 files changed, 191 insertions(+), 9 deletions(-)
 create mode 100644 tools/testing/selftests/ptrace/get_set_sud.c

-- 
2.39.1

