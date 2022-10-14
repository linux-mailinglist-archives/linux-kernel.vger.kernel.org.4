Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D2A5FEEB3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 15:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiJNNd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 09:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiJNNdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 09:33:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6AE1CD6A9;
        Fri, 14 Oct 2022 06:33:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 557EEB81CBA;
        Fri, 14 Oct 2022 13:33:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E05D7C433D6;
        Fri, 14 Oct 2022 13:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665754430;
        bh=4pqJhpYw5cLPbfAk/LnCp5v+rvER8PV3HC7X8MIf+Gc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TDMot0xeNN6kA3wWfXoIl5R1QRnkYpXjH740c/5rV/pqvczQIjQRWpBuzMn+gtZ4Z
         C/Dq4aJ2z4s+Nb3oZgYFdFHQLhhrw8+LXFpydnt8Q0fRi9vmFPXxbp3sHv+sIJ35wl
         Huk1+0/HNNC/kGx1hAYlRJT/2yrxfdkqJyrBkhtDtpMZT9c9UfJhSVpJVBSQpNO3Pg
         8MLyD3zAt8t5Y0duya3AYIUMhGBmIoniM0g5p/2JlJXN3s18Y5/j8aD2RVkn732u57
         gVcm2oxyIXMjl0UV/ypGNjwLGJV1mARw4XdiQCRC76DYxtQiulgpl7shpku1QgKXw3
         Gwa7HYEJABjmQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CAE9E4062C; Fri, 14 Oct 2022 10:33:47 -0300 (-03)
Date:   Fri, 14 Oct 2022 10:33:47 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, linux-perf-users@vger.kernel.org,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf test: Fix test_arm_coresight.sh failures on Juno
Message-ID: <Y0llO2itucU5wwxR@kernel.org>
References: <20221005140508.1537277-1-james.clark@arm.com>
 <Yz7qx+4BxNYOCgvL@leoy-yangtze.lan>
 <cce859cc-f25b-b4e8-70c5-917569aec050@arm.com>
 <Y0PMj4V4MBh4J/ao@leoy-yangtze.lan>
 <7dcf8bc5-4182-cf73-59ec-86e113ab2c17@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7dcf8bc5-4182-cf73-59ec-86e113ab2c17@arm.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Oct 10, 2022 at 10:21:22AM +0100, James Clark escreveu:
> On 10/10/2022 08:41, Leo Yan wrote:
> > On Thu, Oct 06, 2022 at 04:11:05PM +0100, James Clark wrote:
> >>   Error:
> >>   The perf.data data has no samples!
> >>   0

> > Thanks for confirmation.  It's a bit weird that your Juno board doesn't
> > produce all zeros for timestamp packets.

> >> I think the issue is that ls is quite quick to run, so not much trace is
> >> generated for Perf. And it just depends on the scheduling which is
> >> slightly different on Juno. I don't think it's a bug. On N1SDP there are
> >> only 134 samples generated with i1000i, so it could probably end up with
> >> a random run generating 0 there too.

> > Agreed, changing to smaller interval makes sense for me.

> > Reviewed-by: Leo Yan <leo.yan@linaro.org>

> Thanks for the review Leo

Thanks, applied.

- Arnaldo

