Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 324AE6C85EC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 20:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbjCXT0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 15:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjCXT0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 15:26:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E5B19C60;
        Fri, 24 Mar 2023 12:26:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E204D62C7D;
        Fri, 24 Mar 2023 19:26:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0086BC433D2;
        Fri, 24 Mar 2023 19:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679686011;
        bh=EXnKvUW2Hc3NIU9pv4lkWJXUJ5FP9/L1K1tDBcTSLBU=;
        h=From:To:Cc:Subject:Date:From;
        b=Zh7ELqhp8uIN5dxm0jhTS1zHTafbe8UMzU3PbZmbRgmdZb6mp0QBi5MY3LoV1HkO8
         0NulsaoaU7QWr/mZnsIEXpcDs6wHqlTwD2Y+9WGnl5DBmpL//U4Olr1UrgnNFxqIRe
         UAMX3e5m3AMDqyiSNo24nbeB36s6gMfEhEdFSjWAVFWf0Je/j4IYjuRnpv3muyN+8S
         7OrW14JunUvWR4AqoJWLd6QKHio1CSTrkrI3OrDrT97JyYayav3DpRmV+XqzHQn+EW
         V7SVTvjpRtNmzJekF0LOJ7g63PzciTz0fIMW7eRnNBCpfUvl94FfA7fpRQfqU3RkIO
         bdCWCBKIOJTQw==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH] rtla/timerlat: Fix "Previous IRQ" auto analysis' line
Date:   Fri, 24 Mar 2023 20:26:42 +0100
Message-Id: <8b5819077f15ccf24745c9bf3205451e16ee32d9.1679685525.git.bristot@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "Previous IRQ interference" line is misaligned and without
a \n, breaking the tool's output:

 ## CPU 12 hit stop tracing, analyzing it ##
  Previous IRQ interference:			up to      2.22 us  IRQ handler delay:		                	    18.06 us (0.00 %)
  IRQ latency:						    18.52 us
  Timerlat IRQ duration:				     4.41 us (0.00 %)
  Blocking thread:					   216.93 us (0.03 %)

Fix the output:

 ## CPU 7 hit stop tracing, analyzing it ##
  Previous IRQ interference:			 up to       8.93 us
  IRQ handler delay:		                	     0.98 us (0.00 %)
  IRQ latency:						     2.95 us
  Timerlat IRQ duration:				    11.26 us (0.03 %)

Fixes: 27e348b221f6 ("rtla/timerlat: Add auto-analysis core")
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 tools/tracing/rtla/src/timerlat_aa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/tracing/rtla/src/timerlat_aa.c b/tools/tracing/rtla/src/timerlat_aa.c
index ec4e0f4b0e6c..1843fff66da5 100644
--- a/tools/tracing/rtla/src/timerlat_aa.c
+++ b/tools/tracing/rtla/src/timerlat_aa.c
@@ -548,7 +548,7 @@ static void timerlat_thread_analysis(struct timerlat_aa_data *taa_data, int cpu,
 	exp_irq_ts = taa_data->timer_irq_start_time - taa_data->timer_irq_start_delay;
 
 	if (exp_irq_ts < taa_data->prev_irq_timstamp + taa_data->prev_irq_duration)
-		printf("  Previous IRQ interference:	\t	up to %9.2f us",
+		printf("  Previous IRQ interference:	\t\t up to  %9.2f us\n",
 			ns_to_usf(taa_data->prev_irq_duration));
 
 	/*
-- 
2.38.1

