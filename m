Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43BE667A12F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 19:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233241AbjAXSgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 13:36:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjAXSf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 13:35:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660A215540;
        Tue, 24 Jan 2023 10:35:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1783CB81626;
        Tue, 24 Jan 2023 18:35:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A4FCC433EF;
        Tue, 24 Jan 2023 18:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674585354;
        bh=ecw1HDAx/+YfF8fDaE86JWnh72Q1KtAwWY6gHp+pIM8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LAZN6Tdqxze+AsePtssuTbmOMLRdndLlNAwk9k97gheozfoDL3QoIRjZm4evxkdVF
         EAF79us76KzrLHOk91AwvUqnorCkK2+p2Z0wtjOvILCYJT+DKiGvew/rfiNxWjYkTb
         vrd1j/oqm1sxP0VSqvHttkeEh5lRWYDCfKcOEaw3EbtrFgyxEUEaxqSBoyVgOzVPx5
         KFqJVHJkp00798IIRO3tfAtY/O8dS+zdSs9CEYj6uBqEtgF5tflXOsiWVZzxHKBWqH
         PqeqfT/SVIgqJqRNgV7+uRrKeZkcHWu4SK1WbCoZ5V0PLj7qe4TNinpd6VWyk69lbr
         a6A9X9+3ByabQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8D2DE405BE; Tue, 24 Jan 2023 15:35:51 -0300 (-03)
Date:   Tue, 24 Jan 2023 15:35:51 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] perf: cs-etm: Improve missing sink warning message
Message-ID: <Y9AlB8TJkV2mPO5l@kernel.org>
References: <20230124110220.460551-1-james.clark@arm.com>
 <1dbd558a-92b7-77ed-1bbe-0f421547bf54@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1dbd558a-92b7-77ed-1bbe-0f421547bf54@arm.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jan 24, 2023 at 11:08:32AM +0000, Suzuki K Poulose escreveu:
> On 24/01/2023 11:02, James Clark wrote:
> > Make the sink error message more similar to the event error message that
> > reminds about missing kernel support. The available sinks are also
> > determined by the hardware so mention that too.
> > 
> > Also, usually it's not necessary to specify the sink, so add that as a
> > hint.
> > 
> > Now the error for a made up sink looks like this:
> > 
> >    $ perf record -e cs_etm/@abc/
> >    Couldn't find sink "abc" on event cs_etm/@abc/.
> >    Missing kernel or device support?
> > 
> >    Hint: An appropriate sink will be picked automatically if one isn't is specified.
> > 
> > For any error other than ENOENT, the same message as before is
> > displayed.
> > 
> > Signed-off-by: James Clark <james.clark@arm.com>
> 
> Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Thanks, applied.

- Arnaldo

