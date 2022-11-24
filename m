Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944F263768C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 11:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiKXKeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 05:34:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKXKeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 05:34:22 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5565CF72D6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 02:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=B+aYhj6mJgZyjtT6amKhJNb34Op/BURtXrqh3ehtpEg=; b=SCTHoQRT//4wfF/fbwAYC3GB2M
        xY1Gn7m7b0RjklR3O+3jGfrwUPYYTkmRmGpHZHS9/0h/w4uhKShwvTP9MA/zvN6IQiEshvbbiJFsJ
        UHiuIaiPMoxGgjVN0LYm/DksgINaB8wtMFcSE+qt5J7oAMiDr8k8H/kjMJ93QTgS6IjkxXBLKiyJ9
        LQuq28u01Z/FvN5LlFZttEmqTr395cWCJztIPHMq1CfkZ0N12TbAnAo0TrAXoskIyhXuAyUZgjWgP
        DU3ZTzAR+7gzQNZP5VzmPclH4uPj0RUeIUprYL+MkXOr1C/g3uWk7zkSZGI+CnNDQZaeTTeUbkWOI
        KyL3zikA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oy9Yg-008cBM-7t; Thu, 24 Nov 2022 10:34:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 58DE230004F;
        Thu, 24 Nov 2022 11:34:08 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E4F262C47F17D; Thu, 24 Nov 2022 11:34:07 +0100 (CET)
Date:   Thu, 24 Nov 2022 11:34:07 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     Pengfei Xu <pengfei.xu@intel.com>, peter.zijlstra@intel.com,
        linux-kernel@vger.kernel.org, heng.su@intel.com,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [Syzkaller & bisect] There is "__perf_event_overflow" WARNING in
 v6.1-rc5 kernel in guest
Message-ID: <Y39InxmwK88yKkyp@hirez.programming.kicks-ass.net>
References: <Y3RbiRmAKrDlVCxC@xpf.sh.intel.com>
 <Y3Z5WTk+cvHSt0lf@hirez.programming.kicks-ass.net>
 <Y3hDYiXwRnJr8RYG@xpf.sh.intel.com>
 <Y342qkDw7yqA1VOD@hirez.programming.kicks-ass.net>
 <CANpmjNOfF92cGPbWxQy9zj__uBgoeuimWjt4ZH9v35Q=PJ3LXQ@mail.gmail.com>
 <Y38ylOkbhoBEYZjD@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y38ylOkbhoBEYZjD@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2022 at 10:00:04AM +0100, Peter Zijlstra wrote:
> On Thu, Nov 24, 2022 at 09:31:10AM +0100, Marco Elver wrote:
> > On Wed, 23 Nov 2022 at 16:05, Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > > Subject: perf: Consider OS filter fail
> > > From: Peter Zijlstra <peterz@infradead.org>
> > > Date: Sat, 19 Nov 2022 10:45:54 +0800
> > >
> > > Some PMUs (notably the traditional hardware kind) have boundary issues
> > > with the OS filter. Specifically, it is possible for
> > > perf_event_attr::exclude_kernel=1 events to trigger in-kernel due to
> > > SKID or errata.
> > >
> > > This can upset the sigtrap logic some and trigger the WARN.
> > >
> > > However, if this invalid sample is the first we must not loose the
> > > SIGTRAP, OTOH if it is the second, it must not override the
> > > pending_addr with an invalid one.
> > >
> > > Fixes: ca6c21327c6a ("perf: Fix missing SIGTRAPs")
> > > Reported-by: Pengfei Xu <pengfei.xu@intel.com>
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> > > Link: https://lkml.kernel.org/r/Y3hDYiXwRnJr8RYG@xpf.sh.intel.com
> > 
> > Thanks, FWIW
> > 
> > Reviewed-by: Marco Elver <elver@google.com>
> > 
> > One thing I wondered was, if the event fired in the kernel due to
> > skid, is the addr always some kernel address, or does this also depend
> > on the type of PMU? In any case, we don't even want to risk leaking
> > kernel addresses this way, so this looks sane.
> 
> That very much depends on the PMU and event. Most events will not fill
> out ->addr at all, some memop specific events can, but only when
> combined with PERF_SAMPLE_ADDR.
> 
> Typically it will then retain the address of the memop. On Intel it's
> mostly just PEBS events that can provide the ADDR and they'll have less
> such trouble. On AMD we have IBS that can do ADDR but I've forgotten
> much about IBS. PowerPC64 also can do ADDR and there I've no clue.

This is also not taking CPU Errata into consideration; there's plenty of
them where the OS filter is 'delayed', in which case you get actual
kernel samples in your 'user only' stream.
