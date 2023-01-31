Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA65C683874
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 22:14:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbjAaVON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 16:14:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbjAaVOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 16:14:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379BA47408
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 13:14:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC3B461711
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 21:14:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA18FC433EF;
        Tue, 31 Jan 2023 21:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1675199649;
        bh=U6wsVUmsmxWrp6Ky3+Emxba7PMvSFL11l7NlSfpF6N4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=i+eNCGEGJlXeSZ9fNAjQ6sx9GTx1CbjaGju/Lz3FLdukpacSy/wSs4Ji1oiaEBHZu
         QFbw28Bp+O+MqFxekxTKNNs8U64vPSFbcKbPmk1zWavqtWZTfiI2nv+MRyf61dckus
         n1YCHygo1GSUHPnNYn1gE4upjXjOMJYCvrx7hSYQ=
Date:   Tue, 31 Jan 2023 13:14:08 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     Marco Elver <elver@google.com>, andrey.konovalov@linux.dev,
        Alexander Potapenko <glider@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH 16/18] lib/stackdepot: annotate racy slab_index accesses
Message-Id: <20230131131408.ceea0a762d45bf94c1387367@linux-foundation.org>
In-Reply-To: <CA+fCnZdwuAm-fD-o2Yq86=NgU=YympuwAmERN9KwjpYfkPeYLg@mail.gmail.com>
References: <cover.1675111415.git.andreyknvl@google.com>
        <19512bb03eed27ced5abeb5bd03f9a8381742cb1.1675111415.git.andreyknvl@google.com>
        <CANpmjNNzNSDrxfrZUcRtt7=hV=Mz8_kyCpqVnyAqzhaiyipXCg@mail.gmail.com>
        <CA+fCnZdwuAm-fD-o2Yq86=NgU=YympuwAmERN9KwjpYfkPeYLg@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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

On Tue, 31 Jan 2023 19:57:58 +0100 Andrey Konovalov <andreyknvl@gmail.com> wrote:

> On Tue, Jan 31, 2023 at 9:41 AM Marco Elver <elver@google.com> wrote:
> >
> > > diff --git a/lib/stackdepot.c b/lib/stackdepot.c
> > > index f291ad6a4e72..cc2fe8563af4 100644
> > > --- a/lib/stackdepot.c
> > > +++ b/lib/stackdepot.c
> > > @@ -269,8 +269,11 @@ depot_alloc_stack(unsigned long *entries, int size, u32 hash, void **prealloc)
> > >                         return NULL;
> > >                 }
> > >
> > > -               /* Move on to the next slab. */
> > > -               slab_index++;
> > > +               /*
> > > +                * Move on to the next slab.
> > > +                * WRITE_ONCE annotates a race with stack_depot_fetch.
> >
> > "Pairs with potential concurrent read in stack_depot_fetch()." would be clearer.
> >
> > I wouldn't say WRITE_ONCE annotates a race (race = involves 2+
> > accesses, but here's just 1), it just marks this access here which
> > itself is paired with the potential racing read in the other function.
> 
> Will do in v2. Thanks!

Please let's not redo an 18-patch series for a single line comment
change.  If there are more substantial changes then OK.

I queued this as a to-be-squashed fixup against "/stackdepot: annotate
racy slab_index accesses":


From: Andrew Morton <akpm@linux-foundation.org>
Subject: lib-stackdepot-annotate-racy-slab_index-accesses-fix
Date: Tue Jan 31 01:10:50 PM PST 2023

enhance comment, per Marco

Cc: Alexander Potapenko <glider@google.com>
Cc: Andrey Konovalov <andreyknvl@google.com>
Cc: Evgenii Stepanov <eugenis@google.com>
Cc: Marco Elver <elver@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 lib/stackdepot.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/lib/stackdepot.c~lib-stackdepot-annotate-racy-slab_index-accesses-fix
+++ a/lib/stackdepot.c
@@ -271,7 +271,8 @@ depot_alloc_stack(unsigned long *entries
 
 		/*
 		 * Move on to the next slab.
-		 * WRITE_ONCE annotates a race with stack_depot_fetch.
+		 * WRITE_ONCE pairs with potential concurrent read in
+		 * stack_depot_fetch().
 		 */
 		WRITE_ONCE(slab_index, slab_index + 1);
 		slab_offset = 0;
_


