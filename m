Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C001962C6A8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 18:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbiKPRpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 12:45:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233464AbiKPRpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 12:45:25 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B0E5E9D7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 09:45:24 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id i9so12129428qki.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 09:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5GiK3SgiI9CKL6CbV/SHRk4GJHwDooVfogzt8LPWN3o=;
        b=TqeYel93n9lNXLImI0rYMMKitTxHGoo/8D+RKHflcgvzNACmHDu6Eb9di/e7V/YbE8
         JSJRp318JWElgMvnZtF2Sfh/DzdgvepAY2rDh1s1dTzV9kR37AskjrOctkn0OTHyoRkt
         uA55JflOEh28Mq/hdA83+W+8Zqe5ZMbDkRHAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5GiK3SgiI9CKL6CbV/SHRk4GJHwDooVfogzt8LPWN3o=;
        b=tHJBzniv6zcRRutwrXabHyiRdKv6+tr7v4/c7BfblZ7QTqzezBeTWrgan2zaS8G4H2
         H5dE5d3eH3Q9QgyzWB7DFDO9ocy5DemBbrzZb3zqOKBBhv7BW4zxC1r1ERkEFzHtNA0u
         AEA6N9wDHIdVFLNMDT+Ov3/qdvtv50cfhY4XcRYkRO63dLsV6xwWr8lgLQgEfG+5IpJd
         waRAoBgT12HHfruAYe+9dNZqSnjoBBthtmqJuzHYTops+7Dgse3Pti+ZtaaxvWrlKuS8
         nYYP/W0i0cM6O7Y+B+dSw7K7bIHSPD1/e5+KbzcHrwnqPsxRAFu26GVTUcwZ/GkFpa5F
         mxFg==
X-Gm-Message-State: ANoB5pn3ctxyj6Bn5Ichyb0MI/GfD9c+IfzCV9Wc46qnnu2lP+YgQuJ7
        vLKXb9kSR+PsdMZHNJwqiR9IBC17/iXB5A==
X-Google-Smtp-Source: AA0mqf6XApqiKYnkkH33cVGkaDXrcd5p3941RLtOKVqHNunaDKa1C23JcNZE4fBLGoAKYFgSQnd4Nw==
X-Received: by 2002:a05:620a:1a23:b0:6fa:b73:812e with SMTP id bk35-20020a05620a1a2300b006fa0b73812emr20412314qkb.433.1668620723400;
        Wed, 16 Nov 2022 09:45:23 -0800 (PST)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com. [209.85.160.174])
        by smtp.gmail.com with ESMTPSA id c22-20020ac87dd6000000b003a55fe9f352sm9164461qte.64.2022.11.16.09.45.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 09:45:21 -0800 (PST)
Received: by mail-qt1-f174.google.com with SMTP id w9so1327207qtv.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 09:45:20 -0800 (PST)
X-Received: by 2002:a05:622a:22a7:b0:3a5:1ba7:717d with SMTP id
 ay39-20020a05622a22a700b003a51ba7717dmr21964368qtb.678.1668620720230; Wed, 16
 Nov 2022 09:45:20 -0800 (PST)
MIME-Version: 1.0
References: <20221109203051.1835763-1-torvalds@linux-foundation.org>
 <20221109203051.1835763-4-torvalds@linux-foundation.org> <CAHk-=wjf+gN25grUT3o3XK8-B-b2jhBuN8YMLQvq-=AXTcuFXg@mail.gmail.com>
 <CAHk-=wiFmm+X92Ghkz_LDG53djReK=idAj0uvSdES+yeG1X=Dw@mail.gmail.com>
 <Y3SVqePHGXRUagyF@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com> <Y3SWCu6NRaMQ5dbD@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
In-Reply-To: <Y3SWCu6NRaMQ5dbD@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 16 Nov 2022 09:45:04 -0800
X-Gmail-Original-Message-ID: <CAHk-=win6sosEYKi1HcmEFDVH8S4cWntb1RH1z_=Tbkk45ZTLA@mail.gmail.com>
Message-ID: <CAHk-=win6sosEYKi1HcmEFDVH8S4cWntb1RH1z_=Tbkk45ZTLA@mail.gmail.com>
Subject: Re: mm: mmu_gather: do not expose delayed_rmap flag
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

On Tue, Nov 15, 2022 at 11:49 PM Alexander Gordeev
<agordeev@linux.ibm.com> wrote:
>
> Flag delayed_rmap of 'struct mmu_gather' is rather
> a private member, but it is still accessed directly.
> Instead, let the TLB gather code access the flag.

Now, I set it up so that if you don't use delayed_rmap, the
tlb_flush_rmaps() function ends up being an empty inline function, and
as such the compiler should already have done this for you - including
optimizing out the test that then doesn't even matter.

But this patch shouldn't *matter*, but it also isn't wrong, so..

Acked-by: Linus Torvalds <torvalds@linux-foundation.org>

Thanks,

                    Linus
