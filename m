Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7AA86CD3B8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 09:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbjC2HwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 03:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjC2Hvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 03:51:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24DF6448A
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 00:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=jY38LTqzIyM8g2tsYN0SI+/xJUcF8dAkkx/8FMEqR4Q=; b=IWEh2QxTkrlWOMXYD5/U+Mb+sa
        GtbPEyG5AhMxwAUZBVjqnlGPpWWJscXQVjG14tBcILhoG5q9wi5m5+fNI+a9xuHe1XK5x4JNtLlOo
        EA4KtoDOV98YoepkZKdMgapTqFK7k3QtmGVU9/aXsYMOq/8zOCwyjnCAD3Axqdh25ZIKEnCqyRYjj
        +UkuiatphUKn4rEyVUBFlhL78rSUNWOYVBsA4N1PrB0D2ANUF2zZHO+sDQLSKVqeuxmHg0k1y3Hpq
        lUp8FnByA6R+nGzMBpp327bnuuZzT98ypQ42HnXCx7gL8qV95vyq0Q7uIJagsMHinCrPDNffOdVpo
        td4v2mvg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1phQa8-009Des-OS; Wed, 29 Mar 2023 07:50:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F219A3000E6;
        Wed, 29 Mar 2023 09:50:51 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D423D2CC7A022; Wed, 29 Mar 2023 09:50:51 +0200 (CEST)
Date:   Wed, 29 Mar 2023 09:50:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Don <joshdon@google.com>
Cc:     mingo@kernel.org, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, corbet@lwn.net,
        qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, pjt@google.com, pavel@ucw.cz,
        qperret@google.com, tim.c.chen@linux.intel.com, timj@gnu.org,
        kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org, efault@gmx.de
Subject: Re: [PATCH 04/17] sched/fair: Add avg_vruntime
Message-ID: <20230329075051.GJ4253@hirez.programming.kicks-ass.net>
References: <20230328092622.062917921@infradead.org>
 <20230328110353.853385546@infradead.org>
 <CABk29Nt-9MufWcyxr8=ghHDj_kUj21vkEw=4X10NpXncxN32uQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABk29Nt-9MufWcyxr8=ghHDj_kUj21vkEw=4X10NpXncxN32uQ@mail.gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 04:57:49PM -0700, Josh Don wrote:
> On Tue, Mar 28, 2023 at 4:06 AM Peter Zijlstra <peterz@infradead.org> wrote:
> [...]
> > +/*
> > + * Compute virtual time from the per-task service numbers:
> > + *
> > + * Fair schedulers conserve lag: \Sum lag_i = 0
> > + *
> > + * lag_i = S - s_i = w_i * (V - v_i)
> > + *
> > + * \Sum lag_i = 0 -> \Sum w_i * (V - v_i) = V * \Sum w_i - \Sum w_i * v_i = 0
> 
> Small note: I think it would be helpful to label these symbols
> somewhere :) Weight  and vruntime are fairly obvious, but I don't
> think 'S' and 'V' are as clear. Are these non-virtual ideal service
> time, and average vruntime, respectively?

Yep, they are. I'll see what I can do with the comments.
