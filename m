Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40276B9BB4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 17:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjCNQfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 12:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjCNQfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 12:35:38 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09315FE92
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 09:34:58 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id h11so3644471ild.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 09:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678811698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dTUo1zy3Yf2SEGOt4NXzm+Sz0YHam92eDgEkCkzygro=;
        b=OfUkXIjGb3mHVPvW05uFb4MDikddcsTmIhLvBVJQ10F4JDtyO1kFQ4BprDnhVbTOPQ
         ktxNlHpWKlUzhRtiQ/9EtIp4in1y1GlwIM6lV8A6Ux92FYY72VMlglersjb6yNY8E/hn
         4Tz2KUb0HzZPLAvyfG9oKwlmfnCCbQKaiuC7wd2jIyDGE//gwi8PIDCgORuFBwUwixyl
         TkZZH5xCo51aE7hV4UXkzaR/JstS/1JY8kCyweA3DXii6+vfRNN7TD6UuLEiYBxIwyyv
         u3q6D8umveLOrlarc1Fliz2LmohBvqikPhoN4lVbj+Cxr39w76TVQXnjF+71bTASv2lb
         LrXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678811698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dTUo1zy3Yf2SEGOt4NXzm+Sz0YHam92eDgEkCkzygro=;
        b=nm0cSruWc9xtvlBPEIn2T12PcjLLw6SOlEEdrmSi5hs5TpnPegF4CVr91edUCp7P+X
         zZ84jqQW3qKN1UMdUpGnNaXg07qKqo7NWFXBpLcUAFzIGvSPhozC0nhlq/iC7JId4dZk
         omZk2mlHTcXa3mM3wSVTgyVnubjlO0FNI86vjvaC07l/5S/m5qVZmJfwuElGNSgFhF2U
         T3gc362Bi7cR4DA3ukmQEqHt0mG6tuo2gRP4TCltx5obPJxa4jya4Ph7Z9FDAFDxTl9r
         XK7gMF/ecP1TkCOkakiWPsiB/by/1yFeOrPcvxh7LGbf+K3fSncAeixrgHX2SMJctJlM
         JorA==
X-Gm-Message-State: AO0yUKVkVTOJEjVzScaOJPV8dEvAovQLJwxJDqTCSXkHL86vGUqdVTjj
        ltW5NoFir4YKXja2DpfCLaXxhwZwK5DWWnXxw+Yg9Q==
X-Google-Smtp-Source: AK7set+dUs802nOfxxhPX49VrJJOwVZL6sjEfLYK9Ao4UZxrZGa7dW02ez/BpntdYOan9jZ5k1Q9y3bZr2KT8yhkSRQ=
X-Received: by 2002:a05:6e02:889:b0:322:ecc3:e5c3 with SMTP id
 z9-20020a056e02088900b00322ecc3e5c3mr168967ils.13.1678811697674; Tue, 14 Mar
 2023 09:34:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230313080201.2440201-1-tmricht@linux.ibm.com>
 <20230313080201.2440201-2-tmricht@linux.ibm.com> <CAP-5=fW=xVYzkgQ4vUyzkiK-oQjUQ=hLwcLT6D8VjtVCXH5oSQ@mail.gmail.com>
 <ZA9sYL/re/aNVpo+@kernel.org> <1ee6884a-2d92-68d9-0917-3ae4f5390714@linux.ibm.com>
In-Reply-To: <1ee6884a-2d92-68d9-0917-3ae4f5390714@linux.ibm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 14 Mar 2023 09:34:46 -0700
Message-ID: <CAP-5=fUtJsvAtrhe4xESoQc8U15WJ8BWREbH51OKoA218uJLzw@mail.gmail.com>
Subject: Re: [PATCH 2/6] tools/perf/json: Add cache metrics for s390 z16
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        sumanthk@linux.ibm.com, svens@linux.ibm.com, gor@linux.ibm.com,
        hca@linux.ibm.com
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

On Tue, Mar 14, 2023 at 1:20=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.c=
om> wrote:
>
> On 3/13/23 19:33, Arnaldo Carvalho de Melo wrote:
> > Em Mon, Mar 13, 2023 at 08:22:44AM -0700, Ian Rogers escreveu:
> >> On Mon, Mar 13, 2023 at 1:30=E2=80=AFAM Thomas Richter <tmricht@linux.=
ibm.com> wrote:
> >>>
> >>> Add metrics for s390 z16
> >>> - Percentage sourced from Level 2 cache
> >>> - Percentage sourced from Level 3 on same chip cache
> >>> - Percentage sourced from Level 4 Local cache on same book
> >>> - Percentage sourced from Level 4 Remote cache on different book
> >>> - Percentage sourced from memory
> >>>
> >>> For details about the formulas see this documentation:
> >>> https://www.ibm.com/support/pages/system/files/inline-files/CPU%20MF%=
20Formulas%20including%20z16%20-%20May%202022_1.pdf
> >>>
> >>> Outpuf after:
> >>>  # ./perf stat -M l4rp -- dd if=3D/dev/zero of=3D/dev/null bs=3D10M c=
ount=3D10K
> >>>  .... dd output deleted
> >>>
> >>>  Performance counter stats for 'dd if=3D/dev/zero of=3D/dev/null bs=
=3D10M count=3D10K':
> >>>
> >>>                  0      IDCW_OFF_DRAWER_CHIP_HIT         #     0.00 l=
4rp
> >>>            431,866      L1I_DIR_WRITES
> >>>              2,395      IDCW_OFF_DRAWER_IV
> >>>                  0      ICW_OFF_DRAWER
> >>>                  0      IDCW_OFF_DRAWER_DRAWER_HIT
> >>>              1,437      DCW_OFF_DRAWER
> >>>        425,960,793      L1D_DIR_WRITES
> >>>
> >>>       12.165030699 seconds time elapsed
> >>>
> >>>        0.001037000 seconds user
> >>>       12.162140000 seconds sys
> >>>
> >>>  #
> >>>
> >>> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> >>> Acked-By: Sumanth Korikkar <sumanthk@linux.ibm.com>
> >>
> >> Acked-by: Ian Rogers <irogers@google.com>
> >
> > Thanks, applied the first two patches, please address the review
> > suggestions for patches 3-6 and resubmit only those.
> >
> > The patches will be in the public perf-tools-next branch later today.
> >
> > - Arnaldo
> >
>
> I would really prefer the current implementation without using "ScaleUnit=
": "100%"
> The reason is that these formulars are given to me from the s390 Performa=
nce team.
> They want to use the exact same formulars on all platforms running on s39=
0
> which includes z/OS and z/VM. This way they are sure to get the same numb=
ers.
>
> Hope this background info helps.

For the series:
Acked-by: Ian Rogers <irogers@google.com>

Using ScaleUnit won't change the result. A ScaleUnit of "100%" means
scale the result up by multiplying by 100 and then apply the % after
the value. Another nit is having metrics that place their units in the
name, like _percent, is usually a sign the name can be better. Perhaps
we can follow up with some clean up.

Thanks,
Ian

> Thanks a lot.
> --
> Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, German=
y
> --
> Vorsitzender des Aufsichtsrats: Gregor Pillen
> Gesch=C3=A4ftsf=C3=BChrung: David Faller
> Sitz der Gesellschaft: B=C3=B6blingen / Registergericht: Amtsgericht Stut=
tgart, HRB 243294
>
