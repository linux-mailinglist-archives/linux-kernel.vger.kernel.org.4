Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1E2C63604B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 14:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236865AbiKWNqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 08:46:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238308AbiKWNqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 08:46:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFC1E1BF9;
        Wed, 23 Nov 2022 05:35:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2D176B81FE2;
        Wed, 23 Nov 2022 13:35:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA1E3C433D7;
        Wed, 23 Nov 2022 13:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669210511;
        bh=eqQhB3JpwUD9N1JaSv+YIyRx7mv/TnGAZqN9bDQUYdM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NIefZlfTT8OgpJHFnIhhhXYooyAZkBLK10g1K2THsxX/tEFzwWUSuRxX+beX97nCS
         yLTfZbaJxy1ZwTF5P6BRSbJdlvSldo3IktNkfW82ysLHUD0g0W+QVYGYVDwqWvq8hl
         EfTr0PWMVUauhXX3b2tSYA54dWa/YuKcRv1g3rJch/cwlONnhwBPbZ9+h8+j0kz9C4
         Fn3c+3+lHDJ3WMWUXiPfE9T7qmOxm8VjKCxdrcFYI47NR1tIEqDpFEDOhZCd9dWKlH
         h65gpcvv8ksMYggTocV4gFZNx54mNWpgiqbM+/yMrm9vxj47HEVAd/BbTBma4G5g0Z
         Nv7MyaTlyT81A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B4E514034E; Wed, 23 Nov 2022 10:35:09 -0300 (-03)
Date:   Wed, 23 Nov 2022 10:35:09 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf inject: Set PERF_RECORD_MISC_BUILD_ID_SIZE
Message-ID: <Y34hjaIcCUr/80Vx@kernel.org>
References: <20221119002750.1568027-1-namhyung@kernel.org>
 <5e408880-3394-c943-6ed5-6ceb8d05fd07@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e408880-3394-c943-6ed5-6ceb8d05fd07@intel.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Nov 21, 2022 at 10:45:14AM +0200, Adrian Hunter escreveu:
> On 19/11/22 02:27, Namhyung Kim wrote:
> > With perf inject -b, it synthesizes build-id event for DSOs.  But it
> > missed to set the size and resulted in having trailing zeros.
> > 
> > As perf record sets the size in write_build_id(), let's set the size
> > here as well.
> > 
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> 
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks, applied.

- Arnaldo

 
> > ---
> >  tools/perf/util/synthetic-events.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
> > index cccd293b5312..0645795ff080 100644
> > --- a/tools/perf/util/synthetic-events.c
> > +++ b/tools/perf/util/synthetic-events.c
> > @@ -2218,8 +2218,9 @@ int perf_event__synthesize_build_id(struct perf_tool *tool, struct dso *pos, u16
> >  	len = pos->long_name_len + 1;
> >  	len = PERF_ALIGN(len, NAME_ALIGN);
> >  	memcpy(&ev.build_id.build_id, pos->bid.data, sizeof(pos->bid.data));
> > +	ev.build_id.size = pos->bid.size;
> >  	ev.build_id.header.type = PERF_RECORD_HEADER_BUILD_ID;
> > -	ev.build_id.header.misc = misc;
> > +	ev.build_id.header.misc = misc | PERF_RECORD_MISC_BUILD_ID_SIZE;
> >  	ev.build_id.pid = machine->pid;
> >  	ev.build_id.header.size = sizeof(ev.build_id) + len;
> >  	memcpy(&ev.build_id.filename, pos->long_name, pos->long_name_len);

-- 

- Arnaldo
