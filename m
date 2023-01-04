Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0128C65DCCD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 20:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240110AbjADTeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 14:34:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240122AbjADTeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 14:34:14 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5D0395DF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 11:34:13 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id s9so2091744wru.13
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 11:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KonOja3gt2Do8uQ+N5ZsHzrJgX0wr3tVjawKXZm29t0=;
        b=jIC6riemWxGAILjZDvMRYsp+OMPV442Ttv+U6vX9yAxZQ7i2/aOQ5/ebU0i/UgtSsI
         ZWmvXeso6jxm4e1PGA9tAKEAfivX7HMbVMvRTmhxxis1aqUemalqgndfs6d8LUsfVUF3
         aZQ47hP1aOqmnGbedybRs314i1hSjujHla3kVdpJgcymBKTGvwRu+D4yHal6mCxEN8Uu
         EXnZmK2xIeXDToeo8t3d1ikJN84nNqM2zprgNNvj2GcFtwPyH6pvTNVkBAdU/5Z/H3lh
         P88HQscp46reWK1h/qQ6B2kyJ+jVHQ3xNrnwP3nyFjDjZoD3Ot3T2bADQ1Pj9a3198CX
         T33A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KonOja3gt2Do8uQ+N5ZsHzrJgX0wr3tVjawKXZm29t0=;
        b=hWDRVscJ+x/SRRF4hVZT/NaZPE5DMEPDp8cJNiKaDN4fMjCVIHfWy1e1mx6ylrI8vz
         l5oDQxlafpMjnBw9QWqG/q9kX6Ad+b2OcH3Qt6An9zzBuIcZ2qtNPlHbOrnsRyse4ZrQ
         xa5Toxh2Uda6rJzNqgiryINLv3TR9eKICxUmHihu5L9uolCne+mH3lW7tk6EFfD0cVhL
         RRTODucVqObtxBol1yKXGaQwenWsJeQ+9hd0nHzloWbejUL+lxPAZyXg6EBn5ZaP5yF9
         wSqgsUirp+9T5y3389IuKrcBml+uK3dQhJ9GXRb/hgaJLoxr+CMDSb2Hyc5/Kyi6UWXN
         2Oaw==
X-Gm-Message-State: AFqh2krMSG0HoW19cEnQmEg18iFd7pYeQNbchhNcCExw5ja4OzPJDtj1
        hN+EbU4B4mVIb9VBGs1Pj2rrN+6kJ8BHvPDMEElMlg==
X-Google-Smtp-Source: AMrXdXuE+Jz47ACBTQhXSDrEl9W9Z4cli3e6SXSyl0QMgoIf6o2paDsXXUoCTlyv4rQ8nnF9koQftCuvIKwPkpdFMDY=
X-Received: by 2002:a05:6000:1367:b0:28c:295f:3369 with SMTP id
 q7-20020a056000136700b0028c295f3369mr748046wrz.355.1672860851698; Wed, 04 Jan
 2023 11:34:11 -0800 (PST)
MIME-Version: 1.0
References: <20230101230042.244286-1-jthoughton@google.com> <Y7S0lDCeBYLMHBvR@x1n>
In-Reply-To: <Y7S0lDCeBYLMHBvR@x1n>
From:   James Houghton <jthoughton@google.com>
Date:   Wed, 4 Jan 2023 19:34:00 +0000
Message-ID: <CADrL8HWSym93=yNpTUdWebOEzUOTR2ffbfUk04XdK6O+PNJNoA@mail.gmail.com>
Subject: Re: [PATCH] hugetlb: unshare some PMDs when splitting VMAs
To:     Peter Xu <peterx@redhat.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
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

> > @@ -4828,6 +4830,23 @@ static int hugetlb_vm_op_split(struct vm_area_struct *vma, unsigned long addr)
> >  {
> >       if (addr & ~(huge_page_mask(hstate_vma(vma))))
> >               return -EINVAL;
> > +
> > +     /* We require PUD_SIZE VMA alignment for PMD sharing. */
>
> I can get the point, but it reads slightly awkward.  How about:
>
>         /*
>          * If the address to split can be in the middle of a shared pmd
>          * range, unshare before split the vma.
>          */
>

How about:

/*
 * PMD sharing is only possible for PUD_SIZE-aligned address ranges
 * in HugeTLB VMAs. If we will lose PUD_SIZE alignment due to this split,
 * unshare PMDs in the PUD_SIZE interval surrounding addr now.
 */

> I remember you had a helper to check pmd sharing possibility.  Can use here
> depending on whether that existed in the code base or in your hgm series
> (or just pick that up with this one?).

Right, it introduces `pmd_sharing_possible` but I don't think it helps here.

>
> > +     if (addr & ~PUD_MASK) {
> > +             /*
> > +              * hugetlb_vm_op_split is called right before we attempt to
> > +              * split the VMA. We will need to unshare PMDs in the old and
> > +              * new VMAs, so let's unshare before we split.
> > +              */
> > +             unsigned long floor = addr & PUD_MASK;
> > +             unsigned long ceil = floor + PUD_SIZE;
> > +
> > +             if (floor < vma->vm_start || ceil >= vma->vm_end)
>
> s/>=/>/?

Indeed, thanks.

>
> > +                     /* PMD sharing is already impossible. */
> > +                     return 0;
>
> IMHO slightly cleaner to write in the reversed way and let it fall through:
>
>   if (floor >= vma->vm_start && ceil <= vma->vm_end)
>       hugetlb_unshare_pmds(vma, floor, ceil);

Will do.

>
> Thanks,
>

Thanks Peter!
