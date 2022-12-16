Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C960264E9B2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 11:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbiLPKqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 05:46:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbiLPKq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 05:46:29 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37274614E
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 02:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uLavEFJ6ALT6buef2EWP5CDg/zwAhzOSJgnzWM94DQg=; b=blhREiUjsL2FEQVJcJB+iVlnpd
        a4wr9eFxlQSXG1+eSv7fpbcWr6Zoj7M71yhX2LpoDEvONrYGq9cvVnljDbQipYyCzaBjUA5C4EcCK
        nFSWJTrbDLI7mEy7BWry8NQ92NFJ3f1k/9Slp9wzDCD3brZp1aHEBy2GObovaK8dQtg0R1LYwCfd/
        Cg7+IVgowmQyXyngIgvKYRW2c42TinTxXYZDxbUjjTliEUcbeW7FpPz1J15iu60UzVFhhsj5VMpTb
        yn+Qjz3tvctX75GfGf0Ahe8sZt/Y6bUfLQpCTrG7/im/9JZffHlddvCrAt1RxjLNMNZePlCLal2l3
        5JIiyt1g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p68EL-00B7t2-G8; Fri, 16 Dec 2022 10:46:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4CCFC3001E7;
        Fri, 16 Dec 2022 11:46:15 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1C99A201D817F; Fri, 16 Dec 2022 11:46:15 +0100 (CET)
Date:   Fri, 16 Dec 2022 11:46:14 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched: Make const-safe
Message-ID: <Y5xMdt8jhSZQZ6uk@hirez.programming.kicks-ass.net>
References: <20221212144946.2657785-1-willy@infradead.org>
 <Y5mTJVi2PBix+Gy6@hirez.programming.kicks-ass.net>
 <Y5oP2Psz++gHholO@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5oP2Psz++gHholO@casper.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2022 at 06:03:04PM +0000, Matthew Wilcox wrote:
> On Wed, Dec 14, 2022 at 10:11:01AM +0100, Peter Zijlstra wrote:
> > On Mon, Dec 12, 2022 at 02:49:46PM +0000, Matthew Wilcox (Oracle) wrote:
> > > With a modified container_of() that preserves constness, the compiler
> > > finds some pointers which should have been marked as const.  task_of()
> > > also needs to become const-preserving for the !FAIR_GROUP_SCHED case so
> > > that cfs_rq_of() can take a const argument.  No change to generated code.
> > 
> > More const more better I suppose.. Thanks!
> > 
> > Happen to have a sha for the container_of() commit handy?
> 
> There isn't one yet.  Obviously we can't make container_of()
> const-preserving until we've fixed all the places which would warn.
> The diff I have in my tree looks like this:
> 
> diff --git a/include/linux/container_of.h b/include/linux/container_of.h
> index 1d898f9158b4..9416e6cc8c88 100644
> --- a/include/linux/container_of.h
> +++ b/include/linux/container_of.h
> @@ -20,7 +20,10 @@
>         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
>                       __same_type(*(ptr), void),                        \
>                       "pointer type mismatch in container_of()");       \
> -       ((type *)(__mptr - offsetof(type, member))); })
> +       __mptr -= offsetof(type, member);                               \
> +       _Generic(ptr,                                                   \
> +               const typeof(*(ptr)) *: (const type *)__mptr,           \
> +               default: ((type *)__mptr)); })

Ah nice. Thanks!
