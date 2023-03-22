Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8586D6C57BE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 21:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjCVUe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 16:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbjCVUeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 16:34:36 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B3985B2E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 13:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679516762; x=1711052762;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Hu1OeAgYiuid6HW80nky3z1Z//8vmWo2s1l38YSR9qQ=;
  b=lMlOp/JESrrvQf86ompygVvd4NKOAhH/LuexIZ0b+kxoM0ciCsy3fF94
   YtcX2FoOtbXSvbcxJ8vikXb0rLWbM74BsaFx5h0JNqWwwDD0yorWgLFe4
   /eNirtVlJ4tBNxh60KfvMliX1/LI+GqcY6REg3nDMz8xlUUbGqTAVH9hR
   r6EuVgHMDXhkLFHbrHurA5iBaFeiP1dMOs6NR0Fw4/T+X8K4k9Bjozwqc
   W4+S25RLQNOk2avajDmM+ALg79oNOZ3Bgjzwn/2ibbYQdNyA7/hrTRdKg
   PtmTCnf0we4hy36+mcjv2uJ1BVKIfAgtLqxuo7R4y9Uw0diFPp8D5SJ1y
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="339360504"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="339360504"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 13:25:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="792714125"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="792714125"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga002.fm.intel.com with ESMTP; 22 Mar 2023 13:25:09 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        adrian.hunter@intel.com, nadav.amit@gmail.com,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>
Subject: [PATCH V2] perf/core: Fix the same task check in perf_event_set_output
Date:   Wed, 22 Mar 2023 13:24:49 -0700
Message-Id: <20230322202449.512091-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The same task check in perf_event_set_output has some potential issues
for some usages.

For the current perf code, there is a problem if using of
perf_event_open() to have multiple samples getting into the same mmap’d
memory when they are both attached to the same process.
https://lore.kernel.org/all/92645262-D319-4068-9C44-2409EF44888E@gmail.com/
Because the event->ctx is not ready when the perf_event_set_output() is
invoked in the perf_event_open().

Besides the above issue, before the commit bd2756811766 ("perf: Rewrite
core context handling"), perf record can errors out when sampling with
a hardware event and a software event as below.
 $ perf record -e cycles,dummy --per-thread ls
 failed to mmap with 22 (Invalid argument)
That's because that prior to the commit a hardware event and a software
event are from different task context.

The problem should be a long time issue since commit c3f00c70276d
("perk: Separate find_get_context() from event initialization").

The task struct is stored in the event->hw.target for each per-thread
event. It is a more reliable way to determine whether two events are
attached to the same task.

The event->hw.target was also introduced several years ago by the
commit 50f16a8bf9d7 ("perf: Remove type specific target pointers"). It
can not only be used to fix the issue with the current code, but also
back port to fix the issues with an older kernel.

Note: The event->hw.target was introduced later than commit
c3f00c70276d. The patch may cannot be applied between the commit
c3f00c70276d and commit 50f16a8bf9d7. Anybody that wants to back-port
this at that period may have to find other solutions.

Fixes: c3f00c70276d ("perf: Separate find_get_context() from event initialization")
Reviewed-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

Changes since V1:
- Update the description to clarify the history, especially the changes
  because of the rewrite.
- Update the Fixes to reflect the correct commit which introduced the
  issue.

 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 0c49183656fd..07e46cb098d1 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -12178,7 +12178,7 @@ perf_event_set_output(struct perf_event *event, struct perf_event *output_event)
 	/*
 	 * If its not a per-cpu rb, it must be the same task.
 	 */
-	if (output_event->cpu == -1 && output_event->ctx != event->ctx)
+	if (output_event->cpu == -1 && output_event->hw.target != event->hw.target)
 		goto out;
 
 	/*
-- 
2.35.1

