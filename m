Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72ED1733088
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 13:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344706AbjFPL5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 07:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345023AbjFPL4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 07:56:41 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8471730E0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 04:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sEjRgMfM502kXwVzt2PCdAyEOk9vobbMq2nfykcS1SA=; b=AYzskPJFu6JkFbtZhrjnmn4+7l
        rb29vkdKdpbLIU/Gbt9+fapM0vTM3asMrpHyxD3ACsN+VSVRA0d6MofTsr9FExb8b6ZnhM1IOh0OU
        Oa/k6rwgtYQ19K+T6djGMwc/yu76LjVwB3KfQPsVly2HzkA9l+kARzi1j/jF3bXOJVBmH7CzYoE5G
        WfD+W2LudbN+eTxTbreGgDvJVxNcW1w11M65kNuYqXQGg5q4BHdVJQzG5L0ujUhBaNaktHe5KiNsm
        mB8H9trNPy5aUF0m6+q+hsgk3QEytLsrc3ApPOz1jAIMpBo//WcQEw/wVcao2hGNtMG6dcmpb/pyL
        HRGArHDQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qA841-00CuPG-1Z;
        Fri, 16 Jun 2023 11:56:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9EC9630020B;
        Fri, 16 Jun 2023 13:56:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7DEF72C009B7C; Fri, 16 Jun 2023 13:56:24 +0200 (CEST)
Date:   Fri, 16 Jun 2023 13:56:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vineeth Pillai <vineeth@bitbyteword.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [RFC PATCH V3 6/6] sched/fair: Implement starvation monitor
Message-ID: <20230616115624.GL83892@hirez.programming.kicks-ass.net>
References: <cover.1686239016.git.bristot@kernel.org>
 <bd9977efff8cc3e002c4b2db02f611167905a99f.1686239016.git.bristot@kernel.org>
 <CAEXW_YT0DmvQo_gfCq5uzpZpf36HmfzXozo9+=sYJp-hZx4qTQ@mail.gmail.com>
 <b2cd0072-d226-4adb-ddf5-958d9635f881@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2cd0072-d226-4adb-ddf5-958d9635f881@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 04:45:54PM +0200, Daniel Bristot de Oliveira wrote:
> On 6/12/23 03:57, Joel Fernandes wrote:

> > Lastly, if the goal is to remove RT throttling code eventually, are
> > you also planning to remove RT group scheduling as well? Are there
> > users of RT group scheduling that might be impacted? On the other
> > hand, RT throttling / group scheduling code can be left as it is
> > (perhaps documenting it as deprecated) and the server stuff can be
> > implemented via a CONFIG option.
> 
> I think that the idea is to have the DL servers eventually replace the group
> schedule. But I also believe that it is better to start by solving the
> throttling and then moving to other constructions on top of the mechanism.

The big problem with the rt group scheduling mess is affinities. Other
than that, yes abosolutely, that crap needs to go.
