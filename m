Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79EB26DA0C4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 21:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240527AbjDFTMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 15:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240518AbjDFTMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 15:12:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B4493CD
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 12:12:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B8C2263F1A
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 19:12:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E673C433A0;
        Thu,  6 Apr 2023 19:12:34 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1pkV29-001EYZ-0a;
        Thu, 06 Apr 2023 15:12:33 -0400
Message-ID: <20230406191232.998908152@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 06 Apr 2023 15:11:00 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tze-nan Wu <Tze-nan.Wu@mediatek.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        kernel test robot <lkp@intel.com>
Subject: [for-linus][PATCH 2/2] tracing/synthetic: Make lastcmd_mutex static
References: <20230406191058.652785135@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-2.0 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The lastcmd_mutex is only used in trace_events_synth.c and should be
static.

Link: https://lore.kernel.org/linux-trace-kernel/202304062033.cRStgOuP-lkp@intel.com/
Link: https://lore.kernel.org/linux-trace-kernel/20230406111033.6e26de93@gandalf.local.home

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Tze-nan Wu <Tze-nan.Wu@mediatek.com>
Fixes: 4ccf11c4e8a8e ("tracing/synthetic: Fix races on freeing last_cmd")
Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_synth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index f0ff730125bf..d6a70aff2410 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -44,7 +44,7 @@ enum { ERRORS };
 
 static const char *err_text[] = { ERRORS };
 
-DEFINE_MUTEX(lastcmd_mutex);
+static DEFINE_MUTEX(lastcmd_mutex);
 static char *last_cmd;
 
 static int errpos(const char *str)
-- 
2.39.2
