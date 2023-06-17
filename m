Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB1017340FF
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 14:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235070AbjFQMcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 08:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbjFQMcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 08:32:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2E5B3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 05:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UBddHYr3K5LOhUQ5VMGfrM3npDCghRmrpbkd2omOJrY=; b=Kcc4H6k+cd4XLqThXuMfkEjn5M
        6+BW9TrrKOQrp3piZYzRgK7pKbbP/WhMN6TiKGJmK1BqjReii2Q06PKR3UUOrNlWIuEb1WrnRRtMT
        XOlzXx84V9fnqO9mUxrNqMHfSW6ZzypvKI6+Rl+2pywxNwcF9GUsddTa4mdRTBS4ydKCGtbrrN+Ew
        Ee4qsO6ThufJ4Tbl0aMzJXmfR3GhICx81791IJvq/HIe9gaXT3UgYEdWk1GUjRAS1mYrs+vp77tUL
        38Soi7NmlEWSlN7a+4y0j3K0c2nNSizPmHcHDoxNmnVSMRK1pcIiu3dBgciugIN2PUqE0qMLL+Wga
        SKp3nQsw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qAV6I-009wUH-1E; Sat, 17 Jun 2023 12:32:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 554EB3002F0;
        Sat, 17 Jun 2023 14:32:17 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1385821300B3C; Sat, 17 Jun 2023 14:21:16 +0200 (CEST)
Date:   Sat, 17 Jun 2023 14:21:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Robin Jarry <rjarry@redhat.com>
Cc:     Waiman Long <longman@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org> 
        , Josh Poimboeuf <jpoimboe@kernel.org>, Pawan Gupta
        <pawan.kumar.gupta@linux.intel.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
        <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben
        Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Daniel
        Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider" 
        <vschneid@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Joe Mario <jmario@redhat.com>
Subject: Re: [PATCH 0/5] x86/speculation: Disable IBRS when idle
Message-ID: <20230617122115.GA1830050@hirez.programming.kicks-ass.net>
References: <20230616200003.745742-1-longman@redhat.com>
 <CTECMFWMMST3.9FTWRDG7FFKQ@ringo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CTECMFWMMST3.9FTWRDG7FFKQ@ringo>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 10:14:52PM +0200, Robin Jarry wrote:
> Waiman Long, Jun 16, 2023 at 21:59:
> > For Intel processors that need to turn on IBRS to protect against
> > Spectre v2 and Retbleed, the IBRS bit in the SPEC_CTRL MSR affects
> > the performance of the whole core even if only one thread is turning
> > it on when running in the kernel. For user space heavy applications,
> > the performance impact of occasionally turning IBRS on during syscalls
> > shouldn't be significant. Unfortunately, that is not the case when the
> > sibling thread is idling in the kernel. In that case, the performance
> > impact can be significant.
> >
> > When DPDK is running on an isolated CPU thread processing network packets
> > in user space while its sibling thread is idle. The performance of the
> > busy DPDK thread with IBRS on and off in the sibling idle thread are:
> >
> >                                 IBRS on               IBRS off
> >                                 -------               --------
> >   packets/second:                  7.8M                  10.4M
> >   avg tsc cycles/packet:         282.26                 209.86
> >
> > This is a 25% performance degradation. The test system is a Intel Xeon
> > 4114 CPU @ 2.20GHz.
> >
> > This patch series turns off IBRS when in various idle mode to eliminate
> > the performance impact of the idling thread on its busy sibling thread.
> 
> Hi Longman,
> 
> thanks a lot for the quick turnaround on this issue.
> 
> Tested-by: Robin Jarry <rjarry@redhat.com>

I can't see the patches -- they didn't arrive in my mailbox nor can I
find them in the archive, in fact this here mail is the only evidence
they exist at all.

However, did you all see intel_idle_ibrs() and how that is selected for
C6 and up?

What exactly isn't working there?

Also, instead of investing more in this IBRS trainwreck, did you all try
call-depth-stuffing ?
