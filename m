Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4993632DD4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 21:19:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbiKUUTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 15:19:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbiKUUTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 15:19:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0784D1C3A
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 12:19:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9354961453
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 20:19:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73380C433D6;
        Mon, 21 Nov 2022 20:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1669061980;
        bh=Zi9Lx3c8aWMW4JxLDifOxiaYeP264p6EDgyqQzLFIuA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1CV3abAGw5xIsnLjgX6OP4B1P2vPYSLncEQJ9gPbUxXSPzBmhFXg8bo++WIxTft57
         nEMFfIQXC7IudzLEeZPcyixYa128aLDX1dj/ghFaqAoNisEdFqM6ZUL32eIRd7JRNc
         IQ53Rv0/3SiWR5ki5+gXfesnTovCvZGa1tP6NW7g=
Date:   Mon, 21 Nov 2022 12:19:38 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-mm@kvack.org, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next 1/2] mm/slab: add is_kmalloc_cache() helper macro
Message-Id: <20221121121938.1f202880ffe6bb18160ef785@linux-foundation.org>
In-Reply-To: <20221121135024.1655240-1-feng.tang@intel.com>
References: <20221121135024.1655240-1-feng.tang@intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Nov 2022 21:50:23 +0800 Feng Tang <feng.tang@intel.com> wrote:

> +#ifndef CONFIG_SLOB
> +#define is_kmalloc_cache(s) ((s)->flags & SLAB_KMALLOC)
> +#else
> +#define is_kmalloc_cache(s) (false)
> +#endif

Could be implemented as a static inline C function, yes?

If so, that's always best.  For (silly) example, consider the behaviour
of

	x = is_kmalloc_cache(s++);

with and without CONFIG_SLOB.
