Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 534167497E1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 11:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbjGFJDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 05:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbjGFJDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 05:03:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49521BEF;
        Thu,  6 Jul 2023 02:03:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1366618DF;
        Thu,  6 Jul 2023 09:03:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41383C433C7;
        Thu,  6 Jul 2023 09:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688634198;
        bh=bmwwx7MjhCs2MPk4U/hPy8kwH4tv1b3uF0aXE+oLbb0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rePQVRdZmjcVnVcq1mHjiOroIGXiH3oYyuWThaMD2WQeB71LFBFpa2j4YfrDJPHEC
         h7z0g5Tz87cgyToAwg+w+Bcq1grii82C1d3LMdZcAiQ6yn6Q5Or2w1zzEJkZJrauHz
         Xjw2T+I18zZp47PdFGybzj3x9sDPVUYLHxKRIN7gSUm/CndlzDEPnrAWuHadXl017s
         TObQ3QLjYmNr8URSi17mrIPe9U0zhoPK3fBYb8/f0xANq78axUcRll6xLjwx5OqFVX
         s6IQlHfx+YgT9Y6xFjQD1WEDk4v34iW1bztiwpUAUHDxJFyXOv98Mqh2ukkgNWSh0v
         PCu6aRF4xOLxw==
Date:   Thu, 6 Jul 2023 10:03:10 +0100
From:   Will Deacon <will@kernel.org>
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     Marco Elver <elver@google.com>, andrey.konovalov@linux.dev,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Feng Tang <feng.tang@intel.com>, stable@vger.kernel.org,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH] kasan, slub: fix HW_TAGS zeroing with slub_debug
Message-ID: <20230706090309.GA29243@willie-the-truck>
References: <678ac92ab790dba9198f9ca14f405651b97c8502.1688561016.git.andreyknvl@google.com>
 <CANpmjNO+spktteYZezk7PGLFOyoeuFyziKiU-1GXbpeyKLZLPg@mail.gmail.com>
 <CA+fCnZenzRuxS4qjzFiYm05zNxHBSAkTUK7-1zixXXDUQb3g3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+fCnZenzRuxS4qjzFiYm05zNxHBSAkTUK7-1zixXXDUQb3g3w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2023 at 03:19:06PM +0200, Andrey Konovalov wrote:
> On Wed, Jul 5, 2023 at 2:51 PM Marco Elver <elver@google.com> wrote:
> >
> > On Wed, 5 Jul 2023 at 14:44, <andrey.konovalov@linux.dev> wrote:
> > >
> > > From: Andrey Konovalov <andreyknvl@google.com>
> > >
> > > Commit 946fa0dbf2d8 ("mm/slub: extend redzone check to extra allocated
> > > kmalloc space than requested") added precise kmalloc redzone poisoning
> > > to the slub_debug functionality.
> > >
> > > However, this commit didn't account for HW_TAGS KASAN fully initializing
> > > the object via its built-in memory initialization feature. Even though
> > > HW_TAGS KASAN memory initialization contains special memory initialization
> > > handling for when slub_debug is enabled, it does not account for in-object
> > > slub_debug redzones. As a result, HW_TAGS KASAN can overwrite these
> > > redzones and cause false-positive slub_debug reports.
> > >
> > > To fix the issue, avoid HW_TAGS KASAN memory initialization when slub_debug
> > > is enabled altogether. Implement this by moving the __slub_debug_enabled
> > > check to slab_post_alloc_hook. Common slab code seems like a more
> > > appropriate place for a slub_debug check anyway.
> > >
> > > Fixes: 946fa0dbf2d8 ("mm/slub: extend redzone check to extra allocated kmalloc space than requested")
> > > Cc: <stable@vger.kernel.org>
> > > Reported-by: Mark Rutland <mark.rutland@arm.com>
> >
> > Is it fixing this issue:
> >
> >   https://lore.kernel.org/all/20230628154714.GB22090@willie-the-truck/
> 
> Yes, my bad, messed up the Reported-by tag. The correct one should be:
> 
> Reported-by: Will Deacon <will@kernel.org>
> 
> > Other than the question above, it looks sane:
> >
> > Acked-by: Marco Elver <elver@google.com>
> 
> Thank you, Marco!

Cheers, this seems to fix the splats for me:

Tested-by: Will Deacon <will@kernel.org>

Will
