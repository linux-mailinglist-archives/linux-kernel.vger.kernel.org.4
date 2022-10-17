Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B3760115B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbiJQOnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbiJQOm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:42:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292A766A78
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 07:42:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B70B2B818F6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 14:42:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5177C433D6;
        Mon, 17 Oct 2022 14:42:48 +0000 (UTC)
Date:   Mon, 17 Oct 2022 10:43:12 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     Shuah Khan <shuah@kernel.org>, <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Akanksha J N <akanksha@linux.vnet.ibm.com>
Subject: Re: [PATCH] selftests/ftrace: Add check for ping command for
 trigger tests
Message-ID: <20221017104312.16af5467@gandalf.local.home>
In-Reply-To: <20221017101927.303547-1-naveen.n.rao@linux.vnet.ibm.com>
References: <20221017101927.303547-1-naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Oct 2022 15:49:27 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> All these tests depend on the ping command and will fail if it is not
> installed. Add an explicit check and mark the tests as unresolved if it
> isn't found.
> 
> Reported-by: Akanksha J N <akanksha@linux.vnet.ibm.com>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>  .../trigger/inter-event/trigger-field-variable-support.tc    | 5 +++++
>  .../trigger/inter-event/trigger-inter-event-combined-hist.tc | 5 +++++
>  .../trigger/inter-event/trigger-onchange-action-hist.tc      | 5 +++++
>  .../trigger/inter-event/trigger-onmatch-action-hist.tc       | 5 +++++
>  .../trigger/inter-event/trigger-onmatch-onmax-action-hist.tc | 5 +++++
>  .../test.d/trigger/inter-event/trigger-onmax-action-hist.tc  | 5 +++++
>  .../trigger/inter-event/trigger-snapshot-action-hist.tc      | 5 +++++
>  .../trigger/inter-event/trigger-synthetic-event-dynstring.tc | 5 +++++
>  .../test.d/trigger/inter-event/trigger-trace-action-hist.tc  | 5 +++++
>  9 files changed, 45 insertions(+)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-field-variable-support.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-field-variable-support.tc
> index 41119e0440e960..b0969e6eed8375 100644
> --- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-field-variable-support.tc
> +++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-field-variable-support.tc
> @@ -10,6 +10,11 @@ fail() { #msg
>  
>  echo "Test field variable support"
>  
> +if ! which ping; then
> +    echo "ping is not found. This test requires ping command."
> +    exit_unresolved
> +fi
> +

This looks like something we should add to the "requires:" field and not
add this type of logic in the test itself.

Something like this:

diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
index 5f6cbec847fc..e13fe1d5bd6c 100644
--- a/tools/testing/selftests/ftrace/test.d/functions
+++ b/tools/testing/selftests/ftrace/test.d/functions
@@ -144,7 +144,13 @@ check_requires() { # Check required files and tracers
     for i in "$@" ; do
         r=${i%:README}
         t=${i%:tracer}
-        if [ $t != $i ]; then
+        p=${i%:program}
+        if [ $p != $i ]; then
+            if ! which $p; then
+                echo "Required program $p not installed."
+                exit_unresolved
+            fi
+        elif [ $t != $i ]; then
             if ! grep -wq $t available_tracers ; then
                 echo "Required tracer $t is not configured."
                 exit_unsupported
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-inter-event-combined-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-inter-event-combined-hist.tc
index 9098f1e7433f..f7447d800899 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-inter-event-combined-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-inter-event-combined-hist.tc
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test inter-event combined histogram trigger
-# requires: set_event synthetic_events events/sched/sched_process_fork/hist
+# requires: set_event synthetic_events events/sched/sched_process_fork/hist ping:program
 
 fail() { #msg
     echo $1


Then add the "ping:program" to the other tests required fields.

-- Steve
