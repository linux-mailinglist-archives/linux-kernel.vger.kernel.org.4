Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F13C67C9AF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 12:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236849AbjAZLVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 06:21:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233130AbjAZLVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 06:21:20 -0500
Received: from gentwo.de (gentwo.de [161.97.139.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B2C9013
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 03:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.de; s=default;
        t=1674732074; bh=9OAbb+6Iby7ioZj2GSSudmr2Eanm/bGeive3un3bnO8=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=HpMrgwHjh/rRJnbGwExJkLnSMk1A3L9738oqNYw4K/Jzj2CeLC+ZtJ8f1G568ZN3a
         dQRbzbetlbHFUH+BpqI3NC2eGyzIqNY8rBj5fj3WwOqz7ZUm39lesHTDjYJ/v8issc
         iXttVG0uDOIxcVIEfDAk3nGHoeIIiWFI8iO3WaVqJ2pgjnViCIXwD+qEdRajU/fZ9f
         QXTQXng2LxWW8vWcNhDke+z+006jV+GW/nhBXT6n00K39TbRSxlhQ3g47fOns2erXC
         pvEfaUe9OuKw4+QFbrBhVazSTqQJt0Ycqbu1tC7Cclv8QzpQIBBRaOoFrIiieI5+vO
         NkCo3wy+Hjzhg==
Received: by gentwo.de (Postfix, from userid 1001)
        id A067FB0028E; Thu, 26 Jan 2023 12:21:14 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id 9B095B00137;
        Thu, 26 Jan 2023 12:21:14 +0100 (CET)
Date:   Thu, 26 Jan 2023 12:21:14 +0100 (CET)
From:   Christoph Lameter <cl@gentwo.de>
To:     George Prekas <george@enfabrica.net>
cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Andrei Vagin <avagin@gmail.com>
Subject: Re: [PATCH 9/9] mm: kmemleak: fix undetected leaks for page aligned
 objects
In-Reply-To: <20230123170419.7292-10-george@enfabrica.net>
Message-ID: <b081dce4-46a7-c3df-30dc-e064f2515a@gentwo.de>
References: <20230123170419.7292-1-george@enfabrica.net> <20230123170419.7292-10-george@enfabrica.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jan 2023, George Prekas wrote:

> If kmalloc returns a page aligned object, then the object has 2
> references: the pointer returned by kmalloc and page->s_mem of the first
> page of the object. Account for this extra reference, so that kmemleak
> can correctly detect leaks for page aligned objects.

s_mem is a reference to the array of slab objects in a SLAB page. It is
not referring to a particular object. s_mem allows access to the Nth
object in a slab page.

See the function index_to_obj() in slab.c



static inline void  *index_to_obj(struct kmem_cache *cache,
                                 const struct slab *slab, unsigned int idx)
{

        return slab->s_mem + cache->size * idx;
}
