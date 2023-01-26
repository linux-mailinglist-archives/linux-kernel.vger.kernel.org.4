Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1203367C1F7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 01:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236423AbjAZAuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 19:50:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236399AbjAZAuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 19:50:14 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B324265AA
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 16:50:14 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id b1so270104ybn.11
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 16:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1bhyBo7al6IFmy67jCXlva3rHybPAJSM2yEaUOJQ4lY=;
        b=MtM+z+b219UdUN5lbkQzQQnmyWFomgsL3YuR13gv40KQ7Z6imWKFubK5PpZWnKIy3T
         xfC6X4kZcmtmqwVrzMLVgUxUgYbHpPIUqo4GbeLXH2hwmuacvcRxaK5XCk+38ngUpeRm
         OiyHjmJYgqhNUoWa8Y9RQe+riUKMFsHSMhqvggzBKD7a+b+ApUk4a2ktz0CFkfxjg4XO
         vA75Cr2KDO+xZ7pA2CHHDwW2Dl6J1NE5oBEaYoKraasDQ97TyKgvjajRCl0m6zIxunOG
         97NpIrOCHzHlpx/Qpmmt3dZ0d2w5grPaoLPoSzhBYi81S8YO0KrVcyJiqVyCY35hmVWz
         Uhyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1bhyBo7al6IFmy67jCXlva3rHybPAJSM2yEaUOJQ4lY=;
        b=UpyYvoC27v2HBBEb6h0KjX/IG+N7nnZwE7Xv7+lcxI9Wa04QVIQLSl9L6oelKWJzg3
         6bRfuvZRRraKXYslFm/Qbj7REmWV0nIa7Op4GUhW2JA0Wv6PZbjhdlGA6vCz/SageBH/
         KhC+BbE7PXWRn5B2TiS4WISRpb289AUrhEd0NcUqzemYSTftJfEzHnPjclWKyiOqn1+J
         N5N36erxldVF+ixhIK8N0wKdOSNUis2zCTRG3nvakfEFSAOkcAsu+jN2zB/IWWcC0Flr
         qzcykbhHswwn7WpxZYWdKk/ZT32d20303ZRoZgjcjfUGl5v1q6DgkJBhT2x7215UTvSk
         9ZnQ==
X-Gm-Message-State: AFqh2ko6koySumI1UegNPmk3pFrFm5fUOjeahs9I0mvaco7CBY372pBH
        tlFNCzz5ZNTmr0h+PVwxYMlmXoeLYNlmJZbWeb/hog==
X-Google-Smtp-Source: AMrXdXvTA5PhW5zsIFLrGos4xAsLGsOemtNo62tdUEyPmQhzs2vfsnov8+FaF7brmdc4+MYKWjG1pVrfUgIsQlq4xVw=
X-Received: by 2002:a25:9801:0:b0:7d5:b884:3617 with SMTP id
 a1-20020a259801000000b007d5b8843617mr3047541ybo.380.1674694213026; Wed, 25
 Jan 2023 16:50:13 -0800 (PST)
MIME-Version: 1.0
References: <20230125233554.153109-1-surenb@google.com> <20230125233554.153109-2-surenb@google.com>
 <20230125162159.a66e5ef05fecb405e85ffec9@linux-foundation.org>
In-Reply-To: <20230125162159.a66e5ef05fecb405e85ffec9@linux-foundation.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 25 Jan 2023 16:50:01 -0800
Message-ID: <CAJuCfpG5HyMP3RM1jTJxCnN4WUz4APAcxbkOT48ZtJDXcb3z3w@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] kernel/fork: convert vma assignment to a memcpy
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com, paulmck@kernel.org,
        mingo@redhat.com, will@kernel.org, luto@kernel.org,
        songliubraving@fb.com, peterx@redhat.com, david@redhat.com,
        dhowells@redhat.com, hughd@google.com, bigeasy@linutronix.de,
        kent.overstreet@linux.dev, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        jannh@google.com, shakeelb@google.com, tatashin@google.com,
        edumazet@google.com, gthelen@google.com, gurua@google.com,
        arjunroy@google.com, soheil@google.com, hughlynch@google.com,
        leewalsh@google.com, posk@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
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

On Wed, Jan 25, 2023 at 4:22 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Wed, 25 Jan 2023 15:35:48 -0800 Suren Baghdasaryan <surenb@google.com> wrote:
>
> > Convert vma assignment in vm_area_dup() to a memcpy() to prevent compiler
> > errors when we add a const modifier to vma->vm_flags.
> >
> > ...
> >
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -482,7 +482,7 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
> >                * orig->shared.rb may be modified concurrently, but the clone
> >                * will be reinitialized.
> >                */
> > -             *new = data_race(*orig);
> > +             memcpy(new, orig, sizeof(*new));
>
> The data_race() removal is unchangelogged?

True. I'll add a note in the changelog about that. Ideally I would
like to preserve it but I could not find a way to do that.

>
> >               INIT_LIST_HEAD(&new->anon_vma_chain);
> >               dup_anon_vma_name(orig, new);
> >       }
>
