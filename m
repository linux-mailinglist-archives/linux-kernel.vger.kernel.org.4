Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0F173FB23
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 13:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbjF0Lbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 07:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjF0Lbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 07:31:45 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B211010C;
        Tue, 27 Jun 2023 04:31:43 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fa99742af9so18995065e9.2;
        Tue, 27 Jun 2023 04:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687865502; x=1690457502;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=3elyK//VZE6LbNqqmwWhw/AW+Y7NP8/nX3isY27WqZw=;
        b=XIgLrUQhbq43E/LPdw45rTAEuXsIaSnhtYOqC88Wjkjyd0I92LA1qfgGMCZ5w2nv4i
         nT190iJsn9WViNLT19C2CCFnUEPgfz8HtqeNCNX/1sE4WO7cR09k+yh4vMN0dI2b+yER
         YRecDhiVOotFU4b/aOG1V16Ij12kUi9Een2SKOrqAkQgKreVQwtHbzFFIOIu7ID8N+6H
         a/I81Wuuvj2EiAXmtyDvClghGRlKBha5s0CBKH7vKPCg1/NXIK4IfHAtL4JKEStj0DAB
         lM9tZcd6USdZnazyTUiJstkL/MuMf7/V+quv9txNz9UdjWGEZaNiQjtUovbW4g+ZdMCD
         a/2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687865502; x=1690457502;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3elyK//VZE6LbNqqmwWhw/AW+Y7NP8/nX3isY27WqZw=;
        b=Wj6wuLOWiU7D83FnjIVjRi7VX454Y012fEuliKvZCb/rGUraa3DRuroSGF298YmmQw
         aeUNaHqncvbBXJbne0GP9irJ1HLGKcEyIor/tK4kNUVI5EYAt4AqAm5obRW646YiDRbM
         RIvRKzkysy+PeJi86KF+cYoX+3kGEZ43beVjNPTVNEgxyWmgxzZe7VlXpAAMVTl0R17B
         nFLiSKzmzphZ0k9d/hS405OIgaZCHDT3st4zv9I86gXOy9pf4fTncWC+D/2Fube1FAIx
         K44i7u6EG3paLF+bpITU3lXBJyXx1SrbB/zNnDYlnaMVeSMuBJZf2UHOEAVG7V7bdg71
         F+jw==
X-Gm-Message-State: AC+VfDw6fsDxy4Cl8lbCsjSOrfj0gsscP4u1mdvmyIX6zeUjPr6Nqg61
        eXRjPxVOtyVLnVBsTNbW98A=
X-Google-Smtp-Source: ACHHUZ5H9f3gEKkJ/oKFZ/Zztg8/p7GphQFxHpnzw7Dw3f9OIAnMJa1RrOXt4sndAm5TUOpUamoahw==
X-Received: by 2002:a05:600c:3798:b0:3fb:8284:35b0 with SMTP id o24-20020a05600c379800b003fb828435b0mr1594255wmr.30.1687865501928;
        Tue, 27 Jun 2023 04:31:41 -0700 (PDT)
Received: from gmail.com (1F2EF7E2.nat.pool.telekom.hu. [31.46.247.226])
        by smtp.gmail.com with ESMTPSA id 14-20020a05600c020e00b003f8d6647661sm13368317wmi.15.2023.06.27.04.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 04:31:41 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 27 Jun 2023 13:31:39 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] perf event updates for v6.5
Message-ID: <ZJrIm3y2n8x3Oyq/@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Please pull the latest perf events git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2023-06-27

   # HEAD: 228020b490eda9133c9cb6f59a5ee1278d8c463f perf: Re-instate the linear PMU search

Perf events changes for v6.5:

- Rework & fix the event forwarding logic by extending the
  core interface. This fixes AMD PMU events that have to
  be forwarded from the core PMU to the IBS PMU.

- Add self-tests to test AMD IBS invocation via core PMU events

- Clean up Intel FixCntrCtl MSR encoding & handling

 Thanks,

	Ingo

------------------>
Dapeng Mi (1):
      perf/x86/intel: Define bit macros for FixCntrCtl MSR

Peter Zijlstra (1):
      perf: Re-instate the linear PMU search

Ravi Bangoria (4):
      perf/core: Rework forwarding of {task|cpu}-clock events
      perf/ibs: Fix interface via core pmu events
      perf/core: Remove pmu linear searching code
      perf test: Add selftest to test IBS invocation via core pmu events


 arch/x86/events/amd/core.c                       |  2 +-
 arch/x86/events/amd/ibs.c                        | 53 ++++++++--------
 arch/x86/events/intel/core.c                     | 18 +++---
 arch/x86/include/asm/perf_event.h                | 12 ++++
 include/linux/perf_event.h                       | 10 +++
 kernel/events/core.c                             | 77 +++++++++++++-----------
 tools/perf/arch/x86/include/arch-tests.h         |  1 +
 tools/perf/arch/x86/tests/Build                  |  1 +
 tools/perf/arch/x86/tests/amd-ibs-via-core-pmu.c | 71 ++++++++++++++++++++++
 tools/perf/arch/x86/tests/arch-tests.c           |  2 +
 10 files changed, 174 insertions(+), 73 deletions(-)
 create mode 100644 tools/perf/arch/x86/tests/amd-ibs-via-core-pmu.c
