Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3751865BE3F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 11:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237335AbjACKeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 05:34:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237226AbjACKeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 05:34:18 -0500
Received: from serv15.avernis.de (serv15.avernis.de [IPv6:2a01:4f8:151:30a2::163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80CA0FAF3;
        Tue,  3 Jan 2023 02:34:17 -0800 (PST)
Received: from iago.. (unknown [95.91.249.42])
        by serv15.avernis.de (Postfix) with ESMTPSA id 7A63CBDE03EE;
        Tue,  3 Jan 2023 11:34:15 +0100 (CET)
From:   Andreas Ziegler <br015@umbiko.net>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andreas Ziegler <br015@umbiko.net>
Subject: [PATCH 1/2 v2] tools/tracing/rtla: osnoise_hist: use total duration for average calculation
Date:   Tue,  3 Jan 2023 11:33:59 +0100
Message-Id: <20230103103400.275566-2-br015@umbiko.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <f47e877c-c95f-e3e6-b96f-89b0ca582878@kernel.org>
References: <f47e877c-c95f-e3e6-b96f-89b0ca582878@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.7 at serv15.avernis.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,RCVD_IN_SORBS_WEB,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sampled durations must be weighted by observed quantity, to arrive at a correct
average duration value.

Perform calculation of total duration by summing (duration * count).

Fixes: 829a6c0b5698 ("rtla/osnoise: Add the hist mode")

Signed-off-by: Andreas Ziegler <br015@umbiko.net>
---
Changes v1 -> v2:
 - add 'Fixes' line (Daniel)

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
2.34.1

