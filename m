Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8C06CA285
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 13:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbjC0Lel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 07:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232500AbjC0LeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 07:34:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A325A524E;
        Mon, 27 Mar 2023 04:34:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5F9F611CD;
        Mon, 27 Mar 2023 11:34:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A53CC433D2;
        Mon, 27 Mar 2023 11:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679916859;
        bh=SA/i1yJ7AzwsHKI1Lj57e8r058pyxPQCpM7WhIWzP2c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rhdo5wtI+ZOCL2/2eK8ieaBA0nCxM0c4bWnqPfjSMhvxsv1tsGi9D8TSL2MB1wxIn
         Mu+91hEhPooeQ8GdgSNngqVYrL7vSJBK4YFjcCwRdzx8vKlWclIWjdF5OKY1k+0FwL
         EZEBAqmSF9VPZSS+dVKc/eFxOyL3YIG2b719o8H2aiBM9VXsgEF7yUxEuFi5qDOvKK
         ViNkBLEBB1jOhyl5kBxSfIBQFeRl77NCFm9WK4bujbIHYtev8YmX+RYjnD1+4EDaaP
         dpr36U9+5tFpOiuYMX5LcqvueyBxci+91mXsLNef6ECtDESnXBfNDUV/uRi+u4ucEV
         cIfTsk6Y79Oqw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0E83D4052D; Mon, 27 Mar 2023 08:34:17 -0300 (-03)
Date:   Mon, 27 Mar 2023 08:34:17 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Yang Jihong <yangjihong1@huawei.com>, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf ftrace: Make system wide the default target for
 latency subcommand
Message-ID: <ZCF/Oa+dK4Wc/7r7@kernel.org>
References: <20230324032702.109964-1-yangjihong1@huawei.com>
 <CAM9d7ciGy2Mycm6etHDrt6tu331i-7DphHgBzde0_1=w67mvHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7ciGy2Mycm6etHDrt6tu331i-7DphHgBzde0_1=w67mvHg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Mar 24, 2023 at 06:39:25PM -0700, Namhyung Kim escreveu:
> Hello,
> 
> On Thu, Mar 23, 2023 at 8:29 PM Yang Jihong <yangjihong1@huawei.com> wrote:
> >
> > If no target is specified for 'latency' subcommand, the execution fails
> > because - 1 (invalid value) is written to set_ftrace_pid tracefs file.
> > Make system wide the default target, which is the same as the default
> > behavior of 'trace' subcommand.
> 
> I followed the convention to use -a for system-wide profiling.
> Not sure if it's ok to make it default, but I don't object. :)

I'll make that an Acked-by, ok?

- Arnaldo
 
> Thanks,
> Namhyung
> 
> >
> > Before the fix:
> >
> >   # perf ftrace latency -T schedule
> >   failed to set ftrace pid
> >
> > After the fix:
> >
> >   # perf ftrace latency -T schedule
> >   ^C#   DURATION     |      COUNT | GRAPH                                          |
> >        0 - 1    us |          0 |                                                |
> >        1 - 2    us |          0 |                                                |
> >        2 - 4    us |          0 |                                                |
> >        4 - 8    us |       2828 | ####                                           |
> >        8 - 16   us |      23953 | ########################################       |
> >       16 - 32   us |        408 |                                                |
> >       32 - 64   us |        318 |                                                |
> >       64 - 128  us |          4 |                                                |
> >      128 - 256  us |          3 |                                                |
> >      256 - 512  us |          0 |                                                |
> >      512 - 1024 us |          1 |                                                |
> >        1 - 2    ms |          4 |                                                |
> >        2 - 4    ms |          0 |                                                |
> >        4 - 8    ms |          0 |                                                |
> >        8 - 16   ms |          0 |                                                |
> >       16 - 32   ms |          0 |                                                |
> >       32 - 64   ms |          0 |                                                |
> >       64 - 128  ms |          0 |                                                |
> >      128 - 256  ms |          4 |                                                |
> >      256 - 512  ms |          2 |                                                |
> >      512 - 1024 ms |          0 |                                                |
> >        1 - ...   s |          0 |                                                |
> >
> > Fixes: 53be50282269 ("perf ftrace: Add 'latency' subcommand")
> > Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> > ---
> >  tools/perf/builtin-ftrace.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> > index d7fe00f66b83..fb1b66ef2e16 100644
> > --- a/tools/perf/builtin-ftrace.c
> > +++ b/tools/perf/builtin-ftrace.c
> > @@ -1228,10 +1228,12 @@ int cmd_ftrace(int argc, const char **argv)
> >                 goto out_delete_filters;
> >         }
> >
> > +       /* Make system wide (-a) the default target. */
> > +       if (!argc && target__none(&ftrace.target))
> > +               ftrace.target.system_wide = true;
> > +
> >         switch (subcmd) {
> >         case PERF_FTRACE_TRACE:
> > -               if (!argc && target__none(&ftrace.target))
> > -                       ftrace.target.system_wide = true;
> >                 cmd_func = __cmd_ftrace;
> >                 break;
> >         case PERF_FTRACE_LATENCY:
> > --
> > 2.30.GIT
> >

-- 

- Arnaldo
