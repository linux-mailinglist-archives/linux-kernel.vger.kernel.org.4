Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74E686996CF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 15:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjBPOMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 09:12:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjBPOMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 09:12:47 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A841E3B86E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 06:12:45 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 249FB1042;
        Thu, 16 Feb 2023 06:13:28 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0A7143F703;
        Thu, 16 Feb 2023 06:12:43 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     asahi@lists.linux.dev, ecurtin@redhat.com, j@jannau.net,
        lina@asahilina.net, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, peterz@infradead.org, ravi.bangoria@amd.com,
        will@kernel.org
Subject: [PATCH 0/2] arm_pmu: fix fallout from context handling rewrite
Date:   Thu, 16 Feb 2023 14:12:37 +0000
Message-Id: <20230216141240.3833272-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Janne reports [1] that perf has been broken on Apple M1 as of commit:

  bd27568117664b8b ("perf: Rewrite core context handling")

This is due to changes to pmu::filter_match() and
arm_pmu::filter_match(), which have been renamed and had their polarity
inverted, but the conversion was inconsistent, and so in some cases we
return the opposite result relative to what we had intended. This
results in consistently losing events on Apple M1.

That commit also (silently) removed the filtering of CHAIN events, which
is undesireable.

These patches fix and simplify the CPU filtering, and replace the CHAIN
event filtering with early rejection of CHAIN events, which is much
simpler.

Thanks,
Mark

[1] https://lore.kernel.org/asahi/20230215-arm_pmu_m1_regression-v1-1-f5a266577c8d@jannau.net/

Mark Rutland (2):
  arm_pmu: fix event CPU filtering
  arm64: perf: reject CHAIN events at creation time

 arch/arm64/kernel/perf_event.c | 15 ++++++++-------
 drivers/perf/arm_pmu.c         |  8 +-------
 include/linux/perf/arm_pmu.h   |  1 -
 3 files changed, 9 insertions(+), 15 deletions(-)

-- 
2.30.2

