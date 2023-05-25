Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48BA87102C1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 04:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbjEYCQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 22:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237470AbjEYCQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 22:16:12 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BF71B0
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 19:15:50 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-561bd0d31c1so341657b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 19:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1684980944; x=1687572944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f+ykmbunbSMTavDYm2cC5wCQ70/w+yrfqKokU2pUa/E=;
        b=ZQPTv5nvfUy0tCUe+PyijpeyjNtyS3t+oE375SI9VbLxJTzUtZpvxT6GmIulV45OaJ
         PgQC/pMRoePHBFKps1iaVohDrCxsU8JB02eBZXGzQ0gM0xRR80OuDBX+yFu9sacRwhwP
         oSLuU0L5IeSwu4JUbV3atF8Soje0Fo0VrGvqpX86Fw/I1kkzbFiZk/uuTehU0BXftsjW
         EiCRWkJWN65/Me1pgLNoHu/EXQs8RGc1f3uVqLDaJ24EozLuP75f3r2O7MNl7ExsyzEd
         KqxfJjMC09sYG0+froE8i35zKiyqug9kr4xIEEsiPbQ61FxN6gz6DpjDRaNG1AatejKD
         mFLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684980944; x=1687572944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f+ykmbunbSMTavDYm2cC5wCQ70/w+yrfqKokU2pUa/E=;
        b=SGNizCbEgr3LjnQzymjHL+OES24cx0LUH87a7LXm4HifD+X83KqkBwBvgTGsao7xFM
         FQRfbaNKpy1/BhLd6O6mCGU7ltFt36kerzMTMWVNv+m8+5mE+ouPPwMZOdxbW/SUyKZx
         IfmKvICVczhqLLynLVZeq1tl37CF/5uZysr1tmlEX9R8iw5upKi5oDrEhIXLYy+NM2vb
         BZG051P2oMeW+h2Lf+9ntCqEb+lROOZRhtRyKx2WM+tYLKGyEMZIRD+q3Nz+EUYBwwwc
         y952q+xlNfh8U5P/P+MRCkl5aRSCTfRAddedLtaXxk0oATNbZ/BIV/E5YUru39m21Bn8
         2T0g==
X-Gm-Message-State: AC+VfDz3IDaVfwW/pksRaGBd2MWRMMhzVSdYndAKxLZlNktlJ5psKO6r
        wtHCDnZF36sK/yfiswiifoMBN2AGfuv5hay4nOsn
X-Google-Smtp-Source: ACHHUZ7DBGKRnzGPMn8pKO1h24akzMY7IvEQlCqulZs21z3hu3zLql0mOGpOGcNJWDfCq2t0t+xz5dFsHHENC31W2XE=
X-Received: by 2002:a0d:cc92:0:b0:561:c184:6568 with SMTP id
 o140-20020a0dcc92000000b00561c1846568mr21324234ywd.18.1684980944143; Wed, 24
 May 2023 19:15:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230523181624.19932-1-ivan@cloudflare.com> <CAHC9VhTtbbiwyOqiFfveWF6hV-Wb5cuhk0r8EdUi0kVb0v4P_Q@mail.gmail.com>
 <CABWYdi2A8ZfVJjmDpwiNhvYD8m-+PC5MsNRzofX7SXn2TTyY9Q@mail.gmail.com>
 <CAHC9VhQm9JEFozFMvNuBc_dx+XAqvJCY_Z8Dyf7q_RyDcNu=QA@mail.gmail.com> <CABWYdi3_zAVpeTRBou_Br-n6VXeM1xWTCSvu==QWdG4sd+nnnw@mail.gmail.com>
In-Reply-To: <CABWYdi3_zAVpeTRBou_Br-n6VXeM1xWTCSvu==QWdG4sd+nnnw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 24 May 2023 22:15:33 -0400
Message-ID: <CAHC9VhReahw8G4Vc0eMdhQMLhGYE53=X48akC13rN4EPkiF3tQ@mail.gmail.com>
Subject: Re: [PATCH] audit: check syscall bitmap on entry to avoid extra work
To:     Ivan Babrou <ivan@cloudflare.com>
Cc:     audit@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@cloudflare.com, Eric Paris <eparis@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 2:05=E2=80=AFPM Ivan Babrou <ivan@cloudflare.com> w=
rote:
>
> On Tue, May 23, 2023 at 7:03=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > > Could you elaborate on what exactly you would like to see added? It's
> > > not clear to me what is missing.
> >
> > I should have been more clear, let me try again ...
> >
> > From my perspective, this patch adds code and complexity to deal with
> > the performance impact of auditing.  In some cases that is the right
> > thing to do, but I would much rather see a more in-depth analysis of
> > where the audit hot spots are in this benchmark, and some thoughts on
> > how we might improve that.  In other words, don't just add additional
> > processing to bypass (slower, more involved) processing; look at the
> > processing that is currently being done and see if you can find a way
> > to make it faster.  It will likely take longer, but the results will
> > be much more useful.
>
> The fastest way to do something is to not do it to begin with.

While you are not wrong, I believe you and I are focusing on different
things.  From my perspective, you appear primarily concerned with
improving performance by reducing the overhead of auditing.  I too am
interested in reducing the audit overhead, but I also place a very
high value on maintainable code, perhaps more than performance simply
because the current audit code quality is so very poor.
Unfortunately, the patch you posted appears to me as yet another
bolt-on performance tweak that doesn't make an attempt at analyzing
the current hot spots of syscall auditing, and ideally offering
solutions.  Perhaps ultimately this approach is the only sane thing
that can be done, but I'd like to see some analysis first of the
syscall auditing path.

--=20
paul-moore.com
