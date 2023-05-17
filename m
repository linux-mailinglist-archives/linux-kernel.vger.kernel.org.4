Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC09706C16
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 17:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbjEQPFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 11:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbjEQPEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 11:04:35 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722BA9EE9
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 08:04:16 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f4449fa085so6125015e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 08:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684335825; x=1686927825;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ROoM+z1HUyIf7VmHaZw0Osm1LBJIPMGnhoCFAWKqLvQ=;
        b=H4NRL7fIWw72mEHCSKlHC9bEXT51taavHTPlu4pLVksZeccv4zGLtYVNIV36lvzXiA
         5DrTGLg1Rf7DedvAQXUKfRq7Ug6+IdfOEpKG9ZGu1VfUXI1NAB1a8pAc80nDzHmel1pE
         oMoptbsoDTg0m8spTjg6Y56dpGUOJwkJtqGNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684335825; x=1686927825;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ROoM+z1HUyIf7VmHaZw0Osm1LBJIPMGnhoCFAWKqLvQ=;
        b=CjF3JzVb4MkfOlnlxr27dfG3rBC+IKkuC47DvhYHSy1WhnG/LUQPVRWrCsAWQq1TxQ
         XsV8vqvFmo8kFB8jifq/CQrqfKeMu4RhmZfMksyEsjN/ctV0hwzbsNwo4jJgtzZvqnJe
         hqRnNYLZYKjtfXXU5YqR/2wRK4dWbMe0ldpZlVxwwPQx1yiFf82ivyZua5fniy1eXIlT
         lYNsvuTILTzjbOBEQAdfXdMx+jPfrinJhaFdcs213YS8NU/q0VgZ5JScKYOzBnmQwJex
         jdQGzN1jwS6dgLPqH+/hRQhfitkX5/1GK+ibLWNpKABXxmjIX+3+fRvlsvcQepp/ZcxS
         qW4A==
X-Gm-Message-State: AC+VfDyTouGNDxv/YHChw3E9QP0ykJJoiiqs6A4PXzpYi1AaLNzHX3s+
        xZur4b4EOrzJz2YizQYT/nEu6kilOByRSORab+E=
X-Google-Smtp-Source: ACHHUZ6ycuHhmW1jZ1USr9pnh4eCN+Ti51EByPtxjWBdLNzffroPKrrzDg9jaCqBPM38i+CuolJ+MQ==
X-Received: by 2002:a05:6000:1a4e:b0:306:37d9:201c with SMTP id t14-20020a0560001a4e00b0030637d9201cmr1145983wry.17.1684335824681;
        Wed, 17 May 2023 08:03:44 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:e223:a0c2:d2c:c371])
        by smtp.gmail.com with ESMTPSA id e17-20020adffd11000000b003047ea78b42sm3038211wrr.43.2023.05.17.08.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 08:03:43 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, catalin.marinas@arm.com,
        anshuman.khandual@arm.com, joey.gouly@arm.com, mhocko@suse.com,
        keescook@chromium.org, david@redhat.com, peterx@redhat.com,
        izbyshev@ispras.ru, broonie@kernel.org, szabolcs.nagy@arm.com,
        kpsingh@kernel.org, gthelen@google.com, toiwoton@gmail.com,
        Florent Revest <revest@chromium.org>
Subject: [PATCH v2 0/5] MDWE without inheritance
Date:   Wed, 17 May 2023 17:03:16 +0200
Message-ID: <20230517150321.2890206-1-revest@chromium.org>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joey recently introduced a Memory-Deny-Write-Executable (MDWE) prctl which tags
current with a flag that prevents pages that were previously not executable from
becoming executable.
This tag always gets inherited by children tasks. (it's in MMF_INIT_MASK)

At Google, we've been using a somewhat similar downstream patch for a few years
now. To make the adoption of this feature easier, we've had it support a mode in
which the W^X flag does not propagate to children. For example, this is handy if
a C process which wants W^X protection suspects it could start children
processes that would use a JIT.

I'd like to align our features with the upstream prctl. This series proposes a
new NO_INHERIT flag to the MDWE prctl to make this kind of adoption easier. It
sets a different flag in current that is not in MMF_INIT_MASK and which does not
propagate.

As part of looking into MDWE, I also fixed a couple of things in the MDWE test.

This series applies on the mm-everything-2023-05-16-23-30 tag of the mm tree:
  https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/

Diff since v1:
- MMF_HAS_MDWE_NO_INHERIT clears MMF_HAS_MDWE in the fork path as part of a
  MMF_INIT_FLAGS macro (suggested by Catalin)
- PR_MDWE_* are defined as unsigned long rather than int (suggested by Andrey)

Florent Revest (5):
  kselftest: vm: Fix tabs/spaces inconsistency in the mdwe test
  kselftest: vm: Fix mdwe's mmap_FIXED test case
  mm: Make PR_MDWE_REFUSE_EXEC_GAIN an unsigned long
  mm: Add a NO_INHERIT flag to the PR_SET_MDWE prctl
  kselftest: vm: Add tests for no-inherit memory-deny-write-execute

 include/linux/sched/coredump.h         |  10 +++
 include/uapi/linux/prctl.h             |   3 +-
 kernel/fork.c                          |   2 +-
 kernel/sys.c                           |  24 +++++-
 tools/include/uapi/linux/prctl.h       |   3 +-
 tools/testing/selftests/mm/mdwe_test.c | 110 +++++++++++++++++++++----
 6 files changed, 131 insertions(+), 21 deletions(-)

-- 
2.40.1.606.ga4b1b128d6-goog

