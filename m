Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E09F6CFDB3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 10:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjC3IFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 04:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjC3IFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 04:05:07 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58AF75252
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 01:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YGhdC+q7ft0r1pievkNlyzP9/ac5GlE6AqCSli2aS4E=; b=rUFHErHuH4DEVhBC5y/Hdumteh
        lRfE4uEFStoBpj6WOyHcDWDMjlCOTnwMMaVJux+CE45aZ3gfxlBnVldFWhW2LSTSiCNmivdVVLQDU
        w10Vm6MiklYD857IlybuyQN0L5L+z6RlBsYjySwpoQOzWzE6jRr4AEMwPb6N93WVLF97FTobzBPRH
        12LQub8Z1+nZpds27VYV9fuuJDDlfl4JqYDsPjgdv2abhHfydTOGz9AdOC6TqnbNxrWhHVpNWHhGd
        ZY9QGsOcQM4JF/UyPL8jTM+FFA5s9HWG0JU2ws3x+PTxiW0tUt/jtryvzDNmNaAldhXpym7Z2UO12
        yWeXKEJA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1phnEE-0076mI-0T;
        Thu, 30 Mar 2023 08:03:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1E05B300134;
        Thu, 30 Mar 2023 10:01:46 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EEE2A2421F039; Thu, 30 Mar 2023 10:01:45 +0200 (CEST)
Date:   Thu, 30 Mar 2023 10:01:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, corbet@lwn.net, qyousef@layalina.io,
        chris.hyser@oracle.com, patrick.bellasi@matbug.net, pjt@google.com,
        pavel@ucw.cz, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, timj@gnu.org, kprateek.nayak@amd.com,
        yu.c.chen@intel.com, youssefesmat@chromium.org,
        joel@joelfernandes.org, efault@gmx.de
Subject: Re: [PATCH 08/17] sched/fair: Implement an EEVDF like policy
Message-ID: <20230330080145.GA117836@hirez.programming.kicks-ass.net>
References: <20230328092622.062917921@infradead.org>
 <20230328110354.141543852@infradead.org>
 <CAKfTPtDDBVD_N6NgBYi_5iArDXd4iL0-ddQZDKGzzLAD-2AUXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtDDBVD_N6NgBYi_5iArDXd4iL0-ddQZDKGzzLAD-2AUXg@mail.gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 04:35:25PM +0200, Vincent Guittot wrote:

> IIUC how it works, Vd = ve + r / wi
> 
> So for a same weight, the vd will be earlier but it's no more alway
> true for different weight

Correct; but for a heavier task the time also goes slower and since it
needs more time, you want it to go first. But yes, this is weird at
first glance.

Let us consider a 3 task scenario, where one task (A) is double weight
wrt to the other two (B,C), and let them run one quanta (q) at a time.

Each step will see V advance q/4.

A: w=2, r=4q	B: w=1, r=4q	C: w=1, r=4q

  1) A runs -- earliest deadline

    A  |-------<
    B  |---------------<
    C  |---------------<
    ---+---+---+---+---+---+---+-----------
    V  ^

  2) B runs (tie break with C) -- A is ineligible due to v_a > V

    A    |-----<
    B  |---------------<
    C  |---------------<
    ---+---+---+---+---+---+---+-----------
    V   ^

  3) A runs -- earliest deadline

    A    |-----<
    B      |-----------<
    C  |---------------<
    ---+---+---+---+---+---+---+-----------
    V    ^

  4) C runs -- only eligible task

    A      |---<
    B      |-----------<
    C  |---------------<
    ---+---+---+---+---+---+---+-----------
    V     ^

  5) similar to 1)

    A      |---<
    B      |-----------<
    C      |-----------<
    ---+---+---+---+---+---+---+-----------
    V      ^

And we see that we get a very nice ABAC interleave, with the only other
possible schedule being ACAB.

By virtue of the heaver task getting a shorter virtual deadline it gets
nicely interleaved with the other tasks and you get a very consistent
schedule with very little choice.

Like already said, step 2) is the only place we had a choice, and if we
were to have given either B or C a shorter request (IOW latency-nice)
that choice would have been fully determined.

So increasing w gets you more time (and the shorter deadline causes the
above interleaving), while for the same w, reducing r gets you picked
earlier.

Perhaps another way to look at it is that since heavier tasks run more
(often) you've got to compete against it more often for latency.


Does that help?
