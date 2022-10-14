Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6709E5FF303
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 19:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiJNRds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 13:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiJNRdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 13:33:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224F31D3742;
        Fri, 14 Oct 2022 10:33:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D6E14B82371;
        Fri, 14 Oct 2022 17:33:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7739FC433D6;
        Fri, 14 Oct 2022 17:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665768821;
        bh=Ghh1xTYZsprDmNJLjVnEuIi5lRHTYT+xbcK0fCgf3RQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QHXrzxEl51G7p2UCouGJxsTyiHjOAXpZ2C4MX1bVGiGSGtP81MWr8qqZJq2Va7pEB
         BMg/OG4v2xHZXK/fUktDHFYm/u42zCowjhRAXq8UFjziqtUVHJFRMwc3NOcm7pfvFh
         nZMXzYjxnDmpk4G3S1R4kn7ks7K2R+c3FGpgfsKrB+eqZgc7WScRXwFot022kmIsL9
         YwyC+17mxZV8Cm3JLiKpWg7mbLxAzZlDuyFW433/7vy0wYGbN4n/fqYcvH/AI/Dtl2
         JwdrCrySf8wwHEG4dMK/fFrFg/k0KfMGbJx3IyW7lTKKgp5eGcJNNs2D6155W1eSiv
         xr9querwldoWw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 42FB24062C; Fri, 14 Oct 2022 14:33:39 -0300 (-03)
Date:   Fri, 14 Oct 2022 14:33:39 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 5/7] perf test: test_intel_pt.sh: Add jitdump test
Message-ID: <Y0mdc9V0uBdRPcYz@kernel.org>
References: <20221014170905.64069-1-adrian.hunter@intel.com>
 <20221014170905.64069-6-adrian.hunter@intel.com>
 <Y0mcWpc4KaeXpU+z@kernel.org>
 <Y0mdIxx630X5zi4V@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0mdIxx630X5zi4V@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Oct 14, 2022 at 02:32:19PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Oct 14, 2022 at 02:28:58PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Miscellaneous Intel PT testing: Ok
 
> Actually:
 
> --- Test tracing self-modifying code that uses jitdump ---
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.018 MB /tmp/perf-test-intel-pt-sh.GJoKOxGVFY/tmp-perf.data ]
> 
> Warning:
> 1 instruction trace errors
> /home/acme/git/perf
> Decode failed, 1 errors
> Warning:
> 1 instruction trace errors
>  instruction trace error type 1 time 494778.777081924 cpu 3 pid 309650 tid 309650 ip 0x7f0972f22009 code 5: Failed to get instruction
> --- Cleaning up ---
> --- Done ---
> test child finished with -1
> ---- end ----
> Miscellaneous Intel PT testing: FAILED!
> [root@quaco perf]#
> [root@quaco perf]# pwd
> /home/acme/git/perf

I see... nevermind, this is what is expected, failing now, then the fix,
then stops failing, nothing to see here, move along 8-)

- Arnaldo
