Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85DAC6CA23A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 13:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbjC0LQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 07:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232349AbjC0LQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 07:16:03 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B0FC5423C
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 04:16:02 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6DEF84B3;
        Mon, 27 Mar 2023 04:16:46 -0700 (PDT)
Received: from bogus (unknown [10.57.52.160])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BD7933F663;
        Mon, 27 Mar 2023 04:16:00 -0700 (PDT)
Date:   Mon, 27 Mar 2023 12:15:27 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Yicong Yang <yangyicong@huawei.com>
Cc:     Pierre Gondois <pierre.gondois@arm.com>, yangyicong@hisilicon.com,
        Sudeep Holla <sudeep.holla@arm.com>,
        gregkh@linuxfoundation.org, rafael@kernel.org, palmer@rivosinc.com,
        linux-kernel@vger.kernel.org, prime.zeng@hisilicon.com,
        linuxarm@huawei.com
Subject: Re: [PATCH] cacheinfo: Fix LLC is not exported through sysfs
Message-ID: <20230327111527.h46wdd3jva4npksy@bogus>
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

I was thinking of something like below.

--
Regards,
Sudeep

diff --git i/arch/arm64/kernel/cacheinfo.c w/arch/arm64/kernel/cacheinfo.c
index c307f69e9b55..4ef1033fe47e 100644
--- i/arch/arm64/kernel/cacheinfo.c
+++ w/arch/arm64/kernel/cacheinfo.c
@@ -79,12 +79,16 @@ int init_cache_level(unsigned int cpu)

 int populate_cache_leaves(unsigned int cpu)
 {
-       unsigned int level, idx;
+       unsigned int hw_lvl, level, idx;
        enum cache_type type;
        struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
        struct cacheinfo *this_leaf = this_cpu_ci->info_list;

-       for (idx = 0, level = 1; level <= this_cpu_ci->num_levels &&
+       for (hw_lvl = 0; hw_lvl <= MAX_CACHE_LEVEL; hw_lvl++)
+               if (CACHE_TYPE_NOCACHE == get_cache_type(hw_lvl + 1))
+                       break;
+
+       for (idx = 0, level = 1; level <= hw_lvl &&
             idx < this_cpu_ci->num_leaves; idx++, level++) {
                type = get_cache_type(level);
                if (type == CACHE_TYPE_SEPARATE) {
