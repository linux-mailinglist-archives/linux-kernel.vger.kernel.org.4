Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8CA6447E9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 16:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234470AbiLFPYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 10:24:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233864AbiLFPYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 10:24:04 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521E4625E
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 07:24:03 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id k7so14231237pll.6
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 07:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BhBDV/Z8hnxkq5EH3sr+xFSqw/SOYTGLnS4fXDD4TjQ=;
        b=SBctdmIq9vpeD5W6TqrVMbea4gKdOk0Jih4JtPCsizppAMc49/K/3sgli3ZubFqZuV
         U632ldWmIyO3j2XBtoDocjZbpm5Wj9PAFhjQhZG3rf6sRYcmU+5CUPdwZMf82XN8KVSL
         hiqyrXxo90puX6vB3hKQJkMdu+fvacp0Ix01Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BhBDV/Z8hnxkq5EH3sr+xFSqw/SOYTGLnS4fXDD4TjQ=;
        b=jo7HS0AtBk2jkfkqN0/HigA9lvSQcywFQbAZlVPJchX9yv+MWhJjNKuf4znWqGu7c9
         a5WCe1ZXm1VvrIy9RgvCRwDWDiWpwx/ciFRbAcqTnhmF9BfFeKIlm5zyHpxx4xKGD16q
         uzWn3JmgHYfnoH7OrUZcoiqSvSLL7Jxl9MiF4APfyAFaIk14ZT+9G2Hqi0CJhTPX3a+7
         E1QLi9+KPFknPNYOwctPtyqU0B0P6vjpXKr1n5f7vzKhRHSbFhnwOM96iTNQdO9vhIw0
         B61tWol4c9ycx/uimSX773fj8a0ypEfmA8c6DOV9I+lQ7x+mYOx8BkJrapKO9Ojdf7Z5
         w3jQ==
X-Gm-Message-State: ANoB5pnETq3JfpwTSlHPJbj5Abn0711O17drQvNBLmdv5s1yWA/F4oDD
        +WMWOvpN2Fy12hFBdzCyDCZmjQ==
X-Google-Smtp-Source: AA0mqf7+5Iyukh0dKlyUSkV1K2prkVRnF+W+tb1TPIpwKHbNtttYKNMAKAznUSPSpjZ66hzxL4lnHQ==
X-Received: by 2002:a17:902:8606:b0:189:b0a3:cf52 with SMTP id f6-20020a170902860600b00189b0a3cf52mr27014480plo.41.1670340242779;
        Tue, 06 Dec 2022 07:24:02 -0800 (PST)
Received: from jeffxud.c.googlers.com.com (30.202.168.34.bc.googleusercontent.com. [34.168.202.30])
        by smtp.gmail.com with ESMTPSA id r25-20020a635d19000000b0046b1dabf9a8sm10004686pgb.70.2022.12.06.07.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 07:24:02 -0800 (PST)
From:   jeffxu@chromium.org
To:     skhan@linuxfoundation.org, keescook@chromium.org
Cc:     akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jeffxu@google.com,
        jorgelo@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jannh@google.com, linux-hardening@vger.kernel.org,
        Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v5 0/6] mm/memfd: introduce MFD_NOEXEC_SEAL and MFD_EXEC
Date:   Tue,  6 Dec 2022 15:23:52 +0000
Message-Id: <20221206152358.1966099-1-jeffxu@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Xu <jeffxu@chromium.org>

Since Linux introduced the memfd feature, memfd have always had their execute bit set, and the memfd_create() syscall doesn't allow setting it differently.

However, in a secure by default system, such as ChromeOS, (where all executables should come from the rootfs, which is protected by Verified boot), this executable nature of memfd opens a door for NoExec bypass and enables “confused deputy attack”.  E.g, in VRP bug [1]: cros_vm process created a memfd to share the content with an external process, however the memfd is overwritten and used for executing arbitrary code and root escalation. [2] lists more VRP in this kind.

On the other hand, executable memfd has its legit use, runc uses memfd’s seal and executable feature to copy the contents of the binary then execute them, for such system, we need a solution to differentiate runc's use of  executable memfds and an attacker's [3].

To address those above, this set of patches add following:
1> Let memfd_create() set X bit at creation time.
2> Let memfd to be sealed for modifying X bit.
3> A new pid namespace sysctl: vm.memfd_noexec to control behavior of X bit.  For example, if a container has vm.memfd_noexec=2, then memfd_create() without MFD_NOEXEC_SEAL will be rejected.
4> A new security hook in memfd_create(). This make it possible to a new LSM, which rejects or allows executable memfd based on its security policy.

This is V4 version of patch: see [4] [5] [6] for previous versions.

[1] https://crbug.com/1305411
[2] https://bugs.chromium.org/p/chromium/issues/list?q=type%3Dbug-security%20memfd%20escalation&can=1
[3] https://lwn.net/Articles/781013/
[4] https://lwn.net/Articles/890096/
[5] https://lore.kernel.org/lkml/20220805222126.142525-1-jeffxu@chromium.org/
[6] https://lore.kernel.org/lkml/20221202013404.163143-1-jeffxu@chromium.org/

Daniel Verkamp (2):
  mm/memfd: add F_SEAL_EXEC
  selftests/memfd: add tests for F_SEAL_EXEC

Jeff Xu (4):
  mm/memfd: add MFD_NOEXEC_SEAL and MFD_EXEC
  mm/memfd: Add write seals when apply SEAL_EXEC to executable memfd
  selftests/memfd: add tests for MFD_NOEXEC_SEAL MFD_EXEC
  mm/memfd: security hook for memfd_create

 include/linux/lsm_hook_defs.h              |   1 +
 include/linux/lsm_hooks.h                  |   4 +
 include/linux/pid_namespace.h              |  19 ++
 include/linux/security.h                   |   6 +
 include/uapi/linux/fcntl.h                 |   1 +
 include/uapi/linux/memfd.h                 |   4 +
 kernel/pid_namespace.c                     |  48 ++++
 mm/memfd.c                                 |  61 ++++-
 mm/shmem.c                                 |   6 +
 security/security.c                        |  13 +
 tools/testing/selftests/memfd/fuse_test.c  |   1 +
 tools/testing/selftests/memfd/memfd_test.c | 304 ++++++++++++++++++++-
 12 files changed, 465 insertions(+), 3 deletions(-)


base-commit: eb7081409f94a9a8608593d0fb63a1aa3d6f95d8
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

