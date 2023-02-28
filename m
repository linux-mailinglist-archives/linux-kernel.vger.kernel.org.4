Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B496A52C5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 06:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjB1F7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 00:59:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjB1F7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 00:59:35 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F3A1ADC9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 21:59:34 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id c11so7161860oiw.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 21:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677563973;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jLwLNTb6WWaSOQmgH+fKmq+ah1/mTz0fYUzaz0JWEhI=;
        b=fKdLTBQmsXWF4hi32F0onYmpDRUFHMArs1+yBQnwz8Y63NyqIbZJZgk+GtqFAcNR/U
         oO8u83YPQnZv/keE9/fjtR6oZIDlsmJ3T2U6f1jBSNpM+ZVH61YmVQRysPUZ2dhLBgqi
         EXjMDWIZbI+tIfSF62VIBU3pMkPfzv8yuAwRMDgfnaWjASXBYXmlB/zKh2LJOIIOM/Ij
         2EtdWkdzYYgliCnUPlWRWk7ju6hq/eXqS4Za/g543u0aWV1coPJpvQfWjihuV2Fzd6Uq
         swEAOaA4ffWcyTyvXtVmkaRyybC3c5tcUA74+Ykj48o9LsMsjA5lhtpJOZrFtvQwwiVt
         xqVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677563973;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jLwLNTb6WWaSOQmgH+fKmq+ah1/mTz0fYUzaz0JWEhI=;
        b=WD4pZ2Qn7JHe2zAlPBPhGpMFlyh4hCxRw+IJm79nBeFe8u131KMlx6GrhdsBID2chD
         5WfUgWl+lja4JvRSgi3mOWmwj/JQT64HPoGzdxgTGLkRSADRt9nbao6UAENjfrPQcKft
         3LxlxQVuJvMiJag4GBDerrtRk2YwoZOmkOZbEDuXjkcaLbUnKqzKDLgpMCJuVvNs2VmB
         2FbZ3YXmcXC7402AqkhnN4QD4PymYxf83hpZ1DG3ayoAdHXMDs6gt2ghrBNNu+lGuv9R
         lMJOC1YAmI5Aa6ZOS4jMNA9j20SuTufNdH3xRSEw7QjsO0KekWcOCmYQddqv3Pbcje5U
         e3og==
X-Gm-Message-State: AO0yUKXDyd8q0JHaA/OJ8lvonOmTADWTHp84+wLtuZeW0NabpglvBxJ2
        ulmO9nT2ygX78Qpzj1FcwxVq9g==
X-Google-Smtp-Source: AK7set/L7jDr9GHJfIs4WSgKvyphWigdahaYdbtA0Nh6w5RisSSCFHAkVlA+R8Wd3HYYsbjrCvHkzQ==
X-Received: by 2002:aca:1214:0:b0:383:ca99:c70e with SMTP id 20-20020aca1214000000b00383ca99c70emr933488ois.59.1677563973507;
        Mon, 27 Feb 2023 21:59:33 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id r7-20020acaf307000000b00383ef567cfdsm3954400oih.21.2023.02.27.21.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 21:59:29 -0800 (PST)
Date:   Mon, 27 Feb 2023 21:59:17 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     "Huang, Ying" <ying.huang@intel.com>
cc:     Jan Kara <jack@suse.cz>, Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Zi Yan <ziy@nvidia.com>, Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Bharata B Rao <bharata@amd.com>,
        Alistair Popple <apopple@nvidia.com>,
        Xin Hao <xhao@linux.alibaba.com>,
        Minchan Kim <minchan@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: Re: [PATCH -v5 0/9] migrate_pages(): batch TLB flushing
In-Reply-To: <87pm9ubnih.fsf@yhuang6-desk2.ccr.corp.intel.com>
Message-ID: <46f82df2-c925-e3f9-b185-69b3f0b6e366@google.com>
References: <20230213123444.155149-1-ying.huang@intel.com> <87a6c8c-c5c1-67dc-1e32-eb30831d6e3d@google.com> <20230227110614.dngdub2j3exr6dfp@quack3> <87pm9ubnih.fsf@yhuang6-desk2.ccr.corp.intel.com>
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
> Jan Kara <jack@suse.cz> writes:
> > On Fri 17-02-23 13:47:48, Hugh Dickins wrote:
> >> 
> >> Cc'ing Jan Kara, who knows buffer_migrate_folio_norefs() and jbd2
> >> very well, and I hope can assure us that there is an understandable
> >> deadlock here, from holding several random folio locks, then trying
> >> to lock buffers.  Cc'ing fsdevel, because there's a risk that mm
> >> folk think something is safe, when it's not sufficient to cope with
> >> the diversity of filesystems.  I hope nothing more than the below is
> >> needed (and I've had no other problems with the patchset: good job),
> >> but cannot be sure.
> >
> > I suspect it can indeed be caused by the presence of the loop device as
> > Huang Ying has suggested. What filesystems using buffer_heads do is a
> > pattern like:
> >
> > bh = page_buffers(loop device page cache page);
> > lock_buffer(bh);
> > submit_bh(bh);
> > - now on loop dev this ends up doing:
> >   lo_write_bvec()
> >     vfs_iter_write()
> >       ...
> >       folio_lock(backing file folio);
> >
> > So if migration code holds "backing file folio" lock and at the same time
> > waits for 'bh' lock (while trying to migrate loop device page cache page), it
> > is a deadlock.
> >
> > Proposed solution of never waiting for locks in batched mode looks like a
> > sensible one to me...
> 
> Thank you very much for detail explanation!

Yes, thanks a lot, Jan, for elucidating the deadlocks.

I was running with the 1/3,2/3,3/3 series for 48 hours on two machines
at the weekend, and hit no problems with all of them on.

I did try to review them this evening, but there's too much for me to
take in there to give an Acked-by: but I'll ask a couple of questions.

Hugh
