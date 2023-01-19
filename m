Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C46C674C35
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 06:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbjATF0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 00:26:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbjATF0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 00:26:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BDF7E498
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 21:18:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1EB25B82149
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 10:03:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F14A5C433EF;
        Thu, 19 Jan 2023 10:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674122629;
        bh=ma+Mar42lsl3yZ7nWZfqFtFMlViQb4qX34+6FZ69xPE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GxSyjf7n8S91C06majQMmhfVTKjvLge5Mf1Y5KNMQwSY/A80bYFdE7Sam8WnCDSiZ
         8Qzainugf/7yUmfrAaEIGjmoPZ2IyJw6Xb+ye9IwLTFi6BqPrWHQRAV1cfaMDwMITl
         vfCkhsgBic3AqUVcG1OSi5iDyGwGXD1SCRze20s2+WejbvougaUWyLLvKk+/8CCuPX
         PQtT2jpOhwlH2rCty5tjPHGUqpt0yupa/1XinV99xOUnsjCUYPEz8OU1sJnZJzozYM
         /Z/tiJs9VfrXs7JZQnuhhKaje+sqGlnAh5AtpEUpbH2EGRrjcGbIt/JP1dand5nJZW
         1O0jt6/g6HdFQ==
Date:   Thu, 19 Jan 2023 12:03:38 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Nathan Chancellor <nathan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Subject: Re: [PATCHv4 2/2] mm: use stack_depot_early_init for kmemleak
Message-ID: <Y8kVel5ErvDeYLbq@kernel.org>
References: <1674091345-14799-1-git-send-email-zhaoyang.huang@unisoc.com>
 <1674091345-14799-2-git-send-email-zhaoyang.huang@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1674091345-14799-2-git-send-email-zhaoyang.huang@unisoc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 09:22:25AM +0800, zhaoyang.huang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> Mirsad report bellow error which caused by stack_depot_init failed in kvcalloc.
> Solve this by having stackdepot use stack_depot_early_init.
> 
> On 1/4/23 17:08, Mirsad Goran Todorovac wrote:
> I hate to bring bad news again, but there seems to be a problem with the output of /sys/kernel/debug/kmemleak:
> 
> [root@pc-mtodorov ~]# cat /sys/kernel/debug/kmemleak
> unreferenced object 0xffff951c118568b0 (size 16):
> comm "kworker/u12:2", pid 56, jiffies 4294893952 (age 4356.548s)
> hex dump (first 16 bytes):
>     6d 65 6d 73 74 69 63 6b 30 00 00 00 00 00 00 00 memstick0.......
>     backtrace:
> [root@pc-mtodorov ~]#
> 
> Apparently, backtrace of called functions on the stack is no longer printed with the list of memory leaks.
> This appeared on Lenovo desktop 10TX000VCR, with AlmaLinux 8.7 and BIOS version M22KT49A (11/10/2022)
> and 6.2-rc1 and 6.2-rc2 builds.
> This worked on 6.1 with the same CONFIG_KMEMLEAK=y and MGLRU enabled on a vanilla mainstream kernel
> from Mr. Torvalds' tree. I don't know if this is deliberate feature for some reason or a bug.
> Please find attached the config, lshw and kmemleak output.
> 
> reported-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
> suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
> v2: use stack_depot_want_early_init instead of CONFIG_STACKDEPOT_ALWAYS_INIT
> v3: have the Kconfig changes commited in another patch
> v4: select CONFIG_STACKDEPOT_ALWAYS_INIT when DEBUG_KMEMLEAK_DEFAULT_OFF is off
> ---
> 
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
>  mm/Kconfig.debug | 1 +
>  mm/kmemleak.c    | 4 +++-
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
> index d1893ac..466a37e 100644
> --- a/mm/Kconfig.debug
> +++ b/mm/Kconfig.debug
> @@ -219,6 +219,7 @@ config DEBUG_KMEMLEAK
>  	select KALLSYMS
>  	select CRC32
>  	select STACKDEPOT
> +	select STACKDEPOT_ALWAYS_INIT if !DEBUG_KMEMLEAK_DEFAULT_OFF
>  	help
>  	  Say Y here if you want to enable the memory leak
>  	  detector. The memory allocation/freeing is traced in a way
> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> index 762b91f..ddc1ddf 100644
> --- a/mm/kmemleak.c
> +++ b/mm/kmemleak.c
> @@ -2070,8 +2070,10 @@ static int __init kmemleak_boot_config(char *str)
>  		return -EINVAL;
>  	if (strcmp(str, "off") == 0)
>  		kmemleak_disable();
> -	else if (strcmp(str, "on") == 0)
> +	else if (strcmp(str, "on") == 0) {
>  		kmemleak_skip_disable = 1;
> +		stack_depot_want_early_init();
> +	}
>  	else
>  		return -EINVAL;
>  	return 0;
> -- 
> 1.9.1
> 
> 

-- 
Sincerely yours,
Mike.
