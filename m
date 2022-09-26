Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961EB5EAF71
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 20:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbiIZSR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 14:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbiIZSRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 14:17:34 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CFD1FF
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 11:08:11 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id c11so4609312qtw.8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 11:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=zbTeqblGxrVphEvYs4g+Za5JLZuDmNmIQK0NJlTmwT8=;
        b=oVxNzol03dnNpfu8QmUcTpPCYwZXy8WzsbfWjT6qo9tTEJ9iGCHEgdXPYUPRVRN2YZ
         +LlCMbPpzeDXNNo0t6CHPpWw14cpueJclTJ2scnlnjI4Z/v+6k14CtruMcIGHgTWFmYt
         +gh+eg4XVZ3nM64TeZh1XxY3CwUxU9B7zrcHrf9CRrhveWswrZWYVokVNWw2hYV9J3Qp
         3S0AGlHwV+UkIaqzP7blQzYcawju1Qm80RnCAmsrkxLdD7citixAx2Q00PhjeUYD/Z6G
         /Vm6CcPxGXdXrrGNrFuQFZcgPEMPo9O+OfK9R3Ib27TyKzj2Z8l/hFSusyXtzAoiMjuZ
         utUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=zbTeqblGxrVphEvYs4g+Za5JLZuDmNmIQK0NJlTmwT8=;
        b=rVsRo+dCx89Hh2uYDRpphkH1e1cHuwgaYnX8O+GIiIbXSgCKCVbpGWWZ2oe99nxscP
         b9ilu1XqzaOSi3eo+oC80EivtbtVKE6/nEKbv95zCeEg0K2gO9vwepB0j93QFrUOBfNG
         W0ZLhB+HWAQDdyOEJic2VoaODiTA17bE9sTXlhm/8KoFeVeXMURfIN2vAScGXwc5sfh7
         Wlkcir9DU6t6CvLCO+hbUZ+OAMWG8p9M+OjPCAwu+JEweWhbCfNw9ByxFfM7RFbP1hH/
         BZZ1glab2YIG/lz6t4R8HZQ8+c7TUJQdrr8dirEvKaaeaPeBAINLA+TxH6g4xZKSxAvq
         CnKg==
X-Gm-Message-State: ACrzQf3Y0sIVEu2NfadoHc5faU6DuRI9l2tRMifO4QcrCPnCriMN0Moe
        cDZ7AtIXB/nHMB0V24sWZDoivJ8ouiomZ+pntOE=
X-Google-Smtp-Source: AMsMyM6eatwvx5/wUwL+eLNx14HtahXAw8TMeZ969Y1GO53xCjGzunGRKw9qVUVg1OwbN1vRJZCXK9zcWeDR8JgSTpM=
X-Received: by 2002:a05:622a:8b:b0:35d:430d:e53d with SMTP id
 o11-20020a05622a008b00b0035d430de53dmr3962001qtw.391.1664215690624; Mon, 26
 Sep 2022 11:08:10 -0700 (PDT)
MIME-Version: 1.0
References: <9c0210393a8da6fb6887a111a986eb50dfc1b895.1664050880.git.andreyknvl@google.com>
 <20220925100312.6bfecb122b314862ad7b2dd4@linux-foundation.org>
In-Reply-To: <20220925100312.6bfecb122b314862ad7b2dd4@linux-foundation.org>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Mon, 26 Sep 2022 20:07:59 +0200
Message-ID: <CA+fCnZe3SYq1c50hKdR3eoALz+kHE2MdUkbcbG0dhUFjaKkPNw@mail.gmail.com>
Subject: Re: [PATCH mm v2] kasan: fix array-bounds warnings in tests
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     andrey.konovalov@linux.dev, Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 25, 2022 at 7:03 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> > --- a/mm/kasan/kasan_test.c
> > +++ b/mm/kasan/kasan_test.c
> > @@ -333,6 +333,8 @@ static void krealloc_more_oob_helper(struct kunit *test,
> >       ptr2 = krealloc(ptr1, size2, GFP_KERNEL);
> >       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr2);
> >
> > +     OPTIMIZER_HIDE_VAR(ptr2);
> > +
> >       /* All offsets up to size2 must be accessible. */
> >       ptr2[size1 - 1] = 'x';
> >       ptr2[size1] = 'x';
> > @@ -365,6 +367,8 @@ static void krealloc_less_oob_helper(struct kunit *test,
> >       ptr2 = krealloc(ptr1, size2, GFP_KERNEL);
> >       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr2);
> >
> > +     OPTIMIZER_HIDE_VAR(ptr2);
>
> What chance does a reader have of working out why this is here?  If
> "little" then a code comment would be a nice way of saving that poor
> person for having to dive into the git history.

Will add in v3. Thank you, Andrew!
