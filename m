Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48464673524
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 11:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjASKKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 05:10:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbjASKJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 05:09:54 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94CEF677A9
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 02:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tM5eucsKyZ8YXT/h1+DWCYLTkr+tyomjmSjGh+s+X9A=; b=l5JhPGV8krFx7BDySqGXk+Tdo/
        +edGzDMSt/cu+bc1AdqAmflOtLJrAv5nHVL7ZRLYXrorGzP7CuD8fPrLxIsUWzXQ/ZxSlXQrkQfay
        Vm9DYAV4PXqNsPumA+aiRtV7RY5p8RInnUt0CHqRT43t7dKnDxoeJB56GVw6oxiXpTTlkfmatC7eS
        Vk2ewDZpXwzv/2VP+xNdheFWGMdgypQvffnn3tM/DYCh3OIue13/9dQ6TiAgpVyaCiebF1izVO4Qm
        sBv7SW7OJkjzZ0BbD3PJWeAVXXZUlLo37OM2PRhbGw3slxEVYXhHEXFAO114ySy82wdg/YDjWt/YS
        /ngOuE6w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pIRqz-000Fo1-1w;
        Thu, 19 Jan 2023 10:09:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C6E263002BF;
        Thu, 19 Jan 2023 11:09:31 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A40AB20306BCF; Thu, 19 Jan 2023 11:09:31 +0100 (CET)
Date:   Thu, 19 Jan 2023 11:09:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrei Vagin <avagin@gmail.com>
Cc:     Andrei Vagin <avagin@google.com>, Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Christian Brauner <brauner@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Oskolkov <posk@google.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Will Drewry <wad@chromium.org>
Subject: Re: [PATCH 3/5] sched: add a few helpers to wake up tasks on the
 current cpu
Message-ID: <Y8kW25MsKJiycBUU@hirez.programming.kicks-ass.net>
References: <20230110213010.2683185-1-avagin@google.com>
 <20230110213010.2683185-4-avagin@google.com>
 <Y8UgBnsaGDUJKH5A@hirez.programming.kicks-ass.net>
 <CANaxB-z9e2n-TTm7BZDCiv-juoPe2sao078G_imJz+aBkLzm4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANaxB-z9e2n-TTm7BZDCiv-juoPe2sao078G_imJz+aBkLzm4Q@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 10:45:33PM -0800, Andrei Vagin wrote:
> On Mon, Jan 16, 2023 at 1:59 AM Peter Zijlstra <peterz@infradead.org> wrote:

> > So I hate this patch, it adds a whole ton of duplication and litter for
> > no real reason afaict. For instance you could've just added an
> > wake_flags argument to swake_up_locked(), there's not *that* many users
> > -- unlike complete().
> >
> > And for complete() instead of fully duplicating the function (always a
> > bad idea) you could've made complete_flags() and implemented complete()
> > using that, or something.
> >
> > Anyway, let me go (finally) have a look at Chen's patch, since that
> > might render all this moot.
> 
> If it is the only concern, it is easy to fix. I think I decided to do it
> this way because swake_up_locked is in include/linux/swait.h, but wakeup
> flags are in kernel/sched/sched.h. I agree that it is better to avoid
> this code duplication.

Thanks.

> Regarding Chen's proposed patch, unfortunately, it does not solve our
> problem. It works only in narrow conditions. One of the major problems
> is that it does nothing if there are idle cores. The advantage of my
> changes is that they work predictably, and they provide benefits
> regardless of other workloads running on the same host.

Oh well.. carry on then. Can't always have two birds thing I suppose :-)
