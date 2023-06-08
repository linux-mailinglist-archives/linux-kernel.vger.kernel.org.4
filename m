Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E68E47278AF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 09:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234907AbjFHHYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 03:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234380AbjFHHYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 03:24:38 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D611AE
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 00:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qn0Y26j1I3K5ZOtrwpc71K3c8JF0q5T3JqtjyhJNb7o=; b=b2qXHUx4bjWFGSj1mw8H4zXmXl
        B5SKmpzA7xpkqPyygEJUyHR3ZjznoJBPCTYsmaBQodr4E05r2uZzptPC31SCZM4ojKSXUdT477sPm
        36kEV2uif3OQXMynXhhMjijhdSrDXzNyPmb2IfmtAItVU4pDPaGM4APKjBLlb6UTITstIgpUyRczr
        lMgavzM/+L+0QPUltUpMEdEErYO3DRAcyQYZl7Hzk5C5RgqBwydfeHXGKiVUX6jRTcXYdLZ1jlT3z
        DKvHt9ZnvqNHXE4UpuhoIZES3+3oihaTHLQs9vfkPaO1DORoD0frGMlxfADM7Wv+Anx8+OYlaeHWU
        5NCBmFxg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q7A0M-0068fn-1W;
        Thu, 08 Jun 2023 07:24:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1D94F3001E7;
        Thu,  8 Jun 2023 09:24:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CE6A523FF6ACF; Thu,  8 Jun 2023 09:24:20 +0200 (CEST)
Date:   Thu, 8 Jun 2023 09:24:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "irogers@google.com" <irogers@google.com>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "alexey.v.bayduraev@linux.intel.com" 
        <alexey.v.bayduraev@linux.intel.com>,
        "Zhang, Tinghao" <tinghao.zhang@intel.com>
Subject: Re: [PATCH V2 1/6] perf/x86/intel: Add Grand Ridge and Sierra Forest
Message-ID: <20230608072420.GB998233@hirez.programming.kicks-ass.net>
References: <20230522113040.2329924-1-kan.liang@linux.intel.com>
 <20230522202659.GC3334667@hirez.programming.kicks-ass.net>
 <SJ1PR11MB608367DC5D25856073C86FCFFC53A@SJ1PR11MB6083.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB608367DC5D25856073C86FCFFC53A@SJ1PR11MB6083.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 09:43:57PM +0000, Luck, Tony wrote:
> > > Create a non-hybrid PMU setup for Grand Ridge and Sierra Forest.
> >
> > Moo... Tony, did you sneak product names instead of uarch names in the
> > intel-family thing again?
> >
> > That is; I'm thinking we want the below, no?
> >
> > -#define INTEL_FAM6_SIERRAFOREST_X    0xAF
> > -
> > -#define INTEL_FAM6_GRANDRIDGE                0xB6
> > +#define INTEL_FAM6_ATOM_CRESTMONT_X  0xAF /* Sierra Forest */
> > +#define INTEL_FAM6_ATOM_CRESTMONT    0xB6 /* Grand Ridge */
> 
> I don't think that's really any more helpful.

Well, it clearly shows why these two are grouped together. They are the
same bloody uarch. OTOH 'Sierra Forest' and 'Grand Ridge' is just random
gibberish that nobody can relate without looking up some website.

> Using the code name of the model makes it easy to look things
> up in ark.intel.com. Using the "core" name doesn't even work for
> hybrid CPU models which have more than one core type.
> So I'd like to keep it as it is.

ark.intel.com is a travesty anyway... if I get it as a result to a
Google query I will almost always avoid it because it is not useful.

Wikipedia and Wikichip are by far more useful.

> But if you want to change to the core name, then please just
> do it now.
> 
> There are folks internally worried that all upstream work for
> these two CPU models is going to be blocked while this
> is discussed.

Then I'm hoping their take-away is that random gibberish names don't
help anybody. The whole Intel naming scheme is impenetrable crap.
