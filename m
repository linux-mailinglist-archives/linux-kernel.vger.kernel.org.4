Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F8A60DDCA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 11:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233328AbiJZJKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 05:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233166AbiJZJKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 05:10:39 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7C640BD3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 02:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uh3BCm/3F38LepawwgOLWixsQrToIu+qFMWiZqKufG8=; b=T3HhDtIpYO7ka3qVlLncPuMToO
        /qhSEkFlmYHwwIZ7mkIVnwdfEQh6ClMXDkLYxfKzo8Qi+//6/pFf+atm2z9WXpe0FvZoJvuaOYUPf
        U/jRq1hz7wjEo24C8IcEk5XiIlVopfUoj+8de8maXOIwiQGaXC6vkMSGdwRW/Maj/lTcQcJY1/lzG
        1jqSLnBW/EHGDPGO1/IhzMzHSvAM4yZo63D4inLo6iluOUsR3l4ScRH5cOX8xbvbJd3sSwejjE3yB
        3BYL9wwJcYWi2zVgnd5b2C5sy9lqWO6owE6OL4fFRHtI96A2JSzz7kdpW/cmVBigu5TVPds6se56z
        l9ZBTe3g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oncQN-006XzU-O9; Wed, 26 Oct 2022 09:10:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1923730010B;
        Wed, 26 Oct 2022 11:10:11 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 013D32C268BC3; Wed, 26 Oct 2022 11:10:10 +0200 (CEST)
Date:   Wed, 26 Oct 2022 11:10:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Vishal Chourasia <vishalc@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        vincent.guittot@linaro.org, vschneid@redhat.com,
        srikar@linux.vnet.ibm.com, sshegde@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, ritesh.list@gmail.com,
        aneesh.kumar@linux.ibm.com
Subject: Re: sched/debug: CPU hotplug operation suffers in a large cpu systems
Message-ID: <Y1j5cqbyZCDlyaTn@hirez.programming.kicks-ass.net>
References: <Y01UWQL2y2r69sBX@li-05afa54c-330e-11b2-a85c-e3f3aa0db1e9.ibm.com>
 <Y01kc4g9CVmoyOxj@hirez.programming.kicks-ass.net>
 <Y01sk3l8yCMvhvYm@kroah.com>
 <Y06B0pr8hpwzxEzI@li-05afa54c-330e-11b2-a85c-e3f3aa0db1e9.ibm.com>
 <Y06ISBWhJflnV+NI@kroah.com>
 <Y1jVjX9FUuUilcjA@li-05afa54c-330e-11b2-a85c-e3f3aa0db1e9.ibm.com>
 <Y1jbhCYfktL51zNB@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1jbhCYfktL51zNB@kroah.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2022 at 09:02:28AM +0200, Greg Kroah-Hartman wrote:
> On Wed, Oct 26, 2022 at 12:07:01PM +0530, Vishal Chourasia wrote:
> > On Tue, Oct 18, 2022 at 01:04:40PM +0200, Greg Kroah-Hartman wrote:
> > 
> > > Why do you need to?  What tools require these debugfs files to be
> > > present?
> > 
> > We are not entirely sure what applications (if any) might be using this interface.
> 
> Then just disable it and see what happens :)

It's mostly a debug interface for developers. A lot of people complained
when I moved things to debugfs, and I told them their program was broken
for a SCHED_DEBUG=n build anyway, but nobody complained about
this particular thing IIRC.

It's mostly affected by things like hotplug and cpusets, you can
discover the resulting topology by looking at these files.

Also; while we generally try and keep SCHED_DEBUG impact low, it is
still measurable; there are a number of people that run SCHED_DEBUG=n
kernels for the extra little gain.

> > > And if you only have 7-8 files per CPU, that does not seem like a lot of
> > > files overall (14000-16000)?  If you only offline 1 cpu, how is removing
> > > 7 or 8 files a bottleneck?  Do you really offline 1999 cpus for a 2k
> > > system?
> > 
> > It's 7-8 files per domain per cpu, so, in a system with approx 2k cpus and five
> > domains, the total file count goes above 70k-80k files. And, when we offline 1
> > CPU, the entire directory is rebuilt, resulting in creation of all the files
> > again.
> 
> Perhaps change the logic to not rebuild the whole thing and instead just
> remove the required files?

Unplugging a single cpu can change the topology and the other cpus might
need to be updated too.

Simplest example would be the SMT case, if you reduce from SMT>1 to SMT1
the SMT domain goes away (because a single CPU domain is as pointless as
it sounds) and that affects the CPU that remains.

Tracking all that is a pain. Simply rebuilding the whole thing is by
*far* the simplest option. And given this all is debug code, simple is
good.

> Or as I mentioned before, you can move debugfs to use kernfs, which
> should resolve most of these issues automatically.  Why not take the
> time to do that which will solve the problem no matter what gets added
> in the future in other subsystems?

This sounds like a good approach.
