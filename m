Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9F06B81CC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 20:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjCMTlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 15:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjCMTlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 15:41:13 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC9C7FD44
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 12:41:11 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id bg16-20020a05600c3c9000b003eb34e21bdfso11727280wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 12:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678736470;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kDHoNTYRuPYjRiZwfgC2w8CcgH54J2Q5EIBdARM+oCs=;
        b=WG5pBvPYaNCjjDwtZhJYZGmaoF5Ny5BQy6Q0w2tuyxdosHjqXxzz9N2KtYfxkEKHda
         bm6vOO2777IPYEQXY6u/tySVgYXKB5XWGqyGrEfaaNwj6VdrEYBmxZn/pwgiraxmm0Cr
         SBmkBACdsWLyQynkKWUszIZ7ltl0Npmd/o/tqhH+c6I9LdmPHm2c2PHNWm8PD1wioYNP
         5d87KJwG9qTMslXHhmeNSxuvx1DJUKZRG1zYBASthmByI5J70Mvx/ra1G8y/7Vo/R4pe
         kCu0gYG5YCqtdimuPkVxcwR3pXYtIE0+D+UBiu+ZjsYoTDkgB1gwi6fF+enZ5gvLZXXW
         ZmHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678736470;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kDHoNTYRuPYjRiZwfgC2w8CcgH54J2Q5EIBdARM+oCs=;
        b=IZ/orZeoUIAJrkm5/NP1cCaugxVXjOvsDdRCkwI9HsRj+zIIizQ2klw5zEae30srPd
         I1a64tx04nM27DJ5e9l4Gfq7xCOcweUOQOyEoE5VtoL84FSKIFJNcho4oAGtVxirRei7
         G5hlAE5nGgooSRqR+KyfBewR9KegXlb+0x5fJURYdMcMwqnpkqi6tf9F+x8EQRhVmVO/
         XxOdJ2FVczUXB9qXijXuonNEeTIWAWykVrAJRlNAp8SAc7CNHYoiXKn9mTH2kTL7+Uii
         fzIZS73pfzA9HSeP70yb/R0hoklvhKTxPiTk6WrfqvMZdMHHeT5A8MLOVZQs8QIeHSbM
         l1+w==
X-Gm-Message-State: AO0yUKUMwH7D4USxKsmsxy53ZA3H+tZOX0Ch0kVM/jNZbTOm3ZciqBfv
        UYBTHAYUc5L79zsEVImdJV0=
X-Google-Smtp-Source: AK7set/Cb4iH1IKwtyGpCNnEPAGk9kmpHLpbX4q9NnLiWUOQVqEje7GnNxwgOvhHQra3m/ty24H0zw==
X-Received: by 2002:a05:600c:4e8e:b0:3e0:1a9:b1d7 with SMTP id f14-20020a05600c4e8e00b003e001a9b1d7mr12100047wmq.19.1678736470047;
        Mon, 13 Mar 2023 12:41:10 -0700 (PDT)
Received: from localhost (host86-146-209-214.range86-146.btcentralplus.com. [86.146.209.214])
        by smtp.gmail.com with ESMTPSA id a16-20020a056000101000b002c54e26bca5sm275557wrx.49.2023.03.13.12.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 12:41:09 -0700 (PDT)
Date:   Mon, 13 Mar 2023 19:38:58 +0000
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 3/3] drm/ttm: Remove comment referencing now-removed
 vmf_insert_mixed_prot()
Message-ID: <f7c5bd29-18e5-4eed-8a13-c84d4b9c4874@lucifer.local>
References: <cover.1678661628.git.lstoakes@gmail.com>
 <db403b3622b94a87bd93528cc1d6b44ae88adcdd.1678661628.git.lstoakes@gmail.com>
 <58224a49-654f-0026-4286-c6103d2057dc@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <58224a49-654f-0026-4286-c6103d2057dc@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 08:47:21AM +0100, Christian König wrote:
> Am 13.03.23 um 00:40 schrieb Lorenzo Stoakes:
> > This function no longer exists, however the prot != vma->vm_page_prot case
> > discussion has been retained and moved to vmf_insert_pfn_prot() so refer to
> > this instead.
> >
> > Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
>
> Reviewed-by: Christian König <christian.koenig@amd.com>
>
> Feel free to add my acked-by to the other two patches in the series and
> upstream through any branch you like.
>
> Alternatively ping me when you get rbs for the first two patches from the MM
> people and I can push this upstream through drm-misc.
>
> Thanks,
> Christian.

Thanks, much appreciated! I'd rather go through mm if possible as Andrew has
already taken for mm-unstable pending further review + that's easiest for
dealing with any mm feedback.

P.S. apologies for dropping the umlaut on your name in initial patch, I really
need to sort out my terminal which got horribly confused by non-ANSI characters :)

>
> > ---
> >   drivers/gpu/drm/ttm/ttm_bo_vm.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/ttm_bo_vm.c
> > index ca7744b852f5..5df3edadb808 100644
> > --- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
> > +++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
> > @@ -254,7 +254,7 @@ vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
> >   		 * encryption bits. This is because the exact location of the
> >   		 * data may not be known at mmap() time and may also change
> >   		 * at arbitrary times while the data is mmap'ed.
> > -		 * See vmf_insert_mixed_prot() for a discussion.
> > +		 * See vmf_insert_pfn_prot() for a discussion.
> >   		 */
> >   		ret = vmf_insert_pfn_prot(vma, address, pfn, prot);
>
