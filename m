Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB822644DDA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 22:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbiLFVTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 16:19:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiLFVTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 16:19:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2055547325
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 13:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670361513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i2YR3mOSxzpUKrezOQOiAA+KBmrgPX1bMkhWS8VXMu8=;
        b=cfeMti6imvmmHYEybwlseU2p5W8GsaQRknif3Hc3kvd/K7ror40HHuwjkwr7EEIIJXSZgh
        NksY/pDr74X9eJy5D63I87k9uVzqVT+h+XzQp7uxtgXM6TgGzRjse8G3233R1zCF9mZGeC
        6cZizbmxEXZ4dBbIeoTbXxqVNjoGVLo=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-451-zc3ErjTqNgKxLQQir2GP0Q-1; Tue, 06 Dec 2022 16:18:32 -0500
X-MC-Unique: zc3ErjTqNgKxLQQir2GP0Q-1
Received: by mail-qv1-f69.google.com with SMTP id nn2-20020a056214358200b004bb7bc3dfdcso35555868qvb.23
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 13:18:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i2YR3mOSxzpUKrezOQOiAA+KBmrgPX1bMkhWS8VXMu8=;
        b=5+J8YBf9mOJD7nPoAbZHqOGpHP8H5w4hWWOjK11NAsIpH5SQFT3p3X0Ey3G2Ft9eI+
         Ql6TJJ1agadY/ISmb9Shp1KQOuHY2wmOz2YzWhQnQlngQrWWbdGnj2nADSVDrqkD5QVv
         3STO1yf5SQn/AcDVCAkeARbzTFqlWURL82mZ/kvgdAHhLPI/GzbTgvzsNKP5Wn20Sy0X
         viCm0LWVNrjBz3o9FheKl+foxYp713XUDIiVhGquPgpo82DPsZ065bwbiOhNkqcxDm1X
         rLcj163/VA6i2PAOs21lu7FT+FmlAmtn3EIx5tuGUt9JF8hABYE2ldgyOeVlXGbv71pP
         L64w==
X-Gm-Message-State: ANoB5pmi8r7Hd1Pn0MwveaRhL+q0uiJk4Dn7ARHrsFdmwONu3Mcv/v/V
        zxgZYxAExdol5CrZT8AH57D2OOSYOPtEFgpVXO6hNN/X7aIzp2MUBqi6ILd03WdlIdPHPsIqoTt
        qJHc9LINEEH3HWrQhS8CQzHlF
X-Received: by 2002:ac8:1408:0:b0:3a5:c55a:47a4 with SMTP id k8-20020ac81408000000b003a5c55a47a4mr516843qtj.54.1670361511579;
        Tue, 06 Dec 2022 13:18:31 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5lFksiah2trB/06QzRBowJVOz6+v96Eel10IKtkPR/Yr1bHJq4VqtTDKSF8LgnSXzAtoPoHg==
X-Received: by 2002:ac8:1408:0:b0:3a5:c55a:47a4 with SMTP id k8-20020ac81408000000b003a5c55a47a4mr516838qtj.54.1670361511295;
        Tue, 06 Dec 2022 13:18:31 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id bp39-20020a05620a45a700b006cbe3be300esm15581579qkb.12.2022.12.06.13.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 13:18:30 -0800 (PST)
Date:   Tue, 6 Dec 2022 16:18:28 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Hugh Dickins <hughd@google.com>,
        David Hildenbrand <david@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Ives van Hoorne <ives@codesandbox.io>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@goole.com>,
        Alistair Popple <apopple@nvidia.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH RFC] mm/userfaultfd: enable writenotify while
 userfaultfd-wp is enabled for a VMA
Message-ID: <Y4+xpCRQCazCymdS@x1n>
References: <20221202122748.113774-1-david@redhat.com>
 <Y4oo6cN1a4Yz5prh@x1n>
 <690afe0f-c9a0-9631-b365-d11d98fdf56f@redhat.com>
 <19800718-9cb6-9355-da1c-c7961b01e922@redhat.com>
 <Y45duzmGGUT0+u8t@x1n>
 <92173bad-caa3-6b43-9d1e-9a471fdbc184@redhat.com>
 <22d8e8ac-d75-a66-2650-b4d59f89855e@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <22d8e8ac-d75-a66-2650-b4d59f89855e@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Hugh,

On Tue, Dec 06, 2022 at 11:09:40AM -0800, Hugh Dickins wrote:
> I have not been following the uffd-wp work, but I believe that David's
> painstaking and excellent account of vm_page_prot is correct.  Peter,
> please I beg you to follow his advice and go for (1) for uffd-wp.

Thanks for jumping in, I will.  Your input definitely matters.

I think the fundamental moot point was whether vm_page_prot is the "safest"
or "default" behavior of vma.

I thought it was the "default" and I don't want to have VM_UFFD_WP regions
to have default no-write attribute comparing to generic ones.  I wanted it
to behave exactly like a normal shmem vma if no one explicitly does
something else.

If it's "safest" and you also agree then I think indeed VM_UFFD_WP falls
into that category; frankly I don't have a solid clue before.  Maybe that
also matches better with the recent vma_wants_manual_pte_write_upgrade(),
or we start to lose write bit in do_numa_page() at least for uffd-wp
protected ranges when recovering the ptes, and it'll be ugly to have:

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 3a3d23b3dbe2..718d540b9eb4 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2086,7 +2086,7 @@ static inline bool vma_wants_manual_pte_write_upgrade(struct vm_area_struct *vma
         * private mappings, that's always the case when we have write
         * permissions as we properly have to handle COW.
         */
-       if (vma->vm_flags & VM_SHARED)
+       if ((vma->vm_flags & VM_SHARED) && !userfaultfd_wp(vma))
                return vma_wants_writenotify(vma, vma->vm_page_prot);
        return !!(vma->vm_flags & VM_WRITE);

To recover the write bit.

I tried to move forward with the 47ba8bcc33b2 ("mm/migrate: fix read-only
page got writable when recover pte", 2022-11-25) in mm-unstable upstream
because that seems pretty obvious to me and that's verified in the test
beds, but I obviously failed anyway.  Let's adjust the patches with the
best we can have.

> I do not share David's faith in "documented": documented or not,
> depart from safe convention and you will be adding (at least the
> opportunity for) serious bugs.

Yes I agree not having the write bit is safer.  That's also why I wanted to
move the wrprotect into pte_mkuffd_wp.  I assume from "resolving problem"
pov they're the same, but I'll follow your advise.

David, would you please repost a new patch for this one and copy Ives to
make sure it'll work for him in his systems?

I'd suggest to drop the mprotect example, I'll reply later on that to the
other email but I still don't know whether it's a good example for a reader
to understand the problem.

No reproducer needed for numa I think - I guess Ives's test case would be
far enough to verify it if possible.  I also hope what Ives saw was the
numa balancing issue you reported, so maybe it'll resolve all problem he
has.  Then with that verified and queued we can drop the mm/migrate patch.

Thanks,

-- 
Peter Xu

