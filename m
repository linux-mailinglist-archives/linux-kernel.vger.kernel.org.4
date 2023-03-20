Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E746C24C2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 23:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjCTW3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 18:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjCTW3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 18:29:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2DC619C;
        Mon, 20 Mar 2023 15:29:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 753BEB810F6;
        Mon, 20 Mar 2023 22:29:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04FCDC433EF;
        Mon, 20 Mar 2023 22:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679351352;
        bh=scf65u0jBdg4sE2X6WhlnAwDa/Qn0mokAtjRKzVKTBk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aZUC//1LZhzPYZGH5UOU4TgPC/YD48hCJ+XuVz6zUEw2Ap+w59sv+K+pRiSKuK7qH
         b1QX3JSgetAwDNbXlXreAosBbAs7Qlc3nmxNOkgfoawYYn+oNbGTXZpTxaemcM0b0L
         oxDL5zO2I40RkzwuIEMYIWcAkCHrwrdFPZt5+1RlrXW5mQ81rVIdlkT6so0ihzQM05
         BPkZ/mhJqNy7jaXB/T5AKeRFAroBlQxWi87V/sk4wONAh4uv/PE+kkM21ujCSZvErg
         CcELv5sT+SLNdzgVeA6GTdsTTDebiCyohXOXmunqoi+YC8dD5ZbgZ75o5V4WbTXabR
         xp+D1oMZIkppw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EC8E04052D; Mon, 20 Mar 2023 19:29:09 -0300 (-03)
Date:   Mon, 20 Mar 2023 19:29:09 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, Anshuman.Khandual@arm.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/4] Enable display of partial and empty SVE
 predicates from Arm SPE data
Message-ID: <ZBjeNW9wg4fQcLCU@kernel.org>
References: <20230320151509.1137462-1-james.clark@arm.com>
 <CAP-5=fUz_u8BODDn3OK5hh9xSbXbMZU0fiCJUdpoS3AFQGQ9GA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUz_u8BODDn3OK5hh9xSbXbMZU0fiCJUdpoS3AFQGQ9GA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Mar 20, 2023 at 10:50:59AM -0700, Ian Rogers escreveu:
> On Mon, Mar 20, 2023 at 8:15 AM James Clark <james.clark@arm.com> wrote:
> >
> > Changes since v1:
> >  * Rebase onto perf/core because it no longer applied cleanly
> >
> > ------------
> >
> > Hi,
> >
> > I'm submitting this on behalf of German who moved on to work on other
> > things in Arm before he could finish it off.
> >
> > The predicate information is available on SPE samples from
> > Armv8.3 (FEAT_SPEv1p1), this could be useful info for profiling SVE
> > code as partial and empty predicates indicate that the full vector
> > width isn't being used. There is a good example in the last commit
> > message.
> >
> > Though currently, there isn't a suitable field to store the info
> > on Perf samples, so this change also adds a new SIMD field.
> > This field could be used by other architectures, but currently there
> > is only one bit reserved to identify SVE. It's only added to
> > struct perf_sample on the userspace side, and isn't part of the kernel
> > ABI, so it doesn't survive a perf inject. Although this is the
> > same behavior for some other fields like branch flags, so I don't
> > think it should be an issue to do something similar here. Perhaps in
> > the future we could make sure everything that is synthesised from
> > auxtrace data also makes it back into the new Perf inject file without
> > being lost.
> 
> Series:
> Acked-by: Ian Rogers <irogers@google.com>

Thanks, applied.

- Arnaldo

 
> Thanks,
> Ian
> 
> > German Gomez (4):
> >   perf event: Add simd_flags field to perf_sample
> >   perf arm-spe: Refactor arm-spe to support operation packet type
> >   perf arm-spe: Add SVE flags to the SPE samples
> >   perf report: Add 'simd' sort field
> >
> >  tools/perf/Documentation/perf-report.txt      |  1 +
> >  .../util/arm-spe-decoder/arm-spe-decoder.c    | 30 ++++++++++--
> >  .../util/arm-spe-decoder/arm-spe-decoder.h    | 47 +++++++++++++++----
> >  tools/perf/util/arm-spe.c                     | 28 +++++++++--
> >  tools/perf/util/hist.c                        |  1 +
> >  tools/perf/util/hist.h                        |  1 +
> >  tools/perf/util/sample.h                      | 13 +++++
> >  tools/perf/util/sort.c                        | 47 +++++++++++++++++++
> >  tools/perf/util/sort.h                        |  2 +
> >  9 files changed, 152 insertions(+), 18 deletions(-)
> >
> >
> > base-commit: 96d541699e5c50b1bc2d50c83cd7145994d5f071
> > --
> > 2.34.1
> >

-- 

- Arnaldo
