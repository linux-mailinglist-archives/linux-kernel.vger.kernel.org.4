Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 466016CA85B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 16:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbjC0O6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 10:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233121AbjC0O6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 10:58:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFB149E9;
        Mon, 27 Mar 2023 07:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=cE0RQJv+FQscAn7Kg18zI4d5MgKmBRB/NIb1/jav8Js=; b=Qjf6fdufszYfPvYeyKk/7u11qa
        9K6I5TfacvrDxJyo0Sf077teARpsMFYaxJmPUM+beCxy0yUkgEI6uV1jo79+LWq0LFetIKlSHsYrG
        eLggNARQNmV+huipzexYXs2GdFhqoV8pOKRRcuxbFljiEFsP/k1EIaljZhsmIGah/2mj459hIMbas
        jRpzXJvJSdIb8R/EhpVgnu9jDMNCfIubiUXgfFnXy7Mp707oebFYE2XDNvwOnBcgU5FUOYQ70FmLy
        8GAJVbV/rJ2J+8t/QU5CAqhj8wcYXf+RQxG+qBqodbdaFhVhU5n5lYVORJ6cGqaraUNDl1+chJGdF
        7rvddM+A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pgoIZ-007UFv-V7; Mon, 27 Mar 2023 14:58:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5454A3001E5;
        Mon, 27 Mar 2023 16:58:13 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 17AE62111BE15; Mon, 27 Mar 2023 16:58:13 +0200 (CEST)
Date:   Mon, 27 Mar 2023 16:58:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Markus Elfring <Markus.Elfring@web.de>,
        kernel-janitors@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Zhouyi Zhou <zhouzhouyi@gmail.com>, x86@kernel.org,
        cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH resent] perf/x86/amd/uncore: Fix exception handling in
 amd_uncore_cpu_up_prepare()
Message-ID: <20230327145813.GA11425@hirez.programming.kicks-ass.net>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <ab860edf-79ca-2035-c5a3-d25be6fd9dac@web.de>
 <3a35fb28-5937-72f8-b2e8-b1d9899b5e43@web.de>
 <d691d740-c172-a5cb-e4f0-5bc5687c8464@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d691d740-c172-a5cb-e4f0-5bc5687c8464@intel.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 12:11:54PM +0300, Adrian Hunter wrote:
> On 25/03/23 16:15, Markus Elfring wrote:
> > Date: Fri, 17 Mar 2023 13:13:14 +0100
> > 
> > The label “fail” was used to jump to another pointer check despite of
> > the detail in the implementation of the function “amd_uncore_cpu_up_prepare”
> > that it was determined already that the corresponding variable contained
> > a null pointer (because of a failed function call in two cases).
> > 
> > 1. Thus return directly after a call of the function “amd_uncore_alloc”
> >    failed in the first if branch.
> > 
> > 2. Use more appropriate labels instead.
> > 
> > 3. Reorder jump targets at the end.
> > 
> > 4. Delete a redundant check and kfree() call.
> > 
> > 5. Omit an explicit initialisation for the local variable “uncore_llc”.
> > 
> > 
> > This issue was detected by using the Coccinelle software.
> > 
> > Fixes: 39621c5808f5dda75d03dc4b2d4d2b13a5a1c34b ("perf/x86/amd/uncore: Use dynamic events array")
> > Fixes: 503d3291a937b726757c1f7c45fa02389d2f4324 ("perf/x86/amd: Try to fix some mem allocation failure handling")
> 
> Commit should be only the first 12 characters of the hash.
> Refer:	https://docs.kernel.org/process/submitting-patches.html
> 
> But this is not a fix. Redundant calls to kfree do not break
> anything.
> 
> Also avoid using the term "exception" since, in x86, exceptions are
> hardware events.  Better to just call it "error handling".

Don't feed the trolls; Markus is a bot or other weird construct that's
been banned from lkml.
