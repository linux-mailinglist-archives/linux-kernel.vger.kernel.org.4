Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662D870FF1B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 22:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236408AbjEXUWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 16:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjEXUV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 16:21:58 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76FB113;
        Wed, 24 May 2023 13:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=FmMXlqwkR/abppEpWGmFJiOBXndmPtngYGvj5QKOQZw=; b=guGhhkfVTG0Zis+deiqCH6Cyp2
        x6VyePBW5b1kJZZdhHQEvjGBi2WEyvYlAKMI4h/ZQ9KLM7see5teB0firBu1W+cXqxEnuZHHLwvte
        7JuCoHfkwNzxN1NwCZyaiiwYOVxJeL1Euw3PgEaxqS6WFzaMteIz92fqlxI3u8e82XmHQe40nmALR
        XE0LLH9ef+OMz31Ctvn0JpV/CutyLu0kdPdkUTRhgKxs4iOABijrvjRmtufry0YPrjDAgRe12MxC4
        /J70iVsGqwZnA6wh/lT6KVP/EqMl/SqjNaB6HBwXdOT7KUEcLMZv90DAslc89GbcVr8Nzb7sXL+3X
        HqVgl/Bw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q1uzK-0054bX-02;
        Wed, 24 May 2023 20:21:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D191330013F;
        Wed, 24 May 2023 22:21:35 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B289C20A7872D; Wed, 24 May 2023 22:21:35 +0200 (CEST)
Date:   Wed, 24 May 2023 22:21:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Stephane Eranian <eranian@google.com>, mingo@redhat.com,
        linux-kernel@vger.kernel.org, ak@linux.intel.com,
        stable@vger.kernel.org
Subject: Re: [PATCH] perf/x86/uncore: Correct the number of CHAs on SPR
Message-ID: <20230524202135.GA3447678@hirez.programming.kicks-ass.net>
References: <20230508140206.283708-1-kan.liang@linux.intel.com>
 <CABPqkBSczJqEbA8M0HCdeqjddgDqpxapJYVYNuAS+EifJ+v+Dg@mail.gmail.com>
 <fc1e8298-e19d-b16c-3894-1d6e5664151f@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fc1e8298-e19d-b16c-3894-1d6e5664151f@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 03:10:00PM -0400, Liang, Kan wrote:
> Hi Peter,
> 
> On 2023-05-08 12:16 p.m., Stephane Eranian wrote:
> > On Mon, May 8, 2023 at 7:05 AM <kan.liang@linux.intel.com> wrote:
> >>
> >> From: Kan Liang <kan.liang@linux.intel.com>
> >>
> >> The number of CHAs from the discovery table on some SPR variants is
> >> incorrect, because of a firmware issue. An accurate number can be read
> >> from the MSR UNC_CBO_CONFIG.
> >>
> >> Fixes: 949b11381f81 ("perf/x86/intel/uncore: Add Sapphire Rapids server CHA support")
> >> Reported-by: Stephane Eranian <eranian@google.com>
> >> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> > 
> > Tested-by: Stephane Eranian <eranian@google.com>
> >
> 
> Gentle ping.

Urgh, too much email.. Queued for perf/urgent.
