Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD4C272D350
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 23:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233889AbjFLVaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 17:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjFLVaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 17:30:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2AC590;
        Mon, 12 Jun 2023 14:30:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 84E3962AEB;
        Mon, 12 Jun 2023 21:30:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3E4CC433D2;
        Mon, 12 Jun 2023 21:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686605413;
        bh=U52nlfJptELG0Pt6VjrxSD3IavwkMhBT7JDS3mBGqSY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aK/Isjmh6Xy5mmDf6W9Ee+Agc1+r+ipEE3P1T8W3Rd+TZAGpELt3N2TFr2tEqU82a
         JqX3SdA5IDxpNuz8RlXslTmvm1irezEW/YOM7Hajm1Ov+p4zdcpI9lDuVBW0Pvr6ch
         8j4zqWm/IVON+oshsww8/PtzSCVJd5eBplWswKUu6n4heFcqLcYNjA5Xxf9sEdr6KQ
         PPixIK/+4OisMrzvuWcMpSlZy9o0TEoBeDF42Qj1KsS3Smd/YxKIBTIkY9ipqOyYEB
         IVqSc9EeMk3kca/kFgIj+O1++FaFFVa03SHsaB7jIT1AOPgL1o327QhJlzYJ5tbKoZ
         AObi+WPyz59kA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6BE8040692; Mon, 12 Jun 2023 18:30:11 -0300 (-03)
Date:   Mon, 12 Jun 2023 18:30:11 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andi Kleen <ak@linux.intel.com>
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
Message-ID: <ZIeOY4OZM2BeaUhC@kernel.org>
References: <20230608232823.4027869-1-irogers@google.com>
 <20230608232823.4027869-27-irogers@google.com>
 <ZIcoJytUEz4UgQYR@kernel.org>
 <ZIcorZVu1z8jaPL/@kernel.org>
 <CAP-5=fXby-Yk3U4LCQeYkGU_E22kd92=dCnfb7DkN5iPYvCDGA@mail.gmail.com>
 <ZIdUncwTt2fBzxKh@kernel.org>
 <ZIeLMgsBm6cAUmHP@tassilo>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZIeLMgsBm6cAUmHP@tassilo>
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

Em Mon, Jun 12, 2023 at 02:16:34PM -0700, Andi Kleen escreveu:
> On Mon, Jun 12, 2023 at 02:23:41PM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Mon, Jun 12, 2023 at 07:46:14AM -0700, Ian Rogers escreveu:
> > > On Mon, Jun 12, 2023 at 7:16 AM Arnaldo Carvalho de Melo
> > > <acme@kernel.org> wrote:
> > > >
> > > > Em Mon, Jun 12, 2023 at 11:13:59AM -0300, Arnaldo Carvalho de Melo escreveu:
> > > > > Em Thu, Jun 08, 2023 at 04:28:23PM -0700, Ian Rogers escreveu:
> > > > > > srcline isn't freed if it is SRCLINE_UNKNOWN. Avoid strduping in this
> > > > > > case as such strdups are redundant and leak memory.
> > > > >
> > > > > The patch is ok as its what the rest of the code is doing, i.e. strcmp()
> > > > > to check if a srcline is the unknown one, but how about the following
> > > > > patch on top of yours?
> > > >
> > > > [acme@quaco perf-tools-next]$ strings ~/bin/perf | grep '??:0'
> > > > ??:0
> > > > SRCLINE_UNKNOWN ((char *) "??:0")
> > > > [acme@quaco perf-tools-next]$
> > > 
> > > Agreed, the strcmps make me nervous as they won't distinguish heap
> > > from a global meaning we could end up with things like pointers to
> > > freed memory. The comparison with the global is always going to be
> > > same imo.
> > > 
> > > Acked-by: Ian Rogers <irogers@google.com>
> > 
> > Thanks, applied and added your Acked-by.
> 
> Actually was there another patch that turned it into a explicit global? 
> 
> At least in my tree it isn't:
> 
> util/srcline.h
> 28:#define SRCLINE_UNKNOWN  ((char *) "??:0")
> 
> Without any explicit global it's a bit dangerous because you rely on the
> linker doing string deduplication.  While it normally does that there might be
> odd corner cases where it doesn't.

Yeah, several gcc and clang versions complained with:

2    65.38 almalinux:9                   : FAIL clang version 15.0.7 (Red Hat 15.0.7-2.el9)
    builtin-diff.c:1381:17: error: result of comparison against a string literal is unspecified (use an explicit string comparison function instead) [-Werror,-Wstring-compare]
            if (start_line != SRCLINE_UNKNOWN &&

So I added the following on top:

diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
index 48a04f42b308b080..aec596a0b0bbec0f 100644
--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -23,6 +23,8 @@
 
 bool srcline_full_filename;
 
+char *srcline__unknown = (char *)"??:0";
+
 static const char *dso__name(struct dso *dso)
 {
 	const char *dso_name;
diff --git a/tools/perf/util/srcline.h b/tools/perf/util/srcline.h
index a15c7db9058ece96..167645bcff0755e2 100644
--- a/tools/perf/util/srcline.h
+++ b/tools/perf/util/srcline.h
@@ -25,7 +25,8 @@ char *srcline__tree_find(struct rb_root_cached *tree, u64 addr);
 /* delete all srclines within the tree */
 void srcline__tree_delete(struct rb_root_cached *tree);
 
-#define SRCLINE_UNKNOWN  ((char *) "??:0")
+extern char *srcline__unknown;
+#define SRCLINE_UNKNOWN srcline__unknown
 
 struct inline_list {
 	struct symbol		*symbol;
