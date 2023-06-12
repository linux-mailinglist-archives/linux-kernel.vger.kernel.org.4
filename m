Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2BAC72D331
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 23:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234484AbjFLVXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 17:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233166AbjFLVW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 17:22:57 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21C959C9;
        Mon, 12 Jun 2023 14:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686604713; x=1718140713;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=dhxgXYpIXG5Uh2B//r4CHAr2esb78E4fQ9A4WP2agR0=;
  b=MZgXvNRvxgPz5oz7OIrKzPG/+8zaTvJxs2mRJugML3OsYYwbetXmxrjp
   3n4cgYZKZQxt/lP2h74oJSKT06j0tUGCKsQf4Z0jf1gZgnNQDMZBmZZQf
   DLEAtjKYO71eSKAxEwDfMDfxQ37pWn5My725TL8kryqWzzUYAS9BVb1ty
   oijz7T+XbhjeFbUIju3tBfKhBDySRYTHiszc4HbkWUMMiAZXkKMg3kp0j
   hS4DCB9GWIZekI/py5RSoSEXrKYSYeZlc8eb8cwaXdywPCA1kRe6CDhO4
   GHVSzxPW5Pr2uEsNLkKPgTjykmHVq9bfpeOUs3CD479Hg9dWOd6owQoeE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="355659382"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="355659382"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 14:16:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="801171734"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="801171734"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 14:16:35 -0700
Date:   Mon, 12 Jun 2023 14:16:34 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        Ali Saidi <alisaidi@amazon.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Liam Howlett <liam.howlett@oracle.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Changbin Du <changbin.du@huawei.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Yuan Can <yuancan@huawei.com>,
        Brian Robbins <brianrob@linux.microsoft.com>,
        liuwenyu <liuwenyu7@huawei.com>,
        Ivan Babrou <ivan@cloudflare.com>,
        Fangrui Song <maskray@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, coresight@lists.linaro.org
Subject: Re: [PATCH v2 26/26] perf hist: Fix srcline memory leak
Message-ID: <ZIeLMgsBm6cAUmHP@tassilo>
References: <20230608232823.4027869-1-irogers@google.com>
 <20230608232823.4027869-27-irogers@google.com>
 <ZIcoJytUEz4UgQYR@kernel.org>
 <ZIcorZVu1z8jaPL/@kernel.org>
 <CAP-5=fXby-Yk3U4LCQeYkGU_E22kd92=dCnfb7DkN5iPYvCDGA@mail.gmail.com>
 <ZIdUncwTt2fBzxKh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZIdUncwTt2fBzxKh@kernel.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 02:23:41PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Mon, Jun 12, 2023 at 07:46:14AM -0700, Ian Rogers escreveu:
> > On Mon, Jun 12, 2023 at 7:16 AM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > Em Mon, Jun 12, 2023 at 11:13:59AM -0300, Arnaldo Carvalho de Melo escreveu:
> > > > Em Thu, Jun 08, 2023 at 04:28:23PM -0700, Ian Rogers escreveu:
> > > > > srcline isn't freed if it is SRCLINE_UNKNOWN. Avoid strduping in this
> > > > > case as such strdups are redundant and leak memory.
> > > >
> > > > The patch is ok as its what the rest of the code is doing, i.e. strcmp()
> > > > to check if a srcline is the unknown one, but how about the following
> > > > patch on top of yours?
> > >
> > > [acme@quaco perf-tools-next]$ strings ~/bin/perf | grep '??:0'
> > > ??:0
> > > SRCLINE_UNKNOWN ((char *) "??:0")
> > > [acme@quaco perf-tools-next]$
> > 
> > Agreed, the strcmps make me nervous as they won't distinguish heap
> > from a global meaning we could end up with things like pointers to
> > freed memory. The comparison with the global is always going to be
> > same imo.
> > 
> > Acked-by: Ian Rogers <irogers@google.com>
> 
> Thanks, applied and added your Acked-by.

Actually was there another patch that turned it into a explicit global? 

At least in my tree it isn't:

util/srcline.h
28:#define SRCLINE_UNKNOWN  ((char *) "??:0")

Without any explicit global it's a bit dangerous because you rely on the
linker doing string deduplication.  While it normally does that there might be
odd corner cases where it doesn't.

-Andi
