Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F266FF768
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 18:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238475AbjEKQc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 12:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232501AbjEKQc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 12:32:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68F386A9;
        Thu, 11 May 2023 09:32:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3291A64F9A;
        Thu, 11 May 2023 16:32:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 190FEC433EF;
        Thu, 11 May 2023 16:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683822731;
        bh=gW/QVNiiP32Xg88rYdghCZ+KlKF0J2C2taBsF0+taHY=;
        h=From:To:Cc:Subject:Date:From;
        b=tpvaftI0Sc3sYeCtaAg/M0g/a11Fjw5Ofo/Yfwc7yuvArvH/1gdurhWGWRXg4nTOj
         Zi0x4Nkwg7TqsEJlfRHWUJqY6IcKjKIZsQKX5O0qUNZo7A2M7zCWktVQEHeJ33d3K/
         d0yHpYRhk3c683Tn/tDKr84n2L3a2p3U7Ziaoj+uc2Sk7K1DTVNdrZRy1TeTILjXxm
         qMljSKfau5dVdwjha4u5/fq82vfL3fvUr57l1tsTGYdFEsN9UMi/VROQA2aGIJG3up
         wsj7Ibt2ocFLOqk5HXDWLFs9pHrsjzbxwFm9edGrjS/FpggdX4u/QttQULgqZH6Aho
         6YTeQ03H1U6gQ==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH] tracing/timerlat: Always wakeup the timerlat thread
Date:   Thu, 11 May 2023 18:32:01 +0200
Message-Id: <1ed8f830638b20a39d535d27d908e319a9a3c4e2.1683822622.git.bristot@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While testing rtla timerlat auto analysis, I reach a condition where
the interface was not receiving tracing data. I was able to manually
reproduce the problem with these steps:

  # echo 0 > tracing_on                 # disable trace
  # echo 1 > osnoise/stop_tracing_us    # stop trace if timerlat irq > 1 us
  # echo timerlat > current_tracer      # enable timerlat tracer
  # sleep 1                             # wait... that is the time when rtla
                                        # apply configs like prio or cgroup
  # echo 1 > tracing_on                 # start tracing
  # cat trace
  # tracer: timerlat
  #
  #                                _-----=> irqs-off
  #                               / _----=> need-resched
  #                              | / _---=> hardirq/softirq
  #                              || / _--=> preempt-depth
  #                              ||| / _-=> migrate-disable
  #                              |||| /     delay
  #                              |||||            ACTIVATION
  #           TASK-PID      CPU# |||||   TIMESTAMP   ID            CONTEXT                 LATENCY
  #              | |         |   |||||      |         |                  |                       |
        NOTHING!

Then, trying to enable tracing again with echo 1 > tracing_on resulted
in no change: the trace was still not tracing.

This problem happens because the timerlat IRQ hits the stop tracing
condition while tracing is off, and do not wake up the timerlat thread,
so the timerlat threads are kept sleeping forever, resulting in no
trace, even after re-enabling the tracer.

Avoid this condition by always waking up the threads, even after stopping
tracing, allowing the tracer to return to its normal operating after
a new tracing on.

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Fixes: a955d7eac177 ("trace: Add timerlat tracer")
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 kernel/trace/trace_osnoise.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index efbbec2caff8..e97e3fa5cbed 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -1652,6 +1652,8 @@ static enum hrtimer_restart timerlat_irq(struct hrtimer *timer)
 			osnoise_stop_tracing();
 			notify_new_max_latency(diff);
 
+			wake_up_process(tlat->kthread);
+
 			return HRTIMER_NORESTART;
 		}
 	}
-- 
2.38.1

