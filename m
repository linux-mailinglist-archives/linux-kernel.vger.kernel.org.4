Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7156C339A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 15:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbjCUOEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 10:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjCUOEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 10:04:38 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C32166C1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 07:04:36 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id p16so9634326wmq.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 07:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679407475;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Eyc9M815DDWPE+a5iQ5MddjThl1AbQtLO2yVDEfZLUY=;
        b=GXjeLkvKjytTCw5uvgmOTPE72dJ3RoJKaN4OhBTYpmZH634OeIJ9U9cmpyukPU8pf2
         p8z8E2TpYumBVVrBbBaHDwvUeaUd79xpcPLLvl3WT2i2BfepOcb+8fAFNrfBc65/QV4i
         bTRYMbd1T8XGBarkJrOeUnNdwTh26TkUUqe1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679407475;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Eyc9M815DDWPE+a5iQ5MddjThl1AbQtLO2yVDEfZLUY=;
        b=JSVdykNFutU5jWDySZVhoh7abuFa7rZi5YBIq/NVIh0QfSSSj0rerr/5dLey5g7Kwc
         dfyHdvWREUsPCwN1V2yg3sMMFzLx7pHNRD+qmCP96n85EpOGHgJFrTSRFFRTZg7Pdsi/
         TZRUZTdfEL/jdQGFL1ds5feQhmyLavWJYmWNAM2gPyvsPRS/T8ZU/dWzS8CneZ3gb8H2
         Qi7oCH6VhYer9H+8qH1yj7cNhres9RbQ16ym7owPklkyyfoToVp70VBdCIxdg721dCBD
         Vmm22q4+JTQh2QwBEuIeNi64+kam4OcjxjMyC8FXCpy4n7gonrveOfYxY8Z3k3NBr/HL
         2T+A==
X-Gm-Message-State: AO0yUKVFG/2zVObW9pxLWs7zLWVpMkZDB9NKeUU2D1H5CR101eomTros
        Drn1ubl2Amrr8wKAsj+POhEiLq4yXxqLVKemEd0=
X-Google-Smtp-Source: AK7set+y3+a5NcLXFa6wVgIOm4MXUQFs8Vfjy2+3xjt1w+J7OQdgRVkS4bb9JL2mGu6q6T1ODgPuuw==
X-Received: by 2002:a1c:f210:0:b0:3eb:39e0:3530 with SMTP id s16-20020a1cf210000000b003eb39e03530mr2480006wmc.41.1679407474866;
        Tue, 21 Mar 2023 07:04:34 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:4b8c:8b16:90d:8d9a])
        by smtp.gmail.com with ESMTPSA id f12-20020a1cc90c000000b003e20cf0408esm13620896wmb.40.2023.03.21.07.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 07:04:34 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     rostedt@goodmis.org, mhiramat@kernel.org, mark.rutland@arm.com,
        ast@kernel.org, daniel@iogearbox.net, kpsingh@kernel.org,
        revest@chromium.org, jolsa@kernel.org
Subject: [PATCH v2 0/7] Refactor ftrace direct call APIs
Date:   Tue, 21 Mar 2023 15:04:17 +0100
Message-Id: <20230321140424.345218-1-revest@chromium.org>
X-Mailer: git-send-email 2.40.0.rc2.332.ga46443480c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Differences since v1 [1]:
- Use a READ_ONCE() to read the direct call address in call_direct_funcs
- Added an Acked-by from Mark

This series refactors ftrace direct call APIs in preparation for arm64 support.
It is roughly a subset of [2] rebased on v6.3-rc2 and meant to be taken by
Steven's tree before all the arm64 specific bits.

The first patch was suggested by Steven in a review of [1], it makes it more
obvious to the caller that filters probably need to be freed when unregistering
a direct call.

The next three patches consolidate the two existing ftrace APIs for registering
direct calls. They are only split to make the reviewer's life easier.
Currently, there is both a _ftrace_direct and _ftrace_direct_multi API. Apart
from samples and selftests, there are no users of the _ftrace_direct API left
in-tree so this deletes it and renames the _ftrace_direct_multi API to
_ftrace_direct for simplicity.

The main benefit of this refactoring is that, with the API that's left, an
ftrace_ops backing a direct call will only ever point to one direct call. We can
therefore store the direct called trampoline address in the ops (patch 5) and,
in the future arm64 series, look it up from the ftrace trampoline. (in the
meantime, it makes call_direct_funcs a bit simpler too)

Ftrace direct calls technically don't need DYNAMIC_FTRACE_WITH_REGS so this
extends its support to DYNAMIC_FTRACE_WITH_ARGS (patch 6). arm64 won't support
DYNAMIC_FTRACE_WITH_REGS.

Finally, it fixes the ABI of the stub direct call trampoline used in ftrace
selftests.

This has been tested on x86_64 with:
1- CONFIG_FTRACE_SELFTEST
2- samples/ftrace/*.ko

1: https://lore.kernel.org/all/20230316173811.1223508-1-revest@chromium.org/T/#t
2: https://lore.kernel.org/all/20230207182135.2671106-1-revest@chromium.org/T/#t

Florent Revest (6):
  ftrace: Let unregister_ftrace_direct_multi() call ftrace_free_filter()
  ftrace: Replace uses of _ftrace_direct APIs with _ftrace_direct_multi
  ftrace: Remove the legacy _ftrace_direct API
  ftrace: Rename _ftrace_direct_multi APIs to _ftrace_direct APIs
  ftrace: Store direct called addresses in their ops
  ftrace: Make DIRECT_CALLS work WITH_ARGS and !WITH_REGS

Mark Rutland (1):
  ftrace: selftest: remove broken trace_direct_tramp

 arch/s390/kernel/mcount.S                   |   5 +
 arch/x86/kernel/ftrace_32.S                 |   5 +
 arch/x86/kernel/ftrace_64.S                 |   4 +
 include/linux/ftrace.h                      |  61 +--
 kernel/bpf/trampoline.c                     |  12 +-
 kernel/trace/Kconfig                        |   2 +-
 kernel/trace/ftrace.c                       | 438 ++------------------
 kernel/trace/trace_selftest.c               |  19 +-
 samples/Kconfig                             |   2 +-
 samples/ftrace/ftrace-direct-modify.c       |  10 +-
 samples/ftrace/ftrace-direct-multi-modify.c |   9 +-
 samples/ftrace/ftrace-direct-multi.c        |   5 +-
 samples/ftrace/ftrace-direct-too.c          |  10 +-
 samples/ftrace/ftrace-direct.c              |  10 +-
 14 files changed, 101 insertions(+), 491 deletions(-)

-- 
2.40.0.rc2.332.ga46443480c-goog

