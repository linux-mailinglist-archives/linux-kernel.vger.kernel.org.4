Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2AF60FF3A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 19:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235195AbiJ0RUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 13:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233619AbiJ0RUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 13:20:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD73BFF224;
        Thu, 27 Oct 2022 10:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=13CSR5SLPkPzpOSCAc49kTBJVPes/WepABZjQ1sDdeI=; b=F29jWpxaiIdY/S9C+hHbIdCff7
        v1FJXG/DuCbJv6uAi8CKaR8XpXdG1w3m99vPaViJpREZ6g/nPvKHj6mdBbHMkBXZmpzJdulQTmk1D
        tC0A2jm6PnBamEG4Zd9fkQZGZXxpt9MSwuIxWsmjksDq9lCO1qwK/bifU3dfHkZs5EsJYjYa6WZ8/
        Z8bVgztCbRiY8HWqx//I8W77VRd3TjlzEhPRy6W/0jc3YsYLMy0WiRN9eeY8HRKXZDpzJo3/8tOnL
        GpssH8K/yLtHzq9wsPGaIzOOwV7JQArKPuSwExsZq9TslnX24WXBs+CjwkCKgPZTD9JPyYLvpvnia
        kLnihmZw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oo6YP-000RU3-GC; Thu, 27 Oct 2022 17:20:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9C4C530008D;
        Thu, 27 Oct 2022 19:20:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7BC142C450532; Thu, 27 Oct 2022 19:20:23 +0200 (CEST)
Date:   Thu, 27 Oct 2022 19:20:23 +0200
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
Message-ID: <Y1q914IVy6XgE1xq@hirez.programming.kicks-ass.net>
References: <20221020101921.1219533-1-james.clark@arm.com>
 <20221020101921.1219533-2-james.clark@arm.com>
 <Y1F8DUWaWhlh/phL@hirez.programming.kicks-ass.net>
 <4e50b890-0588-1551-fb7c-6cd8191d1054@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e50b890-0588-1551-fb7c-6cd8191d1054@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 04:28:12PM +0100, James Clark wrote:

> > Why do we want the same mask repeated over and over with each sample;
> > should this not be part of the address space (side-band) data?
> 
> You are probably right that it could be done that way. The reason that
> we did it this way was to be consistent with ptrace feature [1] where it
> is delivered to userspace on a per-process basis. And there is also a
> prctl for the enabled key types [2] which can be changed dynamically.
> Particularly for the last reason is why it was done per sample.
> 
> Having said that, the enabled keys field is not used by perf, only the
> mask is used, so I can drop the per sample data until enabled keys is
> needed, which may be never.
> 
> I'm going to assume that perf shouldn't use ptrace because of
> permissions and conflicts with debuggers, so I could put the mask
> somewhere like PERF_RECORD_FORK instead of per sample.

Yeah, or create an new RECORD type which you can also send around at
prctl() time.

The only thing that's needed on top of that is exposing the mask
somewhere in /proc for existing tasks; which is what perf also uses to
syntesize RECORD_MMAP events on startup etc..

