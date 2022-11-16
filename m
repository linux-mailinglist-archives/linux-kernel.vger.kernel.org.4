Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E84862B3E0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 08:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbiKPH0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 02:26:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiKPH0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 02:26:41 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9C21BA446;
        Tue, 15 Nov 2022 23:26:39 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3ADCB13D5;
        Tue, 15 Nov 2022 23:26:45 -0800 (PST)
Received: from bogus (unknown [10.57.6.137])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E8E913F73B;
        Tue, 15 Nov 2022 23:26:36 -0800 (PST)
Date:   Wed, 16 Nov 2022 07:26:33 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     linux-kernel@vger.kernel.org, Rob.Herring@arm.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH -next] cacheinfo: Remove of_node_put() for fw_token
Message-ID: <20221116072633.igvqiimtx2pzaa37@bogus>
References: <20221115220520.2076189-1-pierre.gondois@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115220520.2076189-1-pierre.gondois@arm.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 11:05:20PM +0100, Pierre Gondois wrote:
> fw_token is used for DT/ACPI systems to identify CPUs sharing caches.
> For DT based systems, fw_token is set to a pointer to a DT node.
> 
> commit ("cacheinfo: Decrement refcount in cache_setup_of_node()")

Commit 3da72e18371c ("cacheinfo: Decrement refcount in cache_setup_of_node()")

> doesn't increment the refcount of fw_token anymore in
> cache_setup_of_node(). fw_token is indeed used as a token and not
> as a (struct device_node*), so no reference to fw_token should be
> kept.
> 
> However, [1] is triggered when hotplugging a CPU multiple times
> since cache_shared_cpu_map_remove() decrements the refcount to
> fw_token at each CPU unplugging, eventually reaching 0.
> 
> Remove of_node_put() for fw_token in cache_shared_cpu_map_remove().
> 
> [1]
> [   53.651182] ------------[ cut here ]------------
> [   53.651186] refcount_t: saturated; leaking memory.
> [   53.651223] WARNING: CPU: 4 PID: 32 at lib/refcount.c:22 refcount_warn_saturate (lib/refcount.c:22 (discriminator 3))
> [   53.651241] Modules linked in:
> [   53.651249] CPU: 4 PID: 32 Comm: cpuhp/4 Tainted: G        W          6.1.0-rc1-14091-g9fdf2ca7b9c8 #76
> [   53.651261] Hardware name: ARM LTD ARM Juno Development Platform/ARM Juno Development Platform, BIOS EDK II Oct 31 2022
> [   53.651268] pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [   53.651279] pc : refcount_warn_saturate (lib/refcount.c:22 (discriminator 3))
> [   53.651293] lr : refcount_warn_saturate (lib/refcount.c:22 (discriminator 3))
> [...]
> [   53.651513] Call trace:
> [...]
> [   53.651735] of_node_release (drivers/of/dynamic.c:335)
> [   53.651750] kobject_put (lib/kobject.c:677 lib/kobject.c:704 ./include/linux/kref.h:65 lib/kobject.c:721)
> [   53.651762] of_node_put (drivers/of/dynamic.c:49)
> [   53.651776] free_cache_attributes.part.0 (drivers/base/cacheinfo.c:712)
> [   53.651792] cacheinfo_cpu_pre_down (drivers/base/cacheinfo.c:718)
> [   53.651807] cpuhp_invoke_callback (kernel/cpu.c:247 (discriminator 4))
> [   53.651819] cpuhp_thread_fun (kernel/cpu.c:785)
> [   53.651832] smpboot_thread_fn (kernel/smpboot.c:164 (discriminator 3))
> [   53.651847] kthread (kernel/kthread.c:376)
> [   53.651858] ret_from_fork (arch/arm64/kernel/entry.S:861)
> [   53.651869] ---[ end trace 0000000000000000 ]---
>

Please remove the timestamp as they add no value to the commit log.
Also it is worth adding IMO:
Fixes: 3da72e18371c ("cacheinfo: Decrement refcount in cache_setup_of_node()")

I did a quick test and so,
Tested-by: Sudeep Holla <sudeep.holla@arm.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

Thanks for fixing the quickly and sorry for not noticing the extra of_node_put
even though I thought if it was just incrementing the refcount earlier.

-- 
Regards,
Sudeep
