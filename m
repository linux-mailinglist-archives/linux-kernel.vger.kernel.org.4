Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE5968ED06
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 11:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbjBHKgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 05:36:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbjBHKgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 05:36:06 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6EB0347ECC;
        Wed,  8 Feb 2023 02:35:45 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C8BE1477;
        Wed,  8 Feb 2023 02:36:03 -0800 (PST)
Received: from [10.57.48.140] (unknown [10.57.48.140])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AB3863F8C6;
        Wed,  8 Feb 2023 02:35:18 -0800 (PST)
Message-ID: <0ded9983-8a37-d6c9-3de8-cbde6a4ce1e7@arm.com>
Date:   Wed, 8 Feb 2023 10:35:17 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] perf tools: Fix auto-complete on aarch64
Content-Language: en-US
To:     Yicong Yang <yangyicong@huawei.com>, acme@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, yangyicong@hisilicon.com,
        linuxarm@huawei.com, prime.zeng@hisilicon.com,
        mark.rutland@arm.com, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, yao.jin@linux.intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230207035057.43394-1-yangyicong@huawei.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20230207035057.43394-1-yangyicong@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/02/2023 03:50, Yicong Yang wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> On aarch64 CPU related events are not under event_source/devices/cpu/events,
> they're under event_source/devices/armv8_pmuv3_0/events on my machine.
> Using current auto-complete script will generate below error:
> 
> [root@localhost bin]# perf stat -e
> ls: cannot access '/sys/bus/event_source/devices/cpu/events': No such file or directory
> 
> Fix this by not test /sys/bus/event_source/devices/cpu/events on aarch64
> machine.
> 
> Fixes: 74cd5815d9af ("perf tool: Improve bash command line auto-complete for multiple events with comma")
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
>  tools/perf/perf-completion.sh | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 

Reviewed-by: James Clark <james.clark@arm.com>

> diff --git a/tools/perf/perf-completion.sh b/tools/perf/perf-completion.sh
> index fdf75d45efff..978249d7868c 100644
> --- a/tools/perf/perf-completion.sh
> +++ b/tools/perf/perf-completion.sh
> @@ -165,7 +165,12 @@ __perf_main ()
>  
>  		local cur1=${COMP_WORDS[COMP_CWORD]}
>  		local raw_evts=$($cmd list --raw-dump)
> -		local arr s tmp result
> +		local arr s tmp result cpu_evts
> +
> +		# aarch64 doesn't have /sys/bus/event_source/devices/cpu/events
> +		if [[ `uname -m` != aarch64 ]]; then
> +			cpu_evts=$(ls /sys/bus/event_source/devices/cpu/events)
> +		fi
>  
>  		if [[ "$cur1" == */* && ${cur1#*/} =~ ^[A-Z] ]]; then
>  			OLD_IFS="$IFS"
> @@ -183,9 +188,9 @@ __perf_main ()
>  				fi
>  			done
>  
> -			evts=${result}" "$(ls /sys/bus/event_source/devices/cpu/events)
> +			evts=${result}" "${cpu_evts}
>  		else
> -			evts=${raw_evts}" "$(ls /sys/bus/event_source/devices/cpu/events)
> +			evts=${raw_evts}" "${cpu_evts}
>  		fi
>  
>  		if [[ "$cur1" == , ]]; then
