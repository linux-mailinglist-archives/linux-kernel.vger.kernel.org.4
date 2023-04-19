Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5D86E7876
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 13:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233017AbjDSLUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 07:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232441AbjDSLUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 07:20:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C98415444
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 04:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681903134;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A5NZuRAf3bA6RMcpxMcuMmjJScXbqJXX42QQW6vSBm8=;
        b=XEq9UGQlh9j8hsK3EYBNG7LxKa2PAr5JOdeXxkAZgMIYwP9KvWmrTJwOZTWDqSzivwlDVN
        vBmH7CyBSztHGC4l1fs4ZqDmgz1LZn+mIDotdSKj9we5xRO+L32s3/Yx21oitipL2LykhC
        jkjQSN1M0Jwgb+th++WJfg48hQ1pc4g=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-378-dUtHiiTHO_6yhoxJauysHQ-1; Wed, 19 Apr 2023 07:18:50 -0400
X-MC-Unique: dUtHiiTHO_6yhoxJauysHQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3FAA73C10C64;
        Wed, 19 Apr 2023 11:18:50 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 065462958;
        Wed, 19 Apr 2023 11:18:50 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 9744A400E056C; Wed, 19 Apr 2023 08:14:09 -0300 (-03)
Date:   Wed, 19 Apr 2023 08:14:09 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Lameter <cl@linux.com>,
        Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Russell King <linux@armlinux.org.uk>,
        Huacai Chen <chenhuacai@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, x86@kernel.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v7 00/13] fold per-CPU vmstats remotely
Message-ID: <ZD/NAaa5TVcL7Mxm@tpad>
References: <20230320180332.102837832@redhat.com>
 <20230418150200.027528c155853fea8e4f58b2@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418150200.027528c155853fea8e4f58b2@linux-foundation.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 03:02:00PM -0700, Andrew Morton wrote:
> On Mon, 20 Mar 2023 15:03:32 -0300 Marcelo Tosatti <mtosatti@redhat.com> wrote:
> 
> > This patch series addresses the following two problems:
> > 
> > 1. A customer provided evidence indicating that a process
> >    was stalled in direct reclaim:
> > 
> > ...
> >
> >  2. With a task that busy loops on a given CPU,
> >     the kworker interruption to execute vmstat_update
> >     is undesired and may exceed latency thresholds
> >     for certain applications.
> > 
> 
> I don't think I'll be sending this upstream in the next merge window. 
> Because it isn't clear that the added complexity in vmstat handling is
> justified.

From my POV this is an incorrect statement (that the complexity in
vmstat handling is not justified).

Andrew, this is the 3rd attempt to fix this problem:

First try:  https://lore.kernel.org/lkml/20220127173037.318440631@fedora.localdomain/

Second try: https://patchew.org/linux/20230105125218.031928326@redhat.com/

Third try: syncing vmstats remotely from vmstat_shepherd (this
patchset).

And also, can you please explain: what is so complicated about the
vmstat handling? cmpxchg has been around and is used all over the
kernel, and nobody considers "excessively complicated".

> - Michal's request for more clarity on the end-user requirements
>   seems reasonable.

And i explained to Michal in great detail where the end-user 
requirements come from. For virtualized workloads, there are two
types of use-cases:

1) For example, for the MAC scheduler processing must occur every 1ms,
and a certain amount of computation takes place (and must finish before
the next 1ms timeframe). A > 50us latency spike as observed by cyclictest
is considered a "failure".

I showed him a 7us trace caused by, and explained that will extend to >
50us in the case of virtualized vCPU.

2) PLCs. These workloads will also suffer > 50us latency spikes
which is undesirable.

Can you please explain what additional clarity is required?

RH's performance team, for example, has been performing packet
latency tests and waiting for this issue to be fixed for about 2
years now.

Andrew Theurer, can you please explain what problem is the vmstat_work
interruption causing in your testing?

> - You have indicated that additional changelog material is forthcoming.

Not really.

Do you think additional information on the changelog is necessary?

> - The alternative idea of adding a syscall which tells the kernel
>   "I'm about to go realtime, so please clear away all the pending crap
>   which might later interrupt me" sounds pretty good.
>
>   Partly because there are surely other places where we can use this.
> 
>   Partly because it moves all the crap-clearing into special
>   crap-clearing code paths while adding less burden to the
>   commonly-executed code.
> 
>   And I don't think this alternative has been fully investigated and
>   discussed.

This was tried before:
https://lore.kernel.org/lkml/20220127173037.318440631@fedora.localdomain/

My conclusion from that discussion (and work) is that a special system
call:

1) Does not allow the benefits to be widely applied (only modified
applications will benefit). Is not portable across different operating systems. 

Removing the vmstat_work interruption is a benefit for HPC workloads, 
for example (in fact, it is a benefit for any kind of application, 
since the interruption causes cache misses).

2) Increases the system call cost for applications which would use
the interface.

So avoiding the vmstat_update update interruption, without userspace 
knowledge and modifications, is a better than solution than a modified
userspace.





