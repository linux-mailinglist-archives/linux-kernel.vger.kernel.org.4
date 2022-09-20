Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B77E95BED67
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 21:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbiITTOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 15:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbiITTOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 15:14:22 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9510975CF5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 12:14:21 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id h1so4199552vsr.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 12:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=DYSX+rzfvx6PPE4TbO9ukbYwi6O5v4DOvDShsPehjZs=;
        b=O9Q67sTKdIdUkUfAw3T4g0KL2Ft6B/58Vpl4IvTpCswVqim24o4vIF5JM4gPz/8WQo
         x0DqwmKq0Cro4XHojFU+CZnphwndc0MTmScUuneb4RzwD6q4MldGCqa2N0Ir/nWsNuDR
         bABI1mTPRymfI7SJwZWgw1BnakG/Y3KDIF7ua2kKdnpREIXkqHlf7sg7ZT+sCHld7fBn
         AWBmu+XgwShCHB24+0BbUWzLh0u3dNqwjarEIU3V7dfOlDkuLpgoXT43Dy0bd+T7/dUT
         Qdlgnu4oy2jFH1YH1dCiCRRcfGHSqIZFnLD+ckznWW3AiYL0/Kog1ycSLWL+1o6zXs1k
         Y0ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=DYSX+rzfvx6PPE4TbO9ukbYwi6O5v4DOvDShsPehjZs=;
        b=Ap+JbnGa0B5wbvaTxBl0qWwKHad5E+GQAcAhNRB91y7Ww1j3x0Paiw2qQycynyOrQL
         pSkGTZTvCCJv78pxXbFIaveizYKaTmOaBerBkQQsNUfdXTPeW0Q3rE9Cc8FMvsF5nvAS
         gGkAENTcHhx+oSnu/CFsH3xIJ/bQcKnBOPzrqxoCs03KTpRd9MAR81rDK9zmDS91a/sO
         ToNi6B2COUhtAmAagHgvY05uOyNxfazjgJlrVJtUwi64NtDKo5qgz+czewRcqwKtoAms
         udiLHInjIXdgRuhn7tOwppbGIAFXRpbmmuj1yCEWltQZOZQnrRAVedSl3bqckD3nuvR2
         kA6Q==
X-Gm-Message-State: ACrzQf247Fjc13wK83L1mBjVxt1BJ3lMqKiGJ3RhE1iCgtRP0y5tLVnB
        K3yToKLoDfL+A3FmJue71Lx35JWi2Mcpa/qCLHhhXg==
X-Google-Smtp-Source: AMsMyM6UkmBURuxxZvOTXRzp2UnuhL60STzSwNNNChfdCbuCxSjuqja+8Wo2jgYB7Vd6EladthWqIQmcnJnWldhyhSc=
X-Received: by 2002:a05:6102:3309:b0:39a:e5eb:8508 with SMTP id
 v9-20020a056102330900b0039ae5eb8508mr5938462vsc.65.1663701260563; Tue, 20 Sep
 2022 12:14:20 -0700 (PDT)
MIME-Version: 1.0
References: <576182d194e27531e8090bad809e4136953895f4.1663700262.git.andreyknvl@google.com>
 <CANpmjNN0jyK0svOOHSFPAfFV9CAEUVUb+y_748Fww-sgf=3pdg@mail.gmail.com>
In-Reply-To: <CANpmjNN0jyK0svOOHSFPAfFV9CAEUVUb+y_748Fww-sgf=3pdg@mail.gmail.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Tue, 20 Sep 2022 13:13:44 -0600
Message-ID: <CAOUHufY3E86dZ2SfZgC6X3nOHSm4MVuxsZk5grjnjrfSnaXpkQ@mail.gmail.com>
Subject: Re: [PATCH mm] kasan: initialize read-write lock in stack ring
To:     Marco Elver <elver@google.com>
Cc:     andrey.konovalov@linux.dev,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
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

On Tue, Sep 20, 2022 at 1:10 PM Marco Elver <elver@google.com> wrote:
>
> On Tue, 20 Sept 2022 at 20:58, <andrey.konovalov@linux.dev> wrote:
> >
> > From: Andrey Konovalov <andreyknvl@google.com>
> >
> > Use __RW_LOCK_UNLOCKED to initialize stack_ring.lock.
> >
> > Reported-by: Yu Zhao <yuzhao@google.com>
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> >
> > ---
> >
> > Andrew, could you please fold this patch into:
> > "kasan: implement stack ring for tag-based modes".
> > ---
> >  mm/kasan/tags.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
> > index 9d867cae1b7b..67a222586846 100644
> > --- a/mm/kasan/tags.c
> > +++ b/mm/kasan/tags.c
> > @@ -36,7 +36,9 @@ DEFINE_STATIC_KEY_TRUE(kasan_flag_stacktrace);
> >  /* Non-zero, as initial pointer values are 0. */
> >  #define STACK_RING_BUSY_PTR ((void *)1)
> >
> > -struct kasan_stack_ring stack_ring;
> > +struct kasan_stack_ring stack_ring = {
> > +       .lock = __RW_LOCK_UNLOCKED(stack_ring.lock)
> > +};
>
> Reviewed-by: Marco Elver <elver@google.com>

Tested-by: Yu Zhao <yuzhao@google.com>
