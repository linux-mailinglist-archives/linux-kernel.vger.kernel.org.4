Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA96621C6A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 19:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiKHStM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 13:49:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiKHSsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 13:48:53 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F233A63CCA
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 10:47:05 -0800 (PST)
Date:   Tue, 8 Nov 2022 10:46:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1667933223;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MrIQ3FtzqufFcsoDNlQ77HxkMw/494S1TkLC77QW0G4=;
        b=fIlmEvFdS12JQpFy/wqIzeTn0JvMWY8DPVJ249jAvutTMQSq62UxDK6N6RGKX3LS7gaF2S
        mQ7edI5visOvv6u3ebzbFspS8rHnNZoAxE4JJK+LvHeHF7mHROYFF9s11KEP7Jfptmv0Y0
        +nX/m4lCkg7r9VOAM3ApEy6uioJrEJk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Rustam Kovhaev <rkovhaev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Deprecating and removing SLOB
Message-ID: <Y2qkIrk+a9v7tAQZ@P9FQF9L96D.lan>
References: <b35c3f82-f67b-2103-7d82-7a7ba7521439@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b35c3f82-f67b-2103-7d82-7a7ba7521439@suse.cz>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 04:55:29PM +0100, Vlastimil Babka wrote:
> Hi,
> 
> as we all know, we currently have three slab allocators. As we discussed at
> LPC [1], it is my hope that one of these allocators has a future, and two of
> them do not.
> 
> The unsurprising reasons include code maintenance burden, other features
> compatible with only a subset of allocators (or more effort spent on the
> features), blocking API improvements (more on that below), and my inability
> to pronounce SLAB and SLUB in a properly distinguishable way, without
> resorting to spelling out the letters.
> 
> I think (but may be proven wrong) that SLOB is the easier target of the two
> to be removed, so I'd like to focus on it first.

Great!

SLOB is not supported by the kernel memory accounting code, so if we'll
deprecate SLOB, we can remove all those annoying ifndefs.

But I wonder if we can deprecate SLAB too? Or at least use the moment to
ask every non-SLUB user on why they can't/don't want to use SLUB.
Are there any known advantages of SLAB over SLUB?

Also, for memory-constrained users we might want to add some guide on how
to configure SLUB to minimize the memory footprint.

Thank you!

Roman
