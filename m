Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D195EE1C0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 18:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234363AbiI1QXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 12:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234548AbiI1QWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 12:22:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABAEA6170C
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 09:22:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B1817B8216E
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 16:22:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A465C433D6;
        Wed, 28 Sep 2022 16:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664382160;
        bh=K+hWOMEW1mtLlCr9eENAKeD5tknY+xmXQVN2lkmf9Uo=;
        h=Date:From:To:Cc:Subject:From;
        b=LLOktlpVi+soxtPV13qOgse1CDgV3EaatPsaAq9nib81gWJnt19GbLdI7JNLSalIP
         hyaSeSQGZTzrUPcf0KmtOiK5WA0bIjZZJBDx7u2K3fUx8qxAo374xcKYX9dTeiuvQx
         TjC8lixdwBNrHFEglUedU2hLuzXt7kfQNdr/0DQKgncP5F88pPnZm1TabnNMO0SnTf
         L8LyjLnuxmzxHXiC9vf7Fl97uxDRgWiLvsreN16C8VQumwtmZfL0D9cvSpBoRtVdPe
         ETZYRklcjRbHOGVg8u6TfttzCAIdhtvJBAAd+FityZFCBa+Uj3Kzfvm27dRw5ioBnn
         Tpthr9WallPKg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E6F5E405F0; Wed, 28 Sep 2022 13:22:37 -0300 (-03)
Date:   Wed, 28 Sep 2022 13:22:37 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] perf tests record: Fail the test if the errs counter is
 not zero
Message-ID: <YzR0n5QhsH9VyYB0@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We were just checking for the 'err' variable, when we should really see
if there was some of the many checked errors that don't stop the test
right away.

Detected with clang 15.0.0:

  44    75.23 fedora:37                     : FAIL clang version 15.0.0 (Fedora 15.0.0-2.fc37)

    tests/perf-record.c:68:16: error: variable 'errs' set but not used [-Werror,-Wunused-but-set-variable]
            int err = -1, errs = 0, i, wakeups = 0;
                          ^
    1 error generated.

The patch introducing this 'perf test' entry had that check:

  +       return (err < 0 || errs > 0) ? -1 : 0;

But at some point we lost that:

  -       return (err < 0 || errs > 0) ? -1 : 0;
  +       if (err == -EACCES)
  +               return TEST_SKIP;
  +       if (err < 0)
  +               return TEST_FAIL;
  +       return TEST_OK

Put it back.

Fixes: 2cf88f4614c996e5 ("perf test: Use skip in PERF_RECORD_*")
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/perf-record.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/perf-record.c b/tools/perf/tests/perf-record.c
index 6a001fcfed68e517..4952abe716f318b0 100644
--- a/tools/perf/tests/perf-record.c
+++ b/tools/perf/tests/perf-record.c
@@ -332,7 +332,7 @@ static int test__PERF_RECORD(struct test_suite *test __maybe_unused, int subtest
 out:
 	if (err == -EACCES)
 		return TEST_SKIP;
-	if (err < 0)
+	if (err < 0 || errs != 0)
 		return TEST_FAIL;
 	return TEST_OK;
 }
-- 
2.37.3


----- End forwarded message -----

-- 

- Arnaldo
