Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 447BC6CD461
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 10:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbjC2IUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 04:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbjC2IUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 04:20:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0858526E
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 01:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GjB9ZbCegMQhM5Q6LjfEh62fnlRUwmV++cEbAcHP2BI=; b=oM4lCOywwCWUrFGLg8ZghL1wvo
        kKoleikexrSL8RKjSRDfc6Ne+OI/CusTeNuNKcE4Yv3qzFl20jyzd/yqej5zI59o07XKu5JBMsdIW
        OXey2ZRG41zU1eq6XO/lYbIMK14FOQalgPZyk+XfF2ZUOzopEI2zG6SgdJ3OGLk1NBRTOm47UWkTV
        OH1JW/hiBxh9zb0Wdgr0CZhb8pfU9exdcVWgJsONZOQ42X0Ol8katRmECElxvGFjvsFjRkkSM0SgY
        q4rzKbbtE3sq22CDLiDjplPQ4mKPZD1RXfSFhPMUk+6NV+kOn3vwCIlh2kkXVpIAjKxgdbTfHIDFi
        1E2OKCow==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1phR0Z-009Exi-RK; Wed, 29 Mar 2023 08:18:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 527FB3002A3;
        Wed, 29 Mar 2023 10:18:14 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 348F02CB94EE8; Wed, 29 Mar 2023 10:18:14 +0200 (CEST)
Date:   Wed, 29 Mar 2023 10:18:14 +0200
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
Subject: Re: [PATCH 08/17] sched/fair: Implement an EEVDF like policy
Message-ID: <20230329081814.GN4253@hirez.programming.kicks-ass.net>
References: <20230328092622.062917921@infradead.org>
 <20230328110354.141543852@infradead.org>
 <CABk29Nt4T67S+L9Qs1qeOUyo5gY1Qy5KuOwuCYNM74E58J81Eg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABk29Nt4T67S+L9Qs1qeOUyo5gY1Qy5KuOwuCYNM74E58J81Eg@mail.gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 06:26:51PM -0700, Josh Don wrote:
> Hi Peter,
> 
> This is a really interesting proposal and in general I think the
> incorporation of latency/deadline is quite a nice enhancement. We've
> struggled for a while to get better latency bounds on performance
> sensitive threads in the face of antagonism from overcommit.

Right; so the big caveat is of course that these are virtual deadlines,
overcommit *will* push them out.

We have SCHED_DEADLINE that does the 'real' deadline thing ;-)

But what these virtual deadlines do is provide an order inside the
virtual time domain. It makes the whole preemption business well
defined. And with that, provides means to mix varying request sizes.
