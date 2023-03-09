Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F406B1F6A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 10:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjCIJIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 04:08:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjCIJHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 04:07:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C7B1CAC3
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 01:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1ZD3lt/MH5W34XvuRF34W10M07Y5nYfDU7o1d6UGiik=; b=rOUZtILXyyKL2Evjx/mvtywMuv
        P4pY8hS30/n9P6p/oTwLYiZg+1K5DTTwBWyGOhvKS0VG7U7E63ZRzBRGz3upyauOBcWUS+uVsIZ0I
        AgUJoQ5Bhm/6x9zbpIrV8JJIRcU+0hudlWFRoRjRHE3ovvt/E3edLsGS7AIKz6DhSwgW2Znb5whsL
        C9B+VN6+4z81KH5l/2F3iLio3QspjH2aFlzmsxRD4rXK3u4WGwneKD9xG8yVIKFm9z2UPz1jkA6+d
        8A3q+ScNutcpc5C/TtgW9fLGpyWCMZYWXGtq/oAqeI1viMhCr4XSfUxQJpE3acYDbrKYSXflO0Q9Y
        WRM3GXeQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1paCEN-008GU5-F5; Thu, 09 Mar 2023 09:06:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4E6AF30030B;
        Thu,  9 Mar 2023 10:06:33 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 342252010B6C7; Thu,  9 Mar 2023 10:06:33 +0100 (CET)
Date:   Thu, 9 Mar 2023 10:06:33 +0100
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
Message-ID: <20230309090633.GK2017917@hirez.programming.kicks-ass.net>
References: <20230306132521.968182689@infradead.org>
 <20230306141502.810909205@infradead.org>
 <bfbfbf041854e2cd1a8ed14e64081062e5d632d3.camel@gmx.de>
 <9fd2c37a05713c206dcbd5866f67ce779f315e9e.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fd2c37a05713c206dcbd5866f67ce779f315e9e.camel@gmx.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike!

On Wed, Mar 08, 2023 at 02:36:01PM +0100, Mike Galbraith wrote:
> On Wed, 2023-03-08 at 09:39 +0100, Mike Galbraith wrote:
> >
> > Curiosity got the best of me...
> 
> Remember this little bugger, allegedly distilled from a real
> application control thread starvation issue?

Oooh, yeah, I should still have that somewhere. I'll try and remember
what exactly was needed to make it behave properly.

Thanks for your feedback. I'll go prod at things a bit more. Like I
wrote, the code is more or less at the point where it stopped crashing
and doing obviously bad things. It definitely needs a more attention.


