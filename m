Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8557D6374A1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 10:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiKXJAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 04:00:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbiKXJAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 04:00:13 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3BE110CEBC
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 01:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EO5c44X/jhNTOXnG5TFwTVRZvjkCESEND+iUGeyYt18=; b=aEuPR6rpfZheOoyuAY+8UakxI1
        Kr56Q4Q7FhZ9MARVoYD09NSjWmB5ePLVW63kePJSJDwooD2ZkqNselkLC4wkH4ofUAAGKSM1pkx2S
        3uy/wJsvgfp5Z/UjTMwc4a4K3FUgr5YwdQXYl9EC4iA9p07TicycMU1lP7aYHnibgxeecwXV0ScFW
        VqCroTJkpJcxB7BpZPrENbDtW+CbWqcohs9C3GUvxWCw5H7pOTiJ3TVpEcKtJUDn54CoIKgrlp5QV
        O8aBX5ftZXNA3NwtJjUE2aJEBYioX+CFYFF6KkbIPEcni5T91YCXGT1N2O+qtm11IpSkifZFbhT0a
        PLTf25fg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oy85c-008YNM-PD; Thu, 24 Nov 2022 09:00:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CB7B0300202;
        Thu, 24 Nov 2022 10:00:04 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7AEFD2B66523A; Thu, 24 Nov 2022 10:00:04 +0100 (CET)
Date:   Thu, 24 Nov 2022 10:00:04 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     Pengfei Xu <pengfei.xu@intel.com>, peter.zijlstra@intel.com,
        linux-kernel@vger.kernel.org, heng.su@intel.com,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [Syzkaller & bisect] There is "__perf_event_overflow" WARNING in
 v6.1-rc5 kernel in guest
Message-ID: <Y38ylOkbhoBEYZjD@hirez.programming.kicks-ass.net>
References: <Y3RbiRmAKrDlVCxC@xpf.sh.intel.com>
 <Y3Z5WTk+cvHSt0lf@hirez.programming.kicks-ass.net>
 <Y3hDYiXwRnJr8RYG@xpf.sh.intel.com>
 <Y342qkDw7yqA1VOD@hirez.programming.kicks-ass.net>
 <CANpmjNOfF92cGPbWxQy9zj__uBgoeuimWjt4ZH9v35Q=PJ3LXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNOfF92cGPbWxQy9zj__uBgoeuimWjt4ZH9v35Q=PJ3LXQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2022 at 09:31:10AM +0100, Marco Elver wrote:
> On Wed, 23 Nov 2022 at 16:05, Peter Zijlstra <peterz@infradead.org> wrote:

> > Subject: perf: Consider OS filter fail
> > From: Peter Zijlstra <peterz@infradead.org>
> > Date: Sat, 19 Nov 2022 10:45:54 +0800
> >
> > Some PMUs (notably the traditional hardware kind) have boundary issues
> > with the OS filter. Specifically, it is possible for
> > perf_event_attr::exclude_kernel=1 events to trigger in-kernel due to
> > SKID or errata.
> >
> > This can upset the sigtrap logic some and trigger the WARN.
> >
> > However, if this invalid sample is the first we must not loose the
> > SIGTRAP, OTOH if it is the second, it must not override the
> > pending_addr with an invalid one.
> >
> > Fixes: ca6c21327c6a ("perf: Fix missing SIGTRAPs")
> > Reported-by: Pengfei Xu <pengfei.xu@intel.com>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> > Link: https://lkml.kernel.org/r/Y3hDYiXwRnJr8RYG@xpf.sh.intel.com
> 
> Thanks, FWIW
> 
> Reviewed-by: Marco Elver <elver@google.com>
> 
> One thing I wondered was, if the event fired in the kernel due to
> skid, is the addr always some kernel address, or does this also depend
> on the type of PMU? In any case, we don't even want to risk leaking
> kernel addresses this way, so this looks sane.

That very much depends on the PMU and event. Most events will not fill
out ->addr at all, some memop specific events can, but only when
combined with PERF_SAMPLE_ADDR.

Typically it will then retain the address of the memop. On Intel it's
mostly just PEBS events that can provide the ADDR and they'll have less
such trouble. On AMD we have IBS that can do ADDR but I've forgotten
much about IBS. PowerPC64 also can do ADDR and there I've no clue.
