Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B516B6A17
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 19:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjCLS3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 14:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbjCLS3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 14:29:23 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A775BC8D
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 11:24:19 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-53d277c1834so201663407b3.10
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 11:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678645365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/wfw0Iou++3C7iUKYkrNdPM4+v/VqBNAAE+U9Nr7WdE=;
        b=KMrdFqbhwHAFL5M7zKYcMTVYiyHgZlxzXMkh+h5xlV96p73JAdDc8KItdU99J73s1h
         w24tH4UrF+0bciTf2SAbSghDfsAyhsOQOGaWu7Jdd1ODJksjNKEz7ZXYXT8u5Qg00FtV
         hW6W5HMjQe6650mDqj+axmYvWICwKwnrYI+6obhHW5vcW1L7HUEB8Xrapc6tLjb+O1Xf
         LU8sKhw4P338JjMOy993gq3CgEjvys0LIc8TPqm8Twnc0CDszbWWUPq5PqgSkeChoWP0
         LYp9r/awpn1wVBwurfax8i4nnEBQmlp39OX7rVgXewAZ6JeBP36u8SuvTQ0dL70fPrp3
         xX8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678645365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/wfw0Iou++3C7iUKYkrNdPM4+v/VqBNAAE+U9Nr7WdE=;
        b=BKin6YsPPADh5Jhc4dqVsQtm8/cEMyuwRDeotrWgx8DAoSlnFgF3cW2bQv+2HZqYFs
         5LVHm2yd0/6kMzQ371NFztymNNu7JElok/ObLOUkx0bsZNjXxF1KBIv71TvrIgpJkWbk
         EFEiLXrsGaU/WBPQdpJdZnQQlhL7aW2VITN+fYrY9p2VjFytdNsYYtwt+eVGP5MKEdHG
         d66CZBq3eZWwLsDSbyvKAE2lnKRZvw2NCntG1kF7GHcHNnqMc46qd2I6bQG8zLyTlJT6
         SBRhAeZtj3yWQy0pLG8JpEB3mZM8E7f/eLnOzaj890UaprVXY+/SlBXkSkIH5CTfAGEU
         33Jg==
X-Gm-Message-State: AO0yUKVM5mdaPQpX2BXyTZmi6k8DNhdtpbwqlqlspGZhL7jQPW8Nfn+i
        9BpFcRetB/LxKCGQwX6TslFpd3ORU8PisgzFwzu6ogbnFmc=
X-Google-Smtp-Source: AK7set+X75UgYxIhmzYfG/tdBM9xIWaVnEfdjrTwspuB7fkhMSTTd3VyRzSfVln6cp88PBUq2nXAlBA4xM5p/yaC6mE=
X-Received: by 2002:a81:b646:0:b0:541:a0cf:71c9 with SMTP id
 h6-20020a81b646000000b00541a0cf71c9mr628936ywk.7.1678645365170; Sun, 12 Mar
 2023 11:22:45 -0700 (PDT)
MIME-Version: 1.0
References: <ZA0FEyOtRBvpIXbi@bombadil.infradead.org>
In-Reply-To: <ZA0FEyOtRBvpIXbi@bombadil.infradead.org>
From:   Eric Van Hensbergen <ericvh@gmail.com>
Date:   Sun, 12 Mar 2023 13:22:34 -0500
Message-ID: <CAFkjPTmVbyuA0jEAjYhsOsg-SE99yXgehmjqUZb4_uWS_L-ZTQ@mail.gmail.com>
Subject: Re: 9p caching with cache=loose and cache=fscache
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     lucho@ionkov.net, asmadeus@codewreck.org,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
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

I was looking at kdevops the other day - cool stuff.  Was trying to
figure out how we could do v9fs CI with it.

Both cache=3Dloose and cache=3Dfscache currently don't validate via host.
I have a patch series which adds some new cache modes (readahead and
writeback) that give closer to the loose performance but with tighter
consistency (open-to-close) - these patches are in my ericvh/for-next
tree.  I've also started on some patches to add cache=3Dtight which will
do dir caching like loose but with validation, and potentially also
will add a new flag that will indicate how often loose should
revalidate.  There is also some discussion of decoupling fscache from
the revalidation policy.

So the stuff in for-next will make it into the next kernel, there is a
writeback fix patch that still has some bugs when cache=3Dfscache that
I'm working through, but the base patches add the new cache modes.
The new dir cache along with tight policy will hopefully get done in
the next month and so should be ready for next merge window as well.

       -eric

On Sat, Mar 11, 2023 at 4:47=E2=80=AFPM Luis Chamberlain <mcgrof@kernel.org=
> wrote:
>
> We've embraced 9p on kdevops [0] for support to let a guest use a host's
> path to install Linux. This works well except I notice that if the host
> makes new changes the guest does not see it. This just means the guest
> has to reboot every time before running 'make modules_install install -j =
8'
> and it is unexpected and not user friendly.
>
> I wanted to see if someone was working on fixing this yet. I've tested
> with both cache=3Dloose and cache=3Dfscache. We use msize 131072, no
> security and virtio-9p-pci.
>
> [0] https://github.com/linux-kdevops/kdevops
>
>   Luis
