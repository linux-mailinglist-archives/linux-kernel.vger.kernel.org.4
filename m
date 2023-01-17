Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2DD66D6E8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 08:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233386AbjAQH2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 02:28:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235491AbjAQH2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 02:28:35 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E95C22A38
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 23:28:34 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D5EF63801F;
        Tue, 17 Jan 2023 07:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673940512; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U0mBcioZaX4vf05VyQP2/c5bzQDfLI3vqPDrd98/xE0=;
        b=cBRdVAWVauQu+ma+pgmWpgKDB50C9YxN56HyyUV0BBuyMKCSqojnRukr37eDN3yJDHvGaX
        VJl6+ahzBgsCkWdrogKfhBI0fruoc1jF+dA0xMzHgb46D8X6T7eV57VvyhBuwz9q5tJxsB
        I/Cu6JY9A5RAPAYLGUAco86zLWP7DxI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673940512;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U0mBcioZaX4vf05VyQP2/c5bzQDfLI3vqPDrd98/xE0=;
        b=eCovFWZWudSp4fISHCKSx8qMutH78yK8Aa3TCOvwL/0QLa+INl8y8Q1GaGnVA+nJymMCDX
        n+CAx46zc0hs0dCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ACE6C13357;
        Tue, 17 Jan 2023 07:28:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NkwSKSBOxmN8NQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 17 Jan 2023 07:28:32 +0000
Message-ID: <7506d259-1e07-eb74-332b-c0a9064a4a1b@suse.cz>
Date:   Tue, 17 Jan 2023 08:28:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] mm: use stack_depot_early_init for kmemleak
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Borislav Petkov <bp@alien8.de>
References: <1673935169-30019-1-git-send-email-zhaoyang.huang@unisoc.com>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <1673935169-30019-1-git-send-email-zhaoyang.huang@unisoc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/23 06:59, zhaoyang.huang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> Mirsad report bellow error which caused by stack_depot_init failed in kvcalloc.
> Solve this by having stackdepot use stack_depot_early_init.

This is not ideal because kmemleak can be configured so that it's only
enabled on boot with kmemleak=on and not always.
Please look into stack_depot_want_early_init() as suggested:
https://lore.kernel.org/all/f53653bd-aab1-637e-c034-62761f262a03@suse.cz/

> On 1/4/23 17:08, Mirsad Goran Todorovac wrote:
> I hate to bring bad news again, but there seems to be a problem with the output of /sys/kernel/debug/kmemleak:
> 
> [root@pc-mtodorov ~]# cat /sys/kernel/debug/kmemleak
> unreferenced object 0xffff951c118568b0 (size 16):
> comm "kworker/u12:2", pid 56, jiffies 4294893952 (age 4356.548s)
>     hex dump (first 16 bytes):
>       6d 65 6d 73 74 69 63 6b 30 00 00 00 00 00 00 00 memstick0.......
>     backtrace:
>  [root@pc-mtodorov ~]#
>    Apparently, backtrace of called functions on the stack is no longer printed with the list of memory leaks.
>  This appeared on Lenovo desktop 10TX000VCR, with AlmaLinux 8.7 and BIOS version M22KT49A (11/10/2022)
>  and 6.2-rc1 and 6.2-rc2 builds.
>  This worked on 6.1 with the same CONFIG_KMEMLEAK=y and MGLRU enabled on a vanilla mainstream kernel
>  from Mr. Torvalds' tree. I don't know if this is deliberate feature for some reason or a bug.
>  Please find attached the config, lshw and kmemleak output.
> 
> reported-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
>  lib/Kconfig.debug | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 401ad4b..50cc9f5 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -727,6 +727,7 @@ config DEBUG_KMEMLEAK
>  	select KALLSYMS
>  	select CRC32
>  	select STACKDEPOT
> +	select STACKDEPOT_ALWAYS_INIT
>  	help
>  	  Say Y here if you want to enable the memory leak
>  	  detector. The memory allocation/freeing is traced in a way

