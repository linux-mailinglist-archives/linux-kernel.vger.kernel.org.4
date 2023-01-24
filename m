Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD32679E8E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 17:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjAXQYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 11:24:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbjAXQYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 11:24:16 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B944C0ED
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 08:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=Qstzu33cxXJQwZ7Iyp/NN0AvcyewpE913OdPzhtWHSo=; b=PfgXbyTLXhy8syNH3Dgd2nquIb
        V0c1cTIo//tXTsjajv6kgzqv2wFwKWP6IgNpA+i3dG9EJVp06zuWaz/4NTAnk3+zedOEAVGHM/7Nx
        c9BQ1TtU7I1lyTAhgHSm5XqfbbQkreze2lNe5Rpn4k8kGMfncex1BZbZn5WgGzOEDq368KyCYNYdt
        ayjaF9zBBoiSWQjEJOTQzZKyO24B2y4hs4pa0TsPhiIa2jXAmsJp9RQt53T8zvMPmYHRdUooIC4rd
        RE1O/W/F5Jk+vf41os/y5r5SHkBa8yVxg97GssGcoVRll6mVH2CizywZWb5SAQbTyqQ0DBLS1kwoW
        ToQV1XHw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pKM4e-001t61-2c;
        Tue, 24 Jan 2023 16:23:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 25CE73001D6;
        Tue, 24 Jan 2023 17:23:34 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 102E92B877E72; Tue, 24 Jan 2023 17:23:34 +0100 (CET)
Date:   Tue, 24 Jan 2023 17:23:33 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/fpu: don't set TIF_NEED_FPU_LOAD for PF_IO_WORKER
 threads
Message-ID: <Y9AGBXf5mhZ5geGC@hirez.programming.kicks-ass.net>
References: <560c844c-f128-555b-40c6-31baff27537f@kernel.dk>
 <Y8/8CFwtpmjzdK9c@hirez.programming.kicks-ass.net>
 <b03383e3-cb10-8b70-a042-dbc2170ee3ec@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b03383e3-cb10-8b70-a042-dbc2170ee3ec@kernel.dk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 09:06:08AM -0700, Jens Axboe wrote:
> On 1/24/23 8:40 AM, Peter Zijlstra wrote:
> > On Tue, Jan 24, 2023 at 08:23:20AM -0700, Jens Axboe wrote:
> >> We don't set it on PF_KTHREAD threads as they never return to userspace,
> >> and PF_IO_WORKER threads are identical in that regard. As they keep
> >> running in the kernel until they die, skip setting the FPU flag on them.
> > 
> > No objection to the actual patch; but this changelog fails to tell us
> > why this is important.
> > 
> > What made you get up and write this patch :-) Presumably this is a
> > performance issue? If so, can you quantify how much?
> 
> You snipped the part where that was explained, but arguably that should
> probably go into the commit message itself:
> 
> "Not urgent, more of a cosmetic thing that was found while debugging and
> issue and pondering why the FPU flag is set on these threads."

Duh, I stopped reading at the --- just like a patch tool.. :/

> So it's not really a performance issue, it was just something odd that
> got me scratching my head when debugging another issue and poking at
> the flags.
> 
> Want a resend of it, or will you just augment the commit message?

I think tglx typically takes fpu patches, but sure can do.
