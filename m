Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6DAD73290F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 09:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245170AbjFPHic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 03:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbjFPHia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 03:38:30 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11DF81FF7
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 00:38:29 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-51878f8e541so435164a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 00:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686901107; x=1689493107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j9HtoWwqGbgtEf/5EsF/+Q8jXO/MVPbsLyMQC67iLCk=;
        b=raHYCTMxMkgdF/Ic0WyVRzoA5Z3PZJ8J3oPfOEr5JJr3VIZROzo39uTK/MhsjXI9rv
         o0j4Ho7dzbjbj6WLakxNQZOwSWTY/nBf9KUsKsOfJcnKCXW9LkMMbJP7k4hTz7+i6Csl
         1TNBBLMM4U7orsg9HxATqGLaFS/4NH2HyJiTap2oLgf4nSpkPKC3X3QaZAChSz1BECU8
         oCPpa98bKmNgEADhgCArajuAQnaCZ0kmiEF6mCCA/9v+Tt01VZSYUh7rbp1X6AGhbi0M
         r9h+IEpwWXUBX1XfXGKbh4rQ4c5PfoD5BOzOI7Hv4VRgVDQrUWcChC7Ay70AvBknH2bm
         MctA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686901107; x=1689493107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j9HtoWwqGbgtEf/5EsF/+Q8jXO/MVPbsLyMQC67iLCk=;
        b=NUO/vS96/5kvpIsOtAkGX9zrAho5hXAlhpI+qwlqsv6lmOqqxEN0184yYNaPJknT48
         A3vRz2FNEFBu54P6btBOLiSL2zhcQaY8ZYHNmTOj+B1EFKBLTnuw+DqvHhcSuWrOmkWh
         NgPsH6K9h/eNDsafzT4GCig59koarcELpzJJZo/MJXZRWlNFIBuVYKLkge/t59k5zOmK
         TTInLQQ0sb01+p/UIAUKGKv1WhiJavzNTeeZXUfFPsOqFYTlBcqnysRFaQbpGsyM+sSJ
         neYA93LF6D+k+2ZVZXJtWcKAEOIlVlKbqRlo+QkW2iPGIm50Kulb7LPdrui5uyAtH8jS
         wQ/A==
X-Gm-Message-State: AC+VfDy/wa6Va8crSbeSZ3S/h/8Wp+FSnzXUN+oK8uo/6GVTH8/Kw4Ps
        6I2tVY0Ge21eaSaofxiGqcgoFenkhVtPvQrmOmuo+Q==
X-Google-Smtp-Source: ACHHUZ5qBpwKkKtVtdZEG5c2DEr5/clF3Aq7qfIhliNSqNSzhU9ctycSqVNVwKum6jdlnGqGvAlrUXk2TRckHLZW3cg=
X-Received: by 2002:a17:906:f250:b0:978:6e73:e841 with SMTP id
 gy16-20020a170906f25000b009786e73e841mr771948ejb.35.1686901107361; Fri, 16
 Jun 2023 00:38:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230615034830.1361853-1-hezhongkun.hzk@bytedance.com>
 <CAOUHufZBUEm1P7gm0nFkPSFkNg2fPbs3v3qhL-R9m5yFNoW2YA@mail.gmail.com>
 <CA+PVUaTqNTSYkTy9yCFF=Y+xkimgM+3YQRF7EYr1UruesQnJrg@mail.gmail.com>
 <CAJD7tka-=ppaheVxn2-f6u0egBp8kOHYAK0bBudC62SKkZPk5w@mail.gmail.com> <CACSyD1MepXm4EL3o6OscAjRKQhAWZZ5xZKS8a0TXLAazUE+MpA@mail.gmail.com>
In-Reply-To: <CACSyD1MepXm4EL3o6OscAjRKQhAWZZ5xZKS8a0TXLAazUE+MpA@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Fri, 16 Jun 2023 00:37:50 -0700
Message-ID: <CAJD7tka4Uc1DhNzKbrj71vGyVVA12bJivPUQU7P0DOinunLgGg@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH 1/3] zram: charge the compressed RAM to
 the page's memcgroup
To:     =?UTF-8?B?6LS65Lit5Z2k?= <hezhongkun.hzk@bytedance.com>
Cc:     Yu Zhao <yuzhao@google.com>, minchan@kernel.org,
        senozhatsky@chromium.org, mhocko@suse.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Fabian Deutsch <fdeutsch@redhat.com>
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

On Thu, Jun 15, 2023 at 9:41=E2=80=AFPM =E8=B4=BA=E4=B8=AD=E5=9D=A4 <hezhon=
gkun.hzk@bytedance.com> wrote:
>
> > Thanks Fabian for tagging me.
> >
> > I am not familiar with #1, so I will speak to #2. Zhongkun, There are
> > a few parts that I do not understand -- hopefully you can help me out
> > here:
> >
> > (1) If I understand correctly in this patch we set the active memcg
> > trying to charge any pages allocated in a zspage to the current memcg,
> > yet that zspage will contain multiple compressed object slots, not
> > just the one used by this memcg. Aren't we overcharging the memcg?
> > Basically the first memcg that happens to allocate the zspage will pay
> > for all the objects in this zspage, even after it stops using the
> > zspage completely?
>
> It will not overcharge.  As you said below, we are not using
> __GFP_ACCOUNT and charging the compressed slots to the memcgs.
>
> >
> > (2) Patch 3 seems to be charging the compressed slots to the memcgs,
> > yet this patch is trying to charge the entire zspage. Aren't we double
> > charging the zspage? I am guessing this isn't happening because (as
> > Michal pointed out) we are not using __GFP_ACCOUNT here anyway, so
> > this patch may be NOP, and the actual charging is coming from patch 3
> > only.
>
> YES=EF=BC=8C the actual charging is coming from patch 3. This patch just
> delivers the BIO page's  memcg to the current task which is not the
> consumer.
>
> >
> > (3) Zswap recently implemented per-memcg charging of compressed
> > objects in a much simpler way. If your main interest is #2 (which is
> > what I understand from the commit log), it seems like zswap might be
> > providing this already? Why can't you use zswap? Is it the fact that
> > zswap requires a backing swapfile?
>
> Thanks for your reply and review. Yes, the zswap requires a backing
> swapfile. The I/O path is very complex, sometimes it will throttle the
> whole system if some resources are short , so we hope to use zram.

Is the only problem with zswap for you the requirement of a backing swapfil=
e?

If yes, I am in the early stages of developing a solution to make
zswap work without a backing swapfile. This was discussed in LSF/MM
[1]. Would this make zswap usable in for your use case?

[1]https://lore.kernel.org/linux-mm/CAJD7tkYb_sGN8mfGVjr2JxdB8Pz8Td=3Dyj9_s=
BCMrmsKQo56vTg@mail.gmail.com/

>
> >
> > Thanks!
> >
