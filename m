Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65586671FF3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 15:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbjAROnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 09:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbjAROnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 09:43:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DDE4DBD1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 06:34:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0181DB81D6A
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 14:34:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4A43C433D2;
        Wed, 18 Jan 2023 14:34:33 +0000 (UTC)
Date:   Wed, 18 Jan 2023 14:34:30 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Nathan Chancellor <nathan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Subject: Re: [PATCHv3] mm: use stack_depot_early_init for kmemleak
Message-ID: <Y8gDdnpvkCKvVV1t@arm.com>
References: <1674007655-23016-1-git-send-email-zhaoyang.huang@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1674007655-23016-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 10:07:35AM +0800, zhaoyang.huang wrote:
> Mirsad report bellow error which caused by stack_depot_init failed in kvcalloc.
> Solve this by having stackdepot use stack_depot_early_init.
[...]
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

Does this fix still work if kmemleak is default on and no option passed
on the kernel command line? I thought we also need something like:

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 881c3f84e88a..80c69d026890 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -754,6 +754,7 @@ config DEBUG_KMEMLEAK
 	select KALLSYMS
 	select CRC32
 	select STACKDEPOT
+	select STACKDEPOT_ALWAYS_INIT if !DEBUG_KMEMLEAK_DEFAULT_OFF
 	help
 	  Say Y here if you want to enable the memory leak
 	  detector. The memory allocation/freeing is traced in a way

-- 
Catalin
