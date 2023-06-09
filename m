Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF7672921C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 10:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239981AbjFIICW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 04:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239947AbjFIICE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:02:04 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 05C9A4215;
        Fri,  9 Jun 2023 01:00:08 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D423AB6;
        Fri,  9 Jun 2023 00:59:44 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.25.215])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF6613F71E;
        Fri,  9 Jun 2023 00:58:53 -0700 (PDT)
Date:   Fri, 9 Jun 2023 08:58:49 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Ravi Bangoria <ravi.bangoria@amd.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ming Wang <wangming01@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Sean Christopherson <seanjc@google.com>,
        Ali Saidi <alisaidi@amazon.com>, Rob Herring <robh@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v5 28/34] perf pmus: Split pmus list into core and other
Message-ID: <ZILbubiZPNg2M/JY@FVFF77S0Q05N>
References: <20230527072210.2900565-1-irogers@google.com>
 <20230527072210.2900565-29-irogers@google.com>
 <b8efdc75-253c-ad88-f82f-90c626a26592@amd.com>
 <CAP-5=fXg-4NWOhOoTCfNm3aWp_rd6PWcq5NyZ7xwinbuDPUtZg@mail.gmail.com>
 <7c7d9279-25b0-328e-af41-66c2096febaa@amd.com>
 <CAP-5=fUPYjG2J-bxcBf8h1JW34FGQwEbSo4uDbbi+GTGmvGMtg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUPYjG2J-bxcBf8h1JW34FGQwEbSo4uDbbi+GTGmvGMtg@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 10:35:02PM -0700, Ian Rogers wrote:
> On Thu, Jun 8, 2023 at 10:30 PM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
> >
> > On 09-Jun-23 10:10 AM, Ian Rogers wrote:
> > > On Thu, Jun 8, 2023 at 9:01 PM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
> > >>
> > >> Hi Ian,
> > >
> > > Hi Ravi,
> > >
> > >> On 27-May-23 12:52 PM, Ian Rogers wrote:
> > >>> Split the pmus list into core and other. This will later allow for
> > >>> the core and other pmus to be populated separately.
> > >>>
> > >>> Signed-off-by: Ian Rogers <irogers@google.com>
> > >>> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> > >>> ---
> > >>>  tools/perf/util/pmus.c | 52 ++++++++++++++++++++++++++++++------------
> > >>>  1 file changed, 38 insertions(+), 14 deletions(-)
> > >>>
> > >>> diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> > >>> index 58ff7937e9b7..4ef4fecd335f 100644
> > >>> --- a/tools/perf/util/pmus.c
> > >>> +++ b/tools/perf/util/pmus.c
> > >>> @@ -12,13 +12,19 @@
> > >>>  #include "pmu.h"
> > >>>  #include "print-events.h"
> > >>>
> > >>> -static LIST_HEAD(pmus);
> > >>> +static LIST_HEAD(core_pmus);
> > >>> +static LIST_HEAD(other_pmus);
> > >>
> > >> AMD ibs_fetch// and ibs_op// PMUs are per SMT-thread and are independent of
> > >> core hw pmu. I wonder where does IBS fit. Currently it's part of other_pmus.
> > >> So, is it safe to assume that other_pmus are not just uncore pmus? In that
> > >> case shall we add a comment here?
> > >
> > > I'm a fan of comments. The code has landed in perf-tools-next:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/pmus.c?h=perf-tools-next
> > > Do you have any suggestions on wording? I've had limited success
> > > adding glossary terms, for example, offcore vs uncore:
> > > https://perf.wiki.kernel.org/index.php/Glossary#Offcore
> > > I think offcore is a more interconnect related term, but I'd prefer
> > > not to be inventing the definitions. I'd like it if we could be less
> > > ambiguous in the code and provide useful information on the wiki, so
> > > help appreciated :-)
> >
> > Does this look good?
> >
> > /*
> >  * core_pmus:  A PMU belongs to core_pmus if it's name is "cpu" or it's sysfs
> >  *             directory contains "cpus" file. All PMUs belonging to core_pmus
> >  *             must have pmu->is_core=1. If there are more than one PMUs in
> >  *             this list, perf interprets it as a heterogeneous platform.
> 
> 
> Looks good but a nit here. It is heterogeneous from point-of-view of
> PMUs, there are ARM systems where they are heterogenous with big and
> little cores but they have a single homogeneous PMU driver. The perf
> tool will treat them as homogeneous.

For the sake of the comment: there's a little more nuance here.

The intent is that each distinct micro-architecture has its own PMU instance,
but some people write their device trees incorrectly with a single pmu node
rather than separate pmu nodes per micro-architecture.

That should be viewed as a FW bug, even if we have to deal with it here.

Thanks,
Mark.
