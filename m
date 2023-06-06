Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13D1E724ACB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 20:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238870AbjFFSHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 14:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238105AbjFFSHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 14:07:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71BBD10DF;
        Tue,  6 Jun 2023 11:07:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E7A2635DA;
        Tue,  6 Jun 2023 18:07:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 432DEC433D2;
        Tue,  6 Jun 2023 18:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686074854;
        bh=7lLqWH4ip8VH/3WA/LhtLtBwcCFutgrU/RLWoVwcJ40=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UHHxQUQ4V+KV78PfL6CvVJsFoeJAzA5U5czMdfVkZkrWXJsqa4dKgiceE7YSvy2y0
         TlTXjyHSDwX4Udet2BCZm8fdoWAFWY0vyRu7Se30RUQkqdboydkcKR8/cB4x5xlNkL
         nwYvh/YBRiRGSe21I5v+KbMy0W8eMCecZ2zQ25uG4Q52VtOSYbygACO06L2NqwG2pv
         EBf8pTb5TjxWj+58oDzlKaLhINIFqJjPA0XX7iUHSE+p5nn9q58wftWbvqJKaNzJfi
         fabQ8qvRyNZw5EvIKZ11BpanKscjth34kkQtACBxPITrwHszk1+EvPChrvP2avDMdh
         gziMzj3NzRMLA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1059A40692; Tue,  6 Jun 2023 15:07:32 -0300 (-03)
Date:   Tue, 6 Jun 2023 15:07:32 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
        denik@chromium.org, Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] perf cs-etm: Track exception level
Message-ID: <ZH915HtVcUnLxHsd@kernel.org>
References: <20230524131958.2139331-1-james.clark@arm.com>
 <ZH47LeSnwY2uKs//@kernel.org>
 <20230606004648.GB18315@leoy-huanghe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606004648.GB18315@leoy-huanghe>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jun 06, 2023 at 08:46:48AM +0800, Leo Yan escreveu:
> Hi Arnaldo,
> 
> On Mon, Jun 05, 2023 at 04:44:45PM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Wed, May 24, 2023 at 02:19:54PM +0100, James Clark escreveu:
> > > Some fixes to support an issue reported by Denis Nikitin where decoding
> > > trace that contains different EL1 and EL2 kernels can crash or go into
> > > an infinite loop because the wrong kernel maps are used for the decode.
> > > 
> > > This still doesn't support distinguishing guest and host userspace,
> > > we'd still have to fix the timestamps and do a bit more work to
> > > correlate that. And I've removed PERF_RECORD_MISC_HYPERVISOR as a
> > > possible outcome of cs_etm__cpu_mode(). As far as I know this could
> > > never have been returned anyway because machine__is_host(machine) was
> > > always true due to session.machines.host being hard coded. And I'm not
> > > sure of the relevance of the difference between PERF_RECORD_MISC_KERNEL
> > > and PERF_RECORD_MISC_HYPERVISOR in this scenario.
> > > 
> > > The first commit is a tidy up, second fixes a bug that I found when
> > > comparing the exception level and thread of branch records, the third
> > > is the main fix, and the last commit is some extra error checking. 
> > > 
> > > Applies to acme/perf-tools (4e111f0cf0)
> > 
> > So there seems to be agreement the first two patches can be applied? May
> > I go ahead and do that now?
> 
> Could you pick up the first patch in this series?
> 
> I would like ask James to refine a bit for the second patch.

Ok, left just the first patch on my local perf-tools-next branch, will
go public when tested.

- Arnaldo
