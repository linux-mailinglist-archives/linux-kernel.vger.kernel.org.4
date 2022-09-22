Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D80EE5E5D19
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 10:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbiIVIKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 04:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiIVIKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 04:10:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274BF7C741;
        Thu, 22 Sep 2022 01:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=x2S7ihsdzXGdnhLKW5/Rg77+Ve4aEgc8tlCoujWLAvE=; b=ZWFv9XB9sZkq0mqegWIrgQAV61
        vY73ggeCAQ8R06BrBZqAeK3aWR/ZbbPkXa++s1YIquK+RKyJaDn4U0qUttxHozcKpOBp4DGkOXUfL
        mVKgyiWCGn5XqPf5LunV/XEewR32uXN4/94HwqEM+OCWzR0Bug2O8D5MtGGI+zPu2kJXbY78M1JPw
        GeTP7BN1SmM9lslPbWONPssY4zRtPUvfvRlX37uuIpsh2h8JjIPMfSu0uUTyqpstn8jABeEh+jNkb
        rPQLVOtc3NzzDLn1ZuKeBRxDXYsEtnXgdii9I8rsjkMbh19kcKna+46gpFycCX8RlKWDAjISicjWb
        YLxSst4w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1obHHZ-006ro0-Gs; Thu, 22 Sep 2022 08:10:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BCE8F300169;
        Thu, 22 Sep 2022 10:10:01 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9322C200FBDF7; Thu, 22 Sep 2022 10:10:01 +0200 (CEST)
Date:   Thu, 22 Sep 2022 10:10:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
        Florian Weimer <fw@deneb.enyo.de>, David.Laight@aculab.com,
        carlos@redhat.com, Peter Oskolkov <posk@posk.io>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>
Subject: Re: [RFC PATCH v4 00/25] RSEQ node id and virtual cpu id extensions
Message-ID: <YywYWSIocrDDntq3@hirez.programming.kicks-ass.net>
References: <20220921192454.231662-1-mathieu.desnoyers@efficios.com>
 <14ba275f-8ddc-33fc-2669-1c336436f473@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14ba275f-8ddc-33fc-2669-1c336436f473@efficios.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2022 at 03:54:18PM -0400, Mathieu Desnoyers wrote:
> On 2022-09-21 15:24, Mathieu Desnoyers wrote:
> > Extend the rseq ABI to expose a NUMA node ID and a vm_vcpu_id field.
> > 
> > The NUMA node ID field allows implementing a faster getcpu(2) in libc.
> > 
> > The virtual cpu id allows ideal scaling (down or up) of user-space
> > per-cpu data structures. The virtual cpu ids allocated within a memory
> > space are tracked by the scheduler, which takes into account the number
> > of concurrently running threads, thus implicitly considering the number
> > of threads, the cpu affinity, the cpusets applying to those threads, and
> > the number of logical cores on the system.
> > 
> > This series is based on the v5.19 tag.
> 
> Hi Peter,
> 
> I'm having MTA issues at the moment. I will resend the series as soon as I
> can get hold of my sysadmin.

It landed in my inbox and Lore seems to have received a copy too; as
per:

  https://lkml.kernel.org/r/14ba275f-8ddc-33fc-2669-1c336436f473@efficios.com

So I'm thinking you did manage to send out mail and all is well.

I'll try and have a look later today.
