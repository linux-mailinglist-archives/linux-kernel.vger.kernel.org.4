Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E0E6CBFA1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 14:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbjC1MsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 08:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232902AbjC1MsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 08:48:04 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 12A219767
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 05:47:49 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B9C5AC14;
        Tue, 28 Mar 2023 05:48:09 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 322743F73F;
        Tue, 28 Mar 2023 05:47:24 -0700 (PDT)
Date:   Tue, 28 Mar 2023 13:47:21 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Yicong Yang <yangyicong@huawei.com>, gregkh@linuxfoundation.org
Cc:     rafael@kernel.org, pierre.gondois@arm.com,
        Sudeep Holla <sudeep.holla@arm.com>, palmer@rivosinc.com,
        linux-kernel@vger.kernel.org, prime.zeng@hisilicon.com,
        linuxarm@huawei.com, yangyicong@hisilicon.com
Subject: Re: [PATCH v2] cacheinfo: Fix LLC is not exported through sysfs
Message-ID: <20230328124721.f65amn4v5qmdg64g@bogus>
References: <20230328114915.33340-1-yangyicong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328114915.33340-1-yangyicong@huawei.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 07:49:15PM +0800, Yicong Yang wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> After entering 6.3-rc1 the LLC cacheinfo is not exported on our ACPI

I would have preferred the commit causing the issue as you know and have
it in the fixes tag, but info is there so I don't think it is worth another
version churn. Sorry my bad for missing it earlier.

> based arm64 server. This is because the LLC cacheinfo is partly reset
> when secondary CPUs boot up. On arm64 the primary cpu will allocate
> and setup cacheinfo:
> init_cpu_topology()
>   for_each_possible_cpu()
>     fetch_cache_info() // Allocate cacheinfo and init levels
> detect_cache_attributes()
>   cache_shared_cpu_map_setup()
>     if (!last_level_cache_is_valid()) // not valid, setup LLC
>       cache_setup_properties() // setup LLC
> 
> On secondary CPU boot up:
> detect_cache_attributes()
>   populate_cache_leaves()
>     get_cache_type() // Get cache type from clidr_el1,
>                      // for LLC type=CACHE_TYPE_NOCACHE
>   cache_shared_cpu_map_setup()
>     if (!last_level_cache_is_valid()) // Valid and won't go to this branch,
>                                       // leave LLC's type=CACHE_TYPE_NOCACHE
> 
> The last_level_cache_is_valid() use cacheinfo->{attributes, fw_token} to
> test it's valid or not, but populate_cache_leaves() will only reset
> LLC's type, so we won't try to re-setup LLC's type and leave it
> CACHE_TYPE_NOCACHE and won't export it through sysfs.
> 
> This patch tries to fix this by not re-populating the cache leaves if
> the LLC is valid.
>

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

Hi Greg,

Can you pick this up in your next round of fixes for v6.3 please ?

--
Regards,
Sudeep
