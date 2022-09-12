Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4BD5B5C55
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 16:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbiILOh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 10:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbiILOhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 10:37:53 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B192FFDF
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 07:37:52 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id u28so3189635qku.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 07:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Gma6d5BlyXEKnjQsnnu5KmSUsV/V+0uYpySeCVOzahM=;
        b=mb1F1tRoLU+2X2uBFEA5tHgs0j28pnRartJzBt0Ow8kcF8BxzHePc/0cnIxzE6PYv1
         RDNTI7aA4u0OaXC1ns9sywci1oQ3dibmRtBsRyeAGvxUzduBPeKzXsmZtCbH+MnitP4u
         SA7NHFNHWRU6quzuVh+Fc2m2BmYzPa9EhiVNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Gma6d5BlyXEKnjQsnnu5KmSUsV/V+0uYpySeCVOzahM=;
        b=b15QFK3eJ+OfNSKuPsqh7WanX0KbM+vRUAGYvmGwMH5jsQqOXWG2GnJ9mS9ilR+nmV
         R7rKaLLDfNLpYQ5mS1YigqPEr87IEnK9tVdkLsNmz07qrJ3gY8l/9ii/M9HDI1Jzebzz
         sSD2UeJA8+7ZlWvOCAw9jxak0H/IrvHV+NnQ54jfc7Kgnd93xUr+VxUbljxIpNnd+SMs
         IlQ7OXEaax9ulmGqy6s12VE3T7RenHmqlFK9vFoaaBeb9ZNc8QNO19tsDUix4rD+m5gr
         upvMWcBAl93QVB9sD3Vp2ySqXQT4ax7rxivAV0wzn4LwTr5JVFqU27z7tNQaMqS1diHL
         fJCg==
X-Gm-Message-State: ACgBeo07ir4Nl6ureOxNOx5fxKdqEXG6i0o9038WkVfJEgY4+Re0DPto
        L5WFPjIB2zKZsCQF8SmF2xxDZaAPzYIYwXg8
X-Google-Smtp-Source: AA6agR4jkYNn3PVTnWahKf+uHliycWSbaq9SowgWaAlYrlSeNvk869pS6EmTGvekeXd67urAJdgG4g==
X-Received: by 2002:a05:620a:a98:b0:6ce:1b18:c983 with SMTP id v24-20020a05620a0a9800b006ce1b18c983mr4922016qkg.108.1662993470541;
        Mon, 12 Sep 2022 07:37:50 -0700 (PDT)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com. [209.85.222.177])
        by smtp.gmail.com with ESMTPSA id br22-20020a05622a1e1600b0035bb6c3811asm1720325qtb.53.2022.09.12.07.37.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Sep 2022 07:37:50 -0700 (PDT)
Received: by mail-qk1-f177.google.com with SMTP id s9so3877657qkg.4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 07:37:50 -0700 (PDT)
X-Received: by 2002:a05:6638:1c17:b0:35a:151b:c726 with SMTP id
 ca23-20020a0566381c1700b0035a151bc726mr6077471jab.66.1662993004103; Mon, 12
 Sep 2022 07:30:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220912113856.817188-1-robert.foss@linaro.org> <20220912113856.817188-3-robert.foss@linaro.org>
In-Reply-To: <20220912113856.817188-3-robert.foss@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 12 Sep 2022 15:29:52 +0100
X-Gmail-Original-Message-ID: <CAD=FV=WrH2AAFxV72FZqk-=xU8jzCn6KtcbZRYJAaCwhmvSWmg@mail.gmail.com>
Message-ID: <CAD=FV=WrH2AAFxV72FZqk-=xU8jzCn6KtcbZRYJAaCwhmvSWmg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] Revert "drm/bridge: ti-sn65dsi86: Implement bridge
 connector operations for DP"
To:     Robert Foss <robert.foss@linaro.org>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Robert,

On Mon, Sep 12, 2022 at 12:43 PM Robert Foss <robert.foss@linaro.org> wrote:
>
> As reported by Laurent in response to this commit[1], this functionality should
> not be implemented using the devicetree, because of this let's revert this series
> for now.
>
> This reverts commit c312b0df3b13e4c533743bb2c37fd1bc237368e5.
>
> [1] https://lore.kernel.org/all/20220902153906.31000-2-macroalpha82@gmail.com/
>
> Signed-off-by: Robert Foss <robert.foss@linaro.org>
> ---
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 28 ---------------------------
>  1 file changed, 28 deletions(-)

Any chance you got confused and reverted the wrong patch? This
ti-sn65dsi86 patch doesn't seem relevant to the problems talked about
in the commit or the cover letter. Maybe I'm missing something?

-Doug
