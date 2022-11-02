Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69CD2615B4B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 05:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiKBEGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 00:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiKBEGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 00:06:20 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91C3222A3
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 21:06:18 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 129so380654ybb.12
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 21:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y7q/A8cK4lFjsqmVIn5Mfr4kAsZbPdDkiEzXwz0w1Vg=;
        b=GQAo7WFgMf8nx0oaYeot2D1TVPwvSh72XjAHoNA3vbV5ZbQlA/dhH20dOX92mFtVL7
         0/6PsCq/bs3HJiomA7z3hjK3VsTtj7Z3wDiRt09Tds7e+OoLjVfGgwnEKQFD01vV/S9x
         iBxVJnkE6Cw9AvdcgBAn6mJJ/Z3Hst4A4Yp65wwZGHDQINmHGFUzabLSL5K60UjWLtrH
         CJJw7xA5yyQzcYk2q+Tm6ONKd3zjcZYV/QZfxvdwqzLWTQ5OWxxWivBHNX69WJuMDSu/
         IPBXgXfUtGHyXih1wKTD5FBh4lh5cVLUKVYiGQU8qzgua6pr01g8lBU4a2kRLNSsvwBM
         2JSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y7q/A8cK4lFjsqmVIn5Mfr4kAsZbPdDkiEzXwz0w1Vg=;
        b=TkF+7DHOrCflrgcvyjcMkbIaS+0Omy750k69UQr1bLIdnU3AuTNLUJyBM3wtRMz7A7
         Kb5C2yz7X3Ii5k8SfmRDfAh+YXgigITW5ul4S4NqugfWb2zeuH5XB5eXNjv0U2qkLONK
         ZmFX1fhDQ7d4K/e3focNrtJo6KlIXGycH5xCFnTYih7Jdf6L0RT9ry72YNH/7Yf3e2BY
         wL7v6fXo8gwHpu9djTLsEXD1wi6Oudr2Kfzwns9nl8/v0Zdjzzgjh8/VcBfOzOXHPLjh
         xTSUYXw99LueQHbmMCI18fyw/s4W9GLDaLxT8FWtSd2lLQQ36b4LQT+ZsGo7iSAyYfkd
         qTSw==
X-Gm-Message-State: ACrzQf2VsXj7r2hX8PMcbRLw4SEzzjF3c9zNsNQ8ERQJXRdoQdGeKqN5
        TksO7YPSqfn4ze4WGzlV2794jG4pVn/WHMUBBIOpvQ==
X-Google-Smtp-Source: AMsMyM6uSEEmMpMLvmmVnp2oLoTlp3kSUR2nD1z57edMiHtU7vnTTypBvkQ61CoihBZTToY0AohmDm3tk9ujz/9dKy0=
X-Received: by 2002:a25:d914:0:b0:6cb:13e2:a8cb with SMTP id
 q20-20020a25d914000000b006cb13e2a8cbmr21642273ybg.231.1667361977716; Tue, 01
 Nov 2022 21:06:17 -0700 (PDT)
MIME-Version: 1.0
References: <20221102021549.12213-1-linyunsheng@huawei.com>
 <CANn89iJWyLQDHHJXNHb78zpX=At1oyqPaUmeQ5-GuzX2YOxGDQ@mail.gmail.com> <9cdb2fff-9eee-564d-f8df-38ff7125dad2@huawei.com>
In-Reply-To: <9cdb2fff-9eee-564d-f8df-38ff7125dad2@huawei.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 1 Nov 2022 21:06:06 -0700
Message-ID: <CANn89iJxeT6uumtc+2boTGSe7rhsW7GT-cY81t=YaS0QmXJHAQ@mail.gmail.com>
Subject: Re: [PATCH net-next] ipvlan: minor optimization for ipvlan outbound process
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Tue, Nov 1, 2022 at 8:47 PM Yunsheng Lin <linyunsheng@huawei.com> wrote:
>
> On 2022/11/2 11:23, Eric Dumazet wrote:
> > On Tue, Nov 1, 2022 at 7:15 PM Yunsheng Lin <linyunsheng@huawei.com> wrote:
> >>
> >> Avoid some local variable initialization and remove some
> >> redundant assignment in ipvlan outbound process.
> >>
> >> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> >
> > Really I do not see the point of such a patch, making future backports
> > more difficult.
>
> As the ipvlan outbound process is in the fast path, avoiding the
> unnecessary steps might be worth the backport cost.

Have you measured the gains after your patch is applied ?

Please give us some numbers, but I bet this will be pure noise,
given the overall ipvlan cost.

>
> Anyway, it is more of judgment call, not a rule, right?

The thing is, you are asking us maintainers/reviewers to spend time on
a non-trivial patch,
with no clear indication of why this is worth our time, and why this
is worth future merge conflicts in backports.


>
> >
> > Changing old code like that should only be done if this is really necessary,
> > for instance before adding a new functionality.
> > .
> >
