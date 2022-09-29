Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 635295EF728
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 16:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235623AbiI2OFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 10:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235585AbiI2OFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 10:05:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C758212BD90;
        Thu, 29 Sep 2022 07:05:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5B25DB824A1;
        Thu, 29 Sep 2022 14:05:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4BDBC433D6;
        Thu, 29 Sep 2022 14:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664460333;
        bh=PGLdEFCLQqryQIrHzpE1rK+rKQ6+U1Hs52JY+C45T8w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cU2YD5OIa8O15IBHHx0jn3n6J+K89SPciPalOGLT+gn7EzLI/Xh9+BRV1wOmU01oD
         TbzuR2I8HRVYMtq5rAcWBbwbLsUXjlg2ti9tI//IGx1MPjXaS5Tq/c1DniOOaVTbkF
         AeHRIm66qXHDd8gH/dGafZm9er7o1H8/H3wm0GFxXi5Jje0zlK1s+pFAN8dF5c3rTb
         zIYCgircbdrhFIJxqGy8S6IQi8PRhTGo6yDIF/vkOWxvCfBEGE5o9jpyma9amy1/vC
         7qy9mMTSXN5q9K/rTQ0Y1HtU76XBExOU3sxTqTbVOrm62MjAhSDeLEcesqdQPGg9vr
         kI+RMMcWXTxRg==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 2/2] perf tools: Remove unused variable in tests/test-basic.c
Date:   Thu, 29 Sep 2022 16:05:14 +0200
Message-Id: <20220929140514.226807-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220929140514.226807-1-jolsa@kernel.org>
References: <20220929140514.226807-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clang 15 build reveal several unused-but-set variables,
removing the 'foo' variable in tests/mmap-basic.o object.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/tests/mmap-basic.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
index 21b5e68179d7..8322fc2295fa 100644
--- a/tools/perf/tests/mmap-basic.c
+++ b/tools/perf/tests/mmap-basic.c
@@ -112,8 +112,7 @@ static int test__basic_mmap(struct test_suite *test __maybe_unused, int subtest
 
 	for (i = 0; i < nsyscalls; ++i)
 		for (j = 0; j < expected_nr_events[i]; ++j) {
-			int foo = syscalls[i]();
-			++foo;
+			syscalls[i]();
 		}
 
 	md = &evlist->mmap[0];
-- 
2.37.3

