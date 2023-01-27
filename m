Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC9C67E5FF
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 14:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234309AbjA0NC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 08:02:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233028AbjA0NC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 08:02:28 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9509010A97
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 05:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+zqX6OKw/Ppsz3ZSdGpcBXNTOd5a+3NHPvu0lMwwNT4=; b=ht7DN5ugga19inMN+et05B3+NL
        OwYcSg/8IIT1hWxFHz2ohQPJ+KxBCkCKBnVV2zNDH6lfePc4EZAiFqk+cwu96sjnC6/6MssAsLjGh
        jaYQoIkIrDDD+k+0K3XQZXdB7wmj4W8gdmPsihc/NBYxnZm234pff7u5hidyXqbVa342kSYQD2ecy
        qtT+i3dxhwcMtdvIAGKi5mpgAY3l2cOraLXhJGUIAfzUr2vlJ1inheQ7EvQMoyJuRuUus8rFhW9TF
        ZaDZH6+EqfUo8QoWJNRyt7BjZLPW92sIZhDAgGnfyCAbpRL7mPr9xAKOn4zIijHrCYFJ/DiEUgAIr
        carG192g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pLN98-002lcW-0w;
        Fri, 27 Jan 2023 11:43:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8046D300388;
        Fri, 27 Jan 2023 12:44:23 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 563F52083582A; Fri, 27 Jan 2023 12:44:23 +0100 (CET)
Date:   Fri, 27 Jan 2023 12:44:23 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Roman Kagan <rkagan@amazon.de>,
        Zhang Qiao <zhangqiao22@huawei.com>,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [bug-report] possible s64 overflow in max_vruntime()
Message-ID: <Y9O5Fwfib2CVAMwl@hirez.programming.kicks-ass.net>
References: <73e639d5-702b-0d03-16d9-a965b1963ef6@huawei.com>
 <Y6RRfF5yRew7rdCp@hirez.programming.kicks-ass.net>
 <Y9GG3N5ivVvyETa2@u40bc5e070a0153.ant.amazon.com>
 <Y9J25xMrItpeHIxD@hirez.programming.kicks-ass.net>
 <Y9LG5vkf/4ufJb35@u40bc5e070a0153.ant.amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9LG5vkf/4ufJb35@u40bc5e070a0153.ant.amazon.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 07:31:02PM +0100, Roman Kagan wrote:

> > All that only matters for small sleeps anyway.
> > 
> > Something like:
> > 
> >         sleep_time = U64_MAX;
> >         if (se->avg.last_update_time)
> >           sleep_time = cfs_rq_clock_pelt(cfs_rq) - se->avg.last_update_time;
> 
> Interesting, why not rq_clock_task(rq_of(cfs_rq)) - se->exec_start, as
> others were suggesting?  It appears to better match the notion of sleep
> wall-time, no?

Should also work I suppose. cfs_rq_clock takes throttling into account,
but that should hopefully also not be *that* long, so either should
work.
