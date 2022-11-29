Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E0F63CB0B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 23:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236845AbiK2W3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 17:29:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236713AbiK2W24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 17:28:56 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3156C6F80C
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 14:28:55 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id ml11so12319598ejb.6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 14:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z6DufAiLbikmJOcyvk/dpsDJdo2Yt6A4Va3UXdp6vn4=;
        b=bSbgHd7hgJCYLmAci5POgq7c9xzACAr/4CJtpAngdgrdC6coYb8uiZu2XqhLPmbQXT
         A7Azk3Hr3Y/t/ycCWOsv4JwIcmu4zG7GiR/cpPTpXl4AEw53lgECOhpbLTQ+zR5Da3se
         TdJURnDO7SI7EL6/spaUEq/f30sbEP7S4gDAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z6DufAiLbikmJOcyvk/dpsDJdo2Yt6A4Va3UXdp6vn4=;
        b=n3RQEQW0IUGCbJlEMU2oaQoXJaD76zNiuJo1a55DHfDoLcmh1eVVULPAE0+8oJVpxM
         IthopyK6XV5Vo4s2p0g8SlbU9AHOi4am3l0bmPy+0fvwX/ClHajIcBSxP9wsRqYdHYwp
         hSWi01/xWt1mh5Dwzr/esbintCUBqhXIBLtPzbdNnv4YsbReIaD44ytYmnJKPpzGm+Cw
         ZyMwYnQezCRANMjLKcuDMGn6Oiwb+sIXGIEYzOq/BdzziQ3agf9luGc+goXxafNJ9mK3
         6F+ZYE90fQlZcbmHb0ECA87oU4WOVuJBmi0pVHnaFVqAgHmexk1gynyLeekcHExqdbMD
         mJ1Q==
X-Gm-Message-State: ANoB5pnqHdrdU670Ondz+dTQRYB7bH0YyRZkp7ZZqQkmGQx3uut8ob99
        esXkOe7SQq2xPpaOw3Wak4HhRXTK78i61+xR
X-Google-Smtp-Source: AA0mqf5fd9xNnHSx5rvuBe+kRHzowHcQcvPbOzQY7sYsI19j0QboxEYPv3RPVZuziHo0Jsu/S3wr/Q==
X-Received: by 2002:a17:906:1484:b0:7ae:6746:f270 with SMTP id x4-20020a170906148400b007ae6746f270mr36917927ejc.728.1669760933362;
        Tue, 29 Nov 2022 14:28:53 -0800 (PST)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id f5-20020a056402150500b0045723aa48ccsm6668554edw.93.2022.11.29.14.28.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 14:28:52 -0800 (PST)
Received: by mail-wm1-f53.google.com with SMTP id p16so12000899wmc.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 14:28:52 -0800 (PST)
X-Received: by 2002:a05:600c:3109:b0:3cf:5731:53db with SMTP id
 g9-20020a05600c310900b003cf573153dbmr47280161wmo.85.1669760931831; Tue, 29
 Nov 2022 14:28:51 -0800 (PST)
MIME-Version: 1.0
References: <20221117133655.1.I51639dc112bbbe27259df6bdad56dbabd655d91a@changeid>
 <20221117133655.2.Iebd9f79aba0a62015fd2383fe6986c2d6fe12cfd@changeid> <CAD=FV=XzzS-kygLun7u7XMDVqLdtBtxfhdHP0YFQo4TxCTPkSA@mail.gmail.com>
In-Reply-To: <CAD=FV=XzzS-kygLun7u7XMDVqLdtBtxfhdHP0YFQo4TxCTPkSA@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 29 Nov 2022 14:28:39 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XGQr9iMBoTPRmaiV3rnK2QNJEZ5C9DhgVuWvVJ8mBGmQ@mail.gmail.com>
Message-ID: <CAD=FV=XGQr9iMBoTPRmaiV3rnK2QNJEZ5C9DhgVuWvVJ8mBGmQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] drm/panel-samsung-atna33xc20: Use ktime_get_boottime
 for delays
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

On Thu, Nov 17, 2022 at 1:14 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Thu, Nov 17, 2022 at 12:39 PM Drew Davenport <ddavenport@chromium.org> wrote:
> >
> > ktime_get_boottime continues while the device is suspended. This change
> > ensures that the resume path will not be delayed if the power off delay
> > has already been met while the device is suspended
> >
> > Signed-off-by: Drew Davenport <ddavenport@chromium.org>
> > ---
> >
> >  drivers/gpu/drm/panel/panel-samsung-atna33xc20.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
>
> You could have carried over from v1 [1]:
>
> ...which I guess also means that technically this series should have
> been marked v2, but not a huge deal.
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>
> [1] https://lore.kernel.org/r/20221110145102.1.I51639dc112bbbe27259df6bdad56dbabd655d91a@changeid

Pushed to drm-misc-next:

62e43673ca84 drm/panel-samsung-atna33xc20: Use ktime_get_boottime for delays
