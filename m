Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5B5666224
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 18:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbjAKRjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 12:39:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239124AbjAKRiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 12:38:21 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D4C35904
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 09:36:30 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id c82so8516817ybf.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 09:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CQuivU7tA0j3DaNAmzqNs9rVsYSc4Mupj7zmuVm1L2o=;
        b=m3BZA3J4ZDneq6BFTfRM2gL1L4TzJkzZOzLkrvkS58q1KA44AHRGMd50Xie04FdSP5
         ojeEczPNFUxQ8YDewDrL6S+zSFr+J7b3WSZR6SU4R/rQUW5w74iF88c+IGSasO7abH6x
         kifnVki9SZyc566UQCoj/h1X1S6XVKHiRSX+hJNcIcjOUfGQyg0AAlE1S431lzUcReH9
         pnlPtplxp3n3x6AHBNd/qXxJZB1e58S2YVcFpCH5c2ODpBlgO9Js9SsygmS+jmKpjcNF
         dpG26zkfpK05TRuZ7K9wuE+i/35iSDZLI/+icLhqN/LeSRAY13ir4w4LZ2tyGVeyUPRp
         9Fzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CQuivU7tA0j3DaNAmzqNs9rVsYSc4Mupj7zmuVm1L2o=;
        b=Ck2uOXX+mmmEPu7UFJifsKQYTwjkNBKnPHWeozQLt4sK0DMDbnuAABGXyMt1WSa8wO
         i/M4YvDKo+UK9GBByZYpMCYOQOfjEEq9Fgqu+WJlB/ULYXhG/a1CuFPXWyt3KTpQvwyl
         npfoP7mFt60ym7YqV/RhAWeg/HT9e8P3NHrQlppUa4x98J+pots2yoh62D69C4pvzozO
         sWji+tycjbpC4PzoFeG1ooZnHuYS4alMelfuENleRV0zH5XMllY2Ahgj+6+Er+qmRpkd
         N8LGssizhOmiEebwPxZySeEz7S4bfJIoN6LhdeY90KcJzErap9btUGlZHZTZuyjUgQv3
         Zx2A==
X-Gm-Message-State: AFqh2kpb4Y+Hqjt9n0maWnk6Q6DT9LxnUDVm0MKjDzbM5x/xouYSyTKu
        ggtKgjEmA9zxdWyPnDfMrOc5I3TkwzUOKV8rDO89EQ==
X-Google-Smtp-Source: AMrXdXvUZO0oM/+ykiDhNfUl4bBGqtkVrKxNyHSrFtssvMPCUccoMfbmVDu1oZYeiMvYzVTpl4K2ounvf7p9BcdvbV8=
X-Received: by 2002:a25:1388:0:b0:7b8:6d00:ef23 with SMTP id
 130-20020a251388000000b007b86d00ef23mr2139487ybt.119.1673458589236; Wed, 11
 Jan 2023 09:36:29 -0800 (PST)
MIME-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com> <20230109205336.3665937-14-surenb@google.com>
 <20230111154726.stadwtzicabwh5u5@offworld>
In-Reply-To: <20230111154726.stadwtzicabwh5u5@offworld>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 11 Jan 2023 09:36:18 -0800
Message-ID: <CAJuCfpFmO310qoFJr2EKHRavLx87k6tVkHO3-JCE0s4q5g+TCw@mail.gmail.com>
Subject: Re: [PATCH 13/41] mm: introduce vma->vm_flags modifier functions
To:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
        michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        paulmck@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, david@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com,
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

On Wed, Jan 11, 2023 at 8:13 AM Davidlohr Bueso <dave@stgolabs.net> wrote:
>
> On Mon, 09 Jan 2023, Suren Baghdasaryan wrote:
>
> >To keep vma locking correctness when vm_flags are modified, add modifier
> >functions to be used whenever flags are updated.
>
> How about moving this patch and the ones that follow out of this series,
> into a preliminary patchset? It would reduce the amount of noise in the
> per-vma lock changes, which would then only be adding the needed
> vma_write_lock()ing.

How about moving those prerequisite patches to the beginning of the
patchset (before maple_tree RCU changes)? I feel like they do belong
in the patchset because as a standalone patchset it would be unclear
why I'm adding all these accessor functions and introducing this
churn. Would that be acceptable?

>
> Thanks,
> Davidlohr
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
