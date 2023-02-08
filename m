Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C469168F68F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 19:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbjBHSFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 13:05:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbjBHSFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 13:05:38 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11D515C80;
        Wed,  8 Feb 2023 10:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zh9nqswjJhdYhMpPDVI5AF8aOHrT+4BnIbjtTEcH+O0=; b=SEHP3kAZWo30fFZLD9KrQHCMl0
        bLAWo0pWw5A9KbZ7EwaJqZJ0MTWOn+etMoT+6xM8m/yOsGn2PpbJe/AB2Cdb4spjK2DSJ8vxQChQb
        F7Qv7a8Np/U+3nC0Gv1o9VMxn76bKxlnPJcEZsejTqEK0pXM7gPb6iFN2elhvfNphNpmhWIDbbt4h
        vNd5zOTmi8ThrcjgZuYSra5CpVL6sQEpVB0kjbfMHRlHljUxnRBo9DAE0BAZJb6s7GFXYwE6B03zG
        XTZZ8Q4/RrBo0DWBnLfndhzsEJb8LdoEcsgU08W3S3pf8/1J30gL0a4yH4kpA6luINam4VyBdbzv+
        Ogf17kHg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pPoo2-007Ws6-02;
        Wed, 08 Feb 2023 18:04:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 766F73001E4;
        Wed,  8 Feb 2023 19:05:08 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2427F20F05D4E; Wed,  8 Feb 2023 19:05:08 +0100 (CET)
Date:   Wed, 8 Feb 2023 19:05:08 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH] tracing/selftests: Ignore __pfx_ symbols in kprobe test
Message-ID: <Y+PkVD1+myADYns+@hirez.programming.kicks-ass.net>
References: <20230207135147.5ce618d6@gandalf.local.home>
 <20230207135402.38f73bb6@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230207135402.38f73bb6@gandalf.local.home>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2023 at 01:54:02PM -0500, Steven Rostedt wrote:
> On Tue, 7 Feb 2023 13:51:47 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> > 
> > The kprobe probepoint.tc test started failing because of the added __pfx_
> > symbols that were added because of -fpatchable-function-entry=X,Y causing
> > unwinders to see them as part of the previous functions. But kprobes can
> > not be added on top of them. The selftest looks for tracefs_create_dir and
> > picks it and the previous and following functions to add at their address.
> > This caused it to include __pfx_tracefs_create_dir which is invalid to
> > attach a kprobe to and caused the test to fail.
> > 
> > Fixes: 9f2899fe36a62 ("objtool: Add option to generate prefix symbols")
> > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> This is assuming that kprobes can not be added on top of these. But another
> solution could be to have kprobes just pick the function the __pfx_ is for.
> Would that be a better solution?

Simply refusing them is simplest. I don't see a compelling reason to
make this complicated.
