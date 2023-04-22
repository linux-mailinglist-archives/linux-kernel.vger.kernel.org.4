Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A80E6EB87E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 12:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbjDVKPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 06:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjDVKOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 06:14:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4286211D
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 03:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=az/+SNJkfuz6SKAsmyBKK6ylLWfMohDr3GAbdOAHiz4=; b=Yu7qjdgJxJvgIV65RKG2ktT+gr
        WAqJIg0gZbcHhnhyJ3vWUkkF5HqqwMrpwwEIJpW+xHoBawFkupuXb+PpGEnwl9zc+GlHAmaKZ/faR
        KB7EP9tLPZmN3lpFS5hhRLj+i3+vZjUAUXBn+kQqZ3m25/nPL7KFTIcNP3B6EMIunPV53vu1zizmh
        HFhOEvjvWEFgzNy0KKBm3mYBYtANH2clkOKnw6jWAXeFPia9pdnB/VLP+3VbGbArw93yPFJbmkrii
        oSqPkBkekCLHlCLmC1rj66inGc4x2cGs9ygS4arnYb1+lR0ADzW8NqZoZ1JGnrCJhKcTz1IuSdOIZ
        taY1DzHQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pqAGD-00G916-3l; Sat, 22 Apr 2023 10:14:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B0F4C300338;
        Sat, 22 Apr 2023 12:14:27 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9DEF623BD94B2; Sat, 22 Apr 2023 12:14:27 +0200 (CEST)
Date:   Sat, 22 Apr 2023 12:14:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     John Stultz <jstultz@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qyousef@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Connor O'Brien <connoro@google.com>
Subject: Re: [PATCH v3 09/14] sched: Split scheduler execution context
Message-ID: <20230422101427.GD1214746@hirez.programming.kicks-ass.net>
References: <20230411042511.1606592-1-jstultz@google.com>
 <20230411042511.1606592-10-jstultz@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411042511.1606592-10-jstultz@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 04:25:06AM +0000, John Stultz wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> Lets define the scheduling context as all the scheduler state in
> task_struct and the execution context as all state required to run the
> task.
> 
> Currently both are intertwined in task_struct. We want to logically
> split these such that we can run the execution context of one task
> with the scheduling context of another.
> 
> To this purpose introduce rq_selected() to point to the task_struct
> used for scheduler state and preserve rq_curr() to denote the execution
> context.

I can't say I like the rq_selected() naming :/
