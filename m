Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED326C31DD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 13:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbjCUMjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 08:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbjCUMjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 08:39:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43BCC6EB6;
        Tue, 21 Mar 2023 05:39:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F2428B81673;
        Tue, 21 Mar 2023 12:38:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 713ECC433EF;
        Tue, 21 Mar 2023 12:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679402337;
        bh=fxPcB6Lzqq1Y8arAf6NWGF782DnpVxwW96wS65uUn3I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R6LXbzPqlNuIO/oYPIzCbooFZT8R0Nh+MO5asOv2+KFUbu5hQQNmH/KsHN9uMx3av
         c1mXFTh0FULRl+/HgmX25sQF3pNbeIuEooZ4jPY1mYVZCg2K5sUCSTzUg0b9RzFx8R
         ovicJWaRaMhf4uG8BDSQPvzBeKvF1cTWN+inciYeUc+QUxpK0VpqZN6py8e6EEdKqT
         vI3EmqSGGpeO5l1vWW/dBtJk+qzo9XKH+JJsZcXIvUJxonMtVB6r1mCrPUbeCmryWv
         7B+ZHxbUkRPwuE+iZ1c3D4azzOrYDrD3I5jEthnR3/S8ULA8xY4QC6Dj9/WxI+FP+D
         HOMpX/gMrhfzA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0DCCA4052D; Tue, 21 Mar 2023 09:38:55 -0300 (-03)
Date:   Tue, 21 Mar 2023 09:38:55 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Bernhard M. Wiedemann" <bwiedemann@suse.de>
Cc:     linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf jevents: Sort list of input files
Message-ID: <ZBmlXzCty7wc9M4o@kernel.org>
References: <ZBjdIbF7BDphCH+k@kernel.org>
 <20230321063032.19804-1-bwiedemann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321063032.19804-1-bwiedemann@suse.de>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Mar 21, 2023 at 07:30:32AM +0100, Bernhard M. Wiedemann escreveu:
> Without this, pmu-events.c would be generated with variations in ordering
> depending on non-deterministic filesystem readdir order.
> 
> I tested that pmu-events.c still has the same number of lines
> and that perf list output works.
> 
> This patch was done while working on reproducible builds for openSUSE,
> but also solves issues in Debian [1] and other distributions.
> 
> [1] https://tests.reproducible-builds.org/debian/rb-pkg/unstable/i386/linux.html

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Bernhard M. Wiedemann <bwiedemann@suse.de>
> CC: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/pmu-events/jevents.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
> index 2bcd07ce609f..736ee0a75cf8 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py
> @@ -889,7 +889,7 @@ def main() -> None:
>    def ftw(path: str, parents: Sequence[str],
>            action: Callable[[Sequence[str], os.DirEntry], None]) -> None:
>      """Replicate the directory/file walking behavior of C's file tree walk."""
> -    for item in os.scandir(path):
> +    for item in sorted(os.scandir(path), key=lambda e: e.name):
>        if _args.model != 'all' and item.is_dir():
>          # Check if the model matches one in _args.model.
>          if len(parents) == _args.model.split(',')[0].count('/'):
> -- 
> 2.35.3
> 

-- 

- Arnaldo
