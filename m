Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8782362E69F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 22:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240702AbiKQVPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 16:15:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240228AbiKQVPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 16:15:00 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4EC64542
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 13:14:59 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id x102so4503818ede.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 13:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aF8JxdLtTASZYbRwTOvQQ3h3yTGLTSFoOZwDuKEGvsc=;
        b=k5bfU/FU++6BmZmHkQMUXu5Kot7Hl/rDFqOCHLY8IxEm+9CPNDP2+ANk117ugKxB4H
         3nEelaQHz+nLFpc/riAPNIIUpsBDZe7HcGoGlo9e9MTTns9wkMypUwtV6Z8+QxPJgQJk
         0HD3LhpA18BdKR6yhgAzC6vL8sTT3J9unWOo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aF8JxdLtTASZYbRwTOvQQ3h3yTGLTSFoOZwDuKEGvsc=;
        b=2Yz0xh/bIIdTyOLS9o4EShIC3GcFCwvTKLnnzM/Eg293gsg/gOaGb9Cz+1TiN5TjEc
         ARTXQNr/y4XAiptxCaqMTnC06/wBNkSVlkR9NUW5lPsfcITpNKNBkYMRiETzuGzMIR9+
         KCuoZkAFjxcYtSxU9mozly/lOHv3IxsEvg1KMRiGmoq72AGFVKkvufEVwDyScvdNQOAc
         goQasSrzdD+EtAu2Wo7jHMzFWqgSJctWCsnTyRywv/Hb1hIVSvpCwiN+rizdxuQnbuap
         PKmKTgtN0LqtiK7fN2bLeXbCza3qz97DnFgBVlswVgdO7L0rqxyCtac5GSGUVITAdGvo
         4l6A==
X-Gm-Message-State: ANoB5plQq+Nj7PmFv2hgy36AFM4dwnTzVSRUC1B2LVBi5D+vFQx3JwbH
        bdLuvvYRDhPrtt2L9e4ldp3qzaU8PUhHjA5l
X-Google-Smtp-Source: AA0mqf7eRiEerq/BR007Xo6Ad1TvlS7zQpSuGABCyYqI7lJtsiLubdrQ3lrajYc62HIohdRhLrLT3g==
X-Received: by 2002:aa7:d2c6:0:b0:468:86cf:1da6 with SMTP id k6-20020aa7d2c6000000b0046886cf1da6mr3794651edr.427.1668719697699;
        Thu, 17 Nov 2022 13:14:57 -0800 (PST)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id b14-20020a17090636ce00b007a8de84ce36sm819159ejc.206.2022.11.17.13.14.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 13:14:56 -0800 (PST)
Received: by mail-wr1-f43.google.com with SMTP id a14so5971700wru.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 13:14:56 -0800 (PST)
X-Received: by 2002:adf:d085:0:b0:241:b3d6:d6a0 with SMTP id
 y5-20020adfd085000000b00241b3d6d6a0mr2618473wrh.617.1668719696222; Thu, 17
 Nov 2022 13:14:56 -0800 (PST)
MIME-Version: 1.0
References: <20221117133655.1.I51639dc112bbbe27259df6bdad56dbabd655d91a@changeid>
 <20221117133655.2.Iebd9f79aba0a62015fd2383fe6986c2d6fe12cfd@changeid>
In-Reply-To: <20221117133655.2.Iebd9f79aba0a62015fd2383fe6986c2d6fe12cfd@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 17 Nov 2022 13:14:44 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XzzS-kygLun7u7XMDVqLdtBtxfhdHP0YFQo4TxCTPkSA@mail.gmail.com>
Message-ID: <CAD=FV=XzzS-kygLun7u7XMDVqLdtBtxfhdHP0YFQo4TxCTPkSA@mail.gmail.com>
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

On Thu, Nov 17, 2022 at 12:39 PM Drew Davenport <ddavenport@chromium.org> wrote:
>
> ktime_get_boottime continues while the device is suspended. This change
> ensures that the resume path will not be delayed if the power off delay
> has already been met while the device is suspended
>
> Signed-off-by: Drew Davenport <ddavenport@chromium.org>
> ---
>
>  drivers/gpu/drm/panel/panel-samsung-atna33xc20.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

You could have carried over from v1 [1]:

...which I guess also means that technically this series should have
been marked v2, but not a huge deal.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

[1] https://lore.kernel.org/r/20221110145102.1.I51639dc112bbbe27259df6bdad56dbabd655d91a@changeid
