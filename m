Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA18268EFF4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 14:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbjBHNjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 08:39:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbjBHNjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 08:39:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F662BEF6;
        Wed,  8 Feb 2023 05:39:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC2AA616D5;
        Wed,  8 Feb 2023 13:39:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E79DAC433D2;
        Wed,  8 Feb 2023 13:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675863559;
        bh=pv3vPHLrKcGHa0YzJtDB1Xj9xGNQLf1z6+qJ21VD+og=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EBdrWuLrzQOjHoat5//Vgiv1nXrIYSRoHUW/uNMxJ0k8bWa7VpDt5v4SIOwTwb/z2
         dFzbCjFDNqQnoqB1F/9Bi08a4eqnhZCmpuYSMuyVA/OGHVz1EJgkWdMsuJ5B1f3NSD
         MvO8t4L5FGZkev5afdwf6PTojqllihh0IFzRnR8dhXSREyIEmlcopUzKehmRU3VQ48
         ey5y2BogeQkSaogaIyxtW7dzkKR184+9h9WKCelkQsFuTuDzby916PluXNIjBJ8mHJ
         TO8OUaPr9PbjwxoX7ppFYPzMTBGOnMGY5EwfRp+DqpIYly8zLQMeWX2msZB+Wct+Ch
         DqBC8gDcxbj5Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9A2A5405BE; Wed,  8 Feb 2023 10:39:16 -0300 (-03)
Date:   Wed, 8 Feb 2023 10:39:16 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     Yicong Yang <yangyicong@huawei.com>,
        linux-arm-kernel@lists.infradead.org, yangyicong@hisilicon.com,
        linuxarm@huawei.com, prime.zeng@hisilicon.com,
        mark.rutland@arm.com, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, yao.jin@linux.intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tools: Fix auto-complete on aarch64
Message-ID: <Y+OmBGCL3DyKd28V@kernel.org>
References: <20230207035057.43394-1-yangyicong@huawei.com>
 <0ded9983-8a37-d6c9-3de8-cbde6a4ce1e7@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ded9983-8a37-d6c9-3de8-cbde6a4ce1e7@arm.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Feb 08, 2023 at 10:35:17AM +0000, James Clark escreveu:
> 
> 
> On 07/02/2023 03:50, Yicong Yang wrote:
> > From: Yicong Yang <yangyicong@hisilicon.com>
> > 
> > On aarch64 CPU related events are not under event_source/devices/cpu/events,
> > they're under event_source/devices/armv8_pmuv3_0/events on my machine.
> > Using current auto-complete script will generate below error:
> > 
> > [root@localhost bin]# perf stat -e
> > ls: cannot access '/sys/bus/event_source/devices/cpu/events': No such file or directory
> > 
> > Fix this by not test /sys/bus/event_source/devices/cpu/events on aarch64
> > machine.
> > 
> > Fixes: 74cd5815d9af ("perf tool: Improve bash command line auto-complete for multiple events with comma")
> > Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> > ---
> >  tools/perf/perf-completion.sh | 11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)
> > 
> 
> Reviewed-by: James Clark <james.clark@arm.com>

Thanks, applied.

- Arnaldo

 
> > diff --git a/tools/perf/perf-completion.sh b/tools/perf/perf-completion.sh
> > index fdf75d45efff..978249d7868c 100644
> > --- a/tools/perf/perf-completion.sh
> > +++ b/tools/perf/perf-completion.sh
> > @@ -165,7 +165,12 @@ __perf_main ()
> >  
> >  		local cur1=${COMP_WORDS[COMP_CWORD]}
> >  		local raw_evts=$($cmd list --raw-dump)
> > -		local arr s tmp result
> > +		local arr s tmp result cpu_evts
> > +
> > +		# aarch64 doesn't have /sys/bus/event_source/devices/cpu/events
> > +		if [[ `uname -m` != aarch64 ]]; then
> > +			cpu_evts=$(ls /sys/bus/event_source/devices/cpu/events)
> > +		fi
> >  
> >  		if [[ "$cur1" == */* && ${cur1#*/} =~ ^[A-Z] ]]; then
> >  			OLD_IFS="$IFS"
> > @@ -183,9 +188,9 @@ __perf_main ()
> >  				fi
> >  			done
> >  
> > -			evts=${result}" "$(ls /sys/bus/event_source/devices/cpu/events)
> > +			evts=${result}" "${cpu_evts}
> >  		else
> > -			evts=${raw_evts}" "$(ls /sys/bus/event_source/devices/cpu/events)
> > +			evts=${raw_evts}" "${cpu_evts}
> >  		fi
> >  
> >  		if [[ "$cur1" == , ]]; then

-- 

- Arnaldo
