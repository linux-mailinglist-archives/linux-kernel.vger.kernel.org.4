Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145F06F86F1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 18:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjEEQnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 12:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbjEEQnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 12:43:10 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9CC016355
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 09:43:06 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-52c759b7d45so1705954a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 09:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683304986; x=1685896986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=24yRi1qjnWZisFpP+n/4/JukjZ0Kcgnz8WEqUSF8Rwc=;
        b=S2sfM88FxwFvchAFp3KAzpcSRt0acemz7/xmUrNhlF4medSZEG9Ip5zbYeVTGLiBX0
         Uy+XgOUgvess51BrTKJYsOb3s8LbQeJgD8LBDSmVk1brOb9vmAxj++qdO+tTKoffexYc
         2MlUtSoNk2SlF0bqCkexSkpSDDM3uZHWykvKk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683304986; x=1685896986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=24yRi1qjnWZisFpP+n/4/JukjZ0Kcgnz8WEqUSF8Rwc=;
        b=O6Y2p16BV/RXKQUKWW6Nb6sTqOnmlD6pduPHfWBO6YYgmF06TT5/vl6GskY0mkByHr
         mqcqTcN+HDfZqDdSdEHcC1nr20Igk9M2QG/r3ARhoJ2FJB0cQm1rPWgOLTiuJfKbvkYU
         327LJHjP3HEJky7FF6LoElkcZDm4I1bSeSL7TqzcbOEh87nu76ksBC/EbZZ8O2DOkSju
         0aOHaQLIgTUdskphLe0GWYqynDzrFvEeN6+WFsMaE+6uLAswxSS9jfNJHBViOwarx3MO
         8zXOzguIu1JIarUZV9aJdQMoJlNQiMNBF+gwfSG3ghm+pZFlfGGnfyjTB8xeOiOPX0lz
         petg==
X-Gm-Message-State: AC+VfDxtxuyFRVb1NH5Qr3C62ixmTyu8FoWTU0h8zK+DjaUXfXrCP4Pr
        FZlSBy4pUUUpFtKIIEGF2gn+SFmPJ7szLWFifKWR1Q==
X-Google-Smtp-Source: ACHHUZ4lwwbxB9MtVTfIyIDKgv5PXNKsUEoOM+vA2CiBMedBi+yFNJzbUGwCseHog53wvxF/F6fMSYXIQzA38qxlhqk=
X-Received: by 2002:a17:90b:1d0c:b0:247:1997:6a1f with SMTP id
 on12-20020a17090b1d0c00b0024719976a1fmr2327984pjb.12.1683304986334; Fri, 05
 May 2023 09:43:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230504170942.822147-1-revest@chromium.org> <20230504170942.822147-5-revest@chromium.org>
 <66900d0ad42797a55259061f757beece@ispras.ru>
In-Reply-To: <66900d0ad42797a55259061f757beece@ispras.ru>
From:   Florent Revest <revest@chromium.org>
Date:   Fri, 5 May 2023 18:42:55 +0200
Message-ID: <CABRcYmKXrPE0oP9R=qsn=mL3Nwm_mVqT-r-TvOvowTdiuYU--A@mail.gmail.com>
Subject: Re: [PATCH 4/4] kselftest: vm: Add tests for no-inherit memory-deny-write-execute
To:     Alexey Izbyshev <izbyshev@ispras.ru>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, catalin.marinas@arm.com,
        anshuman.khandual@arm.com, joey.gouly@arm.com, mhocko@suse.com,
        keescook@chromium.org, david@redhat.com, peterx@redhat.com,
        nd@arm.com, broonie@kernel.org, szabolcs.nagy@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 4, 2023 at 10:30=E2=80=AFPM Alexey Izbyshev <izbyshev@ispras.ru=
> wrote:
>
> On 2023-05-04 20:09, Florent Revest wrote:
> > Add some tests to cover the new PR_MDWE_NO_INHERIT flag of the
> > PR_SET_MDWE prctl.
> >
> > Signed-off-by: Florent Revest <revest@chromium.org>
> > ---
> >  tools/testing/selftests/mm/mdwe_test.c | 95 ++++++++++++++++++++++++--
> >  1 file changed, 89 insertions(+), 6 deletions(-)
> >
> > diff --git a/tools/testing/selftests/mm/mdwe_test.c
> > b/tools/testing/selftests/mm/mdwe_test.c
> > index 91aa9c3099e7..9f08ed1b99ae 100644
> > --- a/tools/testing/selftests/mm/mdwe_test.c
> > +++ b/tools/testing/selftests/mm/mdwe_test.c
> > @@ -22,6 +22,8 @@
> >
> >  TEST(prctl_flags)
> >  {
> > +     EXPECT_LT(prctl(PR_SET_MDWE, PR_MDWE_NO_INHERIT, 0L, 0L, 7L), 0);
> > +
>
> PR_MDWE_NO_INHERIT is defined to an int constant, so passing it to
> prctl() without a cast to long or similar may produce wrong code on
> 64-bit targets (ABIs typically don't require the compiler to clear the
> upper 32 bits of a 64-bit register when passing a 32-bit argument, so
> va_arg(arg, unsigned long) in prctl() implementation might get junk).

Ah, good catch Alexey! :)

> Arguably, defining PR_MDWE_* to plain int constants is a bug, or at
> least a footgun for users of uapi headers.

As part of the next version of this series, I'm happy to:
1- change the existing PR_MDWE_REFUSE_EXEC_GAIN to 1UL
2- introduce PR_MDWE_NO_INHERIT as 2UL

But I'm surprised that most of the macros in
include/uapi/linux/prctl.h are the same sort of footguns already ?
Hasn't it been an issue for other prctls yet ?
