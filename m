Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E130069FE5B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 23:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232870AbjBVWSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 17:18:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232627AbjBVWSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 17:18:05 -0500
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7BE948E08
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 14:17:24 -0800 (PST)
Received: by mail-vs1-xe2b.google.com with SMTP id b20so11565702vsu.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 14:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677104176;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z2wJaawwgvxlxLMOBAfRWpXh/WD6hBSU3be6jjh/wmY=;
        b=pILEBfdAYfUP87xYON+2DJTYHTU9qXs2Xu0xVglDua0uETL5FxnyXASgGUlbR80wcd
         6ugBfQ6yYnzK6p5CiNbrODmW3QXxPkPBQoQIf84X1X7uyCSTYAJNu4mIvR9CMkFbWP5G
         a6RBJ5eDWmHE/8QSAn2i6GJu5YE2I24vrsGh/2bbIqJK3Tqrx88VjgGvgS0ZNvpMRz1u
         PKGn7+3Wpbh1DOpr3cRZSMamSpt9yUbolP4IfT9WUSh1cLL1nIld6LJJla+eGh1q7yMx
         sr82T1GjIj3Gos8Q/mw5lWyhWOePqVm/N7322IUQt+NyPXVP/D8qSmpWBnBGFJS+E3/B
         h4Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677104176;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z2wJaawwgvxlxLMOBAfRWpXh/WD6hBSU3be6jjh/wmY=;
        b=toyylD5s4KUp4oIAc7+vALEVHzj/37HOAnksBU+aMggmU/lQyfdTpwIkBD1jmR3v3O
         NhCMPBVmriPcitHAcPoOdhBgCcbJ5O4OMCm7JbS2XSaNfJk4nObUEvUqS26XZzGCum6n
         fSNPSsShmg77YRpQmvrweaPxIJskI5XQQKINMTTnAnHe3e43lMOSAXgxIx97STPlWNIv
         +5pfXW0kSA/6Cc9/1yh9HKFgUYx8tR8thfR3dvXU1QLVf2AFXFE3pC1svTNrDY929uVY
         QvSgsAtYgPf7UZVmIh5jOc4NrLUKy26g6MKuhQt1D7t5U6YIzSb4khGzNYTmjYKLSCEf
         R4Qg==
X-Gm-Message-State: AO0yUKXHtgDsjz5hR4Vl3Q4fMzmuuSBu6dBJ1aUkPg89s0z8QDXxsMGF
        wnmpHL/mDm+kvnAFSrlVLNAeCG+eCE/wcW7GvuSB1s0bIupUSlSC
X-Google-Smtp-Source: AK7set8lIfX3bdQao6+azls2W3CAN7L9AsZ+fx5l5Z3cxgSJcTUQsUtZvzjHoC1Wqut5nhJNvCyh0ZW+t4FsdVYKv9Q=
X-Received: by 2002:a05:6102:23f6:b0:3c8:6949:ea4c with SMTP id
 p22-20020a05610223f600b003c86949ea4cmr2261784vsc.76.1677104175971; Wed, 22
 Feb 2023 14:16:15 -0800 (PST)
MIME-Version: 1.0
References: <20221208053649.540891-1-almasrymina@google.com>
 <20230124120913.GA26449@willie-the-truck> <c663ba9da2c14c69a126f01774cf5973@AcuMS.aculab.com>
In-Reply-To: <c663ba9da2c14c69a126f01774cf5973@AcuMS.aculab.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Wed, 22 Feb 2023 14:16:04 -0800
Message-ID: <CAHS8izNbZ=8on1qx+DmVwVX_oqQ4NwPULjxyy00dSUoJDfyskw@mail.gmail.com>
Subject: Re: [PATCH v1] arch: Enable function alignment for arm64
To:     David Laight <David.Laight@aculab.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
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

On Wed, Jan 25, 2023 at 3:16 AM David Laight <David.Laight@aculab.com> wrote:
>
> From: Will Deacon <will@kernel.org>
> > Sent: 24 January 2023 12:09
> >
> > On Wed, Dec 07, 2022 at 09:36:48PM -0800, Mina Almasry wrote:
> > > We recently ran into a double-digit percentage hackbench regression
> > > when backporting commit 12df140f0bdf ("mm,hugetlb: take hugetlb_lock
> > > before decrementing h->resv_huge_pages") to an older kernel. This was
> > > surprising since hackbench does use hugetlb pages at all and the
> > > modified code is not invoked. After some debugging we found that the
> > > regression can be fixed by back-porting commit d49a0626216b ("arch:
> > > Introduce CONFIG_FUNCTION_ALIGNMENT") and enabling function alignment
> > > for arm64. I suggest enabling it by default for arm64 if possible.
> > >
> ...
> >
> > This increases the size of .text for a defconfig build by ~2%, so I think it
> > would be nice to have some real numbers for the performance uplift. Are you
> > able to elaborate beyond "double-digit percentage hackbench regression"?
> >
> > In general, however, I'm supportive of the patch (and it seems that x86
> > does the same thing) so:
>
> I bet it just changes the alignment of the code so that more
> functions are using different cache lines.
>
> All sorts of other random changes are likely to have a similar effect.
>
> Cache-line aligning the start of a function probably reduces the
> number of cache lines the functions needs - but that isn't guaranteed.
> It also slightly reduces the delay on a cache miss - but they are so
> slow it probably makes almost no difference.
>

David, my understanding is similar to yours. I.e. without explicit alignment:

1. Random changes to the code can cause critical path functions to
become aligned or unaligned which will cause perf
regressions/improvements.
2. Random changes to the code can cause critical path functions to be
placed near a cache line boundary, causing one more cache line to be
loaded when they are run, which will cause perf regressions.

So for these very reasons function alignment is a good thing.

>         David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
>
