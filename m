Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F73647BC6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 03:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiLICAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 21:00:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiLICAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 21:00:16 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B727D063
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 18:00:16 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id z8-20020a17090abd8800b00219ed30ce47so6573316pjr.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 18:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E+MDk20pNjNOTwRWwrQTCQOLe1CumfU1Adn6VxC+as0=;
        b=BzslQxGVzxXy/aPFzhxWGpXiNlSPY/Lv9nV/fQlD26dRU7Sgf2DZNfRJpckwFp6xXg
         PGeriX/ghvqGkP8Sct/fH9M0zj99MVD6PrTXcu2sTLtWRnwlUsnwFSwDly/cVk2Ikj6x
         hB+bHmTpQABHhg/S1MdBRr7R6/RhCWSInpu02IzNS2vCVTIYaq0V6GGHomgig0Wnu9eX
         eIO0ONE8OIIkYUJyWPPI0esJScQvflb9r35XYkLDdk4ofAhIBHsBQvkBzIWp9yzuCoby
         fCN79mT4E0YoaKHwYSVmVVp1GZOm6UHi7wuyf6UzjmG6SZNqk3JHu90bJ9hcWzteNPh+
         jKvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E+MDk20pNjNOTwRWwrQTCQOLe1CumfU1Adn6VxC+as0=;
        b=IdFSUeCA1gEP1a/1O7ptVsXZ1dHvnkjmfhDcORRUJzj6/BnqRvuCDOBIsrG75dXYNJ
         Q4Qsqi4QYPZ01JO07T+DXkdJk3cpEEWAiy0Wj/0qTI6pWDitHFNEgkRWqVkdzcZSXgZF
         o2XB+RUah9mdS1X6FH5TxQ3JJ1O2yrDvSQFB9CLf3edYg3OzZvEqtZVb5YnT7E9pwN9z
         Inr1pcCZF+XQ3E6hNDNays6543A2YEPFY3lpMRNVQxlgeSRzC+R0WnAgLAfVRbt4xMZI
         91PhW+3ADWvrD+tf3Xrd54tfDLoRtHR5zN3kLrMzKi8NTrsDWol4xsBmPHoJeh2cj0Kt
         uYcQ==
X-Gm-Message-State: ANoB5pkFCXeyVa0GBg1d4qHBY3qDwlp6q63dtlaIq6Jbc1hqg9FKm3DG
        UJCEos146mhvgYigRg5KO+UxydeNOgW2xSnHFbg=
X-Google-Smtp-Source: AA0mqf7NK83iZvBvzZ1jzKTh+sSUtdbYdDycl7fTBUeWcCjGlGBqi8ivE1nf0u/ugEUtjuuZeLCKlh/faAWEZLE5Lqs=
X-Received: by 2002:a17:902:e8c3:b0:186:5de2:e17e with SMTP id
 v3-20020a170902e8c300b001865de2e17emr81874555plg.35.1670551215498; Thu, 08
 Dec 2022 18:00:15 -0800 (PST)
MIME-Version: 1.0
References: <20221208180209.50845-1-ryncsn@gmail.com> <20221208180209.50845-4-ryncsn@gmail.com>
 <Y5I2RiQzH/kFD6zX@casper.infradead.org>
In-Reply-To: <Y5I2RiQzH/kFD6zX@casper.infradead.org>
From:   Kairui Song <ryncsn@gmail.com>
Date:   Fri, 9 Dec 2022 10:00:02 +0800
Message-ID: <CAMgjq7DXqrcMvfFt6Ue_gXharkdjL01GGy8zaVrXDM5Uj4j6Jg@mail.gmail.com>
Subject: Re: [PATCH 3/5] swap: fold swap_ra_clamp_pfn into swap_ra_info
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> =E4=BA=8E2022=E5=B9=B412=E6=9C=889=E6=
=97=A5=E5=91=A8=E4=BA=94 03:09=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Dec 09, 2022 at 02:02:07AM +0800, Kairui Song wrote:
> > From: Kairui Song <kasong@tencent.com>
> >
> > This make the code cleaner. This helper is made of only two line of
> > self explanational code and not reused anywhere else.
> >
> > And this actually make the compiled object smaller by a bit:
> >
> >           text    data     bss     dec     hex filename
> > Before:   9502     976      12   10490    28fa mm/swap_state.o
> > After:    9470     976      12   10458    28da mm/swap_state.o
>
> FYI, you can use scripts/bloat-o-meter to get a slightly more
> useful analysis of object code changes.
>

Thanks! That's very helpful info, I got following output from bloat-o-meter=
:

./scripts/bloat-o-meter mm/swap_state.o.old mm/swap_state.o
add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-35 (-35)
Function                                     old     new   delta
swap_ra_info.constprop                       512     477     -35
Total: Before=3D8388, After=3D8353, chg -0.42%

I'll attach this info in commit message from now on.
