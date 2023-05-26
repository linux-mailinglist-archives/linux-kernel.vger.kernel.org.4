Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944CE712327
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 11:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242885AbjEZJNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 05:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjEZJNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 05:13:11 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785F212C
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 02:13:10 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3090d3e9c92so430734f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 02:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685092389; x=1687684389;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R1U6XpxDvSih4ymgTpgV3kFrDpgdRbG2VFnRYHWBNJs=;
        b=ivDTv96j8kH0dG6OxnbkkGSED/St7SA8wh2JOdYc36V0GOaDPoX+B7W4mdUzo/UBhJ
         Wo5yXXRaHSyRUP3nMMDT+QLgN1vSQ4Ivr/VgLhTufKswkJmAEqMtC3Ky74vOo4WIbkKk
         sdJpJWiIh+TgPvLh04ZMZ+Wk5lfSeMnKu00wRNSJkIrwv9FnkTra2n/E9INP13/yzde8
         rfGkfiGVVsl1wFbV8YrSebJrrOgz6t62DjufKg9rz3X+3OwlIROpxwHnLLZBUC3ywNLi
         ISdUIxGMWRXVcfBWNQO9mETwwb2EhHW3+mJ3UzaQWCeJxeCtV/aoTrdceUaT31pntrY5
         iIdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685092389; x=1687684389;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R1U6XpxDvSih4ymgTpgV3kFrDpgdRbG2VFnRYHWBNJs=;
        b=ZubYbyAyYQ/O1LaUwJhrKDStBp0/YsfSEOJ38ti9DybLd43GtuO+v4S3Di+MRJzcqH
         BzMhNKMNZGi0KcNb2Swkz4LsYe703A7YoVR4TNoCooa8S3b8PiV8V7kvlcqO7/wKQYL8
         pXChsCzAAFz4IJD1tFfwt0he76xI0VSZq9/ljfDwtvJ8S8OzimH68Ek7RjxxBYTuZZXE
         E0DBkY1+aqsz37KiCfbAaGVOqay2sePHslYsyKJgqYEYK0o/bVuBmofFYMoaEbXJ7nVV
         BKWn1IAOIv5FN2WNzw5ig0cKHxeFWpZXdYcv8kwYgdmHV49HG/l6mgxLNNGntI1hpM6x
         0yOg==
X-Gm-Message-State: AC+VfDw5qoP+mN6zBV1MX8krqZq+K2e6AeYmykuck3zj2ASbcJBR8Z/D
        PjGCqIO74+m/TPPIB8JdmRc=
X-Google-Smtp-Source: ACHHUZ7DIbuyHeioFWko7fZWbQQq71ahSBtGwNaANF/Weuj5m55L4H0xvPykQ8Rf3L5W/YBa+rCveg==
X-Received: by 2002:a5d:6e53:0:b0:30a:ab38:30fe with SMTP id j19-20020a5d6e53000000b0030aab3830femr937975wrz.43.1685092388679;
        Fri, 26 May 2023 02:13:08 -0700 (PDT)
Received: from localhost (host81-154-179-160.range81-154.btcentralplus.com. [81.154.179.160])
        by smtp.gmail.com with ESMTPSA id r2-20020a5d4e42000000b003095bd71159sm989789wrt.7.2023.05.26.02.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 02:13:07 -0700 (PDT)
Date:   Fri, 26 May 2023 10:10:56 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [PATCH] lib/test_vmalloc.c: avoid garbage in page array
Message-ID: <368bbc1d-d810-4bc4-8091-7ed55631344f@lucifer.local>
References: <20230524082424.10022-1-lstoakes@gmail.com>
 <ZG/4gVO9XPXccR5+@MiWiFi-R3L-srv>
 <b87ff2af-c89d-4ddd-8992-2ffb337fbe0c@lucifer.local>
 <ZHB0UTEYUMZVa23V@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHB0UTEYUMZVa23V@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 04:56:49PM +0800, Baoquan He wrote:
> > Umm, the function literally opens with:-
> >
> > 	/*
> > 	 * Skip populated array elements to determine if any pages need
> > 	 * to be allocated before disabling IRQs.
> > 	 */
> > 	while (page_array && nr_populated < nr_pages && page_array[nr_populated])
> > 		nr_populated++;
>
> OK, suppose page_array[] alreasy has three pages populated, if not
> initialized and there's garbage data in page_array[], it could have
> nr_populated > 3 finally? This is really risky.
>
> >
> > And then later:-
> >
> > 		/* Skip existing pages */
> > 		if (page_array && page_array[nr_populated]) {
> > 			nr_populated++;
> > 			continue;
> > 		}
>
> This is interesting, I thought this place of nr_populated checking and
> updating is meaningless, in fact it's skipping the element with vlaue
> in the middle of page_array. I realize this when I recheck the code when
> replying to your mail. Not sure if we should restrict that, or it's
> really existing reasonablly.
>
> [x][x][x][][][][x][x][][]
> x marks the element pointing to page.

All of this is fine, the caller is expected to provide a zeroed array or an
array that contains existing elements. We only need to use it with a zeroed
array. We zero the array. Problem solved. Other users use the 'already
allocated pages' functionality, we don't care.

>
> >
> > This explicitly skips populated array entries and reads page_array to see
> > if entries already exist, and literally documents this in the comments
> > above each line, exactly as I describe.
>
> OK, I misread your words in log. While page_array[] is still output
> parameter, just not pure output parameter? Not sure if I understand
> output parameter correctly.

Well, output implies output i.e. writing to something. If you also read it,
it's not just an output parameter is it?

I don't really want to get into semantics here, the point is the test's
expectation is that it'd be write-only and it's not so we have to zero the
array, that's it.

>
> Well, I meant adding sentence above __alloc_pages_bulk() to tell:
> page_array[] could have garbage data stored if you don't initialize
> it explicitly before calling __alloc_pages_bulk();
>

As I said I literally state in multiple places this is about needing to
initialise the array:-

    lib/test_vmalloc.c: avoid garbage in page array

...

    This is somewhat unexpected and breaks this test, as we allocate the pages
    array uninitialised on the assumption it will be overwritten.

...

    We solve both problems by simply using kcalloc() and referencing
    sizeof(struct page *) rather than sizeof(struct page).

So I completely disagree we need to add anything more.

> This could happen in other place if they don't use kcalloc(),
> kmalloc(GFP_ZERO) or something like this to allocate page_array[]?

We don't care? I'm fixing a test here not auditing __alloc_bulk_array().

> > A broader problem we might want to think about is how little anybody is
> > running this test in order that it wasn't picked up before now... obviously
> > there's an element of luck as to whether the page_array happens to be
> > zeroed or not, but you'd think it'd be garbage filled at least a reasonable
> > amount of the time.
>
> Hmm, that's why we may need notice people that there's risk in
> __alloc_pages_bulk() if page_array[] is not initialized and the garbage
> could be mistaken as a effective page pointer. My personal opinion.
> People may argue it's caller's responsibility to do that.
>
> Thanks
> Baoquan
>

That's just irrelevant to this change. You're also not replying to my point here
(that we're clearly not running this test very much).

I find this review super bikesheddy. Let's try not to bog things down in
lengthily discussions when literally all I am doing here is:-

1. Function expects a zeroed array
2. Change the code to zero the array
3. Change the array to be smaller since it only needs to store pointers

It's a two line change, can we try to be a little proportionate here?

You're not even giving me a tag because... I'm not auditing all uses of
__alloc_bulk_array() or something? Seriously.
