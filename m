Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBB5718E16
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 00:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbjEaWIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 18:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbjEaWIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 18:08:36 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D601B7
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 15:08:18 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-3f7fd59bb13so57674841cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 15:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1685570897; x=1688162897;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a9UmohLXWQfSsyaexxE0Gnc7j5lYDh6s2uLniOqWFR8=;
        b=maER3qwKrfySMzpZBIGNPSz0QucIMJOWJ/8tXglPc9i7Eku9bOpQiPUJnfXjKF78uU
         CQpfI7d5My1BnbVmZo1nSUnkPn4GtVqJG9hnLkY7GlpqDc8M5bx5nWL4TJAiebzPUX09
         otCg7pZYzL0vgu0/5rXeR00m+NAgieXxUZy+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685570897; x=1688162897;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a9UmohLXWQfSsyaexxE0Gnc7j5lYDh6s2uLniOqWFR8=;
        b=kpiGYQ1cqLMvzRQtSyE6qF/xJqe/jUcG0Tco3dXw7Ui025BrhIucRFEHl6xSDwHdCk
         QbAj7r4AeTIpzZF+D+1PPPPwziVtfF3S3+/f5UYWVdJ3k6qMe2TdSc0SqPB8544Fi4SC
         /soWJ8WScfFt/M5eqMtGI5oexJNPr6BUqG4dv518ugYbQiW1QuOGo9s6nL9X4wmuidTc
         ZvN10hcu13LRX/lBy/2hRYjzdXuWZL9yogmLPXL1GN7OvvajcQY3kuRM8tpbL6rpbWXF
         wWqWl1OP6Ub/YCgvnNqMms61DQi8Ckbj+h8B2SjRYM5qwdqZaIv5xgTIyXjoMp/0i51q
         QidA==
X-Gm-Message-State: AC+VfDwjRi8oSLPGYnXk9rQ7DtlkN7BBrzFXFanZ89TwQjsGfuleM46u
        s4GTYe+XYj03ZiPdqxRZ3/DXmEstU1HVJ+9AD5g=
X-Google-Smtp-Source: ACHHUZ4KJUIxH9kd325Fiaf0aLOebkiLTME5jx55cOnJ2WGeirOZcbDBH1RpvtjvBg3BOaOH0jDlUQ==
X-Received: by 2002:ac8:594d:0:b0:3f3:9240:3265 with SMTP id 13-20020ac8594d000000b003f392403265mr8248942qtz.49.1685570896987;
        Wed, 31 May 2023 15:08:16 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id f2-20020ac87f02000000b003f6b0f4126fsm6666172qtk.8.2023.05.31.15.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 15:08:16 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Kirill A Shutemov <kirill@shutemov.name>,
        "Liam R. Howlett" <liam.howlett@oracle.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Vineeth Pillai <vineeth@bitbyteword.org>
Subject: [PATCH v4 0/7] Optimize mremap during mutual alignment within PMD
Date:   Wed, 31 May 2023 22:08:00 +0000
Message-ID: <20230531220807.2048037-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Here is v4 of the mremap start address optimization / fix for exec warning.  It
took me a while to write a test that catches the issue me/Linus discussed in
the last version. And I verified kernel crashes without the check. See below.

The main changes in this series is:
Care to be taken to move purely within a VMA, in other words this check
   in call_align_down():
    if (vma->vm_start != addr_masked)
            return false;

    As an example of why this is needed:
    Consider the following range which is 2MB aligned and is
    a part of a larger 10MB range which is not shown. Each
    character is 256KB below making the source and destination
    2MB each. The lower case letters are moved (s to d) and the
    upper case letters are not moved.

    |DDDDddddSSSSssss|

    If we align down 'ssss' to start from the 'SSSS', we will end up destroying
    SSSS. The above if statement prevents that and I verified it.

    I also added a test for this in the last patch.

History of patches
==================
v3->v4:
1. Make sure to check address to align is beginning of VMA
2. Add test to check this (test fails with a kernel crash if we don't do this).

v2->v3:
1. Masked address was stored in int, fixed it to unsigned long to avoid truncation.
2. We now handle moves happening purely within a VMA, a new test is added to handle this.
3. More code comments.

v1->v2:
1. Trigger the optimization for mremaps smaller than a PMD. I tested by tracing
that it works correctly.

2. Fix issue with bogus return value found by Linus if we broke out of the
above loop for the first PMD itself.

v1: Initial RFC.

Description of patches
======================
These patches optimizes the start addresses in move_page_tables() and tests the
changes. It addresses a warning [1] that occurs due to a downward, overlapping
move on a mutually-aligned offset within a PMD during exec. By initiating the
copy process at the PMD level when such alignment is present, we can prevent
this warning and speed up the copying process at the same time. Linus Torvalds
suggested this idea.

Please check the individual patches for more details.

thanks,

 - Joel

[1] https://lore.kernel.org/all/ZB2GTBD%2FLWTrkOiO@dhcp22.suse.cz/

Joel Fernandes (Google) (7):
mm/mremap: Optimize the start addresses in move_page_tables()
mm/mremap: Allow moves within the same VMA for stack
selftests: mm: Fix failure case when new remap region was not found
selftests: mm: Add a test for mutually aligned moves > PMD size
selftests: mm: Add a test for remapping to area immediately after
existing mapping
selftests: mm: Add a test for remapping within a range
selftests: mm: Add a test for moving from an offset from start of
mapping

fs/exec.c                                |   2 +-
include/linux/mm.h                       |   2 +-
mm/mremap.c                              |  63 ++++-
tools/testing/selftests/mm/mremap_test.c | 301 +++++++++++++++++++----
4 files changed, 319 insertions(+), 49 deletions(-)

--
2.41.0.rc2.161.g9c6817b8e7-goog

