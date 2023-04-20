Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A390E6E884F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 04:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233631AbjDTCze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 22:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbjDTCzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 22:55:32 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B83198E;
        Wed, 19 Apr 2023 19:55:30 -0700 (PDT)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Q22Kw2QpxzsR6g;
        Thu, 20 Apr 2023 10:53:56 +0800 (CST)
Received: from M910t (10.110.54.157) by kwepemi500013.china.huawei.com
 (7.221.188.120) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 20 Apr
 2023 10:55:26 +0800
Date:   Thu, 20 Apr 2023 10:55:11 +0800
From:   Changbin Du <changbin.du@huawei.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
CC:     Changbin Du <changbin.du@huawei.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Hui Wang <hw.huiwang@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v5 2/3] perf: add helper map__fprintf_dsoname_dsoff
Message-ID: <20230420025511.fkd7upvuoxfz2xih@M910t>
References: <20230418031825.1262579-1-changbin.du@huawei.com>
 <20230418031825.1262579-3-changbin.du@huawei.com>
 <3001bde2-b010-3c00-17de-1c78ef4b589b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3001bde2-b010-3c00-17de-1c78ef4b589b@intel.com>
X-Originating-IP: [10.110.54.157]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500013.china.huawei.com (7.221.188.120)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2023 at 09:58:10PM +0300, Adrian Hunter wrote:
> On 18/04/23 06:18, Changbin Du wrote:
> > This adds a helper function map__fprintf_dsoname_dsoff() to print dsoname
> > with optional dso offset.
> > 
> > Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
> > Signed-off-by: Changbin Du <changbin.du@huawei.com>
> > ---
> >  tools/perf/util/map.c | 13 +++++++++++++
> >  tools/perf/util/map.h |  1 +
> >  2 files changed, 14 insertions(+)
> > 
> > diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> > index d81b6ca18ee9..7da96b41100f 100644
> > --- a/tools/perf/util/map.c
> > +++ b/tools/perf/util/map.c
> > @@ -445,6 +445,19 @@ size_t map__fprintf_dsoname(struct map *map, FILE *fp)
> >  	return fprintf(fp, "%s", dsoname);
> >  }
> >  
> > +size_t map__fprintf_dsoname_dsoff(struct map *map, bool print_off, u64 addr, FILE *fp)
> > +{
> > +	int printed = 0;
> > +
> > +	printed += fprintf(fp, " (");
> > +	printed += map__fprintf_dsoname(map, fp);
> > +	if (print_off && map && map__dso(map) && !map__dso(map)->kernel)
> 
> That will also block vmlinux offsets not just [kernel.kallsyms]
> Is that what was intended?
>
Not only vmlinux, modules are also blocked. We'd better print offset for
vmlinux and modules.

$ sudo perf script -k vmlinux -F +dsoff
       perf-exec 2531039 4120893.685967:          1 cycles:  ffffffff99094ec4 [unknown] (vmlinux)
       perf-exec 2531039 4120893.685970:          1 cycles:  ffffffff99094ec4 [unknown] (vmlinux)
       perf-exec 2531039 4120893.685972:          9 cycles:  ffffffff99094ec4 [unknown] (vmlinux)
       perf-exec 2531039 4120893.685973:        194 cycles:  ffffffff99094ec6 [unknown] (vmlinux)
       perf-exec 2531039 4120893.685974:       4605 cycles:  ffffffff99094ec4 [unknown] (vmlinux)
       perf-exec 2531039 4120893.685976:     108083 cycles:  ffffffff9928e8d0 [unknown] (vmlinux)
              ls 2531039 4120893.686003:    2197682 cycles:  ffffffff993c92bc [unknown] (vmlinux)
              ls 2531039 4120893.686554:    4497190 cycles:  ffffffffc159692b strcasestr+0x7b (/lib/modules/5.15.0-60-generic/extra/isac_ipc.ko)
              ls 2531039 4120893.687700:    4189758 cycles:  ffffffffc18a5d66 delete_net_reject_cache+0x76 (/lib/modules/5.15.0-60-generic/extra/isac_networkfilter.ko)
              ls 2531039 4120893.688786:    3780376 cycles:  ffffffffc18a67de delete_net_process_info+0x5e (/lib/modules/5.15.0-60-generic/extra/isac_networkfilter.ko)
              ls 2531039 4120893.689716:    3416607 cycles:  ffffffffc18a67de delete_net_process_info+0x5e (/lib/modules/5.15.0-60-generic/extra/isac_networkfilter.ko)

But I found addr returned by map__dso_map_ip() for 'vmlinux' is not a 'dso
offset'.

$ sudo perf script -k vmlinux -F +dsoff
       perf-exec 2531039 4120893.685967:          1 cycles:  ffffffff99094ec4 [unknown] (vmlinux+0xffffffff99094ec4)
       perf-exec 2531039 4120893.685970:          1 cycles:  ffffffff99094ec4 [unknown] (vmlinux+0xffffffff99094ec4)
       perf-exec 2531039 4120893.685972:          9 cycles:  ffffffff99094ec4 [unknown] (vmlinux+0xffffffff99094ec4)
       perf-exec 2531039 4120893.685973:        194 cycles:  ffffffff99094ec6 [unknown] (vmlinux+0xffffffff99094ec6)

Do you have better idea?

-- 
Cheers,
Changbin Du
