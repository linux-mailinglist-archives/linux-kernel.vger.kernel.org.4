Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7258462485D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 18:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbiKJR26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 12:28:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbiKJR2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 12:28:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADB71156;
        Thu, 10 Nov 2022 09:28:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2052761D53;
        Thu, 10 Nov 2022 17:28:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA40BC433C1;
        Thu, 10 Nov 2022 17:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668101324;
        bh=sENMuzY4sr/Mt+Bk+aCRj2lY72CbUnhjfFRJxImy25A=;
        h=From:To:Cc:Subject:Date:From;
        b=KZjfd5PhyhUj66YaQCxMlmBJynHn8W2peKPHltHHc+N7D6aO0/MSf0l03Qg2d77ch
         YLq9+fKeIAuN3ohwutirv8enXifCudKDgWAcmdbWm+7Bn7ADdh83kUwPzglgE6I5si
         8rOLPVIAp8VRpLuGlYxMi7rxedECQzEb274uo/qVtn1q6/i/k5TdzfplGYhzoBKNR9
         uuqELUn5LWrO+0/ZOa+T9bi45XYLrHD6OjqFL5tgXnuyijm4hZ4wclteE6eA4GgQ8G
         HQtJRSiZPlop+rDFsfuatnDU8EuZrgz/jnlrKWnTYfScB9ULsiYRtIagayuEvWFlP0
         PDotxcgGSzM6g==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
        Disha Goel <disgoel@linux.vnet.ibm.com>,
        Donglin Peng <dolinux.peng@gmail.com>,
        James Clark <james.clark@arm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf tools fixes for v6.1: 2nd batch
Date:   Thu, 10 Nov 2022 14:28:31 -0300
Message-Id: <20221110172831.369713-1-acme@kernel.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

	Please consider pulling,

Best regards,

- Arnaldo

The following changes since commit 59f2f4b8a757412fce372f6d0767bdb55da127a8:

  fs/userfaultfd: Fix maple tree iterator in userfaultfd_unregister() (2022-11-07 12:58:26 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v6.1-2-2022-11-10

for you to fetch changes up to 94d957ae513fc420d0a5a9bac815eb49ffebb56f:

  perf tools: Add the include/perf/ directory to .gitignore (2022-11-08 18:54:41 -0300)

----------------------------------------------------------------
perf tools fixes for v6.1: 2nd batch

- Fix 'perf stat' crash with --per-node --metric-only in CSV mode, due
  to the AGGR_NODE slot in the 'aggr_header_csv' array not being set.

- Fix printing prefix in CSV output of 'perf stat' metrics in interval
  mode (-I), where an extra separator was being added to the start of
  some lines.

- Fix skipping branch stack sampling 'perf test' entry, that was using
  both --branch-any and --branch-filter, which can't be used together.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Athira Rajeev (1):
      perf stat: Fix printing os->prefix in CSV metrics output

Donglin Peng (1):
      perf tools: Add the include/perf/ directory to .gitignore

James Clark (1):
      perf test: Fix skipping branch stack sampling test

Namhyung Kim (1):
      perf stat: Fix crash with --per-node --metric-only in CSV mode

 tools/perf/.gitignore                  | 1 +
 tools/perf/tests/shell/test_brstack.sh | 5 ++++-
 tools/perf/util/parse-branch-options.c | 4 +++-
 tools/perf/util/stat-display.c         | 6 ++++--
 4 files changed, 12 insertions(+), 4 deletions(-)
