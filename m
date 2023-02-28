Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED8A46A60EE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 22:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjB1VIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 16:08:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjB1VIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 16:08:05 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688188A6E
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 13:08:04 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id z6so12246473qtv.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 13:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677618483;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XrTkPkZkw/0rszifswppJiV3UUqdBojElA8azL6bV4g=;
        b=LKz9vk4sEfto1Nq1L/+2Rd50Syw+DCzYCP7cEpxMagAp+GU+k7zv993ZEmxmvjQ5Mx
         bGLusjNGzJI0rmzwuXZsdQ6yCqvjM97UAzvHi7YNoWvh/4pGxsLQwYVarDRtlBJC45Xq
         fy++Aax/BLW8GqHestXB09RxUKTikSmCcXiCowwZR2ytAqTYOHfNXE+smUS9yjyW4Ivf
         lZe2ds9ofj8zwJw4/kBcM6YMJHJQq10ms9HPV/dHEnbd/6g5k6s1z7qL2pRUegwOQkd/
         7f9TH/8lI4p1wQLDH4Vfm6mdfH5eaw8NWbAigb8H86vAz/lS0T3kH557WjwaUxCgyfGd
         jMXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677618483;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XrTkPkZkw/0rszifswppJiV3UUqdBojElA8azL6bV4g=;
        b=wqc0o6rbdQZT+npB3V5EZNWlLrU0h/2hk3uqYSwzraL96WdAs9Fw01I/HkXin8PB+f
         A9bnSXEeqx9CTR7L2OzzaJYM13ijUDKER1avhggmGP7f9ExxnX2tEZDgaZgabdjk+IHm
         JUIs2i8JsEHjAOi3ASa0aLIWBKarlYBJGDsWH+gfeXNQh0AFaZ3syezyCRZDTsN4BBY2
         rmA6xmp3W1QAPa2X/m/ZlE6OK6vOHLt8PbZIn0kRdm3j0dr2UaYla0lfdRlBEZSGVgFX
         16F/HAahXUrXW20/CHZ1Rkc0g1xsMVAEJZRrx/mHWDn7A+Glq6Cvn9qObBr+u8broS0f
         eoCQ==
X-Gm-Message-State: AO0yUKUH88aSE1CcJh7EOoSM1fHhjiAzTuHVsglRazjT9rsPQpn8oeiG
        rZwJS7Ei3tZ5nx/sQeARuWI5Aw==
X-Google-Smtp-Source: AK7set+6aLyPMkD7xe29+p60VT/myxoeCyqKiL1h6WPHDNFq05JHuLlu+LV3Cb9C/IVZ+9WPTNr1dA==
X-Received: by 2002:ac8:7d8a:0:b0:3bf:e796:bfdd with SMTP id c10-20020ac87d8a000000b003bfe796bfddmr6686616qtd.9.1677618483404;
        Tue, 28 Feb 2023 13:08:03 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id g128-20020a37b686000000b007419f1561fesm7352678qkf.112.2023.02.28.13.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 13:08:02 -0800 (PST)
Date:   Tue, 28 Feb 2023 13:07:41 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     "Huang, Ying" <ying.huang@intel.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, "Xu, Pengfei" <pengfei.xu@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Stefan Roesch <shr@devkernel.io>, Tejun Heo <tj@kernel.org>,
        Xin Hao <xhao@linux.alibaba.com>, Zi Yan <ziy@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH 1/3] migrate_pages: fix deadlock in batched migration
In-Reply-To: <87h6v6b6er.fsf@yhuang6-desk2.ccr.corp.intel.com>
Message-ID: <da5ba36a-dba-f44-926a-c5c912148b@google.com>
References: <20230224141145.96814-1-ying.huang@intel.com> <20230224141145.96814-2-ying.huang@intel.com> <ea4dc95a-e6b2-ff6-62df-1590b93269f@google.com> <87h6v6b6er.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Tue, 28 Feb 2023, Huang, Ying wrote:
> Hugh Dickins <hughd@google.com> writes:
> > On Fri, 24 Feb 2023, Huang Ying wrote:
> >> @@ -1247,7 +1236,7 @@ static int migrate_folio_unmap(new_page_t get_new_page, free_page_t put_new_page
> >>  		/* Establish migration ptes */
> >>  		VM_BUG_ON_FOLIO(folio_test_anon(src) &&
> >>  			       !folio_test_ksm(src) && !anon_vma, src);
> >> -		try_to_migrate(src, TTU_BATCH_FLUSH);
> >> +		try_to_migrate(src, mode == MIGRATE_ASYNC ? TTU_BATCH_FLUSH : 0);
> >
> > Why that change, I wonder? The TTU_BATCH_FLUSH can still be useful for
> > gathering multiple cross-CPU TLB flushes into one, even when it's only
> > a single page in the batch.
> 
> Firstly, I would have thought that we have no opportunities to batch the
> TLB flushing now.  But as you pointed out, it is still possible to batch
> if mapcount > 1.  Secondly, without TTU_BATCH_FLUSH, we may flush the
> TLB for a single page (with invlpg instruction), otherwise, we will
> flush the TLB for all pages.  The former is faster and will not
> influence other TLB entries of the process.
> 
> Or we use TTU_BATCH_FLUSH only if mapcount > 1?

I had not thought at all of the "invlpg" advantage (which I imagine
some other architectures than x86 share) to not delaying the TLB flush
of a single PTE.

Frankly, I just don't have any feeling for the tradeoff between
multiple remote invlpgs versus one remote batched TLB flush of all.
Which presumably depends on number of CPUs, size of TLBs, etc etc.

Your "mapcount > 1" idea might be good, but I cannot tell: I'd say
now that there's no reason to change your "mode == MIGRATE_ASYNC ?
TTU_BATCH_FLUSH : 0" without much more thought, or a quick insight
from someone else.  Some other time maybe.

Hugh
