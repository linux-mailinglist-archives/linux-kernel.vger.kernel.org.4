Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1843869E8F4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 21:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjBUUSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 15:18:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjBUUSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 15:18:16 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E6E27D48;
        Tue, 21 Feb 2023 12:18:15 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id t13so5652316wrv.13;
        Tue, 21 Feb 2023 12:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aaXijHFfh5JmH6oiYnhG/cfQQV+cAi30CCahAJCA94U=;
        b=Zm1QqxWUwm1O8h3kZh7X+MG181OJaOX2xJgjWAYm0psTGvs48vMtoPCIZqnT6yVHay
         a8G9X4ez2Fsww5YeJq5TP3UMFpr51+65qbdKTmmal6+qv4CSpLWJuSaFXbLZTsAskXfY
         wDvWedIVtpihVZs7/EqOpGlSWt41zm11AEjw68Km80SKKD5McuBojtODaM22Skam6hCu
         +Jxh+1v680zVO0doVymWeLpzQX2RriklcwYjuYE62SwKqFdxSwCAABAK+ZVJQ2JNHOZB
         eveN29QKR+Ro6WP+I7T7azUdtgQcA7GtOJq3ZVAdo1BXSOLKbBFU37chocY9avFD3YVM
         tEew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aaXijHFfh5JmH6oiYnhG/cfQQV+cAi30CCahAJCA94U=;
        b=2nfRV9+ppxZcj7SIid48wUsGfOvCSL9BdpTK9MOmkWpvrlefnFnTj7BIDQ7UUIFjc+
         ncH5AhE1vsE+BmGt6i06AJdHuB6MB9AAVq9sLN5Z6J3NjedUbeXdnGW6IdI9jMTGBNIv
         Nr8kbUJtvU9Cgca+LTgK3e2jYDx1Be5e+nsHjAA3iNeogmqaoWV2vz3TVT7M+EyVla9j
         SJz0t1ZKTje19QXbqAvoZnQEUbk3JnZ6XlIlqNpfJhlalpPOBmesblYcVoHlRN4QJFyP
         n22ZjJE0ILJYvakEw1+LpJNhafrtojG5iTLg5VrFQSUv8tL7FuvfXVp316sQMO+wLYQD
         zoiA==
X-Gm-Message-State: AO0yUKXtDdIXblDgFIHhEevOLoGYedYvEvfJsc7K7MOcNtCnlPpQQtlN
        Sb7bf4+5pOTfUlbACEUqRvjq757b7rX/
X-Google-Smtp-Source: AK7set/EJeK6XUwVOjtGGahM9cXUxo2O7RyPR+KpWBtj4Iw0ArZLzgSgjhykunYOI0wiAofiZApTlg==
X-Received: by 2002:adf:cf06:0:b0:2bf:d285:b787 with SMTP id o6-20020adfcf06000000b002bfd285b787mr4770313wrj.56.1677010693201;
        Tue, 21 Feb 2023 12:18:13 -0800 (PST)
Received: from fedora.mshome.net ([104.184.156.161])
        by smtp.gmail.com with ESMTPSA id u14-20020a5d434e000000b002c5a1bd527dsm4656080wrr.96.2023.02.21.12.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 12:18:12 -0800 (PST)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, oleg@redhat.com, avagin@gmail.com,
        peterz@infradead.org, luto@kernel.org, krisman@collabora.com,
        tglx@linutronix.de, corbet@lwn.net, shuah@kernel.org,
        Gregory Price <gregory.price@memverge.com>
Subject: [PATCH v11 0/2] Checkpoint Support for Syscall User Dispatch
Date:   Tue, 21 Feb 2023 15:17:40 -0500
Message-Id: <20230221201740.2236-1-gregory.price@memverge.com>
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

 .../admin-guide/syscall-user-dispatch.rst     |  4 +
 include/linux/syscall_user_dispatch.h         | 18 +++++
 include/uapi/linux/ptrace.h                   | 30 ++++++++
 kernel/entry/syscall_user_dispatch.c          | 63 +++++++++++++--
 kernel/ptrace.c                               |  9 +++
 tools/testing/selftests/ptrace/.gitignore     |  1 +
 tools/testing/selftests/ptrace/Makefile       |  2 +-
 tools/testing/selftests/ptrace/get_set_sud.c  | 77 +++++++++++++++++++
 8 files changed, 195 insertions(+), 9 deletions(-)
 create mode 100644 tools/testing/selftests/ptrace/get_set_sud.c

-- 
2.39.1

