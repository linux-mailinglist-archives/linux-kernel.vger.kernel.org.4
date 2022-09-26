Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB345EA99F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 17:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234933AbiIZPH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 11:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234117AbiIZPFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 11:05:31 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D4ED70F9;
        Mon, 26 Sep 2022 06:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nITPYkhiQSASd/MBANOu6ZY1JaJ2D7mfRTlbFizAq1Q=; b=M27OC6mbY14hs43Q+3USZW4mwQ
        tfYCHnPW0UGV5ubIcF91Ihyzgh6P0XtjDrQuNlKn+1tfvks/bzQr3+/CHLvyJrfgsoUkJ3gG2teHu
        2JTPR/RONDBbFlm608/9434IZF0nT35NB55R3z++eDVgf6R+JC1i7qacPeDtx9HPh7bU9O7zp6jUx
        gk/i+qUbd/lVfEXX3gG2obaRAQoMZNgS3uvvwbJNPfMsPByzZ37xHMv9nXqZ88JAU6sV39eezKF9Z
        rULZl2hbDuz7wywOd9l5tTLSBl14DraCgoPMplYK9mHQpw7gBOaX43ETvqbROTs9ocRGIo3R8lMki
        iK8uknYw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ocoIp-00G25A-Ni; Mon, 26 Sep 2022 13:37:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 674353001D6;
        Mon, 26 Sep 2022 15:37:42 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1F6A9205B02A9; Mon, 26 Sep 2022 15:37:42 +0200 (CEST)
Date:   Mon, 26 Sep 2022 15:37:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christian Borntraeger <borntraeger@linux.ibm.com>
Cc:     bigeasy@linutronix.de, dietmar.eggemann@arm.com,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, mgorman@suse.de, mingo@kernel.org,
        oleg@redhat.com, rjw@rjwysocki.net, rostedt@goodmis.org,
        tj@kernel.org, vincent.guittot@linaro.org, will@kernel.org,
        Marc Hartmayer <mhartmay@linux.ibm.com>,
        Amit Shah <amit@kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH v3 6/6] freezer,sched: Rewrite core freezer logic
Message-ID: <YzGrJSLXpocpGIha@hirez.programming.kicks-ass.net>
References: <20220822114649.055452969@infradead.org>
 <20220923072104.2013212-1-borntraeger@linux.ibm.com>
 <56576c3c-fe9b-59cf-95b8-158734320f24@linux.ibm.com>
 <b1d41989-7f4f-eb1d-db35-07a6f6b7a7f5@linux.ibm.com>
 <436fa401-e113-0393-f47a-ed23890364d7@linux.ibm.com>
 <39dfc425-deff-2469-7bcb-4a0e177b31d1@linux.ibm.com>
 <YzGhUZJKV3pKJL3Z@hirez.programming.kicks-ass.net>
 <66463973-923f-624d-3041-72ce76147b3e@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66463973-923f-624d-3041-72ce76147b3e@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 03:23:10PM +0200, Christian Borntraeger wrote:
> Am 26.09.22 um 14:55 schrieb Peter Zijlstra:
> 
> > Could you please test with something like the below on? I can boot that
> > with KVM, but obviously I didn't suffer any weirdness to begin with :/
> > 
> > ---
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 4e6a6417211f..ef9ccfc3a8c0 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -4051,6 +4051,8 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
> >   	unsigned long flags;
> >   	int cpu, success = 0;
> > +	WARN_ON_ONCE(state & TASK_FREEZABLE);
> > +
> >   	preempt_disable();
> >   	if (p == current) {
> >   		/*
> 
> Does not seem to trigger.

Moo -- quite the puzzle this :/ I'll go stare at it more then.
