Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE1162338E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 20:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbiKITcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 14:32:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbiKITbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 14:31:53 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CC32CE03
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 11:31:10 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id x18so11585254qki.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 11:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eeGIPpDgArzFfYgFEOrNZo7weULW88kk3fiLdCyU0sU=;
        b=SREN01gokrPFFrgd8zT1O5gnWpXiNF0MDh2jOSS1ihhfL9Hr8Hy0x3Y+liF+HNmzjh
         aA1Y2TRFLYd9dien0puJNUAHK6+oB5axp+/obLVsDh+IUAWwrZxlUpGePLz5+00rmTbN
         u82a6RHngd1BxT5rW7Yc6J+7M0dGRTMTTsPQPFhknuNjhdl+nAkkG+w8pP3kIOn2/u84
         mYP/dec6mirOqpQ66gVy/I7EnUXsZswkmIf/XrGv/qYDPvQUKQpGBQv9cbc9O84LePbb
         TSM2JLCXF3uv0ovmA7DW5M8P6F4FKSnB19U7a/9s492g0xDWON3EwmLJwjtF/NhM07Ao
         +QeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eeGIPpDgArzFfYgFEOrNZo7weULW88kk3fiLdCyU0sU=;
        b=N0d+E2EErB1/fx9h68+6AFl6tnxKOHjUhg/+y65qL+DfyAopxmGpmkXssOgnzlFxFc
         JdYpb7t6cA8Xu5H+0fDCcjGiniL3n88tcDHT4xTfDuMbDJxE5SZRnR2sCmIVNDEm+Ci0
         6FfTDxEZc+2EpmoFW9vqPlPm5vttGkzRvzgZu9h0oQcG0d728I5XsM+1eeqvfidU+LCe
         ftXtMy993DrKeA0doZ3EfhljASSuHVRDs8W5kN0A78a8oZUtqQiMa0+JGReLjXe0Hiak
         /2imjKZZxA8Iv+87hqwPGo0Gkc7GWQRGOE15sqamaVk7JA939sAk8SlvlzI4+B+lpkU3
         RdsQ==
X-Gm-Message-State: ANoB5plgWMkksw3Xxgty3fBj2UJsY6Y5uRpT5INZ73QXcQ2MYD75rLbR
        SM3rJnfCdg24P0NBn0HyAm0hzYrc5DrYzA==
X-Google-Smtp-Source: AA0mqf48+lwvGfrLFbuIkHD0vbPPIrPCjuhjDP8SAKBlKkK3DgMoo2GORW9J5ipQssTKITKu7RpGgA==
X-Received: by 2002:a05:620a:ce7:b0:6fa:baf6:ce9 with SMTP id c7-20020a05620a0ce700b006fabaf60ce9mr15282421qkj.421.1668022269796;
        Wed, 09 Nov 2022 11:31:09 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id bj17-20020a05620a191100b006ef1a8f1b81sm11635339qkb.5.2022.11.09.11.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 11:31:09 -0800 (PST)
Date:   Wed, 9 Nov 2022 11:31:00 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Nadav Amit <nadav.amit@gmail.com>,
        Will Deacon <will@kernel.org>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Nick Piggin <npiggin@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Subject: Re: [PATCH 4/4] mm: delay page_remove_rmap() until after the TLB
 has been flushed
In-Reply-To: <Y2vM6FFQX5GlOyBs@cmpxchg.org>
Message-ID: <f38b6812-9d77-c9b8-54c5-7e123cb63265@google.com>
References: <CAHk-=wh6MxaCA4pXpt1F5Bn2__6MxCq0Dr-rES4i=MOL9ibjpg@mail.gmail.com> <20221108194139.57604-4-torvalds@linux-foundation.org> <Y2vM6FFQX5GlOyBs@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Nov 2022, Johannes Weiner wrote:

> All 4 patches look good to me from an MM and cgroup point of view.

Yes, same here from me.

I was running my load on them (applied to 6.1-rc4) overnight, intending
to go for 20 hours.  It stopped just a few minutes short, for some fork
ENOMEM reason I've never (or not in a long time) seen before; but I don't
often run for that long, and I think if there were some new error in the
page freeing in the patches, it would have shown up very much quicker.

So I'd guess the failure was 99.9% likely unrelated, and please go ahead
with getting the patches into mm-unstable.

> 
> And with the pte still locked over rmap, we can continue with the
> removal of the cgroup-specific locking and rely on native MM
> synchronization, which is great as well.

Yes, please go ahead with that Johannes: and many thanks for coming to
the rescue with your input on the other thread.  But you'll find that
the mm/rmap.c source in mm-unstable is a bit different from 6.1-rc,
so your outlined patch will need some changes - or pass it over to
me for that if you prefer.  (And I do have one more patch to that,
hope to post later today: just rearranging the order of tests as
Linus preferred.)

Hugh
