Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6076CED73
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 17:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjC2Pun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 11:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbjC2Pub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 11:50:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71455469C;
        Wed, 29 Mar 2023 08:50:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E287C61D84;
        Wed, 29 Mar 2023 15:50:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E98C3C433EF;
        Wed, 29 Mar 2023 15:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680105029;
        bh=2tVl9UGX52wuunDco8JD3qwtKdEDsXFZ5A6RPBCNMuM=;
        h=From:To:Cc:Subject:Date:From;
        b=p1d/75k2P1b9x5VEEKcCUXBAF+mJF/l25lthonFZXcGlnBqDARpn491qzTs4UJp7+
         gc0x4tMB22H0K1cOnqFTZUDQWukKo/EQAz4PJ6JNMOM5wq5vIwd5PuIjT+dmesn4QL
         VtUM05QWvhHbEQqKYH9VjzC86mrcf+DeGuh3n0x1EY2cDuxY8I22xZHv5JnklufUgr
         uvKQzh9NyXdLZ0VQM+nBDrA+OB/+3bPk4nbDwpjUcQzue9Mi/RSk3nyIh5Z5i47Vjh
         wPJByOH9KEXDhaTw0IClQK8iMB2QcCTlKGb6cl4D9OcUSEEcwbirDB1yErG3FhFlnE
         c99EhNEjf2+Ng==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH V2 1/2] tracing/timerlat: Notify new max thread latency
Date:   Wed, 29 Mar 2023 17:50:15 +0200
Message-Id: <16e18d61d69073d0192ace07bf61e405cca96e9c.1680104184.git.bristot@kernel.org>
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

timerlat is not reporting a new tracing_max_latency for the thread
latency. The reason is that it is not calling notify_new_max_latency()
function after the new thread latency is sampled.

Call notify_new_max_latency after computing the thread latency.

Changes from V1:
 Split the patch into two patches (Steve)

Fixes: dae181349f1e ("tracing/osnoise: Support a list of trace_array *tr")
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 kernel/trace/trace_osnoise.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 9176bb7a9bb4..e8116094bed8 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -1738,6 +1738,8 @@ static int timerlat_main(void *data)
 
 		trace_timerlat_sample(&s);
 
+		notify_new_max_latency(diff);
+
 		timerlat_dump_stack(time_to_us(diff));
 
 		tlat->tracing_thread = false;
-- 
2.38.1

