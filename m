Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2746B26E4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 15:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbjCIO26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 09:28:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbjCIO2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 09:28:50 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B247DE1CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 06:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AadkNC44WK1My3M28H4tBnjNA7h/634PKtIiMh0VNac=; b=IWviibnW4ABTgX5tJHci0raI/Z
        LHvyI1lXqgG1MsJtF8aTLu4ZJy5rIczCKBCSYRGmwv7HYJ8Nmaygv73jyrsDsP/uqtY4hBJOVTwwK
        rmcx0AxhvSRqu/PJHm8eVHFOEEvQQ2/lhHpPFHAv6Hlt8r7EV9dn0bGj/8SqucQqQmfx3vsNQ+SYV
        eDxNC79LozzJ6rvjESV9haA1WwcZFgkus59AcQ1hiZ54strtQ/4Zi+9dEegO5h5SDc7PdOKEoXxjq
        WLoMDay06hLT8Zel5ELii3GLcYAvVMOK5Rd6H2cJYB6+REIz/WjT0YHqh9ZU7Tz7zSdqx4lswNY7o
        p1xZV+YA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1paHFr-008UPk-5e; Thu, 09 Mar 2023 14:28:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 504EC300033;
        Thu,  9 Mar 2023 15:28:25 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 279742CE64A06; Thu,  9 Mar 2023 15:28:25 +0100 (CET)
Date:   Thu, 9 Mar 2023 15:28:25 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Zhang Qiao <zhangqiao22@huawei.com>, linux-kernel@vger.kernel.org,
        mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, rkagan@amazon.de
Subject: Re: [PATCH v2] sched/fair: sanitize vruntime of entity being migrated
Message-ID: <20230309142825.GB273121@hirez.programming.kicks-ass.net>
References: <20230306132418.50389-1-zhangqiao22@huawei.com>
 <20230309130524.GA273121@hirez.programming.kicks-ass.net>
 <CAKfTPtAf5RrzZRSHtfK+r3QvnFQ-oM3+rJ-z5SB8T4+nUv1aQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtAf5RrzZRSHtfK+r3QvnFQ-oM3+rJ-z5SB8T4+nUv1aQw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 02:34:05PM +0100, Vincent Guittot wrote:

> Then, even if we don't clear exec_start before migrating and keep
> current value to be used in place_entity on the new cpu, we can't
> compare the rq_clock_task(rq_of(cfs_rq)) of 2 different rqs AFAICT

Blergh -- indeed, irq and steal time can skew them between CPUs :/
I suppose we can fudge that... wait_start (which is basically what we're
making it do) also does that IIRC.

I really dislike having this placement muck spreadout like proposed.

> side note, why do we reset exec_start ? Is it only to make task_hot
> returns false ?

Yeah, god aweful hack.


