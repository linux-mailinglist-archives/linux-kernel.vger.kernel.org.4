Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62D0605C28
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 12:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbiJTKWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 06:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbiJTKVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 06:21:18 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 77E6B80E8E;
        Thu, 20 Oct 2022 03:20:41 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F088ED1;
        Thu, 20 Oct 2022 03:20:46 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.5.110])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3C8B13F792;
        Thu, 20 Oct 2022 03:20:37 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     linux-perf-users@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org, acme@kernel.org,
        James Clark <james.clark@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH v2 0/1] Perf stack unwinding with pointer authentication
Date:   Thu, 20 Oct 2022 11:19:19 +0100
Message-Id: <20221020101921.1219533-1-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've taken up this change from Andrew and made some improvements. It
also didn't apply cleanly anymore so I thought I would resend.

I know there were some discussions with Vince Weaver about having
something arch specific in perf_event_open, so it would be good to get
some more feedback on that. I'm happy to change it so that it's just
called PERF_SAMPLE_PTRAUTH, but given how arch specific the output is,
I'm not sure if that is best.

Thanks
James

Changes since V1:

  * Use weak symbols instead of #ifdefs which simplified things
  * Remove the new files as everything fits well into existing ones
  * Never allow opening the event if CONFIG_ARM64_PTR_AUTH isn't set
  * Include only the kernel side change in this set, the perf tool
    changes are here [1] which I will also rebase and resubmit
  * Rebase onto tip/perf/core (82aad7ff7ac)

[1]: https://lore.kernel.org/lkml/20220704145333.22557-1-andrew.kilroy@arm.com/T/#t

Andrew Kilroy (1):
  perf arm64: Send pointer auth masks to ring buffer

 arch/arm64/include/asm/perf_event.h | 32 +++++++++++++++++++++++++++++
 arch/arm64/kernel/perf_event.c      | 32 +++++++++++++++++++++++++++++
 include/linux/perf_event.h          | 12 +++++++++++
 include/uapi/linux/perf_event.h     |  4 +++-
 kernel/events/core.c                | 31 ++++++++++++++++++++++++++++
 5 files changed, 110 insertions(+), 1 deletion(-)

-- 
2.28.0

