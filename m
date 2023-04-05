Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA916D817A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 17:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238682AbjDEPSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 11:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237845AbjDEPRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 11:17:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5CA7ABA
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 08:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680707716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZCSaElfv8AUmPjWD9J2bsaS+EBjnAjuOP3qTK8N+O8U=;
        b=PXgGVFyEFwzFrIAYr9B6SXjQj0VbD92Kyt+rcIkhaSEsceJyIlwR3MK6hf43CG1wAqPWAl
        mKqVAySmqch9f1XHXd3CDMMVaBThHeUod0o4bUKk9+SS4jcW5ld/ltaFOT3raQZYp45v76
        nyN8RiFm8oVkz5HpSBumzj+GzXpxh7I=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-BEjvFRQgOuq23cMkMOoLrQ-1; Wed, 05 Apr 2023 11:15:15 -0400
X-MC-Unique: BEjvFRQgOuq23cMkMOoLrQ-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-3e2daffa0d4so12216361cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 08:15:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680707714;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZCSaElfv8AUmPjWD9J2bsaS+EBjnAjuOP3qTK8N+O8U=;
        b=Ms/hATcxwKVXLcsm2udXK168xz036+4Qq6E4g5znsrgFLaxRu5Lnrtx1A/7uT5emET
         XMHa1PeZKQVP+9uN3tuFpN07YMyRHMlQi9aZy//ooDOITO6IXwiwm41PlEMvBRhoJyQb
         J7Upv88CYfM0a7P8x5fc0+Z1pgPjayY8ceqirp5axlvUehBzLRRjkQ1T/0iR+f6JaGDm
         b8rj2KVAHfjSmpG2Te1zoor+1XWChhXJ57C/+ZZrr1K/oyIldZTyg5V7lIAYChCcMewM
         Itj6NF+sZm4O5+IXj9zKK4InWGVbjAXU5dwiU+nbz6zy5l4l6vHOvmuM9ZTDL265bhrM
         BQrg==
X-Gm-Message-State: AAQBX9egeBtAWTcL32TYdX9A5zU21F7K3g2FkyH5wm7ndKYTI4s5jxhk
        5HGgkuWFDu2xKHmcBiOrR0rtudXxPU4P8nsbdQ80ui59JN/d2Bt5uGKaaq7lWxsIJtZUIxoz6WB
        R6BUy82Dw1Fc/lISmAtcaptFG
X-Received: by 2002:a05:622a:1ba8:b0:3e3:98cf:68ae with SMTP id bp40-20020a05622a1ba800b003e398cf68aemr6761947qtb.2.1680707714569;
        Wed, 05 Apr 2023 08:15:14 -0700 (PDT)
X-Google-Smtp-Source: AKy350amPFJ+bM/0v8906JhqvyF31P/2ETS/KzMuu4Tg0eaX0KiKrrhsvKyctDwRDtf6mNRyFAbQUw==
X-Received: by 2002:a05:622a:1ba8:b0:3e3:98cf:68ae with SMTP id bp40-20020a05622a1ba800b003e398cf68aemr6761866qtb.2.1680707713888;
        Wed, 05 Apr 2023 08:15:13 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id z24-20020ac84558000000b003d7e923736asm4096162qtn.6.2023.04.05.08.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 08:15:13 -0700 (PDT)
Date:   Wed, 5 Apr 2023 11:15:12 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>
Subject: Re: [PATCH v1 2/2] mm/userfaultfd: don't consider uffd-wp bit of
 writable migration entries
Message-ID: <ZC2QgGCWyc41x7Je@x1n>
References: <20230405142535.493854-1-david@redhat.com>
 <20230405142535.493854-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230405142535.493854-3-david@redhat.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2023 at 04:25:35PM +0200, David Hildenbrand wrote:
> If we end up with a writable migration entry that has the uffd-wp bit set,
> we already messed up: the source PTE/PMD was writable, which means we could
> have modified the page without notifying uffd first. Setting the uffd-wp
> bit always implies converting migration entries to !writable migration
> entries.
> 
> Commit 8f34f1eac382 ("mm/userfaultfd: fix uffd-wp special cases for
> fork()") documents that "3. Forget to carry over uffd-wp bit for a write
> migration huge pmd entry", but it doesn't really say why that should be
> relevant.
> 
> So let's remove that code to avoid hiding an eventual underlying issue
> (in the future, we might want to warn when creating writable migration
>  entries that have the uffd-wp bit set -- or even better when turning a
>  PTE writable that still has the uffd-wp bit set).
> 
> This now matches the handling for hugetlb migration entries in
> hugetlb_change_protection().
> 
> In copy_huge_pmd()/copy_nonpresent_pte()/copy_hugetlb_page_range(), we
> still transfer the uffd-bit also for writable migration entries, but simply
> because we have unified handling for "writable" and "readable-exclusive"
> migration entries, and we care about transferring the uffd-wp bit for
> the latter.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

I think that's mostly for sanity to carry over one generic bit between
present <-> !present, even if uffd-wp is not that generic and currently
closely bound to write bit.

E.g., we will need to be more careful when we want to change the meaning of
uffd-wp bit some day, but that'll always be challenging anyway, so not
something this will change.

Thanks,

-- 
Peter Xu

