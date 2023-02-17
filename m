Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2115A69A3C9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 03:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjBQCPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 21:15:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjBQCPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 21:15:12 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE174FC92
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 18:15:11 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5338dd2813dso43303317b3.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 18:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gIW9E+wxkNTINaEXAot3lldoZz6sgaV4NvNtgjJaTFE=;
        b=HZ1MbnjL/We5C6AX8xTKc/NqTWr1JbNL6JlhMYjY4MPeRhcx4XZI09qb39bGwvRHpn
         8cDtil8U0r6ullafxJ+QwLrNcyZB/iYRlwQxWBWKusbbvKu5LjqUSwq9Ra4ShiIiGrEv
         AxeeaI71BN3x7atdH3dnzKmeE+EolPr5w0YLihfjx8Lqhfdtg4nJ/eIYXfAJrzuibZs7
         cByt+UC1cn5tWYrIXSmdfIJG8w44wiSxOwaDq0TQPCM1gjyd36andjC6MWF3zwokrgru
         63sqYZasEEiF/RtcTOEDIThAitqANjlx8nQcaAyiwezVllR+cWq9GK3mwpXFnbRC0O/W
         bLkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gIW9E+wxkNTINaEXAot3lldoZz6sgaV4NvNtgjJaTFE=;
        b=FFBwqV2VABDggM4ZVaNwQ1vnt9AfJC/LQLBOCnmSCaCyr6DtZGWifXpq5UbPlf5yxm
         m8mOzbT8zgK+aAm9p91m3TgDR1wmfzPcni08sW0Yh60OHAjBI/xz1soOc7cWUY1KIoQm
         dB5ih93Omc+lcjqJtaTAV4drMZ0mr3D/R9dMoK5VcNpyrOd6HO7T/eOR75fdSmRN23xj
         xQ29I0PPa6EFl5KiORo9EZPIwQTd9HpyfYCHvkk+RHlEQ2ZTxqSmsFNWBXz9OYlIKFFj
         mJGZS2Z3EgQUND2ikBt1FOrSgbPoBS0PSPTZRYI1fcK0xIy7qSmlEQoLPAhC+AS/sO09
         cJ5w==
X-Gm-Message-State: AO0yUKUm4Lur7X3qMaMVhfU1GQUpYKUwRzAELH1pZ9dVeqJqO01vvGwi
        4MtF1vwNi3yWqCUPQzskSoIdjrUjkkmqUc45eINHWA==
X-Google-Smtp-Source: AK7set9iDocdfaltT1vBZM1FfqGEUR3CgAtWXk18fjpJx7Nf/An2UuUbR7/i7tvhGQPyuOkqzQZqqs2JkP/rFvIUCdY=
X-Received: by 2002:a81:4ed4:0:b0:506:6364:fda3 with SMTP id
 c203-20020a814ed4000000b005066364fda3mr971621ywb.72.1676600110454; Thu, 16
 Feb 2023 18:15:10 -0800 (PST)
MIME-Version: 1.0
References: <20230216051750.3125598-1-surenb@google.com> <20230216051750.3125598-27-surenb@google.com>
 <Y+5Pb4hGmV1YtNQp@casper.infradead.org> <CAJuCfpHR8k0GsrYPMjSBVLAbu3EZgDU081+5CnR1td0cLEyDFw@mail.gmail.com>
In-Reply-To: <CAJuCfpHR8k0GsrYPMjSBVLAbu3EZgDU081+5CnR1td0cLEyDFw@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 16 Feb 2023 18:14:59 -0800
Message-ID: <CAJuCfpHODBAV=riSPyvcmLbZVtXSdxrw2GMy8VOjvDV9yCyX8A@mail.gmail.com>
Subject: Re: [PATCH v3 26/35] mm: fall back to mmap_lock if vma->anon_vma is
 not yet set
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@techsingularity.net, dave@stgolabs.net,
        liam.howlett@oracle.com, peterz@infradead.org,
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

On Thu, Feb 16, 2023 at 11:43 AM Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Thu, Feb 16, 2023 at 7:44 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Wed, Feb 15, 2023 at 09:17:41PM -0800, Suren Baghdasaryan wrote:
> > > When vma->anon_vma is not set, page fault handler will set it by either
> > > reusing anon_vma of an adjacent VMA if VMAs are compatible or by
> > > allocating a new one. find_mergeable_anon_vma() walks VMA tree to find
> > > a compatible adjacent VMA and that requires not only the faulting VMA
> > > to be stable but also the tree structure and other VMAs inside that tree.
> > > Therefore locking just the faulting VMA is not enough for this search.
> > > Fall back to taking mmap_lock when vma->anon_vma is not set. This
> > > situation happens only on the first page fault and should not affect
> > > overall performance.
> >
> > I think I asked this before, but don't remember getting an aswer.
> > Why do we defer setting anon_vma to the first fault?  Why don't we
> > set it up at mmap time?
>
> Yeah, I remember that conversation Matthew and I could not find the
> definitive answer at the time. I'll look into that again or maybe
> someone can answer it here.

After looking into it again I'm still under the impression that
vma->anon_vma is populated lazily (during the first page fault rather
than at mmap time) to avoid doing extra work for areas which are never
faulted. Though I might be missing some important detail here.

>
> In the end rather than changing that logic I decided to skip
> vma->anon_vma==NULL cases because I measured them being less than
> 0.01% of all page faults, so ROI from changing that would be quite
> low. But I agree that the logic is weird and maybe we can improve
> that. I will have to review that again when I'm working on eliminating
> all these special cases we skip, like swap/userfaults/etc.
