Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 386876E2A9D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 21:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjDNTYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 15:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjDNTYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 15:24:31 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2845618C
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 12:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TfQNyrp2UDMr/gkUd/v3D/NbTRBJm7YcI/vvYvU6Bjk=; b=JFpY9Tn52PdlvnYHNQXIqcugV+
        YBO4sVaF4PIB3M3Fzja3ZWdU2aTjSYjUHVmEud1yGrONH7fc2NHnGoVdWq4zCeh7bYnH/eJcN97YJ
        uB92XGqoGmMcyjv/KFGZqwyU+wHoKjmXNPVLVgQJCIa/jlPSvuhcLShSjau0PrteM/88CV1LDkAw1
        d68n+YDUNmzKCcJaSLfc0a8cWWgcIqj8vyEBtS8NwSSMe5tD4MO99tNdayEmYiJAot2T6VQoICxXr
        rN8PTSE+gDQwod3TTMCF88/nu8zmETSNZyJxW8Rbp3/5OMUH3rC7UqmbFH06BNmGBYGW9rbMvHiXj
        9RJVhnoQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pnP1l-00Ffwk-17;
        Fri, 14 Apr 2023 19:24:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9BC1C300AFA;
        Fri, 14 Apr 2023 21:24:07 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7428D241FB92F; Fri, 14 Apr 2023 21:24:07 +0200 (CEST)
Date:   Fri, 14 Apr 2023 21:24:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        eranian@google.com
Subject: Re: [PATCH 2/6] perf: Support branch events logging
Message-ID: <20230414192407.GA778423@hirez.programming.kicks-ass.net>
References: <20230410204352.1098067-1-kan.liang@linux.intel.com>
 <20230410204352.1098067-2-kan.liang@linux.intel.com>
 <20230414103832.GD83892@hirez.programming.kicks-ass.net>
 <1d62b865-5d31-ec36-99e0-785844f79199@linux.intel.com>
 <20230414145324.GB761523@hirez.programming.kicks-ass.net>
 <803927bb-6f74-5c09-3c18-2fd5f423287b@linux.intel.com>
 <20230414160945.GC761523@hirez.programming.kicks-ass.net>
 <085fa11e-ea07-c148-1b32-8a09007ee12b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <085fa11e-ea07-c148-1b32-8a09007ee12b@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2023 at 01:53:24PM -0400, Liang, Kan wrote:
> 
> 
> On 2023-04-14 12:09 p.m., Peter Zijlstra wrote:
> > On Fri, Apr 14, 2023 at 11:56:41AM -0400, Liang, Kan wrote:
> >>> If it were to only support 4, then
> >>> we're in counter scheduling contraint hell again 
> >>
> >> Unfortunately, yes.
> >>
> >>> and we need to somehow
> >>> group all these things together with the LBR event.
> >>
> >> Group will bring many limits for the usage. For example, I was told
> >> there could be someone wants to use it with multiplexing.
> > 
> > You can create two groups, each with an LBR event, no?
> 
> If we put everything in a group, that will make the enabling much
> simpler. I don't think the perf tool needs the order information
> anymore. Because the kernel enables the events one by one in a group.
> The kernel just need to convert the information from the counter order
> to the enabling order and dump to user space.

I never understood the whole order thing. What was it trying to do?

> But if we have two groups with LBR event, the order information is still
> required. Why we still want to group things?

Why would you need that; what is that whole order nonsense about?

{e1, e2, e3, e4}, {e5, e6, e7, e8} with e1 and e5 both having LBR on
just works no?

Since they have LBR and that extra sample flag they all get a 0-3
constraint.

Since both e1 and e5 use LBR, they're mutually exclusive, either e1 or
e5 group runs.
