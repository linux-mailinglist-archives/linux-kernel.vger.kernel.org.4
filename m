Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3396B2474
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 13:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjCIMoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 07:44:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbjCIMox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 07:44:53 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1465D8BA
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 04:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=r79Fbimdj09tdWSTQNPJOgYIW4iAPwvCGBNYsTfI7Do=; b=XvD37/zk/2W25TAZnm6kG7554E
        24X9WEyXScSl4kZIexji8wU4u47/dEYlBG7wxFknAlp3nmPuojkaeppt+6q3y7tpvbqjzFmq+8zqw
        fs/om6zLD+U/aJDe7phbw+G13v+QosXdUv0FWUUuLMkPUyQoFYt9zFcmq4Lh34jDDzwpo9yzCZo/7
        ahKnjmXqSO5n0WADoRPGcuc91iq6v7nadKxVxh/owGYjUrJf4cPGWMhJhPDtnrc2oNlDjOapsPCOQ
        ooGzJkCNlWnVe7c/w0jBiocgMFXMEdhZ8lszsSk/QCJKLbUnoB/mmmwDYZGmqXYygQvPM9SB8kuS/
        EVG0xQTQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1paFd3-008Prt-1B; Thu, 09 Mar 2023 12:44:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2B3D230030B;
        Thu,  9 Mar 2023 13:44:14 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F31622010B6C7; Thu,  9 Mar 2023 13:44:13 +0100 (CET)
Date:   Thu, 9 Mar 2023 13:44:13 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mike Galbraith <efault@gmx.de>
Cc:     mingo@kernel.org, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, corbet@lwn.net,
        qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, pjt@google.com, pavel@ucw.cz,
        qperret@google.com, tim.c.chen@linux.intel.com, joshdon@google.com,
        timj@gnu.org, kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org
Subject: Re: [PATCH 10/10] sched/fair: Implement an EEVDF like policy
Message-ID: <ZAnUnSEJ92bKpim7@hirez.programming.kicks-ass.net>
References: <20230306132521.968182689@infradead.org>
 <20230306141502.810909205@infradead.org>
 <bfbfbf041854e2cd1a8ed14e64081062e5d632d3.camel@gmx.de>
 <9fd2c37a05713c206dcbd5866f67ce779f315e9e.camel@gmx.de>
 <20230309090633.GK2017917@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230309090633.GK2017917@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 10:06:33AM +0100, Peter Zijlstra wrote:
> Hi Mike!
> 
> On Wed, Mar 08, 2023 at 02:36:01PM +0100, Mike Galbraith wrote:
> > On Wed, 2023-03-08 at 09:39 +0100, Mike Galbraith wrote:
> > >
> > > Curiosity got the best of me...
> > 
> > Remember this little bugger, allegedly distilled from a real
> > application control thread starvation issue?
> 
> Oooh, yeah, I should still have that somewhere. I'll try and remember
> what exactly was needed to make it behave properly.

That thing wants both wakeup preemption and sleeper bonus. Specifically,
it needs the signal to insta-preempt the 'pointless' kill loop.

What happens is that while positive lag, we get this, when negative lag
happens wakeup-preemption is not achieved and we get delayed by a full
tick.

This gets us very little actual runtime.

Let me see what do do about that...
