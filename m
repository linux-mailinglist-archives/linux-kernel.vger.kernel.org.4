Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE3B862355E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 22:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbiKIVEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 16:04:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiKIVEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 16:04:31 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78779B7D7
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 13:04:30 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id 8so18867qka.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 13:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XpdFWP2UvcAbMGbUYPrSMtfLikuC8rkjFeQL5hAciEA=;
        b=KdE1Y7fAhltwN53hSoHGDBlfPvPeRlvmLCaw+KCDc1dgnDMy9H9uLEGV037MQ0FqfD
         3jZ3GqySXl6FuE9sMkaeHxI/FeCXjw9BIDb8HnG+G4ne79A53gyDug1ySQnIjLw7vakB
         nWaiifZbt81yMI6xYRyWLd5CJDeRZcuejE4mM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XpdFWP2UvcAbMGbUYPrSMtfLikuC8rkjFeQL5hAciEA=;
        b=x5fiV4YlH9SyJZMo/1fNia3ekXFMuCzW15ezBWdidWmOKU31DgTSKshEXLDOmzHsUl
         PvPJlTnoogPeYSetEjarzevgOMCydbGenAtQg3sigM+GY81XcnDBwr5vjcvoKLJ5AB4q
         WcEZTvKEfosdAdDgGTBo+eUR/eR7PP4pOoctToSbJivcStZNejBQXonl7Go1ZnIbBNxq
         5Y8Y9XW9/cq7vV/iv7fNYk7BQuQT4KQ3eJrg+kRe5eUPGWW4vmZJJ/pB6/R1A9tkOu/M
         ndzANCwrJs1Dnccw6hWabXcs03WEVD/+KQUxJBjigPCeqNUHvrswTr90PwhQbM1XUmNV
         GZPw==
X-Gm-Message-State: ANoB5pnHh1OZL2i/9O8hW87VrWdpB8jVF5jfkwflEbsCCEC0FIXSBLvC
        KtDmCnl6NJ5+JNbbRWvMhbzBtP+5DyaJ4Q==
X-Google-Smtp-Source: AA0mqf4Hs0HPLl2L2ENyREwKBUaTD+Egn7bkLS5fpLMirMdCVby9RSf6gr1KD3rG5KywsKy3n7TyWg==
X-Received: by 2002:a05:620a:12e9:b0:6fb:166e:34e4 with SMTP id f9-20020a05620a12e900b006fb166e34e4mr2347843qkl.757.1668027869319;
        Wed, 09 Nov 2022 13:04:29 -0800 (PST)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id i22-20020a05620a249600b006faf76e7c9asm5271322qkn.115.2022.11.09.13.04.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 13:04:25 -0800 (PST)
Received: by mail-yb1-f177.google.com with SMTP id n85so184302yba.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 13:04:23 -0800 (PST)
X-Received: by 2002:a25:bd7:0:b0:6d7:7464:4859 with SMTP id
 206-20020a250bd7000000b006d774644859mr14656214ybl.362.1668027863307; Wed, 09
 Nov 2022 13:04:23 -0800 (PST)
MIME-Version: 1.0
References: <20221109203051.1835763-1-torvalds@linux-foundation.org>
 <20221109203051.1835763-4-torvalds@linux-foundation.org> <CAHk-=wjf+gN25grUT3o3XK8-B-b2jhBuN8YMLQvq-=AXTcuFXg@mail.gmail.com>
In-Reply-To: <CAHk-=wjf+gN25grUT3o3XK8-B-b2jhBuN8YMLQvq-=AXTcuFXg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 9 Nov 2022 13:04:07 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiFmm+X92Ghkz_LDG53djReK=idAj0uvSdES+yeG1X=Dw@mail.gmail.com>
Message-ID: <CAHk-=wiFmm+X92Ghkz_LDG53djReK=idAj0uvSdES+yeG1X=Dw@mail.gmail.com>
Subject: Re: [PATCH 4/4] mm: delay page_remove_rmap() until after the TLB has
 been flushed
To:     Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
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

On Wed, Nov 9, 2022 at 12:48 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I'm sure I messed something up in the process [...]

I hate being right.

The UP build requires a

  #ifdef CONFIG_SMP
  ..
  #endif

around the tlb_flush_rmaps() implementation in mm/mmu_gather.c, since
the UP case now shares the empty "no nothing" implementation with
s390.

I'm not going to re-send the series for that trivial fix, since nobody
is likely to actually care about UP anyway, but since I noticed it
(after sending things out, sorrt), I'll just mention it here.

And I was so happy about sharing the s390 and UP case, and avoiding
any code being specific to s390. Which is what introduced this thing.

Oh well. Easy fix. Just egg on my face. Again.

                Linus
