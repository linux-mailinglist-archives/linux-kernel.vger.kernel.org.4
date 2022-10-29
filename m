Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4DC86122E5
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 14:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiJ2MX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 08:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiJ2MXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 08:23:51 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173A24E427
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 05:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FC4EB+hd0yrq+0XcvsbYagvFo+Z+RA4lu4aEhMuLAuQ=; b=CRwUYVgNEloj2ysmFXj7rE43qJ
        jWm+3INTZ/C/mBNJP+sZ3Fgpn6Fiu000lStK4h3acmquopPlR0GXLK9+J+2dvA/u5VWV98bXOFVOT
        4bTkdOFxE9foaanNeGdJ0VgyMkg8c/nxsCI1D18WDxtXzolxj+yraNjsIbBvSGyLyybnyQ8eXF8IP
        feS9pZHQ1S8WGfDaZfl7a2F9jQhxMNnjM/SmrcuwA3YFyxsB1DGgZD+QscGFYJB6aByWjNtDNRRWx
        XL56n0Qb56/pDaSPPPJbVvkveJY/FahbYqZW85pD4W7UkesSXv2kJ+o/tRBBv5sszu5xpaPgxJ6FM
        fIpsqbsQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ooks2-007Ll4-Jq; Sat, 29 Oct 2022 12:23:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2776530035C;
        Sat, 29 Oct 2022 14:23:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D4EC12C67B21C; Sat, 29 Oct 2022 14:23:24 +0200 (CEST)
Date:   Sat, 29 Oct 2022 14:23:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     "mingo@redhat.com" <mingo@redhat.com>, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rohit.k.jain@oracle.com,
        dietmar.eggemann@arm.com, Steven Rostedt <rostedt@goodmis.org>,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Regression on vcpu_is_preempted()
Message-ID: <Y10bPHJh7g+4OW4k@hirez.programming.kicks-ass.net>
References: <89856431-e68b-ebe9-90cb-e46ed8065659@huawei.com>
 <Y1zrNKEUPRem/UUI@hirez.programming.kicks-ass.net>
 <d00f7b30-4b34-3d3d-98c5-d0db1a5d9c4f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d00f7b30-4b34-3d3d-98c5-d0db1a5d9c4f@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 29, 2022 at 05:15:15PM +0800, Miaohe Lin wrote:
> On 2022/10/29 16:58, Peter Zijlstra wrote:
> > On Fri, Oct 28, 2022 at 04:48:21PM +0800, Miaohe Lin wrote:
> >>   When scheduler tries to select a CPU to run the gc thread,
> >>   available_idle_cpu() will check whether vcpu_is_preempted().  It
> >>   will choose other vcpu to run gc threads when the current vcpu is
> >>   preempted. But the preempted vcpu has no other work to do except
> >>   continuing to do gc. In our guest, there are more vcpus than java gc
> >>   threads. So there could always be some available vcpus when
> >>   scheduler tries to select a idle vcpu (runing on host). This leads
> >>   to lots of cpu migrations and results in regression.
> >>
> >>   I'm not really familiar with this mechanism. Is this a problem that
> >>   needs to be fixed or improved? Or is this just expected behavior?
> >>   Any response would be really appreciated!
> > 
> > This is pretty much expected behaviour. When a vCPU is preempted the
> > guest cannot know it's state or latency. Typically in the overcomitted
> > case another vCPU will be running on the CPU and getting our vCPU thread
> > back will take a considerable amount of time.
> 
> I see. Many thanks for your kindly reply and explanation. :)
> 
> > 
> > If you know you're not over-committed, perhaps you should configure your
> > VM differently.
> 
> Do you have any suggestion about how should I configure my VM when it's not over-committed?

I'm not an expert on VMs, but IIRC when you construct a pinned VM (ie.
1:1 vCPU:CPU relations) this all goes away.
