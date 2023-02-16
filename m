Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22BF2699D1B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 20:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjBPTnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 14:43:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBPTnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 14:43:31 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0FCB4E5C7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 11:43:30 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id 139so3484066ybe.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 11:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ecCMrPuH47M6x+7l+8oSjk53rrpfDEPsyzkbMwvMYGE=;
        b=nQjhqTpWmrsidiAuvoCcaH+1Nn+MdzCD0u1wOKp3+6nMie0EEOCShOkZxWAStmC0Z7
         0DAiGxaTX/84wos6YcnH4ZcBy4oFJENSMkSF4PKWKvGrLfFlv9miv6D1euEV3WJw2Bja
         U/Tc4VyRAp8gojN5lr+rESfLvTfTK5vezctBWGmB51gEhz9cXu1jwSFmGRSfVyIe7KJW
         9985FtKADC1PSU2QKatY5svbWvXHeK/lG4CpKBFBZzA8TlGvpIV5VpHjgkpocjYvo2Sn
         2t+SpqQDf8D5EE+w43rAN8WY2iOuZ6m2DhxKzx3UvSVmlCnkWCxNbjgkfk9I9fPsoDou
         rcSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ecCMrPuH47M6x+7l+8oSjk53rrpfDEPsyzkbMwvMYGE=;
        b=uCgMQ+QaX2kmLMSOnQLeziA4E0/2ALJM/cfJNcPLNTdui6L3r7BwXwSHiQxt/HU+tF
         dPleWwN9LEyOLTUKZ/mLvH1tB+XulJPE31vny+onx9gNvFHYxjJOUqSrVUH/qQ6PY8wV
         7JGnoOEF5ECJT4Bh/MpANrnoPRIuMN2LkmH6TFgRU7bKd1bSUx8OsdC7j+SotThT/gd6
         1Nyixhb92yNrEkgsG/RwZ7/PBbyvFqcL5scZJsLtInC7L/855VeUa05TnB+zVm5u1sau
         M3UmLikVauY3tWZwrUKH1LUCW0OZ1Wueve0BFF8oeiV3YNzY+dAAU0v+mLO+EKNNFewT
         BYPQ==
X-Gm-Message-State: AO0yUKVs4UoWIrbGvQ/Ugtlnb992OZJL/h2rx6pJbtzWAaSoG/p5tWZm
        7GAaycIT0S4jsfZ2nTn9vcgc+LNO5ofX9AxYqL79cw==
X-Google-Smtp-Source: AK7set+GOKNhzuykRCoIMckW7I82pXv7V9YjFwgSjZ09J90OxeIVOanNo7rnoi+gq6vhCwETbxbWJ7fJFGy2XpbKeOY=
X-Received: by 2002:a25:9941:0:b0:90c:de27:7f15 with SMTP id
 n1-20020a259941000000b0090cde277f15mr876421ybo.428.1676576609777; Thu, 16 Feb
 2023 11:43:29 -0800 (PST)
MIME-Version: 1.0
References: <20230216051750.3125598-1-surenb@google.com> <20230216051750.3125598-27-surenb@google.com>
 <Y+5Pb4hGmV1YtNQp@casper.infradead.org>
In-Reply-To: <Y+5Pb4hGmV1YtNQp@casper.infradead.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 16 Feb 2023 11:43:18 -0800
Message-ID: <CAJuCfpHR8k0GsrYPMjSBVLAbu3EZgDU081+5CnR1td0cLEyDFw@mail.gmail.com>
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

On Thu, Feb 16, 2023 at 7:44 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Feb 15, 2023 at 09:17:41PM -0800, Suren Baghdasaryan wrote:
> > When vma->anon_vma is not set, page fault handler will set it by either
> > reusing anon_vma of an adjacent VMA if VMAs are compatible or by
> > allocating a new one. find_mergeable_anon_vma() walks VMA tree to find
> > a compatible adjacent VMA and that requires not only the faulting VMA
> > to be stable but also the tree structure and other VMAs inside that tree.
> > Therefore locking just the faulting VMA is not enough for this search.
> > Fall back to taking mmap_lock when vma->anon_vma is not set. This
> > situation happens only on the first page fault and should not affect
> > overall performance.
>
> I think I asked this before, but don't remember getting an aswer.
> Why do we defer setting anon_vma to the first fault?  Why don't we
> set it up at mmap time?

Yeah, I remember that conversation Matthew and I could not find the
definitive answer at the time. I'll look into that again or maybe
someone can answer it here.

In the end rather than changing that logic I decided to skip
vma->anon_vma==NULL cases because I measured them being less than
0.01% of all page faults, so ROI from changing that would be quite
low. But I agree that the logic is weird and maybe we can improve
that. I will have to review that again when I'm working on eliminating
all these special cases we skip, like swap/userfaults/etc.
