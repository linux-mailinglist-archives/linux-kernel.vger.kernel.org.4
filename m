Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24E9C712AEE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 18:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236871AbjEZQoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 12:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjEZQoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 12:44:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA971B3;
        Fri, 26 May 2023 09:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0/P6scZPRnOZeTZnTWwHw9LDgqvXYUYrAKTqdy4If4E=; b=MXY6KBzRmwjin89VlNauNsRz4+
        2E3OVMOI7EA6gG2pYniBPc5cc5rU+3bGAtN3H7DAZvhulhVUbzz6vXhJHmxCP+rtITreDHevWibLV
        C0Qe/k70jTej0esoQZQbV5bAaAXu51LZvEIAqrl+qsfdx/2rAi+iCwQHJOa0tXSpWvI75RzxlJQiq
        NvA244XNtmIZUEdVSZ7ihpn/IKTJWWGs3axWMZBY45uwbDhpdB6K3n4Rc7d5tldzeCMz4nZYwBTZV
        7wWKe4TCT/R+NGbxIPK70SZxgJzP8Bj9JTwnjj+ZrD8hRCloaMAqqarZfzQAVvNMq/MXAbiTshvbs
        p7m3zusQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q2aXi-002xpM-5W; Fri, 26 May 2023 16:43:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B930D3002F0;
        Fri, 26 May 2023 18:43:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A107622163BD2; Fri, 26 May 2023 18:43:53 +0200 (CEST)
Date:   Fri, 26 May 2023 18:43:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, keescook@chromium.org,
        pbonzini@redhat.com, linux-kernel@vger.kernel.org,
        ojeda@kernel.org, ndesaulniers@google.com, mingo@redhat.com,
        will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        jiangshanlai@gmail.com, qiang1.zhang@intel.com,
        rcu@vger.kernel.org, tj@kernel.org, tglx@linutronix.de
Subject: Re: [RFC][PATCH 2/2] sched: Use fancy new guards
Message-ID: <20230526164353.GB4053578@hirez.programming.kicks-ass.net>
References: <20230526150549.250372621@infradead.org>
 <20230526151947.027972233@infradead.org>
 <2023052626-blunderer-delegator-4b82@gregkh>
 <d806769b-c568-fa7c-f7aa-ded9ffea11b4@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d806769b-c568-fa7c-f7aa-ded9ffea11b4@efficios.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 12:27:51PM -0400, Mathieu Desnoyers wrote:

> > Anyway, the naming is whack, but I don't have a proposed better name,
> > except you might want to put "scope_" as the prefix not the suffix, but
> > then that might look odd to, so who knows.
> 
> FWIW C++ has std::scoped_lock. So perhaps using a similar wording may help ?

Yeah, C++ is a lot more flexible than CPP crazies. But yeah, happy to
change it that way.
