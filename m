Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 120C06B2722
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 15:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbjCIOib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 09:38:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231924AbjCIOhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 09:37:41 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE431F8A45
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 06:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LrCcOkh6nhKY3npOQKBTaiygFlEJ4Tkt6x5iuD6IWpc=; b=iu/9WN05SkPZSoxKa0mSYFQDUi
        0f1XswPe3O0OETLlQYy/9+HDp2TGld/wj0J6Dh4Mld6su6QBW/cJCdJtT6XjchcdRfGkitO+hA2tR
        bxFh5yrGwwSceAkiHZwVWIGGxmF03C7ZfSdbEmif4V6G+/E61yTixzgNOxkftkrFmr2zSPuWF26OY
        HhH7/Lo0ekS/2Z3KxOZ4nMGPGtRKwdhilxtRpZLzoFLTxoL6IN35mRyzn9nH2IPECku1zAg3z/Z5l
        jrGXyuyo0ENSeeJrwzGUAzJI9PnEDWrGIEp++whSQZdYlnvpFkuK2FY9yw+VIUdyNM21sVphiWbzd
        DkWBGjKg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1paHO7-0008oJ-1i;
        Thu, 09 Mar 2023 14:36:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6C2E33002C0;
        Thu,  9 Mar 2023 15:36:56 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 52E142CE67A54; Thu,  9 Mar 2023 15:36:56 +0100 (CET)
Date:   Thu, 9 Mar 2023 15:36:56 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Zhang Qiao <zhangqiao22@huawei.com>, linux-kernel@vger.kernel.org,
        mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, rkagan@amazon.de
Subject: Re: [PATCH v2] sched/fair: sanitize vruntime of entity being migrated
Message-ID: <ZAnvCGdlOrWbIC/o@hirez.programming.kicks-ass.net>
References: <20230306132418.50389-1-zhangqiao22@huawei.com>
 <20230309130524.GA273121@hirez.programming.kicks-ass.net>
 <CAKfTPtAf5RrzZRSHtfK+r3QvnFQ-oM3+rJ-z5SB8T4+nUv1aQw@mail.gmail.com>
 <20230309142825.GB273121@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230309142825.GB273121@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 03:28:25PM +0100, Peter Zijlstra wrote:
> On Thu, Mar 09, 2023 at 02:34:05PM +0100, Vincent Guittot wrote:
> 
> > Then, even if we don't clear exec_start before migrating and keep
> > current value to be used in place_entity on the new cpu, we can't
> > compare the rq_clock_task(rq_of(cfs_rq)) of 2 different rqs AFAICT
> 
> Blergh -- indeed, irq and steal time can skew them between CPUs :/
> I suppose we can fudge that... wait_start (which is basically what we're
> making it do) also does that IIRC.
> 
> I really dislike having this placement muck spreadout like proposed.

Also, I think we might be over-engineering this, we don't care about
accuracy at all, all we really care about is 'long-time'.


