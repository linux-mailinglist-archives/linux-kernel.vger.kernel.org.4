Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B9360FF47
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 19:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235752AbiJ0RZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 13:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235679AbiJ0RZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 13:25:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB6E43E73;
        Thu, 27 Oct 2022 10:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xudGXE+bH5g0uONSt7W7O2capWykcQVvMeLlbM88H0c=; b=onax5cj46BBmSaer2uSKXZEkQs
        oA+FAjxCJOlLeWflBb9VqaU0mPXUetzMX4sRSEFNdQQV7deJs5IEMxW8YqxOBdy5KM7CPRm6W3YNz
        A6Z1jGTb7uG/eyXfAViZ+nOUoUlMFwXff8YQJfFBFd2ELbYvZiAwBcLw4wFcAjSnVw7R2+29163hL
        /FauygackP6NDvE/INb7d/CHDJFSwzXwwPVlQFCWKisG9DeGZEVl897BuI5KRjO4grAWxfOryKkIP
        tvzjtjebSFEj0PCd1NgIbaBQJmarf6VQ8QkfAVHviEhArYSEUlB8taSbVrKBoZ3q8omk9+/qZnSA8
        kRRZSr8A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oo6cw-000RdB-7A; Thu, 27 Oct 2022 17:25:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2174D30029C;
        Thu, 27 Oct 2022 19:25:05 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0DC6B2C450539; Thu, 27 Oct 2022 19:25:05 +0200 (CEST)
Date:   Thu, 27 Oct 2022 19:25:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org, acme@kernel.org,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kristina.martsenko@arm.com
Subject: Re: [PATCH v2 1/1] perf arm64: Send pointer auth masks to ring buffer
Message-ID: <Y1q+8JF7uYlcvasM@hirez.programming.kicks-ass.net>
References: <20221020101921.1219533-1-james.clark@arm.com>
 <20221020101921.1219533-2-james.clark@arm.com>
 <Y1F8DUWaWhlh/phL@hirez.programming.kicks-ass.net>
 <4e50b890-0588-1551-fb7c-6cd8191d1054@arm.com>
 <8eb174c0-c785-c092-96f5-3a4fa3441287@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8eb174c0-c785-c092-96f5-3a4fa3441287@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 03:11:47PM +0100, James Clark wrote:

> Sorry for flip flopping, but I've read those threads that I linked and
> spoke with Kristina and we would like to stick with the per sample
> implementation after all.
> 
> The reason is that in the future there may also be a prctrl for 48/52
> bit userspace addressing which would change the mask dynamically in the
> same way as the enabled keys. Although this isn't possible now it makes
> sense to do it this way in case of that, and also for consistency with
> the ptrace feature.
> 
> I also think that repeating the mask in this case has a very low impact
> because if you are doing dwarf unwinding, then the whole stack is saved
> anyway, so a few extra u64s wouldn't be noticeable.
> 
> Are you ok with that and for me to resubmit with the expanded commit
> message?

But you can send a side-band thing around if/when it changes. Same as
all the other stuff. We don't include MMAP data with each event either.

Yes, the DWARF thing is slow as anything. but imagine needing this for
something else as well, and then you're stuck with it.
