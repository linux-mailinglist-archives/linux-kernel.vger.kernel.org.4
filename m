Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 011F4633A54
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 11:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiKVKmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 05:42:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232905AbiKVKlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 05:41:01 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD9F12086
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 02:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8OLuatTl8W8izZo3kIWs/5oNNlgbjdJ4XjFgVvDoHos=; b=PAyHUlk29zVOfscRvAt5He09Tx
        m+VxlviX8Gs6+uUv5YtZj6stERGA+6lGTKzfiT7LIVwIpyWgY30Mvx8wFESA4li6Q5Nae9kZ8h0ko
        JG9IO/wo7+SD0mE9FnYJdhEnER5mVQ3UUqmOVJmlNqvjwzNS4Fdg3MdnuHxFkBSxnxwI1avHvztZi
        0IhxfE6yu+kCPE1qurmcO9GSxlJHxlJID/1KZIlizltAPv/kdUGt58TpCI5sHFFRWPkTOKMadmCK4
        1Rn6L2WHkCBPDK84ZMoo4PgH9miYre90zMDnD4AeYCoPV9382N5c1B2lDOauUCIeFru7SVgidPu8C
        sPmCVCoA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oxQd3-003Pcs-6x; Tue, 22 Nov 2022 10:35:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 90AAF300244;
        Tue, 22 Nov 2022 11:35:48 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5055B2D66C42E; Tue, 22 Nov 2022 11:35:48 +0100 (CET)
Date:   Tue, 22 Nov 2022 11:35:48 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Don <joshdon@google.com>
Cc:     Chengming Zhou <zhouchengming@bytedance.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Christian Brauner <brauner@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>
Subject: Re: [PATCH v3] sched: async unthrottling for cfs bandwidth
Message-ID: <Y3ymBOfRikUci/PD@hirez.programming.kicks-ass.net>
References: <20221117005418.3499691-1-joshdon@google.com>
 <Y3d+1a9AEnWaxFwq@hirez.programming.kicks-ass.net>
 <CABk29NtSmXVCvkdpymeam7AYmXhZy2JLYLPFTdKpk5g6AN1-zg@mail.gmail.com>
 <094299a3-f039-04c1-d749-2bea0bc14246@linux.dev>
 <Y3tn5wz6TjsqfGTA@hirez.programming.kicks-ass.net>
 <CABk29Nuyp=Ba=qiJAospx-SR2ZQM9GrKW0pDUeJ3sfgNB4uLFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABk29Nuyp=Ba=qiJAospx-SR2ZQM9GrKW0pDUeJ3sfgNB4uLFg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 11:37:14AM -0800, Josh Don wrote:
> Yep, this tradeoff feels "best", but there are some edge cases where
> this could potentially disrupt fairness. For example, if we have
> non-trivial W, a lot of cpus to iterate through for dispatching remote
> unthrottle, and quota is small. Doesn't help that the timer is pinned
> so that this will continually hit the same cpu.

We could -- if we wanted to -- manually rotate the timer around the
relevant CPUs. Doing that sanely would require a bit of hrtimer surgery
though I'm afraid.
