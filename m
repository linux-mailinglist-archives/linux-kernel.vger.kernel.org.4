Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2CD06912A4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 22:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjBIV3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 16:29:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjBIV3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 16:29:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDACA6ADF2;
        Thu,  9 Feb 2023 13:29:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7072DB82315;
        Thu,  9 Feb 2023 21:29:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D270EC433D2;
        Thu,  9 Feb 2023 21:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675978189;
        bh=bhStTkWBXYavX+5JJIgffrgbDoXU1ftYdER+pfSWJb8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p7rK5sUnLDzz7CD0Cuhc/6Gn1f2z68D+mQfl4R5638pdO6TWzRcluOyxJHvQmwOxB
         5lRTMDXk5FkBOW99xSLBX3d+qOL9Z8y0qV1wGxdh/usKVoAN2mVzrX42B9bNOJR93s
         eTF6RA+VHD0Vn7JLRdw5vVvFbWtghq7mwiLZrjzJYqvf7rdizTwkheycfETf1nS/Cq
         M0zDKCi5jOcZJmpw09VX68DpOf0o43vKWh1yXT9x/30OonLjapm13t9fHdVrcCNVCW
         aG8KFi7RN2JRGdEUInwQuBh3pIpDblt83i5A9rDMA78ChPAtMfNzbaxwUDXHZEjHMs
         Or4OjCeDNQM8g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CBD5440444; Thu,  9 Feb 2023 18:29:45 -0300 (-03)
Date:   Thu, 9 Feb 2023 18:29:45 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        James Clark <james.clark@arm.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>,
        Perry Taylor <perry.taylor@intel.com>
Subject: Re: [PATCH v1] perf stat: Avoid merging/aggregating metric counts
 twice
Message-ID: <Y+VlyR9IF8Ky460u@kernel.org>
References: <20230209064447.83733-1-irogers@google.com>
 <CAM9d7ciJpB8qAN1OW+xe-ofuzK9tgytNyrV4modEePKJicX-=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7ciJpB8qAN1OW+xe-ofuzK9tgytNyrV4modEePKJicX-=w@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Feb 09, 2023 at 11:06:22AM -0800, Namhyung Kim escreveu:
> On Wed, Feb 8, 2023 at 10:45 PM Ian Rogers <irogers@google.com> wrote:

> > The added perf_stat_merge_counters combines uncore counters. When
> > metrics are enabled, the counts are merged into a metric_leader
> > via the stat-shadow saved_value logic. As the leader now is
> > passed an aggregated count, it leads to all counters being added
> > together twice and counts appearing approximately doubled in
> > metrics.

> > This change disables the saved_value merging of counts for evsels
> > that are merged. It is recommended that later changes remove the
> > saved_value entirely as the two layers of aggregation in the code
> > is confusing.
 
> +1

'perf stat' code needs help, that I'm sure, its great that you guys are
looking/working at/on it, please continue.
 
> >
> > Fixes: 942c5593393d ("perf stat: Add perf_stat_merge_counters()")
> > Reported-by: Perry Taylor <perry.taylor@intel.com>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied.

- Arnaldo
