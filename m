Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B77B15E7D29
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 16:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbiIWOdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 10:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232416AbiIWOdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 10:33:45 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3837140190
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 07:33:43 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id b35so560845edf.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 07:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=5YJNawVCB64KpIAstvsKw73aAH2yj+Relp5ZFDa3MaI=;
        b=JJbRfx9cLZf7rfabp1oQDbdQ5l8dhYb9U34ueRVV9VAbDSSqorTUwrEx5FVDjKYjLR
         8bHiK+VB0iExV4IvICu/qPuW+1QbSMAJHdJW5VY8lt6zEZET+YXzJobrV4G5o1xnTBbU
         5ZVuqhXzXm59CxvMlFGNyhjAq0k4bwsIxbch0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=5YJNawVCB64KpIAstvsKw73aAH2yj+Relp5ZFDa3MaI=;
        b=bXIAlcWkmZgEeh/pRamtQFKXkGd14XS3RtLMdVn/E3RL4riH4ImtstairSjI+UpTWI
         jWj2eUEllJxvjQIEhELbHaPzkOcih6hfTkXb4S8ic33kiO1tb2egMIcVH/azLp4fnIcY
         AqQ9csptfOyEN0KdUSRyN7LIQGU1M6GahhwUrpy1F/Cb67t1d6iDwIrjW6KD92Y4Kklz
         vwjV+WQ2Oy5F4lN6HNxASNaJpaZN92+yTSmAyekiXUtBmfkaAYwAHJJAWCTc2GecwtLc
         EWKlXo4twsaJg66zb7gxzKvu9v4qkwvWN6Cu4Y/Vz2dLuxzJt8WkLQ7B42iI2t8C1BcA
         yotA==
X-Gm-Message-State: ACrzQf21ZU+xswvbBnUuLFoI2Mctw7nw3z9imQEXQ/vRJpNZOXxQw1KQ
        FLL0c6rdrwQ98RZdaes+wWJ3i/34Vd7I6OGv
X-Google-Smtp-Source: AMsMyM4WU94siZS5kthaZ0tcVBQfztXsZUol3BrXzptXfbQgh69P/61e1VzDufCNM+Q8B/4u1aEVhQ==
X-Received: by 2002:a05:6402:1f0e:b0:453:a419:b3a0 with SMTP id b14-20020a0564021f0e00b00453a419b3a0mr8635255edb.124.1663943622116;
        Fri, 23 Sep 2022 07:33:42 -0700 (PDT)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id b2-20020a1709063ca200b00780a26edfcesm4109453ejh.60.2022.09.23.07.33.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 07:33:41 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id e18so348500wmq.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 07:33:41 -0700 (PDT)
X-Received: by 2002:a05:600c:500d:b0:3b5:234:d7e9 with SMTP id
 n13-20020a05600c500d00b003b50234d7e9mr5982543wmr.57.1663943621242; Fri, 23
 Sep 2022 07:33:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220923054614.302440-1-sean.hong@quanta.corp-partner.google.com>
In-Reply-To: <20220923054614.302440-1-sean.hong@quanta.corp-partner.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 23 Sep 2022 07:33:29 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xje=_kFShMCZ_WbzLBnkehvOp3DQ5p_RsdAPi+SSvAnA@mail.gmail.com>
Message-ID: <CAD=FV=Xje=_kFShMCZ_WbzLBnkehvOp3DQ5p_RsdAPi+SSvAnA@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-edp: Add BOE NT116WHM-N21
To:     Sean Hong <sean.hong@quanta.corp-partner.google.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Thu, Sep 22, 2022 at 10:46 PM Sean Hong
<sean.hong@quanta.corp-partner.google.com> wrote:
>
> Add support for the BOE - NT116WHM-N21 (HW: V8.2) panel.
>
> Signed-off-by: Sean Hong <sean.hong@quanta.corp-partner.google.com>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 1 +
>  1 file changed, 1 insertion(+)

As with previous trivial patches that just add an entry to this
structure, there's no reason to wait before applying. Pushed to
drm-misc-next:

9d6b59478cc5 drm/panel-edp: Add BOE NT116WHM-N21
