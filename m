Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 514D764CC7F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 15:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238347AbiLNOmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 09:42:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiLNOl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 09:41:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BDAEE66;
        Wed, 14 Dec 2022 06:41:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35C5161AE4;
        Wed, 14 Dec 2022 14:41:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7217AC433D2;
        Wed, 14 Dec 2022 14:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671028917;
        bh=VLCo9NWSBq0vwcmbRig0inYNkCeha72qgISlOwva6NI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S0tikTchugSgMWBsFOI2UZvZWnFNa+nfW55fhGBD4qfDEEb++Ri8wJXvcPaNb+G3B
         UzGv+Mv7zejQkOpz6bu/RM+owEnBrYxnJdHwXxXrB8LmNK9wNwaxF8oI8hv6escX4Q
         keLdRXbEYD0/ZZdeM+HvNhp9uihxp1QR/Ffg+rKLElU4qjVs5bluS+NvcthddlTMjM
         UZe2v99KAN0GHTIu3lnZYtEzARZMe0epK2RLP3oCWCdxYSny6eSXBEjD6vkgHHOI5P
         2oE55+r/cYxRVl/Klrslf0Z8XF25R76pgOBR/8cE2U1OqfOqFAVuIt79ecp5CpXMgP
         Z/7bfG9K04ziw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 65B6840367; Wed, 14 Dec 2022 11:41:55 -0300 (-03)
Date:   Wed, 14 Dec 2022 11:41:55 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     James Clark <james.clark@arm.com>,
        =?iso-8859-1?Q?Adri=E1n?= Herrera Arcila 
        <adrian.herrera@arm.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        songliubraving@fb.com, peterz@infradead.org, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org
Subject: Re: [PATCH 2/2] perf stat: fix unexpected delay behaviour
Message-ID: <Y5ngs0bh/R8xPFvo@kernel.org>
References: <20220729161244.10522-1-adrian.herrera@arm.com>
 <20220729161244.10522-2-adrian.herrera@arm.com>
 <e3e123db-5321-c96e-1753-27059c729640@arm.com>
 <Y5iPsjF/lEsEldU8@kernel.org>
 <CAM9d7cj=Pu2QAONzd2JSVzd_X9DakeV=khcFGD_d-ES5zrx+KQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7cj=Pu2QAONzd2JSVzd_X9DakeV=khcFGD_d-ES5zrx+KQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Dec 13, 2022 at 08:40:31AM -0800, Namhyung Kim escreveu:
> Hi,
> 
> On Tue, Dec 13, 2022 at 6:44 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Em Mon, Aug 01, 2022 at 09:20:37AM +0100, James Clark escreveu:
> > >
> > >
> > > On 29/07/2022 17:12, Adrián Herrera Arcila wrote:
> > > > The described --delay behaviour is to delay the enablement of events, but
> > > > not the execution of the command, if one is passed, which is incorrectly
> > > > the current behaviour.
> > > >
> > > > This patch decouples the enablement from the delay, and enables events
> > > > before or after launching the workload dependent on the options passed
> > > > by the user. This code structure is inspired by that in perf-record, and
> > > > tries to be consistent with it.
> > > >
> > > > Link: https://lore.kernel.org/linux-perf-users/7BFD066E-B0A8-49D4-B635-379328F0CF4C@fb.com
> > > > Fixes: d0a0a511493d ("perf stat: Fix forked applications enablement of counters")
> > > > Signed-off-by: Adrián Herrera Arcila <adrian.herrera@arm.com>
> > > > ---
> > > >  tools/perf/builtin-stat.c | 56 ++++++++++++++++++++++-----------------
> > > >  1 file changed, 32 insertions(+), 24 deletions(-)
> > >
> > > Looks good to me. Fixes the counter delay issue and the code is pretty
> > > similar to perf record now. Although I would wait for Leo's or Song's
> > > comment as well because they were involved.
> >
> > I think I didn't notice Leo's ack, it still applies, so I'm doing it
> > now.
> 
> I think the BPF counters should be enabled/disabled together.

Ok, so I removed this one and applied Namhyung's.

- Arnaldo
