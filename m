Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E71E6F4582
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 15:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234139AbjEBNuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 09:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233018AbjEBNuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 09:50:14 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01D8DF;
        Tue,  2 May 2023 06:50:13 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-64115e652eeso34761113b3a.0;
        Tue, 02 May 2023 06:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683035413; x=1685627413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nPyjmDm6ABxZQj0/bNA7SyUBs1ObBoUDPkgVpR4Dtwg=;
        b=bP9mQdziu1KmRL6gbE1k062yIabt3b6iFkMu7UsXvhsAt7jKL7k961TJGJvMB3bwZC
         URCZO83wjm/pHDIejULmxP8GJQdz5qvGGXD6Lgf2C9szKDYtz1GxitTwK15qIOyuXmtV
         27TYWJ7EwqNfE85e0sNVRBauxP9zI+6QL7SW3iQEZbhqU/mmZl4NT7gx94eDDqGavura
         5ScvtdfFh4Q3kWQf/I/246vTylQJQooU/wnF+foGjpPj4uGfMdR6Zd9IGwOTq3u2MGvx
         0NZ+pA7P8MDjUJ9m4pwKEOcTY2K7ogBXwZLJ9tZjKvz483AZgQT6T0+giXZGfUsABbCG
         rhKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683035413; x=1685627413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nPyjmDm6ABxZQj0/bNA7SyUBs1ObBoUDPkgVpR4Dtwg=;
        b=ZoVB7wtIhoXFACXgUZuAz5yDrEakKTPAZgnAmEfTmKoUgnAPcUgwnG+HFCSZjhvvj1
         6FBkcSBaEd6GQ2EfxOw3O9lb0ltAahg7zNgmxPiLgaSmd6a0BOoA910qjOeg70QTRDoZ
         4rpn8yw4yAozYkyg91eFb2+Q2Z4NWJyGj7EFTiWY1YN/ZOehGK5YiqKddo38wxG1lnsZ
         iOPdV37vYQRGyuey970M6PKJxokaujZ2Shr1z5n1B6QPNM7KqdS52kd0fu018B2BGjUp
         K1fajFILshKANpeOXRLSUK13ig+OLoxeP3w952j1eH7l65RCh/3vrMY09z8RQsJeizFS
         hCUw==
X-Gm-Message-State: AC+VfDyq0LN8ajfwr6G7PFrlE3CRm4XXEEuLcEhGi7hLtyBrEwfE8ZHl
        6wEb8sTNGkVYrVBQp4f2/vhTnYQrVlqeBzvsqiY=
X-Google-Smtp-Source: ACHHUZ7tCWSola71AgMeRXKObL6rnAqXFGmM0ERKXNVdhY98YtrLH5wchsLwozljne3rhmzLDt58sDLnY/jaNrT6tFs=
X-Received: by 2002:a17:90a:9bc6:b0:24d:f1b1:4bea with SMTP id
 b6-20020a17090a9bc600b0024df1b14beamr9549926pjw.0.1683035412891; Tue, 02 May
 2023 06:50:12 -0700 (PDT)
MIME-Version: 1.0
References: <1682985701-19914-1-git-send-email-zhouzhouyi@gmail.com> <783a1e86-d625-4d8b-9b7c-0531b11b9290@paulmck-laptop>
In-Reply-To: <783a1e86-d625-4d8b-9b7c-0531b11b9290@paulmck-laptop>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Tue, 2 May 2023 21:50:01 +0800
Message-ID: <CAABZP2wTpG1dCU8GNTuiyj+2zkHxWgOF3j3Mqjk5BUgS6KADZA@mail.gmail.com>
Subject: Re: [PATCH V2] rcu/torture replace wait_event with wait_event_idle
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org, lance@osuosl.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 2, 2023 at 9:40=E2=80=AFPM Paul E. McKenney <paulmck@kernel.org=
> wrote:
>
> On Tue, May 02, 2023 at 08:01:41AM +0800, zhouzhouyi@gmail.com wrote:
> > From: Zhouyi Zhou <zhouzhouyi@gmail.com>
> >
> > In kfree_rcu_test, kfree_scale_shutdown will be detected as hung task
> > if kfree_loops is too big. Replace wait_event with wait_event_idle
> > to avoid false positive.
> >
> > Tested in the PPC VM of Open Source Lab of Oregon State University.
> >
> > Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> > Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
>
> Good catch, thank you!
>
> However, this commit beat you to it:
>
> ef1ef3d47677 ("rcuscale: Move shutdown from wait_event() to wait_event_id=
le()")
You are very welcome ;-) Still, this is a very fruitful learning
process for me ;-)

Cheers
Zhouyi
>
>                                                         Thanx, Paul
>
> > ---
> >  kernel/rcu/rcuscale.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
> > index 91fb5905a008..d99c586939d1 100644
> > --- a/kernel/rcu/rcuscale.c
> > +++ b/kernel/rcu/rcuscale.c
> > @@ -771,7 +771,7 @@ kfree_scale_cleanup(void)
> >  static int
> >  kfree_scale_shutdown(void *arg)
> >  {
> > -     wait_event(shutdown_wq,
> > +     wait_event_idle(shutdown_wq,
> >                  atomic_read(&n_kfree_scale_thread_ended) >=3D kfree_nr=
ealthreads);
> >
> >       smp_mb(); /* Wake before output. */
> > --
> > 2.34.1
> >
