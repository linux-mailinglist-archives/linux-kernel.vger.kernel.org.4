Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 002B16E8AA0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 08:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233871AbjDTGsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 02:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjDTGsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 02:48:04 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16081FE4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 23:48:03 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3ee6c339cceso188465e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 23:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681973282; x=1684565282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mSkCvBXXQn0Pz9mV1Ds+4r3rrylnLRXP3iAno+fbDFI=;
        b=hm71xhFNJdX2UoGBsWYmPq/qdIqZt1Wax24efwoGvt8IiADj4r2nkQ8QD1RxRk2M0Y
         oUxwE8n5yGYRwkgbEfPxCnHh7SQ25L4xi6jiQDEP+oDAcuEdejiiFCUwhXDjWZLwGcNX
         3cz3D/mwHZqEACYf/P6y3TbV7t1QbE5Vl+PqRfcKld3WupvdyreNCPYJVxiskdqDl2b4
         5tm15LEC4Eat+UKBR2wB69zij2rd85NAGbMX+gnau59HF/xUIrM3N1AF/k2x2fGeQ+yI
         7P+RKcER36CH9trJT4KR73dMjHeE0QbuVX5NgS6Vv220RJpmWuEjonOaN/ITGGB7dEdL
         Je4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681973282; x=1684565282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mSkCvBXXQn0Pz9mV1Ds+4r3rrylnLRXP3iAno+fbDFI=;
        b=cc1IXYFhFMFeA0gpZxnKWJd4Y5PD9sfYwg9n5Cc9vIJYAjJf401MT/2DuMzlo/WfOT
         7vg9vitTPiR/i6bHJboBv5Hmpo3XRek7RlgwQS5L16IFZ+6sTuYagPZAupI7fRYOr6MZ
         A4kHu56CTsAGdgaGvfAJK9HEWuJTpXvbeS0AwHoHIo1E06oOfXnnYYtYTySL6ggSm+/i
         JKFsYmT6sicuLLvvi9owJsE3QhHu22nc2t2IkkCVe0FfeOVq1wRw+svLxsgtaldIHh/a
         ozzH9oynjV4CBdtcrqDFih6JaK2q9mydamtpBbp8FLPKTRqbD/CX6Gzf5ccpkGSuYmhC
         SKPw==
X-Gm-Message-State: AAQBX9dUiuFBa70MBlqJePM0zTu0unl+m2Dr3Yp9e+XHcKpH3oSHgndI
        xtkX6q3gXRdLbClRAbQb5BnXLwgyq1PVp3+fBELVgGoPExxD3r/u0QQwSQ==
X-Google-Smtp-Source: AKy350awe0Q0VQ3MkUL4nCZSzp9UwMk5ieIQqMsMbpKlKWIGeopxh9G+woDkgBSOMtvDvry2ruDqF1hCZXkBkRqLY2A=
X-Received: by 2002:a05:600c:314c:b0:3f1:7490:e5a4 with SMTP id
 h12-20020a05600c314c00b003f17490e5a4mr133669wmo.6.1681973282115; Wed, 19 Apr
 2023 23:48:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230418120305.520719816@linuxfoundation.org> <CA+G9fYs9sHnfhn4hSFP=AmOfgj-zvoK9vmBejRvzKPj4uXx+VA@mail.gmail.com>
 <bd46521c-a167-2872-fecb-2b0f32855a24@oracle.com> <20230418165105.q5s77yew2imkamsb@oracle.com>
 <ZD9rfsteIrXIwezR@debian.me> <CAOUHufa9-AKwwx7oVpQkV355TTmVSfi8roBKEsRjRNbeuGUkbw@mail.gmail.com>
 <20230419150923.s5vbpsjqq3hlcl7k@oracle.com>
In-Reply-To: <20230419150923.s5vbpsjqq3hlcl7k@oracle.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Thu, 20 Apr 2023 00:47:15 -0600
Message-ID: <CAOUHufaks2jcHSJbPj-zLrc=6FPjh7oB4ZCf8C3x_8=OMQEwKg@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/91] 5.15.108-rc1 review
To:     Tom Saeger <tom.saeger@oracle.com>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2023 at 9:09=E2=80=AFAM Tom Saeger <tom.saeger@oracle.com> =
wrote:
>
> On Tue, Apr 18, 2023 at 10:56:22PM -0600, Yu Zhao wrote:
> > On Tue, Apr 18, 2023 at 10:18=E2=80=AFPM Bagas Sanjaya <bagasdotme@gmai=
l.com> wrote:
> > >
> > > On Tue, Apr 18, 2023 at 10:51:05AM -0600, Tom Saeger wrote:
> > > > > Tom Saeger identified that the below commit moves it out of ifdef=
.
> > > > >
> > > > > commit 354ed597442952fb680c9cafc7e4eb8a76f9514c
> > > > > Author: Yu Zhao <yuzhao@google.com>
> > > > > Date:   Sun Sep 18 02:00:07 2022 -0600
> > > > >
> > > > >     mm: multi-gen LRU: kill switch
> > > > >
> > > > FWIW - partially backporting (location of cgroup_mutex extern) from=
:
> > > > 354ed5974429 ("mm: multi-gen LRU: kill switch")
> > > >
> > > > fixes x86_64 build for me.
> > > >
> > > > Regards,
> > > >
> > > > --Tom
> > > >
> > > > diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
> >
> > ...
> >
> > > Yu, would you like to provide formal backport?
>
> Nah - an easier fix was suggested by Waiman (remove the lockdep_assert_he=
ld line) and confirmed here:
>
> https://lore.kernel.org/stable/20230418192807.n3hggjak25tnat7i@oracle.com=
/
>
> >
> > Are you suggesting backporting the entire MGLRU patchset (>30 patches)?
> >
> > I do have the backport ready for 5.15 and multiple distros have taken
> > it.
>
> However, I am interested in testing 5.15 backport of MGLRU.
> Where might I find that?

git://github.com/yuzhaogoogle/linux mglru-5.15
