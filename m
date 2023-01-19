Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 727CA67467F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 23:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjASW6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 17:58:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjASW5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 17:57:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04C621A1E
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 14:42:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8DF0B61D94
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 22:42:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 983C3C433F0;
        Thu, 19 Jan 2023 22:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1674168125;
        bh=H9toCFN/mRX7/kvCHEF4NqPLWqqxgNLXk0255cj541U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1KV80hcpZAV1gzmTxGhDr/HNE4i1q4e6K+KrS+ZQ3aCNZ3Nd9S9x/HEZFMmse1r3X
         qNhS8yXZH7B032GI/Ift0yqauxHssIHvDDatp277PeUDqjcWox9AupR9+qNcBc/Dta
         C9dE6pqE2n1k/NDn8ICALv63/2OsfmHkt7llgzc0=
Date:   Thu, 19 Jan 2023 14:42:04 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Subject: Re: [PATCHv4 2/2] mm: use stack_depot_early_init for kmemleak
Message-Id: <20230119144204.a5a67be85544cd29cd656a5b@linux-foundation.org>
In-Reply-To: <6e9e406a-8a94-4e34-9e5e-f4bb3a321b4e@suse.cz>
References: <1674091345-14799-1-git-send-email-zhaoyang.huang@unisoc.com>
        <1674091345-14799-2-git-send-email-zhaoyang.huang@unisoc.com>
        <6e9e406a-8a94-4e34-9e5e-f4bb3a321b4e@suse.cz>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Jan 2023 11:32:36 +0100 Vlastimil Babka <vbabka@suse.cz> wrote:

> But to be cleaner I'd also suggest Andrew adds the hunk below. The call
> to stack_depot_init() becomes no-op after this patch so it's not a bug
> to leave it there, but it's just misleading now.
> 
> ---8<---
> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> index 91dda5c2753a..55dc8b8b0616 100644
> --- a/mm/kmemleak.c
> +++ b/mm/kmemleak.c
> @@ -2095,7 +2095,6 @@ void __init kmemleak_init(void)
>  	if (kmemleak_error)
>  		return;
>  
> -	stack_depot_init();
>  	jiffies_min_age = msecs_to_jiffies(MSECS_MIN_AGE);
>  	jiffies_scan_wait = msecs_to_jiffies(SECS_SCAN_WAIT * 1000);
>  

I added your signoff to this.

I used not to bother for such minor to-be-folded fixups, but now
Stephen sends me automated nags when his scripts detect this.
