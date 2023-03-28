Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61AEF6CC9FE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 20:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjC1S0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 14:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjC1S0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 14:26:17 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE8A1987
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 11:26:17 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-545cb3c9898so171385087b3.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 11:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680027976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2AGWQH5bNreKYweyVy17yy5EiRLAFTbclRLyhJW+HkY=;
        b=TWVo5kbMLITL44SiH7QYY6gA56iFqydbBz9LpsNG5pQX0UxGhBqRfyS0OE/RXAmH5j
         Hwk8TtVX+HakFvAzvGW2g0GXaRdZROgwBGtPu7L7/Q3yY3zms8BPJnqkR0QPIKdTncLp
         HZtgOmOWFaHKXnXy2TYecgnS9H4iKxZE5eCIauQnrCsTRwf2nOLmt4yNhORFLzzy3jjh
         aaA7V5Ds1dG8Z5ot6VgV6/pJkt4N7faikn90E80JBJpg3oILIC/Y13TJ1Yx8mN109R6+
         morxv3RFkhojp+HqzJWacObN6b57bqtOIszmjrqM1PEBcmL1idawXM4ArUq+A9QJPJwr
         gUUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680027976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2AGWQH5bNreKYweyVy17yy5EiRLAFTbclRLyhJW+HkY=;
        b=JZGrACPcAWQh1e6P+udNYZ+0je09SHKXG/S1Jr15cW9KYwJgUrNcuhYn6KTbTk6PaH
         M6vjNU2QRyppd1Hc7hWMurm+ZRWbLvJcs9XbJRQM8jrGD5C4PqaJK/A1KL8AF2jzLY6L
         CtzDtJ8goWvITKpbW64dFTHFX9lZ5Vn5UKOTiji4UaUbcjmoHRoCz5498R932WX25Ray
         gAorVDU8dwC+/So44+fyqwgEEfP025O83WDGw+jQtzTwm3DhilNx34/0HwhV9Fy/2I7c
         pBXXezG89OIiBGpgsUJarur+Gp+YL4oYQEiqMLg/T6H4fOrNiXrg6WH/Xr8yfhVktKnA
         f1rA==
X-Gm-Message-State: AAQBX9cv17oPsTCuEIli2reDvQdHjf6wT9jk1HOGLmEZIiJdN9SmHU15
        /43dllpg/odjICLZatBg+qheJZ7Ze3bv9P/yIV8CuuO6AvIJr5oX05Ar2wU=
X-Google-Smtp-Source: AKy350ZyAqttORMKJqMeGkcjgyqFvxCtrRDSSph/mceXQCWZauj3OekieipEEg3Sxxt2ulFFbJjJEdmb7AnYqhB9DCQ=
X-Received: by 2002:a81:a908:0:b0:545:7164:49ac with SMTP id
 g8-20020a81a908000000b00545716449acmr7679518ywh.5.1680027976159; Tue, 28 Mar
 2023 11:26:16 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20230328125807epcas1p1606c068a9043d6581a1fbdd30e7c53a2@epcas1p1.samsung.com>
 <20230328125818.5574-1-jaewon31.kim@samsung.com>
In-Reply-To: <20230328125818.5574-1-jaewon31.kim@samsung.com>
From:   John Stultz <jstultz@google.com>
Date:   Tue, 28 Mar 2023 11:26:05 -0700
Message-ID: <CANDhNCpNDvK3uKvamNwrxpsaqFZH24BBLrdFUo0Uucu1ic0WdA@mail.gmail.com>
Subject: Re: [PATCH] dma-buf/heaps: c9e8440eca61 staging: ion: Fix overflow
 and list bugs in system heap:
To:     Jaewon Kim <jaewon31.kim@samsung.com>
Cc:     tjmercier@google.com, sumit.semwal@linaro.org,
        daniel.vetter@ffwll.ch, akpm@linux-foundation.org,
        hannes@cmpxchg.org, mhocko@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, jaewon31.kim@gmail.com
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

On Tue, Mar 28, 2023 at 5:58=E2=80=AFAM Jaewon Kim <jaewon31.kim@samsung.co=
m> wrote:
>
> Normal free:212600kB min:7664kB low:57100kB high:106536kB
>   reserved_highatomic:4096KB active_anon:276kB inactive_anon:180kB
>   active_file:1200kB inactive_file:0kB unevictable:2932kB
>   writepending:0kB present:4109312kB managed:3689488kB mlocked:2932kB
>   pagetables:13600kB bounce:0kB free_pcp:0kB local_pcp:0kB
>   free_cma:200844kB
> Out of memory and no killable processes...
> Kernel panic - not syncing: System is deadlocked on memory
>
> An OoM panic was reported, there were only native processes which are
> non-killable as OOM_SCORE_ADJ_MIN.
>
> After looking into the dump, I've found the dma-buf system heap was
> trying to allocate a huge size. It seems to be a signed negative value.
>
> dma_heap_ioctl_allocate(inline)
>     |  heap_allocation =3D 0xFFFFFFC02247BD38 -> (
>     |    len =3D 0xFFFFFFFFE7225100,
>
> Actually the old ion system heap had policy which does not allow that
> huge size with commit c9e8440eca61 ("staging: ion: Fix overflow and list
> bugs in system heap"). We need this change again. Single allocation
> should not be bigger than half of all memory.
>
> Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>

Hey,
  Thanks so much for sending this out! Looks reasonable to me, the
only issue is the commit subject line could be a bit better.

Maybe instead:
  "dma-buf/heaps: system_heap: Avoid DoS by limiting single
allocations to half of all memory"

Otherwise,
Acked-by: John Stultz <jstultz@google.com>

thanks
-john
