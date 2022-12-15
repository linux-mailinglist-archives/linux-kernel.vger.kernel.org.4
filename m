Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D39B064DF78
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 18:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiLOROi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 12:14:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbiLORO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 12:14:29 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B94313E19
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 09:14:28 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id v124-20020a1cac82000000b003cf7a4ea2caso2224516wme.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 09:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IMdxcuxIClBifPQw6g3nMP6O5X2GcDvGLJDe+9TDwNo=;
        b=IP/1mIh6qW3R69MA9Alu/oF7xteHc7Y810FIdRwt9ZirZkqIPCCJJClrVhKqfYFbfL
         pgEqdUd2o5o7Mk/ATfCgr4PmwecShSXs0mWzsIoH+H9G/0rG3fCAXMLQ94MWxPKAXbXz
         t4cRctquFaYRXHwdbCL8JvLGZjnwEF5cnDKuL5c5gRZ53L5jZyOiMD8vtGFfg5+ENi7U
         C9KyOMMhOtKOtEI34QnSK0Ee4JgEoyEZZ4yZ5iYtVB8ZvhJuNBQmq9OYO7i3dIchtPzd
         osrZax5U+9kBKMBQ1wZrYR1lBXxeYKIf6lMo/11/Qi4YjyF1laL2pQbjz/Ort0VkbX/i
         9L8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IMdxcuxIClBifPQw6g3nMP6O5X2GcDvGLJDe+9TDwNo=;
        b=ZlQIA/USRpGHNHk0aH4vV7AhxlWnPcaPrqDLYULfWFb+WtYBRdpzBbdAUKKJC6uLsY
         BQMoHS/yq38mXA8Bg7LsRyaniuT4/3w2GjCMGF6Ab9pRtFBsRyQfKeVd9WtfRNDRHQaL
         XzliWf9KBCpesPg1fvG2SDn2/zbutX1StHSUFRO6Kkr2zmnR3cR2xLpuEFjwy+sGEjyO
         lYK/6ZffClEEQyBz2dAlXMJOtW+LYJa6QKhrgf2VBZaFFPBO8VqeLJMVCT97r2C+PSBS
         UyzJcHW+Ay+uS31w1jYCRclUy7ENuTtpOkkwtoLXbrVmj3/wtJbAp502LyATxxM2xACa
         6SSg==
X-Gm-Message-State: ANoB5pnd9co1n3J4CW1QIMBZE3s4rSJ5kUydr1wTOgvpsrUKw4iRKywG
        4y/cFIsPMp2j7Qz3+bc4wsqxwpMM/kqiEp0CzCdRFSHsZyo=
X-Google-Smtp-Source: AA0mqf7Bgt3Fsu4F2pC7NIMqT54RKD48pfMzz2Ir5W1n86irf6a4sppUgOfY+jvVT49ggxRajXQGyp/DeAd/jncI8Gw=
X-Received: by 2002:a05:600c:1e20:b0:3cf:8952:2fd2 with SMTP id
 ay32-20020a05600c1e2000b003cf89522fd2mr527789wmb.9.1671124466615; Thu, 15 Dec
 2022 09:14:26 -0800 (PST)
MIME-Version: 1.0
References: <20221208202808.908690-1-nphamcs@gmail.com> <20221208202808.908690-4-nphamcs@gmail.com>
 <Y5dNPYVNyjHgGCD6@casper.infradead.org>
In-Reply-To: <Y5dNPYVNyjHgGCD6@casper.infradead.org>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Thu, 15 Dec 2022 09:14:15 -0800
Message-ID: <CAKEwX=Pb8npL9p9bkeEnudp1FsLJ_HydabNDg9J8evD+qV9coQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] cachestat: implement cachestat syscall
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bfoster@redhat.com,
        kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2022 at 7:48 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, Dec 08, 2022 at 12:28:07PM -0800, Nhat Pham wrote:
> > +             struct address_space *mapping = f.file->f_mapping;
> > +             pgoff_t first_index = off >> PAGE_SHIFT;
> > +             pgoff_t last_index =
> > +                     len == 0 ? ULONG_MAX : (off + len - 1) >> PAGE_SHIFT;
> > +             XA_STATE(xas, &mapping->i_pages, first_index);
> > +             struct folio *folio;
> > +
> > +             rcu_read_lock();
> > +             xas_for_each(&xas, folio, last_index) {
> > +                     if (xas_retry(&xas, folio) || !folio)
> > +                             continue;
>
> !folio can't be true.  xas_for_each() terminates when folio is NULL.

Good to know - I'll remove this in the next version.

>
> > +                     if (xa_is_value(folio)) {
> > +                             /* page is evicted */
> > +                             void *shadow = (void *)folio;
> > +                             bool workingset; /* not used */
> > +
> > +                             cs.nr_evicted += 1;
> > +
> > +#ifdef CONFIG_SWAP /* implies CONFIG_MMU */
> > +                             if (shmem_mapping(mapping)) {
> > +                                     /* shmem file - in swap cache */
> > +                                     swp_entry_t swp = radix_to_swp_entry(folio);
> > +
> > +                                     shadow = get_shadow_from_swap_cache(swp);
> > +                             }
> > +#endif
> > +                             if (workingset_test_recent(shadow, true, &workingset))
> > +                                     cs.nr_recently_evicted += 1;
> > +
> > +                             continue;
> > +                     }
> > +
> > +                     /* page is in cache */
> > +                     cs.nr_cache += 1;
> > +
> > +                     if (folio_test_dirty(folio))
> > +                             cs.nr_dirty += 1;
> > +
> > +                     if (folio_test_writeback(folio))
> > +                             cs.nr_writeback += 1;
>
> A folio may represent more than one page.  That's the point of folios.
> So there should be something in here which does
>
>         unsigned long nr = folio_nr_pages();
>
> and then all these '1' should be 'nr'.

Yikes, that's a bug that I missed! Thanks for pointing it out.

> Except that you may need to adjust nr if 'first_index' > folio->index, or
> 'last_index' < folio->index + nr.

Sounds good!

>
> You should test this with XFS, AFS or erofs to be sure you're getting
> results that look right.
>
