Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE08734307
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 20:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234690AbjFQS0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 14:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbjFQS0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 14:26:35 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A72E1BDB
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 11:26:19 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6b46831fd13so131099a34.3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 11:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687026378; x=1689618378;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iAOhlvHTcWXeb9PboEkspmfVbcV594RGj9F/z1tmu4Y=;
        b=DWYFOewOzfcxwUvqtdocgz991WeelZUqOziEmq3Yr1OOBIRlZZZ0Nnzb7tGqJ+WhvZ
         UKCDxM4SD0iyTQC2LQPSnoYvHqvPTSbhi2EpJHXBZuN+zWmtNPGy3z37fgO+DDMDjTO6
         SsSJ0BxgCV29PYyve4O/PEa5snOgcrgclkBGg4yovHC0pfal5ILNoTh3nawLfqGzUdQl
         mBbAvMYXthloGbzpjwO/+YL0LBMR4Gvzvi+hCsHsuXi6jbWx8BJ/9wTWqC+LfhNfmIEM
         4GI/jnS+Wu8R0TofM1bt19kKhf31PegFr7HOoF+OZLjfbem0CtAKF4ZffGd+zIqmErHc
         2GbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687026378; x=1689618378;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iAOhlvHTcWXeb9PboEkspmfVbcV594RGj9F/z1tmu4Y=;
        b=dSrBb73As7E6N51Tv7V1XO77CZfYGufZw6JimWWU52EQZwfbtu87dZOjA5jaNNyH4F
         cShvdQ/EgsbG7P+bzQYS8bHkJRtUa3yWaVRmVg3DceBbjm4X0mKkCrw0QSoJkUFE83IB
         CKDEGY7jrQ9/SnbWdzPasF1Yclqb3BsytRG1WV35i3O+GpNuqDMpp3j7qzzo7sOH7NI3
         pP0cyCGDwWDoBv3qDhcPG4waC02gC2281zN+M1B3ttRiNj7zh/HqZ9WSE+kB6YWL78Tq
         DTX7Ghv4MMAj1uHa8n90HoAuev0B4SPerym+xUugo3nHp0sZ8AitHLkXyzmcq8ONB1H7
         cetQ==
X-Gm-Message-State: AC+VfDwcQ7tWZ13uIBuBWHxCKQaOt9KTPeKn+5Wtc/gh1z6/lPauIjgE
        N1dFfxw5Twm4cBnx07XnYcw=
X-Google-Smtp-Source: ACHHUZ56YUUTSc04n4jtBmXQunTwc6aTvQHQknF6ljrYQVzDoYqxNZifQoRcL1NlfF1RF9LJPzbkNw==
X-Received: by 2002:a05:6359:c1e:b0:12b:dd43:b0a5 with SMTP id gn30-20020a0563590c1e00b0012bdd43b0a5mr2815690rwb.24.1687026378312;
        Sat, 17 Jun 2023 11:26:18 -0700 (PDT)
Received: from sumitra.com ([117.199.158.52])
        by smtp.gmail.com with ESMTPSA id ik26-20020a170902ab1a00b001b20dc1b3c9sm1646501plb.200.2023.06.17.11.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jun 2023 11:26:17 -0700 (PDT)
Date:   Sat, 17 Jun 2023 11:26:09 -0700
From:   Sumitra Sharma <sumitraartsy@gmail.com>
To:     Thomas =?iso-8859-1?Q?Hellstr=F6m_=28Intel=29?= 
        <thomas_os@shipmail.org>
Cc:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Deepak R Varma <drv@mailo.com>,
        Fabio <fmdefrancesco@gmail.com>,
        Thomas Hellstrom <thomas.hellstrom@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        Sumitra Sharma <sumitraartsy@gmail.com>
Subject: Re: [Intel-gfx] [PATCH] drm/i915: Call page_address() on page
 acquired with GFP_KERNEL flag
Message-ID: <20230617182609.GA410998@sumitra.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <69d7af2f-f4c2-5a7d-ce69-c38be5660c74@shipmail.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, Jun 14, 2023 at 05:30:25PM +0200, Thomas Hellström (Intel) wrote:
> 
> On 6/14/23 15:22, Tvrtko Ursulin wrote:
> > 
> > On 14/06/2023 13:35, Sumitra Sharma wrote:
> > > Pages allocated with GFP_KERNEL cannot come from Highmem.
> > > That is why there is no need to call kmap() on them.
> > 
> > Are you sure it is GFP_KERNEL backed and not tmpfs? I am not sure myself
> > so let me copy Matt and Thomas if they happen to know off hand.
>

Hello,

Yes it is true that the pages have not been acquired using the GFP_KERNEL.

I confused the allocation of the struct 'i915_vma_resource' tracking the 
pages with the allocation of the pages themselves.

This was noted by my mentor Ira Weiny <ira.weiny@intel.com>.

> It looks to me these are shmem pages or TTM pages. Both could be highmem. So
> I think kmap is the correct choice here.
> 

However, the kmap() will not be the correct choice here and kmap_local_page()
must be used instead. I have created a v2 patch for the same
https://lore.kernel.org/lkml/20230617180420.GA410966@sumitra.com/

Thank you for helping me.

Regards
Sumitra

> /Thomas
>
> 
> 
> 
> > 
> > Regards,
> > 
> > Tvrtko
> > 
> > > Therefore, don't call kmap() on the page coming from
> > > vma_res->bi.pages using for_each_sgt_page() in
> > > i915_vma_coredump_create().
> > > 
> > > Use a plain page_address() to get the kernel address instead.
> > > 
> > > Signed-off-by: Sumitra Sharma <sumitraartsy@gmail.com>
> > > ---
> > >   drivers/gpu/drm/i915/i915_gpu_error.c | 3 +--
> > >   1 file changed, 1 insertion(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/i915/i915_gpu_error.c
> > > b/drivers/gpu/drm/i915/i915_gpu_error.c
> > > index f020c0086fbc..6f51cb4fc55c 100644
> > > --- a/drivers/gpu/drm/i915/i915_gpu_error.c
> > > +++ b/drivers/gpu/drm/i915/i915_gpu_error.c
> > > @@ -1164,9 +1164,8 @@ i915_vma_coredump_create(const struct intel_gt
> > > *gt,
> > >                 drm_clflush_pages(&page, 1);
> > >   -            s = kmap(page);
> > > +            s = page_address(page);
> > >               ret = compress_page(compress, s, dst, false);
> > > -            kunmap(page);
> > >                 drm_clflush_pages(&page, 1);
