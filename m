Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0F86B146D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 22:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjCHVpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 16:45:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjCHVpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 16:45:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B82559D6
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 13:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678311778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FdnsXLolUJxCc29xMKmh4dWAYjznbbiQcfHEwgveAgs=;
        b=VVJ228pOogFnRelhE7bkyKSP031GbdrjZCIxgewK5aCfOaggIeDIEYXZJG2d8UoMuEFwAo
        yLfzCrWwJVKyn24QA32jTHIPGWOpqLQIvh9WP3P1nZVlvHnJ/uM5yhkQ57W69eNYUDpLEC
        20DakzfZQZLJWgVh7ZA4EVGjp5EtSgc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-100-AvipUr7jOD25WLIQ8vSGaQ-1; Wed, 08 Mar 2023 16:42:53 -0500
X-MC-Unique: AvipUr7jOD25WLIQ8vSGaQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7931185A588;
        Wed,  8 Mar 2023 21:42:52 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F0932166B26;
        Wed,  8 Mar 2023 21:42:52 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id E5BF74015389B; Wed,  8 Mar 2023 18:42:27 -0300 (-03)
Date:   Wed, 8 Mar 2023 18:42:27 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Christoph Lameter <cl@linux.com>,
        Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Russell King <linux@armlinux.org.uk>,
        Huacai Chen <chenhuacai@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH v4 05/12] this_cpu_cmpxchg: x86: switch this_cpu_cmpxchg
 to locked, add _local function
Message-ID: <ZAkBQ+Vtdn1alEyK@tpad>
References: <20230305133657.255737580@redhat.com>
 <20230305134053.537803923@redhat.com>
 <20230306112240.GB1267364@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306112240.GB1267364@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 12:22:40PM +0100, Peter Zijlstra wrote:
> On Sun, Mar 05, 2023 at 10:37:02AM -0300, Marcelo Tosatti wrote:
> > Goal is to have vmstat_shepherd to transfer from
> > per-CPU counters to global counters remotely. For this,
> > an atomic this_cpu_cmpxchg is necessary.
> > 
> > Following the kernel convention for cmpxchg/cmpxchg_local,
> > change x86's this_cpu_cmpxchg_ helpers to be atomic.
> > and add this_cpu_cmpxchg_local_ helpers which are not atomic.
> 
> Urgh.. much hate for this. this_cpu_*() is local, per definition,
> always.

:Author: Christoph Lameter, August 4th, 2014
:Author: Pranith Kumar, Aug 2nd, 2014

this_cpu operations are a way of optimizing access to per cpu
variables associated with the *currently* executing processor. This is
done through the use of segment registers (or a dedicated register where
the cpu permanently stored the beginning of the per cpu area for a
specific processor).

this_cpu operations add a per cpu variable offset to the processor
specific per cpu base and encode that operation in the instruction
operating on the per cpu variable.

This means that there are no atomicity issues between the calculation of
the offset and the operation on the data. Therefore it is not
necessary to disable preemption or interrupts to ensure that the
processor is not changed between the calculation of the address and
the operation on the data.

>> Call the above [1].

>> Up to this point, everything remains valid with adding lock
>> to cmpxchg. That is, it makes sense to have a locked
>> this_cpu_cmpxchg, operating on per-CPU data, without the need
>> to disable preemption/interrupts to ensure processor is not
>> changed.

Read-modify-write operations are of particular interest. Frequently
processors have special lower latency instructions that can operate
without the typical synchronization overhead, but still provide some
sort of relaxed atomicity guarantees. The x86, for example, can execute
RMW (Read Modify Write) instructions like inc/dec/cmpxchg without the
lock prefix and the associated latency penalty.

>> This sentence above makes sense if the data is accessed locally.
>> However, we are extending it (this_cpu_cmpxchg) to the case
>> where we want the data to be accessed remotely (therefore need
>> to be a locked access), but still want the benefits of [1].
>>
>> For example, this_cpu_xchg implies LOCK semantics.

Access to the variable without the lock prefix is not synchronized but
synchronization is not necessary since we are dealing with per cpu
data specific to the currently executing processor. Only the current
processor should be accessing that variable and therefore there are no
concurrency issues with other processors in the system.

----

So in summary, i understand your POV, but:

1) Have outlined arguments above which point that this_cpu_xxx and 
locked instructions can co-exist (in fact, they are already do, for
this_cpu_xchg).

2) In case you still think this is a bad idea, any suggestions for
improvements?

Thanks

