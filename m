Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7434C651008
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 17:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbiLSQN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 11:13:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbiLSQNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 11:13:53 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EF986A440;
        Mon, 19 Dec 2022 08:13:50 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B601AD7;
        Mon, 19 Dec 2022 08:14:31 -0800 (PST)
Received: from e126815.warwick.arm.com (e126815.arm.com [10.32.32.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6B5683F703;
        Mon, 19 Dec 2022 08:13:48 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     linux-perf-users@vger.kernel.org
Cc:     robh@kernel.org, James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/4] Enable display of partial and empty SVE predicates from Arm SPE data
Date:   Mon, 19 Dec 2022 16:12:54 +0000
Message-Id: <20221219161259.3097213-1-james.clark@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm submitting this on behalf of German who moved on to work on other
things in Arm before he could finish it off.

The predicate information is available on SPE samples from 
Armv8.3 (FEAT_SPEv1p1), this could be useful info for profiling SVE
code as partial and empty predicates indicate that the full vector
width isn't being used. There is a good example in the last commit
message.

Though currently, there isn't a suitable field to store the info
on Perf samples, so this change also adds a new SIMD field.
This field could be used by other architectures, but currently there
is only one bit reserved to identify SVE. It's only added to
struct perf_sample on the userspace side, and isn't part of the kernel
ABI, so it doesn't survive a perf inject. Although this is the
same behavior for some other fields like branch flags, so I don't
think it should be an issue to do something similar here. Perhaps in
the future we could make sure everything that is synthesised from
auxtrace data also makes it back into the new Perf inject file without
being lost.

German Gomez (4):
  perf event: Add simd_flags field to perf_sample
  perf arm-spe: Refactor arm-spe to support operation packet type
  perf arm-spe: Add SVE flags to the SPE samples
  perf report: Add 'simd' sort field

 tools/perf/Documentation/perf-report.txt      |  1 +
 .../util/arm-spe-decoder/arm-spe-decoder.c    | 30 ++++++++++--
 .../util/arm-spe-decoder/arm-spe-decoder.h    | 47 +++++++++++++++----
 tools/perf/util/arm-spe.c                     | 28 +++++++++--
 tools/perf/util/hist.c                        |  1 +
 tools/perf/util/hist.h                        |  1 +
 tools/perf/util/sample.h                      | 13 +++++
 tools/perf/util/sort.c                        | 47 +++++++++++++++++++
 tools/perf/util/sort.h                        |  2 +
 9 files changed, 152 insertions(+), 18 deletions(-)


base-commit: 573de010917836f198a4e579d40674991659668b
-- 
2.25.1

