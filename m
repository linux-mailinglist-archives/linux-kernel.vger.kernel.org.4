Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 960EF69B999
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 12:11:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbjBRLLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 06:11:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBRLL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 06:11:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93A7193C4
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 03:11:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6705D60B5C
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 11:11:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6E83C433EF;
        Sat, 18 Feb 2023 11:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676718686;
        bh=TYpBl7Pv8a8OgRVX8tmlNgi4Jw3ee7WV6w+cG8t3Tk0=;
        h=Date:From:To:Cc:Subject:From;
        b=AuO8JsA1EY1vEUAClCXt7jBmtw+zvrpTmXOIzLWQ+deJZKGQbJyHM9qpjNby+66kD
         PKzesJ32v1pbKFABOwwjlaZ/b5V/w3yqMClAyW6z81dRx1koeFlEEEqDLjnhKbdhu2
         9rt2L3csQ1rlNoPyFStWjhX/UNGRsp3jOmYg19VW3fHC8s8KloEYOkebmvRye0PgQs
         bDWJD8bNzxmH3QhlJPCj5eMLvmTPD6RhswemLSjybAJm/RrSa9jyIIPQAM0YPC9Tye
         NsfvkmJHapnWGfroB3oNbVsk4ASs4RzKLiFZnRSSlVSsb/1NL+okNQQ7pTmae5QGPz
         CAZDdRncIujkw==
Date:   Sat, 18 Feb 2023 11:11:22 +0000
From:   Will Deacon <will@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: [GIT PULL] arm64 perf/PMU regression fixes for 6.2
Message-ID: <20230218111100.GA23413@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Apologies for the _extremely_ late pull request here, but we had a 'perf'
(i.e. CPU PMU) regression on the Apple M1 reported on Wednesday [1] which
was introduced by bd2756811766 ("perf: Rewrite core context handling")
during the merge window.

Mark and I looked into this and noticed an additional problem caused by
the same patch, where the 'CHAIN' event (used to combine two adjacent
32-bit counters into a single 64-bit counter) was not being filtered
correctly. Mark posted a series on Thursday [2] which addresses both of
these regressions and I queued it the same day.

Unfortunately, the timing has meant that these two patches are yet to
land in linux-next. We narrowly missed the 20230217 release and now
we're into the weekend. The changes are small, self-contained and have
been confirmed to fix the original regression, so I'd really appreciate
it if you could please pull them in for 6.2 despite the caveat above.

Thanks, and sorry again for the unfortunate timing.

Will

[1] https://lore.kernel.org/asahi/20230215-arm_pmu_m1_regression-v1-1-f5a266577c8d@jannau.net/
[2] https://lore.kernel.org/linux-arm-kernel/20230216141240.3833272-1-mark.rutland@arm.com/

--->8

The following changes since commit a428eb4b99ab80454f06ad256b25e930fe8a4954:

  Partially revert "perf/arm-cmn: Optimise DTC counter accesses" (2023-01-26 13:55:38 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 853e2dac25c15f7431dfe59805de1bada34c96e9:

  arm64: perf: reject CHAIN events at creation time (2023-02-16 21:23:52 +0000)

----------------------------------------------------------------
arm64 regression fix for 6.2

- Fix 'perf' regression for non-standard CPU PMU hardware (i.e. Apple M1)

----------------------------------------------------------------
Mark Rutland (2):
      arm_pmu: fix event CPU filtering
      arm64: perf: reject CHAIN events at creation time

 arch/arm64/kernel/perf_event.c | 15 ++++++++-------
 drivers/perf/arm_pmu.c         |  8 +-------
 include/linux/perf/arm_pmu.h   |  1 -
 3 files changed, 9 insertions(+), 15 deletions(-)
