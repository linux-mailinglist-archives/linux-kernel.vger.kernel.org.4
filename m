Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECAA76BB684
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 15:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbjCOOve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 10:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232283AbjCOOvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 10:51:32 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBAE60D50
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 07:51:31 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id u3-20020a17090a450300b00239db6d7d47so2272238pjg.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 07:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678891890;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bu4kxPfj7aIJx2I6pw2/A71GwgwBL/cX002kwanRK0c=;
        b=tyNRqzSJPRKtY5LNcM6dZEmVfMM65dt3L9q2kkBYCu7OE8sI6uVYE1LAfnbA/pAM/Q
         wja1CAysLDHEslicv7D4P4qE5dMF3tg0nh7hmkw+/9Itks2fAIIJr6a9WyoPt/JM9fMB
         bV8J34pNnVfaRD3Y/DB9MhjvH84gvyahf/bCsNB1D35JyuGi0m5vrcM6bru5YBJimRaO
         48JoZeFei6FBrcZ4W8muU8JbV0SaDaOBYlDJpf5YSBWlpdV6TXgvZNeu0OmoLMdUYoXM
         pcBpFvDM5MPdWndxuiELOpw7KqN3F4o78pbG9yCNTEHiL2spXBVipkI1BXfizjAMaq+R
         mX4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678891890;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bu4kxPfj7aIJx2I6pw2/A71GwgwBL/cX002kwanRK0c=;
        b=Lpej5HJAZarO22oPP2O2j2FoFMERRBshZDbYegyqoLWwk9zedRBNbf412NFZbfZPnX
         A6VhD78JF7BfAVE5xp23RcVJcgwuPhKJNFhqSlv50FNHVbsLUXcBAMxUXR3mEq/BzokK
         KKOH1Qb3jJGRYp+YUVBnCMO7dBXb0P1hzfWUaTg9RrAFt/3WGEhpHoc906G57qVjBkYn
         m7p1CR9xMqRQYRyunJvTjIzJriA+ZOEdjbTcjzeE4CBtHFaYhaV8vAU8I2H6v4jdIKdf
         HUqqoT5RZmlTz065PETt2p8Rj+grIcIX7KfCHX9ApGWfU8Kv2ujXne978N/GczDPZjuL
         Ep9Q==
X-Gm-Message-State: AO0yUKUD38yIMOuDXe4BL9fCMU9FA0KFgt7jh5qzSRn54N6VxOwu90rn
        cEGrJfBqpDBhrWV3b0hgYu/FAQ==
X-Google-Smtp-Source: AK7set8J8AEmLGC58l903GZXDnUrjgGzARKnedfsmeb3OmriJj+UQPTB0Yb6xgtAngvU93KxxBaJEA==
X-Received: by 2002:a17:903:228d:b0:19a:9686:ea85 with SMTP id b13-20020a170903228d00b0019a9686ea85mr3543724plh.17.1678891890198;
        Wed, 15 Mar 2023 07:51:30 -0700 (PDT)
Received: from leoy-huanghe.lan ([107.151.177.133])
        by smtp.gmail.com with ESMTPSA id kh3-20020a170903064300b0019926c77577sm3781587plb.90.2023.03.15.07.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 07:51:29 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        John Garry <john.g.garry@oracle.com>,
        James Clark <james.clark@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v5 00/16] perf kvm: Support histograms and TUI mode
Date:   Wed, 15 Mar 2023 22:50:56 +0800
Message-Id: <20230315145112.186603-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set is to enable histograms and (partially) TUI mode in perf
kvm tool; patch set v1 [1] gives brief introduction for the change.

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

Changes from v4:
* Fixed building failure in patch 04; compiled successfully for every
  patch to ensure bisection.

Changes from v3:
* Updated patch 04 to change comparison function return type from int to
  int64_t to avoid overflow;
* Added a refactoring patch 05 "perf kvm: Use macro to replace variable
  'decode_str_len'";
* Refined to use hists__add_entry_ops() and hist_entry__cmp() to compare
  hist entry and add new entries, to support comparison between hist
  entry, added a new patch 09; (Namhyung Kim)
* Updated patch 10 for comparison event name; (Namhyung Kim)
* Refined patch 11 to move init_stats() and hists__inc_nr_samples()
  into kvm_he_zalloc(); (Namhyung Kim)
* Minor refactoring for sort_result() and kvm_hists__init() in patch 15.

Changes from v2:
* Found building failure with command 'make VF=1 DEBUG=1 NO_SLANG=1',
  fixed it in the patch 13. (James Clark)

Changes from v1:
* Updated the patch 13 'perf kvm: Add TUI mode for stat report' to avoid
  building failure if no support HAVE_SLANG_SUPPORT.

[1] https://lore.kernel.org/lkml/20230226042053.1492409-1-leo.yan@linaro.org/


Leo Yan (16):
  perf kvm: Refactor overall statistics
  perf kvm: Add pointer to 'perf_kvm_stat' in kvm event
  perf kvm: Move up metrics helpers
  perf kvm: Use subtraction for comparison metrics
  perf kvm: Use macro to replace variable 'decode_str_len'
  perf kvm: Introduce histograms data structures
  perf kvm: Pass argument 'sample' to kvm_alloc_init_event()
  perf kvm: Parse address location for samples
  perf hist: Add 'kvm_info' field in histograms entry
  perf kvm: Add dimensions for KVM event statistics
  perf kvm: Use histograms list to replace cached list
  perf kvm: Polish sorting key
  perf kvm: Support printing attributions for dimensions
  perf kvm: Add dimensions for percentages
  perf kvm: Add TUI mode for stat report
  perf kvm: Update documentation to reflect new changes

 tools/perf/Documentation/perf-kvm.txt   |   9 +-
 tools/perf/arch/arm64/util/kvm-stat.c   |   1 -
 tools/perf/arch/powerpc/util/kvm-stat.c |   3 +-
 tools/perf/arch/s390/util/kvm-stat.c    |   1 -
 tools/perf/arch/x86/util/kvm-stat.c     |   7 +-
 tools/perf/builtin-annotate.c           |   2 +-
 tools/perf/builtin-c2c.c                |   4 +-
 tools/perf/builtin-diff.c               |   4 +-
 tools/perf/builtin-kvm.c                | 859 +++++++++++++++++++-----
 tools/perf/tests/hists_link.c           |   4 +-
 tools/perf/util/hist.c                  |  19 +-
 tools/perf/util/hist.h                  |   3 +
 tools/perf/util/kvm-stat.h              |  33 +-
 tools/perf/util/sort.h                  |   1 +
 14 files changed, 745 insertions(+), 205 deletions(-)

-- 
2.34.1

