Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 159C263D994
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 16:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiK3PiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 10:38:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiK3PiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 10:38:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471FF48422
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 07:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669822639;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KkCbDmPSlV3ED2kYMn/nY2F1Zfm2btT/2SFqyr4HySI=;
        b=AFtbxk8CudMVEKrw0b99AEFs236JyaEYDyuaolixaAwxS9O7MB8iKbD05xttUCLEhgwIM5
        y8v08aOXZOCd+fsJaKYWNgEUierKyIEfoXP15VQmPfJ9V8I+8XQ4abt7lcGf4aqEy9jjqy
        3wiwUlPIAZsAwHVn2vCQ9mwOQKLu2qM=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-652-Gf2ETivNOruT5u87QYl2OQ-1; Wed, 30 Nov 2022 10:37:17 -0500
X-MC-Unique: Gf2ETivNOruT5u87QYl2OQ-1
Received: by mail-qk1-f200.google.com with SMTP id az31-20020a05620a171f00b006fa2cc1b0bfso40672466qkb.23
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 07:37:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KkCbDmPSlV3ED2kYMn/nY2F1Zfm2btT/2SFqyr4HySI=;
        b=lUIBR7tgxK4i6UE9dl+2E0csOEkPyY9JwUSTMTzfL2+p6AjLOuheTJsqIufa057zlx
         Qnrj4EXmYBuJT0650QKvGN7iJQw9lq0Ylo6avJvGcn1sfisPTuiUfwE8LLQj7m+UvZ2k
         M8OG3VqWWHZzXI6QUCu/kvpXpvUl3o1RK+RdeNNkpye1Iym+pRUy96cWPQ/tLQiWs0cm
         9e3hU6X17yfPzVJzA1pccLx9SORp5TmmG82xtrKZc+OnsFSafRKqYzoUn3FGrWdWipH7
         SGmK59uhGOJw1ncWhm4tmI1uHh+zzFLP15uRSoWQH/TOSrXIFT4Fp2afgeMbB1kWn3yw
         PdAQ==
X-Gm-Message-State: ANoB5pmGtXr6jo3VvbHXIGFh9MUgm3JDSYJlbRk5RXeGWs1HOYKDMEmu
        4XCefiOOXyXvZUKlxnvfbfw2fwbZo988VD18YT+efhO+EvwdGunfGaLvqUpiPzBmnejaDNb02+w
        RNfl6T9gJOSYEgusso5rY5f0E
X-Received: by 2002:a0c:fdea:0:b0:4b3:fd4b:e86e with SMTP id m10-20020a0cfdea000000b004b3fd4be86emr39065959qvu.109.1669822636849;
        Wed, 30 Nov 2022 07:37:16 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6P5HJ+dItim/tVlZkLVf1jiPTB+2nXKLau8ou1fOB71h9KeP0G98ZIH2C6XFsEXY8UI753oA==
X-Received: by 2002:a0c:fdea:0:b0:4b3:fd4b:e86e with SMTP id m10-20020a0cfdea000000b004b3fd4be86emr39065940qvu.109.1669822636603;
        Wed, 30 Nov 2022 07:37:16 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id z26-20020ac87cba000000b003a586888a20sm977387qtv.79.2022.11.30.07.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 07:37:15 -0800 (PST)
Date:   Wed, 30 Nov 2022 10:37:14 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        James Houghton <jthoughton@google.com>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 10/10] mm/hugetlb: Introduce hugetlb_walk()
Message-ID: <Y4d4qh0ACmo455Nj@x1n>
References: <20221129193526.3588187-1-peterx@redhat.com>
 <20221129193526.3588187-11-peterx@redhat.com>
 <Y4bnkO3ikp5bu44x@sol.localdomain>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="oQiZbfNmI500Ok+U"
Content-Disposition: inline
In-Reply-To: <Y4bnkO3ikp5bu44x@sol.localdomain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oQiZbfNmI500Ok+U
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Tue, Nov 29, 2022 at 09:18:08PM -0800, Eric Biggers wrote:
> On Tue, Nov 29, 2022 at 02:35:26PM -0500, Peter Xu wrote:
> > +static inline pte_t *
> > +hugetlb_walk(struct vm_area_struct *vma, unsigned long addr, unsigned long sz)
> > +{
> > +#if defined(CONFIG_ARCH_WANT_HUGE_PMD_SHARE) && defined(CONFIG_LOCKDEP)
> > +	struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
> > +
> > +	/*
> > +	 * If pmd sharing possible, locking needed to safely walk the
> > +	 * hugetlb pgtables.  More information can be found at the comment
> > +	 * above huge_pte_offset() in the same file.
> > +	 *
> > +	 * NOTE: lockdep_is_held() is only defined with CONFIG_LOCKDEP.
> > +	 */
> > +	if (__vma_shareable_flags_pmd(vma))
> > +		WARN_ON_ONCE(!lockdep_is_held(&vma_lock->rw_sema) &&
> > +			     !lockdep_is_held(
> > +				 &vma->vm_file->f_mapping->i_mmap_rwsem));
> > +#endif
> 
> FYI, in next-20221130 there is a compile error here due to this commit:
> 
>     In file included from security/commoncap.c:19:
>     ./include/linux/hugetlb.h:1262:42: error: incomplete definition of type 'struct hugetlb_vma_lock'
>                     WARN_ON_ONCE(!lockdep_is_held(&vma_lock->rw_sema) &&
>                                                    ~~~~~~~~^
>     ./include/linux/lockdep.h:286:47: note: expanded from macro 'lockdep_is_held'
>     #define lockdep_is_held(lock)           lock_is_held(&(lock)->dep_map)
>                                                            ^~~~

This probably means the config has:

  CONFIG_HUGETLB_PAGE=n
  CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y

And I'm surprised we didn't have a dependency that ARCH_WANT_HUGE_PMD_SHARE
should depend on HUGETLB_PAGE already.  Mike, what do you think?

I've also attached a quick fix for this patch to be squashed in.  Hope it
works.

Thanks,

-- 
Peter Xu

--oQiZbfNmI500Ok+U
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment;
	filename="0001-fixup-mm-hugetlb-Introduce-hugetlb_walk.patch"

From 9787a7f5492ca251fcce5c09bd7e4a80ac157726 Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Wed, 30 Nov 2022 10:33:44 -0500
Subject: [PATCH] fixup! mm/hugetlb: Introduce hugetlb_walk()
Content-type: text/plain

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/hugetlb.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 1a51c45fdf2e..ec2a1f93b12d 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -1248,7 +1248,8 @@ __vma_shareable_flags_pmd(struct vm_area_struct *vma)
 static inline pte_t *
 hugetlb_walk(struct vm_area_struct *vma, unsigned long addr, unsigned long sz)
 {
-#if defined(CONFIG_ARCH_WANT_HUGE_PMD_SHARE) && defined(CONFIG_LOCKDEP)
+#if defined(CONFIG_HUGETLB_PAGE) && \
+	defined(CONFIG_ARCH_WANT_HUGE_PMD_SHARE) && defined(CONFIG_LOCKDEP)
 	struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
 
 	/*
-- 
2.37.3


--oQiZbfNmI500Ok+U--

