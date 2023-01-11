Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABAC6650C9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 01:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234570AbjAKA6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 19:58:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232858AbjAKA6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 19:58:13 -0500
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20D950141
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 16:58:09 -0800 (PST)
Received: by mail-vk1-xa35.google.com with SMTP id z190so6500339vka.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 16:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w/qEOo5OjlMEeYZ96DtrLnhe1l/LTkC2EmBwM2R6NoU=;
        b=gWXF3XFSi77LlxoAifSeJIlQI/otUXaiKOn8F+MEloQOBblQOsl6UzQncoIHupQlt8
         ZDDhJB3W+HWLHHqRMlCrjYW1zaKLnfJov0tKHmRzgp3/L6WYLwmlbzkJDk/NaccrTmTU
         YeCmGHP1Q9SDZXwd6f/6jt1T2axqtByAUYftw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w/qEOo5OjlMEeYZ96DtrLnhe1l/LTkC2EmBwM2R6NoU=;
        b=v3MsxqXy9nsCtVzSy0wMOV1ga1xNX3uyS5GDAQdnOhUmNi46Jh8UR+rbEtLWM6S6lm
         iUnazZ/f+VZGBtzPJ7OjAeE5+EmkZSb3nfvDy/i7d4JJZxM8+NWRrvd8EQmo7O1iRLH7
         y7Mx/cdpilen+6Oahd60iC8/OIcw1jI+kJLFUAQfKH2f186MsB0JqQpAiXEUyMRrWa8Z
         f1AGSyoTfSt47J3z2tsHRs10TTkP0FXLjKmLTF98Aqm4Z3Il1QB2V/uG3Wl00WwPS+Vq
         axu0o3hS6YPM394/j1SpjcYVFIVEAVgi0cizU3mXaWgpJqLZS3zXIxmiShN84c+DdZFU
         uk4g==
X-Gm-Message-State: AFqh2kqch5Jm8/ywIfeweMG0YCShNoqz281HAGQZahYpYvQGAjL6fiHO
        zxfo+orWzbOjtLq57BJEhq2qYaizBvC1lSfu
X-Google-Smtp-Source: AMrXdXs5dYhY/nEZ4Pes5Dt0MasrnCqHwVaoYNyzg4Vos9FvvESrrJy6FLvHfc5T1vUOf/xcF4TWyQ==
X-Received: by 2002:a1f:de87:0:b0:3d5:7838:1f30 with SMTP id v129-20020a1fde87000000b003d578381f30mr24834540vkg.14.1673398688689;
        Tue, 10 Jan 2023 16:58:08 -0800 (PST)
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com. [209.85.221.169])
        by smtp.gmail.com with ESMTPSA id b126-20020a1fb284000000b003d53be21b4esm1578300vkf.38.2023.01.10.16.58.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 16:58:07 -0800 (PST)
Received: by mail-vk1-f169.google.com with SMTP id l3so3400036vkk.11
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 16:58:07 -0800 (PST)
X-Received: by 2002:a1f:430d:0:b0:3d5:bc7d:cacc with SMTP id
 q13-20020a1f430d000000b003d5bc7dcaccmr4785521vka.19.1673398687207; Tue, 10
 Jan 2023 16:58:07 -0800 (PST)
MIME-Version: 1.0
References: <20221231142721.338643-1-abel.vesa@linaro.org>
In-Reply-To: <20221231142721.338643-1-abel.vesa@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 10 Jan 2023 16:57:55 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Xkz4CjF9VpC=H=wOuLNwoDfD1VXLQW2kd-hMb6QV8RcA@mail.gmail.com>
Message-ID: <CAD=FV=Xkz4CjF9VpC=H=wOuLNwoDfD1VXLQW2kd-hMb6QV8RcA@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/panel-edp: fix name for IVO product id 854b
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steev Klimaszewski <steev@kali.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
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

On Sat, Dec 31, 2022 at 6:27 AM Abel Vesa <abel.vesa@linaro.org> wrote:
>
> The actual name is R133NW4K-R0.
>
> Fixes: 0f9fa5f58c784 ("drm/panel-edp: add IVO M133NW4J-R3 panel entry")

-:8: WARNING:BAD_FIXES_TAG: Please use correct Fixes: style 'Fixes:
<12 chars of sha1> ("<title line>")' - ie: 'Fixes: 0f9fa5f58c78
("drm/panel-edp: add IVO M133NW4J-R3 panel entry")'
#8:
Fixes: 0f9fa5f58c784 ("drm/panel-edp: add IVO M133NW4J-R3 panel entry")

Essentially you have one too many hex digits. I'll fix it for you this
time, but please remember for the future.


> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>
> Assuming the information from here is correct:
> https://raw.githubusercontent.com/linuxhw/EDID/master/DigitalDisplay.md

This is nifty--I wasn't aware of this database.


>  drivers/gpu/drm/panel/panel-edp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Fixes: 0f9fa5f58c78 ("drm/panel-edp: add IVO M133NW4J-R3 panel entry")

Pushed to drm-misc-next. I didn't bother doing "drm-misc-fixes"
because it didn't seem urgent and it would have caused a merge
conflict with the next patch.

9cce08cadc6c drm/panel-edp: fix name for IVO product id 854b


-Doug
