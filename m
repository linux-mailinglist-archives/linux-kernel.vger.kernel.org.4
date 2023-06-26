Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 404B573EBEE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 22:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjFZUlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 16:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjFZUl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 16:41:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2282BE53
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 13:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687812040;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ev54ExPXzaNvJTg8/MBf9yolJcrgbZXoUayWT02Jx5E=;
        b=fSEUDK78vV0WmKR09itECnWKRiXQxjQvBBcYDmNKEqQp7DbvTTWEqq/4pfmqNM6i4JCCX4
        7URHUcD064SZdaiTuK0E6geWtjIPqkQAXCKvu0Ug9+eYrD5Zi7icpWeB/jMm/j3afZWOJD
        RRE6USDclkaD0eorp0gsuU5i3cdTPa0=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-xfrW-VzhPGmLIV1Ym8u26w-1; Mon, 26 Jun 2023 16:40:39 -0400
X-MC-Unique: xfrW-VzhPGmLIV1Ym8u26w-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-3f9e7a1caf2so12421431cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 13:40:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687812038; x=1690404038;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ev54ExPXzaNvJTg8/MBf9yolJcrgbZXoUayWT02Jx5E=;
        b=eZ8d9ayMMmIjXf2izSxnMkzgqk28e7r69f7XSv5tXd9nb2HnlNNwNw7y6d/i8XpD3S
         D8Rp2b3rKe8U5Gr5ImgY3Sol6Ic8dK0uLJj+7kVeTzERfZjGIFT/sE2E0dp0fuCCEr3d
         CDZFUaZOx3aDAUxWoSACSf16j6agZMssK2nZeMhcdmxa3qLnS/OyPD2S8Y7By/4mItAq
         RsX7oxIXfTABOqH8VDKrj4tO3bMReCLkVi4tJi9knZ2ZGINsV4thN+DJ4+c+YwTzbrlz
         TIUbtUwlABCgW27/gWWCYnXnzj2xPu8ydwCN0AXWCCRaMEXl4K37Y6wyMPDZfGdM0WgZ
         PBUA==
X-Gm-Message-State: AC+VfDwCVMrl0AuFe0+31qvnxAHeeYmrR2sHt2S15TZbUJAftFOKme5P
        8/5DyHVp6KuSHqUmVzwiB24TnKfzYSVZalIWJ1l77xetxUECSPZJzIWjz+HYic11klWPyCOJ568
        H/h6orHseH6CwhEaYZlxdmHVS
X-Received: by 2002:a05:6214:401a:b0:62b:5410:322d with SMTP id kd26-20020a056214401a00b0062b5410322dmr38030176qvb.6.1687812037925;
        Mon, 26 Jun 2023 13:40:37 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6Dtb63C7KvmjXbiTlKTAOd4PeeO3zkzCwG3AgPJj8QsyFnRHiYIK3DBwF3XpzBiJbIWbFn2g==
X-Received: by 2002:a05:6214:401a:b0:62b:5410:322d with SMTP id kd26-20020a056214401a00b0062b5410322dmr38030157qvb.6.1687812037679;
        Mon, 26 Jun 2023 13:40:37 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id a17-20020a0ccdd1000000b005dd8b9345b4sm3512551qvn.76.2023.06.26.13.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 13:40:37 -0700 (PDT)
Date:   Mon, 26 Jun 2023 16:40:36 -0400
From:   Peter Xu <peterx@redhat.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Lorenzo Stoakes <lstoakes@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        James Houghton <jthoughton@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v3 7/8] selftests/mm: Add -a to run_vmtests.sh
Message-ID: <ZJn3xAS151RwcGJg@x1n>
References: <20230623142936.268456-1-peterx@redhat.com>
 <20230623142936.268456-8-peterx@redhat.com>
 <1f81260b-f569-87b9-a100-f6cd65ee5a5f@redhat.com>
 <ZJm7rzfCwtw7AnC4@x1n>
 <29f9a86d-8ee7-5e54-2979-c5fd3b6fbe2d@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <29f9a86d-8ee7-5e54-2979-c5fd3b6fbe2d@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 01:24:45PM -0700, John Hubbard wrote:
> On 6/26/23 09:24, Peter Xu wrote:
> > On Mon, Jun 26, 2023 at 10:10:26AM +0200, David Hildenbrand wrote:
> > > On 23.06.23 16:29, Peter Xu wrote:
> > > > Allows to specify optional tests in run_vmtests.sh, where we can run time
> > > > consuming test matrix only when user specified "-a".
> > > 
> > > I'd have used something like "-e: extended tests that might be more
> > > time-consuming".
> > 
> > '-a' stands for "all" here, I worry '-e' may be misread into running "extra
> > tests only".
> > 
> 
> It's getting to the point where long options would help. This one
> could be "--stress-tests" or "--all", or "--include-long-running",
> for example.
> 
> I hesitate to suggest it because it's extra work, but at some point
> it would be nice. The options are already hopelessly un-guessable.

Thanks for being considerate, John.  Yes I do hope this series can converge
soon, indeed hopefully any further test patches can be worked on top.

To me I would be fine with either option (-a/-e), as long as there's easy
way to dump a help message, where "run_vmtest.sh -h" works for me always.

What's more "hopeless" along my way as an user is there's no help message
for gup_test.c even though its parameter list is crazily long.  I used to
"convince" myself that gup is just so special so someone should just
understand what option goes to what ioctl, better read into the .c file.
But I know that's an excuse.

Thanks,

-- 
Peter Xu

