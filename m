Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C66BE70CB83
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 22:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234228AbjEVUtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 16:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233555AbjEVUtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 16:49:02 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0C5B9
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 13:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EOTa2Yivs/sWzQzBCKrR0/4wIPeaItCPwaYUM5FuQBA=; b=na7OmH1NB8n3znZsvxxBJCjdQd
        CBzk/mPerdrsI3jnu77iv9/RSYM03YD0NU34Xg6q0akCX42dvtO6Kk/qD0pj8kuqqk/SAI9k0gO7k
        uGwh0Ub2X9dOdT7dQ3e0TsjRymjo0Hd1Gtq9xwPkLGC2t+5S0CtNjiNu7SqkqZcwOrJ9py47298KO
        dkEVtnVgclskYjDdxy2CCeCsMNa4LJfhPJSMEONbbNHsI4JeiMnKX14qa2vDyOiF7zxqN1NlPfJ8k
        62CSAelh4JpVYgPdV5j7dOZlRcxs/rb1hZxSWLemBUTlxXMHomq3/hKXeIo2kk4ncaMdqmmjcpcyf
        odRSn6TA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q1CSS-0028vM-0G;
        Mon, 22 May 2023 20:48:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E660C30003A;
        Mon, 22 May 2023 22:48:42 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CBD4A20A1AF0B; Mon, 22 May 2023 22:48:42 +0200 (CEST)
Date:   Mon, 22 May 2023 22:48:42 +0200
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
Message-ID: <20230522204842.GD3334667@hirez.programming.kicks-ass.net>
References: <20230522113040.2329924-1-kan.liang@linux.intel.com>
 <20230522202659.GC3334667@hirez.programming.kicks-ass.net>
 <SJ1PR11MB608304B3764CE30681B81DC5FC439@SJ1PR11MB6083.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB608304B3764CE30681B81DC5FC439@SJ1PR11MB6083.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 08:42:14PM +0000, Luck, Tony wrote:
> > Moo... Tony, did you sneak product names instead of uarch names in the
> > intel-family thing again?
> 
> The difficult part is that I've finally got Intel to release product names reasonable
> time ahead of launch. But details like which core architecture is used by each
> lags behind.
> 
> But I think you just announced the Crestmont core.

Crestmont was in Kan's original Changelog, also:

  https://en.wikichip.org/wiki/intel/microarchitectures/meteor_lake

has: Core Names	Redwood Cove, Crestmont

And:

  https://wccftech.com/intel-next-gen-arrow-lake-lunar-lake-cpus-get-preliminary-support-in-aida64/

has a giant list of names too.


Basically, I never can remember these things and I use Google because I
can't be bothered to learn how the intraweb muck works.


