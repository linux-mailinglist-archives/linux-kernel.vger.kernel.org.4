Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05BE065A370
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 11:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbiLaKFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 05:05:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiLaKFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 05:05:51 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9139026D6
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 02:05:49 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id x37so17477376ljq.1
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 02:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W4oCVQWoL+YrgdFs4cASqQgdeV4AqJ33Y5f9pTDYOCE=;
        b=Uew+N6ZmTVWEy7vOkDvVjRkhVtXKmBeASt6IKSh96LvmQed9qcQQQJG0elt7FqyvqA
         9x3tquD8kjnX+3xaEMV/kS5u4Rj97xHL0Iiew0zIWcm99LYUQaj1UzesRy/3u60OLLo/
         PLJfDsTbkBy4Ap4YIXHmqQC12RI7o2Bk1L83d1Q5ghA006JhH7hr6KCRQj9o9pk9g7vb
         WDNICQiimP6IiGeeoFd/IAd4NBRYQYoeBuMUtWYIdEch5vE0eY1ZFfVAJMvVQbj8kTMR
         NLjk3YLyYVb97bf3URnnsaNR7jzYTELNl44ritJNS4GSOa+sxGIPiTl7md31qopNGivH
         mYrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W4oCVQWoL+YrgdFs4cASqQgdeV4AqJ33Y5f9pTDYOCE=;
        b=Sz6LcszfNpwp9Hzskdn+t0LwBlfyg+WJ1Gs1iyq70VDEAILw7uoeMtvHTn9zeyjcgJ
         hwXoHDgeevcJPjxgNy5mP0RbndOUFA/9tjxaGn+QgBY9DnKQaDy7yb69lWzWnjGoQPTJ
         D3pAvUY/dsCVi6JTWg0KZ4Yq18+yuAQDYQOBJ8HZfx0Wrjb6UHHd2nx1tbwfrrThyq3S
         goEm7vf8YO5sjhZnxQN5nL627ACs6LIEUFA6tfCn/L1KcJ9XHhHc8w5FMtrTM+EG4H0E
         6jzacElQWFNWIlLSnCmgi7XLkLfC3zPDKJtZwhL1O0FYfNljPNIIGpfGIjTYx1NHRzSP
         /pYA==
X-Gm-Message-State: AFqh2kotW3/L/sp9T9oCtFTs1Is/f3IpE94N2ry1v2EDfVQVcpMT3ceG
        gZqktn5FwbEUfCxUSWn8WepBHa0d+4wT0QcD/fM=
X-Google-Smtp-Source: AMrXdXsgZEU2nIeOADj6o7xR+s+oxvkrLjezwO8SnFv9c/g+WOImxkEC3K928QKoan4WXXq5+33pAwy7x0tiOi25fbI=
X-Received: by 2002:a2e:5405:0:b0:27f:b2cf:710 with SMTP id
 i5-20020a2e5405000000b0027fb2cf0710mr1076089ljb.263.1672481147751; Sat, 31
 Dec 2022 02:05:47 -0800 (PST)
MIME-Version: 1.0
References: <20221231055310.2040648-1-yoochan1026@gmail.com> <Y7AHvYfZreO/G/kT@kroah.com>
In-Reply-To: <Y7AHvYfZreO/G/kT@kroah.com>
From:   Yoochan Lee <yoochan1026@gmail.com>
Date:   Sat, 31 Dec 2022 19:05:36 +0900
Message-ID: <CALQpDLfMjAE9_VtMO6e_iiPrciFNbksLQT3AB3QTGwZCNf5=sA@mail.gmail.com>
Subject: Re: [PATCH] misc: hpilo: Fix use-after-free in ilo_open
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     matt.hsiao@hpe.com, arnd@arndb.de, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I haven't tested with a physical device cause I don't have a real device.
I found this bug through static analysis.

This type of bug is similar to [1] and [2].

And I'm sorry that my patch is incorrect.
It's my first time patching a Linux kernel myself.
So I'm not familiar with how to patch it well (For this reason, my
patches are referred to [1] and [2]).
Then, how should I patch it?

[1] https://lore.kernel.org/lkml/20220919040457.GA302681@ubuntu/
[2] https://lore.kernel.org/lkml/20220919101825.GA313940@ubuntu/

2022=EB=85=84 12=EC=9B=94 31=EC=9D=BC (=ED=86=A0) =EC=98=A4=ED=9B=84 6:58, =
Greg KH <gregkh@linuxfoundation.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Sat, Dec 31, 2022 at 02:53:10PM +0900, Yoochan Lee wrote:
> > --- a/drivers/misc/hpilo.h
> > +++ b/drivers/misc/hpilo.h
> > @@ -62,6 +62,7 @@ struct ilo_hwinfo {
> >       spinlock_t fifo_lock;
> >
> >       struct cdev cdev;
> > +     struct kref refcnt;
>
> This is obviously incorrect, please never have 2 reference counts for
> the same structure.
>
> greg k-h
