Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FABC6348CA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 21:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234426AbiKVU5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 15:57:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233828AbiKVU5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 15:57:20 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B9A79E34
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 12:57:19 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id v124-20020a1cac82000000b003cf7a4ea2caso16235337wme.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 12:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JKuICPYKZ9k0XZnBRysJX6NiMCJfmExtlbNu8FtJP1I=;
        b=X7rHdLp79aV6wbOZPObE1MOz+0+MDECt6wlNvu+uY1NNoOlYVIqCJL5DvgsG8KQFdF
         BIc1lKsonKr3A7YnLdZc2/QOOwjpbmzw7wpOvmlvG7wSbyaVbQjwHFHX1f/TbjrIS2X5
         QPoF0PPuoXqDFuT2Aux8kGN0Zx7KMwcki8kzjob8WgN5o9wBPpNLwobv39BSnE+p/kS9
         9Z5VeoOsorHu+4AN+vLBSaAQ9CSqo6WnFNaRJEUCSpMvtLWsYpmZvf+Q1SqAkcnr2Srj
         3zM1T3fntRpoKo1z2GfCznG4kXdpyU4mDcIW5Xl0Z138dL1mgrEAnqqzJbnan15gVwlR
         b8Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JKuICPYKZ9k0XZnBRysJX6NiMCJfmExtlbNu8FtJP1I=;
        b=NBvWqTqcBw9rsExmYXWNDwojbj/00Q8a8/HJvH/iIbcpy3r/o2hxBoMIxt9Atzpts5
         2Yre4hOWM1ceKCUA2jZ0u+AdnPSo0g7or5Dy2LwZTdD84+xQ0S82HShBX1bGBp1lXlxw
         GIWn0RQJtZa/+GEyVSgOuS3LtUf+guOzeLrhk2YyI4rdg4bhc51CCC/WNEB3icevjStu
         aK17Gmrre0n+V9mk9rbBI6CpIOndIVG/O9u3cFBF04Pbm1wkj7Usq5KoK8FWsbMYry1j
         2rJQfy0MS75A5TJgaIPc0V+8eeGxROiWY8GbxgHSKE5uk26IiGLC4r6RITxSU3eyKo+Z
         gj6A==
X-Gm-Message-State: ANoB5pl9yDK1mG9hLhSPYPLewsrRNjhVCG017GFcmkfDPmFNgi0APYNS
        W8B+U6EoHdXbej36BBBV7D1FOOMzGH2PJGt67u6HXA==
X-Google-Smtp-Source: AA0mqf4F3pkKVLj9jQvWXUefdlx4PRRlHhEv8mRnnvN19zNb002yc4JGoH2K+TPdkcxmELriKHapH/fusiuvCszRuw0=
X-Received: by 2002:a05:600c:4920:b0:3cf:8b23:549c with SMTP id
 f32-20020a05600c492000b003cf8b23549cmr10830757wmp.174.1669150637535; Tue, 22
 Nov 2022 12:57:17 -0800 (PST)
MIME-Version: 1.0
References: <20221121102747.208289-1-naveen.n.rao@linux.vnet.ibm.com> <a9f0f8f1-96cd-f6a8-9dda-d4744b938f97@csgroup.eu>
In-Reply-To: <a9f0f8f1-96cd-f6a8-9dda-d4744b938f97@csgroup.eu>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 22 Nov 2022 12:57:05 -0800
Message-ID: <CAP-5=fXJf+1V5RF-m3e+AhK0Qg-yaJ1_2HL0CTOvp1xkK-1fDg@mail.gmail.com>
Subject: Re: [PATCH] perf test: Skip watchpoint tests if no watchpoints available
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        Disha Goel <disgoel@linux.vnet.ibm.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 11:19 AM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
>
>
> Le 21/11/2022 =C3=A0 11:27, Naveen N. Rao a =C3=A9crit :
> > On IBM Power9, perf watchpoint tests fail since no hardware breakpoints
> > are available. Detect this by checking the error returned by
> > perf_event_open() and skip the tests in that case.
> >
> > Reported-by: Disha Goel <disgoel@linux.vnet.ibm.com>
> > Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> > ---
> >   tools/perf/tests/wp.c | 12 +++++++-----
> >   1 file changed, 7 insertions(+), 5 deletions(-)
> >
> > diff --git a/tools/perf/tests/wp.c b/tools/perf/tests/wp.c
> > index 56455da30341b4..cc8719609b19ea 100644
> > --- a/tools/perf/tests/wp.c
> > +++ b/tools/perf/tests/wp.c
> > @@ -59,8 +59,10 @@ static int __event(int wp_type, void *wp_addr, unsig=
ned long wp_len)
> >       get__perf_event_attr(&attr, wp_type, wp_addr, wp_len);
> >       fd =3D sys_perf_event_open(&attr, 0, -1, -1,
> >                                perf_event_open_cloexec_flag());
> > -     if (fd < 0)
> > +     if (fd < 0) {
> > +             fd =3D -errno;
> >               pr_debug("failed opening event %x\n", attr.bp_type);
> > +     }
>
> Do you really need that ?
>
> Can't you directly check errno in the caller ?

errno is very easily clobbered and not clearly set on success - ie,
it'd be better not to do that.

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> >
> >       return fd;
> >   }
> > @@ -77,7 +79,7 @@ static int test__wp_ro(struct test_suite *test __mayb=
e_unused,
> >
> >       fd =3D __event(HW_BREAKPOINT_R, (void *)&data1, sizeof(data1));
> >       if (fd < 0)
> > -             return -1;
> > +             return fd =3D=3D -ENODEV ? TEST_SKIP : -1;
> >
> >       tmp =3D data1;
> >       WP_TEST_ASSERT_VAL(fd, "RO watchpoint", 1);
> > @@ -101,7 +103,7 @@ static int test__wp_wo(struct test_suite *test __ma=
ybe_unused,
> >
> >       fd =3D __event(HW_BREAKPOINT_W, (void *)&data1, sizeof(data1));
> >       if (fd < 0)
> > -             return -1;
> > +             return fd =3D=3D -ENODEV ? TEST_SKIP : -1;
> >
> >       tmp =3D data1;
> >       WP_TEST_ASSERT_VAL(fd, "WO watchpoint", 0);
> > @@ -126,7 +128,7 @@ static int test__wp_rw(struct test_suite *test __ma=
ybe_unused,
> >       fd =3D __event(HW_BREAKPOINT_R | HW_BREAKPOINT_W, (void *)&data1,
> >                    sizeof(data1));
> >       if (fd < 0)
> > -             return -1;
> > +             return fd =3D=3D -ENODEV ? TEST_SKIP : -1;
> >
> >       tmp =3D data1;
> >       WP_TEST_ASSERT_VAL(fd, "RW watchpoint", 1);
> > @@ -150,7 +152,7 @@ static int test__wp_modify(struct test_suite *test =
__maybe_unused, int subtest _
> >
> >       fd =3D __event(HW_BREAKPOINT_W, (void *)&data1, sizeof(data1));
> >       if (fd < 0)
> > -             return -1;
> > +             return fd =3D=3D -ENODEV ? TEST_SKIP : -1;
> >
> >       data1 =3D tmp;
> >       WP_TEST_ASSERT_VAL(fd, "Modify watchpoint", 1);
> >
> > base-commit: 63a3bf5e8d9e79ce456c8f73d4395a5a51d841b1
