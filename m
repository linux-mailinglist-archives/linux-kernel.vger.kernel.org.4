Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2F22665077
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 01:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235700AbjAKAo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 19:44:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235590AbjAKAoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 19:44:55 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DDC51305
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 16:44:54 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-4c24993965eso169769437b3.12
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 16:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xtvZkDMfjdpj7QHOsKas/y5TjQNGWMzi4v+NaAfxc/M=;
        b=rccchTxYrSIKNuMMA04XAuTcSJ82eK2GdC2ENpgcicB00sj0WcV6jGWsPM7Vj88mPb
         QlM6SlS+l5D5N1ROSmPhwdv9eKvOxbnACcaMUmUMyG/hgdcTpc/m2/U7zUEjMHWKmRnJ
         iLnc+bUB3YARfZVoEVFAUqxXlhi7zPYNt5sxx3Yiv65exEivUjNJfGC6OO/litDhtM1s
         h6F5QPgDgXCz4P3MtLZPSCkFhTucZbdO/UV56ccQ8XpnKs4GidmWckh3zxyqlNmd7nzX
         e8wZVJSxeBkQJKlInwlBAfcaPDtsJFiO+j4iCugO/eypq/qyTfw7kmDZjkQ90McLsnQj
         Cghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xtvZkDMfjdpj7QHOsKas/y5TjQNGWMzi4v+NaAfxc/M=;
        b=YIXjrx2/tFebB54nuWhd/bW9BioOJy7jXuvtZmKijSd1Rcg3V0io5UcHMJOtE8yKnG
         kgkrdkyurw/IJc/QzsIm4eHbpv5nn3d+rsoGB+qt9DlKgonJjBn/nHz2YkIGcKmw0mJq
         +KWkpbWwzVyEY2HEBMXsQ2T5zmd2Yr2Tq0aigVgukgKzaNhdFAf2cSZXAXfg1aO6Qq2b
         gd4ZnYTJ4rVtr7r6YK6PU+ctQ8A4O/aGTTMk5qHTQfjJY8ilLXIRe57nnDlBvfLAVohd
         jSjUXJazq8BeIhkNWt44oiMIuzGU5ro/hJJP9Ibz4Mm+5w0UK1OVMSjt03uXqXUQ9Uk9
         G2ew==
X-Gm-Message-State: AFqh2kr/9ZDvqCp2j29223tmXfvHrtBDYPDc7IxR5s9zCAswhSVynOEs
        KdLBH8bWKvvKxzRWBUVmCty/JFl8sMOG8loGQtnVWw==
X-Google-Smtp-Source: AMrXdXvPXLbnMiGgkk5CiK3fMZDgBpCfW92tb2P0dpshIrb2n4DxdFF46+Kabz2Cd6j2GosIoYiHxTRK+05ofT24Es8=
X-Received: by 2002:a0d:c2c5:0:b0:433:f1c0:3f1c with SMTP id
 e188-20020a0dc2c5000000b00433f1c03f1cmr1613574ywd.438.1673397893628; Tue, 10
 Jan 2023 16:44:53 -0800 (PST)
MIME-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com> <20230109205336.3665937-9-surenb@google.com>
 <20230111001331.cxdeh52vvta6ok2p@offworld>
In-Reply-To: <20230111001331.cxdeh52vvta6ok2p@offworld>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 10 Jan 2023 16:44:42 -0800
Message-ID: <CAJuCfpEv--awCY0=R3h5Fez8x74U1EZCzNkq4_7deCYqej5sSA@mail.gmail.com>
Subject: Re: [PATCH 08/41] mm: introduce CONFIG_PER_VMA_LOCK
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

On Tue, Jan 10, 2023 at 4:39 PM Davidlohr Bueso <dave@stgolabs.net> wrote:
>
> On Mon, 09 Jan 2023, Suren Baghdasaryan wrote:
>
> >This configuration variable will be used to build the support for VMA
> >locking during page fault handling.
> >
> >This is enabled by default on supported architectures with SMP and MMU
> >set.
> >
> >The architecture support is needed since the page fault handler is called
> >from the architecture's page faulting code which needs modifications to
> >handle faults under VMA lock.
>
> I don't think that per-vma locking should be something that is user-configurable.
> It should just be depdendant on the arch. So maybe just remove CONFIG_PER_VMA_LOCK?

Thanks for the suggestion! I would be happy to make that change if
there are no objections. I think the only pushback might have been the
vma size increase but with the latest optimization in the last patch
maybe that's less of an issue?

>
> Thanks,
> Davidlohr
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
