Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C49B3602F81
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 17:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbiJRPUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 11:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiJRPUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 11:20:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6555072E
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 08:19:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 10CA1B81F70
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 15:19:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC055C433D6;
        Tue, 18 Oct 2022 15:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666106393;
        bh=0oEPqC+8GByS2AGYyqYltaGRZmAvfeYo5eg5Xt1Mxfk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RKJcrVzOPy9lhKzBjQ8SrW1I88Ol//cWrhMYPPc5N8MgMH2jIFYvE/2n4V24uIt87
         UOmYcBGEFdIPDhBpqAgcPsTXP0BPXnOB0atvZYNC3NLI1NVOP/Pmz51kTCrBZP0pZN
         FqvjK+pW22JNQo86NrMnW09ezz5XKx1l95Zsl2sABNHxIBciCn5I4yq33WJOfVhpJ7
         0mkScwguzaMUaOWUptN3P7D12VqJor1qseNhK2lUn85putqqWuQBiEJzpM7IzFwa10
         5AbW9K0Y4RzFg07Fj3VWpRigisRr1KEotKl0qY3qsbRzOfAp0bfv2rYlzwpNivjZpU
         qMvpF5UUJ9IWA==
Date:   Wed, 19 Oct 2022 00:19:49 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Shuah Khan <shuah@kernel.org>, <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Akanksha J N <akanksha@linux.vnet.ibm.com>
Subject: Re: [PATCH] selftests/ftrace: Limit number of lines processed in
 'trace'
Message-Id: <20221019001949.950fb044677f96c6cdd00fdf@kernel.org>
In-Reply-To: <20221017105103.540a87c7@gandalf.local.home>
References: <20221017105502.307506-1-naveen.n.rao@linux.vnet.ibm.com>
        <20221017105103.540a87c7@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Oct 2022 10:51:03 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 17 Oct 2022 16:25:02 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> 
> > On very large machines, ftracetest can seem to hang or otherwise take a
> > very long time to complete individual tests. This can be attributed to
> > statements that try to process the entire contents of 'trace'.
> > 
> > Limit the number of lines processed from 'trace' to resolve this. Apart
> > from the change in test.d/functions to add TRACENL, this commit is the
> > result of running the below command (and fixing some whitespace errors):
> >   grep -l -R 'cat trace |' -- ./tools/testing/selftests/ftrace/test.d/ | \
> > 	xargs -n 1 sed --in-place -e "s/cat trace |/head -\$\{TRACENL\} trace |/g"
> > 
> 
> No. This shows that there's an issue in the test. This should never hang
> even with a thousand CPUs.
> 
> You need to make sure that the "pause-on-trace" option is set or tracing_on
> is set to 0 (disabled). Otherwise, if the tracing is still active, then the
> reading of the trace file could potentially never end.

initialize_ftrace() does this setting. So it must be set.
If you run the ftracetest on old kernel, this feature is not there and
it may cause a trouble. Naveen, can you clarify it?

Thank you,

> 
> Did you have tracing enabled and "pause_on_trace" not set when you ran that
> above command? If so, then it may take forever to finish. But the tests
> should take care to not read the trace file unless it has stopped tracing.
> 
> If there's a case where it will read while tracing is active, then sure, we
> need to limit the reporting, otherwise nack on this change.
> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
