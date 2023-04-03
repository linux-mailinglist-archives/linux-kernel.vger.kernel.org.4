Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9E96D4CDE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 17:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233101AbjDCP5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 11:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233132AbjDCP5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 11:57:33 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D79269A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 08:57:03 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-3e392e10cc4so1211621cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 08:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680537420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RL7+7L2nykApN9Uu3qr1Vlz4J5VLm0XSe5hWatHC2UA=;
        b=RvusrN5Grx0iSSZ1EitY9Ozul7j3yF2w2pelTCj9ingDDaNXluye819rbmn54bduOy
         mb9J+2MPN30EHgXolrhZyxSskXx18K9q8K/YqVWTU6zXe80O+3TJ7exICT3C9bvUemLx
         1gg96EkQl5bJdaUikm2d3iAqpDk7TZ5BGU03x7CzPMzrE4M3fzkdAazrb9KvqcscI3MT
         soymh5l0VN9Elo5iEVyP+ovOoq0QHQPldydzgb2D9+D6SyIMKh5oZToeoXYg7npzaF5G
         DnFCTOyEkHH655GjFWG4pYCN6R0p52LEBZQjdAYVC6wfYXE453OO5h/aISmK3M7k6SjF
         i/pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680537420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RL7+7L2nykApN9Uu3qr1Vlz4J5VLm0XSe5hWatHC2UA=;
        b=uZjptQ+bZKZFIfrw4NlpJWuKAoFd/9j902YlTRWr95iFlqIJ3jyLV14HSa17vjnzLH
         gybPSOhq/d+WxbrfGOvLc2RAotd08w943ipKtXncx1C/ka5l/h5Pf02G4hyg98DlGxGd
         kXO9YEb9CrY5zg/CdcjYDrbePUJV1V36ANx0SynAQ95pkXS8zlHxWstiM7StN0Mbn5AF
         IpQUyuIT8ZginqnkMGjLbTN0W/+a43W8sBtYCxrIYUYlYBPxcxRfQ7iCXfYntf6kwhOX
         /AcMR5JRzqPW7+nNo12Vhky6cYYvSyMUi8eIExMbmiWRWn0uw8IxGZs+JXeu/0qafFrl
         Ggsg==
X-Gm-Message-State: AAQBX9ctr3KVWEVYRDKE4PvSzX4CVulBy1/yn5Iv4FOCGns3rTDGdTLE
        SFIfECwULZcGQ0LMdng6N8S2GO0ExcIgFPXQqMFkoY3BhensPcrSKLQ=
X-Google-Smtp-Source: AKy350ap9pELEFkSHtmBKd6EJjD2gLVI9H1B0gyBQzpEjTNYD0Z/tjQrI1rxRpI/cJb66ymxQwqn8yZnd0JVjy9HOj4=
X-Received: by 2002:a05:622a:c:b0:3b9:f696:c759 with SMTP id
 x12-20020a05622a000c00b003b9f696c759mr638521qtw.10.1680537420407; Mon, 03 Apr
 2023 08:57:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAP-5=fWxF6in4vQyGuh=0kpAYEXAYZN_KobXCY=TX2oxssZ+HQ@mail.gmail.com>
 <Y7w2qshoCEjKKVlz@kernel.org> <CAP-5=fUeC2nhUhFN69+sL687csSsoi5=ZEkRH70vUy+kTiF52g@mail.gmail.com>
 <CAP-5=fVaH0p4NkKiQSxaxZnT5zR=hbwSArO2n0L7tCNZwBumKQ@mail.gmail.com>
 <CAP-5=fXWDPzuFrrY+uKnfoa5gO9eEfGUsbCyXB8AS7Tz0ZX=jw@mail.gmail.com>
 <CAP-5=fVHK9VqMs=px3ZzKjinFG4t+oOZ8x2=65_jjds4DiSXLg@mail.gmail.com> <CAP-5=fUTAABzK2e_S3kFYV8jWCrHKfj10wPpTnthQjCLy7d2Gg@mail.gmail.com>
In-Reply-To: <CAP-5=fUTAABzK2e_S3kFYV8jWCrHKfj10wPpTnthQjCLy7d2Gg@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 3 Apr 2023 08:56:47 -0700
Message-ID: <CAP-5=fXdgbJNms5Hy5tw_UxwAeaxn2QCtCphFc4nosEcA92tVw@mail.gmail.com>
Subject: Re: Google Summer-of-Code 2023
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        paranlee <p4ranlee@gmail.com>,
        Madhu patel <patelmadhu06@gmail.com>,
        Anup Sharma <anupnewsmail@gmail.com>,
        Lukas Molleman <lukas.molleman@gmail.com>,
        n2 h9 <n2h9z4@gmail.com>, can.kucukaslan@ug.bilkent.edu.tr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 3:00=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Mon, Mar 27, 2023 at 2:22=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > On Mon, Mar 13, 2023 at 9:38=E2=80=AFAM Ian Rogers <irogers@google.com>=
 wrote:
> > >
> > > On Wed, Feb 22, 2023 at 7:58=E2=80=AFPM Ian Rogers <irogers@google.co=
m> wrote:
> > > >
> > > > The Linux Foundation was selected as a GSoC organization for 2023!
> > > > https://summerofcode.withgoogle.com/programs/2023/organizations/the=
-linux-foundation
> > > >
> > > > This means we're looking for contributors until March 19th:
> > > > https://developers.google.com/open-source/gsoc/timeline
> > >
> > > A reminder of the GSoC timeline. Applications open in a week;
> > >
> > > * February 22 - March 19
> > > Potential GSoC contributors discuss application ideas with mentoring
> > > organizations
> > >
> > > * March 20 - 18:00 UTC
> > > GSoC contributor application period begins
> > >
> > > * April 4 - 18:00 UTC
> > > GSoC contributor application deadline
> > >
> > > Thanks,
> > > Ian
> >
> > A reminder that the application period closes in just over a week:
> > https://developers.google.com/open-source/gsoc/timeline
> > April 4 - 18:00 UTC
> > GSoC contributor application deadline
> >
> > Thanks,
> > Ian
>
> If you are looking for ideas on how to write a good proposal, PSF has
> a collection of previously accepted proposals:
> https://blogs.python-gsoc.org/en/
>
> You can also see the final report of Riccardo Mancini:
> https://lore.kernel.org/lkml/3c4f8dd64d07373d876990ceb16e469b4029363f.cam=
el@gmail.com/
>
> Thanks,
> Ian

A reminder that the GSoC application deadline is tomorrow.

Thanks,
Ian

>
>
> >
> > > > Some project ideas are listed here:
> > > > https://wiki.linuxfoundation.org/gsoc/2023-gsoc-perf
> > > >
> > > > Please help to share!
> > > >
> > > > Thanks,
> > > > Ian
> > > >
> > > > (Resend in plain text because of LKML's HTML filters)
