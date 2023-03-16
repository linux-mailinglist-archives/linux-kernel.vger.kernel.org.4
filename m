Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 050336BD33B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 16:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbjCPPTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 11:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbjCPPTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 11:19:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B47DD517E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 08:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678979909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zk9KdCyCrYHmFVK1vb1UQg9WuTwY/vbXMs8lYmla1FA=;
        b=K50XjM6MWsqWDOnwG+AWrC9FeJyMpDFANRWYr6QnpS9Eo8VOmt4no5B79sx/aT3rESQkyq
        zbY8AJlFE006qxUZVulzJo3eqtli7u7dq5P2TwtHl4iiD1kFeFWCRfL1OgX/KIL6AVKcPm
        XixYW9VNdLIPQmiyqXyAyryjzfrA7hA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-g0FFi-DeOp6TexqXVKLY2A-1; Thu, 16 Mar 2023 11:18:28 -0400
X-MC-Unique: g0FFi-DeOp6TexqXVKLY2A-1
Received: by mail-qk1-f197.google.com with SMTP id oo24-20020a05620a531800b00745d671f9afso1090393qkn.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 08:18:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678979907;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zk9KdCyCrYHmFVK1vb1UQg9WuTwY/vbXMs8lYmla1FA=;
        b=UdfayYRgq/79LVSRDCaceiyi6cclYJs/7DSrJEJPZ3RWHcTOP5OlLuaCmEgGz4JNTm
         jBLIlG3qntx/+qRDwT4oGjfJr10Rm/hyBtEQ8os7pvi2hCsn89NqNYdF1yJK9Ja1DzT4
         wiD5GasNItq+L4e9Wgg5inojMHRYLheQRB2rPgl4s9OnD9bmZQfM/22GD/KOTev+wWuu
         IqEPrkNKCCGHOXoy7YM46WoQI1O/KUSYkTBWAM9J//w4Y2uvA7w1O/2ctqY7klCRKmk7
         282PNz9EaFkJRO7HoM7jc5ab61WGMdnhWB1ge17buzGOvpnd69OuBYqRGnqlH4571nWv
         jKFA==
X-Gm-Message-State: AO0yUKVYgtZ6gUyeTL+PQSfJaaDBzEeRI4CAoLUtyQsekgpT+LN4KjHa
        /USPOUAkkfJ2MecMEX5o7fIidPiAaa3xkdt3NOb5ugryEiYxKk1yKwcApd7wMKlEqgw69ERVr1z
        hut/tqWFZVdp7EHmL4XNm2F6v
X-Received: by 2002:ac8:5f8b:0:b0:3b9:fc92:a6 with SMTP id j11-20020ac85f8b000000b003b9fc9200a6mr5627934qta.6.1678979907388;
        Thu, 16 Mar 2023 08:18:27 -0700 (PDT)
X-Google-Smtp-Source: AK7set+odfYRpP33cKjai6UkPs9JzY9bzO4d71Nnx6DHJNlPPBdosWt4TG+KSxTh4IguRUSCcm1nyQ==
X-Received: by 2002:ac8:5f8b:0:b0:3b9:fc92:a6 with SMTP id j11-20020ac85f8b000000b003b9fc9200a6mr5627901qta.6.1678979906963;
        Thu, 16 Mar 2023 08:18:26 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id z201-20020a3765d2000000b00745c2b29091sm5853490qkb.93.2023.03.16.08.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 08:18:26 -0700 (PDT)
Date:   Thu, 16 Mar 2023 11:18:25 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>
Subject: Re: [PATCH] mm/thp: Rename TRANSPARENT_HUGEPAGE_NEVER_DAX to
 _UNSUPPORTED
Message-ID: <ZBMzQW674oHQJV7F@x1n>
References: <20230315171642.1244625-1-peterx@redhat.com>
 <83625129-26c9-8885-7367-bb56bc5367f3@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Rhi7qt2LvjtkimrJ"
Content-Disposition: inline
In-Reply-To: <83625129-26c9-8885-7367-bb56bc5367f3@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Rhi7qt2LvjtkimrJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Thu, Mar 16, 2023 at 03:57:12PM +0100, David Hildenbrand wrote:
> On 15.03.23 18:16, Peter Xu wrote:
> > TRANSPARENT_HUGEPAGE_NEVER_DAX has nothing to do with DAX.  It's set when
> > has_transparent_hugepage() returns false, checked in hugepage_vma_check()
> > and will disable THP completely if false.  Rename it to reflect its real
> > purpose.
> > 
> > Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> > Cc: Yang Shi <shy828301@gmail.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >   include/linux/huge_mm.h | 2 +-
> >   mm/huge_memory.c        | 4 ++--
> >   2 files changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > index 70bd867eba94..9a3a3af2dd80 100644
> > --- a/include/linux/huge_mm.h
> > +++ b/include/linux/huge_mm.h
> > @@ -79,7 +79,7 @@ static inline vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn,
> >   }
> >   enum transparent_hugepage_flag {
> > -	TRANSPARENT_HUGEPAGE_NEVER_DAX,
> > +	TRANSPARENT_HUGEPAGE_UNSUPPORTED,
> >   	TRANSPARENT_HUGEPAGE_FLAG,
> >   	TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG,
> >   	TRANSPARENT_HUGEPAGE_DEFRAG_DIRECT_FLAG,
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index b0ab247939e0..913e7dc32869 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -88,7 +88,7 @@ bool hugepage_vma_check(struct vm_area_struct *vma, unsigned long vm_flags,
> >   	/*
> >   	 * If the hardware/firmware marked hugepage support disabled.
> >   	 */
> > -	if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_NEVER_DAX))
> > +	if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_UNSUPPORTED))
> >   		return false;
> >   	/* khugepaged doesn't collapse DAX vma, but page fault is fine. */
> > @@ -464,7 +464,7 @@ static int __init hugepage_init(void)
> >   		 * Hardware doesn't support hugepages, hence disable
> >   		 * DAX PMD support.
> 
> 
> We should also fixup that comment then, no?

Yes, I'd drop the comment since the code explains itself.  One fixup
attached.  Thanks.

-- 
Peter Xu

--Rhi7qt2LvjtkimrJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment;
	filename="0001-fixup-mm-thp-rename-TRANSPARENT_HUGEPAGE_NEVER_DAX-t.patch"

From 0d01260fedfd9d99c1eeac10f9bddd52477823bd Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Thu, 16 Mar 2023 11:08:47 -0400
Subject: [PATCH] fixup! mm/thp: rename TRANSPARENT_HUGEPAGE_NEVER_DAX to
 _UNSUPPORTED

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/huge_memory.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2bb16cf4cafa..81a5689806af 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -460,10 +460,6 @@ static int __init hugepage_init(void)
 	struct kobject *hugepage_kobj;
 
 	if (!has_transparent_hugepage()) {
-		/*
-		 * Hardware doesn't support hugepages, hence disable
-		 * DAX PMD support.
-		 */
 		transparent_hugepage_flags = 1 << TRANSPARENT_HUGEPAGE_UNSUPPORTED;
 		return -EINVAL;
 	}
-- 
2.39.1


--Rhi7qt2LvjtkimrJ--

