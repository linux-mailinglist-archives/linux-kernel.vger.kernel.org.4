Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1361645B6C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 14:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiLGNws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 08:52:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiLGNwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 08:52:43 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C705D6344;
        Wed,  7 Dec 2022 05:52:39 -0800 (PST)
Received: from dggpeml100012.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NRzBy0p85zqSqk;
        Wed,  7 Dec 2022 21:48:26 +0800 (CST)
Received: from localhost.localdomain (10.67.175.61) by
 dggpeml100012.china.huawei.com (7.185.36.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Dec 2022 21:52:36 +0800
From:   Zheng Yejian <zhengyejian1@huawei.com>
To:     <rostedt@goodmis.org>, <mhiramat@kernel.org>, <zanussi@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <zhengyejian1@huawei.com>
Subject: [PATCH] tracing/hist: Fix issue of losting command info in error_log
Date:   Wed, 7 Dec 2022 21:53:26 +0800
Message-ID: <20221207135326.3483216-1-zhengyejian1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.175.61]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When input some constructed invalid 'trigger' command, command info
in 'error_log' are lost [1].

The root cause is that there is a path that event_hist_trigger_parse()
is recursely called once and 'last_cmd' which save origin command is
cleared, then later calling of hist_err() will no longer record origin
command info:

  event_hist_trigger_parse() {
    last_cmd_set()  // <1> 'last_cmd' save origin command here at first
    create_actions() {
      onmatch_create() {
        action_create() {
          trace_action_create() {
            trace_action_create_field_var() {
              create_field_var_hist() {
                event_hist_trigger_parse() {  // <2> recursely called once
                  hist_err_clear()  // <3> 'last_cmd' is cleared here
                }
                hist_err()  // <4> No longer find origin command!!!

Since 'glob' is empty string while running into the recurse call, we
can trickly check it and bypass the call of hist_err_clear() to solve it.

[1]
 # cd /sys/kernel/tracing
 # echo "my_synth_event int v1; int v2; int v3;" >> synthetic_events
 # echo 'hist:keys=pid' >> events/sched/sched_waking/trigger
 # echo "hist:keys=next_pid:onmatch(sched.sched_waking).my_synth_event(\
pid,pid1)" >> events/sched/sched_switch/trigger
 # cat error_log
[  8.405018] hist:sched:sched_switch: error: Couldn't find synthetic event
  Command:
hist:keys=next_pid:onmatch(sched.sched_waking).my_synth_event(pid,pid1)
                                                          ^
[  8.816902] hist:sched:sched_switch: error: Couldn't find field
  Command:
hist:keys=next_pid:onmatch(sched.sched_waking).my_synth_event(pid,pid1)
                          ^
[  8.816902] hist:sched:sched_switch: error: Couldn't parse field variable
  Command:
hist:keys=next_pid:onmatch(sched.sched_waking).my_synth_event(pid,pid1)
                          ^
[  8.999880] : error: Couldn't find field
  Command:
           ^
[  8.999880] : error: Couldn't parse field variable
  Command:
           ^
[  8.999880] : error: Couldn't find field
  Command:
           ^
[  8.999880] : error: Couldn't create histogram for field
  Command:
           ^

Fixes: f404da6e1d46 ("tracing: Add 'last error' error facility for hist triggers")
Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
---
 kernel/trace/trace_events_hist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 1c82478e8dff..b6e5724a9ea3 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -6438,7 +6438,7 @@ static int event_hist_trigger_parse(struct event_command *cmd_ops,
 	if (se)
 		se->ref++;
  out:
-	if (ret == 0)
+	if (ret == 0 && glob[0])
 		hist_err_clear();
 
 	return ret;
-- 
2.25.1

