Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35FE4681022
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 15:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236853AbjA3OAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 09:00:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236838AbjA3OAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 09:00:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5D3CDD7;
        Mon, 30 Jan 2023 06:00:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C0F0EB81181;
        Mon, 30 Jan 2023 14:00:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 392C7C433D2;
        Mon, 30 Jan 2023 13:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675087199;
        bh=quv2gJS96/kOS1MFut+Kr8y2xgXp9TjMtnbVARKYfnA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uzvOKTqQcQtzIIYAvD3n65utmLEdbE58vLC9z8CbeuI/5qddveBKaGeXNbT4OaHgZ
         YimHeCEjCEiFBh8l1MMolnCghKtIA450S8/uzLCwajTPROvYYcelpreaYahekalF5d
         EzDvzS7i8xsGStq90NxuXGM40m9mWlVXXx22AlcVijXSi0TmjpDhjSaI2M3xo/262F
         +aNSjnUO7vpKBEInm90075StyXYX4cqGAmu8ZJFPQL2iInWCAVGwYs3QUdXlbNe3Er
         CO10wLAfbhGO8OmCkcyqrHWL8UALZfAkhApa59UQeAK6S6CHsXyt7lCNNsLD6dLZZC
         B0lzuMnILBFjg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 00BFC405BE; Mon, 30 Jan 2023 10:59:54 -0300 (-03)
Date:   Mon, 30 Jan 2023 10:59:54 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     Mike Leach <mike.leach@linaro.org>,
        linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        mathieu.poirier@linaro.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, Ian Rogers <irogers@google.com>
Subject: Re: [PATCH] perf: cs-etm: Update decoder code for OpenCSD version 1.4
Message-ID: <Y9fNWrBIN8o1Ww25@kernel.org>
References: <20230120153706.20388-1-mike.leach@linaro.org>
 <77f9eab5-4fb2-cf96-9628-2a816d519d61@arm.com>
 <CAP-5=fWNT9XXMN+97TcprxWA+FRJpAy4T=XC9RHrOdKfcKi8_w@mail.gmail.com>
 <f17a40d4-2a37-fe7a-eac9-4ac1215e2c20@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f17a40d4-2a37-fe7a-eac9-4ac1215e2c20@arm.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jan 30, 2023 at 12:05:53PM +0000, James Clark escreveu:
> On 24/01/2023 21:50, Ian Rogers wrote:
> > On Fri, Jan 20, 2023 at 7:47 AM James Clark <james.clark@arm.com> wrote:
> >> On 20/01/2023 15:37, Mike Leach wrote:
> >>> OpenCSD version 1.4 is released with support for FEAT_ITE.
> >>> This adds a new packet type, with associated output element ID in
> >>> the packet type enum - OCSD_GEN_TRC_ELEM_INSTRUMENTATION.
> >>>
> >>> As we just ignore this packet in perf, add to the switch statement
> >>> to avoid the "enum not handled in switch error", but conditionally
> >>> so as not to break the perf build for older OpenCSD installations.
> >>>
> >>> Signed-off-by: Mike Leach <mike.leach@linaro.org>
> >>> ---
> >>>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 3 +++
> >>>  1 file changed, 3 insertions(+)
> >>>
> >>> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> >>> index fa3aa9c0fb2e..48e7121880a9 100644
> >>> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> >>> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> >>> @@ -604,6 +604,9 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
> >>>       case OCSD_GEN_TRC_ELEM_CUSTOM:
> >>>       case OCSD_GEN_TRC_ELEM_SYNC_MARKER:
> >>>       case OCSD_GEN_TRC_ELEM_MEMTRANS:
> >>> +#if (OCSD_VER_NUM >= 0x010400)
> >>> +     case OCSD_GEN_TRC_ELEM_INSTRUMENTATION:
> >>> +#endif
> >>>       default:
> >>>               break;
> >>>       }
> >>
> >> Checked the build with both old and new versions of OpenCSD and it's ok:
> >>
> >> Reviewed-by: James Clark <james.clark@arm.com>
> > 
> > Acked-by: Ian Rogers <irogers@google.com>
> > 
> > Thanks,
> > Ian
> 
> Hi Arnaldo,
> 
> Is it ok to merge this change? If anyone is building with the latest
> OpenCSD they will get a build error on the unhandled switch case, and we
> just got it in our CI too.
> 
> I suppose we could disable the warning around this switch, but it's
> pretty rare to add new packets so might be best to leave it.

Thanks, applied.

- Arnaldo
