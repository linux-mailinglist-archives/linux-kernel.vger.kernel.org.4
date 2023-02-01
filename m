Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9F8F68624A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 10:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjBAJD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 04:03:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjBAJDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 04:03:54 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DC6199E1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 01:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+6lBzAzYUDLtb1/53bE7o1+u8f0NnSXZC2nk3HkkMg0=; b=cvFdg3K/a4i1JC02Kk3pA0XT3i
        abS83KqcdG0CZzEnqHiOKeDk4nSsBjOvoK/UZEkiwyTJK0msDlzF628wmNM4bHgMwFlLOFnV/F2m3
        KeMoRGY3xaZmqZE3hcpbORZz6CftMjJmaePadvCKcWlikG4YIg83k+XBimKoME4VFXxTFaLvJGB1S
        oQDcdN2pGnytU2plmVhntAoMOzVEjOrvz6MWo5DFaPtaeOXB4zJ8G5Xsen6BVQbvJ2ocZoapwP8Lg
        QW4gHhZzDbGutWyDJS566N0sD/CW95k3YvbuAfwsWKiZM1wy6Hi/qUAN6g+kUA2VRIKmnxfF0uF4Q
        CQCg4S2w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pN916-004hvJ-0W;
        Wed, 01 Feb 2023 09:02:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9117930012F;
        Wed,  1 Feb 2023 10:03:28 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 64C9D20D6DE1A; Wed,  1 Feb 2023 10:03:28 +0100 (CET)
Date:   Wed, 1 Feb 2023 10:03:28 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Yu Liao <liaoyu15@huawei.com>, fweisbec@gmail.com,
        mingo@kernel.org, liwei391@huawei.com, adobriyan@gmail.com,
        mirsad.todorovac@alu.unizg.hr, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] tick/nohz: fix data races in get_cpu_idle_time_us()
Message-ID: <Y9oq4OSJXJvr56Oj@hirez.programming.kicks-ass.net>
References: <20230128020051.2328465-1-liaoyu15@huawei.com>
 <87357q228f.ffs@tglx>
 <Y9lyx38kHmKEF5CQ@hirez.programming.kicks-ass.net>
 <Y9mEB7LMaZ0dMQS/@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9mEB7LMaZ0dMQS/@lothringen>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 10:11:35PM +0100, Frederic Weisbecker wrote:
> On Tue, Jan 31, 2023 at 08:57:59PM +0100, Peter Zijlstra wrote:
> > On Tue, Jan 31, 2023 at 03:44:00PM +0100, Thomas Gleixner wrote:
> > 
> > > P.S.: I hate the spinlock in the idle code path, but I don't have a
> > >       better idea.
> > 
> > seqcount? It would avoid the obvious interleave and put most of the onus
> > on the reader (which never happens anyway).
> 
> Yep, and do the update locally only on idle exit. But note that neither
> seqcount nor spinlock will fix the nr_iowait_cpu() based thing. This counter
> can be decremented remotely even during the idle period so the reader
> can see an iowait period that may eventually be accounted as !iowait,
> or the reverse. Breaking the monotonicity and even coherency.
> 
> That stuff is broken by design and this is the reason why it got never
> really fixed. The seqcount/spinlock would make it just a bit less worse.

Yeah, iowait is a random number generator, -EWONTFIX on that.
