Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6328069BBC6
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 21:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjBRUTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 15:19:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjBRUTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 15:19:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F161498F
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 12:19:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1FF81B80935
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 20:19:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FE6BC433A4;
        Sat, 18 Feb 2023 20:19:33 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1pTTgC-000xso-1E;
        Sat, 18 Feb 2023 15:19:32 -0500
Message-ID: <20230218201932.196676123@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 18 Feb 2023 15:18:23 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andreas Ziegler <br015@umbiko.net>,
        Daniel Bristot de Oliveira <bristot@kernel.org>
Subject: [for-next][PATCH 2/8] tools/tracing/rtla: osnoise_hist: use total duration for average
 calculation
References: <20230218201821.938318263@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Ziegler <br015@umbiko.net>

Sampled durations must be weighted by observed quantity, to arrive at a correct
average duration value.

Perform calculation of total duration by summing (duration * count).

Link: https://lkml.kernel.org/r/20230103103400.275566-2-br015@umbiko.net

Fixes: 829a6c0b5698 ("rtla/osnoise: Add the hist mode")

Signed-off-by: Andreas Ziegler <br015@umbiko.net>
Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/tracing/rtla/src/osnoise_hist.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index 5d7ea479ac89..fe34452fc4ec 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -121,6 +121,7 @@ static void osnoise_hist_update_multiple(struct osnoise_tool *tool, int cpu,
 {
 	struct osnoise_hist_params *params = tool->params;
 	struct osnoise_hist_data *data = tool->data;
+	unsigned long long total_duration;
 	int entries = data->entries;
 	int bucket;
 	int *hist;
@@ -131,10 +132,12 @@ static void osnoise_hist_update_multiple(struct osnoise_tool *tool, int cpu,
 	if (data->bucket_size)
 		bucket = duration / data->bucket_size;
 
+	total_duration = duration * count;
+
 	hist = data->hist[cpu].samples;
 	data->hist[cpu].count += count;
 	update_min(&data->hist[cpu].min_sample, &duration);
-	update_sum(&data->hist[cpu].sum_sample, &duration);
+	update_sum(&data->hist[cpu].sum_sample, &total_duration);
 	update_max(&data->hist[cpu].max_sample, &duration);
 
 	if (bucket < entries)
-- 
2.39.1
