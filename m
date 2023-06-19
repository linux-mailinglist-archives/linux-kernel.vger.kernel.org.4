Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00DAA73565C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 14:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbjFSMCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 08:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjFSMCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 08:02:32 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C55A11D
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 05:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qa+vS4eBLwHQzXvRvXGPmsksUe4kxzWk6YpXlGn9Oyk=; b=cklv7UXKujqrKzsZTk/OOs2rX9
        Z3ByfDFcmcJ4n6tfsFtg2UP0Z0TOoB+/VKJzFazKm3XW8V/6nJdFLvyjVPE0Tg4+WkN1KjBGlB4YF
        RZszpFv8yYMQ7f+my/2KIQF3TlT5MgEUz1T9M3Hmy8hnS+9HjsOxXPnK12EdgEsORJzWQGZIB4E9I
        8gr5hhpttMHFp3vGOswOdb1gDa4dCKlMnYiabZYILY/1yV33CjmaDGFE4VaiJzzmWD0cbzceGJei3
        FlaHSVRKWEioC6ZnKcX7ZL+l+J6TeA7u0Rqw+PTZygh6EpJGRNbc2bYdXfcQlFlvkysOoBaLxKPLZ
        G2+xQ3cA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qBDaL-00EiUv-1s;
        Mon, 19 Jun 2023 12:02:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BCFEB300322;
        Mon, 19 Jun 2023 14:02:15 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A0FF6201AF169; Mon, 19 Jun 2023 14:02:15 +0200 (CEST)
Date:   Mon, 19 Jun 2023 14:02:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vineeth Pillai <vineeth@bitbyteword.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [RFC PATCH V3 6/6] sched/fair: Implement starvation monitor
Message-ID: <20230619120215.GO38236@hirez.programming.kicks-ass.net>
References: <cover.1686239016.git.bristot@kernel.org>
 <bd9977efff8cc3e002c4b2db02f611167905a99f.1686239016.git.bristot@kernel.org>
 <CAEXW_YT0DmvQo_gfCq5uzpZpf36HmfzXozo9+=sYJp-hZx4qTQ@mail.gmail.com>
 <b2cd0072-d226-4adb-ddf5-958d9635f881@kernel.org>
 <CAEXW_YR9Tfw5KyFU7TQtYE02k+DpaMXH=osx9Ws5w_j1YpHxhg@mail.gmail.com>
 <841849b5-1f9c-4f0e-2de8-1da278256888@kernel.org>
 <20230616120507.GM83892@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616120507.GM83892@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 02:05:07PM +0200, Peter Zijlstra wrote:
> On Tue, Jun 13, 2023 at 03:41:30PM +0200, Daniel Bristot de Oliveira wrote:
> 
> > In an 0-laxity scheduler, the server would run at 0-laxity, jumping in
> > front of DL tasks... that would break EDF. It would be mixing two
> > schedulers in one. It is not required and likely not a good idea either.
> 
> I did consider a hybrid 0-laxity and EDF scheduler for mixed
> criticality, as have others like Ted Baker IIRC. IIRC it can be done
> using an augmented tree, but none of that solves the problems 0-laxity
> has (like over preemption and the general problem of playing chicken by
> doing things at the *VERY* last possible moment).
> 
> I think I did a talk at OSPERT on this at some point many years ago.
> Luckily some bright fellow had this semi-partitioned stuff that would
> make live much simpler :-)

I must clarify; I was thinking Least-Laxity-First, which is ofcourse not
the same as a 0-laxity scheduler.
