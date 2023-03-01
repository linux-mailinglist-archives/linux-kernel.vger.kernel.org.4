Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B78056A687C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 08:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjCAH5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 02:57:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjCAH5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 02:57:06 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A6E301BA
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 23:57:04 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 132so7181329pgh.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 23:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=02i/96l+6ZpFW/jZZDtc8h7hh0YgTsgKHKNNUB9KLxs=;
        b=HoExU3YgBTtCAOk4N3KNsm5T7YL0gsxHB+lFf+mZSLfkrK85VG9LggoYxTRQ7rmz3C
         84wDtDndx7u6dPFMDzMci7J3dRlBhYLD8p7N4cxJltqr/l1/LoOkET1w1jfz44lRpmD+
         yjoxbqJkFS4i5IjCuDQNDys+LCXBL/2vc57zk4yN+L0lKbg8Ah9yDKskfZupSyh1loJC
         KsaYjBt85J5T8JGZBYCSpQuskGBG1DLDhC5oSOhkNwahpLjl8OaJOTjfMCzGUsSW9D71
         ZCflSag2e3UwHVjDC9ICqaiE+cYlCvCSRx09vaQVoWJazHBdCrB1RDzuiRfMPxmpmRKL
         GbRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=02i/96l+6ZpFW/jZZDtc8h7hh0YgTsgKHKNNUB9KLxs=;
        b=tm2s/Sa7g5pOs5gyabsj2gs7h6O1stDKFBwCHA+1LntX9KZOfqu4wxGTqDsE1a85lL
         +rVq4yJG52UhyGLNhLXFKqRPC52x2UY5jWh6DDML2K5GAGwz2kKiuuNtygxJItwJYL01
         uDsaMDDTmyiHwe+n/NKZFst0GH2rth8Fa6RcyUhUnTQhiYC5aEFWn4Fydwaq1lJNA44T
         BkGapgYwZa2zYsBQSBmM5TNvb+WYxSsDZ9cLy3CT8Zf5uLD+pxlxGu7vvooxmbV+sem/
         0Ft300AqMm18JBlD8QtRvs8XGx7UQZ3mF69rn4ECffVJ8Pd6KTiFE91yOAjRieD8aAUb
         wMsw==
X-Gm-Message-State: AO0yUKX3abx+6rmUM33TAb8fsq5fPqZeoBkGEhGK8jDfSBgJXtrtOky7
        +3rjWoHEe+7MKL1taTM7cQ4=
X-Google-Smtp-Source: AK7set9latmKg0SRlfW2C2EjdWRe42leQ/wjfKxC33I4XmpzAO3T0+sqRBSfcTT2+0oY4xU3klbfEA==
X-Received: by 2002:a62:1dc6:0:b0:5e0:316a:39ce with SMTP id d189-20020a621dc6000000b005e0316a39cemr5569689pfd.27.1677657424046;
        Tue, 28 Feb 2023 23:57:04 -0800 (PST)
Received: from localhost ([2400:8902::f03c:93ff:fe27:642a])
        by smtp.gmail.com with ESMTPSA id bm17-20020a056a00321100b005a852875590sm7266765pfb.113.2023.02.28.23.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 23:56:51 -0800 (PST)
Date:   Wed, 1 Mar 2023 07:56:36 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@techsingularity.net, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, paulmck@kernel.org, mingo@redhat.com,
        will@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, david@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com, chriscli@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        rppt@kernel.org, jannh@google.com, shakeelb@google.com,
        tatashin@google.com, edumazet@google.com, gthelen@google.com,
        gurua@google.com, arjunroy@google.com, soheil@google.com,
        leewalsh@google.com, posk@google.com,
        michalechner92@googlemail.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v4 18/33] mm: write-lock VMAs before removing them from
 VMA tree
Message-ID: <Y/8FNM9czzPHb5eG@localhost>
References: <20230227173632.3292573-1-surenb@google.com>
 <20230227173632.3292573-19-surenb@google.com>
 <Y/8CJQGNuMUTdLwP@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/8CJQGNuMUTdLwP@localhost>
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2023 at 07:43:33AM +0000, Hyeonggon Yoo wrote:
> On Mon, Feb 27, 2023 at 09:36:17AM -0800, Suren Baghdasaryan wrote:
> > Write-locking VMAs before isolating them ensures that page fault
> > handlers don't operate on isolated VMAs.
> > 
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  mm/mmap.c  | 1 +
> >  mm/nommu.c | 5 +++++
> >  2 files changed, 6 insertions(+)
> > 
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 1f42b9a52b9b..f7ed357056c4 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -2255,6 +2255,7 @@ int split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
> >  static inline int munmap_sidetree(struct vm_area_struct *vma,
> >  				   struct ma_state *mas_detach)
> >  {
> > +	vma_start_write(vma);
> >  	mas_set_range(mas_detach, vma->vm_start, vma->vm_end - 1);
> 
> I may be missing something, but have few questions:
> 
> 	1) Why does a writer need to both write-lock a VMA and mark the VMA detached
> 	   when unmapping it, isn't it enough to just only write-lock a VMA?
> 
> 	2) as VMAs that are going to be removed are already locked in vma_prepare(),
> 	   so I think this hunk could be dropped?

After sending this just realized that I did not consider simple munmap case :)
But I still think 1) and 3) are valid question.

> 
> >  	if (mas_store_gfp(mas_detach, vma, GFP_KERNEL))
> >  		return -ENOMEM;
> > diff --git a/mm/nommu.c b/mm/nommu.c
> > index 57ba243c6a37..2ab162d773e2 100644
> > --- a/mm/nommu.c
> > +++ b/mm/nommu.c
> > @@ -588,6 +588,7 @@ static int delete_vma_from_mm(struct vm_area_struct *vma)
> >  		       current->pid);
> >  		return -ENOMEM;
> >  	}
> > +	vma_start_write(vma);
> >  	cleanup_vma_from_mm(vma);
> 
> 	3) I think this hunk could be dropped as Per-VMA lock depends on MMU anyway.
> 
> Thanks,
> Hyeonggon
> 
> >  
> >  	/* remove from the MM's tree and list */
> > @@ -1519,6 +1520,10 @@ void exit_mmap(struct mm_struct *mm)
> >  	 */
> >  	mmap_write_lock(mm);
> >  	for_each_vma(vmi, vma) {
> > +		/*
> > +		 * No need to lock VMA because this is the only mm user and no
> > +		 * page fault handled can race with it.
> > +		 */
> >  		cleanup_vma_from_mm(vma);
> >  		delete_vma(mm, vma);
> >  		cond_resched();
> > -- 
> > 2.39.2.722.g9855ee24e9-goog
> > 
> > 
> 
