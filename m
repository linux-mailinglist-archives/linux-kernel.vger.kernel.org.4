Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA1F6BD73B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 18:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjCPRil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 13:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjCPRij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 13:38:39 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97D0302B2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 10:38:37 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id ip21-20020a05600ca69500b003ed56690948so1593870wmb.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 10:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678988316;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U5mSMxwdN0IR5nAI9XvdYIXU9bwtI93jGwawWBVdvG8=;
        b=Dxs14Bj7A6T+cKbTpK2Sr5K3V6GlyRbuHWlE4K0dGbM4pDIOSwjsb5VM2+iga4ht4M
         sY7R67sqg3IZml4TtJi1d0ePthVPWeyBgXjC4aBut8+2fLjigEV5rL9+Y0pQY6qv0j9r
         NZLjtRF7GEYx63rOSN253WcUx8r4tJ1hQn5fM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678988316;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U5mSMxwdN0IR5nAI9XvdYIXU9bwtI93jGwawWBVdvG8=;
        b=taq6EQN8oaPRPdgV/7df0Wx2VPZwz3nPigzZakWDK+qNxnuui3ytj+HGDqbA1w3lxA
         /3vi+LjCa4/EtivQF7AMgmxy6lbIFaeH2YgWPSH+z8W6caR4P3OzPOIqRcRwVvUXRmB2
         yfU494/BTBwIYemAlZDfa0gRKGWzNobzM9HyNxRxHIal/b266vFcWHgT+U9wPBPMhW8+
         9UoWtEzPTJPfMIeIaIjH1Igu8+woXspL+zB6WbCsjGM2vthTl6BjKhTn8XnlPSPEWLHM
         ZGCAPZe5jogIsw47PX+is24qAtvGPtdv9+qvIvYeOaENY2gsCcC6WgfPKoVrUnp94LUW
         EABg==
X-Gm-Message-State: AO0yUKWj5JTFtdCJjdjEm3hNYsAtEX9nJBzDyQbGNNgnWmQC3X8p/jJi
        Qf7CB5UQ4nuB2vk9s8fsnDK3hk1PhWC+e1KLx44=
X-Google-Smtp-Source: AK7set+SPBlj7qjk2ovvOr0jigoTcKalAVDYTuxbkxBRwGrIsClH1KoAnTY10DcSl+pLzdrq3q2kXQ==
X-Received: by 2002:a05:600c:4f91:b0:3ed:2c92:9f4f with SMTP id n17-20020a05600c4f9100b003ed2c929f4fmr9602119wmq.10.1678988315837;
        Thu, 16 Mar 2023 10:38:35 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:24ff:9ff7:736e:20a6])
        by smtp.gmail.com with ESMTPSA id t14-20020a1c770e000000b003daf7721bb3sm5596436wmi.12.2023.03.16.10.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 10:38:35 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     rostedt@goodmis.org, mhiramat@kernel.org, mark.rutland@arm.com,
        ast@kernel.org, daniel@iogearbox.net, kpsingh@kernel.org,
        revest@chromium.org, jolsa@kernel.org
Subject: [PATCH 0/7] Refactor ftrace direct call APIs
Date:   Thu, 16 Mar 2023 18:38:04 +0100
Message-Id: <20230316173811.1223508-1-revest@chromium.org>
X-Mailer: git-send-email 2.40.0.rc2.332.ga46443480c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series refactors ftrace direct call APIs in preparation for arm64 support.
It is roughly a subset of [1] rebased on v6.3-rc2 and meant to be taken by
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

1: https://lore.kernel.org/all/20230207182135.2671106-1-revest@chromium.org/T/#t

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

