Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42813720873
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 19:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236732AbjFBRgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 13:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236683AbjFBRgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 13:36:18 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B481B9
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 10:36:16 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-33baee0235cso6205ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 10:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685727376; x=1688319376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VYGuxy8Ej8tRmw8Uag/5H01fuHpZsdaCh2dA+H02kPM=;
        b=AiObH6k1yxEvPCx51OIA8EV79fxDTSyeBg01wdrmxpGcD6UdUsMYOJwf/c1hToEGp5
         A9G+k6Wo8HljKcNncggTq9A+iEMYRTwo5i7E6l6f632glXN9vPAFmTI79exvZuaynYDK
         bHyfpIBzFsV+rTeMQqtycEU01a6xAzUg4SZ8IHuVkBV650P7H190xDpMbgqcZbUeQFa4
         qHkWSrLYV1CaZ4ehzMflooIUi8EQKCfcJn1kIxUEYhIhDGtnSiG6+s9uqnFTjJ8GFe7t
         /lDwet166VDDHCfma+oh0a26VEDHNnYP8zmPTljMn8h+37iC2EP9ZsMcOFpem893YACv
         p5CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685727376; x=1688319376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VYGuxy8Ej8tRmw8Uag/5H01fuHpZsdaCh2dA+H02kPM=;
        b=I/sGYcGmqf2jlXtFiQzp81ukQZBlrOd00W9+V61gcqmns2uQBCgubduCAGN/Al/dPz
         337ItmoJ406kMfneS3TRIYtpTfZYwoHTwUuCgzseaZ3T6ABNsbRPUmGkAPEDQE5HI5Xi
         YBmsfnGgZ4ZW9+A9YorI0ApLRDVQQBdp2J9pJW9/vBCcDwhw0wZdk4ZXZVBoMIgNJG5+
         eBZcWfKNIFitK2p3dDOWRvPqc3EJkUnLPFODpNSqbA6+I/FvYX2u4bLVqk4tDn3csAkQ
         P0J/zSnLqzldjEiV5zqjI8937caXwWm0sf5Yip+0AirFaKaspJhbdTLZ3CPn3jIF8tC8
         EiMw==
X-Gm-Message-State: AC+VfDybSEPw+boJhWrzuwpC1OeCIrZ2VEaftqSV8WDe7JD9fRcRtLjI
        0VcYBrQ2skl8Qvmpl1+X+7AxGHSBt59TZ2vQO3Oy7Q==
X-Google-Smtp-Source: ACHHUZ6wj7whRMGkFLe9wDNGh8O3OzAA6um6O9lWia/t8YK+4adlmlDW6jCDZkxTijAzhN1cAzOrQ9c3l6HGhUEm6Fw=
X-Received: by 2002:a05:6e02:164a:b0:33c:c3ed:889c with SMTP id
 v10-20020a056e02164a00b0033cc3ed889cmr270037ilu.12.1685727375853; Fri, 02 Jun
 2023 10:36:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230602092949.545577-1-ryan.roberts@arm.com> <20230602092949.545577-3-ryan.roberts@arm.com>
 <CAOUHufb5R_+eMxM28WWxXubPzUO4+c_1UHoXVAcWsKEyG1ndAQ@mail.gmail.com> <640f81aa-035e-9f42-c848-096e4c9e014c@arm.com>
In-Reply-To: <640f81aa-035e-9f42-c848-096e4c9e014c@arm.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Fri, 2 Jun 2023 11:35:39 -0600
Message-ID: <CAOUHufakZjOK445jkMorPsqkdZuwKGxmym4+0p=s2NtB1GtbBQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] mm/damon/ops-common: atomically test and clear
 young on ptes and pmds
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        SeongJae Park <sj@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, damon@lists.linux.dev
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

On Fri, Jun 2, 2023 at 11:14=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> On 02/06/2023 17:35, Yu Zhao wrote:
> > On Fri, Jun 2, 2023 at 3:30=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.c=
om> wrote:
> >>
> >> It is racy to non-atomically read a pte, then clear the young bit, the=
n
> >> write it back as this could discard dirty information. Further, it is
> >> bad practice to directly set a pte entry within a table. Instead
> >> clearing young must go through the arch-provided helper,
> >> ptep_test_and_clear_young() to ensure it is modified atomically and to
> >> give the arch code visibility and allow it to check (and potentially
> >> modify) the operation.
> >>
> >> Fixes: 3f49584b262c ("mm/damon: implement primitives for the virtual m=
emory address spaces").
> >
> > Just to double check: was "Cc: stable@vger.kernel.org" overlooked or
> > deemed unnecessary?
>
> It was overlooked - incompetance strikes again! I was intending to cc the=
 whole
> series. What's the best way to fix this? Can I just add stable in cc on r=
eply to
> the cover letter or will I have to resend the lot?

Resending the whole series would be more reliable for the process (and
easier for Andrew). You might want to include a few new
reviewed/acked-bys anyway (I just acked the next patch).
