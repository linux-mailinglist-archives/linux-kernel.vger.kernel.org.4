Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E666E0A6A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 11:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjDMJmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 05:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjDMJmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 05:42:40 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC544EF2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 02:42:39 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id f188so46454645ybb.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 02:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681378958; x=1683970958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FXuvR6IorGk+vc4Sbx2+ljSRa/GREptQBSmjgKoDNBQ=;
        b=p5qruo+vwLOmiKdo9zfjlw8oOGsiW3ZhyU3s5t1eTAZWl1pBeBkTL6t40YHwQn3GFI
         NI2QEtrQ6G8kh5BFWJMngPiODpBFNej8mvd08VDINHZXAboshyC0dYi1xCG71aNdWeOA
         5MnmtW90zfH0DuhAQS2cJmGWyzQBx9Q+MkqvLvGxJ7jH+UwoAW89+VS2PcKvui2PvGn2
         Q+JKo81qMBYyAgUglWmMWLpwyByA/OgQQOUdHZir1BQHuF8oyUwcII7JzB3oyXxNkHOf
         AMSZYJ2XapdoXefH7JHc+a/P1YL5WtIb8e4TeAMQj45qzAbP8ApdjZDDLJJOo4FWnMC8
         8nlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681378958; x=1683970958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FXuvR6IorGk+vc4Sbx2+ljSRa/GREptQBSmjgKoDNBQ=;
        b=MDasMfM6VTwN4feZn1An+UIXNgJElTqX3ixBx491oLCTAiNEwnKp1Pgpzk7k8XaayX
         PBIQGnMf0vEGK5dj9aY0mYnF6lHU4B++zSlhNS/RIfRUewN6iJWulRbzorzTK0GZaONs
         GeJjzd0ifGymqaU++Dlb+DMSFcvJLjyipKQYcHKU41apYnzGnHLaSK3znA+Rj0dkYDrG
         OqVKPdKdPKgsAaUUMbUmE8WgWBIZyhv6A5wOnd89MXZ3KVZ/o8f1SJSNP9Oj5TIKv3o2
         RwsYhzD3CSwLq/3CMmdm0/IbMvow11QpysWARG3mH3Zory960S/aHWtVzbzwlQ9BKspp
         ukoA==
X-Gm-Message-State: AAQBX9cq4wKdSwevkP0XM0FinFBM0l4c+etTRfUHbIloyJrK6z7FTXI2
        mr16BqZR3EYIiodbCbquQE06n4fbFIjwdkDaXb2XaQ==
X-Google-Smtp-Source: AKy350aIn2eg4lF1zv8Kw+eVubZMSxHczXifNKoJzcDAryVU6K0a4Ip63GAMTioeux0MH1upuKU6C7L4gGonN+vmr4I=
X-Received: by 2002:a25:ae45:0:b0:b8f:62b7:e03c with SMTP id
 g5-20020a25ae45000000b00b8f62b7e03cmr190745ybe.1.1681378958351; Thu, 13 Apr
 2023 02:42:38 -0700 (PDT)
MIME-Version: 1.0
References: <CANX2M5ZRrRA64k0hOif02TjmY9kbbO2aCBPyq79es34RXZ=cAw@mail.gmail.com>
 <CAG_fn=V57m0om5HUHHFOQr9R9TWHtfm4+jO96Smf+Q+XjRkxtQ@mail.gmail.com> <CANX2M5bWPMDJGgD=xq33A3p96ii3wBOuy9UKYAstX4psdAGrrA@mail.gmail.com>
In-Reply-To: <CANX2M5bWPMDJGgD=xq33A3p96ii3wBOuy9UKYAstX4psdAGrrA@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 13 Apr 2023 11:42:01 +0200
Message-ID: <CAG_fn=WOZ2RTyTYrgV3JhsqESf-YCmj_FmbzJZdJogpZk8SnOw@mail.gmail.com>
Subject: Re: Possible incorrect handling of fault injection inside KMSAN instrumentation
To:     Dipanjan Das <mail.dipanjan.das@gmail.com>
Cc:     Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>,
        Marius Fleischer <fleischermarius@googlemail.com>,
        Priyanka Bose <its.priyanka.bose@gmail.com>
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

On Wed, Apr 12, 2023 at 8:24=E2=80=AFPM Dipanjan Das
<mail.dipanjan.das@gmail.com> wrote:
>
> On Wed, Apr 12, 2023 at 7:39=E2=80=AFAM Alexander Potapenko <glider@googl=
e.com> wrote:
>
> > Here are two patches that fix the problem:
> >  - https://github.com/google/kmsan/commit/b793a6d5a1c1258326b0f53d6e3ac=
8aa3eeb3499
> > - for kmsan_vmap_pages_range_noflush();
> >  - https://github.com/google/kmsan/commit/cb9e33e0cd7ff735bc302ff69c022=
74f24060cff
> > - for kmsan_ioremap_page_range()
> >
> > Can you please try them out?
>
> The second patch needs a small modification.
>
> The return value of `__vmap_pages_range_noflush` at Line 181
> (https://github.com/google/kmsan/commit/cb9e33e0cd7ff735bc302ff69c02274f2=
4060cff#diff-6c23520766ef70571c16b74ed93474716645c7ba81dc07028c076b6fd5ad27=
31R181)
> should also be assigned to `mapped`. With this modification, the patch
> works.

Good catch, thanks!
I'll send an updated version.
