Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07CBD62C6E0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 18:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238857AbiKPRw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 12:52:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232855AbiKPRw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 12:52:26 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7429061745
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 09:52:25 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id i9so12145082qki.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 09:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1rQlgFzU2D6ccCofT8yfeItGDtrcH6vIuVi43kZTTr8=;
        b=Rqi9C17fStbxaE75fZDvem3v2dLunYE4NE3tLK28TY10XqKeNf3Xz1E7cNS6OeKABY
         65XciY/3lUHieUdDbDB5CibqglDw7GoDSg59vGUg9ul1GxVmTB/tpic1yFlzTIDUWcvb
         BtKVUF4ZBsYaHfnluSbyDfJ0PASTdJPickmoI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1rQlgFzU2D6ccCofT8yfeItGDtrcH6vIuVi43kZTTr8=;
        b=TJxvrCNhrwsRps3LV1Xsmc3W3YFd/MzmcnpyO59Fm+152j7SicVJPu+JyMMQYzEJFB
         S7ufyZYHqXNlwGTQD8XtX74MCGam/D3l8WhmRc37G1rC7TJrYmuCn74m88SOdr6RKJSh
         WlhlOuEjWr0MAmxzFkLcWK4634U9KePawolHkHBCmcir0YXEncD14ne0DST/tE8s8Zt3
         6kU/WwqN3OCQujrN+jaVHPCE3xbA5F2oHjYi6fruKCDZSuAQ+GBRz9q4fi7Wd+uSRlom
         u/QTQVCfkrfY4yFyg6mwNfjxZyBfCW8ywwG8Wywe0Gf0aNAuBm6hcuOB4NhtXUS0vZQm
         tJLg==
X-Gm-Message-State: ANoB5pkYjSy7ovJYczk/ryALyQUy/ooTkyPKUPkTAi/Mot7EyY9Ckbp5
        g1VqEKNTbTSOQTolcSKS8j59WL0xb8TPBg==
X-Google-Smtp-Source: AA0mqf7LXZVtM/myRqMAeNG/wCicqlDPpxkN834kMZIeRMJfM693mgZsviKZIgue3k/NqcK+c9nuYA==
X-Received: by 2002:a05:620a:1d0d:b0:6f9:c2be:a89 with SMTP id dl13-20020a05620a1d0d00b006f9c2be0a89mr20403028qkb.437.1668621144311;
        Wed, 16 Nov 2022 09:52:24 -0800 (PST)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com. [209.85.160.173])
        by smtp.gmail.com with ESMTPSA id s8-20020a05620a254800b006fa16fe93bbsm10465663qko.15.2022.11.16.09.52.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 09:52:23 -0800 (PST)
Received: by mail-qt1-f173.google.com with SMTP id s4so11179528qtx.6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 09:52:22 -0800 (PST)
X-Received: by 2002:ac8:718a:0:b0:3a5:122:fb79 with SMTP id
 w10-20020ac8718a000000b003a50122fb79mr21752516qto.452.1668621142404; Wed, 16
 Nov 2022 09:52:22 -0800 (PST)
MIME-Version: 1.0
References: <20221109203051.1835763-1-torvalds@linux-foundation.org>
 <20221109203051.1835763-4-torvalds@linux-foundation.org> <CAHk-=wjf+gN25grUT3o3XK8-B-b2jhBuN8YMLQvq-=AXTcuFXg@mail.gmail.com>
 <CAHk-=wiFmm+X92Ghkz_LDG53djReK=idAj0uvSdES+yeG1X=Dw@mail.gmail.com>
 <Y3SVqePHGXRUagyF@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com> <Y3SWTXMotahiqvBO@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
In-Reply-To: <Y3SWTXMotahiqvBO@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 16 Nov 2022 09:52:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh-oBpkN8AKALDkeTcVRzkUqqUyFevCNcCy3F76ogGonA@mail.gmail.com>
Message-ID: <CAHk-=wh-oBpkN8AKALDkeTcVRzkUqqUyFevCNcCy3F76ogGonA@mail.gmail.com>
Subject: Re: mm: mmu_gather: do not define delayed_rmap if not used
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Nadav Amit <nadav.amit@gmail.com>,
        Will Deacon <will@kernel.org>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Nick Piggin <npiggin@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 11:51 PM Alexander Gordeev
<agordeev@linux.ibm.com> wrote:
>
> In cases the delayed rmap removal is not used (which are
> currently UP and s390) skip delayed_rmap flag and make
> the related code paths no-op.

So I'm not convinced about this patch.

I particularly dislike adding even more #ifdef's around the data
structure - it already is pretty nasty, and it was hard to see where
things were initialized.

The only actual code impact of this is in tlb_next_batch(), which
tests for "do I have delayed rmaps pending, in which case I won't add
new batches". Everything else is already either optimized away, or
just "one bit declared in a structure that already has bitfields and
has room for several extra bits":

And that "I need to allocate new batches" case really doesn't matter
anyway - it's not even build at all on s390, and on UP where it's
there but technically pointless to have the test it really isn't
noticeable.

So the previous patch I was "this shouldn't actually _matter_, but it
does seem cleaner to do it this way".

But _this_ patch makes me go "it still doesn't matter, but now this
patch is actually adding extra infrastructure for the 'not-mattering'
case".

So I don't _hate_ this patch, but I think this actually makes the
current mess wrt our 'struct mmu_gather' worse rather than better.

That structure is already a pain, with horrendous initialization and
different bit-fields having different lifetimes. I'd rather have one
unconditional simple bitfield, than have another bitfield that has
conditional complications.

              Linus
