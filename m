Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87A626A5494
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 09:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjB1ImM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 03:42:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjB1ImJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 03:42:09 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853052B2BF
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 00:42:06 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id h8so6326272plf.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 00:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J9njW0cUbNCRuiNeQxGyy89Ebw0Or/C3k7q9j1gWUT4=;
        b=Fz7i6nrjXww1gv1ezA4Y4yQxAb8IkoZCXLDxx+rCPDUDzokDGbwNvPpsZaIKP1n8Ua
         vqPz3OuTl/2iaPW3DimWs+hovbQy1+K6dohaRrsswjKI3rEye34lVeQ0v786HPvlNDCR
         KSMTBp/lXMCP64E/MocCrRRAUac5BgqayPelCb5C/0/sZeBgeVh3hg6MjqaFm0hw+BWB
         sM0psZJKlqX6HsOoJgKVaq2KU3QhhCBrL2+DueBKo2PkeBodGUpAqW4qsqNEcQv7vhXa
         qHq0QY1OSlkSNQIX6AsjKWRbKbsEyPZT7MkBSoRUvljANjmyq3aMieYGjrFmTPCtusvc
         dmtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J9njW0cUbNCRuiNeQxGyy89Ebw0Or/C3k7q9j1gWUT4=;
        b=jC9eX1nUBTZ4C+vGex+M2LBHowYdWBBHnzsnKGphLJRAmYf3xihPIlfrGTAWtTdcgv
         ckOJqD1TiwTRuOHguUQRWw2+W5EzNNzzjbSRiKfyRLQDkb5cHy7SmQxl0I1Or5nOl5L8
         feNFV2GGTGEV+VHr2o0HJQDSjVGZHSHChq23UzPjpIX2k/PZFlD/14MBc6YGNIREluue
         ATJyUZ+GZ6/Hrgqbv7TSBY1xlKLpX5ZEDLTbLIuRN4Rhe4vnmXnJLtS0PGUS5gWYoCEt
         8DNMAwQlaqRyiUm788T07PtBZk/2XsRaKB5eTIY3tF9S6opXraI2+TBVXTgt8qSCS+wj
         +rPw==
X-Gm-Message-State: AO0yUKWBc1pBjVVmtsJNr0rbc/s6enDihXnd0MtH6ac341Wg4OXse43P
        nlmKdxsl9zo0BLbmfc8QxS5sLQ==
X-Google-Smtp-Source: AK7set+IIpVK0uNnk/0dM93v3vTiIcfRXLiIpcFn0O+TyLfiPU9UYFkt3xoDxJoFYwa9X5LOa5uqUA==
X-Received: by 2002:a05:6a20:428b:b0:c2:fb92:3029 with SMTP id o11-20020a056a20428b00b000c2fb923029mr2964908pzj.33.1677573725792;
        Tue, 28 Feb 2023 00:42:05 -0800 (PST)
Received: from leoy-huanghe.lan (n058152048225.netvigator.com. [58.152.48.225])
        by smtp.gmail.com with ESMTPSA id u25-20020aa78499000000b005d6fcd8f9desm5681270pfn.94.2023.02.28.00.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 00:42:05 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 00/14] perf kvm: Support histograms and TUI mode
Date:   Tue, 28 Feb 2023 16:41:33 +0800
Message-Id: <20230228084147.106167-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set is to enable histograms and (partially) TUI mode in perf
kvm tool.

Patch set v1 [1] gives brief introduction for the change and this series
has a minor update for the patch 13 'perf kvm: Add TUI mode for stat
report' to avoid building failure when the system doesn't support
HAVE_SLANG_SUPPORT.

We can use below commands for testing this series:

In a terminal, you could launch a virtual machine with qemu command; in
below case, I downloaded a Ubuntu (or Debian) iso file and used it as
the file system image:

  $ qemu-system-x86_64 -M pc -enable-kvm -cpu host -m 4096 -hda ubuntu-22.04-desktop-amd64.iso

Then in another terminal, I can use below command to capture KVM trace
data and report the result:

  # cd linux/tools/perf
  # ./perf kvm stat record
  # ./perf kvm stat report          => Output in TUI mode
  # ./perf kvm stat report --stdio  => Output in stdio mode

Changes from v1:
* Updated the patch 13 'perf kvm: Add TUI mode for stat report' to avoid
  building failure if no support HAVE_SLANG_SUPPORT.

[1] https://lore.kernel.org/lkml/20230226042053.1492409-1-leo.yan@linaro.org/


Leo Yan (14):
  perf kvm: Refactor overall statistics
  perf kvm: Add pointer to 'perf_kvm_stat' in kvm event
  perf kvm: Move up metrics helpers
  perf kvm: Use subtraction for comparison metrics
  perf kvm: Introduce histograms data structures
  perf kvm: Pass argument 'sample' to kvm_alloc_init_event()
  perf kvm: Parse address location for samples
  perf kvm: Add dimensions for KVM event statistics
  perf kvm: Use histograms list to replace cached list
  perf kvm: Polish sorting key
  perf kvm: Support printing attributions for dimensions
  perf kvm: Add dimensions for percentages
  perf kvm: Add TUI mode for stat report
  perf kvm: Update documentation to reflect new changes

 tools/perf/Documentation/perf-kvm.txt |   9 +-
 tools/perf/builtin-kvm.c              | 856 +++++++++++++++++++++-----
 tools/perf/util/kvm-stat.h            |  26 +-
 3 files changed, 716 insertions(+), 175 deletions(-)

-- 
2.34.1

