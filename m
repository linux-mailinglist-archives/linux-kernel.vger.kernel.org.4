Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9645FF114
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 17:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbiJNPUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 11:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbiJNPUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 11:20:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2758E8E71C;
        Fri, 14 Oct 2022 08:20:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F32F61B9D;
        Fri, 14 Oct 2022 15:20:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2098C433B5;
        Fri, 14 Oct 2022 15:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665760811;
        bh=cMpCOyywjfdKFz+3C0fvxrDh4xfhWaSsnQ3CupGT+bU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oBwG3zL2g6Wem5ygViETMOxoQ2hCL8DhLIp6b2UhyfbR+JhK4arKs02E8Pb++o7VS
         9UYuUHtXX2CsCQ16l3HO+EyR4T8qrAquJ4JvQg0+WNje0J2kGvQW4tihsIgKreta44
         XfIHMQ84XeJJ6a1WjAVJbG4HQRwuO1IZIAZb8h7tB8WPYyAh+UFXOgbrRdLwuMEq2L
         D0kT9Ts8E8nuujVGG1a1d2qdYbyqJgd98zcqaGS/fAm3uMwdrRB2rhJikX/PBDtalH
         w5QoViilZdKW95YBT/KlSz3WmumV7VsG2LqRHe6idznmsolZAH9Vrm3dOX5MMFqRLA
         afZDwvTS5VnMQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2E27F4062C; Fri, 14 Oct 2022 12:20:09 -0300 (-03)
Date:   Fri, 14 Oct 2022 12:20:09 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: [PATCH] perf mem: Fix -C option behavior for perf mem record
Message-ID: <Y0l+KXH9tBnjoil4@kernel.org>
References: <20221004200211.1444521-1-namhyung@kernel.org>
 <Yz5vUmZtQzYNRt73@leoy-yangtze.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yz5vUmZtQzYNRt73@leoy-yangtze.lan>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Oct 06, 2022 at 02:01:54PM +0800, Leo Yan escreveu:
> On Tue, Oct 04, 2022 at 01:02:11PM -0700, Namhyung Kim wrote:
> > The -C/--cpu option was maily for report but it also affected record as
> > it ate the option.  So users needed to use "--" after perf mem record to
> > pass the info to the perf record properly.
> > 
> > Check if this option is set for record, and pass it to the actual perf
> > record.
> > 
> > Before)
> >   $ sudo perf --debug perf-event-open mem record -C 0 2>&1 | grep -a sys_perf_event_open
> >   ...
> >   sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 4
> >   sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 = 5
> >   sys_perf_event_open: pid -1  cpu 2  group_fd -1  flags 0x8 = 6
> >   sys_perf_event_open: pid -1  cpu 3  group_fd -1  flags 0x8 = 7
> >   sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 8
> >   sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 = 9
> >   sys_perf_event_open: pid -1  cpu 2  group_fd -1  flags 0x8 = 10
> >   sys_perf_event_open: pid -1  cpu 3  group_fd -1  flags 0x8 = 11
> >   ...
> > 
> > After)
> >   $ sudo perf --debug perf-event-open mem record -C 0 2>&1 | grep -a sys_perf_event_open
> >   ...
> >   sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 4
> >   sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 5
> >   sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 6
> >   sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 7
> > 
> > Cc: Leo Yan <leo.yan@linaro.org>
> > Reported-by: Ravi Bangoria <ravi.bangoria@amd.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> 
> The change LGTM:
> 
> Reviewed-by: Leo Yan <leo.yan@linaro.org>
> Tested-by: Leo Yan <leo.yan@linaro.org>

Thanks, applied.

- Arnaldo

