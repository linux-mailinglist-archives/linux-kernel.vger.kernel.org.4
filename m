Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F084667151F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 08:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjARHhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 02:37:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjARHgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 02:36:24 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C585953B3F
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 22:54:34 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id e130so7508812yba.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 22:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W7K3U7J7q8qsq+5DG9vwDrzu00VfL71S9pskbFVpOu8=;
        b=VG7uElnzUvxurmTqRBuxo8pIwPUkjkLFH93ePb1S/RRa+9e3X/gk+Ays3E/Aj0ScsZ
         nEeKOt1yq8l1m3AGFkVNLFOqdiVl0sCWCopXdj7VO1VtPQgimxzGXt1+eXS2tbCN9u40
         BAhw4kdTo8TD8U6/gcv6b0PI84ehLnvOo1sjT0K+aHk+7Oi12GbPSpzbYefzcr0nKVUW
         ztb9AdK/xZcin5xFlajIdgGeHPf3ml9uxwvnuVSwFTB5EAIVJgHxpj+qxr9Jo1TvIkej
         5xn2dBDFfgN9a7yuwZWDpxIuBjr+aOMXxUiZcPo7wpuQFPqRInmSsHJwBaVphTJB77p8
         CU7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W7K3U7J7q8qsq+5DG9vwDrzu00VfL71S9pskbFVpOu8=;
        b=5pa6j+ISS1G5wGK4dTvmMva7pOmhx0bmBYeA0S8B4SCiWElIrJWLS4SZlkQyHvhUIu
         tF1/9TSk9wBRmyuLHLxtcI1tZUP3CkPkom1muyVA16tIH+GXP0JMAlRKGqo5koUw7RJT
         JXdrM8ihUEKUn4lcmgGmmhUv++8XxkRLw4hSlF5nN8ZP51CLGmtp7nZEcGiUxW/BYW7y
         7c1mp7BpVrh4zTcwKLsx2QueLqWIj3EQ9sKw6DyvRvqg4zdpaCEl423VcSy8OtPL644F
         VqJUfGRzo/Q2Dx3pfcedOuyloXMaJFCREufTRhBt2KB+VF8+WAGaztplID3WePK4cdHa
         Rk5Q==
X-Gm-Message-State: AFqh2kodUUG8ZWaIDGDfR3sG9QlqRPeokfADYCLsOO2UktISn036WlED
        bj2N2Ihqf01yE84GTo4h55p2WFa8XZg7ooE3QN8Q
X-Google-Smtp-Source: AMrXdXu0f4baWvNWXO3k4JGT4NSiS5o+ls9nfcsi3GrRwWaGIwkKPTGqimdXbFSdiOkRg974+cYEIe9bl8tX7aaaPgo=
X-Received: by 2002:a25:d451:0:b0:7ce:4650:5e5a with SMTP id
 m78-20020a25d451000000b007ce46505e5amr753159ybf.123.1674024873890; Tue, 17
 Jan 2023 22:54:33 -0800 (PST)
MIME-Version: 1.0
References: <CGME20230117082521epcas1p22a709521a9e6d2346d06ac220786560d@epcms1p6>
 <20230117082508.8953-1-jaewon31.kim@samsung.com> <20230117083103epcms1p63382eee1cce1077248a4b634681b0aca@epcms1p6>
In-Reply-To: <20230117083103epcms1p63382eee1cce1077248a4b634681b0aca@epcms1p6>
From:   John Stultz <jstultz@google.com>
Date:   Tue, 17 Jan 2023 22:54:22 -0800
Message-ID: <CANDhNCpKY5Af059ok8ZcgJ=wt7NaorZxqQXaTS848CwY0LNFiw@mail.gmail.com>
Subject: Re: [PATCH] dma-buf: system_heap: avoid reclaim for order 4
To:     jaewon31.kim@samsung.com
Cc:     "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
        "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>,
        "T.J. Mercier" <tjmercier@google.com>
Content-Type: text/plain; charset="UTF-8"
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

On Tue, Jan 17, 2023 at 12:31 AM Jaewon Kim <jaewon31.kim@samsung.com> wrote:
> > Using order 4 pages would be helpful for many IOMMUs, but it could spend
> > quite much time in page allocation perspective.
> >
> > The order 4 allocation with __GFP_RECLAIM may spend much time in
> > reclaim and compation logic. __GFP_NORETRY also may affect. These cause
> > unpredictable delay.
> >
> > To get reasonable allocation speed from dma-buf system heap, use
> > HIGH_ORDER_GFP for order 4 to avoid reclaim.

Thanks for sharing this!
The case where the allocation gets stuck behind reclaim under pressure
does sound undesirable, but I'd be a bit hesitant to tweak numbers
that have been used for a long while (going back to ion) without a bit
more data.

It might be good to also better understand the tradeoff of potential
on-going impact to performance from using low order pages when the
buffer is used.  Do you have any details like or tests that you could
share to help ensure this won't impact other users?

TJ: Do you have any additional thoughts on this?

thanks
-john
