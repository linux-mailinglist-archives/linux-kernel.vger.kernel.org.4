Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A713C72F91A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 11:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244043AbjFNJ2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 05:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244015AbjFNJ16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 05:27:58 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9E82101
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 02:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VDebGFAjszJ5XxlaZqcuzZVx+4xABvp4FBCOBoh0wpk=; b=oVFOIK4NIs1FPvKm+/aEHyFM+j
        cRPcx5dQiV0T+ATXpvKSOXcsGC+nbTxY4G8QZSOD6bcRDCWS8zAPo0MiwUVf0pMMh6wIfrs+GIYEU
        dDJDfygNp1+D25051m/UJiAQyZioxKtuBBJx6xZBolTA+x1gnlB0s73TAx9kJUC/LMuqOk7qOi0s1
        udvv48BeWmxmmFz0Aeuc4eBF80p2PHMm8O+1riUcARsspO0/pkXey7HyRfbEdgJWdOvSob66mXqL4
        WdCusxBjVjpZkydMkpb0qgg5wDKGlajsHh5agAZp3lCK2FRS3UetZSnyq2zdYjyjz53Cvhk3/a5I9
        s4uiLljg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q9MmT-00AfgI-1t;
        Wed, 14 Jun 2023 09:27:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AB4F7300195;
        Wed, 14 Jun 2023 11:27:07 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 64B672C676971; Wed, 14 Jun 2023 11:27:07 +0200 (CEST)
Date:   Wed, 14 Jun 2023 11:27:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, joshdon@google.com,
        roman.gushchin@linux.dev, tj@kernel.org, kernel-team@meta.com
Subject: Re: [RFC PATCH 3/3] sched: Implement shared wakequeue in CFS
Message-ID: <20230614092707.GG1639749@hirez.programming.kicks-ass.net>
References: <20230613052004.2836135-1-void@manifault.com>
 <20230613052004.2836135-4-void@manifault.com>
 <20230613083203.GR4253@hirez.programming.kicks-ass.net>
 <20230614043529.GA1942@ziqianlu-dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614043529.GA1942@ziqianlu-dell>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 12:35:29PM +0800, Aaron Lu wrote:
> On Tue, Jun 13, 2023 at 10:32:03AM +0200, Peter Zijlstra wrote:
> > 
> > Still gotta read it properly, however:
> > 
> > On Tue, Jun 13, 2023 at 12:20:04AM -0500, David Vernet wrote:
> > > Single-socket | 32-core | 2-CCX | AMD 7950X Zen4
> > > Single-socket | 72-core | 6-CCX | AMD Milan Zen3
> > > Single-socket | 176-core | 11-CCX | 2-CCX per CCD | AMD Bergamo Zen4c
> > 
> > Could you please also benchmark on something Intel that has these stupid
> > large LLCs ?
> > 
> > Because the last time I tried something like this, it came apart real
> > quick. And AMD has these relatively small 8-core LLCs.
> 
> I tested on Intel(R) Xeon(R) Platinum 8358, which has 2 sockets and each
> socket has a single LLC with 32 cores/64threads.

> The lock contention due to the per-LLC swqueue->lock is quite serious:

Yep, that's what I was expecting -- complete meltdown that.
