Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C454F64A478
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 16:55:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232637AbiLLPzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 10:55:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbiLLPzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 10:55:43 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 079DC64EE;
        Mon, 12 Dec 2022 07:55:39 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E147C1FB;
        Mon, 12 Dec 2022 07:56:19 -0800 (PST)
Received: from e126815.warwick.arm.com (e126815.arm.com [10.32.32.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CFDCE3F71E;
        Mon, 12 Dec 2022 07:55:36 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     linux-perf-users@vger.kernel.org
Cc:     Al.Grant@arm.com, James Clark <james.clark@arm.com>,
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
        Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        coresight@lists.linaro.org
Subject: [PATCH 0/5] perf: cs-etm: Print auxtrace info even if OpenCSD isn't linked
Date:   Mon, 12 Dec 2022 15:55:08 +0000
Message-Id: <20221212155513.2259623-1-james.clark@arm.com>
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

The auxtrace info header can be useful for debugging, and at the
moment it's possible to record a file without OpenCSD linked but
not view the header even though it should be possible to do.

This patchset tidies up some of the related functions and
improves some of the error messages before making the above
possible in the last commit.

Testing done:

 * Compiled on x86 and Arm both with and without CORESIGHT=1
 * Ran the Coresight tests

Applies to perf/core (0c3852adae8)

James Clark (5):
  perf: cs-etm: Print unknown header version as an error
  perf: cs-etm: Remove unused stub methods
  perf: cs-etm: Tidy up auxtrace info header printing
  perf: cs-etm: Cleanup cs_etm__process_auxtrace_info()
  perf: cs-etm: Print auxtrace info even if OpenCSD isn't linked

 tools/perf/util/Build         |   1 +
 tools/perf/util/cs-etm-base.c | 174 ++++++++++++++++++++++++++++
 tools/perf/util/cs-etm.c      | 208 +++-------------------------------
 tools/perf/util/cs-etm.h      |  46 ++------
 4 files changed, 200 insertions(+), 229 deletions(-)
 create mode 100644 tools/perf/util/cs-etm-base.c

-- 
2.25.1

