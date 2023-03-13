Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA636B7DCC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 17:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbjCMQiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 12:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjCMQib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 12:38:31 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53532231DB
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 09:38:23 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id r4so1248846ilt.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 09:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678725502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FUBPIHS7V4Q1J3EDjJkhS4iBtdM7mneCmDYx2gD8EE4=;
        b=EYLuGvnXzray12IPhIFwaWr41OwuQ8LHrNB4RFiJKBMZw7DKHMGdZoqPQGab93b2My
         uGsYP2d1YF449FVNq4ipp9zwWu2qYiAyqcd/y9FuiRNkc/lBvi5tpFHe5B7pOuPPM0EN
         lDP8ajZc/RZ+S9p6NMA8xVr3LE3bmqAYeykLsCE56E7ujqa2QipVZJSK2rBEpmLWIdl5
         Ab+n56fZynvLZjtKjHMTMOdRH4DICNkPDN7ENMtpjGeeVWnWkcOx01n+jv3EsU8x0zHR
         NQ4KRnwW+mwl3ytV6fYEcTfseVL8BwgAO7RRBxOHCNaNAGkvi0TUvoU82TOYcQjfVqGl
         p1xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678725502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FUBPIHS7V4Q1J3EDjJkhS4iBtdM7mneCmDYx2gD8EE4=;
        b=40pyL6g9eeLbIvTx8WNWwq5+ZvL/8jLoZXbRHg5B7+sC/cfQBNp6i3Z1mtPNtrioNx
         wimnYVjYc4Jn0eghYg76JpFefVoeeIvHqWQwUQ+n798oli/LWmXFq3KETLykIZ5gNmPJ
         YxaxG9l/+q9Q8SyxvDVJuljJBpiT7C5xmrVOxMilpJhiLAhxvaDWiYzDyV9SFhgSzJXJ
         N/C4C3GEf5C0/AT4wHaxApsBzWXdx0X//DekA7223hmfGG3IED9q7Q+KBNI5THSHP1FP
         d81jY7F/PCwUL6awn8+X0QQCa5NCTUawYG49bjYND69X2Kbdlq/4UwT6pUGQ1BRIoEGP
         ncew==
X-Gm-Message-State: AO0yUKVD9kW/fYE3Bnid0PD2xB5XanW4U6muLwkJ5xlk5FtUfghkMwMG
        uwwlMStIZWgUzquK9z3jUE6M2nNPKE9E1dG0DVkynQaXE97DCPhbJam5sQ==
X-Google-Smtp-Source: AK7set//MiSR1y0fInfR6CmYoF+xGcuyeneWkLRWCEDxxFJo+xHqYWalC5eD2RviS7mBu1Ae0FMF4LD2qwwBmOhU5OE=
X-Received: by 2002:a92:cb49:0:b0:313:fa72:d9aa with SMTP id
 f9-20020a92cb49000000b00313fa72d9aamr193949ilq.0.1678725501894; Mon, 13 Mar
 2023 09:38:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAP-5=fWxF6in4vQyGuh=0kpAYEXAYZN_KobXCY=TX2oxssZ+HQ@mail.gmail.com>
 <Y7w2qshoCEjKKVlz@kernel.org> <CAP-5=fUeC2nhUhFN69+sL687csSsoi5=ZEkRH70vUy+kTiF52g@mail.gmail.com>
 <CAP-5=fVaH0p4NkKiQSxaxZnT5zR=hbwSArO2n0L7tCNZwBumKQ@mail.gmail.com>
In-Reply-To: <CAP-5=fVaH0p4NkKiQSxaxZnT5zR=hbwSArO2n0L7tCNZwBumKQ@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 13 Mar 2023 09:38:10 -0700
Message-ID: <CAP-5=fXWDPzuFrrY+uKnfoa5gO9eEfGUsbCyXB8AS7Tz0ZX=jw@mail.gmail.com>
Subject: Re: Google Summer-of-Code 2023
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        paranlee <p4ranlee@gmail.com>,
        Madhu patel <patelmadhu06@gmail.com>,
        Anup Sharma <anupnewsmail@gmail.com>,
        Lukas Molleman <lukas.molleman@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Feb 22, 2023 at 7:58=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> The Linux Foundation was selected as a GSoC organization for 2023!
> https://summerofcode.withgoogle.com/programs/2023/organizations/the-linux=
-foundation
>
> This means we're looking for contributors until March 19th:
> https://developers.google.com/open-source/gsoc/timeline

A reminder of the GSoC timeline. Applications open in a week;

* February 22 - March 19
Potential GSoC contributors discuss application ideas with mentoring
organizations

* March 20 - 18:00 UTC
GSoC contributor application period begins

* April 4 - 18:00 UTC
GSoC contributor application deadline

Thanks,
Ian

> Some project ideas are listed here:
> https://wiki.linuxfoundation.org/gsoc/2023-gsoc-perf
>
> Please help to share!
>
> Thanks,
> Ian
>
> (Resend in plain text because of LKML's HTML filters)
