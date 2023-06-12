Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C48372CC5A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 19:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235771AbjFLRXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 13:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233399AbjFLRXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 13:23:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC828B2;
        Mon, 12 Jun 2023 10:23:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 721F862905;
        Mon, 12 Jun 2023 17:23:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F868C433A1;
        Mon, 12 Jun 2023 17:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686590624;
        bh=num+HBDgMxiuiJVhhkLVPXPpTBWWc1dgJNLDNOGS0Fk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uE12zDMfqRoci4thscAdp3EhSwgKJovJnYvOw3krcV88NGXiZRfF9rOltrCAswAXN
         TfhY5m2ULY71VP3EtGag4nbFEWKPxzFyMuPG3QaaBg/FgP+axXyraqmxKkRVEr1jrU
         F66fBJdtR7u5XF+bUxf0nc+uNB6UiSdxpS8WPdPSdUngO54Nwdyul+O0NltvPBgBM8
         TvC8+1fybwIMNUxG4m6semSiG+yDfRzznvXhkjSxhCVJnuQm8vMTm8aA0J1tYNM/j8
         U+YEG8QI3Byfa1wCkMeiCHNt8OmLMklpSKeGCgZAzvJPIay/RL6ThyyfZw0zP4XgJK
         1ODSUu14Pl9WA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D1BF540692; Mon, 12 Jun 2023 14:23:41 -0300 (-03)
Date:   Mon, 12 Jun 2023 14:23:41 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     John Garry <john.g.garry@oracle.com>,
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
        Andi Kleen <ak@linux.intel.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Yuan Can <yuancan@huawei.com>,
        Brian Robbins <brianrob@linux.microsoft.com>,
        liuwenyu <liuwenyu7@huawei.com>,
        Ivan Babrou <ivan@cloudflare.com>,
        Fangrui Song <maskray@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, coresight@lists.linaro.org
Subject: Re: [PATCH v2 26/26] perf hist: Fix srcline memory leak
Message-ID: <ZIdUncwTt2fBzxKh@kernel.org>
References: <20230608232823.4027869-1-irogers@google.com>
 <20230608232823.4027869-27-irogers@google.com>
 <ZIcoJytUEz4UgQYR@kernel.org>
 <ZIcorZVu1z8jaPL/@kernel.org>
 <CAP-5=fXby-Yk3U4LCQeYkGU_E22kd92=dCnfb7DkN5iPYvCDGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXby-Yk3U4LCQeYkGU_E22kd92=dCnfb7DkN5iPYvCDGA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jun 12, 2023 at 07:46:14AM -0700, Ian Rogers escreveu:
> On Mon, Jun 12, 2023 at 7:16 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Em Mon, Jun 12, 2023 at 11:13:59AM -0300, Arnaldo Carvalho de Melo escreveu:
> > > Em Thu, Jun 08, 2023 at 04:28:23PM -0700, Ian Rogers escreveu:
> > > > srcline isn't freed if it is SRCLINE_UNKNOWN. Avoid strduping in this
> > > > case as such strdups are redundant and leak memory.
> > >
> > > The patch is ok as its what the rest of the code is doing, i.e. strcmp()
> > > to check if a srcline is the unknown one, but how about the following
> > > patch on top of yours?
> >
> > [acme@quaco perf-tools-next]$ strings ~/bin/perf | grep '??:0'
> > ??:0
> > SRCLINE_UNKNOWN ((char *) "??:0")
> > [acme@quaco perf-tools-next]$
> 
> Agreed, the strcmps make me nervous as they won't distinguish heap
> from a global meaning we could end up with things like pointers to
> freed memory. The comparison with the global is always going to be
> same imo.
> 
> Acked-by: Ian Rogers <irogers@google.com>

Thanks, applied and added your Acked-by.

- Arnaldo
