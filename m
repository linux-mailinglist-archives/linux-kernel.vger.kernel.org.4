Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 958BC67C218
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 01:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236446AbjAZA4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 19:56:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbjAZA4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 19:56:30 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D309741B6E
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 16:56:29 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id 129so368198ybb.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 16:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j6PJ67oAnfzV9PxkuyEMm7X3urH+VAUx7uNIfBIgK8A=;
        b=VPV23bB/NTAePn3ETVAx/0rZ5RYy1tyqMgRlKO0QViQnGhUmX7jyE5mB35Xi9APjlY
         DL1Dqno6sd1kt+SACNdRv9yNuwSO4WLY5aSWK1Lo6e1Z5K7hVz05KgRAL08GGJeN8i95
         VoJ8IJ8WCXFymcNzjmnd6pEwTWFDmHZiuixuMrEkedvabWF0sGRFPCEruskVOmNZ2z9v
         4MQJZB50jLKj5Qtx9ezhphFW1ZgV+grFYvY4bw1CA898+aH9wE7fT07rW0gZUvs+zBC7
         /0EjzxiaogGu8EDN1Au38zJws9yGvLda8TtNbSovZLrAXep+lJAoyouy9SaVV9e3LqLB
         ssUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j6PJ67oAnfzV9PxkuyEMm7X3urH+VAUx7uNIfBIgK8A=;
        b=qQokQ6KAR3j8mkvg2O993qIkkpESmh5Gyx6sfynP9dqD98n09HLV3x7ISoIS1bIu83
         psxM9MWgCAmovd5FaO3EH2NVILNn28DuKcb+XHo2IJglfMJdqsyV9dJDnSskDdVNvv08
         z5j5VASacSzMwHOXWGyHf1RDA0p06fh4xM6NVHfAA7W7Chg7dAmwKmyLu5i5ZXSCH82r
         /PGICusRxj2cXmJ4m8Ul+3Bw2idYrmcrgxBUT0cMC5KkuvsczlnXwHN3nKbFCcJweSnK
         OyM3/kk/tEDAjAsApyKXf/7ajnkDSWGuwk1nIqZeLRfhIMOhgUbno1k3WSYRRzba5K1U
         9Bvw==
X-Gm-Message-State: AO0yUKXGY58z6TGDPcnX5VgKic2ttygLOq8zCzU7FACssbSTJq8JZBfQ
        yBYnEdhxCLydAiKVwEloLprCVtX2zrUGl+w1ci8TYA==
X-Google-Smtp-Source: AK7set8NIfHhdPuyL1RvDuayyrK39JHTj20Y7CDEMECMUkWmAbcHmsIgGk35BlpCcNAq5/QsmCjbLZ6FgKApKS2x2KE=
X-Received: by 2002:a25:c247:0:b0:80b:6201:bee7 with SMTP id
 s68-20020a25c247000000b0080b6201bee7mr1062130ybf.340.1674694588781; Wed, 25
 Jan 2023 16:56:28 -0800 (PST)
MIME-Version: 1.0
References: <20230125233554.153109-1-surenb@google.com> <20230125233554.153109-3-surenb@google.com>
 <20230125162810.ec222773d13cd26c55991fde@linux-foundation.org>
In-Reply-To: <20230125162810.ec222773d13cd26c55991fde@linux-foundation.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 25 Jan 2023 16:56:17 -0800
Message-ID: <CAJuCfpFWTNpz7LB+931Gc+yYwBq3-y+_doH2WdtjhTGnxLxvig@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] mm: introduce vma->vm_flags wrapper functions
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

On Wed, Jan 25, 2023 at 4:28 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Wed, 25 Jan 2023 15:35:49 -0800 Suren Baghdasaryan <surenb@google.com> wrote:
>
> > --- a/include/linux/mm_types.h
> > +++ b/include/linux/mm_types.h
> > @@ -491,7 +491,15 @@ struct vm_area_struct {
> >        * See vmf_insert_mixed_prot() for discussion.
> >        */
> >       pgprot_t vm_page_prot;
> > -     unsigned long vm_flags;         /* Flags, see mm.h. */
> > +
> > +     /*
> > +      * Flags, see mm.h.
> > +      * To modify use {init|reset|set|clear|mod}_vm_flags() functions.
> > +      */
> > +     union {
> > +             const vm_flags_t vm_flags;
> > +             vm_flags_t __private __vm_flags;
> > +     };
>
> Typically when making a change like this we'll rename the affected
> field/variable/function/etc.  This will reliably and deliberately break
> unconverted usage sites.
>
> This const trick will get us partway there, by breaking setters.  But
> renaming it will break both setters and getters.

My intent here is to break setters but to allow getters to keep
reading vma->vm_flags directly. We could provide get_vm_flags() and
convert all getters as well but it would introduce a huge additional
churn (800+ hits) with no obvious benefits, I think. Does that clarify
the intent of this trick?

>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
