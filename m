Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2961A633A32
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 11:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233262AbiKVKed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 05:34:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233408AbiKVKd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 05:33:59 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FEF210D1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 02:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vtH0yseOVQYv3RaqERkKZPWbpLpc7sWrd6t0H8JpkxE=; b=RJQAa+yvtu2FU88R+sf0GePhIE
        H4RhNvOLd3dtAaHbK86srNGpXeOCQ1aL5xVi0KbdkkSk6i4djT7HVmYmhBE95yzbzj2o5rRdBzLA3
        pPrucsYB3+IKsFHTCd9HLo6FJ/I5JPeJINP5Okco6jihxVLI/37tSvV2ocetTM4rG1Xvy6E+kA0zm
        QNKVukRaDo37ND90VqHPjugAQBqrblqYXoOxSQFkDEreeljyy5vTdqa8Kcf0WEs7TwkK4Xb+lluI8
        BpQN5mVtMUq5K2Rc4+rxhhCZAO5tUBG4k0sctM2UDoFBF8SZfhL6Xm1QHfhj5/QTV9pmOB2vovR9N
        iVK00Sbw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oxQXt-003PWl-1B; Tue, 22 Nov 2022 10:30:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1814B300282;
        Tue, 22 Nov 2022 11:30:28 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EAD8E20136B62; Tue, 22 Nov 2022 11:30:27 +0100 (CET)
Date:   Tue, 22 Nov 2022 11:30:27 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Don <joshdon@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
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
Message-ID: <Y3ykw85UojmwW3YD@hirez.programming.kicks-ass.net>
References: <20221117005418.3499691-1-joshdon@google.com>
 <Y3d+1a9AEnWaxFwq@hirez.programming.kicks-ass.net>
 <CABk29NtSmXVCvkdpymeam7AYmXhZy2JLYLPFTdKpk5g6AN1-zg@mail.gmail.com>
 <Y3twWYeAW6U2/D92@hirez.programming.kicks-ass.net>
 <CABk29Nsxg2AvUzsvn4kLpE8rzWRJNt-EKwFi1HcK7c6uY_oUUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABk29Nsxg2AvUzsvn4kLpE8rzWRJNt-EKwFi1HcK7c6uY_oUUA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 11:31:20AM -0800, Josh Don wrote:
> > Please test the final version as found here:
> >
> >   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?h=sched/core&id=4e3c1b7b489e218dfa576cd6af0680b975b8743e
> 
> Thanks Peter, the patch looks good to me and continues to work
> correctly. Note that I needed to make two edits to get it to build
> though on sched/core:
> 
> - local_cfq_rq doesn't match variable name used in function (local_unthrottle)
> - rq_lock_irqrestore -> rq_unlock_irqrestore

Bah; and here I throught the .config I build actually had this crud
enabled. Oh well.. fixed that, will push out shortly.
