Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A7B6E940C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 14:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234798AbjDTMQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 08:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234127AbjDTMQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 08:16:00 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0195BA0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 05:15:57 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2171E1EC054E;
        Thu, 20 Apr 2023 14:15:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1681992956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=TZ8Jnkwcs5YEyxZFgiUImVOTqo76esyKbsRkEFFO11o=;
        b=LS/v7KbfMbuhPx6pL7s2/uDf3KJDpy+6s13YeYAgog0FK/TSB0/11swgM7Op2wENUs90do
        UtUvw7BhUIbIWq/4BhpUpXJcoXLtoxcFIOTkar6jQ4AFfdP1vPJpOOBeW1hnVP/tcrVWjt
        +MsiTkzX4OP92neg7zq1FhOcopmr0sU=
Date:   Thu, 20 Apr 2023 14:15:51 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH v5 11/15] x86/mtrr: construct a memory map with cache
 modes
Message-ID: <20230420121551.GMZEEs9wkUrvX05nQr@fat_crate.local>
References: <20230401063652.23522-1-jgross@suse.com>
 <20230401063652.23522-12-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230401063652.23522-12-jgross@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 01, 2023 at 08:36:48AM +0200, Juergen Gross wrote:
> +static void rm_map_entry_at(int idx)
> +{
> +	cache_map_n--;

Let's not call memmove() when cache_map_n == idx.

Below too.

Especially since cache_map + idx + 1 is not valid and I wouldn't want it
getting prefetched from %rsi in the hw when there's no reason for it and
also the RET even from a function which doesn't do anything, costs.

> +	memmove(cache_map + idx, cache_map + idx + 1,
> +		sizeof(*cache_map) * (cache_map_n - idx));
> +}

Ok, first weird issue I encountered while playing with my carved out
program to exercise this cache_map handling thing. I can share it if you
want it - it is ugly but it works.

So while rebuilding the map, I have these current regions in the map, at
one point in time:

Current map:
0: start: 0x0000000000000000, end: 0x0000000000100000, type: 0x0
1: start: 0x0000000100000000, end: 0x0000000820000000, type: 0x6
2: start: 0x000002f10000c000, end: 0x000003bf0000c000, type: 0x2
3: start: 0x000003bf0000c000, end: 0x00000d4b0000c000, type: 0x1
4: start: 0x00000d4b0000c000, end: 0x00019fc000001000, type: 0x0
5: start: 0x00019fc000001000, end: 0x0001df2d00001000, type: 0x2

note entry #3.

Now the next one it inserts is:

add_map_entry_at: start: 0x3bf0000c000, end: 0xd4b0000c000, type: 0x0, idx: 3
 merge_prev 0: prev->fixed: 0, prev->end: 0x3bf0000c000, prev->type: 0x2
 merge_next: 1, next->fixed: 0, next->start: 0xd4b0000c000, next->type: 0x0
add_map_entry_at: ret: 1

Note how it is the same as entry number #3 - just a different type.

What it ends up doing is, it simply overwrites the previous one and
merges it with the next:

Current map:
0: start: 0x0000000000000000, end: 0x0000000000100000, type: 0x0
1: start: 0x0000000100000000, end: 0x0000000820000000, type: 0x6
2: start: 0x000002f10000c000, end: 0x000003bf0000c000, type: 0x2
3: start: 0x000003bf0000c000, end: 0x00019fc000001000, type: 0x0
4: start: 0x00019fc000001000, end: 0x0001df2d00001000, type: 0x2

Now I think right about now we should've screamed loudly.

I know I know, this should never happen, right? And firmware programming
those MTRRs doesn't make mistakes...

However, we should be loud here and scream when a MTRR range disappears
like that.

Right?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
