Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B32601187
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbiJQOuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiJQOuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:50:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B106747C
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 07:50:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DBB3161185
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 14:50:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B07DDC433C1;
        Mon, 17 Oct 2022 14:50:39 +0000 (UTC)
Date:   Mon, 17 Oct 2022 10:51:03 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     Shuah Khan <shuah@kernel.org>, <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Akanksha J N <akanksha@linux.vnet.ibm.com>
Subject: Re: [PATCH] selftests/ftrace: Limit number of lines processed in
 'trace'
Message-ID: <20221017105103.540a87c7@gandalf.local.home>
In-Reply-To: <20221017105502.307506-1-naveen.n.rao@linux.vnet.ibm.com>
References: <20221017105502.307506-1-naveen.n.rao@linux.vnet.ibm.com>
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

On Mon, 17 Oct 2022 16:25:02 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> On very large machines, ftracetest can seem to hang or otherwise take a
> very long time to complete individual tests. This can be attributed to
> statements that try to process the entire contents of 'trace'.
> 
> Limit the number of lines processed from 'trace' to resolve this. Apart
> from the change in test.d/functions to add TRACENL, this commit is the
> result of running the below command (and fixing some whitespace errors):
>   grep -l -R 'cat trace |' -- ./tools/testing/selftests/ftrace/test.d/ | \
> 	xargs -n 1 sed --in-place -e "s/cat trace |/head -\$\{TRACENL\} trace |/g"
> 

No. This shows that there's an issue in the test. This should never hang
even with a thousand CPUs.

You need to make sure that the "pause-on-trace" option is set or tracing_on
is set to 0 (disabled). Otherwise, if the tracing is still active, then the
reading of the trace file could potentially never end.

Did you have tracing enabled and "pause_on_trace" not set when you ran that
above command? If so, then it may take forever to finish. But the tests
should take care to not read the trace file unless it has stopped tracing.

If there's a case where it will read while tracing is active, then sure, we
need to limit the reporting, otherwise nack on this change.

-- Steve
