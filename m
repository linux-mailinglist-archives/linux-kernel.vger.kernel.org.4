Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF1B6F707A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 19:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjEDRKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 13:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjEDRKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 13:10:11 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7A43A9E
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 10:10:09 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f1958d3a53so8170085e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 10:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683220208; x=1685812208;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cTpvEiosV1q0JWnkoeAHKjXmXojYH9L1RV1Ai4BYwtc=;
        b=HMvvC/c+u6SUB3jBk7xrcdUvj5q2RToJwmXxDE5z6sVZmnbqTbv6vuNLC4ZI3JY0+L
         Ft0j0CdooqcxCP7vQxASBQkyoqw5+JMCXmg2oztQ1c4Di3cLCTSHd6k74c4tB/C0niGL
         Mj2wqb7AKJ1ReiqLLRqU4KbU4zCvXM+pqvc7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683220208; x=1685812208;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cTpvEiosV1q0JWnkoeAHKjXmXojYH9L1RV1Ai4BYwtc=;
        b=e8TzxvkivAuaWH6WpQTBHA4+jHxOv2gc5LH+Nyu9r8PFPpewYEyGAdGc4avPp2MpkR
         qjqJJRgdGriy5yMii5UZ0ugCpxzXCY/FG8wfSY067bogVMdj5S4KA+BrDT9HtIRDOvPE
         HQFRy9CYSYONnZBFcs4+qxiHT3mAfO3l1s1gzUKK8/XDxNLKmt1mIXttgEBrivjHvCG6
         usaEjQyLE5Y1J/GnWm+Y9DHYJ24q5ub1ZCoKEsLff1NY+o5Y8iDTX6TEbjTfOngtv6vZ
         x1IMrmY+y7dh4f9+NBeYeoqpF05hfvSkuwd6WplzX/mxDR1FnLz1BfS4hqWlWkbf3NH2
         ZUMw==
X-Gm-Message-State: AC+VfDy7HQVnBQ9eQ5/gHrP+L0DTrYwnQ9LA6m7sahMGuUyfu9bFRuMr
        TjDxbvhhjm+SOaTEozVFiBXnIjZGoddjMWX8TPE=
X-Google-Smtp-Source: ACHHUZ5iyaumrXazVbcbVUI9hzdM/OgURD445vCG2tRGnCDFV4yqXhKLLF9ztuOsbnaKLoYPDkNjDQ==
X-Received: by 2002:a7b:c8c3:0:b0:3f2:5028:a558 with SMTP id f3-20020a7bc8c3000000b003f25028a558mr336713wml.0.1683220207691;
        Thu, 04 May 2023 10:10:07 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:c740:f74d:132c:ca99])
        by smtp.gmail.com with ESMTPSA id q3-20020a1cf303000000b003f3157988f8sm5447895wmq.26.2023.05.04.10.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 10:10:07 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, catalin.marinas@arm.com,
        anshuman.khandual@arm.com, joey.gouly@arm.com, mhocko@suse.com,
        keescook@chromium.org, david@redhat.com, peterx@redhat.com,
        izbyshev@ispras.ru, nd@arm.com, broonie@kernel.org,
        szabolcs.nagy@arm.com, Florent Revest <revest@chromium.org>
Subject: [PATCH 0/4] MDWE without inheritance
Date:   Thu,  4 May 2023 19:09:38 +0200
Message-ID: <20230504170942.822147-1-revest@chromium.org>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Florent Revest (4):
  kselftest: vm: Fix tabs/spaces inconsistency in the mdwe test
  kselftest: vm: Fix mdwe's mmap_FIXED test case
  mm: Add a NO_INHERIT flag to the PR_SET_MDWE prctl
  kselftest: vm: Add tests for no-inherit memory-deny-write-execute

 include/linux/mman.h                   |   8 +-
 include/linux/sched/coredump.h         |   1 +
 include/uapi/linux/prctl.h             |   1 +
 kernel/sys.c                           |  29 +++++--
 tools/include/uapi/linux/prctl.h       |   1 +
 tools/testing/selftests/mm/mdwe_test.c | 110 +++++++++++++++++++++----
 6 files changed, 128 insertions(+), 22 deletions(-)

-- 
2.40.1.495.gc816e09b53d-goog

