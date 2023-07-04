Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1398F747567
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 17:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbjGDPhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 11:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjGDPhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 11:37:10 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9433E42
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 08:37:07 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-307d58b3efbso6323205f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 08:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688485026; x=1691077026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xYU6FV+tdrN3Ch4uMmiUU7E7nNyzdltSIAIHnlX+ZvQ=;
        b=IiZjZdrYhs6+K13xm1zPyve+5xwtTJjobqjkxhkhcOlMcQL+QVY8bsW+nC35ZXwjq7
         dtMe2y4VDBO7WAeFzrsun5RDmquFvO1yw6wIhTKA3cHa+RJz5dxQlhN5M+Clv2Z+Fvux
         FtqLoUisgiqxHgF/S3balRtaAjxxHVDFZiFS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688485026; x=1691077026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xYU6FV+tdrN3Ch4uMmiUU7E7nNyzdltSIAIHnlX+ZvQ=;
        b=YDOkFVqsiMI+MBbgN4qyVb6YaWJJr97bQZDOAN36bOWnvPKyh6D6h9E8Sa1R2XQDmy
         9d65HM2qnltVn0g/ECDBJTKg4pMdb4idjDXmfIrncIuQp13YiidXHiwj2u4dKMxjfM2A
         TsEoz/4pQdQzunUsGcdPE88dJ5tfHrb99dbywMLC/67AcQqlFcyJuVYtrVFBh1W3OxRz
         fKwhp+EQlpI+QL1hSz4l1I7rw+EHnWWuPt7IQANfOPsnosKZzWa2aVIw+coGrWh2zD7b
         44vEiiCT6LmEqslN5UwdO68U+iS/1V2JRLpFLppEFT4VL8XNtr29FZMXnH2FfU4X4dgn
         t8lg==
X-Gm-Message-State: ABy/qLYGPSgTHRDNntX3SGu/kZLFlpUXKj58k9yfCH0tbrD4FrPAT+cT
        6GCaJU37ElJkRMB30dn1FAdGStkCJrPMzVlBKy4=
X-Google-Smtp-Source: APBJJlFFDCa+GFWCozmKBUoO7cIKRPyQRH6umkZmRHRacyzlW3gV5wCKXVrXd/Ccnk3WI1nNYXb/Og==
X-Received: by 2002:a5d:4742:0:b0:313:f347:eea0 with SMTP id o2-20020a5d4742000000b00313f347eea0mr10849843wrs.60.1688485025675;
        Tue, 04 Jul 2023 08:37:05 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:99b2:81bb:8407:5369])
        by smtp.gmail.com with ESMTPSA id b2-20020adfde02000000b0030c4d8930b1sm28538709wrm.91.2023.07.04.08.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 08:37:05 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, catalin.marinas@arm.com,
        anshuman.khandual@arm.com, joey.gouly@arm.com, mhocko@suse.com,
        keescook@chromium.org, david@redhat.com, peterx@redhat.com,
        izbyshev@ispras.ru, broonie@kernel.org, szabolcs.nagy@arm.com,
        kpsingh@kernel.org, gthelen@google.com, toiwoton@gmail.com,
        Florent Revest <revest@chromium.org>
Subject: [PATCH v3 0/5] MDWE without inheritance
Date:   Tue,  4 Jul 2023 17:36:24 +0200
Message-ID: <20230704153630.1591122-1-revest@chromium.org>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
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

Diff since v2:
- Turned the MMF_INIT_FLAGS macro into a mmf_init_flags function as suggested by
  David Hildenbrand
- Removed the ability to transition from to PR_MDWE_REFUSE_EXEC_GAIN from
  (PR_MDWE_REFUSE_EXEC_GAIN | PR_MDWE_NO_INHERIT) which also significantly
  simplifies the prctl_set_mdwe logic
- Cc-ed -stable on patch 3 as suggested by Alexey Izbyshev
- Added a handful of Reviewed-by/Acked-by trailers

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
 kernel/sys.c                           |  32 +++++--
 tools/include/uapi/linux/prctl.h       |   3 +-
 tools/testing/selftests/mm/mdwe_test.c | 113 +++++++++++++++++++++----
 6 files changed, 139 insertions(+), 24 deletions(-)

-- 
2.41.0.255.g8b1d071c50-goog

