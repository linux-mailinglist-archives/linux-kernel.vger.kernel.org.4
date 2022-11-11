Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFC37626320
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 21:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234381AbiKKUoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 15:44:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbiKKUog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 15:44:36 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7293A60345
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 12:44:35 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id a67so9149811edf.12
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 12:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NnLqisDFGKGyEcOivxewv5QdcxXzGz5YXiWHVm2gs7Q=;
        b=jR2w8l/5qKL+O2Vvh57BDW7q1LHOcBDLQI+WmEiDLEw+ZYD0o/H9jLuNB/UBnBIqHL
         qrprw4ujpYS8N0i8zKaDbjhsyAuAwObSkeEB5FXAcHT4+OvwPNhzZV7SXieYcttnpP+g
         h/qeHb81Bubu/MGUENEVonrJL2iwTB1LfSxCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NnLqisDFGKGyEcOivxewv5QdcxXzGz5YXiWHVm2gs7Q=;
        b=cPf3v6MG0FtsbFb9W1PqzbiFPUr9aiBz5ITZLZTlAPXIw7TS0R07uQxiX6uUWqV3AW
         P8SyyXxSh9UCyhWVZdt/a4coYWTWiHrWepXzX1XtBfCL0b7lsbrR41UtyqGkYekbXj8V
         KvTJBclxFYrPqRdQ7EslswlHfTRoq7bOhHinIHV5DcFij/XoEZfO1mvXcwzqeTDJc5xz
         YBG35CP8iGBRY1Ndzc+uykXV9x1xuMtBf0E1SLdZj1zRwSLBpgf70xQVc9lKqDeYy/L/
         gNfrJNb1vycxxDkxQ2z+JPqSnvDkxbGal2ChMR2YjTIn+Q6W2xthQ5wsX9s1FOJha3TC
         LYyQ==
X-Gm-Message-State: ANoB5pkVVZsBGMMd5KR7K+Db0ptDJ8/ppxWrzODKz84dM0NDCDJrA46D
        /8kIyvlwUb7hUcYB+K57dzaVqUBpDSlo1nAJ
X-Google-Smtp-Source: AA0mqf612oOHFvt5Pn0u0kEv889XBXO0APRpfpWqvNjsWgtLaUeWktmjGYpRrk4s48pw2tvu+gSLPg==
X-Received: by 2002:aa7:d396:0:b0:462:67bf:c64e with SMTP id x22-20020aa7d396000000b0046267bfc64emr3182893edq.20.1668199473767;
        Fri, 11 Nov 2022 12:44:33 -0800 (PST)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id q35-20020a05640224a300b00461e4498666sm42430eda.11.2022.11.11.12.44.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Nov 2022 12:44:33 -0800 (PST)
Received: by mail-wm1-f46.google.com with SMTP id c3-20020a1c3503000000b003bd21e3dd7aso6298589wma.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 12:44:33 -0800 (PST)
X-Received: by 2002:a7b:c459:0:b0:3cf:8e70:f34f with SMTP id
 l25-20020a7bc459000000b003cf8e70f34fmr2325334wmi.93.1668199472638; Fri, 11
 Nov 2022 12:44:32 -0800 (PST)
MIME-Version: 1.0
References: <20221110145102.1.I51639dc112bbbe27259df6bdad56dbabd655d91a@changeid>
In-Reply-To: <20221110145102.1.I51639dc112bbbe27259df6bdad56dbabd655d91a@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 11 Nov 2022 12:44:20 -0800
X-Gmail-Original-Message-ID: <CAD=FV=V6HAwvKskWvggxx8J3y_PkiisPzY5YzMV8BMTb3oSxpg@mail.gmail.com>
Message-ID: <CAD=FV=V6HAwvKskWvggxx8J3y_PkiisPzY5YzMV8BMTb3oSxpg@mail.gmail.com>
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

On Thu, Nov 10, 2022 at 1:51 PM Drew Davenport <ddavenport@chromium.org> wrote:
>
> ktime_get is based on CLOCK_MONOTONIC which stops on suspend. On
> suspend, the time that the panel was powerd off is recorded with
> ktime_get, and on resume this time is compared to the current ktime_get
> time to determine if the driver should wait for the panel to power down
> completely before re-enabling it.
>
> Because we're using ktime_get, this delay doesn't account for the time
> that the device is suspended, during which the power down delay may have
> already elapsed.
>
> Change to use ktime_get_boottime throughout, which uses CLOCK_BOOTTIME
> which does not stop when suspended. This ensures that the resume path
> will not be delayed if the power off delay has already been met while
> the device is suspended.
>
> Signed-off-by: Drew Davenport <ddavenport@chromium.org>
>
> ---
>
>  drivers/gpu/drm/panel/panel-edp.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Nice!

Reviewed-by: Douglas Anderson <dianders@chromium.org>

My plan will be to land this to drm-misc-next early next week (Tuesday
maybe?) unless someone has any objections.

BTW: any chance you'd be willing to post against two similar drivers:
panel-simple.c and panel-samsung-atna33xc20.c? They have nearly the
same code (and, yes, these drivers are purposely copies since there
was overall consensus that having one giant panel driver to handle all
possible panels was getting far too confusing)

-Doug
