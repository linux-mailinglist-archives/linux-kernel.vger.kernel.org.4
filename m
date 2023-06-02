Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72085720C06
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 00:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236567AbjFBWjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 18:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234960AbjFBWjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 18:39:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41DC21BC
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 15:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685745513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oR1X1ew3x0HcJtcEhJmoN8Cw49Yjt6Fdc1YyTgyzmkA=;
        b=NSF7Qyc9yDQIMQ6Ek+N7TBhFAs0uL3fOA3sbAMzywiJHJ1UF8YSpA3emQpS2hPBg7qxaVK
        Hj0pJWz1xRZ6bdHTzq0xRuG24fF7kuFJp4VuJaME6v4UZXJ3pjYUymllRws6IGkqVTRtGE
        V2THc03NyRxi7wsAJovjaH1YL7cGY9s=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-Kw4ngPf0Me-1N-0LU2gQAw-1; Fri, 02 Jun 2023 18:38:32 -0400
X-MC-Unique: Kw4ngPf0Me-1N-0LU2gQAw-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-62632620f00so2998476d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 15:38:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685745511; x=1688337511;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oR1X1ew3x0HcJtcEhJmoN8Cw49Yjt6Fdc1YyTgyzmkA=;
        b=A3rSisifhqa1mmBKkJLiyV8fR8pdn6ZL/PNv8r0EBJiDSqQ2UGU2fO7IgtgAk64ubR
         D40S2HVvUW0SIrO/LS5N/dHrlD7ReV+crOilSv3xVOOgxvPexqw8sEReS+cbyAAqL/Iz
         PxTJ/GG7MV9W6o7/leX7Nfntl/jJPIkDGjPY2yNFBaJ5/LOeDdS583v6ZvZl85xAvp8r
         4zYVtgwTj0dTJTyRkoaa0e42xF/adjuCaWhu5j9cmw6gwlpPGgEDTry0VC/nOgC/4Lul
         bEWIuhwCta2f0XwkZLNuR3V9n/dP80gSGfR544PRSTl1zLm6xsD1uagPYIjFNrmhQdTm
         47mA==
X-Gm-Message-State: AC+VfDyENXmD5ItklpsKjo5yxCP4VySJyim0m9xPIt40knAPRgGjnqLM
        9xo/SvMBXWSurVgr3quCL2DBU49Y03mioDCv9r+oKcWtHZ5fRc7QqqUi9+/QJ3BqvUK4fl8gZU4
        DMb0Spq8YSm3/h5RVThPdzpoTC7MX5Mc8
X-Received: by 2002:a05:6214:27c9:b0:624:dcc5:819f with SMTP id ge9-20020a05621427c900b00624dcc5819fmr15407064qvb.1.1685745511421;
        Fri, 02 Jun 2023 15:38:31 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5VLyjLhxGDa0J7wRASxrELVhhJQx7mVt3rBA+n4AUox7ksSWXu86KLUY3aX97s9xRph/GrnQ==
X-Received: by 2002:a05:6214:27c9:b0:624:dcc5:819f with SMTP id ge9-20020a05621427c900b00624dcc5819fmr15407047qvb.1.1685745511171;
        Fri, 02 Jun 2023 15:38:31 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id f19-20020ac84713000000b003f543cbb698sm1317948qtp.23.2023.06.02.15.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 15:38:30 -0700 (PDT)
Date:   Fri, 2 Jun 2023 18:38:29 -0400
From:   Peter Xu <peterx@redhat.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 10/12] selftests/mm: move uffd* routines from vm_util.c
 to uffd-common.c
Message-ID: <ZHpvZcdik7VPsEcL@x1n>
References: <20230602013358.900637-1-jhubbard@nvidia.com>
 <20230602013358.900637-11-jhubbard@nvidia.com>
 <ZHoR+3v+zUENBhi4@x1n>
 <68549f29-fe41-04d4-f648-245f399c350b@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <68549f29-fe41-04d4-f648-245f399c350b@nvidia.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 02, 2023 at 03:11:52PM -0700, John Hubbard wrote:
> On 6/2/23 08:59, Peter Xu wrote:
> > On Thu, Jun 01, 2023 at 06:33:56PM -0700, John Hubbard wrote:
> > > This is where they belong, and this makes it cleaner to apply a
> > > follow-up fix to the uffd builds.
> > > 
> > > Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> > 
> > Thanks for further looking into this.
> > 
> > I'm fine to move it over if you think proper, but just to mention I had
> > those in vm_utils.h just because I left all uffd specific tests shared code
> > in uffd-common.h, so my plan was uffd-common.h shouldn't be included in
> > most test cases except uffd tests.
> 
> I think we're in agreement that we want to only include uffd-common.h
> where it's actually required. Likewise with the uffd*() routines. So I
> would like to still move this over, yes, just to have things in their
> best-named location.

Sorry I didn't get it - e.g. I'm confused why we need to export
uffd_test_ops into ksm unit test, it doesn't make much sense to me..

If you think vm_util.h is a name too common to contain uffd helpers, shall
we create another vm_util_uffd.h just to put the uffd helpers?

Just see what's there in uffd-common.h, which is still ugly (I could look
into it some other day):

extern unsigned long nr_cpus, nr_pages, nr_pages_per_cpu, page_size;
extern char *area_src, *area_src_alias, *area_dst, *area_dst_alias, *area_remap;
extern int uffd, uffd_flags, finished, *pipefd, test_type;
extern bool map_shared;
extern bool test_uffdio_wp;
extern unsigned long long *count_verify;
extern volatile bool test_uffdio_copy_eexist;

extern uffd_test_ops_t anon_uffd_test_ops;
extern uffd_test_ops_t shmem_uffd_test_ops;
extern uffd_test_ops_t hugetlb_uffd_test_ops;
extern uffd_test_ops_t *uffd_test_ops;

and more.

That's why I think this header should not better be included by anyone else
besides uffd-stress.c and uffd-unit-tests.c for now.

> 
> > 
> > I'm not sure whether we can just make your next patch of "ifndef.." into
> > vm_utils.h to avoid the movement, or is it a must?
> > 
> 
> Actually, I think I can drop the next patch entirely, based on
> Muhammad's observation that we should be doing a "make headers"
> to pull in those items. I'll have more to say over on that thread.

Sure, great if the local headers will work.  Thanks.

-- 
Peter Xu

