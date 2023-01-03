Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD1E65BE41
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 11:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237355AbjACKe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 05:34:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237128AbjACKeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 05:34:21 -0500
Received: from serv15.avernis.de (serv15.avernis.de [IPv6:2a01:4f8:151:30a2::163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB00AFADE;
        Tue,  3 Jan 2023 02:34:20 -0800 (PST)
Received: from iago.. (unknown [95.91.249.42])
        by serv15.avernis.de (Postfix) with ESMTPSA id 439FFBDE027B;
        Tue,  3 Jan 2023 11:34:17 +0100 (CET)
From:   Andreas Ziegler <br015@umbiko.net>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andreas Ziegler <br015@umbiko.net>
Subject: [PATCH 2/2 v2] tools/tracing/rtla: osnoise_hist: display average with two-digit precision
Date:   Tue,  3 Jan 2023 11:34:00 +0100
Message-Id: <20230103103400.275566-3-br015@umbiko.net>
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

Calculate average value in osnoise-hist summary with two-digit 
precision to avoid displaying too optimitic results. 

Signed-off-by: Andreas Ziegler <br015@umbiko.net>
---
Changes v1 -> v2:
 - output with two-digit precision instead of rounding (Daniel)

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
2.34.1

