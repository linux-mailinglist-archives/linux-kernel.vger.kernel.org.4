Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC7E5EABE3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 18:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234705AbiIZQDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 12:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233274AbiIZQC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 12:02:27 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0EBCD7D791;
        Mon, 26 Sep 2022 07:50:18 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA2EF1042;
        Mon, 26 Sep 2022 07:50:24 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.0.51])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 565F13F66F;
        Mon, 26 Sep 2022 07:50:16 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     acme@kernel.org, namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 0/1] perf test: Fix attr tests for PERF_FORMAT_LOST
Date:   Mon, 26 Sep 2022 15:49:46 +0100
Message-Id: <20220926144948.223641-1-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not sure what the rule is for backwards compatibility of tests, but
in this case my change will not work on older kernels because I replaced
the previous expected value, rather than adding it as another valid one
with an OR. Like "read_format=4|20"

To me it seems that running the tests is a different workflow than say
someone running Perf itself on older kernels. And if we keep adding to
the valid values in tests, then the tests become less useful over time.

PERF_FORMAT_LOST is not an optional feature so it _should_ always be
present. For that reason I chose to not add it as an extra valid value,
but I'm happy to change it if we think that new tests should also pass
on older kernels.

Thanks
James

James Clark (1):
  perf test: Fix attr tests for PERF_FORMAT_LOST

 tools/perf/tests/attr/base-record                | 2 +-
 tools/perf/tests/attr/system-wide-dummy          | 2 +-
 tools/perf/tests/attr/test-record-group          | 4 ++--
 tools/perf/tests/attr/test-record-group-sampling | 6 +++---
 tools/perf/tests/attr/test-record-group1         | 4 ++--
 tools/perf/tests/attr/test-record-group2         | 4 ++--
 6 files changed, 11 insertions(+), 11 deletions(-)

-- 
2.28.0

