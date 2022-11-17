Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4D3A62E693
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 22:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239416AbiKQVOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 16:14:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234997AbiKQVOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 16:14:41 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A7565E76
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 13:14:40 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id s12so4430805edd.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 13:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=voXeWb+QPjKes3H0GEUnCg0sCJ4iBXmH4ELS4bNeRjo=;
        b=lQ5vo2Bdc4fiK3vsDriKITSkd4NYFMZOqcmVYWtTY530icIftzFPZilgZcMYOvnk9d
         I/33Uwh1ltnAMlV+WXcPuhKvc8GcYgLle6mBS7qyuXou51ASShr5DLf7hqpqFZ+IhlRQ
         rSDz/INWQkkGunIB1Vz0CU60uvmHbADYTBiTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=voXeWb+QPjKes3H0GEUnCg0sCJ4iBXmH4ELS4bNeRjo=;
        b=LkuRyjbvaJHxZhzUcEJC1K7dTddjSFA+ZOxc4w7Z8w0hTpDkbL8RYGLunw7bI1yqHM
         VxS6spI1mtdEJXzdx7t6kADVZAK7dch22dp1+e9Gorz+1wZZR9BRn3YgcMFGNdpebJjZ
         3sIcsasBaYKLZpUxD9eS4l/CwQakmiRoi0sabV1svr07T4Yr8qQJ3hP/Q2hYbGyiY5Xv
         oYQrq5eqQDpJPtdD4nIjQeROmxsCnUH/IrYQhew53dbBSDCXITNgHACpNfvj8X0diLR6
         1mCOHFDHcWHYT9sB+mux/pcbXjnZ4HU4n4Bb+i1AGBvZtLytmYnCTqc5kf0Tn34uoxh5
         faGg==
X-Gm-Message-State: ANoB5pkhd0LPz1OycdRrD1b/Myo8YiSpD16vn6is74/0zK36/7lHO/rB
        NtbWqYnquS+/fWBLYfQTyz3stv+y+CHHIv6v
X-Google-Smtp-Source: AA0mqf52JejtSZUh24jG1GsEzISBNhy5nnhCW6/Jhx5mMiMsyR60Wj3B5hEpf06ZvC8EtK2y08aYrg==
X-Received: by 2002:a50:ee0d:0:b0:458:c339:4229 with SMTP id g13-20020a50ee0d000000b00458c3394229mr3695915eds.393.1668719677885;
        Thu, 17 Nov 2022 13:14:37 -0800 (PST)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id f16-20020a17090631d000b0073d81b0882asm835157ejf.7.2022.11.17.13.14.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 13:14:36 -0800 (PST)
Received: by mail-wr1-f53.google.com with SMTP id i12so2072654wrb.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 13:14:36 -0800 (PST)
X-Received: by 2002:a5d:53c4:0:b0:236:7741:fa7b with SMTP id
 a4-20020a5d53c4000000b002367741fa7bmr2614666wrw.138.1668719675985; Thu, 17
 Nov 2022 13:14:35 -0800 (PST)
MIME-Version: 1.0
References: <20221110145102.1.I51639dc112bbbe27259df6bdad56dbabd655d91a@changeid>
 <CAD=FV=V6HAwvKskWvggxx8J3y_PkiisPzY5YzMV8BMTb3oSxpg@mail.gmail.com>
In-Reply-To: <CAD=FV=V6HAwvKskWvggxx8J3y_PkiisPzY5YzMV8BMTb3oSxpg@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 17 Nov 2022 13:14:23 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WaBWR24BwgyiCA+mYUSt_=R2Mpdt8Wjo4w+9vyZz5mEA@mail.gmail.com>
Message-ID: <CAD=FV=WaBWR24BwgyiCA+mYUSt_=R2Mpdt8Wjo4w+9vyZz5mEA@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-edp: Use ktime_get_boottime for delays
To:     Drew Davenport <ddavenport@chromium.org>
Cc:     dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Nov 11, 2022 at 12:44 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Thu, Nov 10, 2022 at 1:51 PM Drew Davenport <ddavenport@chromium.org> wrote:
> >
> > ktime_get is based on CLOCK_MONOTONIC which stops on suspend. On
> > suspend, the time that the panel was powerd off is recorded with
> > ktime_get, and on resume this time is compared to the current ktime_get
> > time to determine if the driver should wait for the panel to power down
> > completely before re-enabling it.
> >
> > Because we're using ktime_get, this delay doesn't account for the time
> > that the device is suspended, during which the power down delay may have
> > already elapsed.
> >
> > Change to use ktime_get_boottime throughout, which uses CLOCK_BOOTTIME
> > which does not stop when suspended. This ensures that the resume path
> > will not be delayed if the power off delay has already been met while
> > the device is suspended.
> >
> > Signed-off-by: Drew Davenport <ddavenport@chromium.org>
> >
> > ---
> >
> >  drivers/gpu/drm/panel/panel-edp.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
>
> Nice!
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>
> My plan will be to land this to drm-misc-next early next week (Tuesday
> maybe?) unless someone has any objections.
>
> BTW: any chance you'd be willing to post against two similar drivers:
> panel-simple.c and panel-samsung-atna33xc20.c? They have nearly the
> same code (and, yes, these drivers are purposely copies since there
> was overall consensus that having one giant panel driver to handle all
> possible panels was getting far too confusing)

Breadcrumbs: after discussion, this got vacuumed up into a larger
series and is now at:

https://lore.kernel.org/r/20221117133655.2.Iebd9f79aba0a62015fd2383fe6986c2d6fe12cfd@changeid
