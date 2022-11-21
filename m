Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C50631E96
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 11:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiKUKjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 05:39:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiKUKjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 05:39:07 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A95B406A
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 02:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Q87RH7qpKjIQXmMoFhSNFkTPFmijDuVyKpBwqlEq9NM=; b=ITfnMAVyha7/sduoohAPyWQVi9
        mUk9Vfv9sHWvK4PRYlvxFS6qaEwfQT+bU+jzVzDD0Cfrp7nW91eP+ReyCer3LFOUc8HuLAKCZfcb1
        SiNKsgsaiPT/0vWdwelXx6wHeIXPg19vgyuiwYREuZK9RczQzbKNv0hoWimfTwJs3LtCLgcQhfybc
        BpnjDykd0JO59SR9utPkjFjEWT8IhBlHtmAqUiDqUxOjkfbVLvP7Dls/qs0XmSGR2Vh3LCN7qyymG
        00z1ZJJ0L6rTF42ny+WdrK2Tko++fBs0Hsltnmvey624Cgbhy7veo0X8eXZbxGc4BZctfKhsdDjAJ
        EThhGyUg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ox4CV-003531-Tk; Mon, 21 Nov 2022 10:38:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 02E8530045D;
        Mon, 21 Nov 2022 11:38:54 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id ADE822C28BC45; Mon, 21 Nov 2022 11:38:54 +0100 (CET)
Date:   Mon, 21 Nov 2022 11:38:54 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Phil Auld <pauld@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH-tip] sched: Don't call kfree() in do_set_cpus_allowed()
Message-ID: <Y3tVPjAjE9OFRLaP@hirez.programming.kicks-ass.net>
References: <20221118193302.522399-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221118193302.522399-1-longman@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 02:33:02PM -0500, Waiman Long wrote:
> Commit 851a723e45d1 ("sched: Always clear user_cpus_ptr in
> do_set_cpus_allowed()") may call kfree() if user_cpus_ptr was previously
> set. Unfortunately, some of the callers of do_set_cpus_allowed()

'some' ? There's only 3 or so, which one triggers this?

> may not be in a context where kfree() can be safely called. So the
> following splats may be printed:
> 
>    WARNING: possible circular locking dependency detected
>    BUG: sleeping function called from invalid context
> 
> To avoid these problems without leaking memory, the free cpumask is now
> put into a lockless list to be reused in a later sched_setaffinity()
> call instead.

Urgh.. depending on which of the callsites it is, it's probably simpler
to just rework the caller to not use do_set_cpus_allowed(), no?
