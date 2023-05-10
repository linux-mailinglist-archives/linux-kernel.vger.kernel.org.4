Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDFE16FE352
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 19:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235006AbjEJRhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 13:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232414AbjEJRhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 13:37:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79834480;
        Wed, 10 May 2023 10:37:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49BA261213;
        Wed, 10 May 2023 17:37:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66B62C433D2;
        Wed, 10 May 2023 17:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683740230;
        bh=+x+E11GYK8LSZ8F875Waeh17nLuH51uR1wSnDgnlKvY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MYG2Skk+VbgEuquPuxDVEg2EgbjbyzdFwGeyPtZWkEjwE9COQ2fmbTy9fJJq0nSb2
         ik+0kKAy39sEunQ3Y+4kbMbydu7VElrJL5ZVZ3uTylekARPX5vNHFbUTSBiemHp73F
         B/oUusSvQX0+muOGAsBIMEPfWu5LWZAagy5f9yNnC5ed6eepcpYvj92g6oAGrgLqZD
         xC5kgwg7v+SunUIEDO/LrGhqCxd1rWZCYQhfNClMVjvd34lFuLMaEkHup9VLSP7wtA
         GVj/+5+slU1aoCw6A9jG6sLkUK5pg96PPmVKveq3EJlktQY7LO7wTry/6P2IrDH3Bd
         MLnLeLH5qC9bg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2CC82403B5; Wed, 10 May 2023 14:37:08 -0300 (-03)
Date:   Wed, 10 May 2023 14:37:08 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Sandipan Das <sandipan.das@amd.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com, terrelln@fb.com,
        ravi.bangoria@amd.com, ananth.narayan@amd.com
Subject: Re: [PATCH 1/2] perf script: Skip aggregation for stat events
Message-ID: <ZFvWRFGJlAPsgsZL@kernel.org>
References: <83d6c6c05c54bf00c5a9df32ac160718efca0c7a.1683280603.git.sandipan.das@amd.com>
 <CAM9d7cgZLiRmUDnxW3NpN67Jvgj670FPBkwqncXmDEamYM6n3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7cgZLiRmUDnxW3NpN67Jvgj670FPBkwqncXmDEamYM6n3A@mail.gmail.com>
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

Em Fri, May 05, 2023 at 04:43:20PM -0700, Namhyung Kim escreveu:
> Hello,
> 
> On Fri, May 5, 2023 at 3:03 AM Sandipan Das <sandipan.das@amd.com> wrote:
> >
> > The script command does not support aggregation modes by itself although
> > that can be achieved using post-processing scripts. Because of this, it
> > does not allocate memory for aggregated event values.
> >
> > Upon running perf stat record, the aggregation mode is set in the perf
> > data file. If the mode is AGGR_GLOBAL, the aggregated event values are
> > accessed and this leads to a segmentation fault since these were never
> > allocated to begin with. Set the mode to AGGR_NONE explicitly to avoid
> > this.
> >
> > E.g.
> >
> >   $ perf stat record -e cycles true
> >   $ perf script
> >
> > Before:
> >   Segmentation fault (core dumped)
> >
> > After:
> >   CPU   THREAD             VAL             ENA             RUN            TIME EVENT
> >    -1   231919          162831          362069          362069          935289 cycles:u
> >
> > Fixes: 8b76a3188b85 ("perf stat: Remove unused perf_counts.aggr field")
> > Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> > Cc: stable@vger.kernel.org # v6.2+
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied both to perf-tools, for v6.4.

- Arnaldo

