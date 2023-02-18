Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC71569BBC8
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 21:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjBRUTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 15:19:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjBRUTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 15:19:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1E514995
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 12:19:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 52BDFB803F3
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 20:19:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D329BC433A1;
        Sat, 18 Feb 2023 20:19:33 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1pTTgC-000xtM-1u;
        Sat, 18 Feb 2023 15:19:32 -0500
Message-ID: <20230218201932.404609629@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 18 Feb 2023 15:18:24 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andreas Ziegler <br015@umbiko.net>,
        Daniel Bristot de Oliveira <bristot@kernel.org>
Subject: [for-next][PATCH 3/8] tools/tracing/rtla: osnoise_hist: display average with two-digit
 precision
References: <20230218201821.938318263@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Ziegler <br015@umbiko.net>

Calculate average value in osnoise-hist summary with two-digit
precision to avoid displaying too optimitic results.

Link: https://lkml.kernel.org/r/20230103103400.275566-3-br015@umbiko.net

Signed-off-by: Andreas Ziegler <br015@umbiko.net>
Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/tracing/rtla/src/osnoise_hist.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index fe34452fc4ec..13e1233690bb 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -335,8 +335,8 @@ osnoise_print_summary(struct osnoise_hist_params *params,
 			continue;
 
 		if (data->hist[cpu].count)
-			trace_seq_printf(trace->seq, "%9llu ",
-					data->hist[cpu].sum_sample / data->hist[cpu].count);
+			trace_seq_printf(trace->seq, "%9.2f ",
+				((double) data->hist[cpu].sum_sample) / data->hist[cpu].count);
 		else
 			trace_seq_printf(trace->seq, "        - ");
 	}
-- 
2.39.1
