Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C356CBCD2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 12:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbjC1Ksc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 06:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbjC1Ks2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 06:48:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 72B0B76B6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 03:48:26 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 731CBC14;
        Tue, 28 Mar 2023 03:49:10 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E1ACC3F663;
        Tue, 28 Mar 2023 03:48:24 -0700 (PDT)
Date:   Tue, 28 Mar 2023 11:48:22 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Yicong Yang <yangyicong@huawei.com>
Cc:     Pierre Gondois <pierre.gondois@arm.com>, yangyicong@hisilicon.com,
        Sudeep Holla <sudeep.holla@arm.com>,
        gregkh@linuxfoundation.org, rafael@kernel.org, palmer@rivosinc.com,
        linux-kernel@vger.kernel.org, prime.zeng@hisilicon.com,
        linuxarm@huawei.com
Subject: Re: [PATCH] cacheinfo: Fix LLC is not exported through sysfs
Message-ID: <20230328104822.t2p4vxtcwz4j37ec@bogus>
References: <20230323122528.16691-1-yangyicong@huawei.com>
 <7cca5e74-6626-1c8b-9309-47b9f5d4395f@arm.com>
 <20230324113508.x2rt52aakruwelk3@bogus>
 <dd475eb6-7a0b-fbb4-316b-1af94c238699@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd475eb6-7a0b-fbb4-316b-1af94c238699@huawei.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 02:57:07PM +0800, Yicong Yang wrote:
> Hi Pierre and Sudeep,
> 
> On 2023/3/24 19:35, Sudeep Holla wrote:
> > On Thu, Mar 23, 2023 at 06:58:53PM +0100, Pierre Gondois wrote:
> >> Hello Yicong,
> >>
> >> FWIW, I think the patch is correct and I could reproduce the issue.
> >>
> >> On 3/23/23 13:25, Yicong Yang wrote:
> >>> From: Yicong Yang <yangyicong@hisilicon.com>
> >>>
> >>> After entering 6.3-rc1 the LLC cacheinfo is not exported on our ACPI
> >>> based arm64 server. This is because the LLC cacheinfo is partly reset
> >>> when secondary CPUs boot up. On arm64 the primary cpu will allocate
> >>> and setup cacheinfo:
> >>> init_cpu_topology()
> >>>    for_each_possible_cpu()
> >>>      fetch_cache_info() // Allocate cacheinfo and init levels
> >>> detect_cache_attributes()
> >>>    cache_shared_cpu_map_setup()
> >>>      if (!last_level_cache_is_valid()) // not valid, setup LLC
> >>>        cache_setup_properties() // setup LLC
> >>>
> >>> On secondary CPU boot up:
> >>> detect_cache_attributes()
> >>>    populate_cache_leaves()
> >>>      get_cache_type() // Get cache type from clidr_el1,
> >>>                       // for LLC type=CACHE_TYPE_NOCACHE
> >>>    cache_shared_cpu_map_setup()
> >>>      if (!last_level_cache_is_valid()) // Valid and won't go to this branch,
> >>>                                        // leave LLC's type=CACHE_TYPE_NOCACHE
> >>>
> >>> The last_level_cache_is_valid() use cacheinfo->{attributes, fw_token} to
> >>> test it's valid or not, but populate_cache_leaves() will only reset
> >>> LLC's type, so we won't try to re-setup LLC's type and leave it
> >>> CACHE_TYPE_NOCACHE and won't export it through sysfs.
> >>>
> > 
> > IIUC this is for the case where arch register doesn't report the system level
> > cache. I wonder if it makes sense to fix the arch callback to deal with that
> > instead of here. I am fine either way, just checking as ideally it is
> > something populate_cache_leaves() is messing up.
> > 
> 
> yes it's right, the LLC information is not provided by the CPU register and can
> only be retrieved from PPTT on my machine. Maybe fix the issue first, I don't
> know how to make arch callback handle this since arch_topology is also used
> other than arm64 which I'm not familiar with.
> 
> > [...]
> > 
> >>> @@ -481,6 +488,7 @@ int detect_cache_attributes(unsigned int cpu)
> >>>   	if (ret)
> >>>   		goto free_ci;
> >>> +update_cpu_map:
> >>
> >> Maybe just a suggestion about the code itself,
> >> it should be possible to replace the 'goto' by an 'if' condition.
> >> (Similarly, the 'populate_leaves:' label could have been avoided.)
> >>
> > 
> > Agreed, I prefer that as well.
> > 
> 
> ok, will modify as below with a little refactor to get rid of the
> 'populate_leaves:' label as suggested.
> 
> Thanks,
> Yicong
> 
> diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
> index f6573c335f4c..e34e6b77e81a 100644
> --- a/drivers/base/cacheinfo.c
> +++ b/drivers/base/cacheinfo.c
> @@ -462,24 +462,28 @@ int detect_cache_attributes(unsigned int cpu)
>          * as it will happen only once (the cacheinfo memory is never freed).
>          * Just populate the cacheinfo.
>          */
> -       if (per_cpu_cacheinfo(cpu))
> -               goto populate_leaves;
> -
> -       if (init_cache_level(cpu) || !cache_leaves(cpu))
> -               return -ENOENT;
> +       if (!per_cpu_cacheinfo(cpu)) {
> +               if (init_cache_level(cpu) || !cache_leaves(cpu))
> +                       return -ENOENT;
> 
> -       ret = allocate_cache_info(cpu);
> -       if (ret)
> -               return ret;
> +               ret = allocate_cache_info(cpu);
> +               if (ret)
> +                       return ret;
> +       }
> 
> -populate_leaves:
>         /*
> -        * populate_cache_leaves() may completely setup the cache leaves and
> -        * shared_cpu_map or it may leave it partially setup.
> +        * If LLC is valid the cache leaves were already populated so just go to
> +        * update the cpu map.
>          */
> -       ret = populate_cache_leaves(cpu);
> -       if (ret)
> -               goto free_ci;
> +       if (!last_level_cache_is_valid(cpu)) {
> +               /*
> +                * populate_cache_leaves() may completely setup the cache leaves and
> +                * shared_cpu_map or it may leave it partially setup.
> +                */
> +               ret = populate_cache_leaves(cpu);
> +               if (ret)
> +                       goto free_ci;
> +       }
> 
>         /*
>          * For systems using DT for cache hierarchy, fw_token

The above looks OK but I would prefer to keep it simple as a fix by just not
adding update_cpu_map label, but I don't have strong opinion about that. So
I am fine either way.

-- 
Regards,
Sudeep
