Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B991655A27
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 13:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbiLXMru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 07:47:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiLXMrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 07:47:47 -0500
X-Greylist: delayed 505 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 24 Dec 2022 04:47:45 PST
Received: from serv15.avernis.de (serv15.avernis.de [IPv6:2a01:4f8:151:30a2::163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F0CBE07;
        Sat, 24 Dec 2022 04:47:45 -0800 (PST)
Received: from webmail.serv15.avernis.de (ip6-localhost [IPv6:::1])
        by serv15.avernis.de (Postfix) with ESMTPSA id B589ABDE7DCE;
        Sat, 24 Dec 2022 13:39:15 +0100 (CET)
MIME-Version: 1.0
Date:   Sat, 24 Dec 2022 12:39:15 +0000
From:   Andreas Ziegler <br015@umbiko.net>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: rtla osnoise hist: average duration is always zero
Message-ID: <d7bb31547e9bbf6684801a7bbd857810@umbiko.net>
X-Sender: br015@umbiko.net
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.7 at serv15.avernis.de
X-Virus-Status: Clean
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_20,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- Observed in, but not limited to, Linux 6.1.1

Dear all,

rtla osnoise hist always outputs '0' as average duration value. Example:

# rtla osnoise hist -P F:1 -c 0-1 -r 900000 -d 1M -b 1 -E 5000 -T 1
# RTLA osnoise histogram
# Time unit is microseconds (us)
# Duration:   0 00:01:00
   ...
count:     5629      1364
min:          1         1
avg:          0         0
max:       2955        56

This is due to sum_sample in osnoise_hist_update_multiple() being 
calculated as the sum (duration), not as sum (duration * count).

Rounding, instead of truncating, of the average value would be cool.

The following patch would solve the issue described above:


Sampled duration must be weighted by observed quantity, to arrive at a
correct average duration value.

Fix calculation of total duration by summing (duration * count).
Introduce rounding for calculation of final value.

Signed-off-by: Andreas Ziegler <br015@umbiko.net>

--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -121,6 +121,7 @@
  {
  	struct osnoise_hist_params *params = tool->params;
  	struct osnoise_hist_data *data = tool->data;
+	unsigned long long total_duration;
  	int entries = data->entries;
  	int bucket;
  	int *hist;
@@ -131,10 +132,12 @@
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
@@ -333,7 +336,7 @@

  		if (data->hist[cpu].count)
  			trace_seq_printf(trace->seq, "%9llu ",
-					data->hist[cpu].sum_sample / data->hist[cpu].count);
+				(data->hist[cpu].sum_sample + data->hist[cpu].count / 2) / 
data->hist[cpu].count);
  		else
  			trace_seq_printf(trace->seq, "        - ");
  	}


Kind regards,
Andreas
